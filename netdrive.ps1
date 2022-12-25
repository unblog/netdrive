$LogFile = "netdrive.log"
Get-Date -Format "MM/dd/yyyy HH:mm" | Out-File $LogFile -Force
Write-Host "`nEnter your network credentials to map network drives or cancel mapping" -ForegroundColor Yellow
$Cred = Get-Credential -Message "Please enter your credentials" -UserName "domain\username"
if ($Cred) {
    $sharePath = "\\server\share"
    $mapDrive = "Z"
    Write-Host "`nMapping network share.." -ForegroundColor White
    Add-Content $LogFile -Value "Mapping drive $mapDrive $sharePath"
    New-PSDrive -Name $mapDrive -Root $sharePath -Persist -Scope Global -PSProvider "FileSystem" -Credential $Cred | Out-File $LogFile -Append
} else {
    Add-Content $LogFile -Value "No credentials were given, network mapping canceled."
}

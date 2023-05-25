echo "inside!!!!"
param(
    [Parameter(Mandatory=$true)]$Workspace,
    [Parameter(Mandatory=$true)]$RulesFile
)

#Adding AzSentinel module
Install-Module AzSentinel -Scope CurrentUser -Force -AllowClobber
Import-Module AzSentinel

#Name of the Azure DevOps artifact
$artifactName = "RulesFile"

#Build the full path for the analytics rule file
#$artifactPath = Join-Path $env:Pipeline_Workspace $artifactName 

$rulesFilePath = "/home/zaied/myagent/_work/3/s/AnalyticsRules/analytics-rules.json" 
# Join-Path $artifactPath $RulesFile

try {
    Import-AzSentinelAlertRule -WorkspaceName $Workspace -SettingsFile $rulesFilePath
}
catch {
    $ErrorMessage = $_.Exception.Message
    Write-Error "Rule import failed with message: $ErrorMessage" 
}

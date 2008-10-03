From: Petr Baudis <pasky@suse.cz>
Subject: [FYI][PATCH] Customizing the WinGit installer
Date: Fri, 3 Oct 2008 14:27:27 +0200
Message-ID: <20081003122727.GE10360@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Fri Oct 03 14:28:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kljlw-0001CV-5i
	for gcvg-git-2@gmane.org; Fri, 03 Oct 2008 14:28:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753092AbYJCM1a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2008 08:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752700AbYJCM13
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Oct 2008 08:27:29 -0400
Received: from w241.dkm.cz ([62.24.88.241]:49644 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751793AbYJCM13 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2008 08:27:29 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 1C5A53939B4B; Fri,  3 Oct 2008 14:27:27 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97420>

This patch is intended just as a FYI example on customizing the WinGit
installer for e.g. corporate deployment or similar needs, as a starting
point in case anyone needs to do that.

This patch removes some steps redundant for our usage scenario (choose
of the $PATH mode, showing release notes), slightly customizes the
default Git configuration and changes the quickstart icon from Git Bash
to Git GUI (this one might be worth considering for upstream too,
especially after stock git-gui gains the remotes management support).

Signed-off-by: Petr Baudis <petr.baudis@novartis.com>

---

diff --git a/etc/gitconfig b/etc/gitconfig
index 251088c..d0e8e53 100644
--- a/etc/gitconfig
+++ b/etc/gitconfig
@@ -5,3 +5,12 @@
 	diff = auto
 [pack]
 	packSizeLimit = 2g
+[locator "Server"]
+	template = M:/public_git/%s
+[locator "Library"]
+	template = git://lib.example.com/%s
+[gui]
+	remotelocator = Server
+	pulllocator = Library
+	pushlocator = Server
+	autoexplore = true
diff --git a/share/WinGit/install.iss b/share/WinGit/install.iss
index 0f0514d..05fdae6 100644
--- a/share/WinGit/install.iss
+++ b/share/WinGit/install.iss
@@ -20,7 +20,7 @@ ChangesEnvironment=yes
 DefaultDirName={pf}\{#emit APP_NAME}
 DefaultGroupName={#emit APP_NAME}
 DisableReadyPage=yes
-InfoBeforeFile=gpl-2.0.rtf
+;InfoBeforeFile=gpl-2.0.rtf
 PrivilegesRequired=none
 UninstallDisplayIcon=etc\git.ico
 
@@ -36,13 +36,13 @@ Name: guiextension; Description: "Add ""Git &GUI Here"""; GroupDescription: "Win
 
 [Files]
 Source: "*"; DestDir: "{app}"; Excludes: "\*.bmp, gpl-2.0.rtf, \install.*, \tmp.*, \bin\*install*"; Flags: recursesubdirs
-Source: ReleaseNotes.rtf; DestDir: "{app}"; Flags: isreadme
+;Source: ReleaseNotes.rtf; DestDir: "{app}"; Flags: isreadme
 
 [Icons]
 Name: "{group}\Git GUI"; Filename: "{app}\bin\wish.exe"; Parameters: """{app}\bin\git-gui"""; WorkingDir: "%USERPROFILE%"; IconFilename: "{app}\etc\git.ico"
 Name: "{group}\Git Bash"; Filename: "{syswow64}\cmd.exe"; Parameters: "/c """"{app}\bin\sh.exe"" --login -i"""; WorkingDir: "%USERPROFILE%"; IconFilename: "{app}\etc\git.ico"
 Name: "{group}\Uninstall Git"; Filename: "{uninstallexe}"
-Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\Git Bash"; Filename: "{syswow64}\cmd.exe"; Parameters: "/c """"{app}\bin\sh.exe"" --login -i"""; WorkingDir: "%USERPROFILE%"; IconFilename: "{app}\etc\git.ico"; Tasks: quicklaunchicon
+Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\Git GUI"; Filename: "{app}\bin\wish.exe"; Parameters: """{app}\bin\git-gui"""; WorkingDir: "%USERPROFILE%"; IconFilename: "{app}\etc\git.ico"; Tasks: quicklaunchicon
 Name: "{code:GetShellFolder|desktop}\Git Bash"; Filename: "{syswow64}\cmd.exe"; Parameters: "/c """"{app}\bin\sh.exe"" --login -i"""; WorkingDir: "%USERPROFILE%"; IconFilename: "{app}\etc\git.ico"; Tasks: desktopicon
 
 [Messages]
@@ -171,8 +171,7 @@ begin
 end;
 
 var
-    EnvPage,PuTTYPage:TWizardPage;
-    RdbGitBash,RdbGitCmd,RdbGitCmdTools:TRadioButton;
+    PuTTYPage:TWizardPage;
     RdbOpenSSH,RdbPLink:TRadioButton;
     EdtPLink:TEdit;
 
@@ -197,105 +196,12 @@ end;
 
 procedure InitializeWizard;
 var
-    LblGitBash,LblGitCmd,LblGitCmdTools,LblGitCmdToolsWarn:TLabel;
     LblOpenSSH,LblPLink:TLabel;
     BtnPLink:TButton;
 begin
-    // Create a custom page for modifying the environment.
-    EnvPage:=CreateCustomPage(
-        wpSelectTasks,
-        'Adjusting your PATH environment',
-        'How would you like to use Git from the command line?'
-    );
-
-    // 1st choice
-    RdbGitBash:=TRadioButton.Create(EnvPage);
-    with RdbGitBash do begin
-      Parent:=EnvPage.Surface;
-      Caption:='Use Git Bash only';
-      Left:=ScaleX(4);
-      Top:=ScaleY(8);
-      Width:=ScaleX(129);
-      Height:=ScaleY(17);
-      Font.Style:=[fsBold];
-      TabOrder:=0;
-      Checked:=True;
-    end;
-    LblGitBash:=TLabel.Create(EnvPage);
-    with LblGitBash do begin
-        Parent:=EnvPage.Surface;
-        Caption:=
-            'This is the most conservative choice if you are concerned about the stability' + #13 +
-            'of your system. Your PATH will not be modified.';
-        Left:=ScaleX(28);
-        Top:=ScaleY(32);
-        Width:=ScaleX(405);
-        Height:=ScaleY(26);
-    end;
-
-    // 2nd choice
-    RdbGitCmd:=TRadioButton.Create(EnvPage);
-    with RdbGitCmd do begin
-      Parent:=EnvPage.Surface;
-      Caption:='Run Git from the Windows Command Prompt';
-      Left:=ScaleX(4);
-      Top:=ScaleY(76);
-      Width:=ScaleX(281);
-      Height:=ScaleY(17);
-      Font.Style:=[fsBold];
-      TabOrder:=1;
-    end;
-    LblGitCmd:=TLabel.Create(EnvPage);
-    with LblGitCmd do begin
-        Parent:=EnvPage.Surface;
-        Caption:=
-            'This option is considered safe and no conflicts with other tools are known.' + #13 +
-            'Only Git will be added to your PATH. Use this option if you want to use Git' + #13 +
-            'from a Cygwin Prompt (make sure to not have Cygwin''s Git installed).';
-        Left:=ScaleX(28);
-        Top:=ScaleY(100);
-        Width:=ScaleX(405);
-        Height:=ScaleY(39);
-    end;
-
-    // 3rd choice
-    RdbGitCmdTools:=TRadioButton.Create(EnvPage);
-    with RdbGitCmdTools do begin
-      Parent:=EnvPage.Surface;
-      Caption:='Run Git and included Unix tools from the Windows Command Prompt';
-      Left:=ScaleX(4);
-      Top:=ScaleY(152);
-      Width:=ScaleX(405);
-      Height:=ScaleY(17);
-      Font.Style:=[fsBold];
-      TabOrder:=2;
-    end;
-    LblGitCmdTools:=TLabel.Create(EnvPage);
-    with LblGitCmdTools do begin
-        Parent:=EnvPage.Surface;
-        Caption:='Both Git and its accompanying Unix tools will be added to your PATH.';
-        Left:=ScaleX(28);
-        Top:=ScaleY(176);
-        Width:=ScaleX(405);
-        Height:=ScaleY(13);
-    end;
-    LblGitCmdToolsWarn:=TLabel.Create(EnvPage);
-    with LblGitCmdToolsWarn do begin
-        Parent:=EnvPage.Surface;
-        Caption:=
-            'Warning: This will override Windows tools like find.exe and' + #13 +
-            'sort.exe. Select this option only if you understand the implications.';
-        Left:=ScaleX(28);
-        Top:=ScaleY(192);
-        Width:=ScaleX(376);
-        Height:=ScaleY(26);
-        Font.Color:=255;
-        Font.Style:=[fsBold];
-    end;
-
     // Create a custom page for using PuTTY's plink instead of ssh.
     PuTTYPage:=CreateCustomPage(
-        EnvPage.ID,
+        wpSelectTasks,
         'Choosing the SSH executable',
         'Which Secure Shell client program would you like Git to use?'
     );
@@ -537,45 +443,6 @@ begin
         end;
     end;
 
-    // Modify the PATH variable as requested by the user.
-    if RdbGitCmd.Checked or RdbGitCmdTools.Checked then begin
-        i:=GetArrayLength(EnvPath);
-        SetArrayLength(EnvPath,i+1);
-
-        // List \cmd before \bin so \cmd has higher priority and programs in
-        // there will be called in favor of those in \bin.
-        EnvPath[i]:=ExpandConstant('{app}\cmd');
-
-        if RdbGitCmdTools.Checked then begin
-            SetArrayLength(EnvPath,i+2);
-            EnvPath[i+1]:=ExpandConstant('{app}\bin');
-
-            // Set HOME for the Windows Command Prompt, but only if it has not been set manually before.
-            EnvHome:=GetEnvStrings('HOME',IsAdminLoggedOn);
-            i:=GetArrayLength(EnvHome);
-            if (i=0) or ((i=1) and (Length(EnvHome[0])=0)) then begin
-                SetArrayLength(EnvHome,1);
-                EnvHome[0]:=ExpandConstant('{%USERPROFILE}');
-                if not SetEnvStrings('HOME',IsAdminLoggedOn,True,EnvHome) then begin
-                    Msg:='Line {#emit __LINE__}: Unable to set the HOME environment variable.';
-                    MsgBox(Msg,mbError,MB_OK);
-                    Log(Msg);
-                    // This is not a critical error, the user can probably fix it manually,
-                    // so we continue.
-                end;
-
-                // Mark that we have changed HOME.
-                if not SetIniString('Environment','HOME',EnvHome[0],FileName) then begin
-                    Msg:='Line {#emit __LINE__}: Unable to write to file "'+FileName+'".';
-                    MsgBox(Msg,mbError,MB_OK);
-                    Log(Msg);
-                    // This is not a critical error, though uninstall / reinstall will probably not run cleanly,
-                    // so we continue.
-                end;
-            end;
-        end;
-    end;
-
     // Set the current user's PATH directories.
     if not SetEnvStrings('PATH',IsAdminLoggedOn,True,EnvPath) then begin
         Msg:='Line {#emit __LINE__}: Unable to set the PATH environment variable.';

From: Michael Lukashov <michael.lukashov@gmail.com>
Subject: [msysGit] [PATCH] Installer: Create builtins as symbolic links on Vista
Date: Fri, 15 Jan 2010 22:06:59 +0000
Message-ID: <1263593219-6032-1-git-send-email-michael.lukashov@gmail.com>
Cc: Michael Lukashov <michael.lukashov@gmail.com>, git@vger.kernel.org,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: msysgit <msysgit@googlegroups.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 23:07:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVuKL-00043n-3s
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 23:07:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758143Ab0AOWH2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 17:07:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758122Ab0AOWH2
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 17:07:28 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:65286 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757851Ab0AOWH1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 17:07:27 -0500
Received: by bwz27 with SMTP id 27so984232bwz.21
        for <git@vger.kernel.org>; Fri, 15 Jan 2010 14:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=FOYvNeWmU4EnOvCFJifZbjDchuHaavILjL/oHkz52d0=;
        b=Mizqaz6oOiH6z1Qyh2XgtGTTHpI2btUNgxrzqAogEnBWeuLqbmsY36jgTqOp7/a57n
         bQ4pZ5zUFoilM5WldgY9ykPTs0rb8fcmPVzCNdl6Gw69NwZvwF96MHJVhswXibhJ6D6m
         SRmX6bPvw25f+uLrekhmPDhxnjjy3uj1iwtbw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=ryF28OC2mxq9bAS49i61Aem6WaP1E3r+8IlTEjhyKHAz/0p/7uax/96dJkDAeGsEsS
         JEFACdQf23INk4+FOFAYmiD0uecYpiWqykw2pLVAXmI7stafLMKQV01B7qNBkYSgqZ6d
         UZBIhcnRohoXG2dMLdxGDZFm5q4HJr+24S2Jo=
Received: by 10.204.154.219 with SMTP id p27mr1657812bkw.115.1263593245163;
        Fri, 15 Jan 2010 14:07:25 -0800 (PST)
Received: from localhost (nat-nz.wwwcom.ru [195.62.62.242])
        by mx.google.com with ESMTPS id 16sm1125307bwz.11.2010.01.15.14.07.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 Jan 2010 14:07:24 -0800 (PST)
X-Mailer: git-send-email 1.6.6.1536.g1ac8c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137138>

When create builtins, first try to use CreateSymbolicLinkW function.
If symbolic link creating fails, hard links are created.

Tested under WinXP (both FAT32 and NTFS), Vista and Win7.

This patch applies on top of ss/installer-improvements branch.

Signed-off-by: Michael Lukashov <michael.lukashov@gmail.com>
---
 share/WinGit/install.iss |   30 ++++++++++++++++++++++++------
 1 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/share/WinGit/install.iss b/share/WinGit/install.iss
index 91eac9c..f64f754 100644
--- a/share/WinGit/install.iss
+++ b/share/WinGit/install.iss
@@ -83,8 +83,10 @@ Type: dirifempty; Name: {app}\home
 
 // Note: Since we are using the Unicode version of Inno Setup, "String" is a Unicode
 // string, and thus we need to call the "W" (Wide-String) Windows API variant.
+function CreateSymbolicLink(lpFileName,lpExistingFileName:String;lpSecurityAttributes:Integer):Boolean;
+external 'CreateSymbolicLinkW@Kernel32.dll stdcall setuponly delayload';
 function CreateHardLink(lpFileName,lpExistingFileName:String;lpSecurityAttributes:Integer):Boolean;
-external 'CreateHardLinkW@Kernel32.dll stdcall setuponly';
+external 'CreateHardLinkW@Kernel32.dll stdcall setuponly delayload';
 
 const
     // Git Path options.
@@ -474,7 +476,11 @@ var
     IsNTFS:Boolean;
     FindRec:TFindRec;
     RootKey:Integer;
+    Version:TWindowsVersion;
+    LinkCreated:Boolean;
 begin
+    GetWindowsVersionEx(Version);
+
     if CurStep<>ssPostInstall then begin
         Exit;
     end;
@@ -511,13 +517,25 @@ begin
             for i:=0 to Count do begin
                 FileName:=AppDir+'\'+BuiltIns[i];
 
-                // On non-NTFS partitions, create hard links.
-                if (FileExists(FileName) and (not DeleteFile(FileName))) or
-                   (not CreateHardLink(FileName,AppDir+'\bin\git.exe',0)) then begin
-                    Log('Line {#emit __LINE__}: Unable to create hard link "'+FileName+'", will try to copy files.');
-                    IsNTFS:=False;
+                // First check if file exists.
+                if (FileExists(FileName) and (not DeleteFile(FileName))) then begin
+                    Log('Line {#emit __LINE__}: Unable to delete file "'+FileName);
                     Break;
                 end;
+                // Try to create symbolic link
+                if Version.Major>=6 then
+                try
+                  LinkCreated:=CreateSymbolicLink(FileName,AppDir+'\bin\git.exe',0);
+                except
+                  LinkCreated:=False;
+                end;
+                // Try to create hard link
+                if (not LinkCreated) and
+                   (not CreateHardLink(FileName,AppDir+'\bin\git.exe',0)) then begin
+                  Log('Line {#emit __LINE__}: Unable to create hard link "'+FileName+'", will try to copy files.');
+                  IsNTFS:=False;
+                  Break;
+                end;
             end;
 
             Log('Line {#emit __LINE__}: Successfully created built-in aliases as hard links.');
-- 
1.6.6.1536.g1ac8c

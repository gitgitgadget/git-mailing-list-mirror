From: Andrei Warkentin <andreiw@vmware.com>
Subject: [PATCH] Git-p4: Add "git p4 change" command.
Date: Mon, 17 Oct 2011 18:18:57 -0400
Message-ID: <1318889937-17693-1-git-send-email-andreiw@vmware.com>
Cc: Andrei Warkentin <andreiw@vmware.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Oct 18 00:19:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFvWS-00050F-EA
	for gcvg-git-2@lo.gmane.org; Tue, 18 Oct 2011 00:19:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755249Ab1JQWTA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Oct 2011 18:19:00 -0400
Received: from smtp-outbound-1.vmware.com ([65.115.85.69]:25729 "EHLO
	smtp-outbound-1.vmware.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754115Ab1JQWS7 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Oct 2011 18:18:59 -0400
Received: from mailhost3.vmware.com (mailhost3.vmware.com [10.16.27.45])
	by smtp-outbound-1.vmware.com (Postfix) with ESMTP id 7632739010;
	Mon, 17 Oct 2011 15:18:59 -0700 (PDT)
Received: from andreiw-eng-rhel5-64.eng.vmware.com (vmc-floorb-dhcp117-40.eng.vmware.com [10.17.117.40])
	by mailhost3.vmware.com (Postfix) with ESMTP id 1B8C7CD952;
	Mon, 17 Oct 2011 15:18:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183832>

Many users of p4/sd use changelists for review, regression
tests and batch builds.

"p4 change" is almost equivalent to "p4 submit", yet will
just create the changelist and not submit it.

Signed-off-by: Andrei Warkentin <andreiw@vmware.com>
---
 contrib/fast-import/git-p4 |   23 ++++++++++++++++++-----
 1 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 2f7b270..dd084b9 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -950,7 +950,10 @@ class P4Submit(Command, P4UserMap):
             if checkModTime and (os.stat(fileName).st_mtime <= mtime):
                 response = "x"
                 while response != "y" and response != "n":
-                    response = raw_input("Submit template unchanged. Submit anyway? [y]es, [n]o (skip this patch) ")
+                    if (self.cmdname == "change"):
+                        response = raw_input("Change template unchanged. Create changelist anyway? [y]es, [n]o (skip this patch) ")
+                    else:
+                        response = raw_input("Submit template unchanged. Submit anyway? [y]es, [n]o (skip this patch) ")
 
             if response == "y":
                 tmpFile = open(fileName, "rb")
@@ -959,7 +962,10 @@ class P4Submit(Command, P4UserMap):
                 submitTemplate = message[:message.index(separatorLine)]
                 if self.isWindows:
                     submitTemplate = submitTemplate.replace("\r\n", "\n")
-                p4_write_pipe("submit -i", submitTemplate)
+                if (self.cmdname == "change"):
+                    p4_write_pipe("change -i", submitTemplate)
+                else:
+                    p4_write_pipe("submit -i", submitTemplate)
 
                 if self.preserveUser:
                     if p4User:
@@ -981,9 +987,14 @@ class P4Submit(Command, P4UserMap):
             file = open(fileName, "w+")
             file.write(self.prepareLogMessage(template, logMessage))
             file.close()
-            print ("Perforce submit template written as %s. "
-                   + "Please review/edit and then use p4 submit -i < %s to submit directly!"
-                   % (fileName, fileName))
+            if (self.cmdname == "change"):
+                print ("Perforce change template written as %s. "
+                       + "Please review/edit and then use p4 change -i < %s to submit directly!"
+                       % (fileName, fileName))
+            else:
+                print ("Perforce submit template written as %s. "
+                       + "Please review/edit and then use p4 submit -i < %s to submit directly!"
+                       % (fileName, fileName))
 
     def run(self, args):
         if len(args) == 0:
@@ -2177,6 +2188,7 @@ commands = {
     "debug" : P4Debug,
     "submit" : P4Submit,
     "commit" : P4Submit,
+    "change" : P4Submit,
     "sync" : P4Sync,
     "rebase" : P4Rebase,
     "clone" : P4Clone,
@@ -2202,6 +2214,7 @@ def main():
         sys.exit(2)
 
     options = cmd.options
+    cmd.cmdname = cmdName
     cmd.gitdir = os.environ.get("GIT_DIR", None)
 
     args = sys.argv[2:]
-- 
1.7.4.1

From: Pal-Kristian Engstad <pal_engstad@naughtydog.com>
Subject: [PATCH 2/3] git-p4: improve submit dialogs
Date: Thu, 21 Jan 2010 18:05:04 -0800
Message-ID: <4B5907D0.9070608@naughtydog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Simon Hausmann <simon@lst.de>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 22 03:04:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NY8t9-0006Ar-C2
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 03:04:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755793Ab0AVCEh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 21:04:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755781Ab0AVCEh
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 21:04:37 -0500
Received: from ironport02a.scea.com ([160.33.44.43]:30996 "EHLO
	ironport02a.scea.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755630Ab0AVCEg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 21:04:36 -0500
X-IronPort-AV: E=Sophos;i="4.49,321,1262592000"; 
   d="scan'208";a="8055204"
Received: from inbetweener01.scea.com ([160.33.45.195])
  by ironport02a.scea.com with ESMTP; 21 Jan 2010 18:04:36 -0800
Received: from postal1-dog.naughtydog.com (intmail.naughtydog.com [10.15.0.14])
	by inbetweener01.scea.com (Postfix) with ESMTP id 6BF14F017A;
	Thu, 21 Jan 2010 18:04:36 -0800 (PST)
Received: from [127.0.0.1] ([150.0.6.116]) by postal1-dog.naughtydog.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 21 Jan 2010 18:05:05 -0800
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
X-OriginalArrivalTime: 22 Jan 2010 02:05:05.0114 (UTC) FILETIME=[508043A0:01CA9B07]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137717>

Improve the git-p4 submit process by adding additional submit options.

* The regular commit sequence now gives the options of:
  + [y] to submit the patch as is,
  + [c] to display the Perforce commit through "less",
  + [d] to display the output of "p4 diff -du" through "less",
  + [e] to edit the message before submitting,
  + [n] to skip the patch.

* Add a --no-prompt option to submit multiple check-ins without any
  prompts. This feature is useful for when many changes needs to be
  checked in. The git commit message is assumed as the Perforce
  submit message.

* Add an --edit option to preserve the previous submission process.

Signed-off-by: Pal-Kristian Engstad <pal_engstad@naughtydog.com>
---
 contrib/fast-import/git-p4 |   75 +++++++++++++++++++++++++++++++++++--------
 1 files changed, 61 insertions(+), 14 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index c65ef8a..ab538b3 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -545,6 +545,10 @@ class P4Submit(Command):
                 optparse.make_option("--origin", dest="origin"),
                 optparse.make_option("--no-detect", dest="detectRename", action="store_false",
                                      help="Disable git's rename detection, forcing \"p4 delete\" and \"p4 add\" instead of \"p4 integrate\" and \"p4 edit\""),
+                optparse.make_option("--no-prompt", dest="prompt", action="store_false",
+                                     help="Check in every git change into the perforce database without any prompts"),
+                optparse.make_option("--edit", dest="editCommit", action="store_true",
+                                     help="Edit every commit before submitting (old procedure)")
         ]
         self.description = "Submit changes from git to the perforce depot."
         self.usage += " [name of git branch to submit into perforce depot]"
@@ -552,6 +556,8 @@ class P4Submit(Command):
         self.origin = ""
         self.detectRename = True
         self.verbose = False
+        self.editCommit = False
+        self.prompt = True
         self.isWindows = (platform.system() == "Windows")
 
     def check(self):
@@ -657,19 +663,21 @@ class P4Submit(Command):
 
         if os.system(tryPatchCmd) != 0:
             print "Unfortunately applying the change failed!"
+            print "This may be because you need to rebase your commits to the latest P4 changes."
             print "What do you want to do?"
             response = "x"
-            while response != "s" and response != "a" and response != "w":
-                response = raw_input("[s]kip this patch / [a]pply the patch forcibly "
+            while response != "s" and response != "f" and response != "a" and response != "w":
+                response = raw_input("[a]bort / [s]kip this patch / apply the patch [f]orcibly "
                                      "and with .rej files / [w]rite the patch to a file (patch.txt) ")
-            if response == "s":
-                print "Skipping! Good luck with the next patches..."
+            if response == "s" or response == "a":
+                if response == "s":
+                    print "Skipping! Next set of patches might fail..."
                 for f in editedFiles:
                     p4_system("revert \"%s\"" % f);
                 for f in filesToAdd:
                     system("rm %s" %f)
-                return
-            elif response == "a":
+                return response == "a"
+            elif response == "f":
                 os.system(applyPatchCmd)
                 if len(filesToAdd) > 0:
                     print "You may also want to call p4 add on the following files:"
@@ -729,18 +737,28 @@ class P4Submit(Command):
                 newdiff = newdiff.replace("\n", "\r\n")
             tmpFile.write(submitTemplate + separatorLine + diff + newdiff)
             tmpFile.close()
-            mtime = os.stat(fileName).st_mtime
+
             if os.environ.has_key("P4EDITOR"):
                 editor = os.environ.get("P4EDITOR")
             else:
                 editor = read_pipe("git var GIT_EDITOR")
-            system(editor + " " + fileName)
 
-            response = "y"
-            if os.stat(fileName).st_mtime <= mtime:
+            if self.editCommit:
+                response = "e"
+            elif not self.prompt:
+                response = "y"
+            else:
                 response = "x"
-                while response != "y" and response != "n":
-                    response = raw_input("Submit template unchanged. Submit anyway? [y]es, [n]o (skip this patch) ")
+                print "--- Description --------------------------------------------------------------------"
+                print logMessage
+                print "------------------------------------------------------------------------------------"
+
+                while response != "y" and response != "n" and response != "e":
+                    response = raw_input("Submit: [y]es, see P4 [c]ommit, see [d]iff, [e]dit message first, or [n]o (skip this patch) ")
+                    if response == "d":
+                        system("less " + fileName)
+                    elif response == "c":
+                        print submitTemplate
 
             if response == "y":
                 tmpFile = open(fileName, "rb")
@@ -750,14 +768,39 @@ class P4Submit(Command):
                 if self.isWindows:
                     submitTemplate = submitTemplate.replace("\r\n", "\n")
                 p4_write_pipe("submit -i", submitTemplate)
-            else:
+            elif response == "n":
                 for f in editedFiles:
                     p4_system("revert \"%s\"" % f);
                 for f in filesToAdd:
                     p4_system("revert \"%s\"" % f);
                     system("rm %s" %f)
+            elif self.editCommit or response == "e":
+                mtime = os.stat(fileName).st_mtime
+                system(editor + " " + fileName)
+
+                response = "y"
+                if os.stat(fileName).st_mtime <= mtime:
+                    response = "x"
+                    while response != "y" and response != "n":
+                        response = raw_input("Submit template unchanged. Submit anyway? [y]es, [n]o (skip this patch) ")
+
+                if response == "y":
+                    tmpFile = open(fileName, "rb")
+                    message = tmpFile.read()
+                    tmpFile.close()
+                    submitTemplate = message[:message.index(separatorLine)]
+                    if self.isWindows:
+                        submitTemplate = submitTemplate.replace("\r\n", "\n")
+                    p4_write_pipe("submit -i", submitTemplate)
+                else:
+                    for f in editedFiles:
+                        p4_system("revert \"%s\"" % f);
+                    for f in filesToAdd:
+                        p4_system("revert \"%s\"" % f);
+                        system("rm %s" %f)
 
             os.remove(fileName)
+            return True
         else:
             fileName = "submit.txt"
             file = open(fileName, "w+")
@@ -766,6 +809,7 @@ class P4Submit(Command):
             print ("Perforce submit template written as %s. "
                    + "Please review/edit and then use p4 submit -i < %s to submit directly!"
                    % (fileName, fileName))
+            return False
 
     def run(self, args):
         if len(args) == 0:
@@ -813,10 +857,13 @@ class P4Submit(Command):
             commits.append(line.strip())
         commits.reverse()
 
+        startCommits = len(commits)
+
         while len(commits) > 0:
             commit = commits[0]
             commits = commits[1:]
-            self.applyCommit(commit)
+            if not self.applyCommit(commit):
+                break
             if not self.interactive:
                 break
 
-- 
1.6.5.2.6.gc3c1e.dirty

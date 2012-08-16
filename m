From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 08/12] git p4: rearrange submit template construction
Date: Thu, 16 Aug 2012 19:35:10 -0400
Message-ID: <1345160114-27654-9-git-send-email-pw@padd.com>
References: <1345160114-27654-1-git-send-email-pw@padd.com>
Cc: Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 17 01:38:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T29dd-00058k-Jl
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 01:38:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753717Ab2HPXh6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Aug 2012 19:37:58 -0400
Received: from honk.padd.com ([74.3.171.149]:47775 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752540Ab2HPXh6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2012 19:37:58 -0400
Received: from arf.padd.com (unknown [50.55.149.165])
	by honk.padd.com (Postfix) with ESMTPSA id 8EF5ED27;
	Thu, 16 Aug 2012 16:37:57 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 5808B313FD; Thu, 16 Aug 2012 19:37:55 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.rc2.111.g96f7c73
In-Reply-To: <1345160114-27654-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Put all items in order as they appear, and add comments.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 git-p4.py | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 13c62c6..0e874cb 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1202,6 +1202,9 @@ class P4Submit(Command, P4UserMap):
                 p4_revert(f)
             return False
 
+        #
+        # Apply the patch for real, and do add/delete/+x handling.
+        #
         system(applyPatchCmd)
 
         for f in filesToAdd:
@@ -1215,6 +1218,10 @@ class P4Submit(Command, P4UserMap):
             mode = filesToChangeExecBit[f]
             setP4ExecBit(f, mode)
 
+        #
+        # Build p4 change description, starting with the contents
+        # of the git commit message.
+        #
         logMessage = extractLogMessageFromGitCommit(id)
         logMessage = logMessage.strip()
         (logMessage, jobs) = self.separate_jobs_from_description(logMessage)
@@ -1223,8 +1230,16 @@ class P4Submit(Command, P4UserMap):
         submitTemplate = self.prepareLogMessage(template, logMessage, jobs)
 
         if self.preserveUser:
-           submitTemplate = submitTemplate + ("\n######## Actual user %s, modified after commit\n" % p4User)
+           submitTemplate += "\n######## Actual user %s, modified after commit\n" % p4User
+
+        if self.checkAuthorship and not self.p4UserIsMe(p4User):
+            submitTemplate += "######## git author %s does not match your p4 account.\n" % gitEmail
+            submitTemplate += "######## Use option --preserve-user to modify authorship.\n"
+            submitTemplate += "######## Variable git-p4.skipUserNameCheck hides this message.\n"
+
+        separatorLine = "######## everything below this line is just the diff #######\n"
 
+        # diff
         if os.environ.has_key("P4DIFF"):
             del(os.environ["P4DIFF"])
         diff = ""
@@ -1232,6 +1247,7 @@ class P4Submit(Command, P4UserMap):
             diff += p4_read_pipe(['diff', '-du',
                                   wildcard_encode(editedFile)])
 
+        # new file diff
         newdiff = ""
         for newFile in filesToAdd:
             newdiff += "==== new file ====\n"
@@ -1242,13 +1258,7 @@ class P4Submit(Command, P4UserMap):
                 newdiff += "+" + line
             f.close()
 
-        if self.checkAuthorship and not self.p4UserIsMe(p4User):
-            submitTemplate += "######## git author %s does not match your p4 account.\n" % gitEmail
-            submitTemplate += "######## Use option --preserve-user to modify authorship.\n"
-            submitTemplate += "######## Variable git-p4.skipUserNameCheck hides this message.\n"
-
-        separatorLine = "######## everything below this line is just the diff #######\n"
-
+        # change description file: submitTemplate, separatorLine, diff, newdiff
         (handle, fileName) = tempfile.mkstemp()
         tmpFile = os.fdopen(handle, "w+")
         if self.isWindows:
@@ -1258,6 +1268,9 @@ class P4Submit(Command, P4UserMap):
         tmpFile.write(submitTemplate + separatorLine + diff + newdiff)
         tmpFile.close()
 
+        #
+        # Let the user edit the change description, then submit it.
+        #
         if self.edit_template(fileName):
             # read the edited message and submit
             ret = True
-- 
1.7.11.4

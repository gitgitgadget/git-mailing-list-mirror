From: Pete Wyckoff <pw@padd.com>
Subject: [PATCHv2 07/12] git p4: rearrange submit template construction
Date: Sun,  9 Sep 2012 16:16:08 -0400
Message-ID: <1347221773-12773-8-git-send-email-pw@padd.com>
References: <1347221773-12773-1-git-send-email-pw@padd.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Luke Diamand <luke@diamand.org>,
	Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 09 22:18:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAnxt-0004zg-0q
	for gcvg-git-2@plane.gmane.org; Sun, 09 Sep 2012 22:18:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754825Ab2IIUSi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Sep 2012 16:18:38 -0400
Received: from honk.padd.com ([74.3.171.149]:53008 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752589Ab2IIUSh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Sep 2012 16:18:37 -0400
Received: from arf.padd.com (unknown [50.55.149.165])
	by honk.padd.com (Postfix) with ESMTPSA id A9C885AF2;
	Sun,  9 Sep 2012 13:18:36 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 4F6BA32112; Sun,  9 Sep 2012 16:18:34 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.176.gc22bed1
In-Reply-To: <1347221773-12773-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205097>

Put all items in order as they appear, and add comments.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 git-p4.py | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 0481f43..ea14c1f 100755
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
1.7.12.rc2.111.g96f7c73

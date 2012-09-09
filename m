From: Pete Wyckoff <pw@padd.com>
Subject: [PATCHv2 04/12] git p4: move conflict prompt into run, add [q]uit input
Date: Sun,  9 Sep 2012 16:16:05 -0400
Message-ID: <1347221773-12773-5-git-send-email-pw@padd.com>
References: <1347221773-12773-1-git-send-email-pw@padd.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Luke Diamand <luke@diamand.org>,
	Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 09 22:17:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAnx1-0004TP-4r
	for gcvg-git-2@plane.gmane.org; Sun, 09 Sep 2012 22:17:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754863Ab2IIURh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Sep 2012 16:17:37 -0400
Received: from honk.padd.com ([74.3.171.149]:52992 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752589Ab2IIURh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Sep 2012 16:17:37 -0400
Received: from arf.padd.com (unknown [50.55.149.165])
	by honk.padd.com (Postfix) with ESMTPSA id 6985A5AF2;
	Sun,  9 Sep 2012 13:17:36 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 12CE832112; Sun,  9 Sep 2012 16:17:33 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.176.gc22bed1
In-Reply-To: <1347221773-12773-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205094>

When applying a commit to the p4 workspace fails, a prompt
asks what to do next.  This belongs up in run() instead
of in applyCommit(), where run() can notice, for instance,
that the prompt is unnecessary because this is the last commit.

Offer two options about how to continue at conflict: [s]kip or
[q]uit.  Having an explicit "quit" option gives git p4 a chance
to clean up, show the applied-commit summary, and do tag export.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 git-p4.py                     | 41 +++++++++++++++++++++++++++++------------
 t/t9815-git-p4-submit-fail.sh | 31 +++++++++++++++++++++++++++----
 2 files changed, 56 insertions(+), 16 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index e08fea1..479f1fc 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1198,17 +1198,11 @@ class P4Submit(Command, P4UserMap):
                     patch_succeeded = True
 
         if not patch_succeeded:
-            print "What do you want to do?"
-            response = "x"
-            while response != "s":
-                response = raw_input("[s]kip this patch ")
-            if response == "s":
-                print "Skipping! Good luck with the next patches..."
-                for f in editedFiles:
-                    p4_revert(f)
-                for f in filesToAdd:
-                    os.remove(f)
-                return False
+            for f in editedFiles:
+                p4_revert(f)
+            for f in filesToAdd:
+                os.remove(f)
+            return False
 
         system(applyPatchCmd)
 
@@ -1475,11 +1469,34 @@ class P4Submit(Command, P4UserMap):
         if gitConfig("git-p4.detectCopiesHarder", "--bool") == "true":
             self.diffOpts += " --find-copies-harder"
 
+        #
+        # Apply the commits, one at a time.  On failure, ask if should
+        # continue to try the rest of the patches, or quit.
+        #
         applied = []
-        for commit in commits:
+        last = len(commits) - 1
+        for i, commit in enumerate(commits):
             ok = self.applyCommit(commit)
             if ok:
                 applied.append(commit)
+            else:
+                if i < last:
+                    quit = False
+                    while True:
+                        print "What do you want to do?"
+                        response = raw_input("[s]kip this commit but apply"
+                                             " the rest, or [q]uit? ")
+                        if not response:
+                            continue
+                        if response[0] == "s":
+                            print "Skipping this commit, but applying the rest"
+                            break
+                        if response[0] == "q":
+                            print "Quitting"
+                            quit = True
+                            break
+                    if quit:
+                        break
 
         chdir(self.oldWorkingDirectory)
 
diff --git a/t/t9815-git-p4-submit-fail.sh b/t/t9815-git-p4-submit-fail.sh
index 5c36714..397b3e8 100755
--- a/t/t9815-git-p4-submit-fail.sh
+++ b/t/t9815-git-p4-submit-fail.sh
@@ -18,7 +18,7 @@ test_expect_success 'init depot' '
 	)
 '
 
-test_expect_success 'conflict on one commit, skip' '
+test_expect_success 'conflict on one commit' '
 	test_when_finished cleanup_git &&
 	git p4 clone --dest="$git" //depot &&
 	(
@@ -34,12 +34,12 @@ test_expect_success 'conflict on one commit, skip' '
 		echo line3 >>file1 &&
 		git add file1 &&
 		git commit -m "line3 in file1 will conflict" &&
-		echo s | test_expect_code 1 git p4 submit >out &&
+		test_expect_code 1 git p4 submit >out &&
 		test_i18ngrep "No commits applied" out
 	)
 '
 
-test_expect_success 'conflict on second of two commits, skip' '
+test_expect_success 'conflict on second of two commits' '
 	test_when_finished cleanup_git &&
 	git p4 clone --dest="$git" //depot &&
 	(
@@ -57,7 +57,7 @@ test_expect_success 'conflict on second of two commits, skip' '
 		echo line4 >>file1 &&
 		git add file1 &&
 		git commit -m "line4 in file1 will conflict" &&
-		echo s | test_expect_code 1 git p4 submit >out &&
+		test_expect_code 1 git p4 submit >out &&
 		test_i18ngrep "Applied only the commits" out
 	)
 '
@@ -85,6 +85,29 @@ test_expect_success 'conflict on first of two commits, skip' '
 	)
 '
 
+test_expect_success 'conflict on first of two commits, quit' '
+	test_when_finished cleanup_git &&
+	git p4 clone --dest="$git" //depot &&
+	(
+		cd "$cli" &&
+		p4 open file1 &&
+		echo line7 >>file1 &&
+		p4 submit -d "line7 in file1"
+	) &&
+	(
+		cd "$git" &&
+		git config git-p4.skipSubmitEdit true &&
+		# this submit should cause a conflict
+		echo line8 >>file1 &&
+		git add file1 &&
+		git commit -m "line8 in file1 will conflict" &&
+		# but this commit is okay
+		test_commit "okay_commit_after_quit" &&
+		echo q | test_expect_code 1 git p4 submit >out &&
+		test_i18ngrep "No commits applied" out
+	)
+'
+
 test_expect_success 'kill p4d' '
 	kill_p4d
 '
-- 
1.7.12.rc2.111.g96f7c73

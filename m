From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 05/12] git p4: move conflict prompt into run, use [c]ontinue and [q]uit
Date: Thu, 16 Aug 2012 19:35:07 -0400
Message-ID: <1345160114-27654-6-git-send-email-pw@padd.com>
References: <1345160114-27654-1-git-send-email-pw@padd.com>
Cc: Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 17 01:37:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T29ce-00042b-No
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 01:37:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753101Ab2HPXg7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Aug 2012 19:36:59 -0400
Received: from honk.padd.com ([74.3.171.149]:47766 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752636Ab2HPXg6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2012 19:36:58 -0400
Received: from arf.padd.com (unknown [50.55.149.165])
	by honk.padd.com (Postfix) with ESMTPSA id 5BB74D27;
	Thu, 16 Aug 2012 16:36:57 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 2306E313FD; Thu, 16 Aug 2012 19:36:55 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.rc2.111.g96f7c73
In-Reply-To: <1345160114-27654-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When applying a commit to the p4 workspace fails, a prompt
asks what to do next.  This belongs up in run() instead
of in applyCommit(), where run() can notice, for instance,
that the prompt is unnecessary because this is the last commit.

Remove the [s]kip option in favor of two new ones: [c]ontinue and
[q]uit.  Continue means the same as skip, but is more similar to
the --continue option of rebase.  Option [q]uit stops processing.
This is an improvement on the current requirement of ctrl-c, s an
explicit "quit" gives git p4 a chance to clean up, show the
applied-commit summary, and do tag export.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 git-p4.py                     | 41 +++++++++++++++++++++++++++++------------
 t/t9815-git-p4-submit-fail.sh | 37 ++++++++++++++++++++++++++++++-------
 2 files changed, 59 insertions(+), 19 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index e08fea1..1d5194d 100755
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
+                        response = raw_input(
+                            "[c]ontinue to submit other patches, or [q]uit? ")
+                        if not response:
+                            continue
+                        if response[0] == "c":
+                            print "Continuing to submit the rest of the patches"
+                            break
+                        if response[0] == "q":
+                            print "Quitting"
+                            quit = True
+                            break
+                    if quit:
+                        break
 
         chdir(self.oldWorkingDirectory)
 
diff --git a/t/t9815-git-p4-submit-fail.sh b/t/t9815-git-p4-submit-fail.sh
index 8a02c3b..f6204eb 100755
--- a/t/t9815-git-p4-submit-fail.sh
+++ b/t/t9815-git-p4-submit-fail.sh
@@ -19,7 +19,7 @@ test_expect_success 'init depot' '
 	)
 '
 
-test_expect_success 'conflict on one commit, skip' '
+test_expect_success 'conflict on one commit' '
 	test_when_finished cleanup_git &&
 	git p4 clone --dest="$git" //depot &&
 	(
@@ -35,12 +35,12 @@ test_expect_success 'conflict on one commit, skip' '
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
@@ -58,12 +58,12 @@ test_expect_success 'conflict on second of two commits, skip' '
 		echo line4 >>file1 &&
 		git add file1 &&
 		git commit -m "line4 in file1 will conflict" &&
-		echo s | test_expect_code 1 git p4 submit >out &&
+		test_expect_code 1 git p4 submit >out &&
 		test_i18ngrep "Applied only the commits" out
 	)
 '
 
-test_expect_success 'conflict on first of two commits, skip' '
+test_expect_success 'conflict on first of two commits, continue' '
 	test_when_finished cleanup_git &&
 	git p4 clone --dest="$git" //depot &&
 	(
@@ -80,12 +80,35 @@ test_expect_success 'conflict on first of two commits, skip' '
 		git add file1 &&
 		git commit -m "line5 in file1 will conflict" &&
 		# but this commit is okay
-		test_commit "okay_commit_after_skip" &&
-		echo s | test_expect_code 1 git p4 submit >out &&
+		test_commit "okay_commit_after_continue" &&
+		echo c | test_expect_code 1 git p4 submit >out &&
 		test_i18ngrep "Applied only the commits" out
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
1.7.11.4

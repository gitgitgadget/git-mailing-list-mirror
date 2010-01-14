From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 17/18] t3404: Set up more of the test repo in the "setup" step
Date: Thu, 14 Jan 2010 06:54:56 +0100
Message-ID: <9595024ceae4d013954092ed928a50fd887e5996.1263447038.git.mhagger@alum.mit.edu>
References: <cover.1263447037.git.mhagger@alum.mit.edu>
Cc: gitster@pobox.com, Johannes.Schindelin@gmx.de,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 14 06:56:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVIgf-0002Vo-0h
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 06:56:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755703Ab0ANFzh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 00:55:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755700Ab0ANFzf
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 00:55:35 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:58647 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755607Ab0ANFzd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 00:55:33 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from localhost.localdomain (p4FC1EBF4.dip.t-dialin.net [79.193.235.244])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id o0E5t4bW001912;
	Thu, 14 Jan 2010 06:55:29 +0100
X-Mailer: git-send-email 1.6.6
In-Reply-To: <cover.1263447037.git.mhagger@alum.mit.edu>
In-Reply-To: <cover.1263447037.git.mhagger@alum.mit.edu>
References: <cover.1263447037.git.mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136939>

...and reuse these pre-created branches in tests rather than creating
duplicates.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t3404-rebase-interactive.sh |   51 +++++++++++++++++++++--------------------
 1 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 175a86c..a119ce0 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -14,15 +14,20 @@ that the result still makes sense.
 
 set_fake_editor
 
-# set up two branches like this:
+# Set up the repository like this:
 #
-# A - B - C - D - E     (master)
+#     one - two - three - four (conflict-branch)
+#   /
+# A - B - C - D - E            (master)
+# | \
+# |   F - G - H                (branch1)
+# |     \
+#  \      I                    (branch2)
 #   \
-#     F - G - H         (branch1)
-#       \
-#         I             (branch2)
+#     J - K - L - M            (no-conflict-branch)
 #
-# where A, B, D and G touch the same file.
+# where A, B, D and G all touch file1, and one, two, three, four all
+# touch file "conflict".
 
 test_expect_success 'setup' '
 	test_commit A file1 &&
@@ -36,9 +41,20 @@ test_expect_success 'setup' '
 	test_commit H file5 &&
 	git checkout -b branch2 F &&
 	test_commit I file6
+	git checkout -b conflict-branch A &&
+	for n in one two three four
+	do
+		test_commit $n conflict
+	done &&
+	git checkout -b no-conflict-branch A &&
+	for n in J K L M
+	do
+		test_commit $n file$n
+	done
 '
 
 test_expect_success 'no changes are a nop' '
+	git checkout branch2 &&
 	git rebase -i F &&
 	test "$(git symbolic-ref -q HEAD)" = "refs/heads/branch2" &&
 	test $(git rev-parse I) = $(git rev-parse HEAD)
@@ -97,7 +113,7 @@ cat > expect2 << EOF
 D
 =======
 G
->>>>>>> 91201e5... G
+>>>>>>> 51047de... G
 EOF
 
 test_expect_success 'stop on conflicting pick' '
@@ -293,12 +309,7 @@ test_expect_success 'squash ignores blank lines' '
 '
 
 test_expect_success 'squash works as expected' '
-	for n in one two three four
-	do
-		echo $n >> file$n &&
-		git add file$n &&
-		git commit -m $n
-	done &&
+	git checkout -b squash-works no-conflict-branch &&
 	one=$(git rev-parse HEAD~3) &&
 	FAKE_LINES="1 squash 3 2" EXPECT_HEADER_COUNT=2 \
 		git rebase -i HEAD~3 &&
@@ -306,12 +317,7 @@ test_expect_success 'squash works as expected' '
 '
 
 test_expect_success 'interrupted squash works as expected' '
-	for n in one two three four
-	do
-		echo $n >> conflict &&
-		git add conflict &&
-		git commit -m $n
-	done &&
+	git checkout -b interrupted-squash conflict-branch &&
 	one=$(git rev-parse HEAD~3) &&
 	(
 		FAKE_LINES="1 squash 3 2" &&
@@ -328,12 +334,7 @@ test_expect_success 'interrupted squash works as expected' '
 '
 
 test_expect_success 'interrupted squash works as expected (case 2)' '
-	for n in one two three four
-	do
-		echo $n >> conflict &&
-		git add conflict &&
-		git commit -m $n
-	done &&
+	git checkout -b interrupted-squash2 conflict-branch &&
 	one=$(git rev-parse HEAD~3) &&
 	(
 		FAKE_LINES="3 squash 1 2" &&
-- 
1.6.6

From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH 1/3] t3404: slight improvements
Date: Fri, 20 Jun 2008 04:45:33 +0200
Message-ID: <1213929935-15093-2-git-send-email-s-beyer@gmx.net>
References: <1213929935-15093-1-git-send-email-s-beyer@gmx.net>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <chriscool@tuxfamily.org>,
	Stephan Beyer <s-beyer@gmx.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 20 04:46:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9WeL-0006EA-92
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 04:46:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751973AbYFTCpq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 22:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751966AbYFTCpq
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 22:45:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:42268 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751929AbYFTCpl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 22:45:41 -0400
Received: (qmail invoked by alias); 20 Jun 2008 02:45:39 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp065) with SMTP; 20 Jun 2008 04:45:39 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX19rIqFNDl5r0tmJSno5WzBxfx7CEQpTBFdrXUSZXh
	WfbnE0Hg9SN80u
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1K9Wd5-0003wy-Hf; Fri, 20 Jun 2008 04:45:35 +0200
X-Mailer: git-send-email 1.5.5.1.561.gd8556
In-Reply-To: <1213929935-15093-1-git-send-email-s-beyer@gmx.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85587>

This patch adds some extra checks into some
test cases and changes "! git ..." into
"test_must_fail git".

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
 t/t3404-rebase-interactive.sh |   29 +++++++++++++++++++----------
 1 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index e6f3fad..daba5fd 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -107,7 +107,8 @@ chmod a+x fake-editor.sh
 
 test_expect_success 'no changes are a nop' '
 	git rebase -i F &&
-	test $(git rev-parse I) = $(git rev-parse HEAD)
+	test $(git rev-parse I) = $(git rev-parse HEAD) &&
+	test "$(git symbolic-ref -q HEAD)" = "refs/heads/branch2"
 '
 
 test_expect_success 'test the [branch] option' '
@@ -115,7 +116,9 @@ test_expect_success 'test the [branch] option' '
 	git rm file6 &&
 	git commit -m "stop here" &&
 	git rebase -i F branch2 &&
-	test $(git rev-parse I) = $(git rev-parse HEAD)
+	test $(git rev-parse I) = $(git rev-parse branch2) &&
+	test $(git rev-parse I) = $(git rev-parse HEAD) &&
+	test "$(git symbolic-ref -q HEAD)" = "refs/heads/branch2"
 '
 
 test_expect_success 'rebase on top of a non-conflicting commit' '
@@ -123,7 +126,9 @@ test_expect_success 'rebase on top of a non-conflicting commit' '
 	git tag original-branch1 &&
 	git rebase -i branch2 &&
 	test file6 = $(git diff --name-only original-branch1) &&
-	test $(git rev-parse I) = $(git rev-parse HEAD~2)
+	test $(git rev-parse I) = $(git rev-parse branch2) &&
+	test $(git rev-parse I) = $(git rev-parse HEAD~2) &&
+	test "$(git symbolic-ref -q HEAD)" = "refs/heads/branch1"
 '
 
 test_expect_success 'reflog for the branch shows state before rebase' '
@@ -155,9 +160,12 @@ EOF
 
 test_expect_success 'stop on conflicting pick' '
 	git tag new-branch1 &&
-	! git rebase -i master &&
+	test_must_fail git rebase -i master &&
+	test "$(git rev-parse HEAD~3)" = "$(git rev-parse master)" &&
 	test_cmp expect .git/.dotest-merge/patch &&
 	test_cmp expect2 file1 &&
+	test "$(git-diff --name-status |
+		sed -n -e "/^U/s/^U[^a-z]*//p")" = file1 &&
 	test 4 = $(grep -v "^#" < .git/.dotest-merge/done | wc -l) &&
 	test 0 = $(grep -c "^[^#]" < .git/.dotest-merge/git-rebase-todo)
 '
@@ -165,6 +173,7 @@ test_expect_success 'stop on conflicting pick' '
 test_expect_success 'abort' '
 	git rebase --abort &&
 	test $(git rev-parse new-branch1) = $(git rev-parse HEAD) &&
+	test "$(git symbolic-ref -q HEAD)" = "refs/heads/branch1" &&
 	! test -d .git/.dotest-merge
 '
 
@@ -331,7 +340,7 @@ test_expect_success 'interactive -t preserves tags' '
 test_expect_success '--continue tries to commit' '
 	git checkout to-be-rebased &&
 	test_tick &&
-	! git rebase -i --onto new-branch1 HEAD^ &&
+	test_must_fail git rebase -i --onto new-branch1 HEAD^ &&
 	echo resolved > file1 &&
 	git add file1 &&
 	FAKE_COMMIT_MESSAGE="chouette!" git rebase --continue &&
@@ -342,7 +351,7 @@ test_expect_success '--continue tries to commit' '
 test_expect_success 'verbose flag is heeded, even after --continue' '
 	git reset --hard HEAD@{1} &&
 	test_tick &&
-	! git rebase -v -i --onto new-branch1 HEAD^ &&
+	test_must_fail git rebase -v -i --onto new-branch1 HEAD^ &&
 	echo resolved > file1 &&
 	git add file1 &&
 	git rebase --continue > output &&
@@ -380,7 +389,7 @@ test_expect_success 'interrupted squash works as expected' '
 	! FAKE_LINES="1 squash 3 2" git rebase -i HEAD~3 &&
 	(echo one; echo two; echo four) > conflict &&
 	git add conflict &&
-	! git rebase --continue &&
+	test_must_fail git rebase --continue &&
 	echo resolved > conflict &&
 	git add conflict &&
 	git rebase --continue &&
@@ -398,10 +407,10 @@ test_expect_success 'interrupted squash works as expected (case 2)' '
 	! FAKE_LINES="3 squash 1 2" git rebase -i HEAD~3 &&
 	(echo one; echo four) > conflict &&
 	git add conflict &&
-	! git rebase --continue &&
+	test_must_fail git rebase --continue &&
 	(echo one; echo two; echo four) > conflict &&
 	git add conflict &&
-	! git rebase --continue &&
+	test_must_fail git rebase --continue &&
 	echo resolved > conflict &&
 	git add conflict &&
 	git rebase --continue &&
@@ -449,7 +458,7 @@ test_expect_success 'rebase a commit violating pre-commit' '
 	chmod a+x $PRE_COMMIT &&
 	echo "monde! " >> file1 &&
 	test_tick &&
-	! git commit -m doesnt-verify file1 &&
+	test_must_fail git commit -m doesnt-verify file1 &&
 	git commit -m doesnt-verify --no-verify file1 &&
 	test_tick &&
 	FAKE_LINES=2 git rebase -i HEAD~2
-- 
1.5.5.1.561.gd8556

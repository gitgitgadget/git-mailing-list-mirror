From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH v3 1/2] t3404: stricter tests for git-rebase--interactive
Date: Sun, 22 Jun 2008 01:55:50 +0200
Message-ID: <1214092551-8075-1-git-send-email-s-beyer@gmx.net>
References: <7v4p7nazof.fsf@gitster.siamese.dyndns.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <chriscool@tuxfamily.org>,
	Stephan Beyer <s-beyer@gmx.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 22 01:57:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KACxU-0001ge-EE
	for gcvg-git-2@gmane.org; Sun, 22 Jun 2008 01:57:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751783AbYFUX4K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jun 2008 19:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751981AbYFUX4J
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jun 2008 19:56:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:54019 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751662AbYFUX4G (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jun 2008 19:56:06 -0400
Received: (qmail invoked by alias); 21 Jun 2008 23:56:05 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp041) with SMTP; 22 Jun 2008 01:56:05 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1/q2TxouPvq1VfoK5nAQwG4HmC3WrzIjdIb0t7gov
	B8FCRrZceZeVmh
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KACvv-00026r-K7; Sun, 22 Jun 2008 01:55:51 +0200
X-Mailer: git-send-email 1.5.6.310.g344d
In-Reply-To: <7v4p7nazof.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85740>

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
Hi,

ok, next try.
Because I do not want to do a half-ass job, I changed
the remaining ! git to test_must_fail and changed the commit
message subject and removed the commit message body. ;-)

Again, this only applies cleanly to "pu".

 t/t3404-rebase-interactive.sh |   43 ++++++++++++++++++++++++++++++++--------
 1 files changed, 34 insertions(+), 9 deletions(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index e6f3fad..940eb24 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -107,6 +107,7 @@ chmod a+x fake-editor.sh
 
 test_expect_success 'no changes are a nop' '
 	git rebase -i F &&
+	test "$(git symbolic-ref -q HEAD)" = "refs/heads/branch2" &&
 	test $(git rev-parse I) = $(git rev-parse HEAD)
 '
 
@@ -115,14 +116,26 @@ test_expect_success 'test the [branch] option' '
 	git rm file6 &&
 	git commit -m "stop here" &&
 	git rebase -i F branch2 &&
+	test "$(git symbolic-ref -q HEAD)" = "refs/heads/branch2" &&
+	test $(git rev-parse I) = $(git rev-parse branch2) &&
 	test $(git rev-parse I) = $(git rev-parse HEAD)
 '
 
+test_expect_success 'test --onto <branch>' '
+	git checkout -b test-onto branch2 &&
+	git rebase -i --onto branch1 F &&
+	test "$(git symbolic-ref -q HEAD)" = "refs/heads/test-onto" &&
+	test $(git rev-parse HEAD^) = $(git rev-parse branch1) &&
+	test $(git rev-parse I) = $(git rev-parse branch2)
+'
+
 test_expect_success 'rebase on top of a non-conflicting commit' '
 	git checkout branch1 &&
 	git tag original-branch1 &&
 	git rebase -i branch2 &&
 	test file6 = $(git diff --name-only original-branch1) &&
+	test "$(git symbolic-ref -q HEAD)" = "refs/heads/branch1" &&
+	test $(git rev-parse I) = $(git rev-parse branch2) &&
 	test $(git rev-parse I) = $(git rev-parse HEAD~2)
 '
 
@@ -155,9 +168,12 @@ EOF
 
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
@@ -165,6 +181,7 @@ test_expect_success 'stop on conflicting pick' '
 test_expect_success 'abort' '
 	git rebase --abort &&
 	test $(git rev-parse new-branch1) = $(git rev-parse HEAD) &&
+	test "$(git symbolic-ref -q HEAD)" = "refs/heads/branch1" &&
 	! test -d .git/.dotest-merge
 '
 
@@ -331,7 +348,7 @@ test_expect_success 'interactive -t preserves tags' '
 test_expect_success '--continue tries to commit' '
 	git checkout to-be-rebased &&
 	test_tick &&
-	! git rebase -i --onto new-branch1 HEAD^ &&
+	test_must_fail git rebase -i --onto new-branch1 HEAD^ &&
 	echo resolved > file1 &&
 	git add file1 &&
 	FAKE_COMMIT_MESSAGE="chouette!" git rebase --continue &&
@@ -342,7 +359,7 @@ test_expect_success '--continue tries to commit' '
 test_expect_success 'verbose flag is heeded, even after --continue' '
 	git reset --hard HEAD@{1} &&
 	test_tick &&
-	! git rebase -v -i --onto new-branch1 HEAD^ &&
+	test_must_fail git rebase -v -i --onto new-branch1 HEAD^ &&
 	echo resolved > file1 &&
 	git add file1 &&
 	git rebase --continue > output &&
@@ -377,10 +394,14 @@ test_expect_success 'interrupted squash works as expected' '
 		git commit -m $n
 	done &&
 	one=$(git rev-parse HEAD~3) &&
-	! FAKE_LINES="1 squash 3 2" git rebase -i HEAD~3 &&
+	(
+		FAKE_LINES="1 squash 3 2" &&
+		export FAKE_LINES &&
+		test_must_fail git rebase -i HEAD~3
+	) &&
 	(echo one; echo two; echo four) > conflict &&
 	git add conflict &&
-	! git rebase --continue &&
+	test_must_fail git rebase --continue &&
 	echo resolved > conflict &&
 	git add conflict &&
 	git rebase --continue &&
@@ -395,13 +416,17 @@ test_expect_success 'interrupted squash works as expected (case 2)' '
 		git commit -m $n
 	done &&
 	one=$(git rev-parse HEAD~3) &&
-	! FAKE_LINES="3 squash 1 2" git rebase -i HEAD~3 &&
+	(
+		FAKE_LINES="3 squash 1 2" &&
+		export FAKE_LINES &&
+		test_must_fail git rebase -i HEAD~3
+	) &&
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
@@ -449,7 +474,7 @@ test_expect_success 'rebase a commit violating pre-commit' '
 	chmod a+x $PRE_COMMIT &&
 	echo "monde! " >> file1 &&
 	test_tick &&
-	! git commit -m doesnt-verify file1 &&
+	test_must_fail git commit -m doesnt-verify file1 &&
 	git commit -m doesnt-verify --no-verify file1 &&
 	test_tick &&
 	FAKE_LINES=2 git rebase -i HEAD~2
-- 
1.5.6.310.g344d

From: Thomas Rast <trast@student.ethz.ch>
Subject: [RFC PATCH v2 08/11] rebase: support automatic notes copying
Date: Wed, 17 Feb 2010 00:26:04 +0100
Message-ID: <621ce5ad0290d5df0022a7929070a2e0a72c7c22.1266361759.git.trast@student.ethz.ch>
References: <cover.1266361759.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j6t@kdbg.org>, Johan Herland <johan@herland.net>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 17 00:27:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhWp3-0006BI-RN
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 00:27:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933524Ab0BPX0v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 18:26:51 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:45469 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933593Ab0BPX0i (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 18:26:38 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.234.1; Wed, 17 Feb
 2010 00:26:27 +0100
Received: from localhost.localdomain (84.74.100.59) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Wed, 17 Feb
 2010 00:26:10 +0100
X-Mailer: git-send-email 1.7.0.67.g67ac3
In-Reply-To: <cover.1266361759.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140163>

Luckily, all the support already happens to be there.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 git-am.sh                     |    5 ++++-
 git-rebase--interactive.sh    |    4 ++++
 git-rebase.sh                 |    1 +
 t/t3400-rebase.sh             |   16 ++++++++++++++++
 t/t3404-rebase-interactive.sh |   10 ++++++++++
 5 files changed, 35 insertions(+), 1 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 56428b4..83cf6e7 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -782,8 +782,11 @@ do
 	go_next
 done
 
-if test -s "$dotest"/rewritten && test -x "$GIT_DIR"/hooks/post-rewrite; then
+if test -s "$dotest"/rewritten; then
+    git notes copy --for-rewrite=rebase < "$dotest"/rewritten
+    if test -x "$GIT_DIR"/hooks/post-rewrite; then
 	"$GIT_DIR"/hooks/post-rewrite rebase < "$dotest"/rewritten
+    fi
 fi
 
 git gc --auto
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index fc4f7e9..1fda620 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -570,6 +570,10 @@ do_next () {
 		test ! -f "$DOTEST"/verbose ||
 			git diff-tree --stat $(cat "$DOTEST"/head)..HEAD
 	} &&
+	{
+		git notes copy --for-rewrite=rebase < "$REWRITTEN_LIST" ||
+		true # we don't care if this copying failed
+	} &&
 	if test -x "$GIT_DIR"/hooks/post-rewrite &&
 		test -s "$REWRITTEN_LIST"; then
 		"$GIT_DIR"/hooks/post-rewrite rebase < "$REWRITTEN_LIST"
diff --git a/git-rebase.sh b/git-rebase.sh
index 52f8b9b..e0eb956 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -152,6 +152,7 @@ move_to_original_branch () {
 
 finish_rb_merge () {
 	move_to_original_branch
+	git notes copy --for-rewrite=rebase < "$dotest"/rewritten
 	if test -x "$GIT_DIR"/hooks/post-rewrite &&
 		test -s "$dotest"/rewritten; then
 		"$GIT_DIR"/hooks/post-rewrite rebase < "$dotest"/rewritten
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 4314ad2..4608196 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -151,4 +151,20 @@ test_expect_success 'Rebase a commit that sprinkles CRs in' '
 	git diff --exit-code file-with-cr:CR HEAD:CR
 '
 
+test_expect_success 'rebase can copy notes' '
+	git config notes.rewrite.rebase true &&
+	test_commit n1 &&
+	test_commit n2 &&
+	test_commit n3 &&
+	git notes add -m"a note" n3 &&
+	git rebase --onto n1 n2 &&
+	test "a note" = "$(git notes show HEAD)"
+'
+
+test_expect_success 'rebase -m can copy notes' '
+	git reset --hard n3 &&
+	git rebase -m --onto n1 n2 &&
+	test "a note" = "$(git notes show HEAD)"
+'
+
 test_done
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 4e35137..5b5104c 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -553,4 +553,14 @@ test_expect_success 'reword' '
 	git show HEAD~2 | grep "C changed"
 '
 
+test_expect_success 'rebase -i can copy notes' '
+	git config notes.rewrite.rebase true &&
+	test_commit n1 &&
+	test_commit n2 &&
+	test_commit n3 &&
+	git notes add -m"a note" n3 &&
+	git rebase --onto n1 n2 &&
+	test "a note" = "$(git notes show HEAD)"
+'
+
 test_done
-- 
1.7.0.53.g5c2e6.dirty

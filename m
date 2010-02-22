From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v4 09/11] rebase: support automatic notes copying
Date: Mon, 22 Feb 2010 01:10:22 +0100
Message-ID: <57ca9ec9bc9ccdc05c3e54667e7e27dfc9e18ebe.1266797028.git.trast@student.ethz.ch>
References: <cover.1266797028.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Johan Herland <johan@herland.net>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 22 02:08:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjLtO-0000EH-4x
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 01:11:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753893Ab0BVALF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2010 19:11:05 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:28109 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753869Ab0BVAK7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2010 19:10:59 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.234.1; Mon, 22 Feb
 2010 01:10:51 +0100
Received: from localhost.localdomain (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Mon, 22 Feb
 2010 01:10:33 +0100
X-Mailer: git-send-email 1.7.0.147.g5aeb9
In-Reply-To: <cover.1266797028.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140629>

Luckily, all the support already happens to be there.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Changed from v3: more tests

 git-am.sh                     |    5 ++++-
 git-rebase--interactive.sh    |    4 ++++
 git-rebase.sh                 |    1 +
 t/t3400-rebase.sh             |   17 +++++++++++++++++
 t/t3404-rebase-interactive.sh |   24 ++++++++++++++++++++++++
 5 files changed, 50 insertions(+), 1 deletions(-)

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
index 564f6ac..415ae72 100755
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
index 4314ad2..dbf7dfb 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -151,4 +151,21 @@ test_expect_success 'Rebase a commit that sprinkles CRs in' '
 	git diff --exit-code file-with-cr:CR HEAD:CR
 '
 
+test_expect_success 'rebase can copy notes' '
+	git config notes.rewrite.rebase true &&
+	git config notes.rewriteRef "refs/notes/*" &&
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
index 4e35137..19668c2 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -553,4 +553,28 @@ test_expect_success 'reword' '
 	git show HEAD~2 | grep "C changed"
 '
 
+test_expect_success 'rebase -i can copy notes' '
+	git config notes.rewrite.rebase true &&
+	git config notes.rewriteRef "refs/notes/*" &&
+	test_commit n1 &&
+	test_commit n2 &&
+	test_commit n3 &&
+	git notes add -m"a note" n3 &&
+	git rebase --onto n1 n2 &&
+	test "a note" = "$(git notes show HEAD)"
+'
+
+cat >expect <<EOF
+an earlier note
+a note
+EOF
+
+test_expect_success 'rebase -i can copy notes over a fixup' '
+	git reset --hard n3 &&
+	git notes add -m"an earlier note" n2 &&
+	GIT_NOTES_REWRITE_MODE=concatenate FAKE_LINES="1 fixup 2" git rebase -i n1 &&
+	git notes show > output &&
+	test_cmp expect output
+'
+
 test_done
-- 
1.7.0.147.g5aeb9

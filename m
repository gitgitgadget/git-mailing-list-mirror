From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v6 09/13] rebase: support automatic notes copying
Date: Wed, 10 Mar 2010 15:05:56 +0100
Message-ID: <78cd4b3f89c0423c8f680da3de0f29ad2d492a4b.1268229087.git.trast@student.ethz.ch>
References: <cover.1268229087.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j6t@kdbg.org>, Johan Herland <johan@herland.net>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 10 15:06:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpMYH-0004Py-Qf
	for gcvg-git-2@lo.gmane.org; Wed, 10 Mar 2010 15:06:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932402Ab0CJOGR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Mar 2010 09:06:17 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:7926 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932393Ab0CJOGP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Mar 2010 09:06:15 -0500
Received: from CAS02.d.ethz.ch (129.132.178.236) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.234.1; Wed, 10 Mar
 2010 15:06:05 +0100
Received: from localhost.localdomain (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Wed, 10 Mar
 2010 15:06:01 +0100
X-Mailer: git-send-email 1.7.0.2.407.g21ebda
In-Reply-To: <cover.1268229087.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141895>

Luckily, all the support already happens to be there.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---


 git-am.sh                     |    5 ++++-
 git-rebase--interactive.sh    |    4 ++++
 git-rebase.sh                 |    1 +
 t/t3400-rebase.sh             |   17 +++++++++++++++++
 t/t3404-rebase-interactive.sh |   24 ++++++++++++++++++++++++
 5 files changed, 50 insertions(+), 1 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 9b73e0b..1056075 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -797,8 +797,11 @@ do
 	go_next
 done
 
-if test -s "$dotest"/rewritten && test -x "$GIT_DIR"/hooks/post-rewrite; then
+if test -s "$dotest"/rewritten; then
+    git notes copy --for-rewrite=rebase < "$dotest"/rewritten
+    if test -x "$GIT_DIR"/hooks/post-rewrite; then
 	"$GIT_DIR"/hooks/post-rewrite rebase < "$dotest"/rewritten
+    fi
 fi
 
 rm -fr "$dotest"
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index f18a118..a57f043 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -561,6 +561,10 @@ do_next () {
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
1.7.0.2.407.g21ebda

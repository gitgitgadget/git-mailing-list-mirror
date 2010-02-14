From: Thomas Rast <trast@student.ethz.ch>
Subject: [RFC PATCH 4/6] rebase: invoke post-rewrite hook
Date: Sun, 14 Feb 2010 17:17:09 +0100
Message-ID: <8493a921273c327c9da61d1e0ce887ce5e45dd5a.1266164150.git.trast@student.ethz.ch>
References: <cover.1266164150.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johan Herland <johan@herland.net>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 14 17:17:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NghAO-0003W2-Ae
	for gcvg-git-2@lo.gmane.org; Sun, 14 Feb 2010 17:17:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751784Ab0BNQRg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Feb 2010 11:17:36 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:1994 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751702Ab0BNQRf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2010 11:17:35 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.234.1; Sun, 14 Feb
 2010 17:17:33 +0100
Received: from localhost.localdomain (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Sun, 14 Feb
 2010 17:17:12 +0100
X-Mailer: git-send-email 1.7.0.216.g74d8e
In-Reply-To: <cover.1266164150.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139920>

We have to deal with two separate code paths: a normal rebase, which
actually goes through git-am; and rebase {-m|-s}.

The only small issue with both is that they need to remember the
original sha1 across a possible conflict resolution.  rebase -m
already puts this information in $dotest/current, and we just
introduce a similar file for git-am.

Note that in git-am, the hook really only runs when coming from
git-rebase: the code path that sets the $dotest/original-commit file
is guarded by a test for $dotest/rebasing.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 git-am.sh                    |   10 ++++++++++
 git-rebase.sh                |    5 +++++
 t/t5407-post-rewrite-hook.sh |   30 ++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 3c08d53..56428b4 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -575,6 +575,7 @@ do
 			echo "Patch is empty.  Was it split wrong?"
 			stop_here $this
 		}
+		rm -f "$dotest/original-commit"
 		if test -f "$dotest/rebasing" &&
 			commit=$(sed -e 's/^From \([0-9a-f]*\) .*/\1/' \
 				-e q "$dotest/$msgnum") &&
@@ -582,6 +583,7 @@ do
 		then
 			git cat-file commit "$commit" |
 			sed -e '1,/^$/d' >"$dotest/msg-clean"
+			echo "$commit" > "$dotest/original-commit"
 		else
 			{
 				sed -n '/^Subject/ s/Subject: //p' "$dotest/info"
@@ -768,6 +770,10 @@ do
 	git update-ref -m "$GIT_REFLOG_ACTION: $FIRSTLINE" HEAD $commit $parent ||
 	stop_here $this
 
+	if test -f "$dotest/original-commit"; then
+		echo "$(cat "$dotest/original-commit") $commit" >> "$dotest/rewritten"
+	fi
+
 	if test -x "$GIT_DIR"/hooks/post-applypatch
 	then
 		"$GIT_DIR"/hooks/post-applypatch
@@ -776,6 +782,10 @@ do
 	go_next
 done
 
+if test -s "$dotest"/rewritten && test -x "$GIT_DIR"/hooks/post-rewrite; then
+	"$GIT_DIR"/hooks/post-rewrite rebase < "$dotest"/rewritten
+fi
+
 git gc --auto
 
 rm -fr "$dotest"
diff --git a/git-rebase.sh b/git-rebase.sh
index fb4fef7..52f8b9b 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -79,6 +79,7 @@ continue_merge () {
 		then
 			printf "Committed: %0${prec}d " $msgnum
 		fi
+		echo "$cmt $(git rev-parse HEAD^0)" >> "$dotest/rewritten"
 	else
 		if test -z "$GIT_QUIET"
 		then
@@ -151,6 +152,10 @@ move_to_original_branch () {
 
 finish_rb_merge () {
 	move_to_original_branch
+	if test -x "$GIT_DIR"/hooks/post-rewrite &&
+		test -s "$dotest"/rewritten; then
+		"$GIT_DIR"/hooks/post-rewrite rebase < "$dotest"/rewritten
+	fi
 	rm -r "$dotest"
 	say All done.
 }
diff --git a/t/t5407-post-rewrite-hook.sh b/t/t5407-post-rewrite-hook.sh
index ff23ebf..d6438a7 100755
--- a/t/t5407-post-rewrite-hook.sh
+++ b/t/t5407-post-rewrite-hook.sh
@@ -69,4 +69,34 @@ test_expect_success 'git filter-branch (no-op)' '
 	test ! -f post-rewrite.data
 '
 
+test_expect_success 'git rebase' '
+	git reset --hard D &&
+	clear_hook_input &&
+	test_must_fail git rebase --onto A B &&
+	echo C > foo &&
+	git add foo &&
+	git rebase --continue &&
+	echo rebase >expected.args &&
+	cat >expected.data <<EOF &&
+$(git rev-parse C) $(git rev-parse HEAD^)
+$(git rev-parse D) $(git rev-parse HEAD)
+EOF
+	verify_hook_input
+'
+
+test_expect_success 'git rebase --skip' '
+	git reset --hard D &&
+	clear_hook_input &&
+	test_must_fail git rebase --onto A B &&
+	test_must_fail git rebase --skip &&
+	echo D > foo &&
+	git add foo &&
+	git rebase --continue &&
+	echo rebase >expected.args &&
+	cat >expected.data <<EOF &&
+$(git rev-parse D) $(git rev-parse HEAD)
+EOF
+	verify_hook_input
+'
+
 test_done
-- 
1.7.0.216.g74d8e

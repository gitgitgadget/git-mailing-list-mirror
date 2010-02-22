From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v4 05/11] rebase: invoke post-rewrite hook
Date: Mon, 22 Feb 2010 01:10:18 +0100
Message-ID: <407d05a63f09aa006f8d1cd2fa4d1836e25dc9ac.1266797028.git.trast@student.ethz.ch>
References: <cover.1266797028.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Johan Herland <johan@herland.net>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 22 01:42:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjLtM-0000EH-W9
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 01:11:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753845Ab0BVAK5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2010 19:10:57 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:28109 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753796Ab0BVAK4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2010 19:10:56 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.234.1; Mon, 22 Feb
 2010 01:10:50 +0100
Received: from localhost.localdomain (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Mon, 22 Feb
 2010 01:10:31 +0100
X-Mailer: git-send-email 1.7.0.147.g5aeb9
In-Reply-To: <cover.1266797028.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140624>

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

Unchanged from v3

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
index 1020af9..1ecaa4b 100755
--- a/t/t5407-post-rewrite-hook.sh
+++ b/t/t5407-post-rewrite-hook.sh
@@ -49,4 +49,34 @@ test_expect_success 'git commit --amend --no-post-rewrite' '
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
1.7.0.147.g5aeb9

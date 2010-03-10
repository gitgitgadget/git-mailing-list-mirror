From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v6 05/13] rebase: invoke post-rewrite hook
Date: Wed, 10 Mar 2010 15:05:52 +0100
Message-ID: <f0eb9f46d10ccbc3926666fd613bcdc5c7ca9b3c.1268229087.git.trast@student.ethz.ch>
References: <cover.1268229087.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j6t@kdbg.org>, Johan Herland <johan@herland.net>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 10 15:07:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpMYn-0004t1-Oj
	for gcvg-git-2@lo.gmane.org; Wed, 10 Mar 2010 15:06:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932389Ab0CJOGN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Mar 2010 09:06:13 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:7926 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932381Ab0CJOGK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Mar 2010 09:06:10 -0500
Received: from CAS02.d.ethz.ch (129.132.178.236) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.234.1; Wed, 10 Mar
 2010 15:06:04 +0100
Received: from localhost.localdomain (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Wed, 10 Mar
 2010 15:06:00 +0100
X-Mailer: git-send-email 1.7.0.2.407.g21ebda
In-Reply-To: <cover.1268229087.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141902>

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
index 50a292a..9b73e0b 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -593,6 +593,7 @@ do
 			echo "Patch is empty.  Was it split wrong?"
 			stop_here $this
 		}
+		rm -f "$dotest/original-commit"
 		if test -f "$dotest/rebasing" &&
 			commit=$(sed -e 's/^From \([0-9a-f]*\) .*/\1/' \
 				-e q "$dotest/$msgnum") &&
@@ -600,6 +601,7 @@ do
 		then
 			git cat-file commit "$commit" |
 			sed -e '1,/^$/d' >"$dotest/msg-clean"
+			echo "$commit" > "$dotest/original-commit"
 		else
 			{
 				sed -n '/^Subject/ s/Subject: //p' "$dotest/info"
@@ -783,6 +785,10 @@ do
 	git update-ref -m "$GIT_REFLOG_ACTION: $FIRSTLINE" HEAD $commit $parent ||
 	stop_here $this
 
+	if test -f "$dotest/original-commit"; then
+		echo "$(cat "$dotest/original-commit") $commit" >> "$dotest/rewritten"
+	fi
+
 	if test -x "$GIT_DIR"/hooks/post-applypatch
 	then
 		"$GIT_DIR"/hooks/post-applypatch
@@ -791,5 +797,9 @@ do
 	go_next
 done
 
+if test -s "$dotest"/rewritten && test -x "$GIT_DIR"/hooks/post-rewrite; then
+	"$GIT_DIR"/hooks/post-rewrite rebase < "$dotest"/rewritten
+fi
+
 rm -fr "$dotest"
 git gc --auto
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
1.7.0.2.407.g21ebda

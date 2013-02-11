From: John Keeping <john@keeping.me.uk>
Subject: [PATCH v2] rebase -i: respect core.commentchar
Date: Mon, 11 Feb 2013 23:08:04 +0000
Message-ID: <20130211230804.GF2270@serenity.lan>
References: <aa1deab1de2e0f998b9ac0bc8c2d76557429a46b.1360610368.git.john@keeping.me.uk>
 <7vzjzali6a.fsf@alter.siamese.dyndns.org>
 <20130211213900.GE2270@serenity.lan>
 <7va9raldw8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ralf Thielow <ralf.thielow@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 12 00:08:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U52UI-00087c-HY
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 00:08:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759827Ab3BKXIP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 18:08:15 -0500
Received: from pichi.aluminati.org ([72.9.246.58]:47370 "EHLO
	pichi.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757110Ab3BKXIO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 18:08:14 -0500
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 77790161E384;
	Mon, 11 Feb 2013 23:08:13 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tGpm7AFVEFau; Mon, 11 Feb 2013 23:08:12 +0000 (GMT)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 1434C161E2CC;
	Mon, 11 Feb 2013 23:08:06 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <7va9raldw8.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216103>

Commit eff80a9 (Allow custom "comment char") introduced a custom comment
character for commit messages but did not teach git-rebase--interactive
to use it.

Change git-rebase--interactive to read core.commentchar and use its
value when generating commit messages and for the command list.

Signed-off-by: John Keeping <john@keeping.me.uk>

---
Changes since v1:
- use '\' as the comment character in tests
- use "git stripspace --strip-comments" where appropriate
- use "git stripspace --comment-lines" where appropriate
- use printf instead of echo when the string contains $comment_char
- quote $comment_char in case label

On Mon, Feb 11, 2013 at 01:49:27PM -0800, Junio C Hamano wrote:
> ...
> Perhaps
> 
> 	git stripspace --comment-lines <<EOF
>         ...
>         EOF
> 
> is a better option that that loop.

Yes.  I was confusing myself with out-of-date documentation.

---
 git-rebase--interactive.sh    | 88 ++++++++++++++++++++++---------------------
 t/t3404-rebase-interactive.sh | 16 ++++++++
 2 files changed, 62 insertions(+), 42 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 8ed7fcc..b5ce3f2 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -80,6 +80,9 @@ rewritten_pending="$state_dir"/rewritten-pending
 GIT_CHERRY_PICK_HELP="$resolvemsg"
 export GIT_CHERRY_PICK_HELP
 
+comment_char=$(git config --get core.commentchar 2>/dev/null | cut -c1)
+: ${comment_char:=#}
+
 warn () {
 	printf '%s\n' "$*" >&2
 }
@@ -105,8 +108,8 @@ mark_action_done () {
 	sed -e 1q < "$todo" >> "$done"
 	sed -e 1d < "$todo" >> "$todo".new
 	mv -f "$todo".new "$todo"
-	new_count=$(sane_grep -c '^[^#]' < "$done")
-	total=$(($new_count+$(sane_grep -c '^[^#]' < "$todo")))
+	new_count=$(git stripspace --strip-comments < "$done" | wc -l)
+	total=$(($new_count+$(git stripspace --strip-comments < "$todo" | wc -l)))
 	if test "$last_count" != "$new_count"
 	then
 		last_count=$new_count
@@ -116,19 +119,19 @@ mark_action_done () {
 }
 
 append_todo_help () {
-	cat >> "$todo" << EOF
-#
-# Commands:
-#  p, pick = use commit
-#  r, reword = use commit, but edit the commit message
-#  e, edit = use commit, but stop for amending
-#  s, squash = use commit, but meld into previous commit
-#  f, fixup = like "squash", but discard this commit's log message
-#  x, exec = run command (the rest of the line) using shell
-#
-# These lines can be re-ordered; they are executed from top to bottom.
-#
-# If you remove a line here THAT COMMIT WILL BE LOST.
+	git stripspace --comment-lines >>"$todo" <<EOF
+
+Commands:
+ p, pick = use commit
+ r, reword = use commit, but edit the commit message
+ e, edit = use commit, but stop for amending
+ s, squash = use commit, but meld into previous commit
+ f, fixup = like "squash", but discard this commit's log message
+ x, exec = run command (the rest of the line) using shell
+
+These lines can be re-ordered; they are executed from top to bottom.
+
+If you remove a line here THAT COMMIT WILL BE LOST.
 EOF
 }
 
@@ -179,7 +182,9 @@ die_abort () {
 }
 
 has_action () {
-	sane_grep '^[^#]' "$1" >/dev/null
+	echo "space stripped actions:" >&2
+	git stripspace --strip-comments <"$1" >&2
+	test -n "$(git stripspace --strip-comments <"$1")"
 }
 
 is_empty_commit() {
@@ -363,10 +368,10 @@ update_squash_messages () {
 	if test -f "$squash_msg"; then
 		mv "$squash_msg" "$squash_msg".bak || exit
 		count=$(($(sed -n \
-			-e "1s/^# This is a combination of \(.*\) commits\./\1/p" \
+			-e "1s/^. This is a combination of \(.*\) commits\./\1/p" \
 			-e "q" < "$squash_msg".bak)+1))
 		{
-			echo "# This is a combination of $count commits."
+			printf '%s\n' "$comment_char This is a combination of $count commits."
 			sed -e 1d -e '2,/^./{
 				/^$/d
 			}' <"$squash_msg".bak
@@ -375,8 +380,8 @@ update_squash_messages () {
 		commit_message HEAD > "$fixup_msg" || die "Cannot write $fixup_msg"
 		count=2
 		{
-			echo "# This is a combination of 2 commits."
-			echo "# The first commit's message is:"
+			printf '%s\n' "$comment_char This is a combination of 2 commits."
+			printf '%s\n' "$comment_char The first commit's message is:"
 			echo
 			cat "$fixup_msg"
 		} >"$squash_msg"
@@ -385,21 +390,22 @@ update_squash_messages () {
 	squash)
 		rm -f "$fixup_msg"
 		echo
-		echo "# This is the $(nth_string $count) commit message:"
+		printf '%s\n' "$comment_char This is the $(nth_string $count) commit message:"
 		echo
 		commit_message $2
 		;;
 	fixup)
 		echo
-		echo "# The $(nth_string $count) commit message will be skipped:"
+		printf '%s\n' "$comment_char The $(nth_string $count) commit message will be skipped:"
 		echo
-		commit_message $2 | sed -e 's/^/#	/'
+		# Change the space after the comment character to TAB:
+		commit_message $2 | git stripspace --comment-lines | sed -e 's/ /	/'
 		;;
 	esac >>"$squash_msg"
 }
 
 peek_next_command () {
-	sed -n -e "/^#/d" -e '/^$/d' -e "s/ .*//p" -e "q" < "$todo"
+	git stripspace --strip-comments <"$todo" | sed -n -e 's/ .*//p' -e q
 }
 
 # A squash/fixup has failed.  Prepare the long version of the squash
@@ -464,7 +470,7 @@ do_next () {
 	rm -f "$msg" "$author_script" "$amend" || exit
 	read -r command sha1 rest < "$todo"
 	case "$command" in
-	'#'*|''|noop)
+	"$comment_char"*|''|noop)
 		mark_action_done
 		;;
 	pick|p)
@@ -803,15 +809,15 @@ skip)
 	do_rest
 	;;
 edit-todo)
-	sed -e '/^#/d' < "$todo" > "$todo".new
+	git stripspace --strip-comments <"$todo" >"$todo".new
 	mv -f "$todo".new "$todo"
 	append_todo_help
-	cat >> "$todo" << EOF
-#
-# You are editing the todo file of an ongoing interactive rebase.
-# To continue rebase after editing, run:
-#     git rebase --continue
-#
+	git stripspace --comment-lines >>"$todo" <<EOF
+
+You are editing the todo file of an ongoing interactive rebase.
+To continue rebase after editing, run:
+    git rebase --continue
+
 EOF
 
 	git_sequence_editor "$todo" ||
@@ -881,7 +887,7 @@ do
 
 	if test -z "$keep_empty" && is_empty_commit $shortsha1 && ! is_merge_commit $shortsha1
 	then
-		comment_out="# "
+		comment_out="$comment_char "
 	else
 		comment_out=
 	fi
@@ -942,20 +948,18 @@ test -s "$todo" || echo noop >> "$todo"
 test -n "$autosquash" && rearrange_squash "$todo"
 test -n "$cmd" && add_exec_commands "$todo"
 
-cat >> "$todo" << EOF
-
-# Rebase $shortrevisions onto $shortonto
-EOF
+echo >>"$todo"
+printf '%s\n' "$comment_char Rebase $shortrevisions onto $shortonto" >>"$todo"
 append_todo_help
-cat >> "$todo" << EOF
-#
-# However, if you remove everything, the rebase will be aborted.
-#
+git stripspace --comment-lines >>"$todo" <<EOF
+
+However, if you remove everything, the rebase will be aborted.
+
 EOF
 
 if test -z "$keep_empty"
 then
-	echo "# Note that empty commits are commented out" >>"$todo"
+	printf '%s\n' "$comment_char Note that empty commits are commented out" >>"$todo"
 fi
 
 
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 8462be1..16d8160 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -934,4 +934,20 @@ test_expect_success 'rebase --edit-todo can be used to modify todo' '
 	test L = $(git cat-file commit HEAD | sed -ne \$p)
 '
 
+test_expect_success 'rebase -i respects core.commentchar' '
+	git reset --hard &&
+	git checkout E^0 &&
+	git config core.commentchar "\\" &&
+	test_when_finished "git config --unset core.commentchar" &&
+	cat >comment-lines.sh <<EOF &&
+#!$SHELL_PATH
+sed -e "2,\$ s/^/\\\\\\/" "\$1" >"\$1".tmp
+mv "\$1".tmp "\$1"
+EOF
+	chmod a+x comment-lines.sh &&
+	test_set_editor "$(pwd)/comment-lines.sh" &&
+	git rebase -i B &&
+	test B = $(git cat-file commit HEAD^ | sed -ne \$p)
+'
+
 test_done
-- 
1.8.1.3.556.gb3310b5.dirty

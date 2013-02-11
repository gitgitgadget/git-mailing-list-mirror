From: John Keeping <john@keeping.me.uk>
Subject: [PATCH] rebase -i: respect core.commentchar
Date: Mon, 11 Feb 2013 19:21:15 +0000
Message-ID: <aa1deab1de2e0f998b9ac0bc8c2d76557429a46b.1360610368.git.john@keeping.me.uk>
Cc: Ralf Thielow <ralf.thielow@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 11 20:29:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4z4G-00032J-U2
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 20:29:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759236Ab3BKT3I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 14:29:08 -0500
Received: from pichi.aluminati.org ([72.9.246.58]:48135 "EHLO
	pichi.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759126Ab3BKT3G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 14:29:06 -0500
X-Greylist: delayed 462 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 Feb 2013 14:29:06 EST
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 7B650161E480;
	Mon, 11 Feb 2013 19:21:22 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XyHOI5wQsDSD; Mon, 11 Feb 2013 19:21:20 +0000 (GMT)
Received: from river.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 3173C161E2AE;
	Mon, 11 Feb 2013 19:21:15 +0000 (GMT)
X-Mailer: git-send-email 1.8.1.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216079>

Commit eff80a9 (Allow custom "comment char") introduced a custom comment
character for commit messages but did not teach git-rebase--interactive
to use it.

Change git-rebase--interactive to read core.commentchar and use its
value when generating commit messages and for the todo list.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 git-rebase--interactive.sh    | 85 ++++++++++++++++++++++---------------------
 t/t3404-rebase-interactive.sh | 16 ++++++++
 2 files changed, 60 insertions(+), 41 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 8ed7fcc..8a37bc1 100644
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
+	new_count=$(sane_grep -c "^[^${comment_char}]" < "$done")
+	total=$(($new_count+$(sane_grep -c "^[^${comment_char}]" < "$todo")))
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
+	sed -e "s/^/$comment_char /" >>"$todo" <<EOF
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
 
@@ -179,7 +182,7 @@ die_abort () {
 }
 
 has_action () {
-	sane_grep '^[^#]' "$1" >/dev/null
+	sane_grep "^[^${comment_char}]" "$1" >/dev/null
 }
 
 is_empty_commit() {
@@ -363,10 +366,10 @@ update_squash_messages () {
 	if test -f "$squash_msg"; then
 		mv "$squash_msg" "$squash_msg".bak || exit
 		count=$(($(sed -n \
-			-e "1s/^# This is a combination of \(.*\) commits\./\1/p" \
+			-e "1s/^. This is a combination of \(.*\) commits\./\1/p" \
 			-e "q" < "$squash_msg".bak)+1))
 		{
-			echo "# This is a combination of $count commits."
+			echo "$comment_char This is a combination of $count commits."
 			sed -e 1d -e '2,/^./{
 				/^$/d
 			}' <"$squash_msg".bak
@@ -375,8 +378,8 @@ update_squash_messages () {
 		commit_message HEAD > "$fixup_msg" || die "Cannot write $fixup_msg"
 		count=2
 		{
-			echo "# This is a combination of 2 commits."
-			echo "# The first commit's message is:"
+			echo "$comment_char This is a combination of 2 commits."
+			echo "$comment_char The first commit's message is:"
 			echo
 			cat "$fixup_msg"
 		} >"$squash_msg"
@@ -385,21 +388,21 @@ update_squash_messages () {
 	squash)
 		rm -f "$fixup_msg"
 		echo
-		echo "# This is the $(nth_string $count) commit message:"
+		echo "$comment_char This is the $(nth_string $count) commit message:"
 		echo
 		commit_message $2
 		;;
 	fixup)
 		echo
-		echo "# The $(nth_string $count) commit message will be skipped:"
+		echo "$comment_char The $(nth_string $count) commit message will be skipped:"
 		echo
-		commit_message $2 | sed -e 's/^/#	/'
+		commit_message $2 | sed -e "s/^/$comment_char	/"
 		;;
 	esac >>"$squash_msg"
 }
 
 peek_next_command () {
-	sed -n -e "/^#/d" -e '/^$/d' -e "s/ .*//p" -e "q" < "$todo"
+	sed -n -e "/^$comment_char/d" -e '/^$/d' -e "s/ .*//p" -e "q" < "$todo"
 }
 
 # A squash/fixup has failed.  Prepare the long version of the squash
@@ -464,7 +467,7 @@ do_next () {
 	rm -f "$msg" "$author_script" "$amend" || exit
 	read -r command sha1 rest < "$todo"
 	case "$command" in
-	'#'*|''|noop)
+	$comment_char*|''|noop)
 		mark_action_done
 		;;
 	pick|p)
@@ -803,15 +806,15 @@ skip)
 	do_rest
 	;;
 edit-todo)
-	sed -e '/^#/d' < "$todo" > "$todo".new
+	sed -e "/^$comment_char/d" < "$todo" > "$todo".new
 	mv -f "$todo".new "$todo"
 	append_todo_help
-	cat >> "$todo" << EOF
-#
-# You are editing the todo file of an ongoing interactive rebase.
-# To continue rebase after editing, run:
-#     git rebase --continue
-#
+	sed -e "s/^/$comment_char /" >>"$todo" <<EOF
+
+You are editing the todo file of an ongoing interactive rebase.
+To continue rebase after editing, run:
+    git rebase --continue
+
 EOF
 
 	git_sequence_editor "$todo" ||
@@ -881,7 +884,7 @@ do
 
 	if test -z "$keep_empty" && is_empty_commit $shortsha1 && ! is_merge_commit $shortsha1
 	then
-		comment_out="# "
+		comment_out="$comment_char "
 	else
 		comment_out=
 	fi
@@ -942,20 +945,20 @@ test -s "$todo" || echo noop >> "$todo"
 test -n "$autosquash" && rearrange_squash "$todo"
 test -n "$cmd" && add_exec_commands "$todo"
 
-cat >> "$todo" << EOF
-
-# Rebase $shortrevisions onto $shortonto
+echo >>"$todo"
+sed -e "s/^/$comment_char /" >> "$todo" << EOF
+Rebase $shortrevisions onto $shortonto
 EOF
 append_todo_help
-cat >> "$todo" << EOF
-#
-# However, if you remove everything, the rebase will be aborted.
-#
+sed -e "s/^/$comment_char /" >> "$todo" << EOF
+
+However, if you remove everything, the rebase will be aborted.
+
 EOF
 
 if test -z "$keep_empty"
 then
-	echo "# Note that empty commits are commented out" >>"$todo"
+	echo "$comment_char Note that empty commits are commented out" >>"$todo"
 fi
 
 
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 8462be1..1043cdc 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -934,4 +934,20 @@ test_expect_success 'rebase --edit-todo can be used to modify todo' '
 	test L = $(git cat-file commit HEAD | sed -ne \$p)
 '
 
+test_expect_success 'rebase -i respects core.commentchar' '
+	git reset --hard &&
+	git checkout E^0 &&
+	git config core.commentchar \; &&
+	test_when_finished "git config --unset core.commentchar" &&
+	cat >comment-lines.sh <<EOF &&
+#!$SHELL_PATH
+sed -e "2,\$ s/^/;/" "\$1" >"\$1".tmp
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
1.8.1.2

From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 3/3] Add a command "fix" to rebase --interactive.
Date: Fri,  4 Dec 2009 15:36:30 +0100
Message-ID: <6d779d2c244bf5d5b7924cdc5daf66a8186e4bc7.1259934977.git.mhagger@alum.mit.edu>
References: <cover.1259934977.git.mhagger@alum.mit.edu>
Cc: gitster@pobox.com, Johannes.Schindelin@gmx.de,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 04 15:37:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGZHb-0005sB-OR
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 15:37:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754856AbZLDOg6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 09:36:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754836AbZLDOg6
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 09:36:58 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:45778 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752170AbZLDOg5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2009 09:36:57 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from localhost.localdomain (ssh.berlin.jpk.com [212.222.128.135])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id nB4EafCg020736;
	Fri, 4 Dec 2009 15:36:59 +0100
X-Mailer: git-send-email 1.6.5.4
In-Reply-To: <cover.1259934977.git.mhagger@alum.mit.edu>
In-Reply-To: <cover.1259934977.git.mhagger@alum.mit.edu>
References: <cover.1259934977.git.mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134512>

The command is like "squash", except that it discards the commit message
of the corresponding commit.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/git-rebase.txt  |   13 ++++++++-----
 git-rebase--interactive.sh    |   39 +++++++++++++++++++++++++++++----------
 t/lib-rebase.sh               |    7 ++++---
 t/t3404-rebase-interactive.sh |   30 ++++++++++++++++++++++++++++++
 4 files changed, 71 insertions(+), 18 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index ca5e1e8..eafab57 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -382,9 +382,12 @@ If you just want to edit the commit message for a commit, replace the
 command "pick" with the command "reword".
 
 If you want to fold two or more commits into one, replace the command
-"pick" with "squash" for the second and subsequent commit.  If the
-commits had different authors, it will attribute the squashed commit to
-the author of the first commit.
+"pick" for the second and subsequent commits with "squash" or "fix".
+If the commits had different authors, the folded commit will be
+attributed to the author of the first commit.  The suggested commit
+message for the folded commit is the concatenation of the commit
+messages of the first commit and of those with the "squash" command,
+but omits the commit messages of commits with the "fix" command.
 
 'git-rebase' will stop when "pick" has been replaced with "edit" or
 when a command fails due to merge errors. When you are done editing
@@ -512,8 +515,8 @@ Easy case: The changes are literally the same.::
 Hard case: The changes are not the same.::
 
 	This happens if the 'subsystem' rebase had conflicts, or used
-	`\--interactive` to omit, edit, or squash commits; or if the
-	upstream used one of `commit \--amend`, `reset`, or
+	`\--interactive` to omit, edit, squash, or fix commits; or if
+	the upstream used one of `commit \--amend`, `reset`, or
 	`filter-branch`.
 
 
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 0bd3bf7..539413d 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -302,7 +302,7 @@ nth_string () {
 
 make_squash_message () {
 	if test -f "$SQUASH_MSG"; then
-		COUNT=$(($(sed -n "s/^# This is [^0-9]*\([1-9][0-9]*\).*/\1/p" \
+		COUNT=$(($(sed -n "s/^# Th[^0-9]*\([1-9][0-9]*\)\(th\|st\|nd\|rd\) commit message.*:/\1/p" \
 			< "$SQUASH_MSG" | sed -ne '$p')+1))
 		echo "# This is a combination of $COUNT commits."
 		sed -e 1d -e '2,/^./{
@@ -315,10 +315,20 @@ make_squash_message () {
 		echo
 		git cat-file commit HEAD | sed -e '1,/^$/d'
 	fi
-	echo
-	echo "# This is the $(nth_string $COUNT) commit message:"
-	echo
-	git cat-file commit $1 | sed -e '1,/^$/d'
+	case $1 in
+	squash)
+		echo
+		echo "# This is the $(nth_string $COUNT) commit message:"
+		echo
+		git cat-file commit $2 | sed -e '1,/^$/d'
+		;;
+	fix)
+		echo
+		echo "# The $(nth_string $COUNT) commit message will be skipped:"
+		echo
+		git cat-file commit $2 | sed -e '1,/^$/d' -e 's/^/#/'
+		;;
+	esac
 }
 
 peek_next_command () {
@@ -367,20 +377,28 @@ do_next () {
 		warn
 		exit 0
 		;;
-	squash|s)
-		comment_for_reflog squash
+	squash|s|fix|f)
+		case "$command" in
+		squash|s)
+			squash_style=squash
+			;;
+		fix|f)
+			squash_style=fix
+			;;
+		esac
+		comment_for_reflog $squash_style
 
 		test -f "$DONE" && has_action "$DONE" ||
-			die "Cannot 'squash' without a previous commit"
+			die "Cannot '$squash_style' without a previous commit"
 
 		mark_action_done
-		make_squash_message $sha1 > "$MSG"
+		make_squash_message $squash_style $sha1 > "$MSG"
 		failed=f
 		author_script=$(get_author_ident_from_commit HEAD)
 		output git reset --soft HEAD^
 		pick_one -n $sha1 || failed=t
 		case "$(peek_next_command)" in
-		squash|s)
+		squash|s|fix|f)
 			USE_OUTPUT=output
 			MSG_OPT=-F
 			EDIT_OR_FILE="$MSG"
@@ -768,6 +786,7 @@ first and then run 'git rebase --continue' again."
 #  r, reword = use commit, but edit the commit message
 #  e, edit = use commit, but stop for amending
 #  s, squash = use commit, but meld into previous commit
+#  f, fix = like "squash", but discard this commit's log message
 #
 # If you remove a line here THAT COMMIT WILL BE LOST.
 # However, if you remove everything, the rebase will be aborted.
diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
index 62f452c..8b42f23 100644
--- a/t/lib-rebase.sh
+++ b/t/lib-rebase.sh
@@ -9,8 +9,9 @@
 #
 #	"[<lineno1>] [<lineno2>]..."
 #
-#   If a line number is prefixed with "squash", "edit", or "reword", the
-#   respective line's command will be replaced with the specified one.
+#   If a line number is prefixed with "squash", "fix", "edit", or
+#   "reword", the respective line's command will be replaced with the
+#   specified one.
 
 set_fake_editor () {
 	echo "#!$SHELL_PATH" >fake-editor.sh
@@ -32,7 +33,7 @@ cat "$1".tmp
 action=pick
 for line in $FAKE_LINES; do
 	case $line in
-	squash|edit|reword)
+	squash|fix|edit|reword)
 		action="$line";;
 	*)
 		echo sed -n "${line}s/^pick/$action/p"
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 236d698..27645c4 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -264,6 +264,36 @@ test_expect_success 'multi-squash only fires up editor once' '
 	test 1 = $(git show | grep ONCE | wc -l)
 '
 
+test_expect_success 'multi-fix only fires up editor once' '
+	git checkout -b multi-fix E &&
+	base=$(git rev-parse HEAD~4) &&
+	FAKE_COMMIT_AMEND="ONCE" FAKE_LINES="1 fix 2 fix 3 fix 4" \
+		git rebase -i $base &&
+	test $base = $(git rev-parse HEAD^) &&
+	test 1 = $(git show | grep ONCE | wc -l) &&
+	git checkout to-be-rebased &&
+	git branch -D multi-fix
+'
+
+cat > expect-squash-fix << EOF
+B
+
+D
+
+ONCE
+EOF
+
+test_expect_success 'squash and fix generate correct log messages' '
+	git checkout -b squash-fix E &&
+	base=$(git rev-parse HEAD~4) &&
+	FAKE_COMMIT_AMEND="ONCE" FAKE_LINES="1 fix 2 squash 3 fix 4" \
+		git rebase -i $base &&
+	git cat-file commit HEAD | sed -e 1,/^\$/d > actual-squash-fix &&
+	test_cmp expect-squash-fix actual-squash-fix &&
+	git checkout to-be-rebased &&
+	git branch -D squash-fix
+'
+
 test_expect_success 'squash works as expected' '
 	for n in one two three four
 	do
-- 
1.6.5.4

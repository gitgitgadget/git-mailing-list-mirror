From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/2] Teach rebase an interactive mode
Date: Sun, 24 Jun 2007 00:01:51 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706240001150.4059@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jun 24 01:02:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2EcK-0005cv-Dv
	for gcvg-git@gmane.org; Sun, 24 Jun 2007 01:02:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752110AbXFWXCG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Jun 2007 19:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751964AbXFWXCE
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jun 2007 19:02:04 -0400
Received: from mail.gmx.net ([213.165.64.20]:37423 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751646AbXFWXCB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jun 2007 19:02:01 -0400
Received: (qmail invoked by alias); 23 Jun 2007 23:01:59 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp053) with SMTP; 24 Jun 2007 01:01:59 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19ZtNptsnJZhPgsEhBOPW7pwWjqTiEQIS7BTJPGfY
	kToNV5aoEe4KFU
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50757>


With "--interactive", git-rebase now lets you edit the list of patches
to be reapplied, so that you can reorder and/or delete patches.

Such a list will typically look like this:

	pick deadbee The oneline of this commit
	pick fa1afe1 The oneline of the next commit
	...

By replacing the command "pick" with the command "edit", you can amend
that patch and/or its commit message, and by replacing it with "squash"
you can tell rebase to fold that patch into the patch before that.

It is derived from the script sent to the list in
<Pine.LNX.4.63.0702252156190.22628@wbgn013.biozentrum.uni-wuerzburg.de>

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-rebase.txt  |   51 ++++++-
 Makefile                      |    2 +-
 git-rebase--interactive.sh    |  336 +++++++++++++++++++++++++++++++++++++++++
 git-rebase.sh                 |   12 ++-
 t/t3404-rebase-interactive.sh |  163 ++++++++++++++++++++
 5 files changed, 559 insertions(+), 5 deletions(-)
 create mode 100755 git-rebase--interactive.sh
 create mode 100755 t/t3404-rebase-interactive.sh

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 0c00090..2e474e8 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -8,7 +8,8 @@ git-rebase - Forward-port local commits to the updated upstream head
 SYNOPSIS
 --------
 [verse]
-'git-rebase' [-v] [--merge] [-C<n>] [--onto <newbase>] <upstream> [<branch>]
+'git-rebase' [-i | --interactive] [-v | --verbose] [--merge] [-C<n>]
+	[--onto <newbase>] <upstream> [<branch>]
 'git-rebase' --continue | --skip | --abort
 
 DESCRIPTION
@@ -208,6 +209,10 @@ OPTIONS
 	context exist they all must match.  By default no context is
 	ever ignored.
 
+-i, \--interactive::
+	Make a list of the commits which are about to be rebased.  Let the
+	user edit that list before rebasing.
+
 include::merge-strategies.txt[]
 
 NOTES
@@ -226,9 +231,49 @@ pre-rebase hook script for an example.
 You must be in the top directory of your project to start (or continue)
 a rebase.  Upon completion, <branch> will be the current branch.
 
-Author
+Interactive mode
+----------------
+
+Rebasing interactively means that you have a chance to edit the commits
+which are rebased.  You can not only reorder the commits, but also
+remove them (weeding out bad or otherwise unwanted patches).
+
+The list will look like this:
+
+-------------------------------------------
+pick deadbee The oneline of this commit
+pick fa1afe1 The oneline of the next commit
+...
+-------------------------------------------
+
+The oneline descriptions are purely for your pleasure; `git-rebase` will
+not look at them but at the commit names, so do not delete or edit the
+names.
+
+By replacing the command "pick" with the command "edit", you can tell
+`git-rebase` to stop after applying that commit, so that you can edit
+the files and/or the commit message, amend the commit and continue
+rebasing.
+
+If you want to fold two commits into one, just replace the command "pick"
+with "squash" for the second commit.  After squashing the commits,
+`git-rebase` will start an editor with both commit messages, so you
+can compose the commit message for the squashed commit.
+
+A common use case for the interactive mode is when you want to reorder
+the last 5 commits, such that what was HEAD~4 becomes the new HEAD. To
+achieve that, you would call `git-rebase` like this:
+
+----------------------
+$ git rebase -i HEAD~5
+----------------------
+
+And move the first patch to the end of the list.
+
+Authors
 ------
-Written by Junio C Hamano <junkio@cox.net>
+Written by Junio C Hamano <junkio@cox.net> and
+Johannes E. Schindelin <johannes.schindelin@gmx.de>
 
 Documentation
 --------------
diff --git a/Makefile b/Makefile
index 0d904a9..edb421b 100644
--- a/Makefile
+++ b/Makefile
@@ -204,7 +204,7 @@ SCRIPT_SH = \
 	git-fetch.sh \
 	git-ls-remote.sh \
 	git-merge-one-file.sh git-mergetool.sh git-parse-remote.sh \
-	git-pull.sh git-rebase.sh \
+	git-pull.sh git-rebase.sh git-rebase--interactive.sh \
 	git-repack.sh git-request-pull.sh git-reset.sh \
 	git-sh-setup.sh \
 	git-tag.sh git-verify-tag.sh \
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
new file mode 100755
index 0000000..6a960b4
--- /dev/null
+++ b/git-rebase--interactive.sh
@@ -0,0 +1,336 @@
+#!/bin/sh
+#
+# Copyright (c) 2006 Johannes E. Schindelin
+
+# SHORT DESCRIPTION
+#
+# This script makes it easy to fix up commits in the middle of a series,
+# and rearrange commits.
+#
+# The original idea comes from Eric W. Biederman, in
+# http://article.gmane.org/gmane.comp.version-control.git/22407
+#
+# MOTIVATION
+#
+# Consider this type of workflow:
+#
+#	1. have a wonderful idea
+#	2. hack on the code
+#	3. prepare a series for submission
+#	4. submit
+#
+# where the point (2) consists of several instances of
+#
+#	A.1. finish something worthy of a commit
+#	A.2. commit
+#
+# and/or
+#
+#	B.1. realize that something does not work
+#	B.2. fix that
+#	B.3. commit it
+#
+# Sometimes the thing fixed in B.2. cannot be amended to the not-quite
+# perfect commit it fixes, because that commit is buried deeply in a
+# patch series.
+#
+# Use this script after plenty of "A"s and "B"s, by rearranging, and
+# possibly editing and merging commits.
+#
+# USAGE:
+#
+# Start it with the last commit you want to retain as-is:
+#
+#	git rebase -i <after-this-commit>
+#
+# An editor will be fired up with all the commits in your current branch
+# (ignoring merge commits), which come after the given commit.  You can
+# reorder the commits in this list to your heart's content, and you can
+# even remove them.  The list looks more or less like this:
+#
+#	pick deadbee The oneline of this commit
+#	pick fa1afe1 The oneline of the next commit
+#	...
+#
+# By replacing the command "pick" with "edit" you can tell
+# this script to stop the loop so you can fix up the commit by editing
+# files and/or the commit message.
+#
+# When replacing the command "pick" with "squash", the script will squash
+# this commit's changes into the commit which comes right before it, munge
+# the commit messages of both, and open the commit message editor.  If the
+# commits had different authors, it will attribute the squashed commit to
+# the author of the last commit.
+#
+# In both cases, or when a "pick" does not succeed (because of merge
+# errors), the loop will stop to let you fix things, and you can continue
+# the loop with `git rebase --continue`.
+
+USAGE='(--continue | --abort | --skip | [--onto <branch>] <upstream> [<branch>])'
+
+. git-sh-setup
+require_work_tree
+
+DOTEST="$GIT_DIR/.dotest-merge"
+TODO="$DOTEST"/todo
+DONE="$DOTEST"/done
+STRATEGY=
+VERBOSE=
+
+warn () {
+	echo "$@" >&2
+}
+
+require_clean_work_tree () {
+	# test if working tree is dirty
+	git rev-parse --verify HEAD > /dev/null &&
+	git update-index --refresh &&
+	test -z "`git diff-files --name-only`" &&
+	test -z "`git diff-index --cached --name-only HEAD`" ||
+	die "Working tree is dirty"
+}
+
+ORIG_REFLOG_ACTION="$GIT_REFLOG_ACTION"
+
+comment_for_reflog () {
+	if test -z "$ORIG_REFLOG_ACTION"; then
+		GIT_REFLOG_ACTION="rebase --interactive ($1)"
+		export GIT_REFLOG_ACTION
+	fi
+}
+
+mark_action_done () {
+	sed -n 1p < "$TODO" >> "$DONE"
+	sed -n '2,$p' < "$TODO" >> "$TODO".new
+	mv -f "$TODO".new "$TODO"
+}
+
+make_patch () {
+	parent_sha1=$(git rev-parse --verify "$1"^ 2> /dev/null)
+	git diff "$parent_sha1".."$1" > "$DOTEST"/patch
+}
+
+die_with_patch () {
+	make_patch "$1"
+	die "$2"
+}
+
+pick_one () {
+	case "$1" in -n) sha1=$2 ;; *) sha1=$1 ;; esac
+	parent_sha1=$(git rev-parse --verify $sha1^ 2>/dev/null)
+	current_sha1=$(git rev-parse --verify HEAD)
+	if [ $current_sha1 = $parent_sha1 ]; then
+		git reset --hard $sha1
+		sha1=$(git rev-parse --short $sha1)
+		warn Fast forward to $sha1
+	else
+		git cherry-pick $STRATEGY "$@"
+	fi
+}
+
+do_next () {
+	read command sha1 rest < "$TODO"
+	case "$command" in
+	\#)
+		mark_action_done
+		continue
+	;;
+	pick)
+		comment_for_reflog pick
+
+		mark_action_done
+		pick_one $sha1 ||
+			die_with_patch $sha1 "Could not apply $sha1... $rest"
+	;;
+	edit)
+		comment_for_reflog edit
+
+		mark_action_done
+		pick_one $sha1 ||
+			die_with_patch $sha1 "Could not apply $sha1... $rest"
+		make_patch $sha1
+		warn
+		warn "You can amend the commit now, with"
+		warn
+		warn "	git commit --amend"
+		warn
+		exit 0
+	;;
+	squash)
+		comment_for_reflog squash
+
+		test -s "$DONE" ||
+			die "Cannot 'squash' without a previous commit"
+
+		mark_action_done
+		failed=f
+		pick_one -n $sha1 || failed=t
+		MSG="$DOTEST"/message
+		echo "# This is a combination of two commits." > "$MSG"
+		echo "# The first commit's message is:" >> "$MSG"
+		git cat-file commit HEAD | sed -n '/^$/,$p' >> "$MSG"
+		echo >> "$MSG"
+		echo "# And this is the 2nd commit message:" >> "$MSG"
+		echo >> "$MSG"
+		git cat-file commit $sha1 | sed -n '/^$/,$p' >> "$MSG"
+		git reset --soft HEAD^
+		author_script=$(get_author_ident_from_commit $sha1)
+		case $failed in
+		f)
+			# This is like --amend, but with a different message
+			eval $author_script
+			export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_AUTHOR_DATE
+			git commit -F "$MSG" -e
+		;;
+		t)
+			cp "$MSG" "$GIT_DIR"/MERGE_MSG
+			warn
+			warn "Could not apply $sha1... $rest"
+			warn "After you fixed that, commit the result with"
+			warn
+			warn "  $(echo $author_script | tr '\012' ' ') \\"
+			warn "	  git commit -F \"$GIT_DIR\"/MERGE_MSG -e"
+			die_with_patch $sha1 ""
+		esac
+	;;
+	*)
+		warn "Unknown command: $command $sha1 $rest"
+		die_with_patch $sha1 "Please fix this in the file $TODO."
+	esac
+	test -s "$TODO" && continue
+
+	HEAD=$(git rev-parse HEAD)
+	HEADNAME=$(cat "$DOTEST"/head-name)
+	git update-ref $HEADNAME $HEAD &&
+	git symbolic-ref HEAD $HEADNAME || exit
+	rm -rf "$DOTEST" &&
+	warn "Successfully rebased and updated $HEADNAME."
+
+	exit $?
+}
+
+do_rest () {
+	while :
+	do
+		do_next
+	done
+	test $? = 0 -a -f "$DOTEST"/verbose &&
+		git diff --stat $(cat "$DOTEST"/head)..HEAD
+	exit
+}
+
+while case "$#" in 0) break ;; esac
+do
+	case "$1" in
+	--continue)
+		comment_for_reflog continue
+
+		test -d "$DOTEST" || die "No interactive rebase running"
+
+		require_clean_work_tree
+		do_rest
+	;;
+	--abort)
+		comment_for_reflog abort
+
+		test -d "$DOTEST" || die "No interactive rebase running"
+
+		HEADNAME=$(cat "$DOTEST"/head-name)
+		HEAD=$(cat "$DOTEST"/head)
+		git symbolic-ref HEAD $HEADNAME &&
+		git reset --hard $HEAD &&
+		rm -rf "$DOTEST"
+		exit
+	;;
+	--skip)
+		comment_for_reflog skip
+
+		test -d "$DOTEST" || die "No interactive rebase running"
+
+		git reset --hard && do_rest
+	;;
+	-s|--strategy)
+		case "$#,$1" in
+		*,*=*)
+			STRATEGY="-s `expr "z$1" : 'z-[^=]*=\(.*\)'`" ;;
+		1,*)
+			usage ;;
+		*)
+			STRATEGY="-s $2"
+			shift ;;
+		esac
+	;;
+	--merge)
+		# we use merge anyway
+	;;
+	-C*)
+		die "Interactive rebase uses merge, so $1 does not make sense"
+	;;
+	-v)
+		VERBOSE=t
+	;;
+	-i|--interactive)
+		# yeah, we know
+	;;
+	''|-h)
+		usage
+	;;
+	*)
+		test -d "$DOTEST" &&
+			die "Interactive rebase already started"
+
+		git var GIT_COMMITTER_IDENT >/dev/null ||
+			die "You need to set your committer info first"
+
+		comment_for_reflog start
+
+		ONTO=
+		case "$1" in
+		--onto)
+			ONTO=$(git rev-parse --verify "$2") ||
+				die "Does not point to a valid commit: $2"
+			shift; shift
+			;;
+		esac
+
+		require_clean_work_tree
+
+		test -z "$2" || git checkout "$2" ||
+			die "Could not checkout $2"
+
+		HEAD=$(git rev-parse --verify HEAD) || die "No HEAD?"
+		UPSTREAM=$(git rev-parse --verify "$1") || die "Invalid base"
+
+		test -z "$ONTO" && ONTO=$UPSTREAM
+
+		mkdir "$DOTEST" || die "Could not create temporary $DOTEST"
+		: > "$DOTEST"/interactive || die "Could not mark as interactive"
+		git symbolic-ref HEAD > "$DOTEST"/head-name ||
+			die "Could not get HEAD"
+
+		echo $HEAD > "$DOTEST"/head
+		echo $UPSTREAM > "$DOTEST"/upstream
+		echo $ONTO > "$DOTEST"/onto
+		test t = "$VERBOSE" && : > "$DOTEST"/verbose
+
+		cat > "$TODO" << EOF
+# Reorder by exchanging lines.  Skip by removing lines.  If you want to
+# edit a commit, replace the "pick" command with "edit".  If you want to
+# squash the changes of a commit A into a commit B, place A directly
+# after B, and replace the "pick" command with "squash".
+EOF
+		git rev-list --no-merges --pretty=oneline --abbrev-commit \
+			--abbrev=7 --reverse $UPSTREAM..$HEAD | \
+			sed "s/^/pick /" >> "$TODO"
+
+		test -s "$TODO" || die "Nothing to do"
+
+		cp "$TODO" "$TODO".backup
+		${VISUAL:-${EDITOR:-vi}} "$TODO" ||
+			die "Could not execute editor"
+
+		git reset --hard $ONTO && do_rest
+	;;
+	esac
+	shift
+done
diff --git a/git-rebase.sh b/git-rebase.sh
index 2aa3a01..9e25158 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -3,7 +3,7 @@
 # Copyright (c) 2005 Junio C Hamano.
 #
 
-USAGE='[-v] [--onto <newbase>] <upstream> [<branch>]'
+USAGE='[--interactive | -i] [-v] [--onto <newbase>] <upstream> [<branch>]'
 LONG_USAGE='git-rebase replaces <branch> with a new branch of the
 same name.  When the --onto option is provided the new branch starts
 out with a HEAD equal to <newbase>, otherwise it is equal to <upstream>
@@ -120,6 +120,16 @@ finish_rb_merge () {
 	echo "All done."
 }
 
+is_interactive () {
+	test -f "$dotest"/interactive ||
+	while case "$1" in ''|-i|--interactive) break ;; esac
+	do
+		shift
+	done && test -n "$1"
+}
+
+is_interactive "$@" && exec git-rebase--interactive "$@"
+
 while case "$#" in 0) break ;; esac
 do
 	case "$1" in
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
new file mode 100755
index 0000000..48aa8ea
--- /dev/null
+++ b/t/t3404-rebase-interactive.sh
@@ -0,0 +1,163 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Johannes E. Schindelin
+#
+
+test_description='git rebase interactive
+
+This test runs git rebase "interactively", by faking an edit, and verifies
+that the result still makes sense.
+'
+. ./test-lib.sh
+
+# set up two branches like this:
+#
+# A - B - C - D - E
+#   \
+#     F - G - H
+#       \
+#         I
+#
+# where B, D and G touch the same file.
+
+test_expect_success 'setup' '
+	: > file1 &&
+	git add file1 &&
+	test_tick &&
+	git commit -m A &&
+	git tag A &&
+	echo 1 > file1 &&
+	test_tick &&
+	git commit -m B file1 &&
+	: > file2 &&
+	git add file2 &&
+	test_tick &&
+	git commit -m C &&
+	echo 2 > file1 &&
+	test_tick &&
+	git commit -m D file1 &&
+	: > file3 &&
+	git add file3 &&
+	test_tick &&
+	git commit -m E &&
+	git checkout -b branch1 A &&
+	: > file4 &&
+	git add file4 &&
+	test_tick &&
+	git commit -m F &&
+	git tag F &&
+	echo 3 > file1 &&
+	test_tick &&
+	git commit -m G file1 &&
+	: > file5 &&
+	git add file5 &&
+	test_tick &&
+	git commit -m H &&
+	git checkout -b branch2 F &&
+	: > file6 &&
+	git add file6 &&
+	test_tick &&
+	git commit -m I &&
+	git tag I
+'
+
+cat > fake-editor.sh << EOF
+#!/bin/sh
+test "\$1" = .git/COMMIT_EDITMSG && exit
+test -z "\$FAKE_LINES" && exit
+grep -v "^#" < "\$1" > "\$1".tmp
+rm "\$1"
+cat "\$1".tmp
+action=pick
+for line in \$FAKE_LINES; do
+	case \$line in
+	squash)
+		action="\$line";;
+	*)
+		echo sed -n "\${line}s/^pick/\$action/p"
+		sed -n "\${line}p" < "\$1".tmp
+		sed -n "\${line}s/^pick/\$action/p" < "\$1".tmp >> "\$1"
+		action=pick;;
+	esac
+done
+EOF
+
+chmod a+x fake-editor.sh
+VISUAL="$(pwd)/fake-editor.sh"
+export VISUAL
+
+test_expect_success 'no changes are a nop' '
+	git rebase -i F &&
+	test $(git rev-parse I) = $(git rev-parse HEAD)
+'
+
+test_expect_success 'rebase on top of a non-conflicting commit' '
+	git checkout branch1 &&
+	git tag original-branch1 &&
+	git rebase -i branch2 &&
+	test file6 = $(git diff --name-only original-branch1) &&
+	test $(git rev-parse I) = $(git rev-parse HEAD~2)
+'
+
+test_expect_success 'exchange two commits' '
+	FAKE_LINES="2 1" git rebase -i HEAD~2 &&
+	test H = $(git cat-file commit HEAD^ | tail -n 1) &&
+	test G = $(git cat-file commit HEAD | tail -n 1)
+'
+
+cat > expect << EOF
+diff --git a/file1 b/file1
+index e69de29..00750ed 100644
+--- a/file1
++++ b/file1
+@@ -0,0 +1 @@
++3
+EOF
+
+cat > expect2 << EOF
+<<<<<<< HEAD:file1
+2
+=======
+3
+>>>>>>> b7ca976... G:file1
+EOF
+
+test_expect_success 'stop on conflicting pick' '
+	git tag new-branch1 &&
+	! git rebase -i master &&
+	diff -u expect .git/.dotest-merge/patch &&
+	diff -u expect2 file1 &&
+	test 4 = $(grep -v "^#" < .git/.dotest-merge/done | wc -l) &&
+	test 0 = $(grep -v "^#" < .git/.dotest-merge/todo | wc -l)
+'
+
+test_expect_success 'abort' '
+	git rebase --abort &&
+	test $(git rev-parse new-branch1) = $(git rev-parse HEAD) &&
+	! test -d .git/.dotest-merge
+'
+
+test_expect_success 'retain authorship' '
+	echo A > file7 &&
+	git add file7 &&
+	GIT_AUTHOR_NAME="Twerp Snog" git commit -m "different author" &&
+	git tag twerp &&
+	git rebase -i --onto master HEAD^ &&
+	git show HEAD | grep "^Author: Twerp Snog"
+'
+
+test_expect_success 'squash' '
+	git reset --hard twerp &&
+	echo B > file7 &&
+	GIT_AUTHOR_NAME="Nitfol" git commit -m "nitfol" file7 &&
+	echo "******************************" &&
+	FAKE_LINES="1 squash 2" git rebase -i --onto master HEAD~2 &&
+	test B = $(cat file7) &&
+	test $(git rev-parse HEAD^) = $(git rev-parse master)
+'
+
+test_expect_success 'retain authorship when squashing' '
+	git show HEAD | grep "^Author: Nitfol"
+'
+
+test_done
-- 
1.5.2.2.279.g74fb3

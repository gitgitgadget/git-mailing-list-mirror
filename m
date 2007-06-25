From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 3/3] Teach rebase -i about --preserve-merges
Date: Mon, 25 Jun 2007 18:59:43 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706251859270.4059@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jun 25 19:59:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2sqz-0000iv-Ju
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 19:59:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282AbXFYR74 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jun 2007 13:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751984AbXFYR74
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 13:59:56 -0400
Received: from mail.gmx.net ([213.165.64.20]:33153 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751071AbXFYR7z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2007 13:59:55 -0400
Received: (qmail invoked by alias); 25 Jun 2007 17:59:53 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp058) with SMTP; 25 Jun 2007 19:59:53 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18j/hoKDFojRn+7E2IGXV3L6YLG2XqaBe2dtcZW5/
	YoB/8it/4PwJGh
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50911>


The option "-p" (or long "--preserve-merges") makes it possible to
rebase side branches including merges, without straightening the
history.

Example:

           X
            \
         A---M---B
        /
---o---O---P---Q

When the current HEAD is "B", "git rebase -i -p --onto Q O" will yield

               X
                 \
---o---O---P---Q---A'---M'---B'

Note that this will

- _not_ touch X [*1*], it does

- _not_ work without the --interactive flag [*2*], it does

- _not_ guess the type of the merge, but blindly uses recursive or
  whatever strategy you provided with "-s <strategy>" for all merges it
  has to redo, and it does

- _not_ make use of the original merge commit via git-rerere.

*1*: only commits which reach a merge base between <upstream> and HEAD
     are reapplied. The others are kept as-are.

*2*: git-rebase without --interactive is inherently patch based (at
     least at the moment), and therefore merges cannot be preserved.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	This (especially the part about passing the message to git merge,
	you know, correctly quoted and stuff) could use a couple of
	eyeball pairs.

 Documentation/git-rebase.txt  |   23 ++++++++-
 git-rebase--interactive.sh    |  110 +++++++++++++++++++++++++++++++++++++++-
 t/t3404-rebase-interactive.sh |   22 ++++++++
 3 files changed, 151 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 2e3363a..96907d4 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git-rebase' [-i | --interactive] [-v | --verbose] [--merge] [-C<n>]
-	[--onto <newbase>] <upstream> [<branch>]
+	[-p | --preserve-merges] [--onto <newbase>] <upstream> [<branch>]
 'git-rebase' --continue | --skip | --abort
 
 DESCRIPTION
@@ -213,6 +213,10 @@ OPTIONS
 	Make a list of the commits which are about to be rebased.  Let the
 	user edit that list before rebasing.
 
+-p, \--preserve-merges::
+	Instead of ignoring merges, try to recreate them.  This option
+	only works in interactive mode.
+
 include::merge-strategies.txt[]
 
 NOTES
@@ -304,6 +308,23 @@ $ git rebase -i HEAD~5
 
 And move the first patch to the end of the list.
 
+You might want to preserve merges, if you have a history like this:
+
+------------------
+           X
+            \
+         A---M---B
+        /
+---o---O---P---Q
+------------------
+
+Suppose you want to rebase the side branch starting at "A" to "Q". Make
+sure that the current HEAD is "B", and call
+
+-----------------------------
+$ git rebase -i -p --onto Q O
+-----------------------------
+
 Authors
 ------
 Written by Junio C Hamano <junkio@cox.net> and
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index fb93e13..73cbcde 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -10,7 +10,8 @@
 # The original idea comes from Eric W. Biederman, in
 # http://article.gmane.org/gmane.comp.version-control.git/22407
 
-USAGE='(--continue | --abort | --skip | [--onto <branch>] <upstream> [<branch>])'
+USAGE='(--continue | --abort | --skip | [--preserve-merges] [--verbose]
+	[--onto <branch>] <upstream> [<branch>])'
 
 . git-sh-setup
 require_work_tree
@@ -18,6 +19,8 @@ require_work_tree
 DOTEST="$GIT_DIR/.dotest-merge"
 TODO="$DOTEST"/todo
 DONE="$DOTEST"/done
+REWRITTEN="$DOTEST"/rewritten
+PRESERVE_MERGES=
 STRATEGY=
 VERBOSE=
 
@@ -68,6 +71,8 @@ die_abort () {
 pick_one () {
 	case "$1" in -n) sha1=$2 ;; *) sha1=$1 ;; esac
 	git rev-parse --verify $sha1 || die "Invalid commit name: $sha1"
+	test -d "$REWRITTEN" &&
+		pick_one_preserving_merges "$@" && return
 	parent_sha1=$(git rev-parse --verify $sha1^ 2>/dev/null)
 	current_sha1=$(git rev-parse --verify HEAD)
 	if [ $current_sha1 = $parent_sha1 ]; then
@@ -79,6 +84,75 @@ pick_one () {
 	fi
 }
 
+pick_one_preserving_merges () {
+	case "$1" in -n) sha1=$2 ;; *) sha1=$1 ;; esac
+	sha1=$(git rev-parse $sha1)
+
+	if [ -f "$DOTEST"/current-commit ]
+	then
+		current_commit=$(cat "$DOTEST"/current-commit) &&
+		git rev-parse HEAD > "$REWRITTEN"/$current_commit &&
+		rm "$DOTEST"/current-commit ||
+		die "Cannot write current commit's replacement sha1"
+	fi
+
+	# rewrite parents; if none were rewritten, we can fast-forward.
+	fast_forward=t
+	preserve=t
+	new_parents=
+	for p in $(git rev-list --parents -1 $sha1 | cut -d\  -f2-)
+	do
+		if [ -f "$REWRITTEN"/$p ]
+		then
+			preserve=f
+			new_p=$(cat "$REWRITTEN"/$p)
+			test $p != $new_p && fast_forward=f
+			case "$new_parents" in
+			*$new_p*)
+				;; # do nothing; that parent is already there
+			*)
+				new_parents="$new_parents $new_p"
+			esac
+		fi
+	done
+	case $fast_forward in
+	t)
+		echo "Fast forward to $sha1"
+		test $preserve=f && echo $sha1 > "$REWRITTEN"/$sha1
+		;;
+	f)
+		test "a$1" = a-n && die "Refusing to squash a merge: $sha1"
+
+		first_parent=$(expr "$new_parents" : " \([^ ]*\)")
+		# detach HEAD to current parent
+		git checkout $first_parent 2> /dev/null ||
+			die "Cannot move HEAD to $first_parent"
+
+		echo $sha1 > "$DOTEST"/current-commit
+		case "$new_parents" in
+		\ *\ *)
+			# redo merge
+			author_script=$(get_author_ident_from_commit $sha1)
+			eval "$author_script"
+			msg="$(git cat-file commit $sha1 | \
+				sed -e '1,/^$/d' -e "s/[\"\\]/\\\\&/g")"
+			# NEEDSWORK: give rerere a chance
+			if ! git merge $STRATEGY -m "$msg" $new_parents
+			then
+				echo "$msg" > "$GIT_DIR"/MERGE_MSG
+				warn Error redoing merge $sha1
+				warn
+				warn After fixup, please use
+				die "$author_script git commit"
+			fi
+			;;
+		*)
+			git cherry-pick $STRATEGY "$@" ||
+				die_with_patch $sha1 "Could not pick $sha1"
+		esac
+	esac
+}
+
 do_next () {
 	read command sha1 rest < "$TODO"
 	case "$command" in
@@ -155,7 +229,15 @@ do_next () {
 	HEADNAME=$(cat "$DOTEST"/head-name) &&
 	OLDHEAD=$(cat "$DOTEST"/head) &&
 	SHORTONTO=$(git rev-parse --short $(cat "$DOTEST"/onto)) &&
-	NEWHEAD=$(git rev-parse HEAD) &&
+	if [ -d "$REWRITTEN" ]
+	then
+		test -f "$DOTEST"/current-commit &&
+			current_commit=$(cat "$DOTEST"/current-commit) &&
+			git rev-parse HEAD > "$REWRITTEN"/$current_commit
+		NEWHEAD=$(cat "$REWRITTEN"/$OLDHEAD)
+	else
+		NEWHEAD=$(git rev-parse HEAD)
+	fi &&
 	message="$GIT_REFLOG_ACTION: $HEADNAME onto $SHORTONTO)" &&
 	git update-ref -m "$message" $HEADNAME $NEWHEAD $OLDHEAD &&
 	git symbolic-ref HEAD $HEADNAME &&
@@ -226,6 +308,9 @@ do
 	-v|--verbose)
 		VERBOSE=t
 		;;
+	-p|--preserve-merges)
+		PRESERVE_MERGES=t
+		;;
 	-i|--interactive)
 		# yeah, we know
 		;;
@@ -274,6 +359,25 @@ do
 		echo $UPSTREAM > "$DOTEST"/upstream
 		echo $ONTO > "$DOTEST"/onto
 		test t = "$VERBOSE" && : > "$DOTEST"/verbose
+		if [ t = "$PRESERVE_MERGES" ]
+		then
+			# $REWRITTEN contains files for each commit that is
+			# reachable by at least one merge base of $HEAD and
+			# $UPSTREAM. They are not necessarily rewritten, but
+			# their children might be.
+			# This ensures that commits on merged, but otherwise
+			# unrelated side branches are left alone. (Think "X"
+			# in the man page's example.)
+			mkdir "$REWRITTEN" &&
+			for c in $(git merge-base --all $HEAD $UPSTREAM)
+			do
+				echo $ONTO > "$REWRITTEN"/$c ||
+					die "Could not init rewritten commits"
+			done
+			MERGES_OPTION=
+		else
+			MERGES_OPTION=--no-merges
+		fi
 
 		SHORTUPSTREAM=$(git rev-parse --short $UPSTREAM)
 		SHORTHEAD=$(git rev-parse --short $HEAD)
@@ -286,7 +390,7 @@ do
 #  edit = use commit, but stop for amending
 #  squash = use commit, but meld into previous commit
 EOF
-		git rev-list --no-merges --pretty=oneline --abbrev-commit \
+		git rev-list $MERGES_OPTION --pretty=oneline --abbrev-commit \
 			--abbrev=7 --reverse $UPSTREAM..$HEAD | \
 			sed "s/^/pick /" >> "$TODO"
 
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 9f12bb9..883cf29 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -166,4 +166,26 @@ test_expect_success 'retain authorship when squashing' '
 	git show HEAD | grep "^Author: Nitfol"
 '
 
+test_expect_success 'preserve merges with -p' '
+	git checkout -b to-be-preserved master^ &&
+	: > unrelated-file &&
+	git add unrelated-file &&
+	test_tick &&
+	git commit -m "unrelated" &&
+	git checkout -b to-be-rebased master &&
+	echo B > file1 &&
+	test_tick &&
+	git commit -m J file1 &&
+	test_tick &&
+	git merge to-be-preserved &&
+	echo C > file1 &&
+	test_tick &&
+	git commit -m K file1 &&
+	git rebase -i -p --onto branch1 master &&
+	test $(git rev-parse HEAD^^2) = $(git rev-parse to-be-preserved) &&
+	test $(git rev-parse HEAD~3) = $(git rev-parse branch1) &&
+	test $(git show HEAD:file1) = C &&
+	test $(git show HEAD~2:file1) = B
+'
+
 test_done
-- 
1.5.2.2.3172.ge55a1-dirty

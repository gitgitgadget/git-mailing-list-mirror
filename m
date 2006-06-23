From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git-merge --squash
Date: Fri, 23 Jun 2006 01:50:17 -0700
Message-ID: <7virmscl2u.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Jun 23 10:50:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FthN2-00040n-HT
	for gcvg-git@gmane.org; Fri, 23 Jun 2006 10:50:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbWFWIuU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Jun 2006 04:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbWFWIuU
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jun 2006 04:50:20 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:11688 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751249AbWFWIuS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jun 2006 04:50:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060623085017.VJBK12581.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 23 Jun 2006 04:50:17 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22401>

Some people tend to do many little commits on a topic branch,
recording all the trials and errors, and when the topic is
reasonably cooked well, would want to record the net effect of
the series as one commit on top of the mainline, removing the
cruft from the history.  The topic is then abandoned or forked
off again from that point at the mainline.

The barebone porcelainish that comes with core git tools does
not officially support such operation, but you can fake it by
using "git pull --no-merge" when such a topic branch is not a
strict superset of the mainline, like this:

	git checkout mainline
	git pull --no-commit . that-topic-branch
	: fix conflicts if any
	rm -f .git/MERGE_HEAD
        git commit -a -m 'consolidated commit log message'
	git branch -f that-topic-branch ;# now fully merged

This however does not work when the topic branch is a fast
forward of the mainline, because normal "git pull" will never
create a merge commit in such a case, and there is nothing
special --no-commit could do to begin with.

This patch introduces a new option, --squash, to support such a
workflow officially in both fast-forward case and true merge
case.  The user-level operation would be the same in both cases:

	git checkout mainline
        git pull --squash . that-topic-branch
        : fix conflicts if any -- naturally, there would be
        : no conflict if fast forward.
	git commit -a -m  'consolidated commit log message'
	git branch -f that-topic-branch ;# now fully merged

When the current branch is already up-to-date with respect to
the other branch, there truly is nothing to do, so the new
option does not have any effect.

This was brought up in #git IRC channel recently.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * This is something I am unlikely to use myself, since
   "squashing into one" is too coarse grained for the commits I
   usually make myself.

   If one's habit is to use a sequence of many commits to keep
   too-finer-grained snapshots, and the result of a squash
   commit out of such a sequence of commits is a coherent,
   self-contained unit, then I do not see any reason to
   discourage that workflow.  I however suspect that people who
   make such a sequence of "many too-finer-grained commits"
   would inevitably include changes that do not belong together
   in in one sequence on a topic branch and end up squashing
   them together into one resulting commit.  If that is the
   case, this facility is actively encouraging a bad workflow
   and we should instead teach them to use StGIT or something
   saner.

   But somebody asked on #git channel, so here is the rope.

 Documentation/merge-options.txt |    8 ++++
 git-commit.sh                   |    7 +++-
 git-merge.sh                    |   72 +++++++++++++++++++++++++++++----------
 git-pull.sh                     |    7 +++-
 git-reset.sh                    |    2 +
 5 files changed, 72 insertions(+), 24 deletions(-)

diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index 53cc355..182cef5 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -6,6 +6,14 @@
 	not autocommit, to give the user a chance to inspect and
 	further tweak the merge result before committing.
 
+--squash::
+	Produce the working tree and index state as if a real
+	merge happened, but do not actually make a commit or
+	move the `HEAD`, nor record `$GIT_DIR/MERGE_HEAD` to
+	cause the next `git commit` command to create a merge
+	commit.  This allows you to create a single commit on
+	top of the current branch whose effect is the same as
+	merging another branch (or more in case of an octopus).
 
 -s <strategy>, \--strategy=<strategy>::
 	Use the given merge strategy; can be supplied more than
diff --git a/git-commit.sh b/git-commit.sh
index 6dd04fd..cd7358e 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -564,6 +564,9 @@ then
 elif test -f "$GIT_DIR/MERGE_HEAD" && test -f "$GIT_DIR/MERGE_MSG"
 then
 	cat "$GIT_DIR/MERGE_MSG"
+elif test -f "$GIT_DIR/SQUASH_MSG"
+then
+	cat "$GIT_DIR/SQUASH_MSG"
 fi | git-stripspace >"$GIT_DIR"/COMMIT_EDITMSG
 
 case "$signoff" in
@@ -661,7 +664,7 @@ else
 fi
 if [ "$?" != "0" -a ! -f "$GIT_DIR/MERGE_HEAD" -a -z "$amend" ]
 then
-	rm -f "$GIT_DIR/COMMIT_EDITMSG"
+	rm -f "$GIT_DIR/COMMIT_EDITMSG" "$GIT_DIR/SQUASH_MSG"
 	run_status
 	exit 1
 fi
@@ -727,7 +730,7 @@ else
 	false
 fi
 ret="$?"
-rm -f "$GIT_DIR/COMMIT_MSG" "$GIT_DIR/COMMIT_EDITMSG"
+rm -f "$GIT_DIR/COMMIT_MSG" "$GIT_DIR/COMMIT_EDITMSG" "$GIT_DIR/SQUASH_MSG"
 if test -d "$GIT_DIR/rr-cache"
 then
 	git-rerere
diff --git a/git-merge.sh b/git-merge.sh
index af1f25b..e6db610 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -3,8 +3,7 @@ #
 # Copyright (c) 2005 Junio C Hamano
 #
 
-
-USAGE='[-n] [--no-commit] [-s <strategy>]... <merge-message> <head> <remote>+'
+USAGE='[-n] [--no-commit] [--squash] [-s <strategy>]... <merge-message> <head> <remote>+'
 . git-sh-setup
 
 LF='
@@ -42,20 +41,49 @@ restorestate() {
 	fi
 }
 
+finish_up_to_date () {
+	case "$squash" in
+	t)
+		echo "$1 (nothing to squash)" ;;
+	'')
+		echo "$1" ;;
+	esac
+	dropsave
+}
+
+squash_message () {
+	echo Squashed commit of the following:
+	echo
+	git-log --no-merges ^"$head" $remote
+}
+
 finish () {
 	test '' = "$2" || echo "$2"
-	case "$merge_msg" in
-	'')
-		echo "No merge message -- not updating HEAD"
+	case "$squash" in
+	t)
+		echo "Squash commit -- not updating HEAD"
+		squash_message >"$GIT_DIR/SQUASH_MSG"
 		;;
-	*)
-		git-update-ref HEAD "$1" "$head" || exit 1
+	'')
+		case "$merge_msg" in
+		'')
+			echo "No merge message -- not updating HEAD"
+			;;
+		*)
+			git-update-ref HEAD "$1" "$head" || exit 1
+			;;
+		esac
 		;;
 	esac
-
-	case "$no_summary" in
+	case "$1" in
 	'')
-		git-diff-tree -p --stat --summary -M "$head" "$1"
+		;;
+	?*)
+		case "$no_summary" in
+		'')
+			git-diff-tree -p --stat --summary -M "$head" "$1"
+			;;
+		esac
 		;;
 	esac
 }
@@ -66,6 +94,8 @@ do
 	-n|--n|--no|--no-|--no-s|--no-su|--no-sum|--no-summ|\
 		--no-summa|--no-summar|--no-summary)
 		no_summary=t ;;
+	--sq|--squ|--squa|--squas|--squash)
+		squash=t no_commit=t ;;
 	--no-c|--no-co|--no-com|--no-comm|--no-commi|--no-commit)
 		no_commit=t ;;
 	-s=*|--s=*|--st=*|--str=*|--stra=*|--strat=*|--strate=*|\
@@ -152,8 +182,7 @@ f,*)
 ?,1,"$1",*)
 	# If head can reach all the merge then we are up to date.
 	# but first the most common case of merging one remote.
-	echo "Already up-to-date."
-	dropsave
+	finish_up_to_date "Already up-to-date."
 	exit 0
 	;;
 ?,1,"$head",*)
@@ -205,8 +234,7 @@ f,*)
 	done
 	if test "$up_to_date" = t
 	then
-		echo "Already up-to-date. Yeeah!"
-		dropsave
+		finish_up_to_date "Already up-to-date. Yeeah!"
 		exit 0
 	fi
 	;;
@@ -310,11 +338,17 @@ case "$best_strategy" in
 	git-merge-$best_strategy $common -- "$head_arg" "$@"
 	;;
 esac
-for remote
-do
-	echo $remote
-done >"$GIT_DIR/MERGE_HEAD"
-echo "$merge_msg" >"$GIT_DIR/MERGE_MSG"
+
+if test "$squash" = t
+then
+	finish
+else
+	for remote
+	do
+		echo $remote
+	done >"$GIT_DIR/MERGE_HEAD"
+	echo "$merge_msg" >"$GIT_DIR/MERGE_MSG"
+fi
 
 if test "$merge_was_ok" = t
 then
diff --git a/git-pull.sh b/git-pull.sh
index 4611ae6..1670da1 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -8,7 +8,7 @@ USAGE='[-n | --no-summary] [--no-commit]
 LONG_USAGE='Fetch one or more remote refs and merge it/them into the current HEAD.'
 . git-sh-setup
 
-strategy_args= no_summary= no_commit=
+strategy_args= no_summary= no_commit= squash=
 while case "$#,$1" in 0) break ;; *,-*) ;; *) break ;; esac
 do
 	case "$1" in
@@ -17,6 +17,8 @@ do
 		no_summary=-n ;;
 	--no-c|--no-co|--no-com|--no-comm|--no-commi|--no-commit)
 		no_commit=--no-commit ;;
+	--sq|--squ|--squa|--squas|--squash)
+		squash=--squash ;;
 	-s=*|--s=*|--st=*|--str=*|--stra=*|--strat=*|--strate=*|\
 		--strateg=*|--strategy=*|\
 	-s|--s|--st|--str|--stra|--strat|--strate|--strateg|--strategy)
@@ -100,4 +102,5 @@ case "$strategy_args" in
 esac
 
 merge_name=$(git-fmt-merge-msg <"$GIT_DIR/FETCH_HEAD")
-git-merge $no_summary $no_commit $strategy_args "$merge_name" HEAD $merge_head
+git-merge $no_summary $no_commit $squash $strategy_args \
+	"$merge_name" HEAD $merge_head
diff --git a/git-reset.sh b/git-reset.sh
index 296f3b7..46451d0 100755
--- a/git-reset.sh
+++ b/git-reset.sh
@@ -61,4 +61,4 @@ case "$reset_type" in
 	;;
 esac
 
-rm -f "$GIT_DIR/MERGE_HEAD" "$GIT_DIR/rr-cache/MERGE_RR"
+rm -f "$GIT_DIR/MERGE_HEAD" "$GIT_DIR/rr-cache/MERGE_RR" "$GIT_DIR/SQUASH_MSG"
-- 
1.4.1.rc1.g1f33

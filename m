From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/2] A new merge algorithm, take 3
Date: Thu, 08 Sep 2005 13:54:49 -0700
Message-ID: <7v4q8vuvom.fsf@assigned-by-dhcp.cox.net>
References: <20050907164734.GA20198@c165.ib.student.liu.se>
	<7v1x407min.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 08 22:55:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EDTQ6-0003Ea-Mc
	for gcvg-git@gmane.org; Thu, 08 Sep 2005 22:54:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964997AbVIHUyv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Sep 2005 16:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751398AbVIHUyv
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Sep 2005 16:54:51 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:10436 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751396AbVIHUyv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Sep 2005 16:54:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050908205451.GQNE17436.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 8 Sep 2005 16:54:51 -0400
To: Fredrik Kuivinen <freku045@student.liu.se>
In-Reply-To: <7v1x407min.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 07 Sep 2005 11:36:48 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8216>

Junio C Hamano <junkio@cox.net> writes:

> ... I'd like to leave what
> merge strategy to use as an user option, and leave the door open
> for other merge strategies to emerge later.  I know Pasky wants
> to look into pcdv merge and other alternatives.
>
> This is still off-the-top-of-my-head, but the top-level merge
> entry point for the end user would be just:
>
>     git merge <head> <remote> <merge-message>
>
> and by default 'git-merge-script' (sorry, I am taking over the
> name of your script for this 'generic driver for underlying
> merge strategy scripts') would do something like:

And here is "an illustration of concept" patch, requesting for
comments.  It probably is buggy as h*ll, but I am showing
interfaces early, hoping this is something people can agree on
to use to plug various merge strategies into.

The patch uses 'git-show-branches --merge-base' as an improved
'git-merge-base -a' that can do more than two heads, which still
only exists in my development repository, but I hope you get the
idea.

------------
Subject: [PATCH] Multi-backend merge driver.

This is just an illustration of concept patch.

The new command 'git merge' takes the current head and one or more
remote heads, with the commit log message for the automated case.

If the heads being merged are simple fast-forwards, it acts the
same way as the current 'git resolve'.  Otherwise, it tries
different merge strategies and takes the result from the one that
succeeded auto-merging, if there is any.

If no merge strategy succeeds auto-merging, their results are
evaluated for number of paths needed for hand resolving, and the
one with the least number of such paths is left in the working
tree.  The user is asked to resolve them by hand and make a
commit manually.

The calling convention from the 'git merge' driver to merge
strategy programs is very simple:

 - A strategy program is to be called 'git-merge-<strategy>'.

 - They take input of this form:

	<common1> <common2> ... '--' <head> <remote1> <remote2>...

   That is, one or more the common ancestors, double dash, the
   current head, and one or more remote heads being merged into
   the current branch.

 - Before a strategy program is called, the working tree is
   matched to the current <head>.

 - The strategy program exits with status code 0 when it
   successfully auto-merges the given heads.  It should do
   update-cache for all the merged paths when it does so -- the
   index file will be used to record the merge result as a
   commit by the driver.

 - The strategy program exits with status code 1 when it leaves
   conflicts behind.  It should do update-cache for all the
   merged paths that it successfully auto-merged, and leave the
   cache entry in the index file as the same as <head> for paths
   it could not auto-merge, and leave its best-effort result
   with conflict markers in the working tree when it does so.

 - The strategy program exists with status code other than 0 or
   1 if it does not handle the given merge at all.

As examples, this commit comes with merge strategies based on
'git resolve' and 'git octopus'.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 git-commit.sh        |    2 
 git-merge-octopus.sh |   86 +++++++++++++++++++++
 git-merge-resolve.sh |   80 ++++++++++++++++++++
 git-merge.sh         |  205 ++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 372 insertions(+), 1 deletions(-)
 create mode 100755 git-merge-octopus.sh
 create mode 100755 git-merge-resolve.sh
 create mode 100755 git-merge.sh

a65a614ce7f67c3ed4dee3bed3ab4d86d3f79577
diff --git a/git-commit.sh b/git-commit.sh
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -158,7 +158,7 @@ if [ ! -r "$GIT_DIR/HEAD" ]; then
 	PARENTS=""
 else
 	if [ -f "$GIT_DIR/MERGE_HEAD" ]; then
-		PARENTS="-p HEAD -p MERGE_HEAD"
+		PARENTS="-p HEAD "`sed -e 's/^/-p /' "$GIT_DIR/MERGE_HEAD"`
 	fi
 	if test "$use_commit" != ""
 	then
diff --git a/git-merge-octopus.sh b/git-merge-octopus.sh
new file mode 100755
--- /dev/null
+++ b/git-merge-octopus.sh
@@ -0,0 +1,86 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Junio C Hamano
+#
+# Resolve two or more trees.
+#
+
+# The first parameters up to -- are merge bases; the rest are heads.
+bases= head= remotes= sep_seen=
+for arg
+do
+	case ",$sep_seen,$head,$arg," in
+	*,--,)
+		sep_seen=yes
+		;;
+	,yes,,*)
+		head=$arg
+		;;
+	,yes,*)
+		remotes="$remotes$arg "
+		;;
+	*)
+		bases="$bases$arg "
+		;;
+	esac
+done
+
+# Reject if this is not an Octopus -- resolve should be used instead.
+case "$remotes" in
+?*' '?*)
+	;;
+*)
+	exit 2 ;;
+esac
+
+# MRC is the current "merge reference commit"
+# MRT is the current "merge result tree"
+
+MRC=$head MSG= PARENT="-p $head"
+MRT=$(git-write-tree)
+CNT=1 ;# counting our head
+NON_FF_MERGE=0
+for SHA1 in $remotes
+do
+	common=$(git-merge-base $MRC $SHA1) ||
+		die "Unable to find common commit with $SHA1"
+
+	if test "$common" = $SHA1
+	then
+		echo "Already up-to-date with $SHA1"
+		continue
+	fi
+
+	CNT=`expr $CNT + 1`
+	PARENT="$PARENT -p $SHA1"
+
+	if test "$common,$NON_FF_MERGE" = "$MRC,0"
+	then
+		# The first head being merged was a fast-forward.
+		# Advance MRC to the head being merged, and use that
+		# tree as the intermediate result of the merge.
+		# We still need to count this as part of the parent set.
+
+		echo "Fast forwarding to: $SHA1"
+		git-read-tree -u -m $head $SHA1 || exit
+		MRC=$SHA1 MRT=$(git-write-tree)
+		continue
+	fi
+
+	NON_FF_MERGE=1
+
+	echo "Trying simple merge with $SHA1"
+	git-read-tree -u -m $common $MRT $SHA1 || exit 2
+	next=$(git-write-tree 2>/dev/null)
+	if test $? -ne 0
+	then
+		echo "Simple merge did not work, trying automatic merge."
+		git-merge-index -o git-merge-one-file -a ||
+		exit 2 ; # Automatic merge failed; should not be doing Octopus
+		next=$(git-write-tree 2>/dev/null)
+	fi
+	MRC=$common
+	MRT=$next
+done
+
+exit 0
diff --git a/git-merge-resolve.sh b/git-merge-resolve.sh
new file mode 100755
--- /dev/null
+++ b/git-merge-resolve.sh
@@ -0,0 +1,80 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Linus Torvalds
+#
+# Resolve two trees.
+
+# The first parameters up to -- are merge bases; the rest are heads.
+bases= head= remotes= sep_seen=
+for arg
+do
+	case ",$sep_seen,$head,$arg," in
+	*,--,)
+		sep_seen=yes
+		;;
+	,yes,,*)
+		head=$arg
+		;;
+	,yes,*)
+		remotes="$remotes$arg "
+		;;
+	*)
+		bases="$bases$arg "
+		;;
+	esac
+done
+
+# Give up if we are given more than two remotes -- not handling octopus.
+case "$remotes" in
+?*' '?*)
+	exit 2 ;;
+esac
+
+# Find an optimum merge base if there are more than one candidates.
+case "$bases" in
+?*' '?*)
+	echo "Trying to find the optimum merge base."
+	G=.tmp-index$$
+	best=
+	best_cnt=-1
+	for c in $bases
+	do
+		rm -f $G
+		GIT_INDEX_FILE=$G git-read-tree -m $c $head $remotes \
+			 2>/dev/null ||	continue
+		# Count the paths that are unmerged.
+		cnt=`GIT_INDEX_FILE=$G git-ls-files --unmerged | wc -l`
+		if test $best_cnt -le 0 -o $cnt -le $best_cnt
+		then
+			best=$c
+			best_cnt=$cnt
+			if test "$best_cnt" -eq 0
+			then
+				# Cannot do any better than all trivial merge.
+				break
+			fi
+		fi
+	done
+	rm -f $G
+	common="$best"
+	;;
+*)
+	common="$bases"
+	;;
+esac
+
+git-update-index --refresh 2>/dev/null
+git-read-tree -u -m $common $head $remotes || exit 2
+echo "Trying simple merge."
+if result_tree=$(git-write-tree  2>/dev/null)
+then
+	exit 0
+else
+	echo "Simple merge failed, trying Automatic merge."
+	if git-merge-index -o git-merge-one-file -a
+	then
+		exit 0
+	else
+		exit 1
+	fi
+fi
diff --git a/git-merge.sh b/git-merge.sh
new file mode 100755
--- /dev/null
+++ b/git-merge.sh
@@ -0,0 +1,205 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Junio C Hamano
+#
+
+. git-sh-setup || die "Not a git archive"
+
+LF='
+'
+
+usage () {
+    die "git-merge [-n] [-s <strategy>]... <merge-message> <head> <remote>+"
+}
+
+# all_strategies='resolve barkarow fredrik octopus'
+
+all_strategies='resolve octopus'
+default_strategies='resolve octopus'
+use_strategies=
+
+dropheads() {
+	rm -f -- "$GIT_DIR/MERGE_HEAD" || exit 1
+}
+
+summary() {
+	case "$no_summary" in
+	'')
+		git-diff-tree -p -M $head "$1" |
+		git-apply --stat --summary
+		;;
+	esac
+}
+
+while case "$#" in 0) break ;; esac
+do
+	case "$1" in
+	-n|--n|--no|--no-|--no-s|--no-su|--no-sum|--no-summ|\
+		--no-summa|--no-summar|--no-summary)
+		no_summary=t ;;
+	-s=*|--s=*|--st=*|--str=*|--stra=*|--strat=*|--strate=*|\
+		--strateg=*|--strategy=*|\
+	-s|--s|--st|--str|--stra|--strat|--strate|--strateg|--strategy)
+		case "$#,$1" in
+		*,*=*)
+			strategy=`expr "$1" : '-[^=]*=\(.*\)'` ;;
+		0,*)
+			usage ;;
+		*)
+			strategy="$2"
+			shift ;;
+		esac
+		case " $all_strategies " in
+		*" $strategy "*)
+			use_strategies="$use_strategies$strategy " ;;
+		*)
+			die "available strategies are: $all_strategies" ;;
+		esac
+		;;
+	-*)	usage ;;
+	*)	break ;;
+	esac
+	shift
+done
+
+case "$use_strategies" in
+'')
+	use_strategies=$default_strategies
+	;;
+esac
+test "$#" -le 2 && usage ;# we need at least two heads.
+
+merge_msg="$1"
+shift
+head=$(git-rev-parse --verify "$1"^0) || usage
+shift
+
+# All the rest are remote heads
+for remote
+do
+	git-rev-parse --verify "$remote'^0 >/dev/null ||
+	    die "$remote - not something we can merge"
+done
+
+common=$(git-show-branch --merge-base $head "$@")
+echo "$head" >"$GIT_DIR/ORIG_HEAD"
+
+case "$#,$common" in
+*,'')
+	die "Unable to find common commit between $head and $*"
+	;;
+1,"$1")
+	# If head can reach all the merge then we are up to date.
+	# but first the most common case of merging one remote
+	echo "Already up-to-date. Yeeah!"
+	dropheads
+	exit 0
+	;;
+1,"$head")
+	# Again the most common case of merging one remote.
+	echo "Updating from $head to $1."
+	git-update-index --refresh 2>/dev/null
+	git-read-tree -u -m $head "$1" || exit 1
+	echo "$1" > "$GIT_DIR/HEAD"
+	summary "$1"
+	dropheads
+	exit 0
+	;;
+1,*)
+	# We are not doing octopus and not fast forward.  Need a
+	# real merge.
+	;;
+*)
+	# An octopus.  If we can reach all the remote we are up to date.
+	up_to_date=t
+	for remote
+	do
+		common_one=$(git-merge-base $head $remote)
+		if test "$common_one" != "$remote"
+		then
+			up_to_date=f
+			break
+		fi
+	done
+	if test "$up_to_date" = t
+	then
+		echo "Already up-to-date. Yeeah!"
+		dropheads
+		exit 0
+	fi
+	;;
+esac
+
+# At this point we need a real merge.  Require that the tree matches
+# exactly our head.
+
+git-update-index --refresh &&
+test '' = `git-diff-index --cache --name-only $head` || {
+	die "Need real merge but the working tree has local changes."
+}
+
+result_tree= best_cnt=-1 best_strategy= wt_strategy=
+for strategy in $use_strategies
+do
+    test "$wt_strategy" = '' || git reset --hard $head
+
+    echo "Trying merge strategy $strategy..."
+    wt_strategy=$strategy
+    git-merge-$strategy $common -- $head "$@" || {
+
+	# The backend exits with 1 when conflicts are left to be resolved,
+	# with 2 when it does not handle the given merge at all.
+
+	case "$?" in
+	1)
+	    cnt=`git-diff-files --name-only | wc -l`
+	    if test $best_cnt -le 0 -o $cnt -le $best_cnt
+	    then
+		best_strategy=$strategy
+		best_cnt=$cnt
+	    fi
+	esac
+	continue
+    }
+
+    # Automerge succeeded.
+    result_tree=$(git-write-tree) && break
+done
+
+# If we have a resulting tree, that means the strategy module
+# auto resolved the merge cleanly.
+if test '' != $result_tree
+then
+    parents="-p $head"
+    for remote
+    do
+        parents="$parents -p $remote"
+    done
+    result_commit=$(echo "$merge_msg" | git-commit-tree $result_tree $parents)
+    echo "Committed merge $result_commit, made by $wt_strategy."
+    echo $result_commit >"$GIT_DIR"/HEAD
+    summary $result_commit
+    dropheads
+    exit 0
+fi
+
+# Pick the result from the best strategy and have the user fix it up.
+case "$best_strategy" in
+'')
+	git reset --hard $head
+	die "No merge strategy handled the merge."
+	;;
+"$wt_strategy")
+	# We already have its result in the working tree.
+	;;
+*)
+	echo "Using the $strategy to prepare resolving by hand."
+	git reset --hard $head
+	git-merge-$best_strategy $common -- $head "$@"
+	;;
+esac
+for remote
+do
+	echo $remote
+done >"$GIT_DIR/MERGE_HEAD"
+die "Automatic merge failed; fix up by hand"

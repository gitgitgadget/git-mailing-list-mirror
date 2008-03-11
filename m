From: "Sverre Hvammen Johansen" <hvammen@gmail.com>
Subject: [RFC/PATCH] Fast forward strategies allow, never, and only
Date: Mon, 10 Mar 2008 18:59:17 -0800
Message-ID: <402c10cd0803101959q619efa86pbd501e5e2cc018c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 11 04:00:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYuj4-0005KK-Ez
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 04:00:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbYCKC7W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2008 22:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751055AbYCKC7W
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 22:59:22 -0400
Received: from fk-out-0910.google.com ([209.85.128.187]:61040 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750999AbYCKC7U (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2008 22:59:20 -0400
Received: by fk-out-0910.google.com with SMTP id z23so2017437fkz.5
        for <git@vger.kernel.org>; Mon, 10 Mar 2008 19:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=K3+GPSVQ6QTVU+wT1PVGSRTmgX1vfaZomuKkKqKq7jo=;
        b=LJhM/VJTArCncuQWLNB+NgvwwPFnMX9B3Q7xuMAxq2zV6cRbgGwr5Fk5HGVAI8VbgH1CIjODdpgPKvgjqPtn3iTXQ4v10Ovd9suH2su3mcuFGI4g6WLyxOSxutvZg8N8e0DGm4B02tVhgvtZgyo/nxbdP0qjU4nhNKslJaPixZg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=O1lTXhl2yjv4bLXlusgtx8kmM0vXl951D+DQFO+XsjBX+LooAdOoArPWL+rI0OH6nxgYD0GVUCTeUHlDvNlhan9fOmZpy8qJG3wSQL+lCgcKcj6kG59fYU8b5WJU++R4tA62QeqICKYOImD7/2Y2FumxeC7gZ8FEeSjEjSL/b2A=
Received: by 10.82.175.17 with SMTP id x17mr14957375bue.19.1205204357892;
        Mon, 10 Mar 2008 19:59:17 -0700 (PDT)
Received: by 10.82.172.14 with HTTP; Mon, 10 Mar 2008 19:59:17 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76787>

>From 795bd1b3e70f011b675061ecae322527a9f0695c Mon Sep 17 00:00:00 2001
From: Sverre Hvammen Johansen <sj@gmail.com>
Date: Sun, 9 Mar 2008 21:43:56 -0800
Subject: [PATCH] Fast forward strategies allow, never, and only.

New fast forward strategies, only, is introduced.  This new fast
forward strategy prevents real merges.

FF strategy "only" fails if the specified heads and HEAD can not
be reduced down to only one real parent.  The only allowed
outcome is a fast forward unless HEAD is up to date with
the specified heads.

This patch also uses the real heads found instead of those
specified for real merges.  This means that merge startegies
that only take two heads can now accept more than two heads
if they can be reduced down to only two real heads.  However,
fast-forward of head in combination with a real merge is
handled as before.

Signed-off-by: Sverre Hvammen Johansen <sj@black.local>
---
 Documentation/fast-forward-strategies.txt |   16 +
 Documentation/git-merge.txt               |    6 +-
 Documentation/git-pull.txt                |    2 +
 Documentation/merge-options.txt           |   11 +-
 git-merge.sh                              |  291 +++++++++++-----
 git-pull.sh                               |    4 +-
 t/t7601-merge-ff-strategies.sh            |  549 +++++++++++++++++++++++++++++
 7 files changed, 778 insertions(+), 101 deletions(-)
 create mode 100644 Documentation/fast-forward-strategies.txt
 create mode 100755 t/t7601-merge-ff-strategies.sh

diff --git a/Documentation/fast-forward-strategies.txt
b/Documentation/fast-forward-strategies.txt
new file mode 100644
index 0000000..1d6da26
--- /dev/null
+++ b/Documentation/fast-forward-strategies.txt
@@ -0,0 +1,16 @@
+FAST FORWARD STRATEGIES
+-----------------------
+
+allow::
+	Do not generate a merge commit if the merge resolved
+	as a fast-forward, only update the branch pointer.
+	This is the default behavior of git-merge.
+
+never::
+	Generate a merge commit even if the merge resolved
+	as a fast-forward.
+
+only::
+	Only allow a fast-forward.  The merge will fail
+	unless HEAD is up to date or the merge resolved as
+        a fast-forward.
diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index c136b10..fbf3ebe 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -9,7 +9,8 @@ git-merge - Join two or more development histories together
 SYNOPSIS
 --------
 [verse]
-'git-merge' [-n] [--summary] [--no-commit] [--squash] [-s <strategy>]...
+'git-merge' [-n] [--summary] [--no-commit] [--squash]
+	[-s <strategy>]... [--ff[=<fast forward strategy>]]
 	[-m <msg>] <remote> <remote>...
 'git-merge' <msg> HEAD <remote>...

@@ -37,6 +38,9 @@ include::merge-options.txt[]
 	least one <remote>.  Specifying more than one <remote>
 	obviously means you are trying an Octopus.

+
+include::fast-forward-strategies.txt[]
+
 include::merge-strategies.txt[]


diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 7378943..99d205c 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -50,6 +50,8 @@ include::pull-fetch-param.txt[]

 include::urls-remotes.txt[]

+include::fast-forward-strategies.txt[]
+
 include::merge-strategies.txt[]

 DEFAULT BEHAVIOUR
diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index 9f1fc82..848b786 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -29,12 +29,13 @@

 --no-ff::
 	Generate a merge commit even if the merge resolved as a
-	fast-forward.
+	fast-forward.  --on-ff is an alias for --ff=never.

---ff::
-	Do not generate a merge commit if the merge resolved as
-	a fast-forward, only update the branch pointer. This is
-	the default behavior of git-merge.
+--ff[=<fast forward strategy>]::
+	Select fast forward strategy.  --ff without any argument
+	is an alias for --ff=allow which is the default behavior
+	of git-merge.  It will not generate a merge commit if the
+	merge resolved as a fast-forward,

 -s <strategy>, \--strategy=<strategy>::
 	Use the given merge strategy; can be supplied more than
diff --git a/git-merge.sh b/git-merge.sh
index 7dbbb1d..873e4cb 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -12,7 +12,7 @@ summary              show a diffstat at the end of the merge
 n,no-summary         don't show a diffstat at the end of the merge
 squash               create a single commit instead of doing a merge
 commit               perform a commit if the merge sucesses (default)
-ff                   allow fast forward (default)
+ff?                  allow fast forward (default)
 s,strategy=          merge strategy to use
 m,message=           message to be used for the merge commit (if any)
 "
@@ -35,7 +35,7 @@ no_fast_forward_strategies='subtree ours'
 no_trivial_strategies='recursive recur subtree ours'
 use_strategies=

-allow_fast_forward=t
+fast_forward=allow
 allow_trivial_merge=t
 squash= no_commit=

@@ -153,8 +153,8 @@ parse_config () {
 		--summary)
 			show_diffstat=t ;;
 		--squash)
-			test "$allow_fast_forward" = t ||
-				die "You cannot combine --squash with --no-ff."
+			test "$fast_forward" = allow ||
+				die "You cannot combine --squash with --ff=never."
 			squash=t no_commit=t ;;
 		--no-squash)
 			squash= no_commit= ;;
@@ -163,11 +163,28 @@ parse_config () {
 		--no-commit)
 			no_commit=t ;;
 		--ff)
-			allow_fast_forward=t ;;
+			case "$2" in
+			allow|never|only)
+				fast_forward=$2 squash= no_commit= ; shift ;;
+			-*)
+				fast_forward=allow squash= no_commit= ;;
+			*)
+				die "available fast-forward strategies are: allow, newer, and only" ;;
+			esac
+			;;
+		--ff=*)
+			fast_forward=$(echo $1 |cut -d = -f 2) squash= no_commit=
+			case $fast_forward in
+			    allow|never|only)
+				;;
+			    *)
+				die "available fast-forward strategies are: allow, newer, and only" ;;
+			esac
+			;;
 		--no-ff)
 			test "$squash" != t ||
 				die "You cannot combine --squash with --no-ff."
-			allow_fast_forward=f ;;
+			fast_forward=never ;;
 		-s|--strategy)
 			shift
 			case " $all_strategies " in
@@ -279,24 +296,125 @@ do
 done
 set x $remoteheads ; shift

+echo "$head" >"$GIT_DIR/ORIG_HEAD"
+
+find_one_real_parent () {
+	# The real parent candidate
+	real_parent=$1
+	shift
+
+	# Other parents that are indepent of the real parent candidate
+	other_parents=
+
+	# Parents that need further processing to determine whether
+	# they are independent parents of the parent candidate or not
+	parents_x=
+
+	while test $# -gt 0
+	do
+		if test $real_parent = $1
+		then
+			# Found a parent that is equal to the real
+			# parent candidate
+			echo "Duplicate $(git rev-parse --short $1)"
+			echo "Ignoring $1"
+		else
+			common_b=$(git merge-base --all $real_parent $1)
+		
+			if test "$common_b" = $1
+			then
+				# Found a parent that is not
+				# independent of the real parent
+				# candidate
+				echo "Possible ff $(git rev-parse --short $1)..$(git rev-parse
--short $real_parent)."
+				echo "Ignoring $1"
+			elif test "$common_b" = $real_parent
+			then
+				# Found a better real parent candidate
+				echo "Possible ff $(git rev-parse --short $real_parent)..$(git
rev-parse --short $1)."
+				echo "Ignoring $real_parent"
+				real_parent=$1
+				parents_x="$other_parents"
+				other_parents=
+			else
+				# Found a parent that is independent
+				# of the real parent candidate
+				other_parents="$other_parents $1"
+			fi
+		fi
+		shift
+	done
+
+	# We have a real parent, some parents we know is independt of
+	# this real parent, and some parents that need further
+	# processing.
+
+	for b in $parents_x
+	do
+		common_b=$(git merge-base --all $real_parent $b)
+		if test "$common_b" != $b
+		then
+			other_parents="$other_parents $b"
+		fi
+	done
+
+	# We have a real parent and other parents we know is independent
+	# of this real parent
+}
+
+find_real_parents () {
+    find_one_real_parent $head "$@"
+    ff_head=$real_parent
+    real_parents=
+
+    while test -n "$other_parents"
+    do
+	find_one_real_parent $other_parents
+	real_parents="$real_parents $real_parent"
+    done
+}
+
+if test $fast_forward = never -o
+then
+	real_parents="$@"
+	ff_head=$head
+else
+	find_real_parents "$@"
+fi
+
+if test -n "$real_parents"
+then
+	case $fast_forward in
+	only)
+		die "Fast forward strategy only can only handle one real parent" ;;
+	never|allow)
+		if test $head != $ff_head
+		then
+			real_parents="$ff_head $real_parents"
+			ff_head=$head
+		fi
+		;;
+	esac
+fi
+
 case "$use_strategies" in
 '')
-	case "$#" in
-	1)
-		var="`git config --get pull.twohead`"
+	case "$real_parents" in
+	?*" "?*)
+		var="`git config --get pull.octopus`"
 		if test -n "$var"
 		then
 			use_strategies="$var"
 		else
-			use_strategies="$default_twohead_strategies"
+			use_strategies="$default_octopus_strategies"
 		fi ;;
 	*)
-		var="`git config --get pull.octopus`"
+		var="`git config --get pull.twohead`"
 		if test -n "$var"
 		then
 			use_strategies="$var"
 		else
-			use_strategies="$default_octopus_strategies"
+			use_strategies="$default_twohead_strategies"
 		fi ;;
 	esac
 	;;
@@ -308,7 +426,7 @@ do
 	do
 		case " $s " in
 		*" $ss "*)
-			allow_fast_forward=f
+			fast_forward=never
 			break
 			;;
 		esac
@@ -323,88 +441,73 @@ do
 		esac
 	done
 done
-
-case "$#" in
-1)
-	common=$(git merge-base --all $head "$@")
-	;;
-*)
-	common=$(git show-branch --merge-base $head "$@")
-	;;
-esac
-echo "$head" >"$GIT_DIR/ORIG_HEAD"
-
-case "$allow_fast_forward,$#,$common,$no_commit" in
-?,*,'',*)
-	# No common ancestors found. We need a real merge.
-	;;
-?,1,"$1",*)
-	# If head can reach all the merge then we are up to date.
-	# but first the most common case of merging one remote.
-	finish_up_to_date "Already up-to-date."
-	exit 0
-	;;
-t,1,"$head",*)
-	# Again the most common case of merging one remote.
-	echo "Updating $(git rev-parse --short $head)..$(git rev-parse --short $1)"
-	git update-index --refresh 2>/dev/null
-	msg="Fast forward"
-	if test -n "$have_message"
+if test -z "$real_parents"
+then
+	if test $head = $ff_head
 	then
-		msg="$msg (no commit created; -m option ignored)"
-	fi
-	new_head=$(git rev-parse --verify "$1^0") &&
-	git read-tree -v -m -u --exclude-per-directory=.gitignore $head "$new_head" &&
-	finish "$new_head" "$msg" || exit
-	dropsave
-	exit 0
-	;;
-?,1,?*"$LF"?*,*)
-	# We are not doing octopus and not fast forward.  Need a
-	# real merge.
-	;;
-?,1,*,)
-	# We are not doing octopus, not fast forward, and have only
-	# one common.
-	git update-index --refresh 2>/dev/null
-	case "$allow_trivial_merge" in
-	t)
-		# See if it is really trivial.
-		git var GIT_COMMITTER_IDENT >/dev/null || exit
-		echo "Trying really trivial in-index merge..."
-		if git read-tree --trivial -m -u -v $common $head "$1" &&
-		   result_tree=$(git write-tree)
-		then
-			echo "Wonderful."
-			result_commit=$(
-				printf '%s\n' "$merge_msg" |
-				git commit-tree $result_tree -p HEAD -p "$1"
-			) || exit
-			finish "$result_commit" "In-index merge"
-			dropsave
-			exit 0
-		fi
-		echo "Nope."
-	esac
-	;;
-*)
-	# An octopus.  If we can reach all the remote we are up to date.
-	up_to_date=t
-	for remote
-	do
-		common_one=$(git merge-base --all $head $remote)
-		if test "$common_one" != "$remote"
+		finish_up_to_date "Already up-to-date."
+		exit 0
+	elif test $fast_forward = never
+	then
+		real_parents="$ff_head"
+		ff_head=$head
+	else
+		echo "Updating $(git rev-parse --short $head)..$(git rev-parse
--short $ff_head)"
+		git update-index --refresh 2>/dev/null
+		msg="Fast forward"
+		if test -n "$have_message"
 		then
-			up_to_date=f
-			break
+			msg="$msg (no commit created; -m option ignored)"
 		fi
-	done
-	if test "$up_to_date" = t
-	then
-		finish_up_to_date "Already up-to-date. Yeeah!"
+		new_head=$(git rev-parse --verify "$ff_head^0") &&
+		git read-tree -v -m -u --exclude-per-directory=.gitignore $head
"$new_head" &&
+		finish "$new_head" "$msg" || exit
+		dropsave
 		exit 0
 	fi
+else
+	if test $head != $ff_head -a $fast_forward = never
+	then
+		real_parents="$ff_head $real_parents"
+		ff_head=$head
+	fi
+fi
+
+case "$real_parents" in
+?*" "?*)
+	# We have more than one parent
+	common=$(git show-branch --merge-base $head $real_parents)
 	;;
+*)
+	# We have exactly one parent
+	common=$(git merge-base --all $ff_head $real_parents)
+	case "$common" in
+	?*"$LF"?*)
+		# We are not doing octopus and not fast forward.  Need a
+		# real merge.
+		;;
+	*)
+		git update-index --refresh 2>/dev/null
+		if test "$allow_trivial_merge" = t
+		then
+			# See if it is really trivial.
+			git var GIT_COMMITTER_IDENT >/dev/null || exit
+			echo "Trying really trivial in-index merge..."
+			if git read-tree --trivial -m -u -v $common $head $real_parents &&
+				result_tree=$(git write-tree)
+			then
+				echo "Wonderful."
+				result_commit=$(
+					printf '%s\n' "$merge_msg" |
+					git commit-tree $result_tree -p HEAD -p $real_parents
+				) || exit
+				finish "$result_commit" "In-index merge"
+				dropsave
+				exit 0
+			fi
+			echo "Nope."
+		fi ;;
+	esac ;;
 esac

 # We are going to make a new commit.
@@ -445,7 +548,7 @@ do
     # Remember which strategy left the state in the working tree
     wt_strategy=$strategy

-    git-merge-$strategy $common -- "$head_arg" "$@"
+    git-merge-$strategy $common -- "$head_arg" $real_parents
     exit=$?
     if test "$no_commit" = t && test "$exit" = 0
     then
@@ -481,11 +584,11 @@ done
 # auto resolved the merge cleanly.
 if test '' != "$result_tree"
 then
-    if test "$allow_fast_forward" = "t"
+    if test $fast_forward != never
     then
-        parents=$(git show-branch --independent "$head" "$@")
+        parents=$(git show-branch --independent "$head" $real_parents)
     else
-        parents=$(git rev-parse "$head" "$@")
+        parents=$(git rev-parse "$head" $real_parents)
     fi
     parents=$(echo "$parents" | sed -e 's/^/-p /')
     result_commit=$(printf '%s\n' "$merge_msg" | git commit-tree
$result_tree $parents) || exit
@@ -515,7 +618,7 @@ case "$best_strategy" in
 	echo "Rewinding the tree to pristine..."
 	restorestate
 	echo "Using the $best_strategy to prepare resolving by hand."
-	git-merge-$best_strategy $common -- "$head_arg" "$@"
+	git-merge-$best_strategy $common -- "$head_arg" $real_parents
 	;;
 esac

diff --git a/git-pull.sh b/git-pull.sh
index 3ce32b5..b78cfdd 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -4,7 +4,7 @@
 #
 # Fetch one or more remote refs and merge it/them into the current HEAD.

-USAGE='[-n | --no-summary] [--[no-]commit] [--[no-]squash]
[--[no-]ff] [-s strategy]... [<fetch-options>] <repo> <head>...'
+USAGE='[-n | --no-summary] [--[no-]commit] [--[no-]squash]
[--ff=<ff-strategy>] [-s strategy]... [<fetch-options>] <repo>
<head>...'
 LONG_USAGE='Fetch one or more remote refs and merge it/them into the
current HEAD.'
 SUBDIRECTORY_OK=Yes
 OPTIONS_SPEC=
@@ -41,6 +41,8 @@ do
 		no_ff=--ff ;;
 	--no-ff)
 		no_ff=--no-ff ;;
+	--ff=*)
+		no_ff=$1 ;;
 	-s=*|--s=*|--st=*|--str=*|--stra=*|--strat=*|--strate=*|\
 		--strateg=*|--strategy=*|\
 	-s|--s|--st|--str|--stra|--strat|--strate|--strateg|--strategy)
diff --git a/t/t7601-merge-ff-strategies.sh b/t/t7601-merge-ff-strategies.sh
new file mode 100755
index 0000000..6c0a91a
--- /dev/null
+++ b/t/t7601-merge-ff-strategies.sh
@@ -0,0 +1,549 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Lars Hjemli
+#
+
+test_description='git-merge
+
+Testing basic merge operations/option parsing.'
+
+. ./test-lib.sh
+
+cat >file <<EOF
+1
+2
+3
+4
+5
+6
+7
+8
+9
+10
+11
+12
+EOF
+
+cat >file.1 <<EOF
+1 X
+2
+3
+4
+5
+6
+7
+8
+9
+10
+11
+12
+EOF
+
+cat >file.5 <<EOF
+1
+2
+3
+4
+5 X
+6
+7
+8
+9
+10
+11
+12
+EOF
+
+cat >file.9 <<EOF
+1
+2
+3
+4
+5
+6
+7
+8
+9 X
+10
+11
+12
+EOF
+
+cat  >result.0 <<EOF
+1
+2
+3
+4
+5
+6
+7
+8
+9
+10
+11
+12
+EOF
+
+cat  >result.1 <<EOF
+1 X
+2
+3
+4
+5
+6
+7
+8
+9
+10
+11
+12
+EOF
+
+cat >result.1-5 <<EOF
+1 X
+2
+3
+4
+5 X
+6
+7
+8
+9
+10
+11
+12
+EOF
+
+cat >result.1-5-9 <<EOF
+1 X
+2
+3
+4
+5 X
+6
+7
+8
+9 X
+10
+11
+12
+EOF
+
+cat >result.1-5-9-13 <<EOF
+1 X
+2
+3
+4
+5 X
+6
+7
+8
+9 X
+10
+11
+12
+13 x
+EOF
+
+cat >result.1-5-13 <<EOF
+1 X
+2
+3
+4
+5 X
+6
+7
+8
+9
+10
+11
+12
+13 x
+EOF
+
+cat >result.5-13 <<EOF
+1
+2
+3
+4
+5 X
+6
+7
+8
+9
+10
+11
+12
+13 x
+EOF
+
+cat >result.1-13 <<EOF
+1 X
+2
+3
+4
+5
+6
+7
+8
+9
+10
+11
+12
+13 x
+EOF
+
+cat >extend <<EOF
+13 x
+EOF
+
+
+create_merge_msgs() {
+	echo "Merge commit 'c2'" >msg.1-5 &&
+	echo "Merge commit 'c2'; commit 'c3'" >msg.1-5-9 &&
+	echo "Squashed commit of the following:" >squash.1 &&
+	echo >>squash.1 &&
+	git log --no-merges ^HEAD c1 >>squash.1 &&
+	echo "Squashed commit of the following:" >squash.1-5 &&
+	echo >>squash.1-5 &&
+	git log --no-merges ^HEAD c2 >>squash.1-5 &&
+	echo "Squashed commit of the following:" >squash.1-5-9 &&
+	echo >>squash.1-5-9 &&
+	git log --no-merges ^HEAD c2 c3 >>squash.1-5-9
+}
+
+verify_diff() {
+	if ! diff -u "$1" "$2"
+	then
+		echo "$3"
+		false
+	fi
+}
+
+verify_merge() {
+	verify_diff "$2" "$1" "[OOPS] bad merge result" &&
+	if test $(git ls-files -u | wc -l) -gt 0
+	then
+		echo "[OOPS] unmerged files"
+		false
+	fi &&
+	if ! git diff --exit-code
+	then
+		echo "[OOPS] working tree != index"
+		false
+	fi &&
+	if test -n "$3"
+	then
+		git show -s --pretty=format:%s HEAD >msg.act &&
+		verify_diff "$3" msg.act "[OOPS] bad merge message"
+	fi
+}
+
+verify_head() {
+	if test "$1" != "$(git rev-parse HEAD)"
+	then
+		echo "[OOPS] HEAD != $1"
+		false
+	fi
+}
+
+verify_parents() {
+	i=1
+	while test $# -gt 0
+	do
+		if test "$1" != "$(git rev-parse HEAD^$i)"
+		then
+			echo "[OOPS] HEAD^$i != $1"
+			return 1
+		fi
+		i=$(expr $i + 1)
+		shift
+	done
+}
+
+verify_mergeheads() {
+	i=1
+	if ! test -f .git/MERGE_HEAD
+	then
+		echo "[OOPS] MERGE_HEAD is missing"
+		false
+	fi &&
+	while test $# -gt 0
+	do
+		head=$(head -n $i .git/MERGE_HEAD | tail -n 1)
+		if test "$1" != "$head"
+		then
+			echo "[OOPS] MERGE_HEAD $i != $1"
+			return 1
+		fi
+		i=$(expr $i + 1)
+		shift
+	done
+}
+
+verify_no_mergehead() {
+	if test -f .git/MERGE_HEAD
+	then
+		echo "[OOPS] MERGE_HEAD exists"
+		false
+	fi
+}
+
+
+test_expect_success 'setup' '
+	git add file &&
+	test_tick &&
+	git commit -m "commit 0" &&
+	git tag c0 &&
+	c0=$(git rev-parse HEAD) &&
+
+	cp file.1 file &&
+	git add file &&
+	test_tick &&
+	git commit -m "commit 1" &&
+	git tag c1 &&
+	c1=$(git rev-parse HEAD) &&
+	test_tick &&
+
+	git reset --hard "$c0" &&
+	cp file.5 file &&
+	git add file &&
+	git commit -m "commit 2" &&
+	test_tick &&
+	git tag c2 &&
+	c2=$(git rev-parse HEAD) &&
+
+	git reset --hard "$c0" &&
+	cp file.9 file &&
+	git add file &&
+	test_tick &&
+	git commit -m "commit 3" &&
+	git tag c3 &&
+	c3=$(git rev-parse HEAD) &&
+	test_tick &&
+
+	git reset --hard "$c1" &&
+	cat extend >>file &&
+	git add file &&
+	git commit -m "commit 4" &&
+	git tag x1 &&
+	x1=$(git rev-parse HEAD) &&
+	test_tick &&
+
+	git reset --hard "$c1" &&
+	git merge "$c2" &&
+	git tag x0 &&
+	x0=$(git rev-parse HEAD) &&
+	test_tick &&
+
+	git reset --hard "$c2" &&
+	cat extend >>file &&
+	git add file &&
+	git commit -m "commit 5" &&
+	git tag x2 &&
+	x2=$(git rev-parse HEAD) &&
+	test_tick &&
+
+	git reset --hard "$x1" &&
+	git merge "$x0" &&
+	git tag y1 &&
+	y1=$(git rev-parse HEAD) &&
+	test_tick &&
+
+	git reset --hard "$x0" &&
+	git merge "$x2" &&
+	git tag y2 &&
+	y2=$(git rev-parse HEAD) &&
+	test_tick &&
+
+	git reset --hard "$y1" &&
+	git merge "$y2" &&
+	git tag y3 &&
+	y3=$(git rev-parse HEAD) &&
+	test_tick &&
+	git reset --hard "$c0" &&
+	create_merge_msgs &&
+
+	git reset --hard x1 &&
+	git clone .git clone &&
+	git config remote.clone.url clone &&
+	git config remote.clone.fetch "+refs/heads/*:refs/remotes/clone/*" &&
+
+	(mkdir new && cd new && git init && cp ../file.9 file2 && git add
file2 && test_tick && git commit -m "commit new") &&
+	git config remote.new.url new &&
+	git config remote.new.fetch "+refs/heads/*:refs/remotes/new/*"
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c0 with c1 (ff-only overrides no-ff)' '
+	git reset --hard c0 &&
+	git config branch.master.mergeoptions "--no-ff" &&
+	git merge --ff=only c1 &&
+	verify_merge file result.1 &&
+	verify_head $c1
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c0 with c1 (--ff=only in config)' '
+	git reset --hard c0 &&
+	git config branch.master.mergeoptions "--ff=only" &&
+	git merge c1 &&
+	test_tick &&
+	verify_merge file result.1 &&
+	verify_head $c1
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c1 with c0 (--ff=only in config)' '
+	git reset --hard c1 &&
+	git config branch.master.mergeoptions "--ff=only" &&
+	git merge c0 &&
+	verify_merge file result.1 &&
+	verify_head $c1
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c1 with c2 (--ff=only in config)' '
+	git reset --hard c1 &&
+	test_tick &&
+	git config branch.master.mergeoptions "--ff=only" &&
+	if git merge c2
+	then
+		false
+	else
+		verify_merge file result.1 &&
+		verify_head $c1
+	fi
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c0 with c1 (--ff=only)' '
+	git reset --hard c0 &&
+	test_tick &&
+	git merge --ff=only c1 &&
+	verify_merge file result.1 &&
+	verify_head $c1
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c1 with c0 (--ff=only)' '
+	git reset --hard c1 &&
+	test_tick &&
+	git merge --ff=only c0 &&
+	verify_merge file result.1 &&
+	verify_head $c1
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c0 with c1 and c2 (--ff=only)' '
+	git reset --hard c0 &&
+	if git --ff=only merge c1 c2
+	then
+		false
+	else
+		verify_merge file result.0 &&
+		verify_head $c0
+	fi
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c1 with c0 (--ff=only)' '
+	git reset --hard c1 &&
+	test_tick &&
+	git merge --ff=only c0 &&
+	verify_merge file result.1 &&
+	verify_head $c1
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c1 with c2 (--ff=only overrides no-ff)' '
+	git reset --hard c1 &&
+	git config branch.master.mergeoptions "--no-ff" &&
+	test_tick &&
+	if git merge c2 --ff=only
+	then
+		false
+	else
+		verify_merge file result.1 &&
+		verify_head $c1
+	fi
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c0 with c1 (no-ff overrides --ff=only)' '
+	git reset --hard c0 &&
+	git config branch.master.mergeoptions "--ff=only" &&
+	test_tick &&
+	git merge --no-ff c1 &&
+	verify_merge file result.1 &&
+	verify_parents $c0 $c1
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c1 with c2 (ff owerrides --ff=only)' '
+	git reset --hard c1 &&
+	git config branch.master.mergeoptions "--ff=only" &&
+	test_tick &&
+	git merge --ff c2 &&
+	verify_merge file result.1-5 &&
+	verify_parents $c1 $c2
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c0 with c1 and c2' '
+	git reset --hard c0 &&
+	git config branch.master.mergeoptions "" &&
+	test_tick &&
+	git merge c1 c2 &&
+	verify_merge file result.1-5 &&
+	verify_parents $c1 $c2
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c1 with c0, c2, c0, and c1' '
+	git reset --hard c1 &&
+	git config branch.master.mergeoptions "" &&
+	test_tick &&
+	git merge c0 c2 c0 c1 &&
+	verify_merge file result.1-5 &&
+	verify_parents $c1 $c2
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge y2 with x0, c3, and c0' '
+	git reset --hard y2 &&
+	git config branch.master.mergeoptions "" &&
+	test_tick &&
+	git merge x0 c3 c0 &&
+	verify_merge file result.1-5-9-13 &&
+	verify_parents $y2 $c3
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge x0 with y2, c3, and c0' '
+	git reset --hard x0 &&
+	git config branch.master.mergeoptions "" &&
+	test_tick &&
+	git merge y2 c3 c0 &&
+	verify_merge file result.1-5-9-13 &&
+	verify_parents $y2 $c3
+'
+
+test_debug 'gitk --all'
+
+test_done
-- 
1.5.3.3

-- 
Sverre Hvammen Johansen

From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-merge: New options `--no-fast-forward' and `--direct'.
Date: Sat, 18 Mar 2006 14:53:52 -0800
Message-ID: <7vhd5vs6tb.fsf@assigned-by-dhcp.cox.net>
References: <slrne1nnhm.fr9.mdw@metalzone.distorted.org.uk>
	<20060318101941.8941.52615.stgit@metalzone.distorted.org.uk>
	<7vmzfns9c6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 18 23:54:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FKkJ7-0003ZB-Ou
	for gcvg-git@gmane.org; Sat, 18 Mar 2006 23:54:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbWCRWxy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 18 Mar 2006 17:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750952AbWCRWxy
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Mar 2006 17:53:54 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:62613 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1750753AbWCRWxy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Mar 2006 17:53:54 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060318225231.PHVH3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 18 Mar 2006 17:52:31 -0500
To: Mark Wooding <mdw@distorted.org.uk>
In-Reply-To: <7vmzfns9c6.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 18 Mar 2006 13:59:21 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17704>

>From nobody Mon Sep 17 00:00:00 2001
From: Junio C Hamano <junkio@cox.net>
Date: Sat Mar 18 14:50:53 2006 -0800
Subject: [PATCH] git-merge knows some strategies want to skip trivial merges

Most notably "ours".  Also this makes sure we do not record
duplicated parents on the parent list of the resulting commit.

This is based on Mark Wooding's work, but does not change the UI
nor introduce new flags.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * How about this instead?  It looks larger than it really is
   because strategy-defaulting code needed to get moved around.

 git-merge.sh |   67 +++++++++++++++++++++++++++++++++++-----------------------
 1 files changed, 40 insertions(+), 27 deletions(-)

313093ea6d29bbce5977556645eb5946dbfb211e
diff --git a/git-merge.sh b/git-merge.sh
index cc0952a..78ab422 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -11,11 +11,15 @@ LF='
 '
 
 all_strategies='recursive octopus resolve stupid ours'
-default_strategies='recursive'
+default_twohead_strategies='recursive'
+default_octopus_strategies='octopus'
+no_trivial_merge_strategies='ours'
 use_strategies=
+
+index_merge=t
 if test "@@NO_PYTHON@@"; then
 	all_strategies='resolve octopus stupid ours'
-	default_strategies='resolve'
+	default_twohead_strategies='resolve'
 fi
 
 dropsave() {
@@ -90,8 +94,6 @@ do
 	shift
 done
 
-test "$#" -le 2 && usage ;# we need at least two heads.
-
 merge_msg="$1"
 shift
 head_arg="$1"
@@ -99,6 +101,8 @@ head=$(git-rev-parse --verify "$1"^0) ||
 shift
 
 # All the rest are remote heads
+test "$#" = 0 && usage ;# we need at least one remote head.
+
 remoteheads=
 for remote
 do
@@ -108,6 +112,27 @@ do
 done
 set x $remoteheads ; shift
 
+case "$use_strategies" in
+'')
+	case "$#" in
+	1)
+		use_strategies="$default_twohead_strategies" ;;
+	*)
+		use_strategies="$default_octopus_strategies" ;;
+	esac
+	;;
+esac
+
+for s in $use_strategies
+do
+	case " $s " in
+	*" $no_trivial_merge_strategies "*)
+		index_merge=f
+		break
+		;;
+	esac
+done
+
 case "$#" in
 1)
 	common=$(git-merge-base --all $head "$@")
@@ -118,18 +143,21 @@ case "$#" in
 esac
 echo "$head" >"$GIT_DIR/ORIG_HEAD"
 
-case "$#,$common,$no_commit" in
-*,'',*)
+case "$index_merge,$#,$common,$no_commit" in
+f,*)
+	# We've been told not to try anything clever.  Skip to real merge.
+	;;
+?,*,'',*)
 	# No common ancestors found. We need a real merge.
 	;;
-1,"$1",*)
+?,1,"$1",*)
 	# If head can reach all the merge then we are up to date.
-	# but first the most common case of merging one remote
+	# but first the most common case of merging one remote.
 	echo "Already up-to-date."
 	dropsave
 	exit 0
 	;;
-1,"$head",*)
+?,1,"$head",*)
 	# Again the most common case of merging one remote.
 	echo "Updating from $head to $1"
 	git-update-index --refresh 2>/dev/null
@@ -139,11 +167,11 @@ case "$#,$common,$no_commit" in
 	dropsave
 	exit 0
 	;;
-1,?*"$LF"?*,*)
+?,1,?*"$LF"?*,*)
 	# We are not doing octopus and not fast forward.  Need a
 	# real merge.
 	;;
-1,*,)
+?,1,*,)
 	# We are not doing octopus, not fast forward, and have only
 	# one common.  See if it is really trivial.
 	git var GIT_COMMITTER_IDENT >/dev/null || exit
@@ -188,17 +216,6 @@ esac
 # We are going to make a new commit.
 git var GIT_COMMITTER_IDENT >/dev/null || exit
 
-case "$use_strategies" in
-'')
-	case "$#" in
-	1)
-		use_strategies="$default_strategies" ;;
-	*)
-		use_strategies=octopus ;;
-	esac		
-	;;
-esac
-
 # At this point, we need a real merge.  No matter what strategy
 # we use, it would operate on the index, possibly affecting the
 # working tree, and when resolved cleanly, have the desired tree
@@ -270,11 +287,7 @@ done
 # auto resolved the merge cleanly.
 if test '' != "$result_tree"
 then
-    parents="-p $head"
-    for remote
-    do
-        parents="$parents -p $remote"
-    done
+    parents=$(git-show-branch --independent "$head" "$@" | sed -e 's/^/-p /')
     result_commit=$(echo "$merge_msg" | git-commit-tree $result_tree $parents) || exit
     finish "$result_commit" "Merge $result_commit, made by $wt_strategy."
     dropsave
-- 
1.2.4.g2fc2

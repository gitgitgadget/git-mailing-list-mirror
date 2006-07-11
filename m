From: Shawn Pearce <spearce@spearce.org>
Subject: [PATCH] Log ref changes made by git-merge and git-pull.
Date: Tue, 11 Jul 2006 01:52:54 -0400
Message-ID: <20060711055254.GA11636@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 11 07:53:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0BBI-0003lr-Py
	for gcvg-git@gmane.org; Tue, 11 Jul 2006 07:53:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932247AbWGKFxB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Jul 2006 01:53:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932314AbWGKFxB
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Jul 2006 01:53:01 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:10433 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S932247AbWGKFxA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jul 2006 01:53:00 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1G0BB3-0006Fp-Vs; Tue, 11 Jul 2006 01:52:58 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9B9FF20E43C; Tue, 11 Jul 2006 01:52:55 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23686>

When git-merge updates HEAD as a result of a merge record what
happened during the merge into the reflog associated with HEAD
(if any).  The log reports who caused the update (git-merge or
git-pull, by invoking git-merge), what the remote ref names were
and the type of merge process used.

The merge information can be useful when reviewing a reflog for
a branch such as `master` where fast forward and trivial in index
merges might be common as the user tracks an upstream.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 git-merge.sh |   17 ++++++++++++++---
 git-pull.sh  |    3 ++-
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/git-merge.sh b/git-merge.sh
index 24e3b50..a9cfafb 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -58,7 +58,13 @@ squash_message () {
 }
 
 finish () {
-	test '' = "$2" || echo "$2"
+	if test '' = "$2"
+	then
+		rlogm="$rloga"
+	else
+		echo "$2"
+		rlogm="$rloga: $2"
+	fi
 	case "$squash" in
 	t)
 		echo "Squash commit -- not updating HEAD"
@@ -70,7 +76,7 @@ finish () {
 			echo "No merge message -- not updating HEAD"
 			;;
 		*)
-			git-update-ref HEAD "$1" "$head" || exit 1
+			git-update-ref -m "$rlogm" HEAD "$1" "$head" || exit 1
 			;;
 		esac
 		;;
@@ -88,6 +94,7 @@ finish () {
 	esac
 }
 
+rloga=
 while case "$#" in 0) break ;; esac
 do
 	case "$1" in
@@ -117,6 +124,9 @@ do
 			die "available strategies are: $all_strategies" ;;
 		esac
 		;;
+	--reflog-action=*)
+		rloga=`expr "z$1" : 'z-[^=]*=\(.*\)'`
+		;;
 	-*)	usage ;;
 	*)	break ;;
 	esac
@@ -131,6 +141,7 @@ shift
 
 # All the rest are remote heads
 test "$#" = 0 && usage ;# we need at least one remote head.
+test "$rloga" = '' && rloga="merge: $@"
 
 remoteheads=
 for remote
@@ -316,7 +327,7 @@ if test '' != "$result_tree"
 then
     parents=$(git-show-branch --independent "$head" "$@" | sed -e 's/^/-p /')
     result_commit=$(echo "$merge_msg" | git-commit-tree $result_tree $parents) || exit
-    finish "$result_commit" "Merge $result_commit, made by $wt_strategy."
+    finish "$result_commit" "Merge made by $wt_strategy."
     dropsave
     exit 0
 fi
diff --git a/git-pull.sh b/git-pull.sh
index d337bf4..f380437 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -102,5 +102,6 @@ case "$strategy_args" in
 esac
 
 merge_name=$(git-fmt-merge-msg <"$GIT_DIR/FETCH_HEAD") || exit
-git-merge $no_summary $no_commit $squash $strategy_args \
+git-merge "--reflog-action=pull $*" \
+	$no_summary $no_commit $squash $strategy_args \
 	"$merge_name" HEAD $merge_head
-- 
1.4.1.gc48f

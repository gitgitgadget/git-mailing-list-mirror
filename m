X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Return non-zero status from pull if merge fails.
Date: Tue, 7 Nov 2006 13:10:53 -0500
Message-ID: <20061107181053.GA26856@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 7 Nov 2006 18:11:31 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
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
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31083>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhVPs-0004uU-LN for gcvg-git@gmane.org; Tue, 07 Nov
 2006 19:11:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965685AbWKGSK7 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 7 Nov 2006
 13:10:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965686AbWKGSK6
 (ORCPT <rfc822;git-outgoing>); Tue, 7 Nov 2006 13:10:58 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:63160 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S965685AbWKGSK5
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 7 Nov 2006 13:10:57 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GhVPN-0003z1-6Z; Tue, 07 Nov 2006 13:10:49 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 A148420E487; Tue,  7 Nov 2006 13:10:53 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

If the merge operation fails during git-pull it usually exits with a
non-zero exit status to let the caller know it failed.  But git-pull
tossed that status away and always returned 0 (success), leading to
confusing output in any higher level interface which supplied both
the console output (showing the merge failure) and the exit status
(showing success).

So now git-pull just exec's git-merge, allowing its exit status to
be reported directly to the caller.

There were also a number of cases within git-merge which terminated
with a success (0) exit status despite having been caused by failure
to merge.  This is equally misleading and should return 1 instead.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 git-merge.sh |   10 +++++-----
 git-pull.sh  |    2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/git-merge.sh b/git-merge.sh
index cb09438..7725908 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -203,7 +203,7 @@ f,*)
 	git-update-index --refresh 2>/dev/null
 	new_head=$(git-rev-parse --verify "$1^0") &&
 	git-read-tree -u -v -m $head "$new_head" &&
-	finish "$new_head" "Fast forward"
+	finish "$new_head" "Fast forward" || exit 1
 	dropsave
 	exit 0
 	;;
@@ -214,7 +214,7 @@ f,*)
 ?,1,*,)
 	# We are not doing octopus, not fast forward, and have only
 	# one common.  See if it is really trivial.
-	git var GIT_COMMITTER_IDENT >/dev/null || exit
+	git var GIT_COMMITTER_IDENT >/dev/null || exit 1
 
 	echo "Trying really trivial in-index merge..."
 	git-update-index --refresh 2>/dev/null
@@ -225,7 +225,7 @@ f,*)
 	    result_commit=$(
 	        echo "$merge_msg" |
 	        git-commit-tree $result_tree -p HEAD -p "$1"
-	    ) || exit
+	    ) || exit 1
 	    finish "$result_commit" "In-index merge"
 	    dropsave
 	    exit 0
@@ -253,7 +253,7 @@ f,*)
 esac
 
 # We are going to make a new commit.
-git var GIT_COMMITTER_IDENT >/dev/null || exit
+git var GIT_COMMITTER_IDENT >/dev/null || exit 1
 
 # At this point, we need a real merge.  No matter what strategy
 # we use, it would operate on the index, possibly affecting the
@@ -327,7 +327,7 @@ done
 if test '' != "$result_tree"
 then
     parents=$(git-show-branch --independent "$head" "$@" | sed -e 's/^/-p /')
-    result_commit=$(echo "$merge_msg" | git-commit-tree $result_tree $parents) || exit
+    result_commit=$(echo "$merge_msg" | git-commit-tree $result_tree $parents) || exit 1
     finish "$result_commit" "Merge made by $wt_strategy."
     dropsave
     exit 0
diff --git a/git-pull.sh b/git-pull.sh
index ed04e7d..d10fcdd 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -102,6 +102,6 @@ case "$strategy_args" in
 esac
 
 merge_name=$(git-fmt-merge-msg <"$GIT_DIR/FETCH_HEAD") || exit
-git-merge "--reflog-action=pull $*" \
+exec git-merge "--reflog-action=pull $*" \
 	$no_summary $no_commit $squash $strategy_args \
 	"$merge_name" HEAD $merge_head
-- 

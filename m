From: Shawn Pearce <spearce@spearce.org>
Subject: [PATCH 3/5] Include ref log detail in commit, reset, etc.
Date: Fri, 19 May 2006 05:16:18 -0400
Message-ID: <20060519091618.GK22257@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 19 11:16:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fh164-0008Gk-7L
	for gcvg-git@gmane.org; Fri, 19 May 2006 11:16:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbWESJQW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 May 2006 05:16:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWESJQW
	(ORCPT <rfc822;git-outgoing>); Fri, 19 May 2006 05:16:22 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:20939 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751285AbWESJQV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 May 2006 05:16:21 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1Fh15k-0005iq-RC; Fri, 19 May 2006 05:16:17 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 1C91B212691; Fri, 19 May 2006 05:16:18 -0400 (EDT)
To: Junio Hamano <junkio@cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20340>

When updating a ref at the direction of the user include a reason why
head was changed as part of the ref log (assuming it was enabled).

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>

---

 git-am.sh         |    2 +-
 git-applypatch.sh |    2 +-
 git-branch.sh     |    2 +-
 git-commit.sh     |    3 ++-
 git-reset.sh      |    2 +-
 5 files changed, 6 insertions(+), 5 deletions(-)

2a83d6835922e222caadf03b25ebc72e773291ff
diff --git a/git-am.sh b/git-am.sh
index 97ec2d0..4232e27 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -413,7 +413,7 @@ do
 	parent=$(git-rev-parse --verify HEAD) &&
 	commit=$(git-commit-tree $tree -p $parent <"$dotest/final-commit") &&
 	echo Committed: $commit &&
-	git-update-ref HEAD $commit $parent ||
+	git-update-ref -m "am: $SUBJECT" HEAD $commit $parent ||
 	stop_here $this
 
 	if test -x "$GIT_DIR"/hooks/post-applypatch
diff --git a/git-applypatch.sh b/git-applypatch.sh
index 12cab1e..e4b0947 100755
--- a/git-applypatch.sh
+++ b/git-applypatch.sh
@@ -204,7 +204,7 @@ echo Wrote tree $tree
 parent=$(git-rev-parse --verify HEAD) &&
 commit=$(git-commit-tree $tree -p $parent <"$final") || exit 1
 echo Committed: $commit
-git-update-ref HEAD $commit $parent || exit
+git-update-ref -m "applypatch: $SUBJECT" HEAD $commit $parent || exit
 
 if test -x "$GIT_DIR"/hooks/post-applypatch
 then
diff --git a/git-branch.sh b/git-branch.sh
index 134e68c..d1e3730 100755
--- a/git-branch.sh
+++ b/git-branch.sh
@@ -117,4 +117,4 @@ then
 		die "cannot force-update the current branch."
 	fi
 fi
-git update-ref "refs/heads/$branchname" $rev
+git update-ref -m "branch: Created from $head" "refs/heads/$branchname" $rev
diff --git a/git-commit.sh b/git-commit.sh
index 6ef1a9d..a4b0a90 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -676,7 +676,8 @@ then
 		rm -f "$TMP_INDEX"
 	fi &&
 	commit=$(cat "$GIT_DIR"/COMMIT_MSG | git-commit-tree $tree $PARENTS) &&
-	git-update-ref HEAD $commit $current &&
+	rlogm=$(sed -e 1q "$GIT_DIR"/COMMIT_MSG) &&
+	git-update-ref -m "commit: $rlogm" HEAD $commit $current &&
 	rm -f -- "$GIT_DIR/MERGE_HEAD" &&
 	if test -f "$NEXT_INDEX"
 	then
diff --git a/git-reset.sh b/git-reset.sh
index 0ee3e3e..296f3b7 100755
--- a/git-reset.sh
+++ b/git-reset.sh
@@ -48,7 +48,7 @@ then
 else
 	rm -f "$GIT_DIR/ORIG_HEAD"
 fi
-git-update-ref HEAD "$rev"
+git-update-ref -m "reset $reset_type $@" HEAD "$rev"
 
 case "$reset_type" in
 --hard )
-- 
1.3.2.g7278

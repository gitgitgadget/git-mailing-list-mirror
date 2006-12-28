From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 2/2] Use branch names in 'git-rebase -m' conflict hunks.
Date: Wed, 27 Dec 2006 20:43:40 -0500
Message-ID: <20061228014340.GB16790@spearce.org>
References: <35ce346ffc16a7c294a8a1e69e604dfec81d288f.1167270210.git.spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 28 02:43:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzkJB-0003C1-1E
	for gcvg-git@gmane.org; Thu, 28 Dec 2006 02:43:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964834AbWL1Bno (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Dec 2006 20:43:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964845AbWL1Bno
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Dec 2006 20:43:44 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:37321 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964834AbWL1Bnn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Dec 2006 20:43:43 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GzkJ0-0004Ys-RQ; Wed, 27 Dec 2006 20:43:38 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A31C020FB65; Wed, 27 Dec 2006 20:43:40 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <35ce346ffc16a7c294a8a1e69e604dfec81d288f.1167270210.git.spearce@spearce.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35503>

If a three-way merge in git-rebase generates a conflict then we
should take advantage of git-merge-recursive's ability to include
the branch name of each side of the conflict hunk by setting the
GITHEAD_* environment variables.

In the case of rebase there aren't really two clear branches; we
have the branch we are rebasing onto, and we have the branch we are
currently rebasing.  Since most conflicts will be arising between
the user's current branch and the branch they are rebasing onto
we assume the stuff that isn't in the current commit is the "onto"
branch and the stuff in the current commit is the "current" branch.

This assumption may however come up wrong if the user resolves one
conflict in such a way that it conflicts again on a future commit
also being rebased.  In this case the user's prior resolution will
appear to be in the "onto" part of the hunk.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 git-rebase.sh |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index b99f1e3..1f00cb0 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -80,10 +80,18 @@ continue_merge () {
 call_merge () {
 	cmt="$(cat $dotest/cmt.$1)"
 	echo "$cmt" > "$dotest/current"
-	git-merge-$strategy "$cmt^" -- HEAD "$cmt"
+	hd=$(git-rev-parse --verify HEAD)
+	cmt_name=$(git-symbolic-ref HEAD)
+	msgnum=$(cat $dotest/msgnum)
+	end=$(cat $dotest/end)
+	eval GITHEAD_$cmt='"${cmt_name##refs/heads/}~$(($end - $msgnum))"'
+	eval GITHEAD_$hd='"$(cat $dotest/onto_name)"'
+	export GITHEAD_$cmt GITHEAD_$hd
+	git-merge-$strategy "$cmt^" -- "$hd" "$cmt"
 	rv=$?
 	case "$rv" in
 	0)
+		unset GITHEAD_$cmt GITHEAD_$hd
 		return
 		;;
 	1)
@@ -316,6 +324,7 @@ fi
 
 mkdir -p "$dotest"
 echo "$onto" > "$dotest/onto"
+echo "$onto_name" > "$dotest/onto_name"
 prev_head=`git-rev-parse HEAD^0`
 echo "$prev_head" > "$dotest/prev_head"
 
-- 
1.4.4.3.gd2e4

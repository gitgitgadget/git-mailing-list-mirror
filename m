From: Shawn Pearce <spearce@spearce.org>
Subject: Log ref changes made by resolve.
Date: Tue, 11 Jul 2006 02:25:09 -0400
Message-ID: <20060711062509.GC11822@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 11 08:25:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0BgR-0001IG-Cy
	for gcvg-git@gmane.org; Tue, 11 Jul 2006 08:25:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965221AbWGKGZU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Jul 2006 02:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965224AbWGKGZT
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Jul 2006 02:25:19 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:22723 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S965221AbWGKGZS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jul 2006 02:25:18 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1G0BgI-0007Oo-Bs; Tue, 11 Jul 2006 02:25:14 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 4580E20E43C; Tue, 11 Jul 2006 02:25:09 -0400 (EDT)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23690>

Since git-resolve is essentially a form of git-merge record any
ref updates it makes similiar to how git-merge would record them.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 I have to ask:  Should git-resolve just be calling git-merge?  It
 does a fraction of what git-merge does yet it also can do the
 basic fast-forward and in-index merge that git-merge does...

 git-resolve.sh |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/git-resolve.sh b/git-resolve.sh
index 1c7aaef..a7bc680 100755
--- a/git-resolve.sh
+++ b/git-resolve.sh
@@ -15,6 +15,7 @@ dropheads() {
 
 head=$(git-rev-parse --verify "$1"^0) &&
 merge=$(git-rev-parse --verify "$2"^0) &&
+merge_name="$2" &&
 merge_msg="$3" || usage
 
 #
@@ -43,7 +44,8 @@ case "$common" in
 "$head")
 	echo "Updating from $head to $merge"
 	git-read-tree -u -m $head $merge || exit 1
-	git-update-ref HEAD "$merge" "$head"
+	git-update-ref -m "resolve $merge_name: Fast forward" \
+		HEAD "$merge" "$head"
 	git-diff-tree -p $head $merge | git-apply --stat
 	dropheads
 	exit 0
@@ -100,6 +102,7 @@ if [ $? -ne 0 ]; then
 fi
 result_commit=$(echo "$merge_msg" | git-commit-tree $result_tree -p $head -p $merge)
 echo "Committed merge $result_commit"
-git-update-ref HEAD "$result_commit" "$head"
+git-update-ref -m "resolve $merge_name: In-index merge" \
+	HEAD "$result_commit" "$head"
 git-diff-tree -p $head $result_commit | git-apply --stat
 dropheads
-- 
1.4.1.gc48f

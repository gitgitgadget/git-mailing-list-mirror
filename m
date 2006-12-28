From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 11/11] Improve merge performance by avoiding in-index merges.
Date: Thu, 28 Dec 2006 02:35:34 -0500
Message-ID: <20061228073534.GK17867@spearce.org>
References: <9847899e4ba836980dbfed6d0ea1c82f31f21456.1167290864.git.spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 28 08:35:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gzpnl-0000za-Ui
	for gcvg-git@gmane.org; Thu, 28 Dec 2006 08:35:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964996AbWL1Hfm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Dec 2006 02:35:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964998AbWL1Hfm
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Dec 2006 02:35:42 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:45856 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964996AbWL1Hfl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Dec 2006 02:35:41 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GzpnA-0007zH-Mw; Thu, 28 Dec 2006 02:35:12 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 0DD6320FB65; Thu, 28 Dec 2006 02:35:34 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <9847899e4ba836980dbfed6d0ea1c82f31f21456.1167290864.git.spearce@spearce.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35531>

In the early days of Git we performed a 3-way read-tree based merge
before attempting any specific merge strategy, as our core merge
strategies of merge-one-file and merge-recursive were slower script
based programs which took far longer to execute.  This was a good
performance optimization in the past, as most merges were able to
be handled strictly by `read-tree -m -u`.

However now that merge-recursive is a C based program which performs
a full 3-way read-tree before it starts running we need to pay the
cost of the 3-way read-tree twice if we have to do any sort of file
level merging.  This slows down some classes of simple merges which
`read-tree -m -u` could not handle but which merge-recursive does
automatically.

For a really trivial merge which can be handled entirely by
`read-tree -m -u`, skipping the read-tree and just going directly
into merge-recursive saves on average 50 ms on my PowerPC G4 system.
May sound odd, but it does appear to be true.

In a really simple merge which needs to use merge-recursive to handle
a file that was modified on both branches, skipping the read-tree
in git-merge saves on average almost 100 ms (on the same PowerPC G4)
as we avoid doing some work twice.

We only avoid `read-tree -m -u` if the only strategy to use is
merge-recursive, as not all merge strategies perform as well as
merge-recursive does.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 git-merge.sh |   39 ++++++++++++++++++++++-----------------
 1 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/git-merge.sh b/git-merge.sh
index a8f673e..74d4fb0 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -341,23 +341,28 @@ f,*)
 ?,1,*,)
 	# We are not doing octopus, not fast forward, and have only
 	# one common.  See if it is really trivial.
-	git var GIT_COMMITTER_IDENT >/dev/null || exit
-
-	echo "Trying really trivial in-index merge..."
-	git-update-index --refresh 2>/dev/null
-	if git-read-tree --trivial -m -u -v $common $head "$1" &&
-	   result_tree=$(git-write-tree)
-	then
-	    echo "Wonderful."
-	    result_commit=$(
-	        echo "$merge_msg" |
-	        git-commit-tree $result_tree -p HEAD -p "$1"
-	    ) || exit
-	    finish "$result_commit" "In-index merge"
-	    dropsave
-	    exit 0
-	fi
-	echo "Nope."
+	case "$use_strategies" in
+	recursive|'recursive '|recur|'recur ')
+		: run merge later
+		;;
+	*)
+		git var GIT_COMMITTER_IDENT >/dev/null || exit
+		echo "Trying really trivial in-index merge..."
+		git-update-index --refresh 2>/dev/null
+		if git-read-tree --trivial -m -u -v $common $head "$1" &&
+		   result_tree=$(git-write-tree)
+		then
+			echo "Wonderful."
+			result_commit=$(
+				echo "$merge_msg" |
+				git-commit-tree $result_tree -p HEAD -p "$1"
+			) || exit
+			finish "$result_commit" "In-index merge"
+			dropsave
+			exit 0
+		fi
+		echo "Nope."
+	esac
 	;;
 *)
 	# An octopus.  If we can reach all the remote we are up to date.
-- 
1.4.4.3.gd2e4

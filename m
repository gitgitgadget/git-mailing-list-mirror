From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 7/11] Avoid git-fetch in `git-pull .` when possible.
Date: Thu, 28 Dec 2006 02:35:17 -0500
Message-ID: <20061228073517.GG17867@spearce.org>
References: <9847899e4ba836980dbfed6d0ea1c82f31f21456.1167290864.git.spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 28 08:35:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzpnV-0000xI-Us
	for gcvg-git@gmane.org; Thu, 28 Dec 2006 08:35:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964995AbWL1HfX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Dec 2006 02:35:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964993AbWL1HfW
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Dec 2006 02:35:22 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:45833 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964995AbWL1HfV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Dec 2006 02:35:21 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1Gzpmt-0007y2-T2; Thu, 28 Dec 2006 02:34:52 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3B93620FB65; Thu, 28 Dec 2006 02:35:17 -0500 (EST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35529>

Users who merge frequently from remote repositories tend to prefer
`git-pull .` over `git-merge` for local merges, as the pull interface
is then consistent with how the user performs merges from remote
repositories.

Unfortunately `git-pull .` has a (small) amount of overhead on top of
`git-merge` as it needs to first invoke git-fetch to prepare the
FETCH_HEAD file.  However we can easily detect this special case
of a local merge and jump directly into git-merge, bypassing that
overhead.

This change also allows users of `git-pull .` to take advantage of
the change made in commit e0ec1819, where git-merge uses the local
branch name in conflict hunks if it is invoked as a porcelain,
rather than as a plumbing.

Users may also now use `git-pull . foo~3` to merge the early part
of branch foo.  This was not previously possible as git-fetch does
not know how to fetch foo~3 from a repository.

Unfortunately we cannot use this git-fetch bypass if the user is
also updating some sort of tracking branch in the local repository
as part of the pull from the local repository.  This however is a
rather crazy usage of `git-pull .`, but we used to support it, so
we issue a silly warning message and use the older-style git-fetch
path to continue supporting it.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 git-pull.sh |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 28d0819..8c94fef 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -45,6 +45,33 @@ do
 	shift
 done
 
+if test "X$1" = X.
+then
+	# We are merging from this repository.  We can avoid fetch
+	# and go right into merge if the user isn't doing something
+	# odd like asking us to also update tracking branches in
+	# this repository as part of the pull.  Yeah, they probably
+	# shouldn't do that - but we allowed it in the past...
+	#
+	direct_merge=1
+	for remote
+	do
+		case "$remote" in
+		*:*) direct_merge=0; break;;
+		esac
+	done
+	if test $direct_merge = 1
+	then
+		shift
+		exec git-merge \
+			$no_summary $no_commit $squash $strategy_args \
+			"$@"
+	else
+		echo >&2 "Clever... Updating tracking branch while pulling from yourself."
+		echo >&2
+	fi
+fi
+
 orig_head=$(git-rev-parse --verify HEAD 2>/dev/null)
 git-fetch --update-head-ok "$@" || exit 1
 
-- 
1.4.4.3.gd2e4

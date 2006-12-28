From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 10/11] Use merge-recursive in git-am -3.
Date: Thu, 28 Dec 2006 02:35:27 -0500
Message-ID: <20061228073527.GJ17867@spearce.org>
References: <9847899e4ba836980dbfed6d0ea1c82f31f21456.1167290864.git.spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 28 08:35:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gzpng-0000zP-Kr
	for gcvg-git@gmane.org; Thu, 28 Dec 2006 08:35:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964955AbWL1Hfe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Dec 2006 02:35:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965000AbWL1Hfe
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Dec 2006 02:35:34 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:45846 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964997AbWL1Hfd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Dec 2006 02:35:33 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1Gzpn5-0007ye-7v; Thu, 28 Dec 2006 02:35:04 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 8997320FB65; Thu, 28 Dec 2006 02:35:27 -0500 (EST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35532>

By switching from merge-resolve to merge-recursive in the 3-way
fallback behavior of git-am we gain a few benefits:

 * renames are automatically handled, like in rebase -m;
 * conflict hunks can reference the patch name;
 * its faster on Cygwin (less forks).

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 git-am.sh |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index c3bbd78..7c0bb60 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -88,10 +88,12 @@ It does not apply to blobs recorded in its index."
     # This is not so wrong.  Depending on which base we picked,
     # orig_tree may be wildly different from ours, but his_tree
     # has the same set of wildly different changes in parts the
-    # patch did not touch, so resolve ends up canceling them,
+    # patch did not touch, so recursive ends up canceling them,
     # saying that we reverted all those changes.
 
-    git-merge-resolve $orig_tree -- HEAD $his_tree || {
+    eval GITHEAD_$his_tree='"$SUBJECT"'
+    export GITHEAD_$his_tree
+    git-merge-recursive $orig_tree -- HEAD $his_tree || {
 	    if test -d "$GIT_DIR/rr-cache"
 	    then
 		git-rerere
@@ -99,6 +101,7 @@ It does not apply to blobs recorded in its index."
 	    echo Failed to merge in the changes.
 	    exit 1
     }
+    unset GITHEAD_$his_tree
 }
 
 prec=4
-- 
1.4.4.3.gd2e4

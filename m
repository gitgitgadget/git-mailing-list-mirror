From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 1/2] Fix long running merge base computations
Date: Wed, 18 Mar 2009 11:01:48 -0700
Message-ID: <1237399309-29493-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 19:03:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lk075-0002TA-6a
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 19:03:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754161AbZCRSBx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 14:01:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753216AbZCRSBw
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 14:01:52 -0400
Received: from george.spearce.org ([209.20.77.23]:42371 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751361AbZCRSBv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 14:01:51 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 1D0CB38239; Wed, 18 Mar 2009 18:01:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id A3F43381D3;
	Wed, 18 Mar 2009 18:01:49 +0000 (UTC)
X-Mailer: git-send-email 1.6.2.1.337.g6270ba
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113643>

If a part of the project history is reachable by more than one
path through the revision graph, we only need to traverse down
it once through the first detected path when marking parents
as reachable from an input branch.

Previously, JGit recomputed the entire project history for each
path it was reachable through.  On linux-2.6 based histories we
got stuck for hours computing a merge base, as we kept passing
back through the same sections of the revision graph.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../spearce/jgit/revwalk/MergeBaseGenerator.java   |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/MergeBaseGenerator.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/MergeBaseGenerator.java
index 1676caa..2eb9688 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/MergeBaseGenerator.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/MergeBaseGenerator.java
@@ -184,7 +184,9 @@ private void carryOntoHistory(RevCommit c, final int carry) {
 	}
 
 	private boolean carryOntoOne(final RevCommit p, final int carry) {
+		final boolean haveAll = (p.flags & carry) == carry;
 		p.flags |= carry;
+
 		if ((p.flags & POPPED) != 0 && (carry & MERGE_BASE) == 0
 				&& (p.flags & branchMask) == branchMask) {
 			// We were popped without being a merge base, but we just got
@@ -197,6 +199,11 @@ private boolean carryOntoOne(final RevCommit p, final int carry) {
 			carryOntoHistory(p, branchMask | MERGE_BASE);
 			return true;
 		}
-		return false;
+
+		// If we already had all carried flags, our parents do too.
+		// Return true to stop the caller from running down this leg
+		// of the revision graph any further.
+		//
+		return haveAll;
 	}
 }
-- 
1.6.2.1.337.g6270ba

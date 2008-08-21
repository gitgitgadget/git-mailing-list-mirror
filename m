From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 3/4] Micro-optimize TreeWalk's exitSubtree implementation
Date: Thu, 21 Aug 2008 13:57:37 -0700
Message-ID: <1219352258-15431-3-git-send-email-spearce@spearce.org>
References: <1219352258-15431-1-git-send-email-spearce@spearce.org>
 <1219352258-15431-2-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 22:59:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWHFL-0002hz-IE
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 22:59:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755004AbYHUU5p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 16:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753499AbYHUU5p
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 16:57:45 -0400
Received: from george.spearce.org ([209.20.77.23]:41821 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754763AbYHUU5l (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 16:57:41 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 8983938379; Thu, 21 Aug 2008 20:57:40 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 5BA7E38368;
	Thu, 21 Aug 2008 20:57:39 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.112.g9c75
In-Reply-To: <1219352258-15431-2-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93207>

Rather than recomputing the min over again we can take the hint that
the prior min (the one that describes the tree we just left) must be
one that matches itself.  There may be more than one such case, as a
min could be found and match itself and later another min is found.
So we fall back into a pathCompare if we identify more than one.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/treewalk/TreeWalk.java    |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java
index 6d0ef02..ef27e4e 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java
@@ -722,11 +722,19 @@ void skipEntriesEqual() throws CorruptObjectException {
 		}
 	}
 
-	private void exitSubtree() throws CorruptObjectException {
+	private void exitSubtree() {
 		depth--;
 		for (int i = 0; i < trees.length; i++)
 			trees[i] = trees[i].parent;
-		currentHead = min();
+
+		AbstractTreeIterator minRef = null;
+		for (final AbstractTreeIterator t : trees) {
+			if (t.matches != t)
+				continue;
+			if (minRef == null || t.pathCompare(minRef) < 0)
+				minRef = t;
+		}
+		currentHead = minRef;
 	}
 
 	private CanonicalTreeParser parserFor(final ObjectId id)
-- 
1.6.0.112.g9c75

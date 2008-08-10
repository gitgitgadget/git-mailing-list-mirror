From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [EGIT PATCH 06/11] Add getTree to TreeWalk for locating the current iterator instance
Date: Sun, 10 Aug 2008 01:46:21 -0700
Message-ID: <1218357986-19671-7-git-send-email-spearce@spearce.org>
References: <1218357986-19671-1-git-send-email-spearce@spearce.org>
 <1218357986-19671-2-git-send-email-spearce@spearce.org>
 <1218357986-19671-3-git-send-email-spearce@spearce.org>
 <1218357986-19671-4-git-send-email-spearce@spearce.org>
 <1218357986-19671-5-git-send-email-spearce@spearce.org>
 <1218357986-19671-6-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 10 10:47:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KS6aX-0001pt-9k
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 10:47:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752597AbYHJIqn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 04:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752365AbYHJIqm
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 04:46:42 -0400
Received: from george.spearce.org ([209.20.77.23]:51281 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752074AbYHJIqb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 04:46:31 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 4EBB538379; Sun, 10 Aug 2008 08:46:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id A42D7381FD;
	Sun, 10 Aug 2008 08:46:30 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.rc2.219.g1250ab
In-Reply-To: <1218357986-19671-6-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91813>

Since TreeWalk creates new child iterators as it dives into a subtree
(and pops them when it comes out of the subtree) we must allow callers
to locate their current iterator if they need additional APIs from it.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/treewalk/TreeWalk.java    |   23 ++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java
index 7ea16b5..9f373e6 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java
@@ -413,6 +413,29 @@ public class TreeWalk {
 	}
 
 	/**
+	 * Obtain the tree iterator for the current entry.
+	 * <p>
+	 * Entering into (or exiting out of) a subtree causes the current tree
+	 * iterator instance to be changed for the nth tree. This allows the tree
+	 * iterators to manage only one list of items, with the diving handled by
+	 * recursive trees.
+	 * 
+	 * @param <T>
+	 *            type of the tree iterator expected by the caller.
+	 * @param nth
+	 *            tree to obtain the current iterator of.
+	 * @param clazz
+	 *            type of the tree iterator expected by the caller.
+	 * @return r the current iterator of the requested type; null if the tree
+	 *         has no entry to match the current path.
+	 */
+	public <T extends AbstractTreeIterator> T getTree(final int nth,
+			final Class<T> clazz) {
+		final AbstractTreeIterator t = trees[nth];
+		return t.matches == currentHead ? (T) t : null;
+	}
+
+	/**
 	 * Obtain the raw {@link FileMode} bits for the current entry.
 	 * <p>
 	 * Every added tree supplies mode bits, even if the tree does not contain
-- 
1.6.0.rc2.219.g1250ab

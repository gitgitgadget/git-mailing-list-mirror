From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [EGIT PATCH 04/11] Allow AbstractTreeIterator subclasses to supply their own path array
Date: Sun, 10 Aug 2008 01:46:19 -0700
Message-ID: <1218357986-19671-5-git-send-email-spearce@spearce.org>
References: <1218357986-19671-1-git-send-email-spearce@spearce.org>
 <1218357986-19671-2-git-send-email-spearce@spearce.org>
 <1218357986-19671-3-git-send-email-spearce@spearce.org>
 <1218357986-19671-4-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 10 10:47:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KS6aV-0001pt-Ub
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 10:47:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752267AbYHJIqi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 04:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751977AbYHJIqg
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 04:46:36 -0400
Received: from george.spearce.org ([209.20.77.23]:51273 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752267AbYHJIqa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 04:46:30 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 402C43837C; Sun, 10 Aug 2008 08:46:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 9E22A381FD;
	Sun, 10 Aug 2008 08:46:29 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.rc2.219.g1250ab
In-Reply-To: <1218357986-19671-4-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91819>

Some forms of AbstractTreeIterator may already have the path buffer
they want their child iterator to use in memory when the child is
being created.  Therefore they do not want the existing constructor
as it would modify the parent's path buffer, and force the subclass
to copy the new child's path.

By allowing subclass implementations to define their own path buffer
we must rely on them to do the right thing in terms of setting up a
valid buffer for iteration, but the implementation can avoid copies
and unwanted data changes to the parent array.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../jgit/treewalk/AbstractTreeIterator.java        |   23 ++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/AbstractTreeIterator.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/AbstractTreeIterator.java
index 0c0257c..64bb5be 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/treewalk/AbstractTreeIterator.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/AbstractTreeIterator.java
@@ -146,6 +146,29 @@ public abstract class AbstractTreeIterator {
 	}
 
 	/**
+	 * Create an iterator for a subtree of an existing iterator.
+	 * <p>
+	 * The caller is responsible for setting up the path of the child iterator.
+	 * 
+	 * @param p
+	 *            parent tree iterator.
+	 * @param childPath
+	 *            path array to be used by the child iterator. This path must
+	 *            contain the path from the top of the walk to the first child
+	 *            and must end with a '/'.
+	 * @param childPathOffset
+	 *            position within <code>childPath</code> where the child can
+	 *            insert its data. The value at
+	 *            <code>childPath[childPathOffset-1]</code> must be '/'.
+	 */
+	protected AbstractTreeIterator(final AbstractTreeIterator p,
+			final byte[] childPath, final int childPathOffset) {
+		parent = p;
+		path = childPath;
+		pathOffset = childPathOffset;
+	}
+
+	/**
 	 * Grow the path buffer larger.
 	 * 
 	 * @param len
-- 
1.6.0.rc2.219.g1250ab

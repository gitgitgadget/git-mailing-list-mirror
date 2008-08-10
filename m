From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [EGIT PATCH 03/11] Notify AbstractTreeIterator implementations of skipped tree entries
Date: Sun, 10 Aug 2008 01:46:18 -0700
Message-ID: <1218357986-19671-4-git-send-email-spearce@spearce.org>
References: <1218357986-19671-1-git-send-email-spearce@spearce.org>
 <1218357986-19671-2-git-send-email-spearce@spearce.org>
 <1218357986-19671-3-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 10 10:47:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KS6aU-0001pt-7f
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 10:47:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752419AbYHJIqh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 04:46:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752455AbYHJIqf
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 04:46:35 -0400
Received: from george.spearce.org ([209.20.77.23]:51269 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751977AbYHJIqa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 04:46:30 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id C580A3837B; Sun, 10 Aug 2008 08:46:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 1F89C38375;
	Sun, 10 Aug 2008 08:46:29 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.rc2.219.g1250ab
In-Reply-To: <1218357986-19671-3-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91812>

Some tree iterators may benefit from knowing when their driving TreeWalk
has chosen to skip past their current entry and not report it to client
applications.  This can be useful for an index update scenario where the
client application has applied a TreeFilter to only see the entries that
it wants to modify in this session.

By default the new skip() method just calls next(), as most types of the
tree iterator do not have this distinction between skipped entry and a
non-skipped entry.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../jgit/treewalk/AbstractTreeIterator.java        |   16 ++++++++++++++++
 .../src/org/spearce/jgit/treewalk/TreeWalk.java    |   13 ++++++++++++-
 2 files changed, 28 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/AbstractTreeIterator.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/AbstractTreeIterator.java
index 448c547..0c0257c 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/treewalk/AbstractTreeIterator.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/AbstractTreeIterator.java
@@ -46,6 +46,7 @@ import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.FileMode;
 import org.spearce.jgit.lib.ObjectId;
 import org.spearce.jgit.lib.Repository;
+import org.spearce.jgit.treewalk.filter.TreeFilter;
 
 /**
  * Walks a Git tree (directory) in Git sort order.
@@ -316,4 +317,19 @@ public abstract class AbstractTreeIterator {
 	 *             the tree is invalid.
 	 */
 	public abstract void next() throws CorruptObjectException;
+
+	/**
+	 * Advance to the next tree entry, populating this iterator with its data.
+	 * <p>
+	 * This method behaves like {@link #next()} but is called by
+	 * {@link TreeWalk} only if a {@link TreeFilter} was used and ruled out the
+	 * current entry from the results. In such cases this tree iterator may
+	 * perform special behavior.
+	 * 
+	 * @throws CorruptObjectException
+	 *             the tree is invalid.
+	 */
+	public void skip() throws CorruptObjectException {
+		next();
+	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java
index 42f8b25..7ea16b5 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java
@@ -395,7 +395,7 @@ public class TreeWalk {
 
 				currentHead = t;
 				if (!filter.include(this)) {
-					popEntriesEqual();
+					skipEntriesEqual();
 					continue;
 				}
 
@@ -635,6 +635,17 @@ public class TreeWalk {
 		}
 	}
 
+	private void skipEntriesEqual() throws CorruptObjectException {
+		final AbstractTreeIterator ch = currentHead;
+		for (int i = 0; i < trees.length; i++) {
+			final AbstractTreeIterator t = trees[i];
+			if (t.matches == ch) {
+				t.skip();
+				t.matches = null;
+			}
+		}
+	}
+
 	private void exitSubtree() throws CorruptObjectException {
 		depth--;
 		for (int i = 0; i < trees.length; i++)
-- 
1.6.0.rc2.219.g1250ab

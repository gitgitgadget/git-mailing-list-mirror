From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH] Fix data corruption in DirCacheIterator when EmptyTreeIterator is used
Date: Mon, 11 May 2009 10:52:28 -0700
Message-ID: <1242064348-13197-1-git-send-email-spearce@spearce.org>
Cc: Mark Struberg <struberg@yahoo.de>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon May 11 19:52:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3Zg6-0003JA-Cv
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 19:52:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754270AbZEKRwa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2009 13:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753901AbZEKRwa
	(ORCPT <rfc822;git-outgoing>); Mon, 11 May 2009 13:52:30 -0400
Received: from george.spearce.org ([209.20.77.23]:46954 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751710AbZEKRw3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2009 13:52:29 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 0D84A381FC; Mon, 11 May 2009 17:52:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 31873381D3;
	Mon, 11 May 2009 17:52:29 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.48.g99c76
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118818>

When a DirCacheIterator was wrapped in an EmptyTreeIterator (such
as during a parallel TreeWalk where the other trees contain a
path that does not appear in the DirCachIterator) we corrupted
the DirCacheEntry path buffers by overwriting part of file name
components with '/' to match the other tree iterators' path length.

This happened because DirCacheIterator violated the iterator
assumption that the path buffer is always mutable.  Instead of
creating a mutable path, DirCacheIterator reused the path buffer
from the DirCacheEntry or the DirCacheTree.  These reused byte
arrays aren't mutable.

By delegating the EmptyTreeIterator creation to each iterator type
we can permit DirCacheIterator to control how it builds the empty
tree for the caller, ensuring that it copies the path buffer before
writing the '/' suffix onto it.

When EmptyTreeIterator has to grow the path buffer to create a new
iterator around itself, we can't just blindly replace every parent
iterator buffer with the larger path buffer.  DirCacheIterators will
be using a different path buffer, and they want to retain their
old path buffer, not the new larger buffer.

Noticed-by: Mark Struberg <struberg@yahoo.de>
Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 So uhm, test cases...  I can't come up with a simple test case
 which causes the data corruption, but Mark found a very complex
 one in egit.git.

 Now that I understand what the heck was wrong, its obvious we
 need to do this, as DirCacheIterator was breaking the contract.

 I'd love to have a test case, but I just spent an hour trying to
 come up with one and failed.  I'd rather have the data corruption
 fix without tests than not at all, since its obviously wrong as-is.
 But if you want a test, propose one.  I'm just not seeing the
 magic necessary to get the corruption to trigger.

 .../spearce/jgit/dircache/DirCacheIterator.java    |    9 ++++++++
 .../jgit/treewalk/AbstractTreeIterator.java        |   19 +++++++++++++---
 .../spearce/jgit/treewalk/EmptyTreeIterator.java   |   22 ++++++++++++++++++++
 .../src/org/spearce/jgit/treewalk/TreeWalk.java    |    2 +-
 4 files changed, 47 insertions(+), 5 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheIterator.java b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheIterator.java
index 356d735..6fb9510 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheIterator.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheIterator.java
@@ -45,6 +45,7 @@
 import org.spearce.jgit.lib.FileMode;
 import org.spearce.jgit.lib.Repository;
 import org.spearce.jgit.treewalk.AbstractTreeIterator;
+import org.spearce.jgit.treewalk.EmptyTreeIterator;
 
 /**
  * Iterate a {@link DirCache} as part of a <code>TreeWalk</code>.
@@ -126,6 +127,14 @@ public AbstractTreeIterator createSubtreeIterator(final Repository repo)
 	}
 
 	@Override
+	public EmptyTreeIterator createEmptyTreeIterator() {
+		final byte[] n = new byte[Math.max(pathLen + 1, DEFAULT_PATH_SIZE)];
+		System.arraycopy(path, 0, n, 0, pathLen);
+		n[pathLen] = '/';
+		return new EmptyTreeIterator(this, n, pathLen + 1);
+	}
+
+	@Override
 	public byte[] idBuffer() {
 		if (currentSubtree != null)
 			return subtreeId;
diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/AbstractTreeIterator.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/AbstractTreeIterator.java
index 2ff3b99..057250e 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/treewalk/AbstractTreeIterator.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/AbstractTreeIterator.java
@@ -73,7 +73,8 @@
  * @see CanonicalTreeParser
  */
 public abstract class AbstractTreeIterator {
-	static final int DEFAULT_PATH_SIZE = 128;
+	/** Default size for the {@link #path} buffer. */
+	protected static final int DEFAULT_PATH_SIZE = 128;
 
 	/** A dummy object id buffer that matches the zero ObjectId. */
 	protected static final byte[] zeroid = new byte[Constants.OBJECT_ID_LENGTH];
@@ -251,9 +252,10 @@ protected AbstractTreeIterator(final AbstractTreeIterator p,
 	 *            be moved into the larger buffer.
 	 */
 	protected void growPath(final int len) {
-		final byte[] n = new byte[path.length << 1];
-		System.arraycopy(path, 0, n, 0, len);
-		for (AbstractTreeIterator p = this; p != null; p = p.parent)
+		final byte[] o = path;
+		final byte[] n = new byte[o.length << 1];
+		System.arraycopy(o, 0, n, 0, len);
+		for (AbstractTreeIterator p = this; p != null && p.path == o; p = p.parent)
 			p.path = n;
 	}
 
@@ -400,6 +402,15 @@ public abstract AbstractTreeIterator createSubtreeIterator(Repository repo)
 			throws IncorrectObjectTypeException, IOException;
 
 	/**
+	 * Create a new iterator as though the current entry were a subtree.
+	 *
+	 * @return a new empty tree iterator.
+	 */
+	public EmptyTreeIterator createEmptyTreeIterator() {
+		return new EmptyTreeIterator(this);
+	}
+
+	/**
 	 * Create a new iterator for the current entry's subtree.
 	 * <p>
 	 * The parent reference of the iterator must be <code>this</code>, otherwise
diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/EmptyTreeIterator.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/EmptyTreeIterator.java
index eaca04e..cc5ea99 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/treewalk/EmptyTreeIterator.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/EmptyTreeIterator.java
@@ -57,6 +57,28 @@ EmptyTreeIterator(final AbstractTreeIterator p) {
 		pathLen = pathOffset;
 	}
 
+	/**
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
+	public EmptyTreeIterator(final AbstractTreeIterator p,
+			final byte[] childPath, final int childPathOffset) {
+		super(p, childPath, childPathOffset);
+		pathLen = childPathOffset - 1;
+	}
+
 	@Override
 	public AbstractTreeIterator createSubtreeIterator(final Repository repo)
 			throws IncorrectObjectTypeException, IOException {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java
index a41ca58..250b213 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java
@@ -800,7 +800,7 @@ public void enterSubtree() throws MissingObjectException,
 			if (t.matches == ch && !t.eof() && FileMode.TREE.equals(t.mode))
 				n = t.createSubtreeIterator(db, idBuffer, curs);
 			else
-				n = new EmptyTreeIterator(t);
+				n = t.createEmptyTreeIterator();
 			tmp[i] = n;
 		}
 		depth++;
-- 
1.6.3.48.g99c76

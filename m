From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 09/14] Refactor AbstractTreeIterator semantics to start on first entry
Date: Mon, 18 Aug 2008 16:53:17 -0700
Message-ID: <1219103602-32222-10-git-send-email-spearce@spearce.org>
References: <1219103602-32222-1-git-send-email-spearce@spearce.org>
 <1219103602-32222-2-git-send-email-spearce@spearce.org>
 <1219103602-32222-3-git-send-email-spearce@spearce.org>
 <1219103602-32222-4-git-send-email-spearce@spearce.org>
 <1219103602-32222-5-git-send-email-spearce@spearce.org>
 <1219103602-32222-6-git-send-email-spearce@spearce.org>
 <1219103602-32222-7-git-send-email-spearce@spearce.org>
 <1219103602-32222-8-git-send-email-spearce@spearce.org>
 <1219103602-32222-9-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 01:55:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVEZ7-0006i3-0c
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 01:55:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754007AbYHRXxo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 19:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753620AbYHRXxn
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 19:53:43 -0400
Received: from george.spearce.org ([209.20.77.23]:45158 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753655AbYHRXx3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 19:53:29 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id E5A5338389; Mon, 18 Aug 2008 23:53:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 56D8638376;
	Mon, 18 Aug 2008 23:53:25 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.87.g2858d
In-Reply-To: <1219103602-32222-9-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92775>

The AbstractTreeIterator implementations now start on their first
entry at construction time, instead of relying on TreeWalk to do
an initial "next()" invocation.  This cleans up some of the code
and makes the iterators more consistent with each other.

In all implementations the refactoring splits out the advance
portion of next() from the entry parsing portion.  This change
(along with the position semantic change) will permit us to do
reverse iteration in the future, making the iterators all able
to be bi-directional.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../spearce/egit/core/ContainerTreeIterator.java   |    9 +-
 .../jgit/dircache/DirCacheBuilderIteratorTest.java |    2 +-
 .../jgit/dircache/DirCacheIteratorTest.java        |   18 +--
 .../jgit/dircache/DirCacheBuildIterator.java       |    7 +-
 .../spearce/jgit/dircache/DirCacheIterator.java    |   63 +++++------
 .../jgit/treewalk/AbstractTreeIterator.java        |    5 +-
 .../spearce/jgit/treewalk/CanonicalTreeParser.java |   27 +++--
 .../spearce/jgit/treewalk/FileTreeIterator.java    |    5 +-
 .../src/org/spearce/jgit/treewalk/TreeWalk.java    |    4 -
 .../spearce/jgit/treewalk/WorkingTreeIterator.java |  119 ++++++++------------
 10 files changed, 112 insertions(+), 147 deletions(-)

diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/ContainerTreeIterator.java b/org.spearce.egit.core/src/org/spearce/egit/core/ContainerTreeIterator.java
index c4af788..2b7ff3b 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/ContainerTreeIterator.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/ContainerTreeIterator.java
@@ -67,12 +67,14 @@ private static String computePrefix(final IContainer base) {
 	public ContainerTreeIterator(final IContainer base) {
 		super(computePrefix(base));
 		node = base;
+		init(entries());
 	}
 
 	private ContainerTreeIterator(final WorkingTreeIterator p,
 			final IContainer base) {
 		super(p);
 		node = base;
+		init(entries());
 	}
 
 	@Override
@@ -86,16 +88,13 @@ public AbstractTreeIterator createSubtreeIterator(final Repository db)
 					Constants.TYPE_TREE);
 	}
 
-	@Override
-	protected Entry[] getEntries() throws IOException {
+	private Entry[] entries() {
 		final IResource[] all;
 		try {
 //			all = node.members(IContainer.INCLUDE_HIDDEN); 3.4 flag
 			all = node.members(0);
 		} catch (CoreException err) {
-			final IOException ioe = new IOException(err.getMessage());
-			ioe.initCause(err);
-			throw ioe;
+			return EOF;
 		}
 
 		final Entry[] r = new Entry[all.length];
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheBuilderIteratorTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheBuilderIteratorTest.java
index cbcdeb5..162f4ba 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheBuilderIteratorTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheBuilderIteratorTest.java
@@ -74,7 +74,7 @@ public void testPathFilterGroup_DoesNotSkipTail() throws Exception {
 		assertTrue("found " + paths[expIdx], tw.next());
 		final DirCacheIterator c = tw.getTree(0, DirCacheIterator.class);
 		assertNotNull(c);
-		assertEquals(expIdx, c.cachePos);
+		assertEquals(expIdx, c.ptr);
 		assertSame(ents[expIdx], c.getDirCacheEntry());
 		assertEquals(paths[expIdx], tw.getPathString());
 		assertEquals(mode.getBits(), tw.getRawMode(0));
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheIteratorTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheIteratorTest.java
index 62a162f..51b3c5a 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheIteratorTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheIteratorTest.java
@@ -50,7 +50,6 @@ public void testEmptyTree_NoTreeWalk() throws Exception {
 		assertEquals(0, dc.getEntryCount());
 
 		final DirCacheIterator i = new DirCacheIterator(dc);
-		i.next();
 		assertTrue(i.eof());
 	}
 
@@ -79,11 +78,8 @@ public void testNoSubtree_NoTreeWalk() throws Exception {
 
 		final DirCacheIterator i = new DirCacheIterator(dc);
 		int pathIdx = 0;
-		for (;;) {
-			i.next();
-			if (i.eof())
-				break;
-			assertEquals(pathIdx, i.cachePos);
+		for (; !i.eof(); i.next()) {
+			assertEquals(pathIdx, i.ptr);
 			assertSame(ents[pathIdx], i.getDirCacheEntry());
 			pathIdx++;
 		}
@@ -113,7 +109,7 @@ public void testNoSubtree_WithTreeWalk() throws Exception {
 		int pathIdx = 0;
 		while (tw.next()) {
 			assertSame(i, tw.getTree(0, DirCacheIterator.class));
-			assertEquals(pathIdx, i.cachePos);
+			assertEquals(pathIdx, i.ptr);
 			assertSame(ents[pathIdx], i.getDirCacheEntry());
 			assertEquals(paths[pathIdx], tw.getPathString());
 			assertEquals(modes[pathIdx].getBits(), tw.getRawMode(0));
@@ -156,7 +152,7 @@ public void testSingleSubtree_NoRecursion() throws Exception {
 			assertEquals(expPaths[pathIdx], tw.getPathString());
 
 			if (expPos[pathIdx] >= 0) {
-				assertEquals(expPos[pathIdx], i.cachePos);
+				assertEquals(expPos[pathIdx], i.ptr);
 				assertSame(ents[expPos[pathIdx]], i.getDirCacheEntry());
 			} else {
 				assertSame(FileMode.TREE, tw.getFileMode(0));
@@ -192,7 +188,7 @@ public void testSingleSubtree_Recursive() throws Exception {
 		while (tw.next()) {
 			final DirCacheIterator c = tw.getTree(0, DirCacheIterator.class);
 			assertNotNull(c);
-			assertEquals(pathIdx, c.cachePos);
+			assertEquals(pathIdx, c.ptr);
 			assertSame(ents[pathIdx], c.getDirCacheEntry());
 			assertEquals(paths[pathIdx], tw.getPathString());
 			assertEquals(mode.getBits(), tw.getRawMode(0));
@@ -226,7 +222,7 @@ public void testTwoLevelSubtree_Recursive() throws Exception {
 		while (tw.next()) {
 			final DirCacheIterator c = tw.getTree(0, DirCacheIterator.class);
 			assertNotNull(c);
-			assertEquals(pathIdx, c.cachePos);
+			assertEquals(pathIdx, c.ptr);
 			assertSame(ents[pathIdx], c.getDirCacheEntry());
 			assertEquals(paths[pathIdx], tw.getPathString());
 			assertEquals(mode.getBits(), tw.getRawMode(0));
@@ -262,7 +258,7 @@ public void testTwoLevelSubtree_FilterPath() throws Exception {
 			assertTrue(tw.next());
 			final DirCacheIterator c = tw.getTree(0, DirCacheIterator.class);
 			assertNotNull(c);
-			assertEquals(victimIdx, c.cachePos);
+			assertEquals(victimIdx, c.ptr);
 			assertSame(ents[victimIdx], c.getDirCacheEntry());
 			assertEquals(paths[victimIdx], tw.getPathString());
 			assertEquals(mode.getBits(), tw.getRawMode(0));
diff --git a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheBuildIterator.java b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheBuildIterator.java
index 227b64c..aaec4fc 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheBuildIterator.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheBuildIterator.java
@@ -109,7 +109,7 @@ public AbstractTreeIterator createSubtreeIterator(final Repository repo)
 	@Override
 	public void skip() throws CorruptObjectException {
 		if (currentSubtree != null)
-			builder.keep(cachePos, currentSubtree.getEntrySpan());
+			builder.keep(ptr, currentSubtree.getEntrySpan());
 		else
 			builder.add(currentEntry);
 		next();
@@ -117,8 +117,9 @@ public void skip() throws CorruptObjectException {
 
 	@Override
 	public void stopWalk() {
+		final int cur = ptr;
 		final int cnt = cache.getEntryCount();
-		if (cachePos < cnt)
-			builder.keep(cachePos, cnt - cachePos);
+		if (cur < cnt)
+			builder.keep(cur, cnt - cur);
 	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheIterator.java b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheIterator.java
index c093bb2..248ae1e 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheIterator.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheIterator.java
@@ -40,7 +40,6 @@
 import java.io.IOException;
 import java.util.Arrays;
 
-import org.spearce.jgit.errors.CorruptObjectException;
 import org.spearce.jgit.errors.IncorrectObjectTypeException;
 import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.FileMode;
@@ -65,19 +64,19 @@
 	/** The tree this iterator is walking. */
 	private final DirCacheTree tree;
 
+	/** Last position in this tree. */
+	private final int treeEnd;
+
 	/** Special buffer to hold the ObjectId of {@link #currentSubtree}. */
 	private final byte[] subtreeId;
 
 	/** Index of entry within {@link #cache}. */
-	protected int cachePos;
-
-	/** Position of entry within {@link #tree}'s entry span. */
-	private int treePos;
+	protected int ptr;
 
 	/** Next subtree to consider within {@link #tree}. */
-	private int subtreeIdx;
+	private int nextSubtreePos;
 
-	/** The current file entry from {@link #cache}, matching {@link #cachePos}. */
+	/** The current file entry from {@link #cache}. */
 	protected DirCacheEntry currentEntry;
 
 	/** The subtree containing {@link #currentEntry} if this is first entry. */
@@ -96,18 +95,20 @@
 	public DirCacheIterator(final DirCache dc) {
 		cache = dc;
 		tree = dc.getCacheTree(true);
+		treeEnd = tree.getEntrySpan();
 		subtreeId = new byte[Constants.OBJECT_ID_LENGTH];
-		cachePos = -1;
-		treePos = -1;
+		if (!eof())
+			parseEntry();
 	}
 
 	protected DirCacheIterator(final DirCacheIterator p, final DirCacheTree dct) {
 		super(p, p.path, p.pathLen + 1);
 		cache = p.cache;
 		tree = dct;
+		treeEnd = p.ptr + tree.getEntrySpan();
 		subtreeId = p.subtreeId;
-		cachePos = p.cachePos - 1; // back up so first next() call enters it
-		treePos = -1;
+		ptr = p.ptr;
+		parseEntry();
 	}
 
 	@Override
@@ -139,40 +140,31 @@ public int idOffset() {
 
 	@Override
 	public boolean eof() {
-		return treePos >= tree.getEntrySpan();
+		return ptr == treeEnd;
 	}
 
 	@Override
-	public void next() throws CorruptObjectException {
-		if (currentSubtree != null) {
-			// If our last position was a subtree we need to skip over
-			// its entire span to get to the item after the subtree.
-			//
-			final int n = currentSubtree.getEntrySpan();
-			cachePos += n;
-			treePos += n;
-			currentSubtree = null;
-		} else {
-			// Our last position was a file/symlink/gitlink, so we
-			// only skip the one entry.
-			//
-			cachePos++;
-			treePos++;
-		}
-
-		if (treePos >= tree.getEntrySpan())
-			return; // this iterator is now at EOF.
+	public void next() {
+		if (currentSubtree != null)
+			ptr += currentSubtree.getEntrySpan();
+		else
+			ptr++;
+		if (!eof())
+			parseEntry();
+	}
 
-		currentEntry = cache.getEntry(cachePos);
+	private void parseEntry() {
+		currentEntry = cache.getEntry(ptr);
 		final byte[] cep = currentEntry.path;
-		if (subtreeIdx < tree.getChildCount()) {
-			final DirCacheTree s = tree.getChild(subtreeIdx);
+
+		if (nextSubtreePos != tree.getChildCount()) {
+			final DirCacheTree s = tree.getChild(nextSubtreePos);
 			if (s.contains(cep, pathOffset, cep.length)) {
 				// The current position is the first file of this subtree.
 				// Use the subtree instead as the current position.
 				//
 				currentSubtree = s;
-				subtreeIdx++;
+				nextSubtreePos++;
 
 				if (s.isValid())
 					s.getObjectId().copyRawTo(subtreeId, 0);
@@ -191,6 +183,7 @@ public void next() throws CorruptObjectException {
 		mode = currentEntry.getRawMode();
 		path = cep;
 		pathLen = cep.length;
+		currentSubtree = null;
 	}
 
 	/**
diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/AbstractTreeIterator.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/AbstractTreeIterator.java
index e6aa338..208adc7 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/treewalk/AbstractTreeIterator.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/AbstractTreeIterator.java
@@ -53,9 +53,8 @@
 /**
  * Walks a Git tree (directory) in Git sort order.
  * <p>
- * A new iterator instance should be positioned before the first entry. The data
- * about the first entry is not available until after the first call to
- * {@link #next()} is made.
+ * A new iterator instance should be positioned on the first entry, or at eof.
+ * Data for the first entry (if not at eof) should be available immediately.
  * <p>
  * Implementors must walk a tree in the Git sort order, which has the following
  * odd sorting:
diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/CanonicalTreeParser.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/CanonicalTreeParser.java
index 55942ed..ebcc787 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/treewalk/CanonicalTreeParser.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/CanonicalTreeParser.java
@@ -52,7 +52,11 @@
 public class CanonicalTreeParser extends AbstractTreeIterator {
 	private byte[] raw;
 
-	private int rawPtr;
+	/** First offset within {@link #raw} of the current entry's data. */
+	private int currPtr;
+
+	/** Offset one past the current entry (first byte of next entry. */
+	private int nextPtr;
 
 	/** Create a new parser. */
 	public CanonicalTreeParser() {
@@ -71,7 +75,9 @@ private CanonicalTreeParser(final CanonicalTreeParser p) {
 	 */
 	public void reset(final byte[] treeData) {
 		raw = treeData;
-		rawPtr = 0;
+		currPtr = 0;
+		if (!eof())
+			parseEntry();
 	}
 
 	/**
@@ -118,20 +124,21 @@ public CanonicalTreeParser createSubtreeIterator(final Repository repo)
 
 	@Override
 	public int idOffset() {
-		return rawPtr - Constants.OBJECT_ID_LENGTH;
+		return nextPtr - Constants.OBJECT_ID_LENGTH;
 	}
 
 	public boolean eof() {
-		return raw == null;
+		return currPtr == raw.length;
 	}
 
 	public void next() throws CorruptObjectException {
-		int ptr = rawPtr;
-		if (ptr >= raw.length) {
-			raw = null;
-			return;
-		}
+		currPtr = nextPtr;
+		if (!eof())
+			parseEntry();
+	}
 
+	private void parseEntry() {
+		int ptr = currPtr;
 		byte c = raw[ptr++];
 		int tmp = c - '0';
 		for (;;) {
@@ -156,6 +163,6 @@ public void next() throws CorruptObjectException {
 			}
 		}
 		pathLen = tmp;
-		rawPtr = ptr + Constants.OBJECT_ID_LENGTH;
+		nextPtr = ptr + Constants.OBJECT_ID_LENGTH;
 	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/FileTreeIterator.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/FileTreeIterator.java
index 25425dd..2c71151 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/treewalk/FileTreeIterator.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/FileTreeIterator.java
@@ -66,6 +66,7 @@
 	 */
 	public FileTreeIterator(final File root) {
 		directory = root;
+		init(entries());
 	}
 
 	/**
@@ -80,6 +81,7 @@ public FileTreeIterator(final File root) {
 	protected FileTreeIterator(final FileTreeIterator p, final File root) {
 		super(p);
 		directory = root;
+		init(entries());
 	}
 
 	@Override
@@ -88,8 +90,7 @@ public AbstractTreeIterator createSubtreeIterator(final Repository repo)
 		return new FileTreeIterator(this, ((FileEntry) current()).file);
 	}
 
-	@Override
-	protected Entry[] getEntries() {
+	private Entry[] entries() {
 		final File[] all = directory.listFiles();
 		if (all == null)
 			return EOF;
diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java
index 5aabc19..3bdef22 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java
@@ -276,14 +276,12 @@ public void reset(final ObjectId[] ids) throws MissingObjectException,
 				if (o instanceof CanonicalTreeParser) {
 					o.matches = null;
 					((CanonicalTreeParser) o).reset(db, ids[i]);
-					o.next();
 					r[i] = o;
 					continue;
 				}
 			}
 
 			o = parserFor(ids[i]);
-			o.next();
 			r[i] = o;
 		}
 
@@ -340,7 +338,6 @@ public int addTree(final AbstractTreeIterator p)
 		System.arraycopy(trees, 0, newTrees, 0, n);
 		newTrees[n] = p;
 		p.matches = null;
-		p.next();
 
 		trees = newTrees;
 		return n;
@@ -617,7 +614,6 @@ public void enterSubtree() throws MissingObjectException,
 				n = t.createSubtreeIterator(db);
 			else
 				n = new EmptyTreeIterator(t);
-			n.next();
 			tmp[i] = n;
 		}
 		depth++;
diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/WorkingTreeIterator.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/WorkingTreeIterator.java
index f66b5e9..e81ff4a 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/treewalk/WorkingTreeIterator.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/WorkingTreeIterator.java
@@ -63,7 +63,7 @@
  * @see FileTreeIterator
  */
 public abstract class WorkingTreeIterator extends AbstractTreeIterator {
-	/** An empty entry array, suitable for return from {@link #getEntries()}. */
+	/** An empty entry array, suitable for {@link #init(Entry[])}. */
 	protected static final Entry[] EOF = {};
 
 	/** Size we perform file IO in if we have to read and hash a file. */
@@ -72,7 +72,7 @@
 	/** The {@link #idBuffer()} for the current entry. */
 	private byte[] contentId;
 
-	/** Value of {@link #ptr} when {@link #contentId} was last populated. */
+	/** Index within {@link #entries} that {@link #contentId} came from. */
 	private int contentIdFromPtr;
 
 	/** Buffer used to perform {@link #contentId} computations. */
@@ -132,15 +132,12 @@ protected WorkingTreeIterator(final WorkingTreeIterator p) {
 
 	@Override
 	public byte[] idBuffer() {
-		if (contentIdFromPtr == ptr - 1)
+		if (contentIdFromPtr == ptr)
 			return contentId;
-		if (entries == EOF)
-			return zeroid;
-
 		switch (mode & 0170000) {
 		case 0100000: /* normal files */
-			contentIdFromPtr = ptr - 1;
-			return contentId = idBufferBlob(entries[contentIdFromPtr]);
+			contentIdFromPtr = ptr;
+			return contentId = idBufferBlob(entries[ptr]);
 		case 0120000: /* symbolic links */
 			// Java does not support symbolic links, so we should not
 			// have reached this particular part of the walk code.
@@ -235,21 +232,18 @@ public int idOffset() {
 
 	@Override
 	public boolean eof() {
-		return entries == EOF;
+		return ptr == entryCnt;
 	}
 
 	@Override
 	public void next() throws CorruptObjectException {
-		if (entries == null)
-			loadEntries();
-		if (ptr == entryCnt) {
-			entries = EOF;
-			return;
-		}
-		if (entries == EOF)
-			return;
+		ptr++;
+		if (!eof())
+			parseEntry();
+	}
 
-		final Entry e = entries[ptr++];
+	private void parseEntry() {
+		final Entry e = entries[ptr];
 		mode = e.getMode().getBits();
 
 		final int nameLen = e.encodedNameLen;
@@ -338,43 +332,35 @@ static int lastPathChar(final Entry e) {
 		return e.getMode() == FileMode.TREE ? '/' : '\0';
 	}
 
-	private void loadEntries() throws CorruptObjectException {
+	protected void init(final Entry[] list) {
 		// Filter out nulls, . and .. as these are not valid tree entries,
 		// also cache the encoded forms of the path names for efficient use
 		// later on during sorting and iteration.
 		//
-		try {
-			entries = getEntries();
-			int i, o;
-
-			for (i = 0, o = 0; i < entries.length; i++) {
-				final Entry e = entries[i];
-				if (e == null)
-					continue;
-				final String name = e.getName();
-				if (".".equals(name) || "..".equals(name))
-					continue;
-				if (parent == null && ".git".equals(name))
-					continue;
-				if (i != o)
-					entries[o] = e;
-				e.encodeName(nameEncoder);
-				o++;
-			}
-			entryCnt = o;
-			contentIdFromPtr = -1;
-			Arrays.sort(entries, 0, entryCnt, ENTRY_CMP);
-		} catch (CharacterCodingException e) {
-			final CorruptObjectException why;
-			why = new CorruptObjectException("Invalid file name encoding");
-			why.initCause(e);
-			throw why;
-		} catch (IOException e) {
-			final CorruptObjectException why;
-			why = new CorruptObjectException("Error reading directory");
-			why.initCause(e);
-			throw why;
+		entries = list;
+		int i, o;
+
+		for (i = 0, o = 0; i < entries.length; i++) {
+			final Entry e = entries[i];
+			if (e == null)
+				continue;
+			final String name = e.getName();
+			if (".".equals(name) || "..".equals(name))
+				continue;
+			if (parent == null && ".git".equals(name))
+				continue;
+			if (i != o)
+				entries[o] = e;
+			e.encodeName(nameEncoder);
+			o++;
 		}
+		entryCnt = o;
+		Arrays.sort(entries, 0, entryCnt, ENTRY_CMP);		
+
+		contentIdFromPtr = -1;
+		ptr = 0;
+		if (!eof())
+			parseEntry();
 	}
 
 	/**
@@ -383,37 +369,24 @@ private void loadEntries() throws CorruptObjectException {
 	 * @return the currently selected entry.
 	 */
 	protected Entry current() {
-		return entries[ptr - 1];
+		return entries[ptr];
 	}
 
-	/**
-	 * Obtain an unsorted list of this iterator's contents.
-	 * <p>
-	 * Implementations only need to provide the unsorted contents of their lower
-	 * level directory. The caller will automatically prune out ".", "..",
-	 * ".git", as well as null entries as necessary, and then sort the array
-	 * for iteration within a TreeWalk instance.
-	 * <p>
-	 * The returned array will be modified by the caller.
-	 * <p>
-	 * This method is only invoked once per iterator instance.
-	 * 
-	 * @return unsorted list of the immediate children. Never null, but may be
-	 *         {@link #EOF} if no items can be obtained.
-	 * @throws IOException
-	 *             reading the contents failed due to IO errors.
-	 */
-	protected abstract Entry[] getEntries() throws IOException;
-
 	/** A single entry within a working directory tree. */
 	protected static abstract class Entry {
 		byte[] encodedName;
 
 		int encodedNameLen;
 
-		void encodeName(final CharsetEncoder enc)
-				throws CharacterCodingException {
-			final ByteBuffer b = enc.encode(CharBuffer.wrap(getName()));
+		void encodeName(final CharsetEncoder enc) {
+			final ByteBuffer b;			
+			try {
+				b = enc.encode(CharBuffer.wrap(getName()));
+			} catch (CharacterCodingException e) {
+				// This should so never happen.
+				throw new RuntimeException("Unencodeable file: " + getName());
+			}
+
 			encodedNameLen = b.limit();
 			if (b.hasArray() && b.arrayOffset() == 0)
 				encodedName = b.array();
-- 
1.6.0.87.g2858d

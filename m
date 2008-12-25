From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 07/23] Switch ObjectWalk to use a naked CanonicalTreeParser because its faster
Date: Wed, 24 Dec 2008 18:11:03 -0800
Message-ID: <1230171079-17156-8-git-send-email-spearce@spearce.org>
References: <1230171079-17156-1-git-send-email-spearce@spearce.org>
 <1230171079-17156-2-git-send-email-spearce@spearce.org>
 <1230171079-17156-3-git-send-email-spearce@spearce.org>
 <1230171079-17156-4-git-send-email-spearce@spearce.org>
 <1230171079-17156-5-git-send-email-spearce@spearce.org>
 <1230171079-17156-6-git-send-email-spearce@spearce.org>
 <1230171079-17156-7-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Dec 25 03:13:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LFfjK-00029A-E4
	for gcvg-git-2@gmane.org; Thu, 25 Dec 2008 03:13:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751715AbYLYCLl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Dec 2008 21:11:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751611AbYLYCLi
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Dec 2008 21:11:38 -0500
Received: from george.spearce.org ([209.20.77.23]:59418 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751523AbYLYCLZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Dec 2008 21:11:25 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 3C36F3826B; Thu, 25 Dec 2008 02:11:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 1DD2238197;
	Thu, 25 Dec 2008 02:11:22 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc4.301.g5497a
In-Reply-To: <1230171079-17156-7-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103870>

Removing the indirection of the TreeWalk during an ObjectWalk's loop
over the trees saves us 20 seconds on one of my linux-2.6 clones.  On
average we went from 1m37s for "jgit rev-list --objects" down to 1m17s.

C git still does the same operation in 0m20s, so we're a long way from
matching C git's performance, but this is a worthwhile improvement, even
though the code has become slightly more complex.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/revwalk/ObjectWalk.java   |   42 ++++++++++---------
 .../jgit/treewalk/AbstractTreeIterator.java        |   20 +++++++++
 .../spearce/jgit/treewalk/CanonicalTreeParser.java |   39 ++++++++++++++++++-
 .../src/org/spearce/jgit/treewalk/TreeWalk.java    |    4 +-
 4 files changed, 82 insertions(+), 23 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/ObjectWalk.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/ObjectWalk.java
index cfdbe18..0d67a38 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/ObjectWalk.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/ObjectWalk.java
@@ -46,7 +46,7 @@
 import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.FileMode;
 import org.spearce.jgit.lib.Repository;
-import org.spearce.jgit.treewalk.TreeWalk;
+import org.spearce.jgit.treewalk.CanonicalTreeParser;
 
 /**
  * Specialized subclass of RevWalk to include trees, blobs and tags.
@@ -74,7 +74,7 @@
 	 */
 	private static final int IN_PENDING = RevWalk.REWRITE;
 
-	private final TreeWalk treeWalk;
+	private CanonicalTreeParser treeWalk;
 
 	private BlockObjQueue pendingObjects;
 
@@ -92,8 +92,8 @@
 	 */
 	public ObjectWalk(final Repository repo) {
 		super(repo);
-		treeWalk = new TreeWalk(repo);
 		pendingObjects = new BlockObjQueue();
+		treeWalk = new CanonicalTreeParser();
 	}
 
 	/**
@@ -240,17 +240,17 @@ public RevObject nextObject() throws MissingObjectException,
 		fromTreeWalk = false;
 
 		if (enterSubtree) {
-			treeWalk.enterSubtree();
+			treeWalk = treeWalk.createSubtreeIterator(db, idBuffer, curs);
 			enterSubtree = false;
 		}
 
-		while (treeWalk.next()) {
-			final FileMode mode = treeWalk.getFileMode(0);
+		for (; !treeWalk.eof(); treeWalk = treeWalk.next()) {
+			final FileMode mode = treeWalk.getEntryFileMode();
 			final int sType = mode.getObjectType();
 
 			switch (sType) {
 			case Constants.OBJ_BLOB: {
-				treeWalk.getObjectId(idBuffer, 0);
+				treeWalk.getEntryObjectId(idBuffer);
 				final RevObject o = lookupAny(idBuffer, sType);
 				if ((o.flags & SEEN) != 0)
 					continue;
@@ -262,7 +262,7 @@ public RevObject nextObject() throws MissingObjectException,
 				return o;
 			}
 			case Constants.OBJ_TREE: {
-				treeWalk.getObjectId(idBuffer, 0);
+				treeWalk.getEntryObjectId(idBuffer);
 				final RevObject o = lookupAny(idBuffer, sType);
 				if ((o.flags & SEEN) != 0)
 					continue;
@@ -277,10 +277,11 @@ public RevObject nextObject() throws MissingObjectException,
 			default:
 				if (FileMode.GITLINK.equals(mode))
 					continue;
-				treeWalk.getObjectId(idBuffer, 0);
+				treeWalk.getEntryObjectId(idBuffer);
 				throw new CorruptObjectException("Invalid mode " + mode
 						+ " for " + idBuffer.name() + " "
-						+ treeWalk.getPathString() + " in " + currentTree + ".");
+						+ treeWalk.getEntryPathString() + " in " + currentTree
+						+ ".");
 			}
 		}
 
@@ -295,7 +296,7 @@ public RevObject nextObject() throws MissingObjectException,
 				continue;
 			if (o instanceof RevTree) {
 				currentTree = (RevTree) o;
-				treeWalk.reset(currentTree);
+				treeWalk = treeWalk.resetRoot(db, currentTree, curs);
 			}
 			return o;
 		}
@@ -353,7 +354,7 @@ public void checkConnectivity() throws MissingObjectException,
 	 *         has no path, such as for annotated tags or root level trees.
 	 */
 	public String getPathString() {
-		return fromTreeWalk ? treeWalk.getPathString() : null;
+		return fromTreeWalk ? treeWalk.getEntryPathString() : null;
 	}
 
 	@Override
@@ -385,33 +386,34 @@ private void markTreeUninteresting(final RevTree tree)
 			return;
 		tree.flags |= UNINTERESTING;
 
-		treeWalk.reset(tree);
-		while (treeWalk.next()) {
-			final FileMode mode = treeWalk.getFileMode(0);
+		treeWalk = treeWalk.resetRoot(db, tree, curs);
+		for (;!treeWalk.eof(); treeWalk = treeWalk.next()) {
+			final FileMode mode = treeWalk.getEntryFileMode();
 			final int sType = mode.getObjectType();
 
 			switch (sType) {
 			case Constants.OBJ_BLOB: {
-				treeWalk.getObjectId(idBuffer, 0);
+				treeWalk.getEntryObjectId(idBuffer);
 				lookupAny(idBuffer, sType).flags |= UNINTERESTING;
 				continue;
 			}
 			case Constants.OBJ_TREE: {
-				treeWalk.getObjectId(idBuffer, 0);
+				treeWalk.getEntryObjectId(idBuffer);
 				final RevObject subtree = lookupAny(idBuffer, sType);
 				if ((subtree.flags & UNINTERESTING) == 0) {
 					subtree.flags |= UNINTERESTING;
-					treeWalk.enterSubtree();
+					treeWalk = treeWalk.createSubtreeIterator(db, idBuffer,
+							curs);
 				}
 				continue;
 			}
 			default:
 				if (FileMode.GITLINK.equals(mode))
 					continue;
-				treeWalk.getObjectId(idBuffer, 0);
+				treeWalk.getEntryObjectId(idBuffer);
 				throw new CorruptObjectException("Invalid mode " + mode
 						+ " for " + idBuffer.name() + " "
-						+ treeWalk.getPathString() + " in " + tree + ".");
+						+ treeWalk.getEntryPathString() + " in " + tree + ".");
 			}
 		}
 	}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/AbstractTreeIterator.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/AbstractTreeIterator.java
index c404cdc..0229582 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/treewalk/AbstractTreeIterator.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/AbstractTreeIterator.java
@@ -308,6 +308,26 @@ public ObjectId getEntryObjectId() {
 	}
 
 	/**
+	 * Obtain the ObjectId for the current entry.
+	 * 
+	 * @param out
+	 *            buffer to copy the object id into.
+	 */
+	public void getEntryObjectId(final MutableObjectId out) {
+		out.fromRaw(idBuffer(), idOffset());
+	}
+
+	/** @return the file mode of the current entry. */
+	public FileMode getEntryFileMode() {
+		return FileMode.fromBits(mode);
+	}
+
+	/** @return path of the current entry, as a string. */
+	public String getEntryPathString() {
+		return TreeWalk.pathOf(this);
+	}
+
+	/**
 	 * Get the byte array buffer object IDs must be copied out of.
 	 * <p>
 	 * The id buffer contains the bytes necessary to construct an ObjectId for
diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/CanonicalTreeParser.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/CanonicalTreeParser.java
index df3384d..6a5bada 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/treewalk/CanonicalTreeParser.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/CanonicalTreeParser.java
@@ -52,6 +52,8 @@
 
 /** Parses raw Git trees from the canonical semi-text/semi-binary format. */
 public class CanonicalTreeParser extends AbstractTreeIterator {
+	private static final byte[] EMPTY = {};
+
 	private byte[] raw;
 
 	/** First offset within {@link #raw} of the current entry's data. */
@@ -62,7 +64,7 @@
 
 	/** Create a new parser. */
 	public CanonicalTreeParser() {
-		// Nothing necessary.
+		raw = EMPTY;
 	}
 
 	private CanonicalTreeParser(final CanonicalTreeParser p) {
@@ -92,6 +94,41 @@ public void reset(final byte[] treeData) {
 	 *            messages if data corruption is found.
 	 * @param curs
 	 *            window cursor to use during repository access.
+	 * @return the root level parser.
+	 * @throws MissingObjectException
+	 *             the object supplied is not available from the repository.
+	 * @throws IncorrectObjectTypeException
+	 *             the object supplied as an argument is not actually a tree and
+	 *             cannot be parsed as though it were a tree.
+	 * @throws IOException
+	 *             a loose object or pack file could not be read.
+	 */
+	public CanonicalTreeParser resetRoot(final Repository repo,
+			final AnyObjectId id, final WindowCursor curs)
+			throws IncorrectObjectTypeException, IOException {
+		CanonicalTreeParser p = this;
+		while (p.parent != null)
+			p = (CanonicalTreeParser) p.parent;
+		p.reset(repo, id, curs);
+		return p;
+	}
+
+	/** @return this iterator, or its parent, if the tree is at eof. */
+	public CanonicalTreeParser next() {
+		next(1);
+		return eof() && parent != null ? (CanonicalTreeParser) parent : this;
+	}
+
+	/**
+	 * Reset this parser to walk through the given tree.
+	 * 
+	 * @param repo
+	 *            repository to load the tree data from.
+	 * @param id
+	 *            identity of the tree being parsed; used only in exception
+	 *            messages if data corruption is found.
+	 * @param curs
+	 *            window cursor to use during repository access.
 	 * @throws MissingObjectException
 	 *             the object supplied is not available from the repository.
 	 * @throws IncorrectObjectTypeException
diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java
index cf66bf4..d1841b3 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java
@@ -596,7 +596,7 @@ public ObjectId getObjectId(final int nth) {
 	public void getObjectId(final MutableObjectId out, final int nth) {
 		final AbstractTreeIterator t = trees[nth];
 		if (t.matches == currentHead)
-			out.fromRaw(t.idBuffer(), t.idOffset());
+			t.getEntryObjectId(out);
 		else
 			out.clear();
 	}
@@ -834,7 +834,7 @@ private CanonicalTreeParser parserFor(final AnyObjectId id)
 		return p;
 	}
 
-	private static String pathOf(final AbstractTreeIterator t) {
+	static String pathOf(final AbstractTreeIterator t) {
 		return RawParseUtils.decode(Constants.CHARSET, t.path, 0, t.pathLen);
 	}
 }
-- 
1.6.1.rc4.301.g5497a

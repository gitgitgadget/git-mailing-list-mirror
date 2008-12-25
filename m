From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 06/23] Reduce garbage allocation when using TreeWalk
Date: Wed, 24 Dec 2008 18:11:02 -0800
Message-ID: <1230171079-17156-7-git-send-email-spearce@spearce.org>
References: <1230171079-17156-1-git-send-email-spearce@spearce.org>
 <1230171079-17156-2-git-send-email-spearce@spearce.org>
 <1230171079-17156-3-git-send-email-spearce@spearce.org>
 <1230171079-17156-4-git-send-email-spearce@spearce.org>
 <1230171079-17156-5-git-send-email-spearce@spearce.org>
 <1230171079-17156-6-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Dec 25 03:13:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LFfjJ-00029A-Ha
	for gcvg-git-2@gmane.org; Thu, 25 Dec 2008 03:13:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751726AbYLYCLj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Dec 2008 21:11:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751715AbYLYCLd
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Dec 2008 21:11:33 -0500
Received: from george.spearce.org ([209.20.77.23]:59416 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751520AbYLYCLY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Dec 2008 21:11:24 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 91A6838268; Thu, 25 Dec 2008 02:11:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id C0E6C38210;
	Thu, 25 Dec 2008 02:11:21 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc4.301.g5497a
In-Reply-To: <1230171079-17156-6-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103869>

We now support more efficiently resetting a TreeWalk when the
walker is using a single tree traversal from the repository.
This is very common during an ObjectWalk for a PackWriter, so
optimizing the code path is worth while.  By using a special
form of reset we can avoid unnecessary temporary arrays and
also skip some loop conditional instructions.

When diving into a subtree iterator (which is also quite a
common operation in ObjectWalk) we want to reuse an idBuffer
and a WindowCursor as much as possible, ensuring that these
aren't created temporarily on the stack.  This should help
to reduce the stress on the Inflater cache by allowing it
to reuse the same Inflater on each tree construction.  We
also can avoid creating a temporary ObjectId by filling out
the mutable idBuffer during the repository lookup.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../jgit/pgm/opt/AbstractTreeIteratorHandler.java  |    6 ++-
 .../src/org/spearce/jgit/revwalk/ObjectWalk.java   |    5 +-
 .../jgit/transport/WalkFetchConnection.java        |    4 +-
 .../jgit/treewalk/AbstractTreeIterator.java        |   28 ++++++++++
 .../spearce/jgit/treewalk/CanonicalTreeParser.java |   46 ++++++++++++----
 .../src/org/spearce/jgit/treewalk/TreeWalk.java    |   58 ++++++++++++++++++--
 6 files changed, 124 insertions(+), 23 deletions(-)

diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/opt/AbstractTreeIteratorHandler.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/opt/AbstractTreeIteratorHandler.java
index 9432d5f..12d4191 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/opt/AbstractTreeIteratorHandler.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/opt/AbstractTreeIteratorHandler.java
@@ -51,6 +51,7 @@
 import org.spearce.jgit.errors.IncorrectObjectTypeException;
 import org.spearce.jgit.errors.MissingObjectException;
 import org.spearce.jgit.lib.ObjectId;
+import org.spearce.jgit.lib.WindowCursor;
 import org.spearce.jgit.treewalk.AbstractTreeIterator;
 import org.spearce.jgit.treewalk.CanonicalTreeParser;
 import org.spearce.jgit.treewalk.FileTreeIterator;
@@ -110,8 +111,9 @@ public int parseArguments(final Parameters params) throws CmdLineException {
 			throw new CmdLineException(name + " is not a tree");
 
 		final CanonicalTreeParser p = new CanonicalTreeParser();
+		final WindowCursor curs = new WindowCursor();
 		try {
-			p.reset(clp.getRepository(), clp.getRevWalk().parseTree(id));
+			p.reset(clp.getRepository(), clp.getRevWalk().parseTree(id), curs);
 		} catch (MissingObjectException e) {
 			throw new CmdLineException(name + " is not a tree");
 		} catch (IncorrectObjectTypeException e) {
@@ -119,6 +121,8 @@ public int parseArguments(final Parameters params) throws CmdLineException {
 		} catch (IOException e) {
 			throw new CmdLineException("cannot read " + name + ": "
 					+ e.getMessage());
+		} finally {
+			curs.release();
 		}
 
 		setter.addValue(p);
diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/ObjectWalk.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/ObjectWalk.java
index 454cb4a..cfdbe18 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/ObjectWalk.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/ObjectWalk.java
@@ -45,7 +45,6 @@
 import org.spearce.jgit.lib.AnyObjectId;
 import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.FileMode;
-import org.spearce.jgit.lib.ObjectId;
 import org.spearce.jgit.lib.Repository;
 import org.spearce.jgit.treewalk.TreeWalk;
 
@@ -296,7 +295,7 @@ public RevObject nextObject() throws MissingObjectException,
 				continue;
 			if (o instanceof RevTree) {
 				currentTree = (RevTree) o;
-				treeWalk.reset(new ObjectId[] { currentTree });
+				treeWalk.reset(currentTree);
 			}
 			return o;
 		}
@@ -386,7 +385,7 @@ private void markTreeUninteresting(final RevTree tree)
 			return;
 		tree.flags |= UNINTERESTING;
 
-		treeWalk.reset(new ObjectId[] { tree });
+		treeWalk.reset(tree);
 		while (treeWalk.next()) {
 			final FileMode mode = treeWalk.getFileMode(0);
 			final int sType = mode.getObjectType();
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkFetchConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkFetchConnection.java
index 6300f10..5d0c6bc 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkFetchConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkFetchConnection.java
@@ -296,7 +296,7 @@ private void processBlob(final RevObject obj) throws TransportException {
 
 	private void processTree(final RevObject obj) throws TransportException {
 		try {
-			treeWalk.reset(new ObjectId[] { obj });
+			treeWalk.reset(obj);
 			while (treeWalk.next()) {
 				final FileMode mode = treeWalk.getFileMode(0);
 				final int sType = mode.getObjectType();
@@ -720,7 +720,7 @@ private void markTreeComplete(final RevTree tree) throws IOException {
 		if (tree.has(COMPLETE))
 			return;
 		tree.add(COMPLETE);
-		treeWalk.reset(new ObjectId[] { tree });
+		treeWalk.reset(tree);
 		while (treeWalk.next()) {
 			final FileMode mode = treeWalk.getFileMode(0);
 			final int sType = mode.getObjectType();
diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/AbstractTreeIterator.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/AbstractTreeIterator.java
index 5226ab6..c404cdc 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/treewalk/AbstractTreeIterator.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/AbstractTreeIterator.java
@@ -46,8 +46,10 @@
 import org.spearce.jgit.errors.IncorrectObjectTypeException;
 import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.FileMode;
+import org.spearce.jgit.lib.MutableObjectId;
 import org.spearce.jgit.lib.ObjectId;
 import org.spearce.jgit.lib.Repository;
+import org.spearce.jgit.lib.WindowCursor;
 import org.spearce.jgit.treewalk.filter.TreeFilter;
 
 /**
@@ -347,6 +349,32 @@ public abstract AbstractTreeIterator createSubtreeIterator(Repository repo)
 			throws IncorrectObjectTypeException, IOException;
 
 	/**
+	 * Create a new iterator for the current entry's subtree.
+	 * <p>
+	 * The parent reference of the iterator must be <code>this</code>, otherwise
+	 * the caller would not be able to exit out of the subtree iterator
+	 * correctly and return to continue walking <code>this</code>.
+	 * 
+	 * @param repo
+	 *            repository to load the tree data from.
+	 * @param idBuffer
+	 *            temporary ObjectId buffer for use by this method.
+	 * @param curs
+	 *            window cursor to use during repository access.
+	 * @return a new parser that walks over the current subtree.
+	 * @throws IncorrectObjectTypeException
+	 *             the current entry is not actually a tree and cannot be parsed
+	 *             as though it were a tree.
+	 * @throws IOException
+	 *             a loose object or pack file could not be read.
+	 */
+	public AbstractTreeIterator createSubtreeIterator(final Repository repo,
+			final MutableObjectId idBuffer, final WindowCursor curs)
+			throws IncorrectObjectTypeException, IOException {
+		return createSubtreeIterator(repo);
+	}
+
+	/**
 	 * Is this tree iterator positioned on its first entry?
 	 * <p>
 	 * An iterator is positioned on the first entry if <code>back(1)</code>
diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/CanonicalTreeParser.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/CanonicalTreeParser.java
index dcc53cd..df3384d 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/treewalk/CanonicalTreeParser.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/CanonicalTreeParser.java
@@ -41,11 +41,14 @@
 
 import org.spearce.jgit.errors.IncorrectObjectTypeException;
 import org.spearce.jgit.errors.MissingObjectException;
+import org.spearce.jgit.lib.AnyObjectId;
 import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.FileMode;
+import org.spearce.jgit.lib.MutableObjectId;
 import org.spearce.jgit.lib.ObjectId;
 import org.spearce.jgit.lib.ObjectLoader;
 import org.spearce.jgit.lib.Repository;
+import org.spearce.jgit.lib.WindowCursor;
 
 /** Parses raw Git trees from the canonical semi-text/semi-binary format. */
 public class CanonicalTreeParser extends AbstractTreeIterator {
@@ -87,6 +90,8 @@ public void reset(final byte[] treeData) {
 	 * @param id
 	 *            identity of the tree being parsed; used only in exception
 	 *            messages if data corruption is found.
+	 * @param curs
+	 *            window cursor to use during repository access.
 	 * @throws MissingObjectException
 	 *             the object supplied is not available from the repository.
 	 * @throws IncorrectObjectTypeException
@@ -95,27 +100,46 @@ public void reset(final byte[] treeData) {
 	 * @throws IOException
 	 *             a loose object or pack file could not be read.
 	 */
-	public void reset(final Repository repo, final ObjectId id)
+	public void reset(final Repository repo, final AnyObjectId id,
+			final WindowCursor curs)
 			throws IncorrectObjectTypeException, IOException {
-		final ObjectLoader ldr = repo.openObject(id);
-		if (ldr == null)
-			throw new MissingObjectException(id, Constants.TYPE_TREE);
+		final ObjectLoader ldr = repo.openObject(curs, id);
+		if (ldr == null) {
+			final ObjectId me = id.toObjectId();
+			throw new MissingObjectException(me, Constants.TYPE_TREE);
+		}
 		final byte[] subtreeData = ldr.getCachedBytes();
-		if (ldr.getType() != Constants.OBJ_TREE)
-			throw new IncorrectObjectTypeException(id, Constants.TYPE_TREE);
+		if (ldr.getType() != Constants.OBJ_TREE) {
+			final ObjectId me = id.toObjectId();
+			throw new IncorrectObjectTypeException(me, Constants.TYPE_TREE);
+		}
 		reset(subtreeData);
 	}
 
-	public CanonicalTreeParser createSubtreeIterator(final Repository repo)
+	@Override
+	public CanonicalTreeParser createSubtreeIterator(final Repository repo,
+			final MutableObjectId idBuffer, final WindowCursor curs)
 			throws IncorrectObjectTypeException, IOException {
-		final ObjectId id = getEntryObjectId();
-		if (!FileMode.TREE.equals(mode))
-			throw new IncorrectObjectTypeException(id, Constants.TYPE_TREE);
+		idBuffer.fromRaw(idBuffer(), idOffset());
+		if (!FileMode.TREE.equals(mode)) {
+			final ObjectId me = idBuffer.toObjectId();
+			throw new IncorrectObjectTypeException(me, Constants.TYPE_TREE);
+		}
 		final CanonicalTreeParser p = new CanonicalTreeParser(this);
-		p.reset(repo, id);
+		p.reset(repo, idBuffer, curs);
 		return p;
 	}
 
+	public CanonicalTreeParser createSubtreeIterator(final Repository repo)
+			throws IncorrectObjectTypeException, IOException {
+		final WindowCursor curs = new WindowCursor();
+		try {
+			return createSubtreeIterator(repo, new MutableObjectId(), curs);
+		} finally {
+			curs.release();
+		}
+	}
+
 	@Override
 	public byte[] idBuffer() {
 		return raw;
diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java
index 38a726b..cf66bf4 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java
@@ -44,11 +44,13 @@
 import org.spearce.jgit.errors.IncorrectObjectTypeException;
 import org.spearce.jgit.errors.MissingObjectException;
 import org.spearce.jgit.errors.StopWalkException;
+import org.spearce.jgit.lib.AnyObjectId;
 import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.FileMode;
 import org.spearce.jgit.lib.MutableObjectId;
 import org.spearce.jgit.lib.ObjectId;
 import org.spearce.jgit.lib.Repository;
+import org.spearce.jgit.lib.WindowCursor;
 import org.spearce.jgit.revwalk.RevTree;
 import org.spearce.jgit.treewalk.filter.PathFilterGroup;
 import org.spearce.jgit.treewalk.filter.TreeFilter;
@@ -99,7 +101,7 @@
 	 *             a tree object was not found.
 	 */
 	public static TreeWalk forPath(final Repository db, final String path,
-			final ObjectId[] trees) throws MissingObjectException,
+			final AnyObjectId[] trees) throws MissingObjectException,
 			IncorrectObjectTypeException, CorruptObjectException, IOException {
 		final TreeWalk r = new TreeWalk(db);
 		r.setFilter(PathFilterGroup.createFromStrings(Collections
@@ -142,6 +144,10 @@ public static TreeWalk forPath(final Repository db, final String path,
 
 	private final Repository db;
 
+	private final MutableObjectId idBuffer = new MutableObjectId();
+
+	private final WindowCursor curs = new WindowCursor();
+
 	private TreeFilter filter;
 
 	AbstractTreeIterator[] trees;
@@ -278,6 +284,46 @@ public void reset() {
 	}
 
 	/**
+	 * Reset this walker to run over a single existing tree.
+	 * 
+	 * @param id
+	 *            the tree we need to parse. The walker will execute over this
+	 *            single tree if the reset is successful.
+	 * @throws MissingObjectException
+	 *             the given tree object does not exist in this repository.
+	 * @throws IncorrectObjectTypeException
+	 *             the given object id does not denote a tree, but instead names
+	 *             some other non-tree type of object. Note that commits are not
+	 *             trees, even if they are sometimes called a "tree-ish".
+	 * @throws CorruptObjectException
+	 *             the object claimed to be a tree, but its contents did not
+	 *             appear to be a tree. The repository may have data corruption.
+	 * @throws IOException
+	 *             a loose object or pack file could not be read.
+	 */
+	public void reset(final AnyObjectId id) throws MissingObjectException,
+			IncorrectObjectTypeException, CorruptObjectException, IOException {
+		if (trees.length == 1) {
+			AbstractTreeIterator o = trees[0];
+			while (o.parent != null)
+				o = o.parent;
+			if (o instanceof CanonicalTreeParser) {
+				o.matches = null;
+				o.matchShift = 0;
+				((CanonicalTreeParser) o).reset(db, id, curs);
+				trees[0] = o;
+			} else {
+				trees[0] = parserFor(id);
+			}
+		} else {
+			trees = new AbstractTreeIterator[] { parserFor(id) };
+		}
+
+		advance = false;
+		depth = 0;
+	}
+
+	/**
 	 * Reset this walker to run over a set of existing trees.
 	 * 
 	 * @param ids
@@ -295,7 +341,7 @@ public void reset() {
 	 * @throws IOException
 	 *             a loose object or pack file could not be read.
 	 */
-	public void reset(final ObjectId[] ids) throws MissingObjectException,
+	public void reset(final AnyObjectId[] ids) throws MissingObjectException,
 			IncorrectObjectTypeException, CorruptObjectException, IOException {
 		final int oldLen = trees.length;
 		final int newLen = ids.length;
@@ -311,7 +357,7 @@ public void reset(final ObjectId[] ids) throws MissingObjectException,
 				if (o instanceof CanonicalTreeParser) {
 					o.matches = null;
 					o.matchShift = 0;
-					((CanonicalTreeParser) o).reset(db, ids[i]);
+					((CanonicalTreeParser) o).reset(db, ids[i], curs);
 					r[i] = o;
 					continue;
 				}
@@ -709,7 +755,7 @@ public void enterSubtree() throws MissingObjectException,
 			final AbstractTreeIterator t = trees[i];
 			final AbstractTreeIterator n;
 			if (t.matches == ch && !t.eof() && FileMode.TREE.equals(t.mode))
-				n = t.createSubtreeIterator(db);
+				n = t.createSubtreeIterator(db, idBuffer, curs);
 			else
 				n = new EmptyTreeIterator(t);
 			tmp[i] = n;
@@ -781,10 +827,10 @@ private void exitSubtree() {
 		currentHead = minRef;
 	}
 
-	private CanonicalTreeParser parserFor(final ObjectId id)
+	private CanonicalTreeParser parserFor(final AnyObjectId id)
 			throws IncorrectObjectTypeException, IOException {
 		final CanonicalTreeParser p = new CanonicalTreeParser();
-		p.reset(db, id);
+		p.reset(db, id, curs);
 		return p;
 	}
 
-- 
1.6.1.rc4.301.g5497a

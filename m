From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 2/3] Fix ObjectWalk to handle single-entry subtrees correctly
Date: Fri, 13 Mar 2009 11:11:51 -0700
Message-ID: <1236967912-15088-2-git-send-email-spearce@spearce.org>
References: <1236967912-15088-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Mar 13 19:14:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LiBsr-00077Q-KK
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 19:13:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754801AbZCMSL7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2009 14:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753507AbZCMSL5
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 14:11:57 -0400
Received: from george.spearce.org ([209.20.77.23]:57847 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752670AbZCMSLz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2009 14:11:55 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 8ECDB38221; Fri, 13 Mar 2009 18:11:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 9E12238211;
	Fri, 13 Mar 2009 18:11:52 +0000 (UTC)
X-Mailer: git-send-email 1.6.2.288.gc3f22
In-Reply-To: <1236967912-15088-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113216>

"jgit push" has been pushing more objects than necessary
for a while now, due to ObjectWalk failing to mark a subtree
uninteresting if it contains exactly one subtree child, such as
"org.spearce.egit.core/src" which has only one child, "org".

The bug was caused by the child iterator being advanced past the
first item before we even evaluated it, as the for loop always
invoked treeWalk.next() at the end of each iteration.  However,
a new subtree iterator is positioned on the first item and must
not call next() until after we have handled that first entry.

While debugging this I also noticed strange behavior from the
ObjectWalk evaulating a subtree again, after we had exited it.
This was because the parent iterator was never advanced past the
child when we entered into it.  We now advance the parent whenever
we leave the child.

Note that its important we do the parent advance *after* we exit the
child, as they share the same path buffer.  Advancing the parent
before we enter into the child would cause the child to corrupt
the parent's next item path.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/revwalk/ObjectWalk.java   |   54 +++++++++++---------
 .../spearce/jgit/treewalk/CanonicalTreeParser.java |   40 +++++++++++++-
 2 files changed, 66 insertions(+), 28 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/ObjectWalk.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/ObjectWalk.java
index 0d67a38..a481639 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/ObjectWalk.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/ObjectWalk.java
@@ -82,7 +82,7 @@
 
 	private boolean fromTreeWalk;
 
-	private boolean enterSubtree;
+	private RevTree nextSubtree;
 
 	/**
 	 * Create a new revision and object walker for a given repository.
@@ -239,50 +239,52 @@ public RevObject nextObject() throws MissingObjectException,
 			IncorrectObjectTypeException, IOException {
 		fromTreeWalk = false;
 
-		if (enterSubtree) {
-			treeWalk = treeWalk.createSubtreeIterator(db, idBuffer, curs);
-			enterSubtree = false;
+		if (nextSubtree != null) {
+			treeWalk = treeWalk.createSubtreeIterator0(db, nextSubtree, curs);
+			nextSubtree = null;
 		}
 
-		for (; !treeWalk.eof(); treeWalk = treeWalk.next()) {
+		while (!treeWalk.eof()) {
 			final FileMode mode = treeWalk.getEntryFileMode();
 			final int sType = mode.getObjectType();
 
 			switch (sType) {
 			case Constants.OBJ_BLOB: {
 				treeWalk.getEntryObjectId(idBuffer);
-				final RevObject o = lookupAny(idBuffer, sType);
+				final RevBlob o = lookupBlob(idBuffer);
 				if ((o.flags & SEEN) != 0)
-					continue;
+					break;
 				o.flags |= SEEN;
 				if ((o.flags & UNINTERESTING) != 0
 						&& !hasRevSort(RevSort.BOUNDARY))
-					continue;
+					break;
 				fromTreeWalk = true;
 				return o;
 			}
 			case Constants.OBJ_TREE: {
 				treeWalk.getEntryObjectId(idBuffer);
-				final RevObject o = lookupAny(idBuffer, sType);
+				final RevTree o = lookupTree(idBuffer);
 				if ((o.flags & SEEN) != 0)
-					continue;
+					break;
 				o.flags |= SEEN;
 				if ((o.flags & UNINTERESTING) != 0
 						&& !hasRevSort(RevSort.BOUNDARY))
-					continue;
-				enterSubtree = true;
+					break;
+				nextSubtree = o;
 				fromTreeWalk = true;
 				return o;
 			}
 			default:
 				if (FileMode.GITLINK.equals(mode))
-					continue;
+					break;
 				treeWalk.getEntryObjectId(idBuffer);
 				throw new CorruptObjectException("Invalid mode " + mode
 						+ " for " + idBuffer.name() + " "
 						+ treeWalk.getEntryPathString() + " in " + currentTree
 						+ ".");
 			}
+
+			treeWalk = treeWalk.next();
 		}
 
 		for (;;) {
@@ -361,7 +363,7 @@ public String getPathString() {
 	public void dispose() {
 		super.dispose();
 		pendingObjects = new BlockObjQueue();
-		enterSubtree = false;
+		nextSubtree = null;
 		currentTree = null;
 	}
 
@@ -369,7 +371,7 @@ public void dispose() {
 	protected void reset(final int retainFlags) {
 		super.reset(retainFlags);
 		pendingObjects = new BlockObjQueue();
-		enterSubtree = false;
+		nextSubtree = null;
 	}
 
 	private void addObject(final RevObject o) {
@@ -387,34 +389,36 @@ private void markTreeUninteresting(final RevTree tree)
 		tree.flags |= UNINTERESTING;
 
 		treeWalk = treeWalk.resetRoot(db, tree, curs);
-		for (;!treeWalk.eof(); treeWalk = treeWalk.next()) {
+		while (!treeWalk.eof()) {
 			final FileMode mode = treeWalk.getEntryFileMode();
 			final int sType = mode.getObjectType();
 
 			switch (sType) {
 			case Constants.OBJ_BLOB: {
 				treeWalk.getEntryObjectId(idBuffer);
-				lookupAny(idBuffer, sType).flags |= UNINTERESTING;
-				continue;
+				lookupBlob(idBuffer).flags |= UNINTERESTING;
+				break;
 			}
 			case Constants.OBJ_TREE: {
 				treeWalk.getEntryObjectId(idBuffer);
-				final RevObject subtree = lookupAny(idBuffer, sType);
-				if ((subtree.flags & UNINTERESTING) == 0) {
-					subtree.flags |= UNINTERESTING;
-					treeWalk = treeWalk.createSubtreeIterator(db, idBuffer,
-							curs);
+				final RevTree t = lookupTree(idBuffer);
+				if ((t.flags & UNINTERESTING) == 0) {
+					t.flags |= UNINTERESTING;
+					treeWalk = treeWalk.createSubtreeIterator0(db, t, curs);
+					continue;
 				}
-				continue;
+				break;
 			}
 			default:
 				if (FileMode.GITLINK.equals(mode))
-					continue;
+					break;
 				treeWalk.getEntryObjectId(idBuffer);
 				throw new CorruptObjectException("Invalid mode " + mode
 						+ " for " + idBuffer.name() + " "
 						+ treeWalk.getEntryPathString() + " in " + tree + ".");
 			}
+
+			treeWalk = treeWalk.next();
 		}
 	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/CanonicalTreeParser.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/CanonicalTreeParser.java
index 8028b14..5c331ca 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/treewalk/CanonicalTreeParser.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/CanonicalTreeParser.java
@@ -145,8 +145,19 @@ public CanonicalTreeParser resetRoot(final Repository repo,
 
 	/** @return this iterator, or its parent, if the tree is at eof. */
 	public CanonicalTreeParser next() {
-		next(1);
-		return eof() && parent != null ? (CanonicalTreeParser) parent : this;
+		CanonicalTreeParser p = this;
+		for (;;) {
+			p.next(1);
+			if (p.eof() && parent != null) {
+				// Parent was left pointing at the entry for us; advance
+				// the parent to the next entry, possibly unwinding many
+				// levels up the tree.
+				//
+				p = (CanonicalTreeParser) p.parent;
+				continue;
+			}
+			return p;
+		}
 	}
 
 	/**
@@ -192,8 +203,31 @@ public CanonicalTreeParser createSubtreeIterator(final Repository repo,
 			final ObjectId me = idBuffer.toObjectId();
 			throw new IncorrectObjectTypeException(me, Constants.TYPE_TREE);
 		}
+		return createSubtreeIterator0(repo, idBuffer, curs);
+	}
+
+	/**
+	 * Back door to quickly create a subtree iterator for any subtree.
+	 * <p>
+	 * Don't use this unless you are ObjectWalk. The method is meant to be
+	 * called only once the current entry has been identified as a tree and its
+	 * identity has been converted into an ObjectId.
+	 *
+	 * @param repo
+	 *            repository to load the tree data from.
+	 * @param id
+	 *            ObjectId of the tree to open.
+	 * @param curs
+	 *            window cursor to use during repository access.
+	 * @return a new parser that walks over the current subtree.
+	 * @throws IOException
+	 *             a loose object or pack file could not be read.
+	 */
+	public final CanonicalTreeParser createSubtreeIterator0(
+			final Repository repo, final AnyObjectId id, final WindowCursor curs)
+			throws IOException {
 		final CanonicalTreeParser p = new CanonicalTreeParser(this);
-		p.reset(repo, idBuffer, curs);
+		p.reset(repo, id, curs);
 		return p;
 	}
 
-- 
1.6.2.288.gc3f22

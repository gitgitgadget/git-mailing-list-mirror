From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 13/14] Create NameConflictTreeWalk to transparently detect D/F conflicts
Date: Mon, 18 Aug 2008 16:53:21 -0700
Message-ID: <1219103602-32222-14-git-send-email-spearce@spearce.org>
References: <1219103602-32222-1-git-send-email-spearce@spearce.org>
 <1219103602-32222-2-git-send-email-spearce@spearce.org>
 <1219103602-32222-3-git-send-email-spearce@spearce.org>
 <1219103602-32222-4-git-send-email-spearce@spearce.org>
 <1219103602-32222-5-git-send-email-spearce@spearce.org>
 <1219103602-32222-6-git-send-email-spearce@spearce.org>
 <1219103602-32222-7-git-send-email-spearce@spearce.org>
 <1219103602-32222-8-git-send-email-spearce@spearce.org>
 <1219103602-32222-9-git-send-email-spearce@spearce.org>
 <1219103602-32222-10-git-send-email-spearce@spearce.org>
 <1219103602-32222-11-git-send-email-spearce@spearce.org>
 <1219103602-32222-12-git-send-email-spearce@spearce.org>
 <1219103602-32222-13-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 01:55:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVEZ9-0006i3-7R
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 01:55:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754127AbYHRXxy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 19:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753856AbYHRXxv
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 19:53:51 -0400
Received: from george.spearce.org ([209.20.77.23]:45152 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753739AbYHRXxc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 19:53:32 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 824B53837B; Mon, 18 Aug 2008 23:53:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 7170F38378;
	Mon, 18 Aug 2008 23:53:26 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.87.g2858d
In-Reply-To: <1219103602-32222-13-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92780>

When performing a merge between two or more tree iterators we really
need to be able to detect a directory-file conflict and handle it as
a single step of the TreeWalk iteration.  This way we can merge say
three iterators together:

  - commit $A
  - commit $B
  - working tree

Where the working tree is moving from $A to $B and the file path
"foo" has been changed from being a file in $A to a directory in
commit $B.  To make this change effective we must delete "foo"
and then enter the "foo" subtree to create the directory and
the paths within it.

This walk implementation is outside of TreeWalk as it is not a
trivial operation.  Applications should only use this variant
when conflict handling is absolutely necessary.  Basic commit
filtering (such as done by RevWalk) does not need this support
so we really don't want to bog down RevWalk's critical loop.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../jgit/treewalk/AbstractTreeIterator.java        |    7 +
 .../jgit/treewalk/NameConflictTreeWalk.java        |  237 ++++++++++++++++++++
 .../src/org/spearce/jgit/treewalk/TreeWalk.java    |   12 +-
 3 files changed, 251 insertions(+), 5 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/treewalk/NameConflictTreeWalk.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/AbstractTreeIterator.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/AbstractTreeIterator.java
index c1b7ad8..31ccebe 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/treewalk/AbstractTreeIterator.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/AbstractTreeIterator.java
@@ -83,6 +83,13 @@
 	AbstractTreeIterator matches;
 
 	/**
+	 * Number of entries we moved forward to force a D/F conflict match.
+	 * 
+	 * @see NameConflictTreeWalk
+	 */
+	int matchShift;
+
+	/**
 	 * Mode bits for the current entry.
 	 * <p>
 	 * A numerical value from FileMode is usually faster for an iterator to
diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/NameConflictTreeWalk.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/NameConflictTreeWalk.java
new file mode 100644
index 0000000..fdfba4e
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/NameConflictTreeWalk.java
@@ -0,0 +1,237 @@
+/*
+ * Copyright (C) 2008, Google Inc.
+ *
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or
+ * without modification, are permitted provided that the following
+ * conditions are met:
+ *
+ * - Redistributions of source code must retain the above copyright
+ *   notice, this list of conditions and the following disclaimer.
+ *
+ * - Redistributions in binary form must reproduce the above
+ *   copyright notice, this list of conditions and the following
+ *   disclaimer in the documentation and/or other materials provided
+ *   with the distribution.
+ *
+ * - Neither the name of the Git Development Community nor the
+ *   names of its contributors may be used to endorse or promote
+ *   products derived from this software without specific prior
+ *   written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
+ * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
+ * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+package org.spearce.jgit.treewalk;
+
+import org.spearce.jgit.dircache.DirCacheBuilder;
+import org.spearce.jgit.errors.CorruptObjectException;
+import org.spearce.jgit.lib.FileMode;
+import org.spearce.jgit.lib.Repository;
+
+/**
+ * Specialized TreeWalk to detect directory-file (D/F) name conflicts.
+ * <p>
+ * Due to the way a Git tree is organized the standard {@link TreeWalk} won't
+ * easily find a D/F conflict when merging two or more trees together. In the
+ * standard TreeWalk the file will be returned first, and then much later the
+ * directory will be returned. This makes it impossible for the application to
+ * efficiently detect and handle the conflict.
+ * <p>
+ * Using this walk implementation causes the directory to report earlier than
+ * usual, at the same time as the non-directory entry. This permits the
+ * application to handle the D/F conflict in a single step. The directory is
+ * returned only once, so it does not get returned later in the iteration.
+ * <p>
+ * When a D/F conflict is detected {@link TreeWalk#isSubtree()} will return true
+ * and {@link TreeWalk#enterSubtree()} will recurse into the subtree, no matter
+ * which iterator originally supplied the subtree.
+ * <p>
+ * Because conflicted directories report early, using this walk implementation
+ * to populate a {@link DirCacheBuilder} may cause the automatic resorting to
+ * run and fix the entry ordering.
+ * <p>
+ * This walk implementation requires more CPU to implement a look-ahead and a
+ * look-behind to merge a D/F pair together, or to skip a previously reported
+ * directory. In typical Git repositories the look-ahead cost is 0 and the
+ * look-behind doesn't trigger, as users tend not to create trees which contain
+ * both "foo" as a directory and "foo.c" as a file.
+ * <p>
+ * In the worst-case however several thousand look-ahead steps per walk step may
+ * be necessary, making the overhead quite significant. Since this worst-case
+ * should never happen this walk implementation has made the time/space tradeoff
+ * in favor of more-time/less-space, as that better suits the typical case.
+ */
+public class NameConflictTreeWalk extends TreeWalk {
+	private static final int TREE_MODE = FileMode.TREE.getBits();
+
+	/**
+	 * Create a new tree walker for a given repository.
+	 * 
+	 * @param repo
+	 *            the repository the walker will obtain data from.
+	 */
+	public NameConflictTreeWalk(final Repository repo) {
+		super(repo);
+	}
+
+	@Override
+	AbstractTreeIterator min() throws CorruptObjectException {
+		for (;;) {
+			final AbstractTreeIterator minRef = super.min();
+			if (minRef.eof())
+				return minRef;
+
+			if (FileMode.TREE.equals(minRef.mode)) {
+				if (skipEntry(minRef)) {
+					for (final AbstractTreeIterator t : trees) {
+						if (t.matches == minRef) {
+							t.next(1);
+							t.matches = null;
+						}
+					}
+					continue;
+				}
+				return minRef;
+			}
+
+			return combineDF(minRef);
+		}
+	}
+
+	private boolean skipEntry(final AbstractTreeIterator minRef)
+			throws CorruptObjectException {
+		// A tree D/F may have been handled earlier. We need to
+		// not report this path if it has already been reported.
+		//
+		for (final AbstractTreeIterator t : trees) {
+			if (t.matches == minRef || t.first())
+				continue;
+
+			int stepsBack = 0;
+			for (;;) {
+				stepsBack++;
+				t.back(1);
+
+				final int cmp = t.pathCompare(minRef, 0);
+				if (cmp == 0) {
+					// We have already seen this "$path" before. Skip it.
+					//
+					t.next(stepsBack);
+					return true;
+				} else if (cmp < 0 || t.first()) {
+					// We cannot find "$path" in t; it will never appear.
+					//
+					t.next(stepsBack);
+					break;
+				}
+			}
+		}
+
+		// We have never seen the current path before.
+		//
+		return false;
+	}
+
+	private AbstractTreeIterator combineDF(final AbstractTreeIterator minRef)
+			throws CorruptObjectException {
+		// Look for a possible D/F conflict forward in the tree(s)
+		// as there may be a "$path/" which matches "$path". Make
+		// such entries match this entry.
+		//
+		AbstractTreeIterator treeMatch = null;
+		for (final AbstractTreeIterator t : trees) {
+			if (t.matches == minRef || t.eof())
+				continue;
+
+			for (;;) {
+				final int cmp = t.pathCompare(minRef, TREE_MODE);
+				if (cmp < 0) {
+					// The "$path/" may still appear later.
+					//
+					t.matchShift++;
+					t.next(1);
+					if (t.eof()) {
+						t.back(t.matchShift);
+						t.matchShift = 0;
+						break;
+					}
+				} else if (cmp == 0) {
+					// We have a conflict match here.
+					//
+					t.matches = minRef;
+					treeMatch = t;
+					break;
+				} else {
+					// A conflict match is not possible.
+					//
+					if (t.matchShift != 0) {
+						t.back(t.matchShift);
+						t.matchShift = 0;
+					}
+					break;
+				}
+			}
+		}
+
+		if (treeMatch != null) {
+			// If we do have a conflict use one of the directory
+			// matching iterators instead of the file iterator.
+			// This way isSubtree is true and isRecursive works.
+			//
+			for (final AbstractTreeIterator t : trees)
+				if (t.matches == minRef)
+					t.matches = treeMatch;
+			return treeMatch;
+		}
+
+		return minRef;
+	}
+
+	@Override
+	void popEntriesEqual() throws CorruptObjectException {
+		final AbstractTreeIterator ch = currentHead;
+		for (int i = 0; i < trees.length; i++) {
+			final AbstractTreeIterator t = trees[i];
+			if (t.matches == ch) {
+				if (t.matchShift == 0)
+					t.next(1);
+				else {
+					t.back(t.matchShift);
+					t.matchShift = 0;
+				}
+				t.matches = null;
+			}
+		}
+	}
+
+	@Override
+	void skipEntriesEqual() throws CorruptObjectException {
+		final AbstractTreeIterator ch = currentHead;
+		for (int i = 0; i < trees.length; i++) {
+			final AbstractTreeIterator t = trees[i];
+			if (t.matches == ch) {
+				if (t.matchShift == 0)
+					t.skip();
+				else {
+					t.back(t.matchShift);
+					t.matchShift = 0;
+				}
+				t.matches = null;
+			}
+		}
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java
index 10cdebd..7a09878 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java
@@ -143,7 +143,7 @@ public static TreeWalk forPath(final Repository db, final String path,
 
 	private TreeFilter filter;
 
-	private AbstractTreeIterator[] trees;
+	AbstractTreeIterator[] trees;
 
 	private boolean recursive;
 
@@ -151,7 +151,7 @@ public static TreeWalk forPath(final Repository db, final String path,
 
 	private boolean advance;
 
-	private AbstractTreeIterator currentHead;
+	AbstractTreeIterator currentHead;
 
 	/**
 	 * Create a new tree walker for a given repository.
@@ -275,6 +275,7 @@ public void reset(final ObjectId[] ids) throws MissingObjectException,
 					o = o.parent;
 				if (o instanceof CanonicalTreeParser) {
 					o.matches = null;
+					o.matchShift = 0;
 					((CanonicalTreeParser) o).reset(db, ids[i]);
 					r[i] = o;
 					continue;
@@ -338,6 +339,7 @@ public int addTree(final AbstractTreeIterator p)
 		System.arraycopy(trees, 0, newTrees, 0, n);
 		newTrees[n] = p;
 		p.matches = null;
+		p.matchShift = 0;
 
 		trees = newTrees;
 		return n;
@@ -621,7 +623,7 @@ public void enterSubtree() throws MissingObjectException,
 		System.arraycopy(tmp, 0, trees, 0, trees.length);
 	}
 
-	private AbstractTreeIterator min() {
+	AbstractTreeIterator min() throws CorruptObjectException {
 		int i = 0;
 		AbstractTreeIterator minRef = trees[i];
 		while (minRef.eof() && ++i < trees.length)
@@ -646,7 +648,7 @@ private AbstractTreeIterator min() {
 		return minRef;
 	}
 
-	private void popEntriesEqual() throws CorruptObjectException {
+	void popEntriesEqual() throws CorruptObjectException {
 		final AbstractTreeIterator ch = currentHead;
 		for (int i = 0; i < trees.length; i++) {
 			final AbstractTreeIterator t = trees[i];
@@ -657,7 +659,7 @@ private void popEntriesEqual() throws CorruptObjectException {
 		}
 	}
 
-	private void skipEntriesEqual() throws CorruptObjectException {
+	void skipEntriesEqual() throws CorruptObjectException {
 		final AbstractTreeIterator ch = currentHead;
 		for (int i = 0; i < trees.length; i++) {
 			final AbstractTreeIterator t = trees[i];
-- 
1.6.0.87.g2858d

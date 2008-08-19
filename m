From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 15/14] Micro-optimize the combineDF part of NameConflictTreeWalk
Date: Tue, 19 Aug 2008 16:17:13 -0700
Message-ID: <1219187833-26568-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Aug 20 01:18:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVaSx-0001wJ-2o
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 01:18:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752205AbYHSXRP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 19:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751639AbYHSXRP
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 19:17:15 -0400
Received: from george.spearce.org ([209.20.77.23]:56760 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751260AbYHSXRO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 19:17:14 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 1824B38376; Tue, 19 Aug 2008 23:17:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 7FEE038368;
	Tue, 19 Aug 2008 23:17:13 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.96.g2fad1.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92934>

We can do the common case of combineDF (which requires no lookahead)
during the search for the minimum entry by keeping track of the type
of each entry and using the single entry lookahead inherent in the
data structure.

Since this catches the most common case of "a" and "a/" with no
intervening "a.foo" we can typically avoid the much more costly
combineDF and skipEntry routines.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 This adds onto the end of my 14 patch D/F conflict series.  Last night
 it was bugging me that the common cases of all paths matching, or of
 the D/F pair being just one item apart required two loops through the
 iterators to identify the match (once in super.min, again in combineDF).

 .../jgit/treewalk/NameConflictTreeWalk.java        |   75 +++++++++++++++++++-
 1 files changed, 72 insertions(+), 3 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/NameConflictTreeWalk.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/NameConflictTreeWalk.java
index fdfba4e..dc854d8 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/treewalk/NameConflictTreeWalk.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/NameConflictTreeWalk.java
@@ -78,6 +78,8 @@
 public class NameConflictTreeWalk extends TreeWalk {
 	private static final int TREE_MODE = FileMode.TREE.getBits();
 
+	private boolean fastMinHasMatch;
+
 	/**
 	 * Create a new tree walker for a given repository.
 	 * 
@@ -91,11 +93,11 @@ public NameConflictTreeWalk(final Repository repo) {
 	@Override
 	AbstractTreeIterator min() throws CorruptObjectException {
 		for (;;) {
-			final AbstractTreeIterator minRef = super.min();
-			if (minRef.eof())
+			final AbstractTreeIterator minRef = fastMin();
+			if (fastMinHasMatch)
 				return minRef;
 
-			if (FileMode.TREE.equals(minRef.mode)) {
+			if (isTree(minRef)) {
 				if (skipEntry(minRef)) {
 					for (final AbstractTreeIterator t : trees) {
 						if (t.matches == minRef) {
@@ -112,6 +114,73 @@ AbstractTreeIterator min() throws CorruptObjectException {
 		}
 	}
 
+	private AbstractTreeIterator fastMin() {
+		fastMinHasMatch = true;
+
+		int i = 0;
+		AbstractTreeIterator minRef = trees[i];
+		while (minRef.eof() && ++i < trees.length)
+			minRef = trees[i];
+		if (minRef.eof())
+			return minRef;
+
+		minRef.matches = minRef;
+		while (++i < trees.length) {
+			final AbstractTreeIterator t = trees[i];
+			if (t.eof())
+				continue;
+
+			final int cmp = t.pathCompare(minRef);
+			if (cmp < 0) {
+				if (fastMinHasMatch && isTree(minRef) && !isTree(t)
+						&& nameEqual(minRef, t)) {
+					// We used to be at a tree, but now we are at a file
+					// with the same name. Allow the file to match the
+					// tree anyway.
+					//
+					t.matches = minRef;
+				} else {
+					fastMinHasMatch = false;
+					t.matches = t;
+					minRef = t;
+				}
+			} else if (cmp == 0) {
+				// Exact name/mode match is best.
+				//
+				t.matches = minRef;
+			} else if (fastMinHasMatch && isTree(t) && !isTree(minRef)
+					&& nameEqual(t, minRef)) {
+				// The minimum is a file (non-tree) but the next entry
+				// of this iterator is a tree whose name matches our file.
+				// This is a classic D/F conflict and commonly occurs like
+				// this, with no gaps in between the file and directory.
+				//
+				// Use the tree as the minimum instead (see combineDF).
+				//
+
+				for (int k = 0; k < i; k++) {
+					final AbstractTreeIterator p = trees[k];
+					if (p.matches == minRef)
+						p.matches = t;
+				}
+				t.matches = t;
+				minRef = t;
+			} else
+				fastMinHasMatch = false;
+		}
+
+		return minRef;
+	}
+
+	private static boolean nameEqual(final AbstractTreeIterator a,
+			final AbstractTreeIterator b) {
+		return a.pathCompare(b, TREE_MODE) == 0;
+	}
+
+	private static boolean isTree(final AbstractTreeIterator p) {
+		return FileMode.TREE.equals(p.mode);
+	}
+
 	private boolean skipEntry(final AbstractTreeIterator minRef)
 			throws CorruptObjectException {
 		// A tree D/F may have been handled earlier. We need to
-- 
1.6.0.96.g2fad1.dirty

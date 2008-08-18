From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 11/14] Expose beginning of iterator indication from AbstractTreeIterator
Date: Mon, 18 Aug 2008 16:53:19 -0700
Message-ID: <1219103602-32222-12-git-send-email-spearce@spearce.org>
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
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 01:55:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVEZ8-0006i3-IB
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 01:55:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754069AbYHRXxv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 19:53:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753813AbYHRXxs
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 19:53:48 -0400
Received: from george.spearce.org ([209.20.77.23]:45149 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753576AbYHRXxa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 19:53:30 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 6911E38379; Mon, 18 Aug 2008 23:53:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id EFEB738368;
	Mon, 18 Aug 2008 23:53:25 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.87.g2858d
In-Reply-To: <1219103602-32222-11-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92776>

Callers like TreeWalk need to know if back(1) is going to be a valid
operation for a given AbstractTreeIterator before they try to make a
call to move the iterator backwards.  The new method first() returns
true only if the iterator is already positioned on its first entry,
in which case a call to back(n) (for any n) is invalid.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../spearce/jgit/dircache/DirCacheIterator.java    |   12 +++++++++++-
 .../jgit/treewalk/AbstractTreeIterator.java        |   13 +++++++++++++
 .../spearce/jgit/treewalk/CanonicalTreeParser.java |    5 +++++
 .../spearce/jgit/treewalk/EmptyTreeIterator.java   |    5 +++++
 .../spearce/jgit/treewalk/WorkingTreeIterator.java |    5 +++++
 5 files changed, 39 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheIterator.java b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheIterator.java
index 84cefa5..8384723 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheIterator.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheIterator.java
@@ -64,6 +64,9 @@
 	/** The tree this iterator is walking. */
 	private final DirCacheTree tree;
 
+	/** First position in this tree. */
+	private final int treeStart;
+
 	/** Last position in this tree. */
 	private final int treeEnd;
 
@@ -95,6 +98,7 @@
 	public DirCacheIterator(final DirCache dc) {
 		cache = dc;
 		tree = dc.getCacheTree(true);
+		treeStart = 0;
 		treeEnd = tree.getEntrySpan();
 		subtreeId = new byte[Constants.OBJECT_ID_LENGTH];
 		if (!eof())
@@ -105,7 +109,8 @@ protected DirCacheIterator(final DirCacheIterator p, final DirCacheTree dct) {
 		super(p, p.path, p.pathLen + 1);
 		cache = p.cache;
 		tree = dct;
-		treeEnd = p.ptr + tree.getEntrySpan();
+		treeStart = p.ptr;
+		treeEnd = treeStart + tree.getEntrySpan();
 		subtreeId = p.subtreeId;
 		ptr = p.ptr;
 		parseEntry();
@@ -139,6 +144,11 @@ public int idOffset() {
 	}
 
 	@Override
+	public boolean first() {
+		return ptr == treeStart;
+	}
+
+	@Override
 	public boolean eof() {
 		return ptr == treeEnd;
 	}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/AbstractTreeIterator.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/AbstractTreeIterator.java
index 8ec506c..c1b7ad8 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/treewalk/AbstractTreeIterator.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/AbstractTreeIterator.java
@@ -340,6 +340,19 @@ public abstract AbstractTreeIterator createSubtreeIterator(Repository repo)
 			throws IncorrectObjectTypeException, IOException;
 
 	/**
+	 * Is this tree iterator positioned on its first entry?
+	 * <p>
+	 * An iterator is positioned on the first entry if <code>back(1)</code>
+	 * would be an invalid request as there is no entry before the current one.
+	 * <p>
+	 * An empty iterator (one with no entries) will be
+	 * <code>first() &amp;&amp; eof()</code>.
+	 * 
+	 * @return true if the iterator is positioned on the first entry.
+	 */
+	public abstract boolean first();
+
+	/**
 	 * Is this tree iterator at its EOF point (no more entries)?
 	 * <p>
 	 * An iterator is at EOF if there is no current entry.
diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/CanonicalTreeParser.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/CanonicalTreeParser.java
index 111d03b..dcc53cd 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/treewalk/CanonicalTreeParser.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/CanonicalTreeParser.java
@@ -126,6 +126,11 @@ public int idOffset() {
 		return nextPtr - Constants.OBJECT_ID_LENGTH;
 	}
 
+	@Override
+	public boolean first() {
+		return currPtr == 0;
+	}
+
 	public boolean eof() {
 		return currPtr == raw.length;
 	}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/EmptyTreeIterator.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/EmptyTreeIterator.java
index 232e3b1..eaca04e 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/treewalk/EmptyTreeIterator.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/EmptyTreeIterator.java
@@ -79,6 +79,11 @@ public int idOffset() {
 	}
 
 	@Override
+	public boolean first() {
+		return true;
+	}
+
+	@Override
 	public boolean eof() {
 		return true;
 	}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/WorkingTreeIterator.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/WorkingTreeIterator.java
index 41fd47b..9c53224 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/treewalk/WorkingTreeIterator.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/WorkingTreeIterator.java
@@ -231,6 +231,11 @@ public int idOffset() {
 	}
 
 	@Override
+	public boolean first() {
+		return ptr == 0;
+	}
+
+	@Override
 	public boolean eof() {
 		return ptr == entryCnt;
 	}
-- 
1.6.0.87.g2858d

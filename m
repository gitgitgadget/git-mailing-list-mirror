From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 09/10] Implement a Tree iterator
Date: Sun, 24 Feb 2008 00:50:42 +0100
Message-ID: <1203810643-28819-10-git-send-email-robin.rosenberg@dewire.com>
References: <1203810643-28819-1-git-send-email-robin.rosenberg@dewire.com>
 <1203810643-28819-2-git-send-email-robin.rosenberg@dewire.com>
 <1203810643-28819-3-git-send-email-robin.rosenberg@dewire.com>
 <1203810643-28819-4-git-send-email-robin.rosenberg@dewire.com>
 <1203810643-28819-5-git-send-email-robin.rosenberg@dewire.com>
 <1203810643-28819-6-git-send-email-robin.rosenberg@dewire.com>
 <1203810643-28819-7-git-send-email-robin.rosenberg@dewire.com>
 <1203810643-28819-8-git-send-email-robin.rosenberg@dewire.com>
 <1203810643-28819-9-git-send-email-robin.rosenberg@dewire.com>
Cc: David Watson <dwatson@mimvista.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 24 00:52:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JT4AT-0001IU-Ti
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 00:52:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754841AbYBWXvi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2008 18:51:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754766AbYBWXvh
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 18:51:37 -0500
Received: from [83.140.172.130] ([83.140.172.130]:11228 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754697AbYBWXvA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2008 18:51:00 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 78BAF80069D;
	Sun, 24 Feb 2008 00:50:59 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lodZAwur5nyG; Sun, 24 Feb 2008 00:50:58 +0100 (CET)
Received: from lathund.dewire.com (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id D1964802872;
	Sun, 24 Feb 2008 00:50:50 +0100 (CET)
Received: by lathund.dewire.com (Postfix, from userid 500)
	id 1E147293F2; Sun, 24 Feb 2008 00:50:43 +0100 (CET)
X-Mailer: git-send-email 1.5.4.2
In-Reply-To: <1203810643-28819-9-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74893>

This is an implementation of the Iterator interace. It can
be used for iterating over all entries in a tree in Git
order. Since it is an iterator it can be used to walk more
than one tree in parallel.

Although only post order is needed, preorder and leaves-only
mode is also implemented here.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../spearce/jgit/lib/TreeIteratorLeafOnlyTest.java |   85 +++++++++
 .../jgit/lib/TreeIteratorPostOrderTest.java        |  103 +++++++++++
 .../spearce/jgit/lib/TreeIteratorPreOrderTest.java |  103 +++++++++++
 .../src/org/spearce/jgit/lib/TreeIterator.java     |  182 ++++++++++++++++++++
 4 files changed, 473 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/lib/TreeIteratorLeafOnlyTest.java
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/lib/TreeIteratorPostOrderTest.java
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/lib/TreeIteratorPreOrderTest.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/TreeIterator.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/TreeIteratorLeafOnlyTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/TreeIteratorLeafOnlyTest.java
new file mode 100644
index 0000000..7d65982
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/TreeIteratorLeafOnlyTest.java
@@ -0,0 +1,85 @@
+package org.spearce.jgit.lib;
+
+import java.io.IOException;
+
+public class TreeIteratorLeafOnlyTest extends RepositoryTestCase {
+
+	/** Empty tree */
+	public void testEmpty() {
+		Tree tree = new Tree(db);
+		TreeIterator i = makeIterator(tree);
+		assertFalse(i.hasNext());
+	}
+
+	/**
+	 * one file
+	 * 
+	 * @throws IOException
+	 */
+	public void testSimpleF1() throws IOException {
+		Tree tree = new Tree(db);
+		tree.addFile("x");
+		TreeIterator i = makeIterator(tree);
+		assertTrue(i.hasNext());
+		assertEquals("x", i.next().getName());
+	}
+
+	/**
+	 * two files
+	 * 
+	 * @throws IOException
+	 */
+	public void testSimpleF2() throws IOException {
+		Tree tree = new Tree(db);
+		tree.addFile("a");
+		tree.addFile("x");
+		TreeIterator i = makeIterator(tree);
+		assertTrue(i.hasNext());
+		assertEquals("a", i.next().getName());
+		assertEquals("x", i.next().getName());
+	}
+
+	/**
+	 * Empty tree
+	 * 
+	 * @throws IOException
+	 */
+	public void testSimpleT() throws IOException {
+		Tree tree = new Tree(db);
+		tree.addTree("a");
+		TreeIterator i = makeIterator(tree);
+		assertFalse(i.hasNext());
+	}
+	
+	public void testTricky() throws IOException {
+		Tree tree = new Tree(db);
+		tree.addFile("a.b");
+		tree.addFile("a.c");
+		tree.addFile("a/b.b/b");
+		tree.addFile("a/b");
+		tree.addFile("a/c");
+		tree.addFile("a=c");
+		tree.addFile("a=d");
+
+		TreeIterator i = makeIterator(tree);
+		assertTrue(i.hasNext());
+		assertEquals("a.b", i.next().getFullName());
+		assertTrue(i.hasNext());
+		assertEquals("a.c", i.next().getFullName());
+		assertTrue(i.hasNext());
+		assertEquals("a/b", i.next().getFullName());
+		assertTrue(i.hasNext());
+		assertEquals("a/b.b/b", i.next().getFullName());
+		assertTrue(i.hasNext());
+		assertEquals("a/c", i.next().getFullName());
+		assertTrue(i.hasNext());
+		assertEquals("a=c", i.next().getFullName());
+		assertTrue(i.hasNext());
+		assertEquals("a=d", i.next().getFullName());
+		assertFalse(i.hasNext());
+	}
+
+	private TreeIterator makeIterator(Tree tree) {
+		return new TreeIterator(tree);
+	}
+}
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/TreeIteratorPostOrderTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/TreeIteratorPostOrderTest.java
new file mode 100644
index 0000000..a6def1d
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/TreeIteratorPostOrderTest.java
@@ -0,0 +1,103 @@
+package org.spearce.jgit.lib;
+
+import java.io.IOException;
+
+public class TreeIteratorPostOrderTest extends RepositoryTestCase {
+
+	/** Empty tree */
+	public void testEmpty() {
+		Tree tree = new Tree(db);
+		TreeIterator i = makeIterator(tree);
+		assertTrue(i.hasNext());
+		assertEquals("", i.next().getFullName());
+		assertFalse(i.hasNext());
+	}
+
+	/**
+	 * one file
+	 * 
+	 * @throws IOException
+	 */
+	public void testSimpleF1() throws IOException {
+		Tree tree = new Tree(db);
+		tree.addFile("x");
+		TreeIterator i = makeIterator(tree);
+		assertTrue(i.hasNext());
+		assertEquals("x", i.next().getName());
+		assertTrue(i.hasNext());
+		assertEquals("", i.next().getFullName());
+		assertFalse(i.hasNext());
+	}
+
+	/**
+	 * two files
+	 * 
+	 * @throws IOException
+	 */
+	public void testSimpleF2() throws IOException {
+		Tree tree = new Tree(db);
+		tree.addFile("a");
+		tree.addFile("x");
+		TreeIterator i = makeIterator(tree);
+		assertTrue(i.hasNext());
+		assertEquals("a", i.next().getName());
+		assertEquals("x", i.next().getName());
+		assertTrue(i.hasNext());
+		assertEquals("", i.next().getFullName());
+		assertFalse(i.hasNext());
+	}
+
+	/**
+	 * Empty tree
+	 * 
+	 * @throws IOException
+	 */
+	public void testSimpleT() throws IOException {
+		Tree tree = new Tree(db);
+		tree.addTree("a");
+		TreeIterator i = makeIterator(tree);
+		assertTrue(i.hasNext());
+		assertEquals("a", i.next().getFullName());
+		assertTrue(i.hasNext());
+		assertEquals("", i.next().getFullName());
+		assertFalse(i.hasNext());
+	}
+	
+	public void testTricky() throws IOException {
+		Tree tree = new Tree(db);
+		tree.addFile("a.b");
+		tree.addFile("a.c");
+		tree.addFile("a/b.b/b");
+		tree.addFile("a/b");
+		tree.addFile("a/c");
+		tree.addFile("a=c");
+		tree.addFile("a=d");
+
+		TreeIterator i = makeIterator(tree);
+		assertTrue(i.hasNext());
+		assertEquals("a.b", i.next().getFullName());
+		assertTrue(i.hasNext());
+		assertEquals("a.c", i.next().getFullName());
+		assertTrue(i.hasNext());
+		assertEquals("a/b", i.next().getFullName());
+		assertTrue(i.hasNext());
+		assertEquals("a/b.b/b", i.next().getFullName());
+		assertTrue(i.hasNext());
+		assertEquals("a/b.b", i.next().getFullName());
+		assertTrue(i.hasNext());
+		assertEquals("a/c", i.next().getFullName());
+		assertTrue(i.hasNext());
+		assertEquals("a", i.next().getFullName());
+		assertTrue(i.hasNext());
+		assertEquals("a=c", i.next().getFullName());
+		assertTrue(i.hasNext());
+		assertEquals("a=d", i.next().getFullName());
+		assertTrue(i.hasNext());
+		assertEquals("", i.next().getFullName());
+		assertFalse(i.hasNext());
+	}
+
+	private TreeIterator makeIterator(Tree tree) {
+		return new TreeIterator(tree, TreeIterator.Order.POSTORDER);
+	}
+}
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/TreeIteratorPreOrderTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/TreeIteratorPreOrderTest.java
new file mode 100644
index 0000000..e7e9bf4
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/TreeIteratorPreOrderTest.java
@@ -0,0 +1,103 @@
+package org.spearce.jgit.lib;
+
+import java.io.IOException;
+
+public class TreeIteratorPreOrderTest extends RepositoryTestCase {
+
+	/** Empty tree */
+	public void testEmpty() {
+		Tree tree = new Tree(db);
+		TreeIterator i = makeIterator(tree);
+		assertTrue(i.hasNext());
+		assertEquals("", i.next().getFullName());
+		assertFalse(i.hasNext());
+	}
+
+	/**
+	 * one file
+	 * 
+	 * @throws IOException
+	 */
+	public void testSimpleF1() throws IOException {
+		Tree tree = new Tree(db);
+		tree.addFile("x");
+		TreeIterator i = makeIterator(tree);
+		assertTrue(i.hasNext());
+		assertEquals("", i.next().getFullName());
+		assertTrue(i.hasNext());
+		assertEquals("x", i.next().getName());
+		assertFalse(i.hasNext());
+	}
+
+	/**
+	 * two files
+	 * 
+	 * @throws IOException
+	 */
+	public void testSimpleF2() throws IOException {
+		Tree tree = new Tree(db);
+		tree.addFile("a");
+		tree.addFile("x");
+		TreeIterator i = makeIterator(tree);
+		assertTrue(i.hasNext());
+		assertEquals("", i.next().getFullName());
+		assertTrue(i.hasNext());
+		assertEquals("a", i.next().getName());
+		assertEquals("x", i.next().getName());
+		assertFalse(i.hasNext());
+	}
+
+	/**
+	 * Empty tree
+	 * 
+	 * @throws IOException
+	 */
+	public void testSimpleT() throws IOException {
+		Tree tree = new Tree(db);
+		tree.addTree("a");
+		TreeIterator i = makeIterator(tree);
+		assertTrue(i.hasNext());
+		assertEquals("", i.next().getFullName());
+		assertTrue(i.hasNext());
+		assertEquals("a", i.next().getFullName());
+		assertFalse(i.hasNext());
+	}
+	
+	public void testTricky() throws IOException {
+		Tree tree = new Tree(db);
+		tree.addFile("a.b");
+		tree.addFile("a.c");
+		tree.addFile("a/b.b/b");
+		tree.addFile("a/b");
+		tree.addFile("a/c");
+		tree.addFile("a=c");
+		tree.addFile("a=d");
+
+		TreeIterator i = makeIterator(tree);
+		assertTrue(i.hasNext());
+		assertEquals("", i.next().getFullName());
+		assertTrue(i.hasNext());
+		assertEquals("a.b", i.next().getFullName());
+		assertTrue(i.hasNext());
+		assertEquals("a.c", i.next().getFullName());
+		assertTrue(i.hasNext());
+		assertEquals("a", i.next().getFullName());
+		assertTrue(i.hasNext());
+		assertEquals("a/b", i.next().getFullName());
+		assertTrue(i.hasNext());
+		assertEquals("a/b.b", i.next().getFullName());
+		assertTrue(i.hasNext());
+		assertEquals("a/b.b/b", i.next().getFullName());
+		assertTrue(i.hasNext());
+		assertEquals("a/c", i.next().getFullName());
+		assertTrue(i.hasNext());
+		assertEquals("a=c", i.next().getFullName());
+		assertTrue(i.hasNext());
+		assertEquals("a=d", i.next().getFullName());
+		assertFalse(i.hasNext());
+	}
+
+	private TreeIterator makeIterator(Tree tree) {
+		return new TreeIterator(tree, TreeIterator.Order.PREORDER);
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/TreeIterator.java b/org.spearce.jgit/src/org/spearce/jgit/lib/TreeIterator.java
new file mode 100644
index 0000000..e45d1fc
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/TreeIterator.java
@@ -0,0 +1,182 @@
+/*
+ *  Copyright (C) 2008 Robin Rosenberg
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License, version 2.1, as published by the Free Software Foundation.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301
+ */
+
+package org.spearce.jgit.lib;
+
+import java.io.IOException;
+import java.util.Iterator;
+
+/**
+ * A tree iterator iterates over a tree and all its members recursing into
+ * subtrees according to order.
+ *
+ * Default is to only visit leafs. An {@link Order} value can be supplied to
+ * make the iteration include Tree nodes as well either before or after the
+ * child nodes have been visited.
+ */
+public class TreeIterator implements Iterator<TreeEntry> {
+
+	private Tree tree;
+
+	private int index;
+
+	private TreeIterator sub;
+
+	private Order order;
+
+	private boolean visitTreeNodes;
+
+	private boolean hasVisitedTree;
+
+	/**
+	 * Traversal order
+	 */
+	public enum Order {
+		/**
+		 * Visit node first, then leaves
+		 */
+		PREORDER,
+
+		/**
+		 * Visit leaves first, then node
+		 */
+		POSTORDER
+	};
+
+	/**
+	 * Construct a {@link TreeIterator} for visiting all non-tree nodes.
+	 *
+	 * @param start
+	 */
+	public TreeIterator(Tree start) {
+		this(start, Order.PREORDER, false);
+	}
+
+	/**
+	 * Construct a {@link TreeIterator} visiting all nodes in a tree in a given
+	 * order.
+	 *
+	 * @param start Root node
+	 * @param order {@link Order}
+	 */
+	public TreeIterator(Tree start, Order order) {
+		this(start, order, true);
+	}
+
+	/**
+	 * Construct a {@link TreeIterator}
+	 *
+	 * @param start First node to visit
+	 * @param order Visitation {@link Order}
+	 * @param visitTreeNode True to include tree node
+	 */
+	private TreeIterator(Tree start, Order order, boolean visitTreeNode) {
+		this.tree = start;
+		this.visitTreeNodes = visitTreeNode;
+		this.index = -1;
+		this.order = order;
+		if (!visitTreeNodes)
+			this.hasVisitedTree = true;
+		try {
+			step();
+		} catch (IOException e) {
+			throw new Error(e);
+		}
+	}
+
+	public TreeEntry next() {
+		try {
+			TreeEntry ret = nextTreeEntry();
+			step();
+			return ret;
+		} catch (IOException e) {
+			throw new Error(e);
+		}
+	}
+
+	private TreeEntry nextTreeEntry() throws IOException {
+		TreeEntry ret;
+		if (sub != null)
+			ret = sub.nextTreeEntry();
+		else {
+			if (index < 0 && order == Order.PREORDER) {
+				return tree;
+			}
+			if (order == Order.POSTORDER && index == tree.memberCount()) {
+				return tree;
+			}
+			ret = tree.members()[index];
+		}
+		return ret;
+	}
+
+	public boolean hasNext() {
+		try {
+			return hasNextTreeEntry();
+		} catch (IOException e) {
+			throw new Error(e);
+		}
+	}
+
+	private boolean hasNextTreeEntry() throws IOException {
+		if (tree == null)
+			return false;
+		return sub != null
+			|| index < tree.memberCount()
+			|| order == Order.POSTORDER && index == tree.memberCount();
+	}
+
+	private boolean step() throws IOException {
+		if (tree == null)
+			return false;
+
+		if (sub != null) {
+			if (sub.step())
+				return true;
+			sub = null;
+		}
+
+		if (index < 0 && !hasVisitedTree && order == Order.PREORDER) {
+			hasVisitedTree = true;
+			return true;
+		}
+
+		while (++index < tree.memberCount()) {
+			TreeEntry e = tree.members()[index];
+			if (e instanceof Tree) {
+				sub = new TreeIterator((Tree) e, order, visitTreeNodes);
+				if (sub.hasNextTreeEntry())
+					return true;
+				sub = null;
+				continue;
+			}
+			return true;
+		}
+
+		if (index == tree.memberCount() && !hasVisitedTree
+				&& order == Order.POSTORDER) {
+			hasVisitedTree = true;
+			return true;
+		}
+		return false;
+	}
+
+	public void remove() {
+		throw new IllegalStateException(
+				"TreeIterator does not suppport remove()");
+	}
+}
-- 
1.5.4.2

From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 03/15] Add IntList as a more efficient representation of List<Integer>
Date: Thu, 11 Dec 2008 18:46:09 -0800
Message-ID: <1229049981-14152-4-git-send-email-spearce@spearce.org>
References: <1229049981-14152-1-git-send-email-spearce@spearce.org>
 <1229049981-14152-2-git-send-email-spearce@spearce.org>
 <1229049981-14152-3-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 03:48:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAy4v-00057A-Vd
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 03:48:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757313AbYLLCqf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 21:46:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757089AbYLLCqb
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 21:46:31 -0500
Received: from george.spearce.org ([209.20.77.23]:41575 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757213AbYLLCq0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2008 21:46:26 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 4B0F938267; Fri, 12 Dec 2008 02:46:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id C3FEF38194;
	Fri, 12 Dec 2008 02:46:22 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc2.306.ge5d5e
In-Reply-To: <1229049981-14152-3-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102866>

Java's generic container types can only handle reference values,
which means making a List of ints requires boxing each value. A
boxed int typically requires at least 12 bytes more space per
value over an unboxed int, as it has an additional object header
and a cell to hold the object reference.

IntList uses an int[] internally to hold the values, rather than
an Object[] like List<Integer> would use.

We don't conform to the List (or even Collection) APIs as doing
so would require that we box return values, which is even less
efficient than just using ArrayList<Integer>, because we would
be boxing every return value each time it is accessed.  Instead
we use an API that smells the same, so there is some finger feel
to using the class.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../tst/org/spearce/jgit/util/IntListTest.java     |  132 ++++++++++++++++++++
 .../src/org/spearce/jgit/util/IntList.java         |  113 +++++++++++++++++
 2 files changed, 245 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/util/IntListTest.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/util/IntList.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/util/IntListTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/util/IntListTest.java
new file mode 100644
index 0000000..f943075
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/util/IntListTest.java
@@ -0,0 +1,132 @@
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
+package org.spearce.jgit.util;
+
+import junit.framework.TestCase;
+
+public class IntListTest extends TestCase {
+	public void testEmpty_DefaultCapacity() {
+		final IntList i = new IntList();
+		assertEquals(0, i.size());
+		try {
+			i.get(0);
+			fail("Accepted 0 index on empty list");
+		} catch (ArrayIndexOutOfBoundsException e) {
+			assertTrue(true);
+		}
+	}
+
+	public void testEmpty_SpecificCapacity() {
+		final IntList i = new IntList(5);
+		assertEquals(0, i.size());
+		try {
+			i.get(0);
+			fail("Accepted 0 index on empty list");
+		} catch (ArrayIndexOutOfBoundsException e) {
+			assertTrue(true);
+		}
+	}
+
+	public void testAdd_SmallGroup() {
+		final IntList i = new IntList();
+		final int n = 5;
+		for (int v = 0; v < n; v++)
+			i.add(10 + v);
+		assertEquals(n, i.size());
+
+		for (int v = 0; v < n; v++)
+			assertEquals(10 + v, i.get(v));
+		try {
+			i.get(n);
+			fail("Accepted out of bound index on list");
+		} catch (ArrayIndexOutOfBoundsException e) {
+			assertTrue(true);
+		}
+	}
+
+	public void testAdd_ZeroCapacity() {
+		final IntList i = new IntList(0);
+		assertEquals(0, i.size());
+		i.add(1);
+		assertEquals(1, i.get(0));
+	}
+
+	public void testAdd_LargeGroup() {
+		final IntList i = new IntList();
+		final int n = 500;
+		for (int v = 0; v < n; v++)
+			i.add(10 + v);
+		assertEquals(n, i.size());
+
+		for (int v = 0; v < n; v++)
+			assertEquals(10 + v, i.get(v));
+		try {
+			i.get(n);
+			fail("Accepted out of bound index on list");
+		} catch (ArrayIndexOutOfBoundsException e) {
+			assertTrue(true);
+		}
+	}
+
+	public void testClear() {
+		final IntList i = new IntList();
+		final int n = 5;
+		for (int v = 0; v < n; v++)
+			i.add(10 + v);
+		assertEquals(n, i.size());
+
+		i.clear();
+		assertEquals(0, i.size());
+		try {
+			i.get(0);
+			fail("Accepted 0 index on empty list");
+		} catch (ArrayIndexOutOfBoundsException e) {
+			assertTrue(true);
+		}
+	}
+
+	public void testToString() {
+		final IntList i = new IntList();
+		i.add(1);
+		assertEquals("[1]", i.toString());
+		i.add(13);
+		i.add(5);
+		assertEquals("[1, 13, 5]", i.toString());
+	}
+
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/util/IntList.java b/org.spearce.jgit/src/org/spearce/jgit/util/IntList.java
new file mode 100644
index 0000000..1445f88
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/util/IntList.java
@@ -0,0 +1,113 @@
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
+package org.spearce.jgit.util;
+
+/** A more efficient List<Integer> using a primitive integer array. */
+public class IntList {
+	private int[] entries;
+
+	private int count;
+
+	/** Create an empty list with a default capacity. */
+	public IntList() {
+		this(10);
+	}
+
+	/**
+	 * Create an empty list with the specified capacity.
+	 * 
+	 * @param capacity
+	 *            number of entries the list can initially hold.
+	 */
+	public IntList(final int capacity) {
+		entries = new int[capacity];
+	}
+
+	/** @return number of entries in this list */
+	public int size() {
+		return count;
+	}
+
+	/**
+	 * @param i
+	 *            index to read, must be in the range [0, {@link #size()}).
+	 * @return the number at the specified index
+	 * @throws ArrayIndexOutOfBoundsException
+	 *             the index outside the valid range
+	 */
+	public int get(final int i) {
+		if (count <= i)
+			throw new ArrayIndexOutOfBoundsException(i);
+		return entries[i];
+	}
+
+	/** Empty this list */
+	public void clear() {
+		count = 0;
+	}
+
+	/**
+	 * Add an entry to the end of the list.
+	 * 
+	 * @param n
+	 *            the number to add.
+	 */
+	public void add(final int n) {
+		if (count == entries.length)
+			grow();
+		entries[count++] = n;
+	}
+
+	private void grow() {
+		final int[] n = new int[(entries.length + 16) * 3 / 2];
+		System.arraycopy(entries, 0, n, 0, count);
+		entries = n;
+	}
+
+	public String toString() {
+		final StringBuilder r = new StringBuilder();
+		r.append('[');
+		for (int i = 0; i < count; i++) {
+			if (i > 0)
+				r.append(", ");
+			r.append(entries[i]);
+		}
+		r.append(']');
+		return r.toString();
+	}
+}
-- 
1.6.1.rc2.306.ge5d5e

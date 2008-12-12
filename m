From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 04/15] Add lineMap computer to RawParseUtils to index locations of line starts
Date: Thu, 11 Dec 2008 18:46:10 -0800
Message-ID: <1229049981-14152-5-git-send-email-spearce@spearce.org>
References: <1229049981-14152-1-git-send-email-spearce@spearce.org>
 <1229049981-14152-2-git-send-email-spearce@spearce.org>
 <1229049981-14152-3-git-send-email-spearce@spearce.org>
 <1229049981-14152-4-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 03:48:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAy4x-00057A-Fa
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 03:48:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757256AbYLLCqj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 21:46:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757276AbYLLCqe
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 21:46:34 -0500
Received: from george.spearce.org ([209.20.77.23]:41578 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757228AbYLLCq0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2008 21:46:26 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 382FD38269; Fri, 12 Dec 2008 02:46:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 2028F38211;
	Fri, 12 Dec 2008 02:46:23 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc2.306.ge5d5e
In-Reply-To: <1229049981-14152-4-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102868>

Some algorithms like a diff or patch require efficient lookup of lines
within a source file, using a 1 based line number.  lineMap produces a
list of offsets within the file where each line starts, providing O(1)
lookup time to locate those positions.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../tst/org/spearce/jgit/util/IntListTest.java     |   24 ++++++
 .../jgit/util/RawParseUtils_LineMapTest.java       |   88 ++++++++++++++++++++
 .../src/org/spearce/jgit/util/IntList.java         |   15 ++++
 .../src/org/spearce/jgit/util/RawParseUtils.java   |   31 +++++++
 4 files changed, 158 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/util/RawParseUtils_LineMapTest.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/util/IntListTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/util/IntListTest.java
index f943075..c470d55 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/util/IntListTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/util/IntListTest.java
@@ -103,6 +103,30 @@ public void testAdd_LargeGroup() {
 		}
 	}
 
+	public void testFillTo0() {
+		final IntList i = new IntList();
+		i.fillTo(0, Integer.MIN_VALUE);
+		assertEquals(0, i.size());
+	}
+
+	public void testFillTo1() {
+		final IntList i = new IntList();
+		i.fillTo(1, Integer.MIN_VALUE);
+		assertEquals(1, i.size());
+		i.add(0);
+		assertEquals(Integer.MIN_VALUE, i.get(0));
+		assertEquals(0, i.get(1));
+	}
+
+	public void testFillTo100() {
+		final IntList i = new IntList();
+		i.fillTo(100, Integer.MIN_VALUE);
+		assertEquals(100, i.size());
+		i.add(3);
+		assertEquals(Integer.MIN_VALUE, i.get(99));
+		assertEquals(3, i.get(100));
+	}
+
 	public void testClear() {
 		final IntList i = new IntList();
 		final int n = 5;
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/util/RawParseUtils_LineMapTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/util/RawParseUtils_LineMapTest.java
new file mode 100644
index 0000000..3f562a4
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/util/RawParseUtils_LineMapTest.java
@@ -0,0 +1,88 @@
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
+import java.io.UnsupportedEncodingException;
+
+import junit.framework.TestCase;
+
+public class RawParseUtils_LineMapTest extends TestCase {
+	public void testEmpty() {
+		final IntList map = RawParseUtils.lineMap(new byte[] {}, 0, 0);
+		assertNotNull(map);
+		assertEquals(1, map.size());
+		assertEquals(Integer.MIN_VALUE, map.get(0));
+	}
+
+	public void testOneBlankLine() {
+		final IntList map = RawParseUtils.lineMap(new byte[] { '\n' }, 0, 1);
+		assertEquals(2, map.size());
+		assertEquals(Integer.MIN_VALUE, map.get(0));
+		assertEquals(0, map.get(1));
+	}
+
+	public void testTwoLineFooBar() throws UnsupportedEncodingException {
+		final byte[] buf = "foo\nbar\n".getBytes("ISO-8859-1");
+		final IntList map = RawParseUtils.lineMap(buf, 0, buf.length);
+		assertEquals(3, map.size());
+		assertEquals(Integer.MIN_VALUE, map.get(0));
+		assertEquals(0, map.get(1));
+		assertEquals(4, map.get(2));
+	}
+
+	public void testTwoLineNoLF() throws UnsupportedEncodingException {
+		final byte[] buf = "foo\nbar".getBytes("ISO-8859-1");
+		final IntList map = RawParseUtils.lineMap(buf, 0, buf.length);
+		assertEquals(3, map.size());
+		assertEquals(Integer.MIN_VALUE, map.get(0));
+		assertEquals(0, map.get(1));
+		assertEquals(4, map.get(2));
+	}
+
+	public void testFourLineBlanks() throws UnsupportedEncodingException {
+		final byte[] buf = "foo\n\n\nbar\n".getBytes("ISO-8859-1");
+		final IntList map = RawParseUtils.lineMap(buf, 0, buf.length);
+		assertEquals(5, map.size());
+		assertEquals(Integer.MIN_VALUE, map.get(0));
+		assertEquals(0, map.get(1));
+		assertEquals(4, map.get(2));
+		assertEquals(5, map.get(3));
+		assertEquals(6, map.get(4));
+	}
+
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/util/IntList.java b/org.spearce.jgit/src/org/spearce/jgit/util/IntList.java
index 1445f88..2824074 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/util/IntList.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/util/IntList.java
@@ -93,6 +93,21 @@ public void add(final int n) {
 		entries[count++] = n;
 	}
 
+	/**
+	 * Pad the list with entries.
+	 * 
+	 * @param toIndex
+	 *            index position to stop filling at. 0 inserts no filler. 1
+	 *            ensures the list has a size of 1, adding <code>val</code> if
+	 *            the list is currently empty.
+	 * @param val
+	 *            value to insert into padded positions.
+	 */
+	public void fillTo(int toIndex, final int val) {
+		while (count < toIndex)
+			add(val);
+	}
+
 	private void grow() {
 		final int[] n = new int[(entries.length + 16) * 3 / 2];
 		System.arraycopy(entries, 0, n, 0, count);
diff --git a/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java b/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java
index 8896d38..6143188 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java
@@ -266,6 +266,37 @@ public static final int nextLF(final byte[] b, int ptr, final char chrA) {
 	}
 
 	/**
+	 * Index the region between <code>[ptr, end)</code> to find line starts.
+	 * <p>
+	 * The returned list is 1 indexed. Index 0 contains
+	 * {@link Integer#MIN_VALUE} to pad the list out.
+	 * <p>
+	 * Using a 1 indexed list means that line numbers can be directly accessed
+	 * from the list, so <code>list.get(1)</code> (aka get line 1) returns
+	 * <code>ptr</code>.
+	 * 
+	 * @param buf
+	 *            buffer to scan.
+	 * @param ptr
+	 *            position within the buffer corresponding to the first byte of
+	 *            line 1.
+	 * @param end
+	 *            1 past the end of the content within <code>buf</code>.
+	 * @return a line map indexing the start position of each line.
+	 */
+	public static final IntList lineMap(final byte[] buf, int ptr, int end) {
+		// Experimentally derived from multiple source repositories
+		// the average number of bytes/line is 36. Its a rough guess
+		// to initially size our map close to the target.
+		//
+		final IntList map = new IntList((end - ptr) / 36);
+		map.fillTo(1, Integer.MIN_VALUE);
+		for (; ptr < end; ptr = nextLF(buf, ptr))
+			map.add(ptr);
+		return map;
+	}
+
+	/**
 	 * Locate the "author " header line data.
 	 * 
 	 * @param b
-- 
1.6.1.rc2.306.ge5d5e

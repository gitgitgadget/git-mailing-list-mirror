From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 1/3] Define an abstraction for handling abbreviated SHA-1 strings
Date: Wed, 10 Dec 2008 15:18:25 -0800
Message-ID: <1228951107-5546-2-git-send-email-spearce@spearce.org>
References: <1228951107-5546-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Dec 11 00:19:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAYLM-0005X0-D9
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 00:19:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753929AbYLJXSd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 18:18:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753966AbYLJXSc
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 18:18:32 -0500
Received: from george.spearce.org ([209.20.77.23]:41566 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752994AbYLJXSa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 18:18:30 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 673D73821F; Wed, 10 Dec 2008 23:18:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 2C22338200;
	Wed, 10 Dec 2008 23:18:28 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc2.299.gead4c
In-Reply-To: <1228951107-5546-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102736>

The AbbreviatedObjectId class parses an abbreviated SHA-1 string
into a binary format, permitting it to be more efficiently matched
against existing binary ObjectId fields.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../spearce/jgit/lib/AbbreviatedObjectIdTest.java  |  227 ++++++++++++++++++++
 .../org/spearce/jgit/lib/AbbreviatedObjectId.java  |  205 ++++++++++++++++++
 .../src/org/spearce/jgit/lib/AnyObjectId.java      |    2 +-
 3 files changed, 433 insertions(+), 1 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/lib/AbbreviatedObjectIdTest.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/AbbreviatedObjectId.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/AbbreviatedObjectIdTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/AbbreviatedObjectIdTest.java
new file mode 100644
index 0000000..f540f49
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/AbbreviatedObjectIdTest.java
@@ -0,0 +1,227 @@
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
+package org.spearce.jgit.lib;
+
+import junit.framework.TestCase;
+
+public class AbbreviatedObjectIdTest extends TestCase {
+	public void testEmpty_FromByteArray() {
+		final AbbreviatedObjectId i;
+		i = AbbreviatedObjectId.fromString(new byte[] {}, 0, 0);
+		assertNotNull(i);
+		assertEquals(0, i.length());
+		assertFalse(i.isComplete());
+		assertEquals("", i.name());
+	}
+
+	public void testEmpty_FromString() {
+		final AbbreviatedObjectId i = AbbreviatedObjectId.fromString("");
+		assertNotNull(i);
+		assertEquals(0, i.length());
+		assertFalse(i.isComplete());
+		assertEquals("", i.name());
+	}
+
+	public void testFull_FromByteArray() {
+		final String s = "7b6e8067ec96acef9a4184b43210d583b6d2f99a";
+		final byte[] b = Constants.encodeASCII(s);
+		final AbbreviatedObjectId i = AbbreviatedObjectId.fromString(b, 0,
+				b.length);
+		assertNotNull(i);
+		assertEquals(s.length(), i.length());
+		assertTrue(i.isComplete());
+		assertEquals(s, i.name());
+
+		final ObjectId f = i.toObjectId();
+		assertNotNull(f);
+		assertEquals(ObjectId.fromString(s), f);
+		assertEquals(f.hashCode(), i.hashCode());
+	}
+
+	public void testFull_FromString() {
+		final String s = "7b6e8067ec96acef9a4184b43210d583b6d2f99a";
+		final AbbreviatedObjectId i = AbbreviatedObjectId.fromString(s);
+		assertNotNull(i);
+		assertEquals(s.length(), i.length());
+		assertTrue(i.isComplete());
+		assertEquals(s, i.name());
+
+		final ObjectId f = i.toObjectId();
+		assertNotNull(f);
+		assertEquals(ObjectId.fromString(s), f);
+		assertEquals(f.hashCode(), i.hashCode());
+	}
+
+	public void test1_FromString() {
+		final String s = "7";
+		final AbbreviatedObjectId i = AbbreviatedObjectId.fromString(s);
+		assertNotNull(i);
+		assertEquals(s.length(), i.length());
+		assertFalse(i.isComplete());
+		assertEquals(s, i.name());
+		assertNull(i.toObjectId());
+	}
+
+	public void test2_FromString() {
+		final String s = "7b";
+		final AbbreviatedObjectId i = AbbreviatedObjectId.fromString(s);
+		assertNotNull(i);
+		assertEquals(s.length(), i.length());
+		assertFalse(i.isComplete());
+		assertEquals(s, i.name());
+		assertNull(i.toObjectId());
+	}
+
+	public void test3_FromString() {
+		final String s = "7b6";
+		final AbbreviatedObjectId i = AbbreviatedObjectId.fromString(s);
+		assertNotNull(i);
+		assertEquals(s.length(), i.length());
+		assertFalse(i.isComplete());
+		assertEquals(s, i.name());
+		assertNull(i.toObjectId());
+	}
+
+	public void test4_FromString() {
+		final String s = "7b6e";
+		final AbbreviatedObjectId i = AbbreviatedObjectId.fromString(s);
+		assertNotNull(i);
+		assertEquals(s.length(), i.length());
+		assertFalse(i.isComplete());
+		assertEquals(s, i.name());
+		assertNull(i.toObjectId());
+	}
+
+	public void test5_FromString() {
+		final String s = "7b6e8";
+		final AbbreviatedObjectId i = AbbreviatedObjectId.fromString(s);
+		assertNotNull(i);
+		assertEquals(s.length(), i.length());
+		assertFalse(i.isComplete());
+		assertEquals(s, i.name());
+		assertNull(i.toObjectId());
+	}
+
+	public void test6_FromString() {
+		final String s = "7b6e80";
+		final AbbreviatedObjectId i = AbbreviatedObjectId.fromString(s);
+		assertNotNull(i);
+		assertEquals(s.length(), i.length());
+		assertFalse(i.isComplete());
+		assertEquals(s, i.name());
+		assertNull(i.toObjectId());
+	}
+
+	public void test7_FromString() {
+		final String s = "7b6e806";
+		final AbbreviatedObjectId i = AbbreviatedObjectId.fromString(s);
+		assertNotNull(i);
+		assertEquals(s.length(), i.length());
+		assertFalse(i.isComplete());
+		assertEquals(s, i.name());
+		assertNull(i.toObjectId());
+	}
+
+	public void test8_FromString() {
+		final String s = "7b6e8067";
+		final AbbreviatedObjectId i = AbbreviatedObjectId.fromString(s);
+		assertNotNull(i);
+		assertEquals(s.length(), i.length());
+		assertFalse(i.isComplete());
+		assertEquals(s, i.name());
+		assertNull(i.toObjectId());
+	}
+
+	public void test9_FromString() {
+		final String s = "7b6e8067e";
+		final AbbreviatedObjectId i = AbbreviatedObjectId.fromString(s);
+		assertNotNull(i);
+		assertEquals(s.length(), i.length());
+		assertFalse(i.isComplete());
+		assertEquals(s, i.name());
+		assertNull(i.toObjectId());
+	}
+
+	public void test17_FromString() {
+		final String s = "7b6e8067ec96acef9";
+		final AbbreviatedObjectId i = AbbreviatedObjectId.fromString(s);
+		assertNotNull(i);
+		assertEquals(s.length(), i.length());
+		assertFalse(i.isComplete());
+		assertEquals(s, i.name());
+		assertNull(i.toObjectId());
+	}
+
+	public void testEquals_Short() {
+		final String s = "7b6e8067";
+		final AbbreviatedObjectId a = AbbreviatedObjectId.fromString(s);
+		final AbbreviatedObjectId b = AbbreviatedObjectId.fromString(s);
+		assertNotSame(a, b);
+		assertTrue(a.hashCode() == b.hashCode());
+		assertTrue(a.equals(b));
+		assertTrue(b.equals(a));
+	}
+
+	public void testEquals_Full() {
+		final String s = "7b6e8067ec96acef9a4184b43210d583b6d2f99a";
+		final AbbreviatedObjectId a = AbbreviatedObjectId.fromString(s);
+		final AbbreviatedObjectId b = AbbreviatedObjectId.fromString(s);
+		assertNotSame(a, b);
+		assertTrue(a.hashCode() == b.hashCode());
+		assertTrue(a.equals(b));
+		assertTrue(b.equals(a));
+	}
+
+	public void testNotEquals_SameLength() {
+		final String sa = "7b6e8067";
+		final String sb = "7b6e806e";
+		final AbbreviatedObjectId a = AbbreviatedObjectId.fromString(sa);
+		final AbbreviatedObjectId b = AbbreviatedObjectId.fromString(sb);
+		assertFalse(a.equals(b));
+		assertFalse(b.equals(a));
+	}
+
+	public void testNotEquals_DiffLength() {
+		final String sa = "7b6e8067abcd";
+		final String sb = "7b6e8067";
+		final AbbreviatedObjectId a = AbbreviatedObjectId.fromString(sa);
+		final AbbreviatedObjectId b = AbbreviatedObjectId.fromString(sb);
+		assertFalse(a.equals(b));
+		assertFalse(b.equals(a));
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/AbbreviatedObjectId.java b/org.spearce.jgit/src/org/spearce/jgit/lib/AbbreviatedObjectId.java
new file mode 100644
index 0000000..1a8d296
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/AbbreviatedObjectId.java
@@ -0,0 +1,205 @@
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
+package org.spearce.jgit.lib;
+
+import java.io.UnsupportedEncodingException;
+
+/**
+ * A prefix abbreviation of an {@link ObjectId}.
+ * <p>
+ * Sometimes Git produces abbreviated SHA-1 strings, using sufficient leading
+ * digits from the ObjectId name to still be unique within the repository the
+ * string was generated from. These ids are likely to be unique for a useful
+ * period of time, especially if they contain at least 6-10 hex digits.
+ * <p>
+ * This class converts the hex string into a binary form, to make it more
+ * efficient for matching against an object.
+ */
+public class AbbreviatedObjectId {
+	/**
+	 * Convert an AbbreviatedObjectId from hex characters (US-ASCII).
+	 * 
+	 * @param buf
+	 *            the US-ASCII buffer to read from.
+	 * @param offset
+	 *            position to read the first character from.
+	 * @param end
+	 *            one past the last position to read (<code>end-offset</code> is
+	 *            the length of the string).
+	 * @return the converted object id.
+	 */
+	public static final AbbreviatedObjectId fromString(final byte[] buf,
+			final int offset, final int end) {
+		if (end - offset > AnyObjectId.STR_LEN)
+			throw new IllegalArgumentException("Invalid id");
+		return fromHexString(buf, offset, end);
+	}
+
+	/**
+	 * Convert an AbbreviatedObjectId from hex characters.
+	 * 
+	 * @param str
+	 *            the string to read from. Must be &lt;= 40 characters.
+	 * @return the converted object id.
+	 */
+	public static final AbbreviatedObjectId fromString(final String str) {
+		if (str.length() > AnyObjectId.STR_LEN)
+			throw new IllegalArgumentException("Invalid id: " + str);
+		final byte[] b = Constants.encodeASCII(str);
+		return fromHexString(b, 0, b.length);
+	}
+
+	private static final AbbreviatedObjectId fromHexString(final byte[] bs,
+			int ptr, final int end) {
+		try {
+			final int a = hexUInt32(bs, ptr, end);
+			final int b = hexUInt32(bs, ptr + 8, end);
+			final int c = hexUInt32(bs, ptr + 16, end);
+			final int d = hexUInt32(bs, ptr + 24, end);
+			final int e = hexUInt32(bs, ptr + 32, end);
+			return new AbbreviatedObjectId(end - ptr, a, b, c, d, e);
+		} catch (ArrayIndexOutOfBoundsException e1) {
+			try {
+				final String str = new String(bs, ptr, end - ptr, "US-ASCII");
+				throw new IllegalArgumentException("Invalid id: " + str);
+			} catch (UnsupportedEncodingException e2) {
+				throw new IllegalArgumentException("Invalid id");
+			}
+		}
+	}
+
+	private static final int hexUInt32(final byte[] bs, int p, final int end) {
+		if (8 <= end - p)
+			return AnyObjectId.hexUInt32(bs, p);
+
+		int r = 0, n = 0;
+		while (n < 8 && p < end) {
+			final int v = AnyObjectId.fromhex[bs[p++]];
+			if (v < 0)
+				throw new ArrayIndexOutOfBoundsException();
+			r <<= 4;
+			r |= v;
+			n++;
+		}
+		return r << (8 - n) * 4;
+	}
+
+	/** Number of half-bytes used by this id. */
+	final int nibbles;
+
+	final int w1;
+
+	final int w2;
+
+	final int w3;
+
+	final int w4;
+
+	final int w5;
+
+	private AbbreviatedObjectId(final int n, final int new_1, final int new_2,
+			final int new_3, final int new_4, final int new_5) {
+		nibbles = n;
+		w1 = new_1;
+		w2 = new_2;
+		w3 = new_3;
+		w4 = new_4;
+		w5 = new_5;
+	}
+
+	/** @return number of hex digits appearing in this id */
+	public int length() {
+		return nibbles;
+	}
+
+	/** @return true if this ObjectId is actually a complete id. */
+	public boolean isComplete() {
+		return length() == AnyObjectId.RAW_LEN * 2;
+	}
+
+	/** @return a complete ObjectId; null if {@link #isComplete()} is false */
+	public ObjectId toObjectId() {
+		return isComplete() ? new ObjectId(w1, w2, w3, w4, w5) : null;
+	}
+
+	@Override
+	public int hashCode() {
+		return w2;
+	}
+
+	@Override
+	public boolean equals(final Object o) {
+		if (o instanceof AbbreviatedObjectId) {
+			final AbbreviatedObjectId b = (AbbreviatedObjectId) o;
+			return nibbles == b.nibbles && w1 == b.w1 && w2 == b.w2
+					&& w3 == b.w3 && w4 == b.w4 && w5 == b.w5;
+		}
+		return false;
+	}
+
+	/**
+	 * @return string form of the abbreviation, in lower case hexadecimal.
+	 */
+	public final String name() {
+		final char[] b = new char[AnyObjectId.STR_LEN];
+
+		AnyObjectId.formatHexChar(b, 0, w1);
+		if (nibbles <= 8)
+			return new String(b, 0, nibbles);
+
+		AnyObjectId.formatHexChar(b, 8, w2);
+		if (nibbles <= 16)
+			return new String(b, 0, nibbles);
+
+		AnyObjectId.formatHexChar(b, 16, w3);
+		if (nibbles <= 24)
+			return new String(b, 0, nibbles);
+
+		AnyObjectId.formatHexChar(b, 24, w4);
+		if (nibbles <= 32)
+			return new String(b, 0, nibbles);
+
+		AnyObjectId.formatHexChar(b, 32, w5);
+		return new String(b, 0, nibbles);
+	}
+
+	@Override
+	public String toString() {
+		return "AbbreviatedObjectId[" + name() + "]";
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/AnyObjectId.java b/org.spearce.jgit/src/org/spearce/jgit/lib/AnyObjectId.java
index a534202..e88e09d 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/AnyObjectId.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/AnyObjectId.java
@@ -396,7 +396,7 @@ private void toHexCharArray(final char[] dst) {
 	private static final char[] hexchar = { '0', '1', '2', '3', '4', '5', '6',
 			'7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f' };
 
-	private static void formatHexChar(final char[] dst, final int p, int w) {
+	static void formatHexChar(final char[] dst, final int p, int w) {
 		int o = p + 7;
 		while (o >= p && w != 0) {
 			dst[o--] = hexchar[w & 0xf];
-- 
1.6.1.rc2.299.gead4c

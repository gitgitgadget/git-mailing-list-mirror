From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 1/7] Move hex parsing functions to RawParseUtil, accept upper case
Date: Thu,  4 Jun 2009 14:43:57 -0700
Message-ID: <1244151843-26954-2-git-send-email-spearce@spearce.org>
References: <1244151843-26954-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Jun 04 23:45:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCKkF-0001OL-Uf
	for gcvg-git-2@gmane.org; Thu, 04 Jun 2009 23:45:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754313AbZFDVoI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2009 17:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754397AbZFDVoG
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jun 2009 17:44:06 -0400
Received: from george.spearce.org ([209.20.77.23]:35362 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753507AbZFDVoD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2009 17:44:03 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 4C4A338221; Thu,  4 Jun 2009 21:44:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id C38BA381D1;
	Thu,  4 Jun 2009 21:44:03 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.1.333.g3ebba7
In-Reply-To: <1244151843-26954-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120715>

This way we can reuse them beyond just the ObjectId family of classes.

We also now accept upper case hex digits in object ids.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../tst/org/spearce/jgit/lib/T0001_ObjectId.java   |   10 ++-
 .../org/spearce/jgit/lib/AbbreviatedObjectId.java  |    8 +-
 .../src/org/spearce/jgit/lib/AnyObjectId.java      |   36 ---------
 .../src/org/spearce/jgit/lib/MutableObjectId.java  |   11 ++-
 .../src/org/spearce/jgit/lib/ObjectId.java         |   19 +++--
 .../src/org/spearce/jgit/util/RawParseUtils.java   |   80 ++++++++++++++++++--
 6 files changed, 101 insertions(+), 63 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0001_ObjectId.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0001_ObjectId.java
index 4c03667..7a53925 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0001_ObjectId.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0001_ObjectId.java
@@ -74,8 +74,8 @@ assertFalse("39 digits is not an id", ObjectId
 				.isId("def4c620bc3713bb1bb26b808ec9312548e7394"));
 	}
 
-	public void test007_notIsId() {
-		assertFalse("uppercase is not accepted", ObjectId
+	public void test007_isId() {
+		assertTrue("uppercase is accepted", ObjectId
 				.isId("Def4c620bc3713bb1bb26b808ec9312548e73946"));
 	}
 
@@ -94,4 +94,10 @@ public void test010_toString() {
 		final String x = "0000000000000000000000000000000000000000";
 		assertEquals(x, ObjectId.toString(null));
 	}
+
+	public void test011_toString() {
+		final String x = "0123456789ABCDEFabcdef1234567890abcdefAB";
+		final ObjectId oid = ObjectId.fromString(x);
+		assertEquals(x.toLowerCase(), oid.name());
+	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/AbbreviatedObjectId.java b/org.spearce.jgit/src/org/spearce/jgit/lib/AbbreviatedObjectId.java
index ed03fb5..1706e88 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/AbbreviatedObjectId.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/AbbreviatedObjectId.java
@@ -40,6 +40,7 @@
 import java.io.UnsupportedEncodingException;
 
 import org.spearce.jgit.util.NB;
+import org.spearce.jgit.util.RawParseUtils;
 
 /**
  * A prefix abbreviation of an {@link ObjectId}.
@@ -107,15 +108,12 @@ private static final AbbreviatedObjectId fromHexString(final byte[] bs,
 
 	private static final int hexUInt32(final byte[] bs, int p, final int end) {
 		if (8 <= end - p)
-			return AnyObjectId.hexUInt32(bs, p);
+			return RawParseUtils.parseHexInt32(bs, p);
 
 		int r = 0, n = 0;
 		while (n < 8 && p < end) {
-			final int v = AnyObjectId.fromhex[bs[p++]];
-			if (v < 0)
-				throw new ArrayIndexOutOfBoundsException();
 			r <<= 4;
-			r |= v;
+			r |= RawParseUtils.parseHexInt4(bs[p++]);
 			n++;
 		}
 		return r << (8 - n) * 4;
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/AnyObjectId.java b/org.spearce.jgit/src/org/spearce/jgit/lib/AnyObjectId.java
index acb3cb5..0df2768 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/AnyObjectId.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/AnyObjectId.java
@@ -41,7 +41,6 @@
 import java.io.OutputStream;
 import java.io.Writer;
 import java.nio.ByteBuffer;
-import java.util.Arrays;
 
 import org.spearce.jgit.util.NB;
 
@@ -57,16 +56,7 @@
 
 	static final int STR_LEN = RAW_LEN * 2;
 
-	static final byte fromhex[];
-
 	static {
-		fromhex = new byte['f' + 1];
-		Arrays.fill(fromhex, (byte) -1);
-		for (char i = '0'; i <= '9'; i++)
-			fromhex[i] = (byte) (i - '0');
-		for (char i = 'a'; i <= 'f'; i++)
-			fromhex[i] = (byte) ((i - 'a') + 10);
-
 		if (RAW_LEN != 20)
 			throw new LinkageError("ObjectId expects"
 					+ " Constants.OBJECT_ID_LENGTH = 20; it is " + RAW_LEN
@@ -100,32 +90,6 @@ public static boolean equals(final AnyObjectId firstObjectId,
 				&& firstObjectId.w1 == secondObjectId.w1;
 	}
 
-	static final int hexUInt32(final byte[] bs, final int p) {
-		int r = fromhex[bs[p]] << 4;
-
-		r |= fromhex[bs[p + 1]];
-		r <<= 4;
-
-		r |= fromhex[bs[p + 2]];
-		r <<= 4;
-
-		r |= fromhex[bs[p + 3]];
-		r <<= 4;
-
-		r |= fromhex[bs[p + 4]];
-		r <<= 4;
-
-		r |= fromhex[bs[p + 5]];
-		r <<= 4;
-
-		r |= fromhex[bs[p + 6]];
-
-		final int last = fromhex[bs[p + 7]];
-		if (r < 0 || last < 0)
-			throw new ArrayIndexOutOfBoundsException();
-		return (r << 4) | last;
-	}
-
 	int w1;
 
 	int w2;
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/MutableObjectId.java b/org.spearce.jgit/src/org/spearce/jgit/lib/MutableObjectId.java
index fadebab..805f328 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/MutableObjectId.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/MutableObjectId.java
@@ -40,6 +40,7 @@
 import java.io.UnsupportedEncodingException;
 
 import org.spearce.jgit.util.NB;
+import org.spearce.jgit.util.RawParseUtils;
 
 /**
  * A mutable SHA-1 abstraction.
@@ -159,11 +160,11 @@ public void fromString(final String str) {
 
 	private void fromHexString(final byte[] bs, int p) {
 		try {
-			w1 = hexUInt32(bs, p);
-			w2 = hexUInt32(bs, p + 8);
-			w3 = hexUInt32(bs, p + 16);
-			w4 = hexUInt32(bs, p + 24);
-			w5 = hexUInt32(bs, p + 32);
+			w1 = RawParseUtils.parseHexInt32(bs, p);
+			w2 = RawParseUtils.parseHexInt32(bs, p + 8);
+			w3 = RawParseUtils.parseHexInt32(bs, p + 16);
+			w4 = RawParseUtils.parseHexInt32(bs, p + 24);
+			w5 = RawParseUtils.parseHexInt32(bs, p + 32);
 		} catch (ArrayIndexOutOfBoundsException e1) {
 			try {
 				final String str = new String(bs, p, STR_LEN, "US-ASCII");
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectId.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectId.java
index fde209b..cdd523f 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectId.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectId.java
@@ -41,6 +41,7 @@
 import java.io.UnsupportedEncodingException;
 
 import org.spearce.jgit.util.NB;
+import org.spearce.jgit.util.RawParseUtils;
 
 /**
  * A SHA-1 abstraction.
@@ -74,12 +75,12 @@ public static final ObjectId zeroId() {
 	 * @return true if the string can converted into an ObjectId.
 	 */
 	public static final boolean isId(final String id) {
-		if (id.length() != 2 * Constants.OBJECT_ID_LENGTH)
+		if (id.length() != STR_LEN)
 			return false;
 		try {
-			for (int k = id.length() - 1; k >= 0; k--)
-				if (fromhex[id.charAt(k)] < 0)
-					return false;
+			for (int i = 0; i < STR_LEN; i++) {
+				RawParseUtils.parseHexInt4((byte) id.charAt(i));
+			}
 			return true;
 		} catch (ArrayIndexOutOfBoundsException e) {
 			return false;
@@ -222,11 +223,11 @@ public static final ObjectId fromString(final String str) {
 
 	private static final ObjectId fromHexString(final byte[] bs, int p) {
 		try {
-			final int a = hexUInt32(bs, p);
-			final int b = hexUInt32(bs, p + 8);
-			final int c = hexUInt32(bs, p + 16);
-			final int d = hexUInt32(bs, p + 24);
-			final int e = hexUInt32(bs, p + 32);
+			final int a = RawParseUtils.parseHexInt32(bs, p);
+			final int b = RawParseUtils.parseHexInt32(bs, p + 8);
+			final int c = RawParseUtils.parseHexInt32(bs, p + 16);
+			final int d = RawParseUtils.parseHexInt32(bs, p + 24);
+			final int e = RawParseUtils.parseHexInt32(bs, p + 32);
 			return new ObjectId(a, b, c, d, e);
 		} catch (ArrayIndexOutOfBoundsException e1) {
 			try {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java b/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java
index 79ebe41..0554acb 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java
@@ -54,13 +54,24 @@
 
 /** Handy utility functions to parse raw object contents. */
 public final class RawParseUtils {
-	private static final byte[] digits;
+	private static final byte[] digits10;
+
+	private static final byte[] digits16;
 
 	static {
-		digits = new byte['9' + 1];
-		Arrays.fill(digits, (byte) -1);
+		digits10 = new byte['9' + 1];
+		Arrays.fill(digits10, (byte) -1);
+		for (char i = '0'; i <= '9'; i++)
+			digits10[i] = (byte) (i - '0');
+
+		digits16 = new byte['f' + 1];
+		Arrays.fill(digits16, (byte) -1);
 		for (char i = '0'; i <= '9'; i++)
-			digits[i] = (byte) (i - '0');
+			digits16[i] = (byte) (i - '0');
+		for (char i = 'a'; i <= 'f'; i++)
+			digits16[i] = (byte) ((i - 'a') + 10);
+		for (char i = 'A'; i <= 'F'; i++)
+			digits16[i] = (byte) ((i - 'A') + 10);
 	}
 
 	/**
@@ -175,7 +186,7 @@ public static final int parseBase10(final byte[] b, int ptr,
 			}
 
 			while (ptr < sz) {
-				final byte v = digits[b[ptr]];
+				final byte v = digits10[b[ptr]];
 				if (v < 0)
 					break;
 				r = (r * 10) + v;
@@ -229,7 +240,7 @@ public static final long parseLongBase10(final byte[] b, int ptr,
 			}
 
 			while (ptr < sz) {
-				final byte v = digits[b[ptr]];
+				final byte v = digits10[b[ptr]];
 				if (v < 0)
 					break;
 				r = (r * 10) + v;
@@ -244,6 +255,63 @@ public static final long parseLongBase10(final byte[] b, int ptr,
 	}
 
 	/**
+	 * Parse 8 character base 16 (hex) formatted string to unsigned integer.
+	 * <p>
+	 * The number is read in network byte order, that is, most significant
+	 * nybble first.
+	 *
+	 * @param bs
+	 *            buffer to parse digits from; positions {@code [p, p+8)} will
+	 *            be parsed.
+	 * @param p
+	 *            first position within the buffer to parse.
+	 * @return the integer value.
+	 * @throws ArrayIndexOutOfBoundsException
+	 *             if the string is not hex formatted.
+	 */
+	public static final int parseHexInt32(final byte[] bs, final int p) {
+		int r = digits16[bs[p]] << 4;
+
+		r |= digits16[bs[p + 1]];
+		r <<= 4;
+
+		r |= digits16[bs[p + 2]];
+		r <<= 4;
+
+		r |= digits16[bs[p + 3]];
+		r <<= 4;
+
+		r |= digits16[bs[p + 4]];
+		r <<= 4;
+
+		r |= digits16[bs[p + 5]];
+		r <<= 4;
+
+		r |= digits16[bs[p + 6]];
+
+		final int last = digits16[bs[p + 7]];
+		if (r < 0 || last < 0)
+			throw new ArrayIndexOutOfBoundsException();
+		return (r << 4) | last;
+	}
+
+	/**
+	 * Parse a single hex digit to its numeric value (0-15).
+	 *
+	 * @param digit
+	 *            hex character to parse.
+	 * @return numeric value, in the range 0-15.
+	 * @throws ArrayIndexOutOfBoundsException
+	 *             if the input digit is not a valid hex digit.
+	 */
+	public static final int parseHexInt4(final byte digit) {
+		final byte r = digits16[digit];
+		if (r < 0)
+			throw new ArrayIndexOutOfBoundsException();
+		return r;
+	}
+
+	/**
 	 * Parse a Git style timezone string.
 	 * <p>
 	 * The sequence "-0315" will be parsed as the numeric value -195, as the
-- 
1.6.3.1.333.g3ebba7

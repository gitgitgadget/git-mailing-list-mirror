From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [EGIT PATCH 03/26] Add Constants.encode as a utility for quick encoding in UTF-8
Date: Mon, 11 Aug 2008 18:07:50 -0700
Message-ID: <1218503293-14057-4-git-send-email-spearce@spearce.org>
References: <1218503293-14057-1-git-send-email-spearce@spearce.org>
 <1218503293-14057-2-git-send-email-spearce@spearce.org>
 <1218503293-14057-3-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Aug 12 03:09:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSiO3-0005x2-Fl
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 03:09:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbYHLBIW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 21:08:22 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751040AbYHLBIV
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 21:08:21 -0400
Received: from george.spearce.org ([209.20.77.23]:38566 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750977AbYHLBIQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 21:08:16 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 783D938389; Tue, 12 Aug 2008 01:08:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 50A56381FD;
	Tue, 12 Aug 2008 01:08:14 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.rc2.22.g71b99
In-Reply-To: <1218503293-14057-3-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92034>

We often need to convert a string into a UTF-8 encoding, so that
we can use this string as a path filter in a TreeWalk or in some
other suitable place where we assume a standard UTF-8 encoding is
being used.  As we have already done the lookup for the CHARSET
we can reuse that same CHARSET reference during future encoding
calls, while allowing the CharSet implementation to cache and
reuse the actual encoder instance.

Whenever possible we try to avoid copying the result as most of
the time the returned ByteBuffer's internal array matches the
result array we need to return to our caller.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../spearce/jgit/lib/ConstantsEncodingTest.java    |   89 ++++++++++++=
++++++++
 .../src/org/spearce/jgit/lib/Constants.java        |   25 ++++++
 2 files changed, 114 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/lib/Cons=
tantsEncodingTest.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ConstantsEn=
codingTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/Consta=
ntsEncodingTest.java
new file mode 100644
index 0000000..7b3e5a0
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ConstantsEncodingT=
est.java
@@ -0,0 +1,89 @@
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
+import java.util.Arrays;
+
+import junit.framework.TestCase;
+
+public class ConstantsEncodingTest extends TestCase {
+	public void testEncodeASCII_SimpleASCII()
+			throws UnsupportedEncodingException {
+		final String src =3D "abc";
+		final byte[] exp =3D { 'a', 'b', 'c' };
+		final byte[] res =3D Constants.encodeASCII(src);
+		assertTrue(Arrays.equals(exp, res));
+		assertEquals(src, new String(res, 0, res.length, "UTF-8"));
+	}
+
+	public void testEncodeASCII_FailOnNonASCII() {
+		final String src =3D "=C5=AAn=C4=ADc=C5=8Dde=CC=BD";
+		try {
+			Constants.encodeASCII(src);
+			fail("Incorrectly accepted a Unicode character");
+		} catch (IllegalArgumentException err) {
+			assertEquals("Not ASCII string: " + src, err.getMessage());
+		}
+	}
+
+	public void testEncodeASCII_Number13() {
+		final long src =3D 13;
+		final byte[] exp =3D { '1', '3' };
+		final byte[] res =3D Constants.encodeASCII(src);
+		assertTrue(Arrays.equals(exp, res));
+	}
+
+	public void testEncode_SimpleASCII() throws UnsupportedEncodingExcept=
ion {
+		final String src =3D "abc";
+		final byte[] exp =3D { 'a', 'b', 'c' };
+		final byte[] res =3D Constants.encode(src);
+		assertTrue(Arrays.equals(exp, res));
+		assertEquals(src, new String(res, 0, res.length, "UTF-8"));
+	}
+
+	public void testEncode_Unicode() throws UnsupportedEncodingException =
{
+		final String src =3D "=C5=AAn=C4=ADc=C5=8Dde=CC=BD";
+		final byte[] exp =3D { (byte) 0xC5, (byte) 0xAA, 0x6E, (byte) 0xC4,
+				(byte) 0xAD, 0x63, (byte) 0xC5, (byte) 0x8D, 0x64, 0x65,
+				(byte) 0xCC, (byte) 0xBD };
+		final byte[] res =3D Constants.encode(src);
+		assertTrue(Arrays.equals(exp, res));
+		assertEquals(src, new String(res, 0, res.length, "UTF-8"));
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java b=
/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java
index 7c2cef9..23ac3ac 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java
@@ -1,6 +1,7 @@
 /*
  * Copyright (C) 2008, Robin Rosenberg <robin.rosenberg@dewire.com>
  * Copyright (C) 2008, Shawn O. Pearce <spearce@spearce.org>
+ * Copyright (C) 2008, Google Inc.
  *
  * All rights reserved.
  *
@@ -38,6 +39,7 @@
=20
 package org.spearce.jgit.lib;
=20
+import java.nio.ByteBuffer;
 import java.nio.charset.Charset;
 import java.security.MessageDigest;
 import java.security.NoSuchAlgorithmException;
@@ -387,6 +389,29 @@ public final class Constants {
 		return r;
 	}
=20
+	/**
+	 * Convert a string to a byte array in the standard character encodin=
g.
+	 *=20
+	 * @param str
+	 *            the string to convert. May contain any Unicode characte=
rs.
+	 * @return a byte array representing the requested string, encoded us=
ing the
+	 *         default character encoding (UTF-8).
+	 * @see #CHARACTER_ENCODING
+	 */
+	public static byte[] encode(final String str) {
+		final ByteBuffer bb =3D Constants.CHARSET.encode(str);
+		final int len =3D bb.limit();
+		if (bb.hasArray() && bb.arrayOffset() =3D=3D 0) {
+			final byte[] arr =3D bb.array();
+			if (arr.length =3D=3D len)
+				return arr;
+		}
+
+		final byte[] arr =3D new byte[len];
+		bb.get(arr);
+		return arr;
+	}
+
 	static {
 		if (OBJECT_ID_LENGTH !=3D newMessageDigest().getDigestLength())
 			throw new LinkageError("Incorrect OBJECT_ID_LENGTH.");
--=20
1.6.0.rc2.22.g71b99

From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 4/6] Add QuotedString class to handle C-style quoting rules
Date: Wed, 10 Dec 2008 14:05:49 -0800
Message-ID: <1228946751-12708-5-git-send-email-spearce@spearce.org>
References: <1228946751-12708-1-git-send-email-spearce@spearce.org>
 <1228946751-12708-2-git-send-email-spearce@spearce.org>
 <1228946751-12708-3-git-send-email-spearce@spearce.org>
 <1228946751-12708-4-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Dec 10 23:07:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAXDN-00031R-6s
	for gcvg-git-2@gmane.org; Wed, 10 Dec 2008 23:07:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755618AbYLJWGE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 17:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755588AbYLJWGD
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 17:06:03 -0500
Received: from george.spearce.org ([209.20.77.23]:39018 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755302AbYLJWF4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 17:05:56 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id CB39138221; Wed, 10 Dec 2008 22:05:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id CD8ED3821F;
	Wed, 10 Dec 2008 22:05:52 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc2.299.gead4c
In-Reply-To: <1228946751-12708-4-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102727>

Git patch files can contain file names which are quoted using the
C language quoting rules.  In order to correctly create or parse
these files we must implement a quoting style that matches those
specific rules.

QuotedString itself is an abstract API so callers can be passed a
quoting style based on the context of where their output will be
used, and multiple styles could be supported.  This may be useful
if jgit ever grows a "git for-each-ref" style of output where Perl,
Python, Tcl and Bourne style quoting might be necessary.

References through the singleton QuotedString.C should be able to
bypass the virtual function table, as the specific type is mentioned
in the field declaration and that type is final.  A good JIT should
be able to remove the abstraction costs when the caller has hardcoded
the quoting style.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../spearce/jgit/util/QuotedStringC_StyleTest.java |  144 +++++++++++
 .../src/org/spearce/jgit/util/QuotedString.java    |  270 ++++++++++++++++++++
 2 files changed, 414 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/util/QuotedStringC_StyleTest.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/util/QuotedString.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/util/QuotedStringC_StyleTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/util/QuotedStringC_StyleTest.java
new file mode 100644
index 0000000..493869c
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/util/QuotedStringC_StyleTest.java
@@ -0,0 +1,144 @@
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
+import static org.spearce.jgit.util.QuotedString.C;
+import junit.framework.TestCase;
+
+import org.spearce.jgit.lib.Constants;
+
+public class QuotedStringC_StyleTest extends TestCase {
+	private static void assertQuote(final String in, final String exp) {
+		final String r = C.quote(in);
+		assertNotSame(in, r);
+		assertFalse(in.equals(r));
+		assertEquals('"' + exp + '"', r);
+	}
+
+	private static void assertDequote(final String exp, final String in) {
+		final byte[] b = Constants.encode('"' + in + '"');
+		final String r = C.dequote(b, 0, b.length);
+		assertEquals(exp, r);
+	}
+
+	public void testQuote_Empty() {
+		assertEquals("\"\"", C.quote(""));
+	}
+
+	public void testDequote_Empty1() {
+		assertEquals("", C.dequote(new byte[0], 0, 0));
+	}
+
+	public void testDequote_Empty2() {
+		assertEquals("", C.dequote(new byte[] { '"', '"' }, 0, 2));
+	}
+
+	public void testDequote_SoleDq() {
+		assertEquals("\"", C.dequote(new byte[] { '"' }, 0, 1));
+	}
+
+	public void testQuote_BareA() {
+		final String in = "a";
+		assertSame(in, C.quote(in));
+	}
+
+	public void testDequote_BareA() {
+		final String in = "a";
+		final byte[] b = Constants.encode(in);
+		assertEquals(in, C.dequote(b, 0, b.length));
+	}
+
+	public void testDequote_BareABCZ_OnlyBC() {
+		final String in = "abcz";
+		final byte[] b = Constants.encode(in);
+		final int p = in.indexOf('b');
+		assertEquals("bc", C.dequote(b, p, p + 2));
+	}
+
+	public void testDequote_LoneBackslash() {
+		assertDequote("\\", "\\");
+	}
+
+	public void testQuote_NamedEscapes() {
+		assertQuote("\u0007", "\\a");
+		assertQuote("\b", "\\b");
+		assertQuote("\f", "\\f");
+		assertQuote("\n", "\\n");
+		assertQuote("\r", "\\r");
+		assertQuote("\t", "\\t");
+		assertQuote("\u000B", "\\v");
+		assertQuote("\\", "\\\\");
+		assertQuote("\"", "\\\"");
+	}
+
+	public void testDequote_NamedEscapes() {
+		assertDequote("\u0007", "\\a");
+		assertDequote("\b", "\\b");
+		assertDequote("\f", "\\f");
+		assertDequote("\n", "\\n");
+		assertDequote("\r", "\\r");
+		assertDequote("\t", "\\t");
+		assertDequote("\u000B", "\\v");
+		assertDequote("\\", "\\\\");
+		assertDequote("\"", "\\\"");
+	}
+
+	public void testDequote_OctalAll() {
+		for (int i = 0; i < 256; i++) {
+			String s = Integer.toOctalString(i);
+			while (s.length() < 3) {
+				s = "0" + s;
+			}
+			assertDequote("" + (char) i, "\\" + s);
+		}
+	}
+
+	public void testQuote_OctalAll() {
+		assertQuote("\1", "\\001");
+		assertQuote("~", "\\176");
+		assertQuote("\u00ff", "\\303\\277"); // \u00ff in UTF-8
+	}
+
+	public void testDequote_UnknownEscapeQ() {
+		assertDequote("\\q", "\\q");
+	}
+
+	public void testDequote_FooTabBar() {
+		assertDequote("foo\tbar", "foo\\tbar");
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/util/QuotedString.java b/org.spearce.jgit/src/org/spearce/jgit/util/QuotedString.java
new file mode 100644
index 0000000..4aaa8ff
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/util/QuotedString.java
@@ -0,0 +1,270 @@
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
+import static org.spearce.jgit.util.RawParseUtils.decode;
+
+import java.util.Arrays;
+
+import org.spearce.jgit.lib.Constants;
+
+/** Utility functions related to quoted string handling. */
+public abstract class QuotedString {
+	/** Quoting style that obeys the rules of the C programming language. */
+	public static final C_Style C = new C_Style();
+
+	/**
+	 * Quote an input string by the quoting rules.
+	 * <p>
+	 * If the input string does not require any quoting, the same String
+	 * reference is returned to the caller.
+	 * <p>
+	 * Otherwise a quoted string is returned, including the opening and closing
+	 * quotation marks at the start and end of the string. If the style does not
+	 * permit raw Unicode characters then the string will first be encoded in
+	 * UTF-8, with unprintable sequences possibly escaped by the rules.
+	 * 
+	 * @param in
+	 *            any non-null Unicode string.
+	 * @return a quoted string. See above for details.
+	 */
+	public abstract String quote(String in);
+
+	/**
+	 * Clean a previously quoted input, decoding the result via UTF-8.
+	 * <p>
+	 * This method must match quote such that:
+	 * 
+	 * <pre>
+	 * a.equals(dequote(quote(a)));
+	 * </pre>
+	 * 
+	 * is true for any <code>a</code>.
+	 * 
+	 * @param in
+	 *            a Unicode string to remove quoting from.
+	 * @return the cleaned string.
+	 * @see #dequote(byte[], int, int)
+	 */
+	public String dequote(final String in) {
+		final byte[] b = Constants.encode(in);
+		return dequote(b, 0, b.length);
+	}
+
+	/**
+	 * Decode a previously quoted input, scanning a UTF-8 encoded buffer.
+	 * <p>
+	 * This method must match quote such that:
+	 * 
+	 * <pre>
+	 * a.equals(dequote(Constants.encode(quote(a))));
+	 * </pre>
+	 * 
+	 * is true for any <code>a</code>.
+	 * <p>
+	 * This method removes any opening/closing quotation marks added by
+	 * {@link #quote(String)}.
+	 * 
+	 * @param in
+	 *            the input buffer to parse.
+	 * @param offset
+	 *            first position within <code>in</code> to scan.
+	 * @param end
+	 *            one position past in <code>in</code> to scan.
+	 * @return the cleaned string.
+	 */
+	public abstract String dequote(byte[] in, int offset, int end);
+
+	/** Quoting style that obeys the rules of the C programming language. */
+	public static final class C_Style extends QuotedString {
+		private static final byte[] quote;
+		static {
+			quote = new byte[128];
+			Arrays.fill(quote, (byte) -1);
+
+			for (int i = '0'; i <= '9'; i++)
+				quote[i] = 0;
+			for (int i = 'a'; i <= 'z'; i++)
+				quote[i] = 0;
+			for (int i = 'A'; i <= 'Z'; i++)
+				quote[i] = 0;
+			quote[' '] = 0;
+			quote['+'] = 0;
+			quote[','] = 0;
+			quote['-'] = 0;
+			quote['.'] = 0;
+			quote['/'] = 0;
+			quote['='] = 0;
+			quote['_'] = 0;
+			quote['^'] = 0;
+
+			quote['\u0007'] = 'a';
+			quote['\b'] = 'b';
+			quote['\f'] = 'f';
+			quote['\n'] = 'n';
+			quote['\r'] = 'r';
+			quote['\t'] = 't';
+			quote['\u000B'] = 'v';
+			quote['\\'] = '\\';
+			quote['"'] = '"';
+		}
+
+		@Override
+		public String quote(final String instr) {
+			if (instr.length() == 0)
+				return "\"\"";
+			boolean reuse = true;
+			final byte[] in = Constants.encode(instr);
+			final StringBuilder r = new StringBuilder(2 + in.length);
+			r.append('"');
+			for (int i = 0; i < in.length; i++) {
+				final int c = in[i] & 0xff;
+				if (c < quote.length) {
+					final byte style = quote[c];
+					if (style == 0) {
+						r.append((char) c);
+						continue;
+					}
+					if (style > 0) {
+						reuse = false;
+						r.append('\\');
+						r.append((char) style);
+						continue;
+					}
+				}
+
+				reuse = false;
+				r.append('\\');
+				r.append((char) (((c >> 6) & 03) + '0'));
+				r.append((char) (((c >> 3) & 07) + '0'));
+				r.append((char) (((c >> 0) & 07) + '0'));
+			}
+			if (reuse)
+				return instr;
+			r.append('"');
+			return r.toString();
+		}
+
+		@Override
+		public String dequote(final byte[] in, final int inPtr, final int inEnd) {
+			if (2 <= inEnd - inPtr && in[inPtr] == '"' && in[inEnd - 1] == '"')
+				return dq(in, inPtr + 1, inEnd - 1);
+			return decode(Constants.CHARSET, in, inPtr, inEnd);
+		}
+
+		private static String dq(final byte[] in, int inPtr, final int inEnd) {
+			final byte[] r = new byte[inEnd - inPtr];
+			int rPtr = 0;
+			while (inPtr < inEnd) {
+				final byte b = in[inPtr++];
+				if (b != '\\') {
+					r[rPtr++] = b;
+					continue;
+				}
+
+				if (inPtr == inEnd) {
+					// Lone trailing backslash. Treat it as a literal.
+					//
+					r[rPtr++] = '\\';
+					break;
+				}
+
+				switch (in[inPtr++]) {
+				case 'a':
+					r[rPtr++] = 0x07 /* \a = BEL */;
+					continue;
+				case 'b':
+					r[rPtr++] = '\b';
+					continue;
+				case 'f':
+					r[rPtr++] = '\f';
+					continue;
+				case 'n':
+					r[rPtr++] = '\n';
+					continue;
+				case 'r':
+					r[rPtr++] = '\r';
+					continue;
+				case 't':
+					r[rPtr++] = '\t';
+					continue;
+				case 'v':
+					r[rPtr++] = 0x0B/* \v = VT */;
+					continue;
+
+				case '\\':
+				case '"':
+					r[rPtr++] = in[inPtr - 1];
+					continue;
+
+				case '0':
+				case '1':
+				case '2':
+				case '3': {
+					int cp = in[inPtr - 1] - '0';
+					while (inPtr < inEnd) {
+						final byte c = in[inPtr];
+						if ('0' <= c && c <= '7') {
+							cp <<= 3;
+							cp |= c - '0';
+							inPtr++;
+						} else {
+							break;
+						}
+					}
+					r[rPtr++] = (byte) cp;
+					continue;
+				}
+
+				default:
+					// Any other code is taken literally.
+					//
+					r[rPtr++] = '\\';
+					r[rPtr++] = in[inPtr - 1];
+					continue;
+				}
+			}
+
+			return decode(Constants.CHARSET, r, 0, rPtr);
+		}
+
+		private C_Style() {
+			// Singleton
+		}
+	}
+}
-- 
1.6.1.rc2.299.gead4c

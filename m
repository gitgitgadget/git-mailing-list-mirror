From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 5/6 v2] Add Bourne style quoting for TransportGitSsh
Date: Wed, 10 Dec 2008 15:59:53 -0800
Message-ID: <1228953594-12749-2-git-send-email-spearce@spearce.org>
References: <1228953594-12749-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Dec 11 01:01:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAYzd-0002Zv-5c
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 01:01:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752443AbYLKAAE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 19:00:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752737AbYLJX76
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 18:59:58 -0500
Received: from george.spearce.org ([209.20.77.23]:40004 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752343AbYLJX75 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 18:59:57 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 61C3138200; Wed, 10 Dec 2008 23:59:56 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id E57F838200;
	Wed, 10 Dec 2008 23:59:54 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc2.299.gead4c
In-Reply-To: <1228953594-12749-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102745>

Now that we have a nice QuotedString abstraction we can port our
string quoting logic from being private within the SSH transport
code to being available in the rest of the library.

Currently we only support the super-restrictive quoting style used
for the repository path name argument over SSH.  We don't support the
"minimal" style used to invoke the command name, nor do we support
the ~user/ style format, which cannot be quoted.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../jgit/util/QuotedStringBourneStyleTest.java     |  111 ++++++++++++++++++++
 .../spearce/jgit/transport/TransportGitSsh.java    |   13 +--
 .../src/org/spearce/jgit/util/QuotedString.java    |   66 ++++++++++++
 3 files changed, 179 insertions(+), 11 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/util/QuotedStringBourneStyleTest.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/util/QuotedStringBourneStyleTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/util/QuotedStringBourneStyleTest.java
new file mode 100644
index 0000000..86d46fe
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/util/QuotedStringBourneStyleTest.java
@@ -0,0 +1,111 @@
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
+import static org.spearce.jgit.util.QuotedString.BOURNE;
+import junit.framework.TestCase;
+
+import org.spearce.jgit.lib.Constants;
+
+public class QuotedStringBourneStyleTest extends TestCase {
+	private static void assertQuote(final String in, final String exp) {
+		final String r = BOURNE.quote(in);
+		assertNotSame(in, r);
+		assertFalse(in.equals(r));
+		assertEquals('\'' + exp + '\'', r);
+	}
+
+	private static void assertDequote(final String exp, final String in) {
+		final byte[] b = Constants.encode('\'' + in + '\'');
+		final String r = BOURNE.dequote(b, 0, b.length);
+		assertEquals(exp, r);
+	}
+
+	public void testQuote_Empty() {
+		assertEquals("''", BOURNE.quote(""));
+	}
+
+	public void testDequote_Empty1() {
+		assertEquals("", BOURNE.dequote(new byte[0], 0, 0));
+	}
+
+	public void testDequote_Empty2() {
+		assertEquals("", BOURNE.dequote(new byte[] { '\'', '\'' }, 0, 2));
+	}
+
+	public void testDequote_SoleSq() {
+		assertEquals("", BOURNE.dequote(new byte[] { '\'' }, 0, 1));
+	}
+
+	public void testQuote_BareA() {
+		assertQuote("a", "a");
+	}
+
+	public void testDequote_BareA() {
+		final String in = "a";
+		final byte[] b = Constants.encode(in);
+		assertEquals(in, BOURNE.dequote(b, 0, b.length));
+	}
+
+	public void testDequote_BareABCZ_OnlyBC() {
+		final String in = "abcz";
+		final byte[] b = Constants.encode(in);
+		final int p = in.indexOf('b');
+		assertEquals("bc", BOURNE.dequote(b, p, p + 2));
+	}
+
+	public void testDequote_LoneBackslash() {
+		assertDequote("\\", "\\");
+	}
+
+	public void testQuote_NamedEscapes() {
+		assertQuote("'", "'\\''");
+		assertQuote("!", "'\\!'");
+
+		assertQuote("a'b", "a'\\''b");
+		assertQuote("a!b", "a'\\!'b");
+	}
+
+	public void testDequote_NamedEscapes() {
+		assertDequote("'", "'\\''");
+		assertDequote("!", "'\\!'");
+
+		assertDequote("a'b", "a'\\''b");
+		assertDequote("a!b", "a'\\!'b");
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitSsh.java b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitSsh.java
index 3f2cd37..e3f5ae8 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitSsh.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitSsh.java
@@ -47,6 +47,7 @@
 import org.spearce.jgit.errors.NoRemoteRepositoryException;
 import org.spearce.jgit.errors.TransportException;
 import org.spearce.jgit.lib.Repository;
+import org.spearce.jgit.util.QuotedString;
 
 import com.jcraft.jsch.ChannelExec;
 import com.jcraft.jsch.JSchException;
@@ -154,17 +155,7 @@ private static void sq(final StringBuilder cmd, final String val) {
 				return;
 		}
 
-		cmd.append('\'');
-		for (; i < val.length(); i++) {
-			final char c = val.charAt(i);
-			if (c == '\'')
-				cmd.append("'\\''");
-			else if (c == '!')
-				cmd.append("'\\!'");
-			else
-				cmd.append(c);
-		}
-		cmd.append('\'');
+		cmd.append(QuotedString.BOURNE.quote(val.substring(i)));
 	}
 
 	private void initSession() throws TransportException {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/util/QuotedString.java b/org.spearce.jgit/src/org/spearce/jgit/util/QuotedString.java
index 279b713..82ce716 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/util/QuotedString.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/util/QuotedString.java
@@ -47,6 +47,15 @@
 	public static final GitPathStyle GIT_PATH = new GitPathStyle();
 
 	/**
+	 * Quoting style used by the Bourne shell.
+	 * <p>
+	 * Quotes are unconditionally inserted during {@link #quote(String)}. This
+	 * protects shell meta-characters like <code>$</code> or <code>~</code> from
+	 * being recognized as special.
+	 */
+	public static final BourneStyle BOURNE = new BourneStyle();
+
+	/**
 	 * Quote an input string by the quoting rules.
 	 * <p>
 	 * If the input string does not require any quoting, the same String
@@ -108,6 +117,63 @@ public String dequote(final String in) {
 	 */
 	public abstract String dequote(byte[] in, int offset, int end);
 
+	/**
+	 * Quoting style used by the Bourne shell.
+	 * <p>
+	 * Quotes are unconditionally inserted during {@link #quote(String)}. This
+	 * protects shell meta-characters like <code>$</code> or <code>~</code> from
+	 * being recognized as special.
+	 */
+	public static class BourneStyle extends QuotedString {
+		@Override
+		public String quote(final String in) {
+			final StringBuilder r = new StringBuilder();
+			r.append('\'');
+			int start = 0, i = 0;
+			for (; i < in.length(); i++) {
+				switch (in.charAt(i)) {
+				case '\'':
+				case '!':
+					r.append(in, start, i);
+					r.append('\'');
+					r.append('\\');
+					r.append(in.charAt(i));
+					r.append('\'');
+					start = i + 1;
+					break;
+				}
+			}
+			r.append(in, start, i);
+			r.append('\'');
+			return r.toString();
+		}
+
+		@Override
+		public String dequote(final byte[] in, int ip, final int ie) {
+			boolean inquote = false;
+			final byte[] r = new byte[ie - ip];
+			int rPtr = 0;
+			while (ip < ie) {
+				final byte b = in[ip++];
+				switch (b) {
+				case '\'':
+					inquote = !inquote;
+					continue;
+				case '\\':
+					if (inquote || ip == ie)
+						r[rPtr++] = b; // literal within a quote
+					else
+						r[rPtr++] = in[ip++];
+					continue;
+				default:
+					r[rPtr++] = b;
+					continue;
+				}
+			}
+			return RawParseUtils.decode(Constants.CHARSET, r, 0, rPtr);
+		}
+	}
+
 	/** Quoting style that obeys the rules Git applies to file names */
 	public static final class GitPathStyle extends QuotedString {
 		private static final byte[] quote;
-- 
1.6.1.rc2.299.gead4c

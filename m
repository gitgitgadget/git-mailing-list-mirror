From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 6/6 v2] Add ~user friendly Bourne style quoting for TransportGitSsh
Date: Wed, 10 Dec 2008 15:59:54 -0800
Message-ID: <1228953594-12749-3-git-send-email-spearce@spearce.org>
References: <1228953594-12749-1-git-send-email-spearce@spearce.org>
 <1228953594-12749-2-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Dec 11 01:01:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAYzt-0002gM-MA
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 01:01:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752882AbYLKAAL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 19:00:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752343AbYLKAAE
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 19:00:04 -0500
Received: from george.spearce.org ([209.20.77.23]:40006 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752386AbYLJX75 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 18:59:57 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 0A97838211; Wed, 10 Dec 2008 23:59:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 3317C38210;
	Wed, 10 Dec 2008 23:59:55 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc2.299.gead4c
In-Reply-To: <1228953594-12749-2-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102746>

This mostly completes the migration of our quoting rules from the
SSH transport to our QuotedString pattern.  User names may be left
alone for the shell to expand when the string is evaluated, if the
caller wants that sort of behavior in a particular context.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../util/QuotedStringBourneUserPathStyleTest.java  |  130 ++++++++++++++++++++
 .../spearce/jgit/transport/TransportGitSsh.java    |   27 +----
 .../src/org/spearce/jgit/util/QuotedString.java    |   28 ++++
 3 files changed, 160 insertions(+), 25 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/util/QuotedStringBourneUserPathStyleTest.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/util/QuotedStringBourneUserPathStyleTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/util/QuotedStringBourneUserPathStyleTest.java
new file mode 100644
index 0000000..36fb52a
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/util/QuotedStringBourneUserPathStyleTest.java
@@ -0,0 +1,130 @@
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
+import static org.spearce.jgit.util.QuotedString.BOURNE_USER_PATH;
+import junit.framework.TestCase;
+
+import org.spearce.jgit.lib.Constants;
+
+public class QuotedStringBourneUserPathStyleTest extends TestCase {
+	private static void assertQuote(final String in, final String exp) {
+		final String r = BOURNE_USER_PATH.quote(in);
+		assertNotSame(in, r);
+		assertFalse(in.equals(r));
+		assertEquals('\'' + exp + '\'', r);
+	}
+
+	private static void assertDequote(final String exp, final String in) {
+		final byte[] b = Constants.encode('\'' + in + '\'');
+		final String r = BOURNE_USER_PATH.dequote(b, 0, b.length);
+		assertEquals(exp, r);
+	}
+
+	public void testQuote_Empty() {
+		assertEquals("''", BOURNE_USER_PATH.quote(""));
+	}
+
+	public void testDequote_Empty1() {
+		assertEquals("", BOURNE_USER_PATH.dequote(new byte[0], 0, 0));
+	}
+
+	public void testDequote_Empty2() {
+		assertEquals("", BOURNE_USER_PATH.dequote(new byte[] { '\'', '\'' }, 0,
+				2));
+	}
+
+	public void testDequote_SoleSq() {
+		assertEquals("", BOURNE_USER_PATH.dequote(new byte[] { '\'' }, 0, 1));
+	}
+
+	public void testQuote_BareA() {
+		assertQuote("a", "a");
+	}
+
+	public void testDequote_BareA() {
+		final String in = "a";
+		final byte[] b = Constants.encode(in);
+		assertEquals(in, BOURNE_USER_PATH.dequote(b, 0, b.length));
+	}
+
+	public void testDequote_BareABCZ_OnlyBC() {
+		final String in = "abcz";
+		final byte[] b = Constants.encode(in);
+		final int p = in.indexOf('b');
+		assertEquals("bc", BOURNE_USER_PATH.dequote(b, p, p + 2));
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
+
+	public void testQuote_User() {
+		assertEquals("~foo/", BOURNE_USER_PATH.quote("~foo"));
+		assertEquals("~foo/", BOURNE_USER_PATH.quote("~foo/"));
+		assertEquals("~/", BOURNE_USER_PATH.quote("~/"));
+
+		assertEquals("~foo/'a'", BOURNE_USER_PATH.quote("~foo/a"));
+		assertEquals("~/'a'", BOURNE_USER_PATH.quote("~/a"));
+	}
+
+	public void testDequote_User() {
+		assertEquals("~foo", BOURNE_USER_PATH.dequote("~foo"));
+		assertEquals("~foo/", BOURNE_USER_PATH.dequote("~foo/"));
+		assertEquals("~/", BOURNE_USER_PATH.dequote("~/"));
+
+		assertEquals("~foo/a", BOURNE_USER_PATH.dequote("~foo/'a'"));
+		assertEquals("~/a", BOURNE_USER_PATH.dequote("~/'a'"));
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitSsh.java b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitSsh.java
index e3f5ae8..d4bf466 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitSsh.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitSsh.java
@@ -131,31 +131,8 @@ private static void sqAlways(final StringBuilder cmd, final String val) {
 	}
 
 	private static void sq(final StringBuilder cmd, final String val) {
-		int i = 0;
-
-		if (val.length() == 0)
-			return;
-		if (val.matches("^~[A-Za-z0-9_-]+$")) {
-			// If the string is just "~user" we can assume they
-			// mean "~user/" and evaluate it within the shell.
-			//
-			cmd.append(val);
-			cmd.append('/');
-			return;
-		}
-
-		if (val.matches("^~[A-Za-z0-9_-]*/.*$")) {
-			// If the string is of "~/path" or "~user/path"
-			// we must not escape ~/ or ~user/ from the shell
-			// as we need that portion to be evaluated.
-			//
-			i = val.indexOf('/') + 1;
-			cmd.append(val.substring(0, i));
-			if (i == val.length())
-				return;
-		}
-
-		cmd.append(QuotedString.BOURNE.quote(val.substring(i)));
+		if (val.length() > 0)
+			cmd.append(QuotedString.BOURNE.quote(val));
 	}
 
 	private void initSession() throws TransportException {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/util/QuotedString.java b/org.spearce.jgit/src/org/spearce/jgit/util/QuotedString.java
index 82ce716..60c4195 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/util/QuotedString.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/util/QuotedString.java
@@ -55,6 +55,9 @@
 	 */
 	public static final BourneStyle BOURNE = new BourneStyle();
 
+	/** Bourne style, but permits <code>~user</code> at the start of the string. */
+	public static final BourneUserPathStyle BOURNE_USER_PATH = new BourneUserPathStyle();
+
 	/**
 	 * Quote an input string by the quoting rules.
 	 * <p>
@@ -174,6 +177,31 @@ public String dequote(final byte[] in, int ip, final int ie) {
 		}
 	}
 
+	/** Bourne style, but permits <code>~user</code> at the start of the string. */
+	public static class BourneUserPathStyle extends BourneStyle {
+		@Override
+		public String quote(final String in) {
+			if (in.matches("^~[A-Za-z0-9_-]+$")) {
+				// If the string is just "~user" we can assume they
+				// mean "~user/".
+				//
+				return in + "/";
+			}
+
+			if (in.matches("^~[A-Za-z0-9_-]*/.*$")) {
+				// If the string is of "~/path" or "~user/path"
+				// we must not escape ~/ or ~user/ from the shell.
+				//
+				final int i = in.indexOf('/') + 1;
+				if (i == in.length())
+					return in;
+				return in.substring(0, i) + super.quote(in.substring(i));
+			}
+
+			return super.quote(in);
+		}
+	}
+
 	/** Quoting style that obeys the rules Git applies to file names */
 	public static final class GitPathStyle extends QuotedString {
 		private static final byte[] quote;
-- 
1.6.1.rc2.299.gead4c

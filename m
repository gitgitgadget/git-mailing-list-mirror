From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 2/2] Make Repository.isValidRefName compatible with Git 1.6.3
Date: Thu,  7 May 2009 08:05:14 -0700
Message-ID: <1241708714-20326-2-git-send-email-spearce@spearce.org>
References: <1241708714-20326-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu May 07 17:08:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M25Ae-0001U1-9e
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 17:06:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758975AbZEGPFU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 11:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758779AbZEGPFT
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 11:05:19 -0400
Received: from george.spearce.org ([209.20.77.23]:41352 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758051AbZEGPFQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 11:05:16 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 9A10B381D2; Thu,  7 May 2009 15:05:16 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 2DDA4381D1;
	Thu,  7 May 2009 15:05:15 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.195.gad81
In-Reply-To: <1241708714-20326-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118485>

In 3e262b95c509 I taught C Git to disallow refs whose names end in
".lock".  This suffix is used by the atomic update mechanism as a
signal that the ref is being modified.  When reading a loose ref
directory both JGit and C Git skip over any files whose names end
with this suffix, as the file is assumed to be one of these magic
locking files from another concurrent process.  Consequently, any
ref that ends with this name will become invisible once created.

We also add a suite of tests for the isValidRefName function, fix
its formatting to better conform to current style conventions, and
correct the result for "master"; this is not a valid ref name as it
has only 1 path component.  At least 2 path components is required.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../tst/org/spearce/jgit/lib/ValidRefNameTest.java |  168 ++++++++++++++++++++
 .../src/org/spearce/jgit/lib/Repository.java       |   28 ++--
 2 files changed, 181 insertions(+), 15 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/lib/ValidRefNameTest.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ValidRefNameTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ValidRefNameTest.java
new file mode 100644
index 0000000..5cca682
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ValidRefNameTest.java
@@ -0,0 +1,168 @@
+/*
+ * Copyright (C) 2009, Google Inc.
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
+public class ValidRefNameTest extends TestCase {
+	private static void assertValid(final boolean exp, final String name) {
+		assertEquals("\"" + name + "\"", exp, Repository.isValidRefName(name));
+	}
+
+	public void testEmptyString() {
+		assertValid(false, "");
+		assertValid(false, "/");
+	}
+
+	public void testMustHaveTwoComponents() {
+		assertValid(false, "master");
+		assertValid(true, "heads/master");
+	}
+
+	public void testValidHead() {
+		assertValid(true, "refs/heads/master");
+		assertValid(true, "refs/heads/pu");
+		assertValid(true, "refs/heads/z");
+		assertValid(true, "refs/heads/FoO");
+	}
+
+	public void testValidTag() {
+		assertValid(true, "refs/tags/v1.0");
+	}
+
+	public void testNoLockSuffix() {
+		assertValid(false, "refs/heads/master.lock");
+	}
+
+	public void testNoDirectorySuffix() {
+		assertValid(false, "refs/heads/master/");
+	}
+
+	public void testNoSpace() {
+		assertValid(false, "refs/heads/i haz space");
+	}
+
+	public void testNoAsciiControlCharacters() {
+		for (char c = '\0'; c < ' '; c++)
+			assertValid(false, "refs/heads/mast" + c + "er");
+	}
+
+	public void testNoBareDot() {
+		assertValid(false, "refs/heads/.");
+		assertValid(false, "refs/heads/..");
+		assertValid(false, "refs/heads/./master");
+		assertValid(false, "refs/heads/../master");
+	}
+
+	public void testNoLeadingDot() {
+		assertValid(false, ".");
+		assertValid(false, "refs/heads/.bar");
+		assertValid(false, "refs/heads/..bar");
+	}
+
+	public void testContainsDot() {
+		assertValid(true, "refs/heads/m.a.s.t.e.r");
+		assertValid(false, "refs/heads/master..pu");
+	}
+
+	public void testNoMagicRefCharacters() {
+		assertValid(false, "refs/heads/master^");
+		assertValid(false, "refs/heads/^master");
+		assertValid(false, "^refs/heads/master");
+
+		assertValid(false, "refs/heads/master~");
+		assertValid(false, "refs/heads/~master");
+		assertValid(false, "~refs/heads/master");
+
+		assertValid(false, "refs/heads/master:");
+		assertValid(false, "refs/heads/:master");
+		assertValid(false, ":refs/heads/master");
+	}
+
+	public void testShellGlob() {
+		assertValid(false, "refs/heads/master?");
+		assertValid(false, "refs/heads/?master");
+		assertValid(false, "?refs/heads/master");
+
+		assertValid(false, "refs/heads/master[");
+		assertValid(false, "refs/heads/[master");
+		assertValid(false, "[refs/heads/master");
+
+		assertValid(false, "refs/heads/master*");
+		assertValid(false, "refs/heads/*master");
+		assertValid(false, "*refs/heads/master");
+	}
+
+	public void testValidSpecialCharacters() {
+		assertValid(true, "refs/heads/!");
+		assertValid(true, "refs/heads/\"");
+		assertValid(true, "refs/heads/#");
+		assertValid(true, "refs/heads/$");
+		assertValid(true, "refs/heads/%");
+		assertValid(true, "refs/heads/&");
+		assertValid(true, "refs/heads/'");
+		assertValid(true, "refs/heads/(");
+		assertValid(true, "refs/heads/)");
+		assertValid(true, "refs/heads/+");
+		assertValid(true, "refs/heads/,");
+		assertValid(true, "refs/heads/-");
+		assertValid(true, "refs/heads/;");
+		assertValid(true, "refs/heads/<");
+		assertValid(true, "refs/heads/=");
+		assertValid(true, "refs/heads/>");
+		assertValid(true, "refs/heads/@");
+		assertValid(true, "refs/heads/]");
+		assertValid(true, "refs/heads/_");
+		assertValid(true, "refs/heads/`");
+		assertValid(true, "refs/heads/{");
+		assertValid(true, "refs/heads/|");
+		assertValid(true, "refs/heads/}");
+
+		// This is valid on UNIX, but not on Windows.
+		//
+		assertValid(true, "refs/heads/\\");
+	}
+
+	public void testRefLogQueryIsValidRef() {
+		// Yes, these are actually ambiguous. You can create a ref
+		// that also looks like a reflog query.
+		//
+		assertValid(true, "refs/heads/master@{1}");
+		assertValid(true, "refs/heads/master@{1.hour.ago}");
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index 5baa7a0..66dcd46 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -939,36 +939,34 @@ public static boolean isValidRefName(final String refName) {
 		final int len = refName.length();
 		if (len == 0)
 			return false;
+		if (refName.endsWith(".lock"))
+			return false;
 
+		int components = 1;
 		char p = '\0';
-		for (int i=0; i<len; ++i) {
-			char c = refName.charAt(i);
+		for (int i = 0; i < len; i++) {
+			final char c = refName.charAt(i);
 			if (c <= ' ')
 				return false;
-			switch(c) {
+			switch (c) {
 			case '.':
-				if (i == 0)
-					return false;
-				if (p == '/')
-					return false;
-				if (p == '.')
+				switch (p) {
+				case '\0': case '/': case '.':
 					return false;
+				}
 				break;
 			case '/':
-				if (i == 0)
-					return false;
-				if (i == len -1)
+				if (i == 0 || i == len - 1)
 					return false;
+				components++;
 				break;
 			case '~': case '^': case ':':
-			case '?': case '[':
-				return false;
-			case '*':
+			case '?': case '[': case '*':
 				return false;
 			}
 			p = c;
 		}
-		return true;
+		return components > 1;
 	}
 
 	/**
-- 
1.6.3.195.gad81

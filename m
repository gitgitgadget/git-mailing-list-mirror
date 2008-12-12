From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 10/15] Record patch parsing errors for later inspection by applications
Date: Thu, 11 Dec 2008 18:46:16 -0800
Message-ID: <1229049981-14152-11-git-send-email-spearce@spearce.org>
References: <1229049981-14152-1-git-send-email-spearce@spearce.org>
 <1229049981-14152-2-git-send-email-spearce@spearce.org>
 <1229049981-14152-3-git-send-email-spearce@spearce.org>
 <1229049981-14152-4-git-send-email-spearce@spearce.org>
 <1229049981-14152-5-git-send-email-spearce@spearce.org>
 <1229049981-14152-6-git-send-email-spearce@spearce.org>
 <1229049981-14152-7-git-send-email-spearce@spearce.org>
 <1229049981-14152-8-git-send-email-spearce@spearce.org>
 <1229049981-14152-9-git-send-email-spearce@spearce.org>
 <1229049981-14152-10-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 03:48:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAy52-00057A-LK
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 03:48:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757270AbYLLCq6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 21:46:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757420AbYLLCq4
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 21:46:56 -0500
Received: from george.spearce.org ([209.20.77.23]:41594 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757270AbYLLCqd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2008 21:46:33 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 6E19538215; Fri, 12 Dec 2008 02:46:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 4824238265;
	Fri, 12 Dec 2008 02:46:25 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc2.306.ge5d5e
In-Reply-To: <1229049981-14152-10-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102872>

Errors identified while reading a patch script are now collected
into FormatError objects within the errors collection of a Patch.
These can be inspected to determine if a common form of breakage
is found within the patch script once its basic metadata is read.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../tst/org/spearce/jgit/patch/PatchErrorTest.java |  174 ++++++++++++++++++++
 .../tst/org/spearce/jgit/patch/PatchTest.java      |    4 +
 .../spearce/jgit/patch/testError_BodyTooLong.patch |   17 ++
 .../jgit/patch/testError_DisconnectedHunk.patch    |   30 ++++
 .../jgit/patch/testError_GarbageBetweenFiles.patch |   33 ++++
 .../patch/testError_GitBinaryNoForwardHunk.patch   |   10 +
 .../jgit/patch/testError_TruncatedNew.patch        |   15 ++
 .../jgit/patch/testError_TruncatedOld.patch        |   15 ++
 .../src/org/spearce/jgit/patch/FormatError.java    |   95 +++++++++++
 .../src/org/spearce/jgit/patch/HunkHeader.java     |   20 ++-
 .../src/org/spearce/jgit/patch/Patch.java          |   38 ++++-
 11 files changed, 441 insertions(+), 10 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/patch/PatchErrorTest.java
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/patch/testError_BodyTooLong.patch
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/patch/testError_DisconnectedHunk.patch
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/patch/testError_GarbageBetweenFiles.patch
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/patch/testError_GitBinaryNoForwardHunk.patch
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/patch/testError_TruncatedNew.patch
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/patch/testError_TruncatedOld.patch
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/patch/FormatError.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/patch/PatchErrorTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/PatchErrorTest.java
new file mode 100644
index 0000000..3d7e6b2
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/PatchErrorTest.java
@@ -0,0 +1,174 @@
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
+package org.spearce.jgit.patch;
+
+import java.io.IOException;
+import java.io.InputStream;
+
+import junit.framework.TestCase;
+
+public class PatchErrorTest extends TestCase {
+	public void testError_DisconnectedHunk() throws IOException {
+		final Patch p = parseTestPatchFile();
+		assertEquals(1, p.getFiles().size());
+		{
+			final FileHeader fh = p.getFiles().get(0);
+			assertEquals(
+					"org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java",
+					fh.getNewName());
+			assertEquals(1, fh.getHunks().size());
+		}
+
+		assertEquals(1, p.getErrors().size());
+		final FormatError e = p.getErrors().get(0);
+		assertSame(FormatError.Severity.ERROR, e.getSeverity());
+		assertEquals("Hunk disconnected from file", e.getMessage());
+		assertEquals(18, e.getOffset());
+		assertTrue(e.getLineText().startsWith("@@ -109,4 +109,11 @@ assert"));
+	}
+
+	public void testError_TruncatedOld() throws IOException {
+		final Patch p = parseTestPatchFile();
+		assertEquals(1, p.getFiles().size());
+		assertEquals(1, p.getErrors().size());
+
+		final FormatError e = p.getErrors().get(0);
+		assertSame(FormatError.Severity.ERROR, e.getSeverity());
+		assertEquals("Truncated hunk, at least 1 old lines is missing", e
+				.getMessage());
+		assertEquals(313, e.getOffset());
+		assertTrue(e.getLineText().startsWith("@@ -236,9 +236,9 @@ protected "));
+	}
+
+	public void testError_TruncatedNew() throws IOException {
+		final Patch p = parseTestPatchFile();
+		assertEquals(1, p.getFiles().size());
+		assertEquals(1, p.getErrors().size());
+
+		final FormatError e = p.getErrors().get(0);
+		assertSame(FormatError.Severity.ERROR, e.getSeverity());
+		assertEquals("Truncated hunk, at least 1 new lines is missing", e
+				.getMessage());
+		assertEquals(313, e.getOffset());
+		assertTrue(e.getLineText().startsWith("@@ -236,9 +236,9 @@ protected "));
+	}
+
+	public void testError_BodyTooLong() throws IOException {
+		final Patch p = parseTestPatchFile();
+		assertEquals(1, p.getFiles().size());
+		assertEquals(1, p.getErrors().size());
+
+		final FormatError e = p.getErrors().get(0);
+		assertSame(FormatError.Severity.WARNING, e.getSeverity());
+		assertEquals("Hunk header 4:11 does not match body line count of 4:12",
+				e.getMessage());
+		assertEquals(349, e.getOffset());
+		assertTrue(e.getLineText().startsWith("@@ -109,4 +109,11 @@ assert"));
+	}
+
+	public void testError_GarbageBetweenFiles() throws IOException {
+		final Patch p = parseTestPatchFile();
+		assertEquals(2, p.getFiles().size());
+		{
+			final FileHeader fh = p.getFiles().get(0);
+			assertEquals(
+					"org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryConfigTest.java",
+					fh.getNewName());
+			assertEquals(1, fh.getHunks().size());
+		}
+		{
+			final FileHeader fh = p.getFiles().get(1);
+			assertEquals(
+					"org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java",
+					fh.getNewName());
+			assertEquals(1, fh.getHunks().size());
+		}
+
+		assertEquals(1, p.getErrors().size());
+		final FormatError e = p.getErrors().get(0);
+		assertSame(FormatError.Severity.WARNING, e.getSeverity());
+		assertEquals("Unexpected hunk trailer", e.getMessage());
+		assertEquals(926, e.getOffset());
+		assertEquals("I AM NOT HERE\n", e.getLineText());
+	}
+
+	public void testError_GitBinaryNoForwardHunk() throws IOException {
+		final Patch p = parseTestPatchFile();
+		assertEquals(2, p.getFiles().size());
+		{
+			final FileHeader fh = p.getFiles().get(0);
+			assertEquals("org.spearce.egit.ui/icons/toolbar/fetchd.png", fh
+					.getNewName());
+			assertSame(FileHeader.PatchType.GIT_BINARY, fh.getPatchType());
+			assertTrue(fh.getHunks().isEmpty());
+			assertNull(fh.getForwardBinaryHunk());
+		}
+		{
+			final FileHeader fh = p.getFiles().get(1);
+			assertEquals("org.spearce.egit.ui/icons/toolbar/fetche.png", fh
+					.getNewName());
+			assertSame(FileHeader.PatchType.UNIFIED, fh.getPatchType());
+			assertTrue(fh.getHunks().isEmpty());
+			assertNull(fh.getForwardBinaryHunk());
+		}
+
+		assertEquals(1, p.getErrors().size());
+		final FormatError e = p.getErrors().get(0);
+		assertSame(FormatError.Severity.ERROR, e.getSeverity());
+		assertEquals("Missing forward-image in GIT binary patch", e
+				.getMessage());
+		assertEquals(297, e.getOffset());
+		assertEquals("\n", e.getLineText());
+	}
+
+	private Patch parseTestPatchFile() throws IOException {
+		final String patchFile = getName() + ".patch";
+		final InputStream in = getClass().getResourceAsStream(patchFile);
+		if (in == null) {
+			fail("No " + patchFile + " test vector");
+			return null; // Never happens
+		}
+		try {
+			final Patch p = new Patch();
+			p.parse(in);
+			return p;
+		} finally {
+			in.close();
+		}
+	}
+}
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/patch/PatchTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/PatchTest.java
index 453d88e..7c69fff 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/patch/PatchTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/PatchTest.java
@@ -49,11 +49,13 @@
 	public void testEmpty() {
 		final Patch p = new Patch();
 		assertTrue(p.getFiles().isEmpty());
+		assertTrue(p.getErrors().isEmpty());
 	}
 
 	public void testParse_ConfigCaseInsensitive() throws IOException {
 		final Patch p = parseTestPatchFile();
 		assertEquals(2, p.getFiles().size());
+		assertTrue(p.getErrors().isEmpty());
 
 		final FileHeader fRepositoryConfigTest = p.getFiles().get(0);
 		final FileHeader fRepositoryConfig = p.getFiles().get(1);
@@ -145,6 +147,7 @@ assertSame(FileHeader.PatchType.UNIFIED, fRepositoryConfig
 	public void testParse_NoBinary() throws IOException {
 		final Patch p = parseTestPatchFile();
 		assertEquals(5, p.getFiles().size());
+		assertTrue(p.getErrors().isEmpty());
 
 		for (int i = 0; i < 4; i++) {
 			final FileHeader fh = p.getFiles().get(i);
@@ -179,6 +182,7 @@ public void testParse_GitBinary() throws IOException {
 		final Patch p = parseTestPatchFile();
 		final int[] binsizes = { 359, 393, 372, 404 };
 		assertEquals(5, p.getFiles().size());
+		assertTrue(p.getErrors().isEmpty());
 
 		for (int i = 0; i < 4; i++) {
 			final FileHeader fh = p.getFiles().get(i);
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/patch/testError_BodyTooLong.patch b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/testError_BodyTooLong.patch
new file mode 100644
index 0000000..1d0b1c4
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/testError_BodyTooLong.patch
@@ -0,0 +1,17 @@
+diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryConfigTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryConfigTest.java
+index da7e704..34ce04a 100644
+--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryConfigTest.java
++++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryConfigTest.java
+@@ -109,4 +109,11 @@ assertTrue(Arrays.equals(values.toArray(), repositoryConfig
+        .getStringList("my", null, "somename")));
+    checkFile(cfgFile, "[my]\n\tsomename = value1\n\tsomename = value2\n");
+  }
++
++ public void test006_readCaseInsensitive() throws IOException {
++   final File path = writeTrashFile("config_001", "[Foo]\nBar\n");
++   RepositoryConfig repositoryConfig = new RepositoryConfig(null, path);
++BAD LINE
++   assertEquals(true, repositoryConfig.getBoolean("foo", null, "bar", false));
++   assertEquals("", repositoryConfig.getString("foo", null, "bar"));
++ }
+ }
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/patch/testError_DisconnectedHunk.patch b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/testError_DisconnectedHunk.patch
new file mode 100644
index 0000000..4762928
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/testError_DisconnectedHunk.patch
@@ -0,0 +1,30 @@
+From: A. U. Thor
+
+@@ -109,4 +109,11 @@ assertTrue(Arrays.equals(values.toArray(), repositoryConfig
+        .getStringList("my", null, "somename")));
+    checkFile(cfgFile, "[my]\n\tsomename = value1\n\tsomename = value2\n");
+  }
++
++ public void test006_readCaseInsensitive() throws IOException {
++   final File path = writeTrashFile("config_001", "[Foo]\nBar\n");
++   RepositoryConfig repositoryConfig = new RepositoryConfig(null, path);
++   assertEquals(true, repositoryConfig.getBoolean("foo", null, "bar", false));
++   assertEquals("", repositoryConfig.getString("foo", null, "bar"));
++ }
+ }
+diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
+index 45c2f8a..3291bba 100644
+--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
++++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
+@@ -236,9 +236,9 @@ protected boolean getBoolean(final String section, String subsection,
+      return defaultValue;
+ 
+    n = n.toLowerCase();
+-   if (MAGIC_EMPTY_VALUE.equals(n) || "yes".equals(n) || "true".equals(n) || "1".equals(n)) {
++   if (MAGIC_EMPTY_VALUE.equals(n) || "yes".equalsIgnoreCase(n) || "true".equalsIgnoreCase(n) || "1".equals(n)) {
+      return true;
+-   } else if ("no".equals(n) || "false".equals(n) || "0".equals(n)) {
++   } else if ("no".equalsIgnoreCase(n) || "false".equalsIgnoreCase(n) || "0".equalsIgnoreCase(n)) {
+      return false;
+    } else {
+      throw new IllegalArgumentException("Invalid boolean value: "
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/patch/testError_GarbageBetweenFiles.patch b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/testError_GarbageBetweenFiles.patch
new file mode 100644
index 0000000..163357e
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/testError_GarbageBetweenFiles.patch
@@ -0,0 +1,33 @@
+diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryConfigTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryConfigTest.java
+index da7e704..34ce04a 100644
+--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryConfigTest.java
++++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryConfigTest.java
+@@ -109,4 +109,11 @@ assertTrue(Arrays.equals(values.toArray(), repositoryConfig
+        .getStringList("my", null, "somename")));
+    checkFile(cfgFile, "[my]\n\tsomename = value1\n\tsomename = value2\n");
+  }
++
++ public void test006_readCaseInsensitive() throws IOException {
++   final File path = writeTrashFile("config_001", "[Foo]\nBar\n");
++   RepositoryConfig repositoryConfig = new RepositoryConfig(null, path);
++   assertEquals(true, repositoryConfig.getBoolean("foo", null, "bar", false));
++   assertEquals("", repositoryConfig.getString("foo", null, "bar"));
++ }
+ }
+I AM NOT HERE
+diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
+index 45c2f8a..3291bba 100644
+--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
++++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
+@@ -236,9 +236,9 @@ protected boolean getBoolean(final String section, String subsection,
+      return defaultValue;
+ 
+    n = n.toLowerCase();
+-   if (MAGIC_EMPTY_VALUE.equals(n) || "yes".equals(n) || "true".equals(n) || "1".equals(n)) {
++   if (MAGIC_EMPTY_VALUE.equals(n) || "yes".equalsIgnoreCase(n) || "true".equalsIgnoreCase(n) || "1".equals(n)) {
+      return true;
+-   } else if ("no".equals(n) || "false".equals(n) || "0".equals(n)) {
++   } else if ("no".equalsIgnoreCase(n) || "false".equalsIgnoreCase(n) || "0".equalsIgnoreCase(n)) {
+      return false;
+    } else {
+      throw new IllegalArgumentException("Invalid boolean value: "
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/patch/testError_GitBinaryNoForwardHunk.patch b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/testError_GitBinaryNoForwardHunk.patch
new file mode 100644
index 0000000..e3f3307
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/testError_GitBinaryNoForwardHunk.patch
@@ -0,0 +1,10 @@
+ create mode 100644 org.spearce.egit.ui/icons/toolbar/pushe.png
+
+diff --git a/org.spearce.egit.ui/icons/toolbar/fetchd.png b/org.spearce.egit.ui/icons/toolbar/fetchd.png
+new file mode 100644
+index 0000000000000000000000000000000000000000..4433c543f2a52b586a3ed5e31b138244107bc239
+GIT binary patch
+
+diff --git a/org.spearce.egit.ui/icons/toolbar/fetche.png b/org.spearce.egit.ui/icons/toolbar/fetche.png
+new file mode 100644
+index 0000000000000000000000000000000000000000..0ffeb419e6ab302caa5e58661854b33853dc43dc
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/patch/testError_TruncatedNew.patch b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/testError_TruncatedNew.patch
new file mode 100644
index 0000000..6bbb73d
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/testError_TruncatedNew.patch
@@ -0,0 +1,15 @@
+diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
+index 45c2f8a..3291bba 100644
+--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
++++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
+@@ -236,9 +236,9 @@ protected boolean getBoolean(final String section, String subsection,
+      return defaultValue;
+ 
+    n = n.toLowerCase();
+-   if (MAGIC_EMPTY_VALUE.equals(n) || "yes".equals(n) || "true".equals(n) || "1".equals(n)) {
+      return true;
+-   } else if ("no".equals(n) || "false".equals(n) || "0".equals(n)) {
++   } else if ("no".equalsIgnoreCase(n) || "false".equalsIgnoreCase(n) || "0".equalsIgnoreCase(n)) {
+      return false;
+    } else {
+      throw new IllegalArgumentException("Invalid boolean value: "
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/patch/testError_TruncatedOld.patch b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/testError_TruncatedOld.patch
new file mode 100644
index 0000000..c8fbdc1
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/testError_TruncatedOld.patch
@@ -0,0 +1,15 @@
+diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
+index 45c2f8a..3291bba 100644
+--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
++++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
+@@ -236,9 +236,9 @@ protected boolean getBoolean(final String section, String subsection,
+      return defaultValue;
+ 
+    n = n.toLowerCase();
+-   if (MAGIC_EMPTY_VALUE.equals(n) || "yes".equals(n) || "true".equals(n) || "1".equals(n)) {
++   if (MAGIC_EMPTY_VALUE.equals(n) || "yes".equalsIgnoreCase(n) || "true".equalsIgnoreCase(n) || "1".equals(n)) {
+      return true;
++   } else if ("no".equalsIgnoreCase(n) || "false".equalsIgnoreCase(n) || "0".equalsIgnoreCase(n)) {
+      return false;
+    } else {
+      throw new IllegalArgumentException("Invalid boolean value: "
diff --git a/org.spearce.jgit/src/org/spearce/jgit/patch/FormatError.java b/org.spearce.jgit/src/org/spearce/jgit/patch/FormatError.java
new file mode 100644
index 0000000..e6f0a03
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/patch/FormatError.java
@@ -0,0 +1,95 @@
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
+package org.spearce.jgit.patch;
+
+import org.spearce.jgit.lib.Constants;
+import org.spearce.jgit.util.RawParseUtils;
+
+/** An error in a patch script */
+public class FormatError {
+	/** Classification of an error. */
+	public static enum Severity {
+		/** The error is unexpected, but can be worked around. */
+		WARNING,
+
+		/** The error indicates the script is severely flawed. */
+		ERROR;
+	}
+
+	private final byte[] buf;
+
+	private final int offset;
+
+	private final Severity severity;
+
+	private final String message;
+
+	FormatError(final byte[] buffer, final int ptr, final Severity sev,
+			final String msg) {
+		buf = buffer;
+		offset = ptr;
+		severity = sev;
+		message = msg;
+	}
+
+	/** @return the severity of the error. */
+	public Severity getSeverity() {
+		return severity;
+	}
+
+	/** @return a message describing the error. */
+	public String getMessage() {
+		return message;
+	}
+
+	/** @return the byte buffer holding the patch script. */
+	public byte[] getBuffer() {
+		return buf;
+	}
+
+	/** @return byte offset within {@link #getBuffer()} where the error is */
+	public int getOffset() {
+		return offset;
+	}
+
+	/** @return line of the patch script the error appears on. */
+	public String getLineText() {
+		final int eol = RawParseUtils.nextLF(buf, offset);
+		return RawParseUtils.decode(Constants.CHARSET, buf, offset, eol);
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/patch/HunkHeader.java b/org.spearce.jgit/src/org/spearce/jgit/patch/HunkHeader.java
index fc606c3..20dd6e2 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/patch/HunkHeader.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/patch/HunkHeader.java
@@ -132,7 +132,7 @@ void parseHeader() {
 		newLineCount = parseBase10(buf, ptr.value + 1, ptr);
 	}
 
-	int parseBody() {
+	int parseBody(final Patch script) {
 		final byte[] buf = file.buf;
 		final int sz = buf.length;
 		int c = nextLF(buf, startOffset), last = c;
@@ -175,9 +175,21 @@ int parseBody() {
 			return last;
 		}
 
-		if (nContext + nDeleted != oldLineCount
-				|| nContext + nAdded != newLineCount) {
-			// TODO report on truncated hunk
+		if (nContext + nDeleted < oldLineCount) {
+			final int missingCount = oldLineCount - (nContext + nDeleted);
+			script.error(buf, startOffset, "Truncated hunk, at least "
+					+ missingCount + " old lines is missing");
+
+		} else if (nContext + nAdded < newLineCount) {
+			final int missingCount = newLineCount - (nContext + nAdded);
+			script.error(buf, startOffset, "Truncated hunk, at least "
+					+ missingCount + " new lines is missing");
+
+		} else if (nContext + nDeleted > oldLineCount
+				|| nContext + nAdded > newLineCount) {
+			script.warn(buf, startOffset, "Hunk header " + oldLineCount + ":"
+					+ newLineCount + " does not match body line count of "
+					+ (nContext + nDeleted) + ":" + (nContext + nAdded));
 		}
 
 		return c;
diff --git a/org.spearce.jgit/src/org/spearce/jgit/patch/Patch.java b/org.spearce.jgit/src/org/spearce/jgit/patch/Patch.java
index 56eb327..5cc208c 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/patch/Patch.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/patch/Patch.java
@@ -69,9 +69,13 @@
 	/** The files, in the order they were parsed out of the input. */
 	private final List<FileHeader> files;
 
+	/** Formatting errors, if any were identified. */
+	private final List<FormatError> errors;
+
 	/** Create an empty patch. */
 	public Patch() {
 		files = new ArrayList<FileHeader>();
+		errors = new ArrayList<FormatError>(0);
 	}
 
 	/**
@@ -93,6 +97,21 @@ public void addFile(final FileHeader fh) {
 	}
 
 	/**
+	 * Add a formatting error to this patch script.
+	 * 
+	 * @param err
+	 *            the error description.
+	 */
+	public void addError(final FormatError err) {
+		errors.add(err);
+	}
+
+	/** @return collection of formatting errors, if any. */
+	public List<FormatError> getErrors() {
+		return errors;
+	}
+
+	/**
 	 * Parse a patch received from an InputStream.
 	 * <p>
 	 * Multiple parse calls on the same instance will concatenate the patch
@@ -149,8 +168,7 @@ private int parseFile(final byte[] buf, int c) {
 				// have missed a file header previously. The hunk
 				// isn't valid without knowing where it comes from.
 				//
-
-				// TODO handle a disconnected hunk fragment
+				error(buf, c, "Hunk disconnected from file");
 				c = nextLF(buf, c);
 				continue;
 			}
@@ -218,6 +236,7 @@ private int parseDiffCC(final byte[] buf, final int startOffset) {
 
 		// TODO Support parsing diff --cc headers
 		// TODO parse diff --cc hunks
+		warn(buf, startOffset, "diff --cc format not supported");
 		fh.endOffset = ptr;
 		addFile(fh);
 		return ptr;
@@ -259,12 +278,12 @@ private int parseHunks(final FileHeader fh, int c) {
 			if (match(buf, c, HUNK_HDR) >= 0) {
 				final HunkHeader h = new HunkHeader(fh, c);
 				h.parseHeader();
-				c = h.parseBody();
+				c = h.parseBody(this);
 				h.endOffset = c;
 				fh.addHunk(h);
 				if (c < sz && buf[c] != '@' && buf[c] != 'd'
 						&& match(buf, c, SIG_FOOTER) < 0) {
-					// TODO report on noise between hunks, might be an error
+					warn(buf, c, "Unexpected hunk trailer");
 				}
 				continue;
 			}
@@ -308,8 +327,7 @@ private int parseGitBinary(final FileHeader fh, int c) {
 		if (nEnd < 0) {
 			// Not a binary hunk.
 			//
-
-			// TODO handle invalid binary hunks
+			error(fh.buf, c, "Missing forward-image in GIT binary patch");
 			return c;
 		}
 		c = nEnd;
@@ -327,6 +345,14 @@ private int parseGitBinary(final FileHeader fh, int c) {
 		return c;
 	}
 
+	void warn(final byte[] buf, final int ptr, final String msg) {
+		addError(new FormatError(buf, ptr, FormatError.Severity.WARNING, msg));
+	}
+
+	void error(final byte[] buf, final int ptr, final String msg) {
+		addError(new FormatError(buf, ptr, FormatError.Severity.ERROR, msg));
+	}
+
 	private static boolean matchAny(final byte[] buf, final int c,
 			final byte[][] srcs) {
 		for (final byte[] s : srcs) {
-- 
1.6.1.rc2.306.ge5d5e

From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 4/5] Define Patch to parse a sequence of patch FileHeaders
Date: Wed, 10 Dec 2008 20:58:41 -0800
Message-ID: <1228971522-28764-5-git-send-email-spearce@spearce.org>
References: <1228971522-28764-1-git-send-email-spearce@spearce.org>
 <1228971522-28764-2-git-send-email-spearce@spearce.org>
 <1228971522-28764-3-git-send-email-spearce@spearce.org>
 <1228971522-28764-4-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Dec 11 06:00:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAdf8-0002D6-TD
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 06:00:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754558AbYLKE65 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 23:58:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754642AbYLKE6z
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 23:58:55 -0500
Received: from george.spearce.org ([209.20.77.23]:51660 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754558AbYLKE6s (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 23:58:48 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 1EA1B38210; Thu, 11 Dec 2008 04:58:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id AEC4338200;
	Thu, 11 Dec 2008 04:58:44 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc2.299.gead4c
In-Reply-To: <1228971522-28764-4-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102779>

Most patch scripts impact more than one file at a time, so we need
to support parsing multiple FileHeaders from the same input stream
and collect them into a larger entity representing the entire script.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../tst/org/spearce/jgit/patch/PatchTest.java      |   97 +++++++++
 .../patch/testParse_ConfigCaseInsensitive.patch    |   67 ++++++
 .../src/org/spearce/jgit/patch/FileHeader.java     |   28 +++
 .../src/org/spearce/jgit/patch/Patch.java          |  217 ++++++++++++++++++++
 4 files changed, 409 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/patch/PatchTest.java
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/patch/testParse_ConfigCaseInsensitive.patch
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/patch/Patch.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/patch/PatchTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/PatchTest.java
new file mode 100644
index 0000000..f389d89
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/PatchTest.java
@@ -0,0 +1,97 @@
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
+import org.spearce.jgit.lib.FileMode;
+
+public class PatchTest extends TestCase {
+	public void testEmpty() {
+		final Patch p = new Patch();
+		assertTrue(p.getFiles().isEmpty());
+	}
+
+	public void testParse_ConfigCaseInsensitive() throws IOException {
+		final Patch p = parseTestPatchFile();
+		assertEquals(2, p.getFiles().size());
+
+		final FileHeader fRepositoryConfigTest = p.getFiles().get(0);
+		final FileHeader fRepositoryConfig = p.getFiles().get(1);
+
+		assertEquals(
+				"org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryConfigTest.java",
+				fRepositoryConfigTest.getNewName());
+
+		assertEquals(
+				"org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java",
+				fRepositoryConfig.getNewName());
+
+		assertEquals(572, fRepositoryConfigTest.startOffset);
+		assertEquals(1490, fRepositoryConfig.startOffset);
+
+		assertEquals("da7e704", fRepositoryConfigTest.getOldId().name());
+		assertEquals("34ce04a", fRepositoryConfigTest.getNewId().name());
+		assertSame(FileMode.REGULAR_FILE, fRepositoryConfigTest.getOldMode());
+		assertSame(FileMode.REGULAR_FILE, fRepositoryConfigTest.getNewMode());
+
+		assertEquals("45c2f8a", fRepositoryConfig.getOldId().name());
+		assertEquals("3291bba", fRepositoryConfig.getNewId().name());
+		assertSame(FileMode.REGULAR_FILE, fRepositoryConfig.getOldMode());
+		assertSame(FileMode.REGULAR_FILE, fRepositoryConfig.getNewMode());
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
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/patch/testParse_ConfigCaseInsensitive.patch b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/testParse_ConfigCaseInsensitive.patch
new file mode 100644
index 0000000..b30418e
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/testParse_ConfigCaseInsensitive.patch
@@ -0,0 +1,67 @@
+From ce9b593ddf2530613f6da9d7f7e4a5ff93da8b36 Mon Sep 17 00:00:00 2001
+From: Robin Rosenberg <robin.rosenberg@dewire.com>
+Date: Mon, 13 Oct 2008 00:50:59 +0200
+Subject: [PATCH] git config file is case insensitive
+
+Keys are now always compared with ignore case rules.
+
+Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
+Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
+---
+ .../org/spearce/jgit/lib/RepositoryConfigTest.java |    7 +++++++
+ .../src/org/spearce/jgit/lib/RepositoryConfig.java |    8 ++++----
+ 2 files changed, 11 insertions(+), 4 deletions(-)
+
+diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryConfigTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryConfigTest.java
+index da7e704..34ce04a 100644
+--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryConfigTest.java
++++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryConfigTest.java
+@@ -109,4 +109,11 @@ assertTrue(Arrays.equals(values.toArray(), repositoryConfig
+ 				.getStringList("my", null, "somename")));
+ 		checkFile(cfgFile, "[my]\n\tsomename = value1\n\tsomename = value2\n");
+ 	}
++
++	public void test006_readCaseInsensitive() throws IOException {
++		final File path = writeTrashFile("config_001", "[Foo]\nBar\n");
++		RepositoryConfig repositoryConfig = new RepositoryConfig(null, path);
++		assertEquals(true, repositoryConfig.getBoolean("foo", null, "bar", false));
++		assertEquals("", repositoryConfig.getString("foo", null, "bar"));
++	}
+ }
+diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
+index 45c2f8a..3291bba 100644
+--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
++++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
+@@ -236,9 +236,9 @@ protected boolean getBoolean(final String section, String subsection,
+ 			return defaultValue;
+ 
+ 		n = n.toLowerCase();
+-		if (MAGIC_EMPTY_VALUE.equals(n) || "yes".equals(n) || "true".equals(n) || "1".equals(n)) {
++		if (MAGIC_EMPTY_VALUE.equals(n) || "yes".equalsIgnoreCase(n) || "true".equalsIgnoreCase(n) || "1".equals(n)) {
+ 			return true;
+-		} else if ("no".equals(n) || "false".equals(n) || "0".equals(n)) {
++		} else if ("no".equalsIgnoreCase(n) || "false".equalsIgnoreCase(n) || "0".equalsIgnoreCase(n)) {
+ 			return false;
+ 		} else {
+ 			throw new IllegalArgumentException("Invalid boolean value: "
+@@ -300,7 +300,7 @@ public String getString(final String section, String subsection, final String na
+ 		final Set<String> result = new HashSet<String>();
+ 
+ 		for (final Entry e : entries) {
+-			if (section.equals(e.base) && e.extendedBase != null)
++			if (section.equalsIgnoreCase(e.base) && e.extendedBase != null)
+ 				result.add(e.extendedBase);
+ 		}
+ 		if (baseConfig != null)
+@@ -954,7 +954,7 @@ private static boolean eq(final String a, final String b) {
+ 				return true;
+ 			if (a == null || b == null)
+ 				return false;
+-			return a.equals(b);
++			return a.equalsIgnoreCase(b);
+ 		}
+ 	}
+ }
+-- 
+1.6.1.rc2.299.gead4c
+
diff --git a/org.spearce.jgit/src/org/spearce/jgit/patch/FileHeader.java b/org.spearce.jgit/src/org/spearce/jgit/patch/FileHeader.java
index 5d1454b..f57a0ff 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/patch/FileHeader.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/patch/FileHeader.java
@@ -364,6 +364,34 @@ int parseGitHeaders(int ptr) {
 		return ptr;
 	}
 
+	int parseTraditionalHeaders(int ptr) {
+		final int sz = buf.length;
+		while (ptr < sz) {
+			final int eol = nextLF(buf, ptr);
+			if (match(buf, ptr, HUNK_HDR) >= 0) {
+				// First hunk header; break out and parse them later.
+				break;
+
+			} else if (match(buf, ptr, OLD_NAME) >= 0) {
+				oldName = p1(parseName(oldName, ptr + OLD_NAME.length, eol));
+				if (oldName == DEV_NULL)
+					changeType = ChangeType.ADD;
+
+			} else if (match(buf, ptr, NEW_NAME) >= 0) {
+				newName = p1(parseName(newName, ptr + NEW_NAME.length, eol));
+				if (newName == DEV_NULL)
+					changeType = ChangeType.DELETE;
+
+			} else {
+				// Possibly an empty patch.
+				break;
+			}
+
+			ptr = eol;
+		}
+		return ptr;
+	}
+
 	private String parseName(final String expect, int ptr, final int end) {
 		if (ptr == end)
 			return expect;
diff --git a/org.spearce.jgit/src/org/spearce/jgit/patch/Patch.java b/org.spearce.jgit/src/org/spearce/jgit/patch/Patch.java
new file mode 100644
index 0000000..30d12a5
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/patch/Patch.java
@@ -0,0 +1,217 @@
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
+import static org.spearce.jgit.lib.Constants.encodeASCII;
+import static org.spearce.jgit.patch.FileHeader.HUNK_HDR;
+import static org.spearce.jgit.patch.FileHeader.NEW_NAME;
+import static org.spearce.jgit.patch.FileHeader.OLD_NAME;
+import static org.spearce.jgit.util.RawParseUtils.match;
+import static org.spearce.jgit.util.RawParseUtils.nextLF;
+
+import java.io.IOException;
+import java.io.InputStream;
+import java.util.ArrayList;
+import java.util.List;
+
+import org.spearce.jgit.util.TemporaryBuffer;
+
+/** A parsed collection of {@link FileHeader}s from a unified diff patch file */
+public class Patch {
+	private static final byte[] DIFF_GIT = encodeASCII("diff --git ");
+
+	private static final byte[] DIFF_CC = encodeASCII("diff --cc ");
+
+	/** The files, in the order they were parsed out of the input. */
+	private final List<FileHeader> files;
+
+	/** Create an empty patch. */
+	public Patch() {
+		files = new ArrayList<FileHeader>();
+	}
+
+	/**
+	 * Add a single file to this patch.
+	 * <p>
+	 * Typically files should be added by parsing the text through one of this
+	 * class's parse methods.
+	 * 
+	 * @param fh
+	 *            the header of the file.
+	 */
+	public void addFile(final FileHeader fh) {
+		files.add(fh);
+	}
+
+	/** @return list of files described in the patch, in occurrence order. */
+	public List<FileHeader> getFiles() {
+		return files;
+	}
+
+	/**
+	 * Parse a patch received from an InputStream.
+	 * <p>
+	 * Multiple parse calls on the same instance will concatenate the patch
+	 * data, but each parse input must start with a valid file header (don't
+	 * split a single file across parse calls).
+	 * 
+	 * @param is
+	 *            the stream to read the patch data from. The stream is read
+	 *            until EOF is reached.
+	 * @throws IOException
+	 *             there was an error reading from the input stream.
+	 */
+	public void parse(final InputStream is) throws IOException {
+		final byte[] buf = readFully(is);
+		parse(buf, 0, buf.length);
+	}
+
+	private static byte[] readFully(final InputStream is) throws IOException {
+		final TemporaryBuffer b = new TemporaryBuffer();
+		b.copy(is);
+		final byte[] buf = b.toByteArray();
+		return buf;
+	}
+
+	/**
+	 * Parse a patch stored in a byte[].
+	 * <p>
+	 * Multiple parse calls on the same instance will concatenate the patch
+	 * data, but each parse input must start with a valid file header (don't
+	 * split a single file across parse calls).
+	 * 
+	 * @param buf
+	 *            the buffer to parse.
+	 * @param ptr
+	 *            starting position to parse from.
+	 * @param end
+	 *            1 past the last position to end parsing. The total length to
+	 *            be parsed is <code>end - ptr</code>.
+	 */
+	public void parse(final byte[] buf, int ptr, final int end) {
+		while (ptr < end)
+			ptr = parseFile(buf, ptr);
+	}
+
+	private int parseFile(final byte[] buf, int c) {
+		final int sz = buf.length;
+		while (c < sz) {
+			// Valid git style patch?
+			//
+			if (match(buf, c, DIFF_GIT) >= 0)
+				return parseDiffGit(buf, c);
+			if (match(buf, c, DIFF_CC) >= 0)
+				return parseDiffCC(buf, c);
+
+			// Junk between files? Leading junk? Traditional
+			// (non-git generated) patch?
+			//
+			final int n = nextLF(buf, c);
+			if (n >= sz) {
+				// Patches cannot be only one line long. This must be
+				// trailing junk that we should ignore.
+				//
+				return sz;
+			}
+
+			if (n - c < 6) {
+				// A valid header must be at least 6 bytes on the
+				// first line, e.g. "--- a/b\n".
+				//
+				c = n;
+				continue;
+			}
+
+			if (match(buf, c, OLD_NAME) >= 0 && match(buf, n, NEW_NAME) >= 0) {
+				// Probably a traditional patch. Ensure we have at least
+				// a "@@ -0,0" smelling line next. We only check the "@@ -".
+				//
+				final int f = nextLF(buf, n);
+				if (f >= sz)
+					return sz;
+				if (match(buf, f, HUNK_HDR) >= 0)
+					return parseTraditionalPatch(buf, c);
+			}
+
+			c = n;
+		}
+		return c;
+	}
+
+	private int parseDiffGit(final byte[] buf, final int startOffset) {
+		final FileHeader fh = new FileHeader(buf, startOffset);
+		int ptr = fh.parseGitFileName(startOffset + DIFF_GIT.length);
+		if (ptr < 0)
+			return skipFile(buf, startOffset);
+
+		ptr = fh.parseGitHeaders(ptr);
+		// TODO parse hunks
+		fh.endOffset = ptr;
+		addFile(fh);
+		return ptr;
+	}
+
+	private int parseDiffCC(final byte[] buf, final int startOffset) {
+		final FileHeader fh = new FileHeader(buf, startOffset);
+		int ptr = fh.parseGitFileName(startOffset + DIFF_CC.length);
+		if (ptr < 0)
+			return skipFile(buf, startOffset);
+
+		// TODO Support parsing diff --cc headers
+		// TODO parse diff --cc hunks
+		fh.endOffset = ptr;
+		addFile(fh);
+		return ptr;
+	}
+
+	private int parseTraditionalPatch(final byte[] buf, final int startOffset) {
+		final FileHeader fh = new FileHeader(buf, startOffset);
+		int ptr = fh.parseTraditionalHeaders(startOffset);
+		// TODO parse hunks
+		fh.endOffset = ptr;
+		addFile(fh);
+		return ptr;
+	}
+
+	private static int skipFile(final byte[] buf, int ptr) {
+		ptr = nextLF(buf, ptr);
+		if (match(buf, ptr, OLD_NAME) >= 0)
+			ptr = nextLF(buf, ptr);
+		return ptr;
+	}
+}
-- 
1.6.1.rc2.299.gead4c

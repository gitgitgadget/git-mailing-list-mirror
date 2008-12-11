From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 3/5] Define FileHeader to parse the header block of a git diff
Date: Wed, 10 Dec 2008 20:58:40 -0800
Message-ID: <1228971522-28764-4-git-send-email-spearce@spearce.org>
References: <1228971522-28764-1-git-send-email-spearce@spearce.org>
 <1228971522-28764-2-git-send-email-spearce@spearce.org>
 <1228971522-28764-3-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Dec 11 06:00:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAdf7-0002D6-Ed
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 06:00:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754640AbYLKE6z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 23:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753023AbYLKE6x
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 23:58:53 -0500
Received: from george.spearce.org ([209.20.77.23]:51657 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754511AbYLKE6r (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 23:58:47 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id C4FEB38215; Thu, 11 Dec 2008 04:58:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 37BEF38210;
	Thu, 11 Dec 2008 04:58:44 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc2.299.gead4c
In-Reply-To: <1228971522-28764-3-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102778>

This class parses the top header lines of a git style diff, such as:

  diff --git a/SUBMITTING_PATCHES b/Q
  similarity index 100%
  copy from SUBMITTING_PATCHES
  copy to Q

or:

  diff --git a/Q b/Q
  new file mode 100644
  index 0000000..e4a135e
  --- /dev/null
  +++ b/Q

and makes the information available in an object form.  Unit tests
cover the different styles of headers that are commonly created by
C git, including both rename formats.

The hunk header information is not handled by this class, and it
does not have a public API.  It is my intention to wrap this into
a larger container class that handles multiple FileHeaders at once,
with the base case of course being a single FileHeader describing
a patch that impacts only one file.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../tst/org/spearce/jgit/patch/FileHeaderTest.java |  391 ++++++++++++++++++
 .../src/org/spearce/jgit/patch/FileHeader.java     |  430 ++++++++++++++++++++
 2 files changed, 821 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/patch/FileHeaderTest.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/patch/FileHeader.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/patch/FileHeaderTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/FileHeaderTest.java
new file mode 100644
index 0000000..1d87bc0
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/FileHeaderTest.java
@@ -0,0 +1,391 @@
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
+package org.spearce.jgit.patch;
+
+import junit.framework.TestCase;
+
+import org.spearce.jgit.lib.Constants;
+import org.spearce.jgit.lib.FileMode;
+import org.spearce.jgit.lib.ObjectId;
+
+public class FileHeaderTest extends TestCase {
+	public void testParseGitFileName_Empty() {
+		assertEquals(-1, data("").parseGitFileName(0));
+	}
+
+	public void testParseGitFileName_NoLF() {
+		assertEquals(-1, data("a/ b/").parseGitFileName(0));
+	}
+
+	public void testParseGitFileName_NoSecondLine() {
+		assertEquals(-1, data("\n").parseGitFileName(0));
+	}
+
+	public void testParseGitFileName_EmptyHeader() {
+		assertEquals(1, data("\n\n").parseGitFileName(0));
+	}
+
+	public void testParseGitFileName_Foo() {
+		final String name = "foo";
+		final FileHeader fh = header(name);
+		assertEquals(gitLine(name).length(), fh.parseGitFileName(0));
+		assertEquals(name, fh.getOldName());
+		assertSame(fh.getOldName(), fh.getNewName());
+	}
+
+	public void testParseGitFileName_FailFooBar() {
+		final FileHeader fh = data("a/foo b/bar\n-");
+		assertTrue(fh.parseGitFileName(0) > 0);
+		assertNull(fh.getOldName());
+		assertNull(fh.getNewName());
+	}
+
+	public void testParseGitFileName_FooSpBar() {
+		final String name = "foo bar";
+		final FileHeader fh = header(name);
+		assertEquals(gitLine(name).length(), fh.parseGitFileName(0));
+		assertEquals(name, fh.getOldName());
+		assertSame(fh.getOldName(), fh.getNewName());
+	}
+
+	public void testParseGitFileName_DqFooTabBar() {
+		final String name = "foo\tbar";
+		final String dqName = "foo\\tbar";
+		final FileHeader fh = dqHeader(dqName);
+		assertEquals(dqGitLine(dqName).length(), fh.parseGitFileName(0));
+		assertEquals(name, fh.getOldName());
+		assertSame(fh.getOldName(), fh.getNewName());
+	}
+
+	public void testParseGitFileName_DqFooSpLfNulBar() {
+		final String name = "foo \n\0bar";
+		final String dqName = "foo \\n\\0bar";
+		final FileHeader fh = dqHeader(dqName);
+		assertEquals(dqGitLine(dqName).length(), fh.parseGitFileName(0));
+		assertEquals(name, fh.getOldName());
+		assertSame(fh.getOldName(), fh.getNewName());
+	}
+
+	public void testParseGitFileName_SrcFooC() {
+		final String name = "src/foo/bar/argh/code.c";
+		final FileHeader fh = header(name);
+		assertEquals(gitLine(name).length(), fh.parseGitFileName(0));
+		assertEquals(name, fh.getOldName());
+		assertSame(fh.getOldName(), fh.getNewName());
+	}
+
+	public void testParseGitFileName_SrcFooCNonStandardPrefix() {
+		final String name = "src/foo/bar/argh/code.c";
+		final String header = "project-v-1.0/" + name + " mydev/" + name + "\n";
+		final FileHeader fh = data(header + "-");
+		assertEquals(header.length(), fh.parseGitFileName(0));
+		assertEquals(name, fh.getOldName());
+		assertSame(fh.getOldName(), fh.getNewName());
+	}
+
+	public void testParseUnicodeName_NewFile() {
+		final FileHeader fh = data("diff --git \"a/\\303\\205ngstr\\303\\266m\" \"b/\\303\\205ngstr\\303\\266m\"\n"
+				+ "new file mode 100644\n"
+				+ "index 0000000..7898192\n"
+				+ "--- /dev/null\n"
+				+ "+++ \"b/\\303\\205ngstr\\303\\266m\"\n"
+				+ "@@ -0,0 +1 @@\n" + "+a\n");
+		assertParse(fh);
+
+		assertEquals("/dev/null", fh.getOldName());
+		assertSame(FileHeader.DEV_NULL, fh.getOldName());
+		assertEquals("\u00c5ngstr\u00f6m", fh.getNewName());
+
+		assertSame(FileHeader.ChangeType.ADD, fh.getChangeType());
+
+		assertNull(fh.getOldMode());
+		assertSame(FileMode.REGULAR_FILE, fh.getNewMode());
+
+		assertEquals("0000000", fh.getOldId().name());
+		assertEquals("7898192", fh.getNewId().name());
+		assertEquals(0, fh.getScore());
+	}
+
+	public void testParseUnicodeName_DeleteFile() {
+		final FileHeader fh = data("diff --git \"a/\\303\\205ngstr\\303\\266m\" \"b/\\303\\205ngstr\\303\\266m\"\n"
+				+ "deleted file mode 100644\n"
+				+ "index 7898192..0000000\n"
+				+ "--- \"a/\\303\\205ngstr\\303\\266m\"\n"
+				+ "+++ /dev/null\n"
+				+ "@@ -1 +0,0 @@\n" + "-a\n");
+		assertParse(fh);
+
+		assertEquals("\u00c5ngstr\u00f6m", fh.getOldName());
+		assertEquals("/dev/null", fh.getNewName());
+		assertSame(FileHeader.DEV_NULL, fh.getNewName());
+
+		assertSame(FileHeader.ChangeType.DELETE, fh.getChangeType());
+
+		assertSame(FileMode.REGULAR_FILE, fh.getOldMode());
+		assertNull(fh.getNewMode());
+
+		assertEquals("7898192", fh.getOldId().name());
+		assertEquals("0000000", fh.getNewId().name());
+		assertEquals(0, fh.getScore());
+	}
+
+	public void testParseModeChange() {
+		final FileHeader fh = data("diff --git a/a b b/a b\n"
+				+ "old mode 100644\n" + "new mode 100755\n");
+		assertParse(fh);
+		assertEquals("a b", fh.getOldName());
+		assertEquals("a b", fh.getNewName());
+
+		assertSame(FileHeader.ChangeType.MODIFY, fh.getChangeType());
+
+		assertNull(fh.getOldId());
+		assertNull(fh.getNewId());
+
+		assertSame(FileMode.REGULAR_FILE, fh.getOldMode());
+		assertSame(FileMode.EXECUTABLE_FILE, fh.getNewMode());
+		assertEquals(0, fh.getScore());
+	}
+
+	public void testParseRename100_NewStyle() {
+		final FileHeader fh = data("diff --git a/a b/ c/\\303\\205ngstr\\303\\266m\n"
+				+ "similarity index 100%\n"
+				+ "rename from a\n"
+				+ "rename to \" c/\\303\\205ngstr\\303\\266m\"\n");
+		int ptr = fh.parseGitFileName(0);
+		assertTrue(ptr > 0);
+		assertNull(fh.getOldName()); // can't parse names on a rename
+		assertNull(fh.getNewName());
+
+		ptr = fh.parseGitHeaders(ptr);
+		assertTrue(ptr > 0);
+
+		assertEquals("a", fh.getOldName());
+		assertEquals(" c/\u00c5ngstr\u00f6m", fh.getNewName());
+
+		assertSame(FileHeader.ChangeType.RENAME, fh.getChangeType());
+
+		assertNull(fh.getOldId());
+		assertNull(fh.getNewId());
+
+		assertNull(fh.getOldMode());
+		assertNull(fh.getNewMode());
+
+		assertEquals(100, fh.getScore());
+	}
+
+	public void testParseRename100_OldStyle() {
+		final FileHeader fh = data("diff --git a/a b/ c/\\303\\205ngstr\\303\\266m\n"
+				+ "similarity index 100%\n"
+				+ "rename old a\n"
+				+ "rename new \" c/\\303\\205ngstr\\303\\266m\"\n");
+		int ptr = fh.parseGitFileName(0);
+		assertTrue(ptr > 0);
+		assertNull(fh.getOldName()); // can't parse names on a rename
+		assertNull(fh.getNewName());
+
+		ptr = fh.parseGitHeaders(ptr);
+		assertTrue(ptr > 0);
+
+		assertEquals("a", fh.getOldName());
+		assertEquals(" c/\u00c5ngstr\u00f6m", fh.getNewName());
+
+		assertSame(FileHeader.ChangeType.RENAME, fh.getChangeType());
+
+		assertNull(fh.getOldId());
+		assertNull(fh.getNewId());
+
+		assertNull(fh.getOldMode());
+		assertNull(fh.getNewMode());
+
+		assertEquals(100, fh.getScore());
+	}
+	public void testParseCopy100() {
+		final FileHeader fh = data("diff --git a/a b/ c/\\303\\205ngstr\\303\\266m\n"
+				+ "similarity index 100%\n"
+				+ "copy from a\n"
+				+ "copy to \" c/\\303\\205ngstr\\303\\266m\"\n");
+		int ptr = fh.parseGitFileName(0);
+		assertTrue(ptr > 0);
+		assertNull(fh.getOldName()); // can't parse names on a copy
+		assertNull(fh.getNewName());
+
+		ptr = fh.parseGitHeaders(ptr);
+		assertTrue(ptr > 0);
+
+		assertEquals("a", fh.getOldName());
+		assertEquals(" c/\u00c5ngstr\u00f6m", fh.getNewName());
+
+		assertSame(FileHeader.ChangeType.COPY, fh.getChangeType());
+
+		assertNull(fh.getOldId());
+		assertNull(fh.getNewId());
+
+		assertNull(fh.getOldMode());
+		assertNull(fh.getNewMode());
+
+		assertEquals(100, fh.getScore());
+	}
+
+	public void testParseFullIndexLine_WithMode() {
+		final String oid = "78981922613b2afb6025042ff6bd878ac1994e85";
+		final String nid = "61780798228d17af2d34fce4cfbdf35556832472";
+		final FileHeader fh = data("diff --git a/a b/a\n" + "index " + oid
+				+ ".." + nid + " 100644\n" + "--- a/a\n" + "+++ b/a\n");
+		assertParse(fh);
+
+		assertEquals("a", fh.getOldName());
+		assertEquals("a", fh.getNewName());
+
+		assertSame(FileMode.REGULAR_FILE, fh.getOldMode());
+		assertSame(FileMode.REGULAR_FILE, fh.getNewMode());
+
+		assertNotNull(fh.getOldId());
+		assertNotNull(fh.getNewId());
+
+		assertTrue(fh.getOldId().isComplete());
+		assertTrue(fh.getNewId().isComplete());
+
+		assertEquals(ObjectId.fromString(oid), fh.getOldId().toObjectId());
+		assertEquals(ObjectId.fromString(nid), fh.getNewId().toObjectId());
+	}
+
+	public void testParseFullIndexLine_NoMode() {
+		final String oid = "78981922613b2afb6025042ff6bd878ac1994e85";
+		final String nid = "61780798228d17af2d34fce4cfbdf35556832472";
+		final FileHeader fh = data("diff --git a/a b/a\n" + "index " + oid
+				+ ".." + nid + "\n" + "--- a/a\n" + "+++ b/a\n");
+		assertParse(fh);
+
+		assertEquals("a", fh.getOldName());
+		assertEquals("a", fh.getNewName());
+
+		assertNull(fh.getOldMode());
+		assertNull(fh.getNewMode());
+
+		assertNotNull(fh.getOldId());
+		assertNotNull(fh.getNewId());
+
+		assertTrue(fh.getOldId().isComplete());
+		assertTrue(fh.getNewId().isComplete());
+
+		assertEquals(ObjectId.fromString(oid), fh.getOldId().toObjectId());
+		assertEquals(ObjectId.fromString(nid), fh.getNewId().toObjectId());
+	}
+
+	public void testParseAbbrIndexLine_WithMode() {
+		final int a = 7;
+		final String oid = "78981922613b2afb6025042ff6bd878ac1994e85";
+		final String nid = "61780798228d17af2d34fce4cfbdf35556832472";
+		final FileHeader fh = data("diff --git a/a b/a\n" + "index "
+				+ oid.substring(0, a - 1) + ".." + nid.substring(0, a - 1)
+				+ " 100644\n" + "--- a/a\n" + "+++ b/a\n");
+		assertParse(fh);
+
+		assertEquals("a", fh.getOldName());
+		assertEquals("a", fh.getNewName());
+
+		assertSame(FileMode.REGULAR_FILE, fh.getOldMode());
+		assertSame(FileMode.REGULAR_FILE, fh.getNewMode());
+
+		assertNotNull(fh.getOldId());
+		assertNotNull(fh.getNewId());
+
+		assertFalse(fh.getOldId().isComplete());
+		assertFalse(fh.getNewId().isComplete());
+
+		assertEquals(oid.substring(0, a - 1), fh.getOldId().name());
+		assertEquals(nid.substring(0, a - 1), fh.getNewId().name());
+
+		assertTrue(ObjectId.fromString(oid).startsWith(fh.getOldId()));
+		assertTrue(ObjectId.fromString(nid).startsWith(fh.getNewId()));
+	}
+
+	public void testParseAbbrIndexLine_NoMode() {
+		final int a = 7;
+		final String oid = "78981922613b2afb6025042ff6bd878ac1994e85";
+		final String nid = "61780798228d17af2d34fce4cfbdf35556832472";
+		final FileHeader fh = data("diff --git a/a b/a\n" + "index "
+				+ oid.substring(0, a - 1) + ".." + nid.substring(0, a - 1)
+				+ "\n" + "--- a/a\n" + "+++ b/a\n");
+		assertParse(fh);
+
+		assertEquals("a", fh.getOldName());
+		assertEquals("a", fh.getNewName());
+
+		assertNull(fh.getOldMode());
+		assertNull(fh.getNewMode());
+
+		assertNotNull(fh.getOldId());
+		assertNotNull(fh.getNewId());
+
+		assertFalse(fh.getOldId().isComplete());
+		assertFalse(fh.getNewId().isComplete());
+
+		assertEquals(oid.substring(0, a - 1), fh.getOldId().name());
+		assertEquals(nid.substring(0, a - 1), fh.getNewId().name());
+
+		assertTrue(ObjectId.fromString(oid).startsWith(fh.getOldId()));
+		assertTrue(ObjectId.fromString(nid).startsWith(fh.getNewId()));
+	}
+
+	private static void assertParse(final FileHeader fh) {
+		int ptr = fh.parseGitFileName(0);
+		assertTrue(ptr > 0);
+		ptr = fh.parseGitHeaders(ptr);
+		assertTrue(ptr > 0);
+	}
+
+	private static FileHeader data(final String in) {
+		return new FileHeader(Constants.encodeASCII(in), 0);
+	}
+
+	private static FileHeader header(final String path) {
+		return data(gitLine(path) + "--- " + path + "\n");
+	}
+
+	private static String gitLine(final String path) {
+		return "a/" + path + " b/" + path + "\n";
+	}
+
+	private static FileHeader dqHeader(final String path) {
+		return data(dqGitLine(path) + "--- " + path + "\n");
+	}
+
+	private static String dqGitLine(final String path) {
+		return "\"a/" + path + "\" \"b/" + path + "\"\n";
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/patch/FileHeader.java b/org.spearce.jgit/src/org/spearce/jgit/patch/FileHeader.java
new file mode 100644
index 0000000..5d1454b
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/patch/FileHeader.java
@@ -0,0 +1,430 @@
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
+import static org.spearce.jgit.util.RawParseUtils.decode;
+import static org.spearce.jgit.util.RawParseUtils.match;
+import static org.spearce.jgit.util.RawParseUtils.nextLF;
+import static org.spearce.jgit.util.RawParseUtils.parseBase10;
+
+import org.spearce.jgit.lib.AbbreviatedObjectId;
+import org.spearce.jgit.lib.Constants;
+import org.spearce.jgit.lib.FileMode;
+import org.spearce.jgit.util.QuotedString;
+
+/** Patch header describing an action for a single file path. */
+public class FileHeader {
+	/** Magical file name used for file adds or deletes. */
+	public static final String DEV_NULL = "/dev/null";
+
+	private static final byte[] OLD_MODE = encodeASCII("old mode ");
+
+	private static final byte[] NEW_MODE = encodeASCII("new mode ");
+
+	private static final byte[] DELETED_FILE_MODE = encodeASCII("deleted file mode ");
+
+	private static final byte[] NEW_FILE_MODE = encodeASCII("new file mode ");
+
+	private static final byte[] COPY_FROM = encodeASCII("copy from ");
+
+	private static final byte[] COPY_TO = encodeASCII("copy to ");
+
+	private static final byte[] RENAME_OLD = encodeASCII("rename old ");
+
+	private static final byte[] RENAME_NEW = encodeASCII("rename new ");
+
+	private static final byte[] RENAME_FROM = encodeASCII("rename from ");
+
+	private static final byte[] RENAME_TO = encodeASCII("rename to ");
+
+	private static final byte[] SIMILARITY_INDEX = encodeASCII("similarity index ");
+
+	private static final byte[] DISSIMILARITY_INDEX = encodeASCII("dissimilarity index ");
+
+	private static final byte[] INDEX = encodeASCII("index ");
+
+	static final byte[] OLD_NAME = encodeASCII("--- ");
+
+	static final byte[] NEW_NAME = encodeASCII("+++ ");
+
+	static final byte[] HUNK_HDR = encodeASCII("@@ -");
+
+	/** General type of change a single file-level patch describes. */
+	public static enum ChangeType {
+		/** Add a new file to the project */
+		ADD,
+
+		/** Modify an existing file in the project (content and/or mode) */
+		MODIFY,
+
+		/** Delete an existing file from the project */
+		DELETE,
+
+		/** Rename an existing file to a new location */
+		RENAME,
+
+		/** Copy an existing file to a new location, keeping the original */
+		COPY;
+	}
+
+	/** Buffer holding the patch data for this file. */
+	final byte[] buf;
+
+	/** Offset within {@link #buf} to the "diff ..." line. */
+	final int startOffset;
+
+	/** Position 1 past the end of this file within {@link #buf}. */
+	int endOffset;
+
+	/** File name of the old (pre-image). */
+	private String oldName;
+
+	/** File name of the new (post-image). */
+	private String newName;
+
+	/** Old mode of the file, if described by the patch, else null. */
+	private FileMode oldMode;
+
+	/** New mode of the file, if described by the patch, else null. */
+	private FileMode newMode;
+
+	/** General type of change indicated by the patch. */
+	private ChangeType changeType;
+
+	/** Similarity score if {@link #changeType} is a copy or rename. */
+	private int score;
+
+	/** ObjectId listed on the index line for the old (pre-image) */
+	private AbbreviatedObjectId oldId;
+
+	/** ObjectId listed on the index line for the new (post-image) */
+	private AbbreviatedObjectId newId;
+
+	FileHeader(final byte[] b, final int offset) {
+		buf = b;
+		startOffset = offset;
+		changeType = ChangeType.MODIFY; // unless otherwise designated
+	}
+
+	/**
+	 * Get the old name associated with this file.
+	 * <p>
+	 * The meaning of the old name can differ depending on the semantic meaning
+	 * of this patch:
+	 * <ul>
+	 * <li><i>file add</i>: always <code>/dev/null</code></li>
+	 * <li><i>file modify</i>: always {@link #getNewName()}</li>
+	 * <li><i>file delete</i>: always the file being deleted</li>
+	 * <li><i>file copy</i>: source file the copy originates from</li>
+	 * <li><i>file rename</i>: source file the rename originates from</li>
+	 * </ul>
+	 * 
+	 * @return old name for this file.
+	 */
+	public String getOldName() {
+		return oldName;
+	}
+
+	/**
+	 * Get the new name associated with this file.
+	 * <p>
+	 * The meaning of the new name can differ depending on the semantic meaning
+	 * of this patch:
+	 * <ul>
+	 * <li><i>file add</i>: always the file being created</li>
+	 * <li><i>file modify</i>: always {@link #getOldName()}</li>
+	 * <li><i>file delete</i>: always <code>/dev/null</code></li>
+	 * <li><i>file copy</i>: destination file the copy ends up at</li>
+	 * <li><i>file rename</i>: destination file the rename ends up at/li>
+	 * </ul>
+	 * 
+	 * @return new name for this file.
+	 */
+	public String getNewName() {
+		return newName;
+	}
+
+	/** @return the old file mode, if described in the patch */
+	public FileMode getOldMode() {
+		return oldMode;
+	}
+
+	/** @return the new file mode, if described in the patch */
+	public FileMode getNewMode() {
+		return newMode;
+	}
+
+	/** @return the type of change this patch makes on {@link #getNewName()} */
+	public ChangeType getChangeType() {
+		return changeType;
+	}
+
+	/**
+	 * @return similarity score between {@link #getOldName()} and
+	 *         {@link #getNewName()} if {@link #getChangeType()} is
+	 *         {@link ChangeType#COPY} or {@link ChangeType#RENAME}.
+	 */
+	public int getScore() {
+		return score;
+	}
+
+	/**
+	 * Get the old object id from the <code>index</code>.
+	 * 
+	 * @return the object id; null if there is no index line
+	 */
+	public AbbreviatedObjectId getOldId() {
+		return oldId;
+	}
+
+	/**
+	 * Get the new object id from the <code>index</code>.
+	 * 
+	 * @return the object id; null if there is no index line
+	 */
+	public AbbreviatedObjectId getNewId() {
+		return newId;
+	}
+
+	/**
+	 * Parse a "diff --git" or "diff --cc" line.
+	 * 
+	 * @param ptr
+	 *            first character after the "diff --git " or "diff --cc " part.
+	 * @return first character after the LF at the end of the line; -1 on error.
+	 */
+	int parseGitFileName(int ptr) {
+		final int eol = nextLF(buf, ptr);
+		final int bol = ptr;
+		if (eol >= buf.length) {
+			return -1;
+		}
+
+		// buffer[ptr..eol] looks like "a/foo b/foo\n". After the first
+		// A regex to match this is "^[^/]+/(.*?) [^/+]+/\1\n$". There
+		// is only one way to split the line such that text to the left
+		// of the space matches the text to the right, excluding the part
+		// before the first slash.
+		//
+
+		final int aStart = nextLF(buf, ptr, '/');
+		if (aStart >= eol)
+			return eol;
+
+		while (ptr < eol) {
+			final int sp = nextLF(buf, ptr, ' ');
+			if (sp >= eol) {
+				// We can't split the header, it isn't valid.
+				// This may be OK if this is a rename patch.
+				//
+				return eol;
+			}
+			final int bStart = nextLF(buf, sp, '/');
+			if (bStart >= eol)
+				return eol;
+
+			// If buffer[aStart..sp - 1] = buffer[bStart..eol - 1]
+			// we have a valid split.
+			//
+			if (eq(aStart, sp - 1, bStart, eol - 1)) {
+				if (buf[bol] == '"') {
+					// We're a double quoted name. The region better end
+					// in a double quote too, and we need to decode the
+					// characters before reading the name.
+					//
+					if (buf[sp - 2] != '"') {
+						return eol;
+					}
+					oldName = QuotedString.GIT_PATH.dequote(buf, bol, sp - 1);
+					oldName = p1(oldName);
+				} else {
+					oldName = decode(Constants.CHARSET, buf, aStart, sp - 1);
+				}
+				newName = oldName;
+				return eol;
+			}
+
+			// This split wasn't correct. Move past the space and try
+			// another split as the space must be part of the file name.
+			//
+			ptr = sp;
+		}
+
+		return eol;
+	}
+
+	int parseGitHeaders(int ptr) {
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
+			} else if (match(buf, ptr, OLD_MODE) >= 0) {
+				oldMode = parseFileMode(ptr + OLD_MODE.length, eol);
+
+			} else if (match(buf, ptr, NEW_MODE) >= 0) {
+				newMode = parseFileMode(ptr + NEW_MODE.length, eol);
+
+			} else if (match(buf, ptr, DELETED_FILE_MODE) >= 0) {
+				oldMode = parseFileMode(ptr + DELETED_FILE_MODE.length, eol);
+				changeType = ChangeType.DELETE;
+
+			} else if (match(buf, ptr, NEW_FILE_MODE) >= 0) {
+				newMode = parseFileMode(ptr + NEW_FILE_MODE.length, eol);
+				changeType = ChangeType.ADD;
+
+			} else if (match(buf, ptr, COPY_FROM) >= 0) {
+				oldName = parseName(oldName, ptr + COPY_FROM.length, eol);
+				changeType = ChangeType.COPY;
+
+			} else if (match(buf, ptr, COPY_TO) >= 0) {
+				newName = parseName(newName, ptr + COPY_TO.length, eol);
+				changeType = ChangeType.COPY;
+
+			} else if (match(buf, ptr, RENAME_OLD) >= 0) {
+				oldName = parseName(oldName, ptr + RENAME_OLD.length, eol);
+				changeType = ChangeType.RENAME;
+
+			} else if (match(buf, ptr, RENAME_NEW) >= 0) {
+				newName = parseName(newName, ptr + RENAME_NEW.length, eol);
+				changeType = ChangeType.RENAME;
+
+			} else if (match(buf, ptr, RENAME_FROM) >= 0) {
+				oldName = parseName(oldName, ptr + RENAME_FROM.length, eol);
+				changeType = ChangeType.RENAME;
+
+			} else if (match(buf, ptr, RENAME_TO) >= 0) {
+				newName = parseName(newName, ptr + RENAME_TO.length, eol);
+				changeType = ChangeType.RENAME;
+
+			} else if (match(buf, ptr, SIMILARITY_INDEX) >= 0) {
+				score = parseBase10(buf, ptr + SIMILARITY_INDEX.length, null);
+
+			} else if (match(buf, ptr, DISSIMILARITY_INDEX) >= 0) {
+				score = parseBase10(buf, ptr + DISSIMILARITY_INDEX.length, null);
+
+			} else if (match(buf, ptr, INDEX) >= 0) {
+				parseIndexLine(ptr + INDEX.length, eol);
+
+			} else {
+				// Probably an empty patch (stat dirty).
+				break;
+			}
+
+			ptr = eol;
+		}
+		return ptr;
+	}
+
+	private String parseName(final String expect, int ptr, final int end) {
+		if (ptr == end)
+			return expect;
+
+		String r;
+		if (buf[ptr] == '"') {
+			// New style GNU diff format
+			//
+			r = QuotedString.GIT_PATH.dequote(buf, ptr, end - 1);
+		} else {
+			// Older style GNU diff format, an optional tab ends the name.
+			//
+			int tab = end;
+			while (ptr < tab && buf[tab - 1] != '\t')
+				tab--;
+			if (ptr == tab)
+				tab = end;
+			r = decode(Constants.CHARSET, buf, ptr, tab - 1);
+		}
+
+		if (r.equals(DEV_NULL))
+			r = DEV_NULL;
+		return r;
+	}
+
+	private static String p1(final String r) {
+		final int s = r.indexOf('/');
+		return s > 0 ? r.substring(s + 1) : r;
+	}
+
+	private FileMode parseFileMode(int ptr, final int end) {
+		int tmp = 0;
+		while (ptr < end - 1) {
+			tmp <<= 3;
+			tmp += buf[ptr++] - '0';
+		}
+		return FileMode.fromBits(tmp);
+	}
+
+	private void parseIndexLine(int ptr, final int end) {
+		// "index $asha1..$bsha1[ $mode]" where $asha1 and $bsha1
+		// can be unique abbreviations
+		//
+		final int dot2 = nextLF(buf, ptr, '.');
+		final int mode = nextLF(buf, dot2, ' ');
+
+		oldId = AbbreviatedObjectId.fromString(buf, ptr, dot2 - 1);
+		newId = AbbreviatedObjectId.fromString(buf, dot2 + 1, mode - 1);
+
+		if (mode < end)
+			newMode = oldMode = parseFileMode(mode, end);
+	}
+
+	private boolean eq(int aPtr, int aEnd, int bPtr, int bEnd) {
+		if (aEnd - aPtr != bEnd - bPtr) {
+			return false;
+		}
+		while (aPtr < aEnd) {
+			if (buf[aPtr++] != buf[bPtr++])
+				return false;
+		}
+		return true;
+	}
+}
-- 
1.6.1.rc2.299.gead4c

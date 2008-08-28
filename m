From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 3/5] JUnit test for FileTreeIterator, WorkingTreeIterator
Date: Thu, 28 Aug 2008 08:27:44 -0700
Message-ID: <1219937266-24903-3-git-send-email-spearce@spearce.org>
References: <1219937266-24903-1-git-send-email-spearce@spearce.org>
 <1219937266-24903-2-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 17:29:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYjQt-0003Pm-3o
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 17:29:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753392AbYH1P1x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 11:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753364AbYH1P1w
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 11:27:52 -0400
Received: from george.spearce.org ([209.20.77.23]:51100 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753307AbYH1P1t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 11:27:49 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 47D3A3837A; Thu, 28 Aug 2008 15:27:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 721E738376;
	Thu, 28 Aug 2008 15:27:47 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.174.gd789c
In-Reply-To: <1219937266-24903-2-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94075>

This test is an indirect test of WorkingTreeIterator as the class
is abstract.  An easy way to test it is through the FileTreeIterator
as that relies only on standard Java IO.

We don't have full coverage yet, but most of the cases are dealt
with by this test.  A better test of WorkingTreeIterator would be
to setup a mock implementation that works strictly in memory and
throws it all of the corner cases.  Building that is a lot more
work, and the test will be focusing more on the mock code than on
the live library, so I'm punting on it for now.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../jgit/treewalk/FileTreeIteratorTest.java        |  167 ++++++++++++++++++++
 1 files changed, 167 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/FileTreeIteratorTest.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/FileTreeIteratorTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/FileTreeIteratorTest.java
new file mode 100644
index 0000000..ca31991
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/FileTreeIteratorTest.java
@@ -0,0 +1,167 @@
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
+package org.spearce.jgit.treewalk;
+
+import java.io.File;
+import java.security.MessageDigest;
+
+import org.spearce.jgit.lib.Constants;
+import org.spearce.jgit.lib.FileMode;
+import org.spearce.jgit.lib.ObjectId;
+import org.spearce.jgit.lib.RepositoryTestCase;
+import org.spearce.jgit.util.RawParseUtils;
+
+public class FileTreeIteratorTest extends RepositoryTestCase {
+	private final String[] paths = { "a.", "a.b", "a/b", "a0b" };
+
+	private long[] mtime;
+
+	public void setUp() throws Exception {
+		super.setUp();
+
+		// We build the entries backwards so that on POSIX systems we
+		// are likely to get the entries in the trash directory in the
+		// opposite order of what they should be in for the iteration.
+		// This should stress the sorting code better than doing it in
+		// the correct order.
+		//
+		mtime = new long[paths.length];
+		for (int i = paths.length - 1; i >= 0; i--) {
+			final String s = paths[i];
+			writeTrashFile(s, s);
+			mtime[i] = new File(trash, s).lastModified();
+		}
+	}
+
+	public void testEmptyIfRootIsFile() throws Exception {
+		final File r = new File(trash, paths[0]);
+		assertTrue(r.isFile());
+		final FileTreeIterator fti = new FileTreeIterator(r);
+		assertTrue(fti.first());
+		assertTrue(fti.eof());
+	}
+
+	public void testEmptyIfRootDoesNotExist() throws Exception {
+		final File r = new File(trash, "not-existing-file");
+		assertFalse(r.exists());
+		final FileTreeIterator fti = new FileTreeIterator(r);
+		assertTrue(fti.first());
+		assertTrue(fti.eof());
+	}
+
+	public void testEmptyIfRootIsEmpty() throws Exception {
+		final File r = new File(trash, "not-existing-file");
+		assertFalse(r.exists());
+		r.mkdir();
+		assertTrue(r.isDirectory());
+
+		final FileTreeIterator fti = new FileTreeIterator(r);
+		assertTrue(fti.first());
+		assertTrue(fti.eof());
+	}
+
+	public void testSimpleIterate() throws Exception {
+		final FileTreeIterator top = new FileTreeIterator(trash);
+
+		assertTrue(top.first());
+		assertFalse(top.eof());
+		assertEquals(FileMode.REGULAR_FILE.getBits(), top.mode);
+		assertEquals(paths[0], nameOf(top));
+		assertEquals(paths[0].length(), top.getEntryLength());
+		assertEquals(mtime[0], top.getEntryLastModified());
+
+		top.next(1);
+		assertFalse(top.first());
+		assertFalse(top.eof());
+		assertEquals(FileMode.REGULAR_FILE.getBits(), top.mode);
+		assertEquals(paths[1], nameOf(top));
+		assertEquals(paths[1].length(), top.getEntryLength());
+		assertEquals(mtime[1], top.getEntryLastModified());
+
+		top.next(1);
+		assertFalse(top.first());
+		assertFalse(top.eof());
+		assertEquals(FileMode.TREE.getBits(), top.mode);
+
+		final AbstractTreeIterator sub = top.createSubtreeIterator(db);
+		assertTrue(sub instanceof FileTreeIterator);
+		final FileTreeIterator subfti = (FileTreeIterator) sub;
+		assertTrue(sub.first());
+		assertFalse(sub.eof());
+		assertEquals(paths[2], nameOf(sub));
+		assertEquals(paths[2].length(), subfti.getEntryLength());
+		assertEquals(mtime[2], subfti.getEntryLastModified());
+
+		sub.next(1);
+		assertTrue(sub.eof());
+
+		top.next(1);
+		assertFalse(top.first());
+		assertFalse(top.eof());
+		assertEquals(FileMode.REGULAR_FILE.getBits(), top.mode);
+		assertEquals(paths[3], nameOf(top));
+		assertEquals(paths[3].length(), top.getEntryLength());
+		assertEquals(mtime[3], top.getEntryLastModified());
+
+		top.next(1);
+		assertTrue(top.eof());
+	}
+
+	public void testComputeFileObjectId() throws Exception {
+		final FileTreeIterator top = new FileTreeIterator(trash);
+
+		final MessageDigest md = Constants.newMessageDigest();
+		md.update(Constants.encodeASCII(Constants.TYPE_BLOB));
+		md.update((byte) ' ');
+		md.update(Constants.encodeASCII(paths[0].length()));
+		md.update((byte) 0);
+		md.update(Constants.encode(paths[0]));
+		final ObjectId expect = ObjectId.fromRaw(md.digest());
+
+		assertEquals(expect, top.getEntryObjectId());
+
+		// Verify it was cached by removing the file and getting it again.
+		//
+		new File(trash, paths[0]).delete();
+		assertEquals(expect, top.getEntryObjectId());
+	}
+
+	private static String nameOf(final AbstractTreeIterator i) {
+		return RawParseUtils.decode(Constants.CHARSET, i.path, 0, i.pathLen);
+	}
+}
-- 
1.6.0.174.gd789c

From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH] Support path names longer than 4095 bytes in DirCache
Date: Tue, 19 Aug 2008 15:51:54 -0700
Message-ID: <1219186314-24048-2-git-send-email-spearce@spearce.org>
References: <1219186314-24048-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Aug 20 00:53:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVa4U-0002rL-AH
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 00:53:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752416AbYHSWv7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 18:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752579AbYHSWv7
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 18:51:59 -0400
Received: from george.spearce.org ([209.20.77.23]:50451 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751649AbYHSWv4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 18:51:56 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 4068B38376; Tue, 19 Aug 2008 22:51:56 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 6CD4F38375;
	Tue, 19 Aug 2008 22:51:55 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.96.g2fad1.dirty
In-Reply-To: <1219186314-24048-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92930>

C Git supports long paths within the index file by setting the
length portion of the flags field to 4095 (0xfff) and then it
does a simple C strlen() on the remaining part of the string
to locate the first null byte.

The trick works because every index record must have between
1 and 8 null bytes trailing the entry as padding.  C Git had
this rule to make it easy to pass the mmap'd name portion of
an entry directly to system calls, and it helped to ensure
all members were aligned properly in memory.

We now support infinite length paths (well, up to 2GB) by
using the same encoding strategy, however paths under the
4095 limit still perform better as they do not require a
single byte read loop and a growing/shrinking byte buffer.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../jgit/dircache/DirCacheLargePathTest.java       |  106 ++++++++++++++++++++
 .../org/spearce/jgit/dircache/DirCacheEntry.java   |   39 ++++++--
 2 files changed, 136 insertions(+), 9 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheLargePathTest.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheLargePathTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheLargePathTest.java
new file mode 100644
index 0000000..4ea286c
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheLargePathTest.java
@@ -0,0 +1,106 @@
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
+package org.spearce.jgit.dircache;
+
+import java.io.IOException;
+
+import org.spearce.jgit.errors.CorruptObjectException;
+import org.spearce.jgit.lib.RepositoryTestCase;
+
+public class DirCacheLargePathTest extends RepositoryTestCase {
+	public void testPath_4090() throws Exception {
+		testLongPath(4090);
+	}
+
+	public void testPath_4094() throws Exception {
+		testLongPath(4094);
+	}
+
+	public void testPath_4095() throws Exception {
+		testLongPath(4095);
+	}
+
+	public void testPath_4096() throws Exception {
+		testLongPath(4096);
+	}
+
+	public void testPath_16384() throws Exception {
+		testLongPath(16384);
+	}
+
+	private void testLongPath(final int len) throws CorruptObjectException,
+			IOException {
+		final String longPath = makeLongPath(len);
+		final String shortPath = "~~~ shorter-path";
+
+		final DirCacheEntry longEnt = new DirCacheEntry(longPath);
+		final DirCacheEntry shortEnt = new DirCacheEntry(shortPath);
+		assertEquals(longPath, longEnt.getPathString());
+		assertEquals(shortPath, shortEnt.getPathString());
+
+		{
+			final DirCache dc1 = DirCache.lock(db);
+			{
+				final DirCacheBuilder b = dc1.builder();
+				b.add(longEnt);
+				b.add(shortEnt);
+				assertTrue(b.commit());
+			}
+			assertEquals(2, dc1.getEntryCount());
+			assertSame(longEnt, dc1.getEntry(0));
+			assertSame(shortEnt, dc1.getEntry(1));
+		}
+		{
+			final DirCache dc2 = DirCache.read(db);
+			assertEquals(2, dc2.getEntryCount());
+
+			assertNotSame(longEnt, dc2.getEntry(0));
+			assertEquals(longPath, dc2.getEntry(0).getPathString());
+
+			assertNotSame(shortEnt, dc2.getEntry(1));
+			assertEquals(shortPath, dc2.getEntry(1).getPathString());
+		}
+	}
+
+	private static String makeLongPath(final int len) {
+		final StringBuilder r = new StringBuilder(len);
+		for (int i = 0; i < len; i++)
+			r.append('a' + (i % 26));
+		return r.toString();
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheEntry.java b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheEntry.java
index 011bc16..dbd74b5 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheEntry.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheEntry.java
@@ -37,6 +37,8 @@
 
 package org.spearce.jgit.dircache;
 
+import java.io.ByteArrayOutputStream;
+import java.io.EOFException;
 import java.io.IOException;
 import java.io.InputStream;
 import java.io.OutputStream;
@@ -105,18 +107,36 @@ DirCacheEntry(final byte[] sharedInfo, final int infoAt,
 		NB.readFully(in, info, infoOffset, INFO_LEN);
 
 		int pathLen = NB.decodeUInt16(info, infoOffset + P_FLAGS) & NAME_MASK;
-		if (pathLen == NAME_MASK)
-			throw new IOException("Path name too long for jgit");
-		path = new byte[pathLen];
-		NB.readFully(in, path, 0, pathLen);
+		int skipped = 0;
+		if (pathLen < NAME_MASK) {
+			path = new byte[pathLen];
+			NB.readFully(in, path, 0, pathLen);
+		} else {
+			final ByteArrayOutputStream tmp = new ByteArrayOutputStream();
+			{
+				final byte[] buf = new byte[NAME_MASK];
+				NB.readFully(in, buf, 0, NAME_MASK);
+				tmp.write(buf);
+			}
+			for (;;) {
+				final int c = in.read();
+				if (c < 0)
+					throw new EOFException("Short read of block.");
+				if (c == 0)
+					break;
+				tmp.write(c);
+			}
+			path = tmp.toByteArray();
+			pathLen = path.length;
+			skipped = 1; // we already skipped 1 '\0' above to break the loop.
+		}
 
 		// Index records are padded out to the next 8 byte alignment
 		// for historical reasons related to how C Git read the files.
 		//
 		final int actLen = INFO_LEN + pathLen;
 		final int expLen = (actLen + 8) & ~7;
-		if (actLen != expLen)
-			NB.skipFully(in, expLen - actLen);
+		NB.skipFully(in, expLen - actLen - skipped);
 	}
 
 	/**
@@ -140,9 +160,10 @@ public DirCacheEntry(final byte[] newPath) {
 		infoOffset = 0;
 
 		path = newPath;
-		if (path.length >= NAME_MASK)
-			throw new IllegalArgumentException("Path name too long for jgit");
-		NB.encodeInt16(info, infoOffset + P_FLAGS, path.length);
+		if (path.length < NAME_MASK)
+			NB.encodeInt16(info, infoOffset + P_FLAGS, path.length);
+		else
+			NB.encodeInt16(info, infoOffset + P_FLAGS, NAME_MASK);
 	}
 
 	void write(final OutputStream os) throws IOException {
-- 
1.6.0.96.g2fad1.dirty

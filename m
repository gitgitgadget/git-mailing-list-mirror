From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 04/10] Add writeTree support to DirCache
Date: Thu, 22 Jan 2009 15:28:04 -0800
Message-ID: <1232666890-23488-5-git-send-email-spearce@spearce.org>
References: <1232666890-23488-1-git-send-email-spearce@spearce.org>
 <1232666890-23488-2-git-send-email-spearce@spearce.org>
 <1232666890-23488-3-git-send-email-spearce@spearce.org>
 <1232666890-23488-4-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 00:30:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQ90L-0008Aq-Pj
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 00:30:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758456AbZAVX20 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 18:28:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758325AbZAVX2X
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 18:28:23 -0500
Received: from george.spearce.org ([209.20.77.23]:55227 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755526AbZAVX2P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 18:28:15 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 3E83738265; Thu, 22 Jan 2009 23:28:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id D368E38210;
	Thu, 22 Jan 2009 23:28:12 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.399.g0d272
In-Reply-To: <1232666890-23488-4-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106795>

This way we can write a full tree from the DirCache, including reusing
any valid tree entries stored within the 'TREE' cache extension.  By
reusing those entries we can avoid generating the tree objects that
are already stored in the Git repository.

The algorithm may cause up to 3 passes over the DirCache entries:

 * Pass 1: Compute the tree structure
 * Pass 2: Compute the sizes of each tree
 * Pass 3: Write the tree object to the object store

These extra passes cause more CPU time to be expended in exchange
for a lower memory requirement during the tree writing.  The code
is only formatting the lowest level leaf tree which has not yet
been written to the object store, so higher level trees do not
occupy memory while they are waiting for the leaves to write out.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/dircache/DirCache.java    |   20 ++++
 .../org/spearce/jgit/dircache/DirCacheTree.java    |  115 ++++++++++++++++++++
 .../spearce/jgit/errors/UnmergedPathException.java |   67 ++++++++++++
 .../src/org/spearce/jgit/lib/FileMode.java         |    7 ++
 .../src/org/spearce/jgit/lib/ObjectWriter.java     |   12 ++-
 5 files changed, 219 insertions(+), 2 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/errors/UnmergedPathException.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCache.java b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCache.java
index 76657c4..b3c57ad 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCache.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCache.java
@@ -51,8 +51,11 @@
 import java.util.Comparator;
 
 import org.spearce.jgit.errors.CorruptObjectException;
+import org.spearce.jgit.errors.UnmergedPathException;
 import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.LockFile;
+import org.spearce.jgit.lib.ObjectId;
+import org.spearce.jgit.lib.ObjectWriter;
 import org.spearce.jgit.lib.Repository;
 import org.spearce.jgit.util.MutableInteger;
 import org.spearce.jgit.util.NB;
@@ -692,4 +695,21 @@ public DirCacheTree getCacheTree(final boolean build) {
 		}
 		return tree;
 	}
+
+	/**
+	 * Write all index trees to the object store, returning the root tree.
+	 * 
+	 * @param ow
+	 *            the writer to use when serializing to the store.
+	 * @return identity for the root tree.
+	 * @throws UnmergedPathException
+	 *             one or more paths contain higher-order stages (stage > 0),
+	 *             which cannot be stored in a tree object.
+	 * @throws IOException
+	 *             an unexpected error occurred writing to the object store.
+	 */
+	public ObjectId writeTree(final ObjectWriter ow)
+			throws UnmergedPathException, IOException {
+		return getCacheTree(true).writeTree(sortedEntries, 0, 0, ow);
+	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheTree.java b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheTree.java
index 26b6348..cf96ded 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheTree.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheTree.java
@@ -1,5 +1,6 @@
 /*
  * Copyright (C) 2008, Shawn O. Pearce <spearce@spearce.org>
+ * Copyright (C) 2008, Google Inc.
  *
  * All rights reserved.
  *
@@ -37,14 +38,20 @@
 
 package org.spearce.jgit.dircache;
 
+import static org.spearce.jgit.lib.Constants.OBJECT_ID_LENGTH;
+
+import java.io.ByteArrayOutputStream;
 import java.io.IOException;
 import java.io.OutputStream;
 import java.nio.ByteBuffer;
 import java.util.Arrays;
 import java.util.Comparator;
 
+import org.spearce.jgit.errors.UnmergedPathException;
 import org.spearce.jgit.lib.Constants;
+import org.spearce.jgit.lib.FileMode;
 import org.spearce.jgit.lib.ObjectId;
+import org.spearce.jgit.lib.ObjectWriter;
 import org.spearce.jgit.util.MutableInteger;
 import org.spearce.jgit.util.RawParseUtils;
 
@@ -273,6 +280,114 @@ public String getPathString() {
 		return r.toString();
 	}
 
+	/**
+	 * Write (if necessary) this tree to the object store.
+	 * 
+	 * @param cache
+	 *            the complete cache from DirCache.
+	 * @param cIdx
+	 *            first position of <code>cache</code> that is a member of this
+	 *            tree. The path of <code>cache[cacheIdx].path</code> for the
+	 *            range <code>[0,pathOff-1)</code> matches the complete path of
+	 *            this tree, from the root of the repository.
+	 * @param pathOffset
+	 *            number of bytes of <code>cache[cacheIdx].path</code> that
+	 *            matches this tree's path. The value at array position
+	 *            <code>cache[cacheIdx].path[pathOff-1]</code> is always '/' if
+	 *            <code>pathOff</code> is > 0.
+	 * @param ow
+	 *            the writer to use when serializing to the store.
+	 * @return identity of this tree.
+	 * @throws UnmergedPathException
+	 *             one or more paths contain higher-order stages (stage > 0),
+	 *             which cannot be stored in a tree object.
+	 * @throws IOException
+	 *             an unexpected error occurred writing to the object store.
+	 */
+	ObjectId writeTree(final DirCacheEntry[] cache, int cIdx,
+			final int pathOffset, final ObjectWriter ow)
+			throws UnmergedPathException, IOException {
+		if (id == null) {
+			final int endIdx = cIdx + entrySpan;
+			final int size = computeSize(cache, cIdx, pathOffset, ow);
+			final ByteArrayOutputStream out = new ByteArrayOutputStream(size);
+			int childIdx = 0;
+			int entryIdx = cIdx;
+
+			while (entryIdx < endIdx) {
+				final DirCacheEntry e = cache[entryIdx];
+				final byte[] ep = e.path;
+				if (childIdx < childCnt) {
+					final DirCacheTree st = children[childIdx];
+					if (st.contains(ep, pathOffset, ep.length)) {
+						FileMode.TREE.copyTo(out);
+						out.write(' ');
+						out.write(st.encodedName);
+						out.write(0);
+						st.id.copyRawTo(out);
+
+						entryIdx += st.entrySpan;
+						childIdx++;
+						continue;
+					}
+				}
+
+				e.getFileMode().copyTo(out);
+				out.write(' ');
+				out.write(ep, pathOffset, ep.length - pathOffset);
+				out.write(0);
+				out.write(e.idBuffer(), e.idOffset(), OBJECT_ID_LENGTH);
+				entryIdx++;
+			}
+
+			id = ow.writeCanonicalTree(out.toByteArray());
+		}
+		return id;
+	}
+
+	private int computeSize(final DirCacheEntry[] cache, int cIdx,
+			final int pathOffset, final ObjectWriter ow)
+			throws UnmergedPathException, IOException {
+		final int endIdx = cIdx + entrySpan;
+		int childIdx = 0;
+		int entryIdx = cIdx;
+		int size = 0;
+
+		while (entryIdx < endIdx) {
+			final DirCacheEntry e = cache[entryIdx];
+			if (e.getStage() != 0)
+				throw new UnmergedPathException(e);
+
+			final byte[] ep = e.path;
+			if (childIdx < childCnt) {
+				final DirCacheTree st = children[childIdx];
+				if (st.contains(ep, pathOffset, ep.length)) {
+					final int stOffset = pathOffset + st.nameLength() + 1;
+					st.writeTree(cache, entryIdx, stOffset, ow);
+
+					size += FileMode.TREE.copyToLength();
+					size += st.nameLength();
+					size += OBJECT_ID_LENGTH + 2;
+
+					entryIdx += st.entrySpan;
+					childIdx++;
+					continue;
+				}
+			}
+
+			final FileMode mode = e.getFileMode();
+			if (mode.getObjectType() == Constants.OBJ_BAD)
+				throw new UnmergedPathException(e);
+
+			size += mode.copyToLength();
+			size += ep.length - pathOffset;
+			size += OBJECT_ID_LENGTH + 2;
+			entryIdx++;
+		}
+
+		return size;
+	}
+
 	private void appendName(final StringBuilder r) {
 		if (parent != null) {
 			parent.appendName(r);
diff --git a/org.spearce.jgit/src/org/spearce/jgit/errors/UnmergedPathException.java b/org.spearce.jgit/src/org/spearce/jgit/errors/UnmergedPathException.java
new file mode 100644
index 0000000..17a3965
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/errors/UnmergedPathException.java
@@ -0,0 +1,67 @@
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
+package org.spearce.jgit.errors;
+
+import java.io.IOException;
+
+import org.spearce.jgit.dircache.DirCacheEntry;
+
+/**
+ * Indicates one or more paths in a DirCache have non-zero stages present.
+ */
+public class UnmergedPathException extends IOException {
+	private static final long serialVersionUID = 1L;
+
+	private final DirCacheEntry entry;
+
+	/**
+	 * Create a new unmerged path exception.
+	 * 
+	 * @param dce
+	 *            the first non-zero stage of the unmerged path.
+	 */
+	public UnmergedPathException(final DirCacheEntry dce) {
+		super("Unmerged path: " + dce.getPathString());
+		entry = dce;
+	}
+
+	/** @return the first non-zero stage of the unmerged path */
+	public DirCacheEntry getDirCacheEntry() {
+		return entry;
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/FileMode.java b/org.spearce.jgit/src/org/spearce/jgit/lib/FileMode.java
index fe5f2f6..cf42f37 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/FileMode.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/FileMode.java
@@ -191,6 +191,13 @@ public void copyTo(final OutputStream os) throws IOException {
 	}
 
 	/**
+	 * @return the number of bytes written by {@link #copyTo(OutputStream)}.
+	 */
+	public int copyToLength() {
+		return octalBytes.length;
+	}
+
+	/**
 	 * Get the object type that should appear for this type of mode.
 	 * <p>
 	 * See the object type constants in {@link Constants}.
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectWriter.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectWriter.java
index e84798a..546cc68 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectWriter.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectWriter.java
@@ -155,10 +155,18 @@ public ObjectId writeTree(final Tree t) throws IOException {
 			o.write(0);
 			id.copyRawTo(o);
 		}
-		return writeTree(o.toByteArray());
+		return writeCanonicalTree(o.toByteArray());
 	}
 
-	private ObjectId writeTree(final byte[] b) throws IOException {
+	/**
+	 * Write a canonical tree to the object database.
+	 *
+	 * @param b
+	 *            the canonical encoding of the tree object.
+	 * @return SHA-1 of the tree
+	 * @throws IOException
+	 */
+	public ObjectId writeCanonicalTree(final byte[] b) throws IOException {
 		return writeTree(b.length, new ByteArrayInputStream(b));
 	}
 
-- 
1.6.1.399.g0d272

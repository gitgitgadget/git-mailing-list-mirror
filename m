From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [EGIT PATCH 10/26] Support the 'TREE' extension in .git/index through DirCache
Date: Mon, 11 Aug 2008 18:07:57 -0700
Message-ID: <1218503293-14057-11-git-send-email-spearce@spearce.org>
References: <1218503293-14057-1-git-send-email-spearce@spearce.org>
 <1218503293-14057-2-git-send-email-spearce@spearce.org>
 <1218503293-14057-3-git-send-email-spearce@spearce.org>
 <1218503293-14057-4-git-send-email-spearce@spearce.org>
 <1218503293-14057-5-git-send-email-spearce@spearce.org>
 <1218503293-14057-6-git-send-email-spearce@spearce.org>
 <1218503293-14057-7-git-send-email-spearce@spearce.org>
 <1218503293-14057-8-git-send-email-spearce@spearce.org>
 <1218503293-14057-9-git-send-email-spearce@spearce.org>
 <1218503293-14057-10-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Aug 12 03:10:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSiPS-0006OQ-WA
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 03:10:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751651AbYHLBIk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 21:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751466AbYHLBIh
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 21:08:37 -0400
Received: from george.spearce.org ([209.20.77.23]:38586 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751181AbYHLBIV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 21:08:21 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id D81AA3841C; Tue, 12 Aug 2008 01:08:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 5403938378;
	Tue, 12 Aug 2008 01:08:16 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.rc2.22.g71b99
In-Reply-To: <1218503293-14057-10-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92035>

We now support reading and writing the 'TREE' extension of the 'DIRC'
file format.  C Git uses this as an optional extension to cache the
SHA-1 id of each tree object used by the index, permitting C Git to
identify subsections of the repository which have not been modified
and to speed up the git-write-tree plumbing command prior to making
a commit object.

Our support includes constructing the tree objects if they do not
exist, but we don't write them to the object database.  This change
only builds the ranges within the index file and marks them invalid,
so C Git knows that the tree must be generated and saved into the
object database before it can rely upon it in a commit.

Like the DirCacheEntry objects we try to avoid unnecessary encode
and decode operations during reads and writes as they would just
drag down the processor.

Our sort ordering of the 'TREE' data is different from that of C Git.
C Git sorts tree children according to lengths of path names, as the
actual order was not relevant but Junio wanted a stable ordering.  We
want our tree children sorted by name so we can merge-sort them onto
the main index entries.  That means we may have to sort the children
after we read them from disk; at least that is true if C Git was the
last process to write the index file.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/dircache/DirCache.java    |   46 ++
 .../org/spearce/jgit/dircache/DirCacheTree.java    |  453 ++++++++++++++++++++
 2 files changed, 499 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheTree.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCache.java b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCache.java
index 248e2a2..b5fdd46 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCache.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCache.java
@@ -54,7 +54,9 @@ import org.spearce.jgit.errors.CorruptObjectException;
 import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.LockFile;
 import org.spearce.jgit.lib.Repository;
+import org.spearce.jgit.util.MutableInteger;
 import org.spearce.jgit.util.NB;
+import org.spearce.jgit.util.TemporaryBuffer;
 
 /**
  * Support for the Git dircache (aka index file).
@@ -72,6 +74,8 @@ import org.spearce.jgit.util.NB;
 public class DirCache {
 	private static final byte[] SIG_DIRC = { 'D', 'I', 'R', 'C' };
 
+	private static final int EXT_TREE = 0x54524545 /* 'TREE' */;
+
 	private static final int INFO_LEN = DirCacheEntry.INFO_LEN;
 
 	private static final DirCacheEntry[] NO_ENTRIES = {};
@@ -211,6 +215,9 @@ public class DirCache {
 	/** Number of positions within {@link #sortedEntries} that are valid. */
 	private int entryCnt;
 
+	/** Cache tree for this index; null if the cache tree is not available. */
+	private DirCacheTree tree;
+
 	/** Our active lock (if we hold it); null if we don't have it locked. */
 	private LockFile myLock;
 
@@ -272,6 +279,7 @@ public class DirCache {
 		lastModified = 0;
 		sortedEntries = NO_ENTRIES;
 		entryCnt = 0;
+		tree = null;
 	}
 
 	private void readFrom(final FileInputStream inStream) throws IOException,
@@ -306,6 +314,12 @@ public class DirCache {
 		while (fd.position() - in.available() < sizeOnDisk - 20) {
 			NB.readFully(in, hdr, 0, 8);
 			switch (NB.decodeInt32(hdr, 0)) {
+			case EXT_TREE: {
+				final byte[] raw = new byte[NB.decodeInt32(hdr, 4)];
+				NB.readFully(in, raw, 0, raw.length);
+				tree = new DirCacheTree(raw, new MutableInteger(), null);
+				break;
+			}
 			default:
 				if (hdr[0] >= 'A' && hdr[0] <= 'Z') {
 					// The extension is optional and is here only as
@@ -417,6 +431,17 @@ public class DirCache {
 			}
 		}
 
+		if (tree != null) {
+			final TemporaryBuffer bb = new TemporaryBuffer();
+			tree.write(tmp, bb);
+			bb.close();
+
+			NB.encodeInt32(tmp, 0, EXT_TREE);
+			NB.encodeInt32(tmp, 4, (int) bb.length());
+			dos.write(tmp, 0, 8);
+			bb.writeTo(dos, null);
+		}
+
 		os.write(foot.digest());
 		os.close();
 	}
@@ -565,4 +590,25 @@ public class DirCache {
 		final int i = findEntry(path);
 		return i < 0 ? null : sortedEntries[i];
 	}
+
+	/**
+	 * Obtain (or build) the current cache tree structure.
+	 * <p>
+	 * This method can optionally recreate the cache tree, without flushing the
+	 * tree objects themselves to disk.
+	 * 
+	 * @param build
+	 *            if true and the cache tree is not present in the index it will
+	 *            be generated and returned to the caller.
+	 * @return the cache tree; null if there is no current cache tree available
+	 *         and <code>build</code> was false.
+	 */
+	public DirCacheTree getCacheTree(final boolean build) {
+		if (build) {
+			if (tree == null)
+				tree = new DirCacheTree();
+			tree.validate(sortedEntries, entryCnt, 0, 0);
+		}
+		return tree;
+	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheTree.java b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheTree.java
new file mode 100644
index 0000000..d06be08
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheTree.java
@@ -0,0 +1,453 @@
+/*
+ * Copyright (C) 2008, Shawn O. Pearce <spearce@spearce.org>
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
+import java.io.OutputStream;
+import java.nio.ByteBuffer;
+import java.util.Arrays;
+import java.util.Comparator;
+
+import org.spearce.jgit.lib.Constants;
+import org.spearce.jgit.lib.ObjectId;
+import org.spearce.jgit.util.MutableInteger;
+import org.spearce.jgit.util.RawParseUtils;
+
+/**
+ * Single tree record from the 'TREE' {@link DirCache} extension.
+ * <p>
+ * A valid cache tree record contains the object id of a tree object and the
+ * total number of {@link DirCacheEntry} instances (counted recursively) from
+ * the DirCache contained within the tree. This information facilitates faster
+ * traversal of the index and quicker generation of tree objects prior to
+ * creating a new commit.
+ * <p>
+ * An invalid cache tree record indicates a known subtree whose file entries
+ * have changed in ways that cause the tree to no longer have a known object id.
+ * Invalid cache tree records must be revalidated prior to use.
+ */
+public class DirCacheTree {
+	private static final byte[] NO_NAME = {};
+
+	private static final DirCacheTree[] NO_CHILDREN = {};
+
+	private static final Comparator<DirCacheTree> TREE_CMP = new Comparator<DirCacheTree>() {
+		public int compare(final DirCacheTree o1, final DirCacheTree o2) {
+			final byte[] a = o1.encodedName;
+			final byte[] b = o2.encodedName;
+			final int aLen = a.length;
+			final int bLen = b.length;
+			int cPos;
+			for (cPos = 0; cPos < aLen && cPos < bLen; cPos++) {
+				final int cmp = (a[cPos] & 0xff) - (b[cPos] & 0xff);
+				if (cmp != 0)
+					return cmp;
+			}
+			if (aLen == bLen)
+				return 0;
+			if (aLen < bLen)
+				return '/' - (b[cPos] & 0xff);
+			return (a[cPos] & 0xff) - '/';
+		}
+	};
+
+	/** Tree this tree resides in; null if we are the root. */
+	private DirCacheTree parent;
+
+	/** Name of this tree within its parent. */
+	private byte[] encodedName;
+
+	/** Number of {@link DirCacheEntry} records that belong to this tree. */
+	private int entrySpan;
+
+	/** Unique SHA-1 of this tree; null if invalid. */
+	private ObjectId id;
+
+	/** Child trees, if any, sorted by {@link #encodedName}. */
+	private DirCacheTree[] children;
+
+	/** Number of valid children in {@link #children}. */
+	private int childCnt;
+
+	DirCacheTree() {
+		encodedName = NO_NAME;
+		children = NO_CHILDREN;
+		childCnt = 0;
+		entrySpan = -1;
+	}
+
+	private DirCacheTree(final DirCacheTree myParent, final byte[] path,
+			final int pathOff, final int pathLen) {
+		parent = myParent;
+		encodedName = new byte[pathLen];
+		System.arraycopy(path, pathOff, encodedName, 0, pathLen);
+		children = NO_CHILDREN;
+		childCnt = 0;
+		entrySpan = -1;
+	}
+
+	DirCacheTree(final byte[] in, final MutableInteger off,
+			final DirCacheTree myParent) {
+		parent = myParent;
+
+		int ptr = RawParseUtils.next(in, off.value, '\0');
+		final int nameLen = ptr - off.value - 1;
+		if (nameLen > 0) {
+			encodedName = new byte[nameLen];
+			System.arraycopy(in, off.value, encodedName, 0, nameLen);
+		} else
+			encodedName = NO_NAME;
+
+		entrySpan = RawParseUtils.parseBase10(in, ptr, off);
+		final int subcnt = RawParseUtils.parseBase10(in, off.value, off);
+		off.value = RawParseUtils.next(in, off.value, '\n');
+
+		if (entrySpan >= 0) {
+			// Valid trees have a positive entry count and an id of a
+			// tree object that should exist in the object database.
+			//
+			id = ObjectId.fromRaw(in, off.value);
+			off.value += Constants.OBJECT_ID_LENGTH;
+		}
+
+		if (subcnt > 0) {
+			boolean alreadySorted = true;
+			children = new DirCacheTree[subcnt];
+			for (int i = 0; i < subcnt; i++) {
+				children[i] = new DirCacheTree(in, off, this);
+
+				// C Git's ordering differs from our own; it prefers to
+				// sort by length first. This sometimes produces a sort
+				// we do not desire. On the other hand it may have been
+				// created by us, and be sorted the way we want.
+				//
+				if (alreadySorted && i > 0
+						&& TREE_CMP.compare(children[i - 1], children[i]) > 0)
+					alreadySorted = false;
+			}
+			if (!alreadySorted)
+				Arrays.sort(children, 0, subcnt, TREE_CMP);
+		} else {
+			// Leaf level trees have no children, only (file) entries.
+			//
+			children = NO_CHILDREN;
+		}
+		childCnt = subcnt;
+	}
+
+	void write(final byte[] tmp, final OutputStream os) throws IOException {
+		int ptr = tmp.length;
+		tmp[--ptr] = '\n';
+		ptr = RawParseUtils.formatBase10(tmp, ptr, childCnt);
+		tmp[--ptr] = ' ';
+		ptr = RawParseUtils.formatBase10(tmp, ptr, isValid() ? entrySpan : -1);
+		tmp[--ptr] = 0;
+
+		os.write(encodedName);
+		os.write(tmp, ptr, tmp.length - ptr);
+		if (isValid()) {
+			id.copyRawTo(tmp, 0);
+			os.write(tmp, 0, Constants.OBJECT_ID_LENGTH);
+		}
+		for (int i = 0; i < childCnt; i++)
+			children[i].write(tmp, os);
+	}
+
+	/**
+	 * Determine if this cache is currently valid.
+	 * <p>
+	 * A valid cache tree knows how many {@link DirCacheEntry} instances from
+	 * the parent {@link DirCache} reside within this tree (recursively
+	 * enumerated). It also knows the object id of the tree, as the tree should
+	 * be readily available from the repository's object database.
+	 * 
+	 * @return true if this tree is knows key details about itself; false if the
+	 *         tree needs to be regenerated.
+	 */
+	public boolean isValid() {
+		return id != null;
+	}
+
+	/**
+	 * Get the number of entries this tree spans within the DirCache.
+	 * <p>
+	 * If this tree is not valid (see {@link #isValid()}) this method's return
+	 * value is always strictly negative (less than 0) but is otherwise an
+	 * undefined result.
+	 * 
+	 * @return total number of entries (recursively) contained within this tree.
+	 */
+	public int getEntrySpan() {
+		return entrySpan;
+	}
+
+	/**
+	 * Get the number of cached subtrees contained within this tree.
+	 * 
+	 * @return number of child trees available through this tree.
+	 */
+	public int getChildCount() {
+		return childCnt;
+	}
+
+	/**
+	 * Get the i-th child cache tree.
+	 * 
+	 * @param i
+	 *            index of the child to obtain.
+	 * @return the child tree.
+	 */
+	public DirCacheTree getChild(final int i) {
+		return children[i];
+	}
+
+	ObjectId getObjectId() {
+		return id;
+	}
+
+	/**
+	 * Get the tree's name within its parent.
+	 * <p>
+	 * This method is not very efficient and is primarily meant for debugging
+	 * and final output generation. Applications should try to avoid calling it,
+	 * and if invoked do so only once per interesting entry, where the name is
+	 * absolutely required for correct function.
+	 * 
+	 * @return name of the tree. This does not contain any '/' characters.
+	 */
+	public String getNameString() {
+		final ByteBuffer bb = ByteBuffer.wrap(encodedName);
+		return Constants.CHARSET.decode(bb).toString();
+	}
+
+	/**
+	 * Get the tree's path within the repository.
+	 * <p>
+	 * This method is not very efficient and is primarily meant for debugging
+	 * and final output generation. Applications should try to avoid calling it,
+	 * and if invoked do so only once per interesting entry, where the name is
+	 * absolutely required for correct function.
+	 * 
+	 * @return path of the tree, relative to the repository root. If this is not
+	 *         the root tree the path ends with '/'. The root tree's path string
+	 *         is the empty string ("").
+	 */
+	public String getPathString() {
+		final StringBuilder r = new StringBuilder();
+		appendName(r);
+		return r.toString();
+	}
+
+	private void appendName(final StringBuilder r) {
+		if (parent != null) {
+			parent.appendName(r);
+			r.append(getNameString());
+			r.append('/');
+		} else if (nameLength() > 0) {
+			r.append(getNameString());
+			r.append('/');
+		}
+	}
+
+	final int nameLength() {
+		return encodedName.length;
+	}
+
+	final boolean contains(final byte[] a, int aOff, final int aLen) {
+		final byte[] e = encodedName;
+		final int eLen = e.length;
+		for (int eOff = 0; eOff < eLen && aOff < aLen; eOff++, aOff++)
+			if (e[eOff] != a[aOff])
+				return false;
+		if (aOff == aLen)
+			return false;
+		return a[aOff] == '/';
+	}
+
+	/**
+	 * Update (if necessary) this tree's entrySpan.
+	 * 
+	 * @param cache
+	 *            the complete cache from DirCache.
+	 * @param cCnt
+	 *            number of entries in <code>cache</code> that are valid for
+	 *            iteration.
+	 * @param cIdx
+	 *            first position of <code>cache</code> that is a member of this
+	 *            tree. The path of <code>cache[cacheIdx].path</code> for the
+	 *            range <code>[0,pathOff-1)</code> matches the complete path of
+	 *            this tree, from the root of the repository.
+	 * @param pathOff
+	 *            number of bytes of <code>cache[cacheIdx].path</code> that
+	 *            matches this tree's path. The value at array position
+	 *            <code>cache[cacheIdx].path[pathOff-1]</code> is always '/' if
+	 *            <code>pathOff</code> is > 0.
+	 */
+	void validate(final DirCacheEntry[] cache, final int cCnt, int cIdx,
+			final int pathOff) {
+		if (entrySpan >= 0) {
+			// If we are valid, our children are also valid.
+			// We have no need to validate them.
+			//
+			return;
+		}
+
+		entrySpan = 0;
+		if (cCnt == 0) {
+			// Special case of an empty index, and we are the root tree.
+			//
+			return;
+		}
+
+		final byte[] firstPath = cache[cIdx].path;
+		int stIdx = 0;
+		while (cIdx < cCnt) {
+			final byte[] currPath = cache[cIdx].path;
+			if (pathOff > 0 && !peq(firstPath, currPath, pathOff)) {
+				// The current entry is no longer in this tree. Our
+				// span is updated and the remainder goes elsewhere.
+				//
+				break;
+			}
+
+			DirCacheTree st = stIdx < childCnt ? children[stIdx] : null;
+			final int cc = namecmp(currPath, pathOff, st);
+			if (cc > 0) {
+				// This subtree is now empty.
+				//
+				removeChild(stIdx);
+				continue;
+			}
+
+			if (cc < 0) {
+				final int p = slash(currPath, pathOff);
+				if (p < 0) {
+					// The entry has no '/' and thus is directly in this
+					// tree. Count it as one of our own.
+					//
+					cIdx++;
+					entrySpan++;
+					continue;
+				}
+
+				// Build a new subtree for this entry.
+				//
+				st = new DirCacheTree(this, currPath, pathOff, p - pathOff);
+				insertChild(stIdx, st);
+			}
+
+			// The entry is contained in this subtree.
+			//
+			st.validate(cache, cCnt, cIdx, pathOff + st.nameLength() + 1);
+			cIdx += st.entrySpan;
+			entrySpan += st.entrySpan;
+			stIdx++;
+		}
+
+		if (stIdx < childCnt) {
+			// None of our remaining children can be in this tree
+			// as the current cache entry is after our own name.
+			//
+			final DirCacheTree[] dct = new DirCacheTree[stIdx];
+			System.arraycopy(children, 0, dct, 0, stIdx);
+			children = dct;
+		}
+	}
+
+	private void insertChild(final int stIdx, final DirCacheTree st) {
+		final DirCacheTree[] c = children;
+		if (childCnt + 1 <= c.length) {
+			if (stIdx < childCnt)
+				System.arraycopy(c, stIdx, c, stIdx + 1, childCnt - stIdx);
+			c[stIdx] = st;
+			childCnt++;
+			return;
+		}
+
+		final int n = c.length;
+		final DirCacheTree[] a = new DirCacheTree[n + 1];
+		if (stIdx > 0)
+			System.arraycopy(c, 0, a, 0, stIdx);
+		a[stIdx] = st;
+		if (stIdx < n)
+			System.arraycopy(c, stIdx, a, stIdx + 1, n - stIdx);
+		children = a;
+		childCnt++;
+	}
+
+	private void removeChild(final int stIdx) {
+		final int n = --childCnt;
+		if (stIdx < n)
+			System.arraycopy(children, stIdx + 1, children, stIdx, n - stIdx);
+		children[n] = null;
+	}
+
+	static boolean peq(final byte[] a, final byte[] b, int aLen) {
+		if (b.length < aLen)
+			return false;
+		for (aLen--; aLen >= 0; aLen--)
+			if (a[aLen] != b[aLen])
+				return false;
+		return true;
+	}
+
+	private static int namecmp(final byte[] a, int aPos, final DirCacheTree ct) {
+		if (ct == null)
+			return -1;
+		final byte[] b = ct.encodedName;
+		final int aLen = a.length;
+		final int bLen = b.length;
+		int bPos = 0;
+		for (; aPos < aLen && bPos < bLen; aPos++, bPos++) {
+			final int cmp = (a[aPos] & 0xff) - (b[bPos] & 0xff);
+			if (cmp != 0)
+				return cmp;
+		}
+		if (bPos == bLen)
+			return a[aPos] == '/' ? 0 : -1;
+		return aLen - bLen;
+	}
+
+	private static int slash(final byte[] a, int aPos) {
+		final int aLen = a.length;
+		for (; aPos < aLen; aPos++)
+			if (a[aPos] == '/')
+				return aPos;
+		return -1;
+	}
+}
-- 
1.6.0.rc2.22.g71b99

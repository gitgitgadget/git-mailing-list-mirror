From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [EGIT PATCH 06/26] Implement a new .git/index (aka dircache) read interface
Date: Mon, 11 Aug 2008 18:07:53 -0700
Message-ID: <1218503293-14057-7-git-send-email-spearce@spearce.org>
References: <1218503293-14057-1-git-send-email-spearce@spearce.org>
 <1218503293-14057-2-git-send-email-spearce@spearce.org>
 <1218503293-14057-3-git-send-email-spearce@spearce.org>
 <1218503293-14057-4-git-send-email-spearce@spearce.org>
 <1218503293-14057-5-git-send-email-spearce@spearce.org>
 <1218503293-14057-6-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Aug 12 03:11:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSiPQ-0006OQ-JG
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 03:10:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751516AbYHLBIc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 21:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbYHLBIa
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 21:08:30 -0400
Received: from george.spearce.org ([209.20.77.23]:38573 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750987AbYHLBIT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 21:08:19 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id D9D9A38395; Tue, 12 Aug 2008 01:08:17 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 2080D38376;
	Tue, 12 Aug 2008 01:08:15 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.rc2.22.g71b99
In-Reply-To: <1218503293-14057-6-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92056>

This is a smaller (and faster) .git/index file reader and it will be
an eventual replacement for the current GitIndex class.

We silently skip optional extensions, which means we silently skip the
current 'TREE' extension.  We also fail out if we identify a required
extension which we do not support.

Most of each index entry is held in a shared byte[] as we do not need
most of the fields in jgit, due to Java's lack of a POSIX lstat like
utility.  This makes it more efficient for us to read the C Git index
format as we can avoid expending a lot of CPU on decode calls during
the file read.

Lookup is handled by binary searching against the encoded paths, as
this lines up better with how TreeWalk and its TreeFilters operate.
Most of the time when we are looking for something in the index it
is a quick read-find+update-write cycle affecting only a handful of
paths.  Avoiding any unnecessary byte[]->String->byte[] translations
during these operations performance.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/dircache/DirCache.java    |  385 ++++++++++++++++++++
 .../org/spearce/jgit/dircache/DirCacheEntry.java   |  270 ++++++++++++++
 2 files changed, 655 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/dircache/DirCache.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheEntry.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCache.java b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCache.java
new file mode 100644
index 0000000..f8ca60d
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCache.java
@@ -0,0 +1,385 @@
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
+import java.io.BufferedInputStream;
+import java.io.File;
+import java.io.FileInputStream;
+import java.io.FileNotFoundException;
+import java.io.IOException;
+import java.nio.ByteBuffer;
+import java.nio.channels.FileChannel;
+import java.util.Comparator;
+
+import org.spearce.jgit.errors.CorruptObjectException;
+import org.spearce.jgit.lib.Constants;
+import org.spearce.jgit.lib.Repository;
+import org.spearce.jgit.util.NB;
+
+/**
+ * Support for the Git dircache (aka index file).
+ * <p>
+ * The index file keeps track of which objects are currently checked out in the
+ * working directory, and the last modified time of those working files. Changes
+ * in the working directory can be detected by comparing the modification times
+ * to the cached modification time within the index file.
+ * <p>
+ * Index files are also used during merges, where the merge happens within the
+ * index file first, and the working directory is updated as a post-merge step.
+ * Conflicts are stored in the index file to allow tool (and human) based
+ * resolutions to be easily performed.
+ */
+public class DirCache {
+	private static final byte[] SIG_DIRC = { 'D', 'I', 'R', 'C' };
+
+	private static final int INFO_LEN = DirCacheEntry.INFO_LEN;
+
+	private static final DirCacheEntry[] NO_ENTRIES = {};
+
+	static final Comparator<DirCacheEntry> ENT_CMP = new Comparator<DirCacheEntry>() {
+		public int compare(final DirCacheEntry o1, final DirCacheEntry o2) {
+			final int cr = cmp(o1, o2);
+			if (cr != 0)
+				return cr;
+			return o1.getStage() - o2.getStage();
+		}
+	};
+
+	static int cmp(final DirCacheEntry a, final DirCacheEntry b) {
+		return cmp(a.path, a.path.length, b);
+	}
+
+	static int cmp(final byte[] aPath, final int aLen, final DirCacheEntry b) {
+		return cmp(aPath, aLen, b.path, b.path.length);
+	}
+
+	static int cmp(final byte[] aPath, final int aLen, final byte[] bPath,
+			final int bLen) {
+		for (int cPos = 0; cPos < aLen && cPos < bLen; cPos++) {
+			final int cmp = (aPath[cPos] & 0xff) - (bPath[cPos] & 0xff);
+			if (cmp != 0)
+				return cmp;
+		}
+		return aLen - bLen;
+	}
+
+	/**
+	 * Create a new in-core index representation and read an index from disk.
+	 * <p>
+	 * The new index will be read before it is returned to the caller. Read
+	 * failures are reported as exceptions and therefore prevent the method from
+	 * returning a partially populated index.
+	 * 
+	 * @param indexLocation
+	 *            location of the index file on disk.
+	 * @return a cache representing the contents of the specified index file (if
+	 *         it exists) or an empty cache if the file does not exist.
+	 * @throws IOException
+	 *             the index file is present but could not be read.
+	 * @throws CorruptObjectException
+	 *             the index file is using a format or extension that this
+	 *             library does not support.
+	 */
+	public static DirCache read(final File indexLocation)
+			throws CorruptObjectException, IOException {
+		final DirCache c = new DirCache(indexLocation);
+		c.read();
+		return c;
+	}
+
+	/**
+	 * Create a new in-core index representation and read an index from disk.
+	 * <p>
+	 * The new index will be read before it is returned to the caller. Read
+	 * failures are reported as exceptions and therefore prevent the method from
+	 * returning a partially populated index.
+	 * 
+	 * @param db
+	 *            repository the caller wants to read the default index of.
+	 * @return a cache representing the contents of the specified index file (if
+	 *         it exists) or an empty cache if the file does not exist.
+	 * @throws IOException
+	 *             the index file is present but could not be read.
+	 * @throws CorruptObjectException
+	 *             the index file is using a format or extension that this
+	 *             library does not support.
+	 */
+	public static DirCache read(final Repository db)
+			throws CorruptObjectException, IOException {
+		return read(new File(db.getDirectory(), "index"));
+	}
+
+	/** Location of the current version of the index file. */
+	private final File liveFile;
+
+	/** Modification time of the file at the last read/write we did. */
+	private long lastModified;
+
+	/** Individual file index entries, sorted by path name. */
+	private DirCacheEntry[] sortedEntries;
+
+	/** Number of positions within {@link #sortedEntries} that are valid. */
+	private int entryCnt;
+
+	/**
+	 * Create a new in-core index representation.
+	 * <p>
+	 * The new index will be empty. Callers may wish to read from the on disk
+	 * file first with {@link #read()}.
+	 * 
+	 * @param indexLocation
+	 *            location of the index file on disk.
+	 */
+	public DirCache(final File indexLocation) {
+		liveFile = indexLocation;
+		clear();
+	}
+
+	/**
+	 * Read the index from disk, if it has changed on disk.
+	 * <p>
+	 * This method tries to avoid loading the index if it has not changed since
+	 * the last time we consulted it. A missing index file will be treated as
+	 * though it were present but had no file entries in it.
+	 * 
+	 * @throws IOException
+	 *             the index file is present but could not be read. This
+	 *             DirCache instance may not be populated correctly.
+	 * @throws CorruptObjectException
+	 *             the index file is using a format or extension that this
+	 *             library does not support.
+	 */
+	public void read() throws IOException, CorruptObjectException {
+		if (!liveFile.exists())
+			clear();
+		else if (liveFile.lastModified() != lastModified) {
+			try {
+				final FileInputStream inStream = new FileInputStream(liveFile);
+				try {
+					clear();
+					readFrom(inStream);
+				} finally {
+					try {
+						inStream.close();
+					} catch (IOException err2) {
+						// Ignore any close failures.
+					}
+				}
+			} catch (FileNotFoundException fnfe) {
+				// Someone must have deleted it between our exists test
+				// and actually opening the path. That's fine, its empty.
+				//
+				clear();
+			}
+		}
+	}
+
+	/** Empty this index, removing all entries. */
+	public void clear() {
+		lastModified = 0;
+		sortedEntries = NO_ENTRIES;
+		entryCnt = 0;
+	}
+
+	private void readFrom(final FileInputStream inStream) throws IOException,
+			CorruptObjectException {
+		final FileChannel fd = inStream.getChannel();
+		final long sizeOnDisk = fd.size();
+		final BufferedInputStream in = new BufferedInputStream(inStream);
+
+		// Read the index header and verify we understand it.
+		//
+		final byte[] hdr = new byte[12];
+		NB.readFully(in, hdr, 0, 12);
+		if (!is_DIRC(hdr))
+			throw new CorruptObjectException("Not a DIRC file.");
+		final int ver = NB.decodeInt32(hdr, 4);
+		if (ver != 2)
+			throw new CorruptObjectException("Unknown DIRC version " + ver);
+		entryCnt = NB.decodeInt32(hdr, 8);
+		if (entryCnt < 0)
+			throw new CorruptObjectException("DIRC has too many entries.");
+
+		// Load the individual file entries.
+		//
+		final byte[] infos = new byte[INFO_LEN * entryCnt];
+		sortedEntries = new DirCacheEntry[entryCnt];
+		for (int i = 0; i < entryCnt; i++)
+			sortedEntries[i] = new DirCacheEntry(infos, i * INFO_LEN, in);
+		lastModified = liveFile.lastModified();
+
+		// After the file entries are index extensions.
+		//
+		while (fd.position() - in.available() < sizeOnDisk - 20) {
+			NB.readFully(in, hdr, 0, 8);
+			switch (NB.decodeInt32(hdr, 0)) {
+			default:
+				if (hdr[0] >= 'A' && hdr[0] <= 'Z') {
+					// The extension is optional and is here only as
+					// a performance optimization. Since we do not
+					// understand it, we can safely skip past it.
+					//
+					in.skip(NB.decodeInt32(hdr, 4));
+				} else {
+					// The extension is not an optimization and is
+					// _required_ to understand this index format.
+					// Since we did not trap it above we must abort.
+					//
+					throw new CorruptObjectException("DIRC extension '"
+							+ Constants.CHARSET.decode(
+									ByteBuffer.wrap(hdr, 0, 4)).toString()
+							+ "' not supported by this version.");
+				}
+			}
+		}
+	}
+
+	private static boolean is_DIRC(final byte[] hdr) {
+		if (hdr.length < SIG_DIRC.length)
+			return false;
+		for (int i = 0; i < SIG_DIRC.length; i++)
+			if (hdr[i] != SIG_DIRC[i])
+				return false;
+		return true;
+	}
+
+	/**
+	 * Locate the position a path's entry is at in the index.
+	 * <p>
+	 * If there is at least one entry in the index for this path the position of
+	 * the lowest stage is returned. Subsequent stages can be identified by
+	 * testing consecutive entries until the path differs.
+	 * <p>
+	 * If no path matches the entry -(position+1) is returned, where position is
+	 * the location it would have gone within the index.
+	 * 
+	 * @param path
+	 *            the path to search for.
+	 * @return if >= 0 then the return value is the position of the entry in the
+	 *         index; pass to {@link #getEntry(int)} to obtain the entry
+	 *         information. If < 0 the entry does not exist in the index.
+	 */
+	public int findEntry(final String path) {
+		if (entryCnt == 0)
+			return -1;
+		final byte[] p = Constants.encode(path);
+		return findEntry(p, p.length);
+	}
+
+	int findEntry(final byte[] p, final int pLen) {
+		int low = 0;
+		int high = entryCnt;
+		do {
+			int mid = (low + high) >> 1;
+			final int cmp = cmp(p, pLen, sortedEntries[mid]);
+			if (cmp < 0)
+				high = mid;
+			else if (cmp == 0) {
+				while (mid > 0 && cmp(p, pLen, sortedEntries[mid - 1]) == 0)
+					mid--;
+				return mid;
+			} else
+				low = mid + 1;
+		} while (low < high);
+		return -(low + 1);
+	}
+
+	/**
+	 * Determine the next index position past all entries with the same name.
+	 * <p>
+	 * As index entries are sorted by path name, then stage number, this method
+	 * advances the supplied position to the first position in the index whose
+	 * path name does not match the path name of the supplied position's entry.
+	 * 
+	 * @param position
+	 *            entry position of the path that should be skipped.
+	 * @return position of the next entry whose path is after the input.
+	 */
+	public int nextEntry(final int position) {
+		DirCacheEntry last = sortedEntries[position];
+		int nextIdx = position + 1;
+		while (nextIdx < entryCnt) {
+			final DirCacheEntry next = sortedEntries[nextIdx];
+			if (cmp(last, next) != 0)
+				break;
+			last = next;
+			nextIdx++;
+		}
+		return nextIdx;
+	}
+
+	/**
+	 * Total number of file entries stored in the index.
+	 * <p>
+	 * This count includes unmerged stages for a file entry if the file is
+	 * currently conflicted in a merge. This means the total number of entries
+	 * in the index may be up to 3 times larger than the number of files in the
+	 * working directory.
+	 * <p>
+	 * Note that this value counts only <i>files</i>.
+	 * 
+	 * @return number of entries available.
+	 * @see #getEntry(int)
+	 */
+	public int getEntryCount() {
+		return entryCnt;
+	}
+
+	/**
+	 * Get a specific entry.
+	 * 
+	 * @param i
+	 *            position of the entry to get.
+	 * @return the entry at position <code>i</code>.
+	 */
+	public DirCacheEntry getEntry(final int i) {
+		return sortedEntries[i];
+	}
+
+	/**
+	 * Get a specific entry.
+	 * 
+	 * @param path
+	 *            the path to search for.
+	 * @return the entry at position <code>i</code>.
+	 */
+	public DirCacheEntry getEntry(final String path) {
+		final int i = findEntry(path);
+		return i < 0 ? null : sortedEntries[i];
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheEntry.java b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheEntry.java
new file mode 100644
index 0000000..7efab48
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheEntry.java
@@ -0,0 +1,270 @@
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
+import java.io.InputStream;
+import java.nio.ByteBuffer;
+
+import org.spearce.jgit.lib.Constants;
+import org.spearce.jgit.lib.FileMode;
+import org.spearce.jgit.lib.ObjectId;
+import org.spearce.jgit.util.NB;
+
+/**
+ * A single file (or stage of a file) in a {@link DirCache}.
+ * <p>
+ * An entry represents exactly one stage of a file. If a file path is unmerged
+ * then multiple DirCacheEntry instances may appear for the same path name.
+ */
+public class DirCacheEntry {
+	// private static final int P_CTIME = 0;
+
+	// private static final int P_CTIME_NSEC = 4;
+
+	private static final int P_MTIME = 8;
+
+	// private static final int P_MTIME_NSEC = 12;
+
+	// private static final int P_DEV = 16;
+
+	// private static final int P_INO = 20;
+
+	private static final int P_MODE = 24;
+
+	// private static final int P_UID = 28;
+
+	// private static final int P_GID = 32;
+
+	private static final int P_SIZE = 36;
+
+	private static final int P_OBJECTID = 40;
+
+	private static final int P_FLAGS = 60;
+
+	static final int INFO_LEN = 62;
+
+	private static final int ASSUME_VALID = 0x80;
+
+	/** (Possibly shared) header information storage. */
+	private final byte[] info;
+
+	/** First location within {@link #info} where our header starts. */
+	private final int infoOffset;
+
+	/** Our encoded path name, from the root of the repository. */
+	final byte[] path;
+
+	DirCacheEntry(final byte[] sharedInfo, final int infoAt,
+			final InputStream in) throws IOException {
+		info = sharedInfo;
+		infoOffset = infoAt;
+
+		NB.readFully(in, info, infoOffset, INFO_LEN);
+
+		int pathLen = NB.decodeUInt16(info, infoOffset + P_FLAGS) & 0xfff;
+		path = new byte[pathLen];
+		NB.readFully(in, path, 0, pathLen);
+
+		// Index records are padded out to the next 8 byte alignment
+		// for historical reasons related to how C Git read the files.
+		//
+		final int actLen = INFO_LEN + pathLen;
+		final int expLen = (actLen + 8) & ~7;
+		if (actLen != expLen)
+			in.skip(expLen - actLen);
+	}
+
+	final byte[] idBuffer() {
+		return info;
+	}
+
+	final int idOffset() {
+		return infoOffset + P_OBJECTID;
+	}
+
+	/**
+	 * Is this entry always thought to be unmodified?
+	 * <p>
+	 * Most entries in the index do not have this flag set. Users may however
+	 * set them on if the file system stat() costs are too high on this working
+	 * directory, such as on NFS or SMB volumes.
+	 * 
+	 * @return true if we must assume the entry is unmodified.
+	 */
+	public boolean isAssumeValid() {
+		return (info[infoOffset + P_FLAGS] & ASSUME_VALID) != 0;
+	}
+
+	/**
+	 * Set the assume valid flag for this entry,
+	 * 
+	 * @param assume
+	 *            true to ignore apparent modifications; false to look at last
+	 *            modified to detect file modifications.
+	 */
+	public void setAssumeValid(final boolean assume) {
+		if (assume)
+			info[infoOffset + P_FLAGS] |= ASSUME_VALID;
+		else
+			info[infoOffset + P_FLAGS] &= ~ASSUME_VALID;
+	}
+
+	/**
+	 * Get the stage of this entry.
+	 * <p>
+	 * Entries have one of 4 possible stages: 0-3.
+	 * 
+	 * @return the stage of this entry.
+	 */
+	public int getStage() {
+		return (info[infoOffset + P_FLAGS] >>> 4) & 0x3;
+	}
+
+	/**
+	 * Obtain the raw {@link FileMode} bits for this entry.
+	 * 
+	 * @return mode bits for the entry.
+	 * @see FileMode#fromBits(int)
+	 */
+	public int getRawMode() {
+		return NB.decodeInt32(info, infoOffset + P_MODE);
+	}
+
+	/**
+	 * Set the file mode for this entry.
+	 * 
+	 * @param mode
+	 *            the new mode constant.
+	 */
+	public void setFileMode(final FileMode mode) {
+		NB.encodeInt32(info, infoOffset + P_MODE, mode.getBits());
+	}
+
+	/**
+	 * Get the cached last modification date of this file, in milliseconds.
+	 * <p>
+	 * One of the indicators that the file has been modified by an application
+	 * changing the working tree is if the last modification time for the file
+	 * differs from the time stored in this entry.
+	 * 
+	 * @return last modification time of this file, in milliseconds since the
+	 *         Java epoch (midnight Jan 1, 1970 UTC).
+	 */
+	public long getLastModified() {
+		return decodeTS(P_MTIME);
+	}
+
+	/**
+	 * Set the cached last modification date of this file, using milliseconds.
+	 * 
+	 * @param when
+	 *            new cached modification date of the file, in milliseconds.
+	 */
+	public void setLastModified(final long when) {
+		encodeTS(P_MTIME, when);
+	}
+
+	/**
+	 * Get the cached size (in bytes) of this file.
+	 * <p>
+	 * One of the indicators that the file has been modified by an application
+	 * changing the working tree is if the size of the file (in bytes) differs
+	 * from the size stored in this entry.
+	 * <p>
+	 * Note that this is the length of the file in the working directory, which
+	 * may differ from the size of the decompressed blob if work tree filters
+	 * are being used, such as LF<->CRLF conversion.
+	 * 
+	 * @return cached size of the working directory file, in bytes.
+	 */
+	public int getLength() {
+		return NB.decodeInt32(info, infoOffset + P_SIZE);
+	}
+
+	/**
+	 * Set the cached size (in bytes) of this file.
+	 * 
+	 * @param sz
+	 *            new cached size of the file, as bytes.
+	 */
+	public void setLength(final int sz) {
+		NB.encodeInt32(info, infoOffset + P_SIZE, sz);
+	}
+
+	/**
+	 * Obtain the ObjectId for the entry.
+	 * <p>
+	 * Using this method to compare ObjectId values between entries is
+	 * inefficient as it causes memory allocation.
+	 * 
+	 * @return object identifier for the entry.
+	 */
+	public ObjectId getObjectId() {
+		return ObjectId.fromRaw(idBuffer(), idOffset());
+	}
+
+	/**
+	 * Get the entry's complete path.
+	 * <p>
+	 * This method is not very efficient and is primarily meant for debugging
+	 * and final output generation. Applications should try to avoid calling it,
+	 * and if invoked do so only once per interesting entry, where the name is
+	 * absolutely required for correct function.
+	 * 
+	 * @return complete path of the entry, from the root of the repository. If
+	 *         the entry is in a subtree there will be at least one '/' in the
+	 *         returned string.
+	 */
+	public String getPathString() {
+		return Constants.CHARSET.decode(ByteBuffer.wrap(path)).toString();
+	}
+
+	private long decodeTS(final int pIdx) {
+		final int base = infoOffset + pIdx;
+		final int sec = NB.decodeInt32(info, base);
+		final int ms = NB.decodeInt32(info, base + 4) / 1000000;
+		return 1000L * sec + ms;
+	}
+
+	private void encodeTS(final int pIdx, final long when) {
+		final int base = infoOffset + pIdx;
+		NB.encodeInt32(info, base, (int) (when / 1000));
+		NB.encodeInt32(info, base + 4, ((int) (when % 1000)) * 1000000);
+	}
+}
-- 
1.6.0.rc2.22.g71b99

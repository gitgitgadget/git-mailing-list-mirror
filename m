From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH] Combine WindowedFile into PackFile to simplify the internals
Date: Wed, 22 Apr 2009 10:33:36 -0700
Message-ID: <1240421616-14662-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Apr 22 19:35:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwgLu-0006Id-Di
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 19:35:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752989AbZDVRdn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 13:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753583AbZDVRdm
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 13:33:42 -0400
Received: from george.spearce.org ([209.20.77.23]:42343 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219AbZDVRdk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 13:33:40 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 3BB9138215; Wed, 22 Apr 2009 17:33:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 38AE4381CE;
	Wed, 22 Apr 2009 17:33:37 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.rc1.205.g37f8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117220>

The only user of WindowedFile is PackFile, and it did so by making
an anonymous inner subclass within its constructor.  This is simply
too confusing to work with.  The two classes are tightly integrated
and work together to implement pack access.  Half of WindowedFile
is just exposing accessors for PackFile to call through.

Long ago both PackFile and PackIndex used WindowedFile to read
data on demand, so having the WindowedFile class made some degree
of sense.  But in 667a84b6997e9048e0771168c98d2ffbca791937 (almost 2
years ago) Robin changed the pack index data to be read in one shot,
as that performed better than paging in the index on demand.

Since that change, the only real user of WindowedFile has been
PackFile.  Its time they got married and reduced the overall
complexity of the library internals.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/ByteArrayWindow.java  |    9 +-
 .../src/org/spearce/jgit/lib/ByteBufferWindow.java |    4 +-
 .../src/org/spearce/jgit/lib/ByteWindow.java       |   12 +-
 .../src/org/spearce/jgit/lib/PackFile.java         |  201 ++++++++---
 .../org/spearce/jgit/lib/UnpackedObjectCache.java  |   10 +-
 .../src/org/spearce/jgit/lib/WindowCache.java      |   14 +-
 .../src/org/spearce/jgit/lib/WindowCursor.java     |   14 +-
 .../src/org/spearce/jgit/lib/WindowedFile.java     |  355 --------------------
 8 files changed, 176 insertions(+), 443 deletions(-)
 delete mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/WindowedFile.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ByteArrayWindow.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ByteArrayWindow.java
index c07a260..5dc3d28 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/ByteArrayWindow.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ByteArrayWindow.java
@@ -53,17 +53,16 @@
 	 * Constructor for ByteWindow.
 	 * 
 	 * @param o
-	 *            the WindowedFile providing data access
+	 *            the PackFile providing data access
 	 * @param p
 	 *            the file offset.
 	 * @param d
-	 *            an id provided by the WindowedFile. See
-	 *            {@link WindowCache#get(WindowCursor, WindowedFile, long)}.
+	 *            an id provided by the PackFile. See
+	 *            {@link WindowCache#get(WindowCursor, PackFile, long)}.
 	 * @param b
 	 *            byte array for storage
 	 */
-	ByteArrayWindow(final WindowedFile o, final long p, final int d,
-			final byte[] b) {
+	ByteArrayWindow(final PackFile o, final long p, final int d, final byte[] b) {
 		super(o, p, d, b, b.length);
 	}
 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ByteBufferWindow.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ByteBufferWindow.java
index 5beb79b..01956fd 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/ByteBufferWindow.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ByteBufferWindow.java
@@ -53,12 +53,12 @@
 	 *
 	 * @See ByteWindow
 	 *
-	 * @param o The WindowedFile
+	 * @param o The PackFile
 	 * @param p the file offset.
 	 * @param d Window id
 	 * @param b ByteBuffer storage
 	 */
-	ByteBufferWindow(final WindowedFile o, final long p, final int d,
+	ByteBufferWindow(final PackFile o, final long p, final int d,
 			final ByteBuffer b) {
 		super(o, p, d, b, b.capacity());
 	}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ByteWindow.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ByteWindow.java
index e957138..0d01fca 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/ByteWindow.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ByteWindow.java
@@ -64,7 +64,7 @@
 
 	ByteWindow<?> lruNext;
 
-	final WindowedFile provider;
+	final PackFile provider;
 
 	final int id;
 
@@ -78,19 +78,19 @@
 	 * Constructor for ByteWindow.
 	 * 
 	 * @param o
-	 *            the WindowedFile providing data access
+	 *            the PackFile providing data access
 	 * @param pos
 	 *            the position in the file the data comes from.
 	 * @param d
-	 *            an id provided by the WindowedFile. See
-	 *            {@link WindowCache#get(WindowCursor, WindowedFile, long)}.
+	 *            an id provided by the PackFile. See
+	 *            {@link WindowCache#get(WindowCursor, PackFile, long)}.
 	 * @param ref
 	 *            the object value required to perform data access.
 	 * @param sz
 	 *            the total number of bytes in this window.
 	 */
 	@SuppressWarnings("unchecked")
-	ByteWindow(final WindowedFile o, final long pos, final int d, final T ref,
+	ByteWindow(final PackFile o, final long pos, final int d, final T ref,
 			final int sz) {
 		super(ref, (ReferenceQueue<T>) WindowCache.clearedWindowQueue);
 		provider = o;
@@ -100,7 +100,7 @@ ByteWindow(final WindowedFile o, final long pos, final int d, final T ref,
 		end = start + size;
 	}
 
-	final boolean contains(final WindowedFile neededFile, final long neededPos) {
+	final boolean contains(final PackFile neededFile, final long neededPos) {
 		return provider == neededFile && start <= neededPos && neededPos < end;
 	}
 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
index 74ffef8..dccc067 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
@@ -42,6 +42,9 @@
 import java.io.File;
 import java.io.IOException;
 import java.io.OutputStream;
+import java.io.RandomAccessFile;
+import java.nio.MappedByteBuffer;
+import java.nio.channels.FileChannel.MapMode;
 import java.util.Arrays;
 import java.util.Collections;
 import java.util.Comparator;
@@ -53,6 +56,7 @@
 import org.spearce.jgit.errors.CorruptObjectException;
 import org.spearce.jgit.errors.PackMismatchException;
 import org.spearce.jgit.util.NB;
+import org.spearce.jgit.util.RawParseUtils;
 
 /**
  * A Git version 2 pack file representation. A pack file contains Git objects in
@@ -69,7 +73,16 @@ public int compare(final PackFile a, final PackFile b) {
 
 	private final File idxFile;
 
-	private final WindowedFile pack;
+	private final File packFile;
+
+	final int hash;
+
+	RandomAccessFile fd;
+
+	long length;
+
+	/** Total number of windows actively in the associated cache. */
+	int openCount;
 
 	private int packLastModified;
 
@@ -89,18 +102,14 @@ public int compare(final PackFile a, final PackFile b) {
 	 */
 	public PackFile(final File idxFile, final File packFile) {
 		this.idxFile = idxFile;
+		this.packFile = packFile;
 		this.packLastModified = (int) (packFile.lastModified() >> 10);
-		pack = new WindowedFile(packFile) {
-			@Override
-			protected void onOpen() throws IOException {
-				try {
-					onOpenPack();
-				} catch (IOException e) {
-					invalid = true;
-					throw e;
-				}
-			}
-		};
+
+		// Multiply by 31 here so we can more directly combine with another
+		// value in WindowCache.hash(), without doing the multiply there.
+		//
+		hash = System.identityHashCode(this) * 31;
+		length = Long.MAX_VALUE;
 	}
 
 	private synchronized PackIndex idx() throws IOException {
@@ -122,7 +131,7 @@ final PackedObjectLoader resolveBase(final WindowCursor curs, final long ofs)
 
 	/** @return the File object which locates this pack on disk. */
 	public File getPackFile() {
-		return pack.getFile();
+		return packFile;
 	}
 
 	/**
@@ -164,8 +173,8 @@ public PackedObjectLoader get(final WindowCursor curs, final AnyObjectId id)
 	 * Close the resources utilized by this repository
 	 */
 	public void close() {
-		UnpackedObjectCache.purge(pack);
-		pack.close();
+		UnpackedObjectCache.purge(this);
+		WindowCache.purge(this);
 		synchronized (this) {
 			loadedIdx = null;
 			reverseIdx = null;
@@ -219,17 +228,18 @@ ObjectId findObjectForOffset(final long offset) throws IOException {
 	}
 
 	final UnpackedObjectCache.Entry readCache(final long position) {
-		return UnpackedObjectCache.get(pack, position);
+		return UnpackedObjectCache.get(this, position);
 	}
 
 	final void saveCache(final long position, final byte[] data, final int type) {
-		UnpackedObjectCache.store(pack, position, data, type);
+		UnpackedObjectCache.store(this, position, data, type);
 	}
 
 	final byte[] decompress(final long position, final int totalSize,
 			final WindowCursor curs) throws DataFormatException, IOException {
 		final byte[] dstbuf = new byte[totalSize];
-		pack.readCompressed(position, dstbuf, curs);
+		if (curs.inflate(this, position, dstbuf, 0) != totalSize)
+			throw new EOFException("Short compressed stream at " + position);
 		return dstbuf;
 	}
 
@@ -245,15 +255,13 @@ final void copyRawData(final PackedObjectLoader loader,
 			final CRC32 crc = new CRC32();
 			int headerCnt = (int) (dataOffset - objectOffset);
 			while (headerCnt > 0) {
-				int toRead = Math.min(headerCnt, buf.length);
-				int read = pack.read(objectOffset, buf, 0, toRead, curs);
-				if (read != toRead)
-					throw new EOFException();
-				crc.update(buf, 0, read);
+				final int toRead = Math.min(headerCnt, buf.length);
+				readFully(objectOffset, buf, 0, toRead, curs);
+				crc.update(buf, 0, toRead);
 				headerCnt -= toRead;
 			}
 			final CheckedOutputStream crcOut = new CheckedOutputStream(out, crc);
-			pack.copyToStream(dataOffset, buf, cnt, crcOut, curs);
+			copyToStream(dataOffset, buf, cnt, crcOut, curs);
 			final long computed = crc.getValue();
 
 			final ObjectId id = findObjectForOffset(objectOffset);
@@ -263,7 +271,7 @@ final void copyRawData(final PackedObjectLoader loader,
 						+ " in " + getPackFile() + " has bad zlib stream");
 		} else {
 			try {
-				pack.verifyCompressed(dataOffset, curs);
+				curs.inflateVerify(this, dataOffset);
 			} catch (DataFormatException dfe) {
 				final CorruptObjectException coe;
 				coe = new CorruptObjectException("Object at " + dataOffset
@@ -271,7 +279,7 @@ final void copyRawData(final PackedObjectLoader loader,
 				coe.initCause(dfe);
 				throw coe;
 			}
-			pack.copyToStream(dataOffset, buf, cnt, out, curs);
+			copyToStream(dataOffset, buf, cnt, out, curs);
 		}
 	}
 
@@ -283,44 +291,127 @@ boolean invalid() {
 		return invalid;
 	}
 
+	private void readFully(final long position, final byte[] dstbuf,
+			int dstoff, final int cnt, final WindowCursor curs)
+			throws IOException {
+		if (curs.copy(this, position, dstbuf, dstoff, cnt) != cnt)
+			throw new EOFException();
+	}
+
+	private void copyToStream(long position, final byte[] buf, long cnt,
+			final OutputStream out, final WindowCursor curs)
+			throws IOException, EOFException {
+		while (cnt > 0) {
+			final int toRead = (int) Math.min(cnt, buf.length);
+			readFully(position, buf, 0, toRead, curs);
+			position += toRead;
+			cnt -= toRead;
+			out.write(buf, 0, toRead);
+		}
+	}
+
+	void cacheOpen() throws IOException {
+		fd = new RandomAccessFile(packFile, "r");
+		length = fd.length();
+		try {
+			onOpenPack();
+		} catch (IOException ioe) {
+			invalid = true;
+			cacheClose();
+			throw ioe;
+		} catch (RuntimeException re) {
+			invalid = true;
+			cacheClose();
+			throw re;
+		} catch (Error re) {
+			invalid = true;
+			cacheClose();
+			throw re;
+		}
+	}
+
+	void cacheClose() {
+		if (fd != null) {
+			try {
+				fd.close();
+			} catch (IOException err) {
+				// Ignore a close event. We had it open only for reading.
+				// There should not be errors related to network buffers
+				// not flushed, etc.
+			}
+			fd = null;
+		}
+	}
+
+	void allocWindow(final WindowCursor curs, final int windowId,
+			final long pos, final int size) {
+		if (WindowCache.mmap) {
+			MappedByteBuffer map;
+			try {
+				map = fd.getChannel().map(MapMode.READ_ONLY, pos, size);
+			} catch (IOException e) {
+				// The most likely reason this failed is the JVM has run out
+				// of virtual memory. We need to discard quickly, and try to
+				// force the GC to finalize and release any existing mappings.
+				try {
+					curs.release();
+					System.gc();
+					System.runFinalization();
+					map = fd.getChannel().map(MapMode.READ_ONLY, pos, size);
+				} catch (IOException ioe2) {
+					// Temporarily disable mmap and do buffered disk IO.
+					//
+					map = null;
+					System.err.println("warning: mmap failure: "+ioe2);
+				}
+			}
+			if (map != null) {
+				if (map.hasArray()) {
+					final byte[] b = map.array();
+					final ByteArrayWindow w;
+					w = new ByteArrayWindow(this, pos, windowId, b);
+					w.loaded = true;
+					curs.window = w;
+					curs.handle = b;
+				} else {
+					curs.window = new ByteBufferWindow(this, pos, windowId, map);
+					curs.handle = map;
+				}
+				return;
+			}
+		}
+
+		final byte[] b = new byte[size];
+		curs.window = new ByteArrayWindow(this, pos, windowId, b);
+		curs.handle = b;
+		openCount++; // Until the window loads, we must stay open.
+	}
+
 	private void onOpenPack() throws IOException {
 		final PackIndex idx = idx();
 		final WindowCursor curs = new WindowCursor();
-		long position = 0;
-		final byte[] sig = new byte[Constants.PACK_SIGNATURE.length];
-		final byte[] intbuf = new byte[4];
-		final long vers;
+		final byte[] buf = new byte[20];
 
-		if (pack.read(position, sig, curs) != Constants.PACK_SIGNATURE.length)
+		readFully(0, buf, 0, 12, curs);
+		if (RawParseUtils.match(buf, 0, Constants.PACK_SIGNATURE) != 4)
 			throw new IOException("Not a PACK file.");
-		for (int k = 0; k < Constants.PACK_SIGNATURE.length; k++) {
-			if (sig[k] != Constants.PACK_SIGNATURE[k])
-				throw new IOException("Not a PACK file.");
-		}
-		position += Constants.PACK_SIGNATURE.length;
-
-		pack.readFully(position, intbuf, curs);
-		vers = NB.decodeUInt32(intbuf, 0);
+		final long vers = NB.decodeUInt32(buf, 4);
+		final long packCnt = NB.decodeUInt32(buf, 8);
 		if (vers != 2 && vers != 3)
 			throw new IOException("Unsupported pack version " + vers + ".");
-		position += 4;
 
-		pack.readFully(position, intbuf, curs);
-		final long packCnt = NB.decodeUInt32(intbuf, 0);
-		final long idxCnt = idx.getObjectCount();
-		if (idxCnt != packCnt)
+		if (packCnt != idx.getObjectCount())
 			throw new PackMismatchException("Pack object count mismatch:"
 					+ " pack " + packCnt
-					+ " index " + idxCnt
-					+ ": " + pack.getName());
+					+ " index " + idx.getObjectCount()
+					+ ": " + getPackFile());
 
-		final byte[] csumbuf = new byte[20];
-		pack.readFully(pack.length() - 20, csumbuf, curs);
-		if (!Arrays.equals(csumbuf, idx.packChecksum))
+		readFully(length - 20, buf, 0, 20, curs);
+		if (!Arrays.equals(buf, idx.packChecksum))
 			throw new PackMismatchException("Pack checksum mismatch:"
-					+ " pack " + ObjectId.fromRaw(csumbuf).name()
+					+ " pack " + ObjectId.fromRaw(buf).name()
 					+ " index " + ObjectId.fromRaw(idx.packChecksum).name()
-					+ ": " + pack.getName());
+					+ ": " + getPackFile());
 	}
 
 	private PackedObjectLoader reader(final WindowCursor curs,
@@ -328,7 +419,7 @@ private PackedObjectLoader reader(final WindowCursor curs,
 		long pos = objOffset;
 		int p = 0;
 		final byte[] ib = curs.tempId;
-		pack.readFully(pos, ib, curs);
+		readFully(pos, ib, 0, 20, curs);
 		int c = ib[p++] & 0xff;
 		final int typeCode = (c >> 4) & 7;
 		long dataSize = c & 15;
@@ -349,7 +440,7 @@ private PackedObjectLoader reader(final WindowCursor curs,
 					typeCode, (int) dataSize);
 
 		case Constants.OBJ_OFS_DELTA: {
-			pack.readFully(pos, ib, curs);
+			readFully(pos, ib, 0, 20, curs);
 			p = 0;
 			c = ib[p++] & 0xff;
 			long ofs = c & 127;
@@ -363,7 +454,7 @@ private PackedObjectLoader reader(final WindowCursor curs,
 					objOffset, (int) dataSize, objOffset - ofs);
 		}
 		case Constants.OBJ_REF_DELTA: {
-			pack.readFully(pos, ib, curs);
+			readFully(pos, ib, 0, 20, curs);
 			return new DeltaRefPackedObjectLoader(curs, this, pos + ib.length,
 					objOffset, (int) dataSize, ObjectId.fromRaw(ib));
 		}
@@ -374,7 +465,7 @@ private PackedObjectLoader reader(final WindowCursor curs,
 
 	private long findEndOffset(final long startOffset)
 			throws IOException, CorruptObjectException {
-		final long maxOffset = pack.length() - Constants.OBJECT_ID_LENGTH;
+		final long maxOffset = length - 20;
 		return getReverseIdx().findNextOffset(startOffset, maxOffset);
 	}
 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/UnpackedObjectCache.java b/org.spearce.jgit/src/org/spearce/jgit/lib/UnpackedObjectCache.java
index 13861bf..3d76a90 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/UnpackedObjectCache.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/UnpackedObjectCache.java
@@ -75,7 +75,7 @@ static synchronized void reconfigure(final WindowCacheConfig cfg) {
 		}
 	}
 
-	static synchronized Entry get(final WindowedFile pack, final long position) {
+	static synchronized Entry get(final PackFile pack, final long position) {
 		final Slot e = cache[hash(position)];
 		if (e.provider == pack && e.position == position) {
 			final Entry buf = e.data.get();
@@ -87,8 +87,8 @@ static synchronized Entry get(final WindowedFile pack, final long position) {
 		return null;
 	}
 
-	static synchronized void store(final WindowedFile pack,
-			final long position, final byte[] data, final int objectType) {
+	static synchronized void store(final PackFile pack, final long position,
+			final byte[] data, final int objectType) {
 		if (data.length > maxByteCount)
 			return; // Too large to cache.
 
@@ -122,7 +122,7 @@ private static void releaseMemory() {
 		}
 	}
 
-	static synchronized void purge(final WindowedFile file) {
+	static synchronized void purge(final PackFile file) {
 		for (final Slot e : cache) {
 			if (e.provider == file) {
 				clearEntry(e);
@@ -178,7 +178,7 @@ Entry(final byte[] aData, final int aType) {
 
 		Slot lruNext;
 
-		WindowedFile provider;
+		PackFile provider;
 
 		long position;
 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java
index f755dad..03e531a 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java
@@ -217,14 +217,14 @@ else if (maxFileCount > cfg.getPackedGitOpenFiles()) {
 	 *             the window was not found in the cache and the given provider
 	 *             was unable to load the window on demand.
 	 */
-	public static final void get(final WindowCursor curs,
-			final WindowedFile wp, final long position) throws IOException {
+	public static final void get(final WindowCursor curs, final PackFile wp,
+			final long position) throws IOException {
 		getImpl(curs, wp, position);
 		curs.window.ensureLoaded(curs.handle);
 	}
 
 	private static synchronized final void getImpl(final WindowCursor curs,
-			final WindowedFile wp, final long position) throws IOException {
+			final PackFile wp, final long position) throws IOException {
 		final int id = (int) (position >> windowSizeShift);
 		final int idx = hash(wp, id);
 		for (ByteWindow<?> e = cache[idx]; e != null; e = e.chainNext) {
@@ -333,7 +333,7 @@ private static boolean isOverLimit() {
 	 *            the window provider whose windows should be removed from the
 	 *            cache.
 	 */
-	public static synchronized final void purge(final WindowedFile wp) {
+	public static synchronized final void purge(final PackFile wp) {
 		for (ByteWindow e : cache) {
 			for (; e != null; e = e.chainNext) {
 				if (e.provider == wp)
@@ -413,15 +413,15 @@ private static void insertLRU(final ByteWindow<?> e) {
 		lruHead = e;
 	}
 
-	private static int hash(final WindowedFile wp, final int id) {
+	private static int hash(final PackFile wp, final int id) {
 		// wp.hash was already "stirred up" a bit by * 31 when
 		// it was created. Its reasonable to just add here.
 		//
 		return ((wp.hash + id) >>> 1) % cache.length;
 	}
 
-	private static int windowSize(final WindowedFile file, final int id) {
-		final long len = file.length();
+	private static int windowSize(final PackFile file, final int id) {
+		final long len = file.length;
 		final long pos = id << windowSizeShift;
 		return len < pos + windowSize ? (int) (len - pos) : windowSize;
 	}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCursor.java b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCursor.java
index 363ec6d..fb9d348 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCursor.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCursor.java
@@ -74,9 +74,9 @@
 	 *             this cursor does not match the provider or id and the proper
 	 *             window could not be acquired through the provider's cache.
 	 */
-	int copy(final WindowedFile provider, long position, final byte[] dstbuf,
+	int copy(final PackFile provider, long position, final byte[] dstbuf,
 			int dstoff, final int cnt) throws IOException {
-		final long length = provider.length();
+		final long length = provider.length;
 		int need = cnt;
 		while (need > 0 && position < length) {
 			pin(provider, position);
@@ -109,9 +109,8 @@ int copy(final WindowedFile provider, long position, final byte[] dstbuf,
 	 *             the inflater encountered an invalid chunk of data. Data
 	 *             stream corruption is likely.
 	 */
-	int inflate(final WindowedFile provider, long position,
-			final byte[] dstbuf, int dstoff)
-			throws IOException, DataFormatException {
+	int inflate(final PackFile provider, long position, final byte[] dstbuf,
+			int dstoff) throws IOException, DataFormatException {
 		if (inf == null)
 			inf = InflaterCache.get();
 		else
@@ -125,7 +124,7 @@ int inflate(final WindowedFile provider, long position,
 		}
 	}
 
-	void inflateVerify(final WindowedFile provider, long position)
+	void inflateVerify(final PackFile provider, long position)
 			throws IOException, DataFormatException {
 		if (inf == null)
 			inf = InflaterCache.get();
@@ -140,8 +139,7 @@ void inflateVerify(final WindowedFile provider, long position)
 		}
 	}
 
-
-	private void pin(final WindowedFile provider, final long position)
+	private void pin(final PackFile provider, final long position)
 			throws IOException {
 		final ByteWindow w = window;
 		if (w == null || !w.contains(provider, position))
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowedFile.java b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowedFile.java
deleted file mode 100644
index 9293eb9..0000000
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowedFile.java
+++ /dev/null
@@ -1,355 +0,0 @@
-/*
- * Copyright (C) 2008, Shawn O. Pearce <spearce@spearce.org>
- *
- * All rights reserved.
- *
- * Redistribution and use in source and binary forms, with or
- * without modification, are permitted provided that the following
- * conditions are met:
- *
- * - Redistributions of source code must retain the above copyright
- *   notice, this list of conditions and the following disclaimer.
- *
- * - Redistributions in binary form must reproduce the above
- *   copyright notice, this list of conditions and the following
- *   disclaimer in the documentation and/or other materials provided
- *   with the distribution.
- *
- * - Neither the name of the Git Development Community nor the
- *   names of its contributors may be used to endorse or promote
- *   products derived from this software without specific prior
- *   written permission.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
- * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
- * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
- * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
- * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
- * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
- * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
- * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
- * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
- * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- */
-
-package org.spearce.jgit.lib;
-
-import java.io.EOFException;
-import java.io.File;
-import java.io.IOException;
-import java.io.OutputStream;
-import java.io.RandomAccessFile;
-import java.nio.MappedByteBuffer;
-import java.nio.channels.FileChannel.MapMode;
-import java.util.zip.DataFormatException;
-
-/**
- * Read-only cached file access.
- * <p>
- * Supports reading data from large read-only files by loading and caching
- * regions (windows) of the file in memory. Windows may be loaded using either
- * traditional byte[] or by taking advantage of the operating system's virtual
- * memory manager and mapping the file into the JVM's address space.
- * </p>
- * <p>
- * Using no MapMode is the most portable way to access a file and does not run
- * into problems with garbage collection, but will take longer to access as the
- * entire window must be copied from the operating system into the Java byte[]
- * before any single byte can be accessed.
- * </p>
- * <p>
- * Using a specific MapMode will avoid the complete copy by mmaping in the
- * operating system's file buffers, however this may cause problems if a large
- * number of windows are being heavily accessed as the Java garbage collector
- * may not be able to unmap old windows fast enough to permit new windows to be
- * mapped.
- * </p>
- */
-public class WindowedFile {
-	private final File fPath;
-
-	final int hash;
-
-	RandomAccessFile fd;
-
-	private long length;
-
-	/** Total number of windows actively in the associated cache. */
-	int openCount;
-
-	/**
-	 * Open a file for reading through window caching.
-	 * 
-	 * @param file
-	 *            the file to open.
-	 */
-	public WindowedFile(final File file) {
-		fPath = file;
-
-		// Multiply by 31 here so we can more directly combine with another
-		// value in WindowCache.hash(), without doing the multiply there.
-		//
-		hash = System.identityHashCode(this) * 31;
-		length = Long.MAX_VALUE;
-	}
-
-	/**
-	 * Get the total number of bytes available in this file.
-	 * 
-	 * @return the number of bytes contained within this file.
-	 */
-	public long length() {
-		return length;
-	}
-
-	/** @return the absolute file object this file reads from. */
-	public File getFile() {
-		return fPath.getAbsoluteFile();
-	}
-
-	/**
-	 * Get the path name of this file.
-	 * 
-	 * @return the absolute path name of the file.
-	 */
-	public String getName() {
-		return getFile().getPath();
-	}
-
-	/**
-	 * Read the bytes into a buffer until it is full.
-	 * <p>
-	 * This routine always reads until either the requested number of bytes has
-	 * been copied or EOF has been reached. Consequently callers do not need to
-	 * invoke it in a loop to make sure their buffer has been fully populated.
-	 * </p>
-	 * 
-	 * @param position
-	 *            the starting offset, as measured in bytes from the beginning
-	 *            of this file, to copy from.
-	 * @param dstbuf
-	 *            buffer to copy the bytes into.
-	 * @param curs
-	 *            current cursor for reading data from the file.
-	 * @return total number of bytes read. Always <code>dstbuf.length</code>
-	 *         unless the requested range to copy is over the end of the file.
-	 * @throws IOException
-	 *             a necessary window was not found in the window cache and
-	 *             trying to load it in from the operating system failed.
-	 */
-	public int read(final long position, final byte[] dstbuf,
-			final WindowCursor curs) throws IOException {
-		return read(position, dstbuf, 0, dstbuf.length, curs);
-	}
-
-	/**
-	 * Read the requested number of bytes into a buffer.
-	 * <p>
-	 * This routine always reads until either the requested number of bytes has
-	 * been copied or EOF has been reached. Consequently callers do not need to
-	 * invoke it in a loop to make sure their buffer has been fully populated.
-	 * </p>
-	 * 
-	 * @param position
-	 *            the starting offset, as measured in bytes from the beginning
-	 *            of this file, to copy from.
-	 * @param dstbuf
-	 *            buffer to copy the bytes into.
-	 * @param dstoff
-	 *            offset within <code>dstbuf</code> to start copying into.
-	 * @param cnt
-	 *            number of bytes to copy. Must not exceed
-	 *            <code>dstbuf.length - dstoff</code>.
-	 * @param curs
-	 *            current cursor for reading data from the file.
-	 * @return total number of bytes read. Always <code>length</code> unless
-	 *         the requested range to copy is over the end of the file.
-	 * @throws IOException
-	 *             a necessary window was not found in the window cache and
-	 *             trying to load it in from the operating system failed.
-	 */
-	public int read(long position, final byte[] dstbuf, int dstoff,
-			final int cnt, final WindowCursor curs) throws IOException {
-		return curs.copy(this, position, dstbuf, dstoff, cnt);
-	}
-
-	/**
-	 * Read the bytes into a buffer until it is full.
-	 * <p>
-	 * This routine always reads until either the requested number of bytes has
-	 * been copied or EOF has been reached. Consequently callers do not need to
-	 * invoke it in a loop to make sure their buffer has been fully populated.
-	 * </p>
-	 * 
-	 * @param position
-	 *            the starting offset, as measured in bytes from the beginning
-	 *            of this file, to copy from.
-	 * @param dstbuf
-	 *            buffer to copy the bytes into.
-	 * @param curs
-	 *            current cursor for reading data from the file.
-	 * @throws IOException
-	 *             a necessary window was not found in the window cache and
-	 *             trying to load it in from the operating system failed.
-	 * @throws EOFException
-	 *             the file ended before <code>dstbuf.length</code> bytes
-	 *             could be read.
-	 */
-	public void readFully(final long position, final byte[] dstbuf,
-			final WindowCursor curs) throws IOException {
-		if (read(position, dstbuf, 0, dstbuf.length, curs) != dstbuf.length)
-			throw new EOFException();
-	}
-
-	/**
-	 * Copy the requested number of bytes to the provided output stream.
-	 * <p>
-	 * This routine always reads until either the requested number of bytes has
-	 * been copied or EOF has been reached.
-	 * </p>
-	 *
-	 * @param position
-	 *            the starting offset, as measured in bytes from the beginning
-	 *            of this file, to copy from.
-	 * @param buf
-	 *            temporary buffer to copy bytes into. In case of a big amount
-	 *            of data to copy, size of at least few kB is recommended. It
-	 *            does not need to be of size <code>cnt</code>, however.
-	 * @param cnt
-	 *            number of bytes to copy. Must not exceed
-	 *            <code>file.length - position</code>.
-	 * @param out
-	 *            output stream where read data is written out. No buffering is
-	 *            guaranteed by this method.
-	 * @param curs
-	 *            current cursor for reading data from the file.
-	 * @throws IOException
-	 *             a necessary window was not found in the window cache and
-	 *             trying to load it in from the operating system failed.
-	 * @throws EOFException
-	 *             the file ended before <code>cnt</code> bytes could be read.
-	 */
-	public void copyToStream(long position, final byte[] buf, long cnt,
-			final OutputStream out, final WindowCursor curs)
-			throws IOException, EOFException {
-		while (cnt > 0) {
-			int toRead = (int) Math.min(cnt, buf.length);
-			int read = read(position, buf, 0, toRead, curs);
-			if (read != toRead)
-				throw new EOFException();
-			position += read;
-			cnt -= read;
-			out.write(buf, 0, read);
-		}
-	}
-
-	void readCompressed(final long position, final byte[] dstbuf,
-			final WindowCursor curs) throws IOException, DataFormatException {
-		if (curs.inflate(this, position, dstbuf, 0) != dstbuf.length)
-			throw new EOFException("Short compressed stream at " + position);
-	}
-
-	void verifyCompressed(final long position, final WindowCursor curs)
-			throws IOException, DataFormatException {
-		curs.inflateVerify(this, position);
-	}
-
-	/**
-	 * Overridable hook called after the file is opened.
-	 * <p>
-	 * This hook is invoked each time the file is opened for reading, but before
-	 * the first window is mapped into the cache. Implementers are free to use
-	 * any of the window access methods to obtain data, however doing so may
-	 * pollute the window cache with otherwise unnecessary windows.
-	 * </p>
-	 * 
-	 * @throws IOException
-	 *             something is wrong with the file, for example the caller does
-	 *             not understand its version header information.
-	 */
-	protected void onOpen() throws IOException {
-		// Do nothing by default.
-	}
-
-	/** Close this file and remove all open windows. */
-	public void close() {
-		WindowCache.purge(this);
-	}
-
-	void cacheOpen() throws IOException {
-		fd = new RandomAccessFile(fPath, "r");
-		length = fd.length();
-		try {
-			onOpen();
-		} catch (IOException ioe) {
-			cacheClose();
-			throw ioe;
-		} catch (RuntimeException re) {
-			cacheClose();
-			throw re;
-		} catch (Error re) {
-			cacheClose();
-			throw re;
-		}
-	}
-
-	void cacheClose() {
-		if (fd != null) {
-			try {
-				fd.close();
-			} catch (IOException err) {
-				// Ignore a close event. We had it open only for reading.
-				// There should not be errors related to network buffers
-				// not flushed, etc.
-			}
-			fd = null;
-		}
-	}
-
-	void allocWindow(final WindowCursor curs, final int windowId,
-			final long pos, final int size) {
-		if (WindowCache.mmap) {
-			MappedByteBuffer map;
-			try {
-				map = fd.getChannel().map(MapMode.READ_ONLY, pos, size);
-			} catch (IOException e) {
-				// The most likely reason this failed is the JVM has run out
-				// of virtual memory. We need to discard quickly, and try to
-				// force the GC to finalize and release any existing mappings.
-				try {
-					curs.release();
-					System.gc();
-					System.runFinalization();
-					map = fd.getChannel().map(MapMode.READ_ONLY, pos, size);
-				} catch (IOException ioe2) {
-					// Temporarily disable mmap and do buffered disk IO.
-					//
-					map = null;
-					System.err.println("warning: mmap failure: "+ioe2);
-				}
-			}
-			if (map != null) {
-				if (map.hasArray()) {
-					final byte[] b = map.array();
-					final ByteArrayWindow w;
-					w = new ByteArrayWindow(this, pos, windowId, b);
-					w.loaded = true;
-					curs.window = w;
-					curs.handle = b;
-				} else {
-					curs.window = new ByteBufferWindow(this, pos, windowId, map);
-					curs.handle = map;
-				}
-				return;
-			}
-		}
-
-		final byte[] b = new byte[size];
-		curs.window = new ByteArrayWindow(this, pos, windowId, b);
-		curs.handle = b;
-		openCount++; // Until the window loads, we must stay open.
-	}
-}
-- 
1.6.3.rc1.205.g37f8

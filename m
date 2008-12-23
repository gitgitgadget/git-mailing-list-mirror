From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 03/13] Cache an Inflater inside a WindowCursor and reuse it as much as possible
Date: Mon, 22 Dec 2008 16:27:13 -0800
Message-ID: <1229992043-1053-4-git-send-email-spearce@spearce.org>
References: <1229992043-1053-1-git-send-email-spearce@spearce.org>
 <1229992043-1053-2-git-send-email-spearce@spearce.org>
 <1229992043-1053-3-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Dec 23 01:30:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEv9u-0005lu-CC
	for gcvg-git-2@gmane.org; Tue, 23 Dec 2008 01:30:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752664AbYLWA1f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2008 19:27:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752624AbYLWA1e
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Dec 2008 19:27:34 -0500
Received: from george.spearce.org ([209.20.77.23]:54471 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751859AbYLWA10 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2008 19:27:26 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 380E938222; Tue, 23 Dec 2008 00:27:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 22D2838210;
	Tue, 23 Dec 2008 00:27:25 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc4.301.g5497a
In-Reply-To: <1229992043-1053-3-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103786>

By caching the Inflater within the WindowCursor we can improve
performance associated with reading objects from the pack files.
Each read can use the cached Inflater, especially when chasing
down a delta chain.  This avoids locking on the global cache.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../jgit/lib/DeltaRefPackedObjectLoader.java       |    2 +-
 .../src/org/spearce/jgit/lib/PackFile.java         |    7 +++-
 .../src/org/spearce/jgit/lib/Repository.java       |    7 +++-
 .../src/org/spearce/jgit/lib/WindowCursor.java     |   33 ++++++++++++++------
 .../src/org/spearce/jgit/lib/WindowedFile.java     |   10 +-----
 .../src/org/spearce/jgit/revwalk/RevWalk.java      |    4 +-
 .../src/org/spearce/jgit/transport/IndexPack.java  |    9 ++++-
 7 files changed, 47 insertions(+), 25 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/DeltaRefPackedObjectLoader.java b/org.spearce.jgit/src/org/spearce/jgit/lib/DeltaRefPackedObjectLoader.java
index 042d3a8..b126bbd 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/DeltaRefPackedObjectLoader.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/DeltaRefPackedObjectLoader.java
@@ -54,7 +54,7 @@ DeltaRefPackedObjectLoader(final WindowCursor curs, final PackFile pr,
 	}
 
 	protected PackedObjectLoader getBaseLoader() throws IOException {
-		final PackedObjectLoader or = pack.get(deltaBase);
+		final PackedObjectLoader or = pack.get(curs, deltaBase);
 		if (or == null)
 			throw new MissingObjectException(deltaBase, "delta base");
 		return or;
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
index 8ebd440..6cd85b1 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
@@ -120,7 +120,12 @@ public boolean hasObject(final AnyObjectId id) {
 	 *             the pack file or the index could not be read.
 	 */
 	public PackedObjectLoader get(final AnyObjectId id) throws IOException {
-		return get(new WindowCursor(), id);
+		final WindowCursor wc = new WindowCursor();
+		try {
+			return get(wc, id);
+		} finally {
+			wc.release();
+		}
 	}
 
 	/**
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index a319c00..ff36a3d 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -251,7 +251,12 @@ public boolean hasObject(final AnyObjectId objectId) {
 	 */
 	public ObjectLoader openObject(final AnyObjectId id)
 			throws IOException {
-		return openObject(new WindowCursor(),id);
+		final WindowCursor wc = new WindowCursor();
+		try {
+			return openObject(wc, id);
+		} finally {
+			wc.release();
+		}
 	}
 
 	/**
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCursor.java b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCursor.java
index 0f4dab9..7aad081 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCursor.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCursor.java
@@ -46,6 +46,8 @@
 	/** Temporary buffer large enough for at least one raw object id. */
 	final byte[] tempId = new byte[Constants.OBJECT_ID_LENGTH];
 
+	private Inflater inf;
+	
 	ByteWindow window;
 
 	Object handle;
@@ -98,16 +100,8 @@ int copy(final WindowedFile provider, long position, final byte[] dstbuf,
 	 *            data to.
 	 * @param dstoff
 	 *            current offset within <code>dstbuf</code> to inflate into.
-	 * @param inf
-	 *            the inflater to feed input to. The caller is responsible for
-	 *            initializing the inflater as multiple windows may need to
-	 *            supply data to the same inflater to completely decompress
-	 *            something.
 	 * @return updated <code>dstoff</code> based on the number of bytes
-	 *         successfully copied into <code>dstbuf</code> by
-	 *         <code>inf</code>. If the inflater is not yet finished then
-	 *         another window's data must still be supplied as input to finish
-	 *         decompression.
+	 *         successfully inflated into <code>dstbuf</code>.
 	 * @throws IOException
 	 *             this cursor does not match the provider or id and the proper
 	 *             window could not be acquired through the provider's cache.
@@ -116,8 +110,12 @@ int copy(final WindowedFile provider, long position, final byte[] dstbuf,
 	 *             stream corruption is likely.
 	 */
 	int inflate(final WindowedFile provider, long position,
-			final byte[] dstbuf, int dstoff, final Inflater inf)
+			final byte[] dstbuf, int dstoff)
 			throws IOException, DataFormatException {
+		if (inf == null)
+			inf = InflaterCache.get();
+		else
+			inf.reset();
 		for (;;) {
 			pin(provider, position);
 			dstoff = window.inflate(handle, position, dstbuf, dstoff, inf);
@@ -138,5 +136,20 @@ private void pin(final WindowedFile provider, final long position)
 	public void release() {
 		window = null;
 		handle = null;
+		try {
+			InflaterCache.release(inf);
+		} finally {
+			inf = null;
+		}
+	}
+
+	/**
+	 * @param curs cursor to release; may be null.
+	 * @return always null.
+	 */
+	public static WindowCursor release(final WindowCursor curs) {
+		if (curs != null)
+			curs.release();
+		return null;
 	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowedFile.java b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowedFile.java
index f28524f..454f98b 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowedFile.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowedFile.java
@@ -45,7 +45,6 @@
 import java.nio.MappedByteBuffer;
 import java.nio.channels.FileChannel.MapMode;
 import java.util.zip.DataFormatException;
-import java.util.zip.Inflater;
 
 /**
  * Read-only cached file access.
@@ -240,13 +239,8 @@ public void copyToStream(long position, final byte[] buf, long cnt,
 
 	void readCompressed(final long position, final byte[] dstbuf,
 			final WindowCursor curs) throws IOException, DataFormatException {
-		final Inflater inf = InflaterCache.get();
-		try {
-			if (curs.inflate(this, position, dstbuf, 0, inf) != dstbuf.length)
-				throw new EOFException("Short compressed stream at " + position);
-		} finally {
-			InflaterCache.release(inf);
-		}
+		if (curs.inflate(this, position, dstbuf, 0) != dstbuf.length)
+			throw new EOFException("Short compressed stream at " + position);
 	}
 
 	/**
diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevWalk.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevWalk.java
index d7e4c58..b1571ab 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevWalk.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevWalk.java
@@ -651,7 +651,7 @@ else if (!(c instanceof RevTree))
 
 		if ((t.flags & PARSED) != 0)
 			return t;
-		final ObjectLoader ldr = db.openObject(t);
+		final ObjectLoader ldr = db.openObject(curs, t);
 		if (ldr == null)
 			throw new MissingObjectException(t, Constants.TYPE_TREE);
 		if (ldr.getType() != Constants.OBJ_TREE)
@@ -680,7 +680,7 @@ public RevObject parseAny(final AnyObjectId id)
 			throws MissingObjectException, IOException {
 		RevObject r = objects.get(id);
 		if (r == null) {
-			final ObjectLoader ldr = db.openObject(id);
+			final ObjectLoader ldr = db.openObject(curs, id);
 			if (ldr == null)
 				throw new MissingObjectException(id.toObjectId(), "unknown");
 			final byte[] data = ldr.getCachedBytes();
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java b/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
index 3e2187c..82cd615 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
@@ -68,6 +68,7 @@
 import org.spearce.jgit.lib.PackIndexWriter;
 import org.spearce.jgit.lib.ProgressMonitor;
 import org.spearce.jgit.lib.Repository;
+import org.spearce.jgit.lib.WindowCursor;
 import org.spearce.jgit.util.NB;
 
 /** Indexes Git pack files for local use. */
@@ -173,6 +174,8 @@ public static IndexPack create(final Repository db, final InputStream is)
 	/** If {@link #fixThin} this is the last byte of the original checksum. */
 	private long originalEOF;
 
+	private WindowCursor readCurs;
+
 	/**
 	 * Create a new pack indexer utility.
 	 * 
@@ -189,6 +192,7 @@ public IndexPack(final Repository db, final InputStream src,
 		repo = db;
 		in = src;
 		inflater = InflaterCache.get();
+		readCurs = new WindowCursor();
 		buf = new byte[BUFFER_SIZE];
 		objectData = new byte[BUFFER_SIZE];
 		objectDigest = Constants.newMessageDigest();
@@ -325,6 +329,7 @@ public void index(final ProgressMonitor progress) throws IOException {
 				} finally {
 					inflater = null;
 				}
+				readCurs = WindowCursor.release(readCurs);
 
 				progress.endTask();
 				if (packOut != null)
@@ -461,7 +466,7 @@ private void fixThinPack(final ProgressMonitor progress) throws IOException {
 		final Deflater def = new Deflater(Deflater.DEFAULT_COMPRESSION, false);
 		long end = originalEOF;
 		for (final ObjectId baseId : new ArrayList<ObjectId>(baseById.keySet())) {
-			final ObjectLoader ldr = repo.openObject(baseId);
+			final ObjectLoader ldr = repo.openObject(readCurs, baseId);
 			if (ldr == null)
 				continue;
 			final byte[] data = ldr.getBytes();
@@ -715,7 +720,7 @@ private void verifySafeObject(final AnyObjectId id, final int type,
 			}
 		}
 
-		final ObjectLoader ldr = repo.openObject(id);
+		final ObjectLoader ldr = repo.openObject(readCurs, id);
 		if (ldr != null) {
 			final byte[] existingData = ldr.getCachedBytes();
 			if (ldr.getType() != type || !Arrays.equals(data, existingData)) {
-- 
1.6.1.rc4.301.g5497a

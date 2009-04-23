From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT RFC PATCH 5/5] Teach PackWriter to recover from removed/replaced packs
Date: Wed, 22 Apr 2009 20:36:23 -0700
Message-ID: <1240457783-21434-6-git-send-email-spearce@spearce.org>
References: <1240457783-21434-1-git-send-email-spearce@spearce.org>
 <1240457783-21434-2-git-send-email-spearce@spearce.org>
 <1240457783-21434-3-git-send-email-spearce@spearce.org>
 <1240457783-21434-4-git-send-email-spearce@spearce.org>
 <1240457783-21434-5-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Apr 23 05:38:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwplV-0005xI-DH
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 05:38:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754097AbZDWDgf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 23:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753775AbZDWDgd
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 23:36:33 -0400
Received: from george.spearce.org ([209.20.77.23]:47549 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753500AbZDWDg2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 23:36:28 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id B447738211; Thu, 23 Apr 2009 03:36:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id A607C38222;
	Thu, 23 Apr 2009 03:36:25 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.rc1.205.g37f8
In-Reply-To: <1240457783-21434-5-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117290>

A concurrently running "git gc" in the same repository could cause a
PackFile that was previously identified for object reuse to disappear
(or be rewritten) between the time that a segment was selected to
be reused, and when we actually need to copy the raw data from the
pack to the output stream.

We now peg the pack file open during the reuse period, ensuring
that the underlying file descriptor cannot be closed while we are
copying data, even if memory pressure gets high and windows are
evicted from the WindowCache.

If the pack file is gone (or has been rewritten) since we originally
picked it for reuse we throw away that reuse decision and make
it again.  This is a relative waste of CPU and disk IO, as we have
to do work twice, but it should be fairly infrequent as repositories
are not repacked that often.  If we do have to recompute one object,
it is likely that we may need to recompute all reuse decisions for
the remainder of this pack output stream, but doing a bit more work
and succeeding is better than failing outright with an obtuse error.

The way we handle the recovery is subject to livelock.  We could
pick a new reuse location, see it disappear before we can get a pin,
and need to select another one.  Livelock however is not likely
here, as the situation can only happen when the selected pack
file has been deleted or overwritten.  Repacking takes some time
on any repository, typically longer than a single PackWriter may
need to stream to a network client.  It is highly improbable that
the repository administator is running "while true; git gc; done",
as that would suck up all system resources and generally make the
host unresponsive anyway.  So, long story short, we should be OK
against livelock if the repository administrator isn't hellbent
on otherwise sucking up CPU usage through repeat git gc attempts.
And if they are, we'll just help them out by falling for the obvious
livelock case.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 As I said in the cover letter of this series; this one is still
 iffy.  I think its sound as-is, but I'm not convinced that this
 patch is sufficient to cover everything that can happen.

 .../src/org/spearce/jgit/lib/PackWriter.java       |  118 +++++++++++++-------
 .../org/spearce/jgit/lib/PackedObjectLoader.java   |   30 +++++
 .../src/org/spearce/jgit/lib/WindowCache.java      |   59 +++++++----
 3 files changed, 145 insertions(+), 62 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
index e1397fd..2da8bbc 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
@@ -606,14 +606,7 @@ private void searchForReuse() throws IOException {
 					throw new IOException(
 							"Packing cancelled during objects writing");
 				reuseLoaders.clear();
-				db.openObjectInAllPacks(otp, reuseLoaders, windowCursor);
-				if (reuseDeltas) {
-					selectDeltaReuseForObject(otp, reuseLoaders);
-				}
-				// delta reuse is preferred over object reuse
-				if (reuseObjects && !otp.hasReuseLoader()) {
-					selectObjectReuseForObject(otp, reuseLoaders);
-				}
+				searchForReuse(reuseLoaders, otp);
 				initMonitor.update(1);
 			}
 		}
@@ -621,6 +614,19 @@ private void searchForReuse() throws IOException {
 		initMonitor.endTask();
 	}
 
+	private void searchForReuse(
+			final Collection<PackedObjectLoader> reuseLoaders,
+			final ObjectToPack otp) throws IOException {
+		db.openObjectInAllPacks(otp, reuseLoaders, windowCursor);
+		if (reuseDeltas) {
+			selectDeltaReuseForObject(otp, reuseLoaders);
+		}
+		// delta reuse is preferred over object reuse
+		if (reuseObjects && !otp.hasReuseLoader()) {
+			selectObjectReuseForObject(otp, reuseLoaders);
+		}
+	}
+
 	private void selectDeltaReuseForObject(final ObjectToPack otp,
 			final Collection<PackedObjectLoader> loaders) throws IOException {
 		PackedObjectLoader bestLoader = null;
@@ -707,40 +713,69 @@ private void writeObject(final ObjectToPack otp) throws IOException {
 
 		out.resetCRC32();
 		otp.setOffset(out.length());
-		if (otp.isDeltaRepresentation())
-			writeDeltaObject(otp);
-		else
-			writeWholeObject(otp);
+		
+		final PackedObjectLoader reuse = open(otp);
+		if (reuse != null) {
+			try {
+				if (otp.isDeltaRepresentation()) {
+					writeDeltaObjectReuse(otp, reuse);
+				} else {
+					writeObjectHeader(otp.getType(), reuse.getSize());
+					reuse.copyRawData(out, buf, windowCursor);
+				}
+			} finally {
+				reuse.endCopyRawData();
+			}
+		} else if (otp.isDeltaRepresentation()) {
+			throw new IOException("creating deltas is not implemented");
+		} else {
+			writeWholeObjectDeflate(otp);
+		}
 		otp.setCRC(out.getCRC32());
 
 		writeMonitor.update(1);
 	}
 
-	private void writeWholeObject(final ObjectToPack otp) throws IOException {
-		if (otp.hasReuseLoader()) {
-			final PackedObjectLoader loader = otp.getReuseLoader();
-			writeObjectHeader(otp.getType(), loader.getSize());
-			loader.copyRawData(out, buf, windowCursor);
-			otp.disposeLoader();
-		} else {
-			final ObjectLoader loader = db.openObject(windowCursor, otp);
-			final byte[] data = loader.getCachedBytes();
-			writeObjectHeader(otp.getType(), data.length);
-			deflater.reset();
-			deflater.setInput(data, 0, data.length);
-			deflater.finish();
-			do {
-				final int n = deflater.deflate(buf, 0, buf.length);
-				if (n > 0)
-					out.write(buf, 0, n);
-			} while (!deflater.finished());
-		}
-	}
-
-	private void writeDeltaObject(final ObjectToPack otp) throws IOException {
-		final PackedObjectLoader loader = otp.getReuseLoader();
+	private PackedObjectLoader open(final ObjectToPack otp) throws IOException {
+		for (;;) {
+			PackedObjectLoader reuse = otp.useLoader();
+			if (reuse == null) {
+				return null;
+			}
+
+			try {
+				reuse.beginCopyRawData();
+				return reuse;
+			} catch (IOException err) {
+				// The pack we found the object in originally is gone, or
+				// it has been overwritten with a different layout.
+				//
+				otp.clearDeltaBase();
+				searchForReuse(new ArrayList<PackedObjectLoader>(), otp);
+				continue;
+			}
+		}
+	}
+
+	private void writeWholeObjectDeflate(final ObjectToPack otp)
+			throws IOException {
+		final ObjectLoader loader = db.openObject(windowCursor, otp);
+		final byte[] data = loader.getCachedBytes();
+		writeObjectHeader(otp.getType(), data.length);
+		deflater.reset();
+		deflater.setInput(data, 0, data.length);
+		deflater.finish();
+		do {
+			final int n = deflater.deflate(buf, 0, buf.length);
+			if (n > 0)
+				out.write(buf, 0, n);
+		} while (!deflater.finished());
+	}
+
+	private void writeDeltaObjectReuse(final ObjectToPack otp,
+			final PackedObjectLoader reuse) throws IOException {
 		if (deltaBaseAsOffset && otp.getDeltaBase() != null) {
-			writeObjectHeader(Constants.OBJ_OFS_DELTA, loader.getRawSize());
+			writeObjectHeader(Constants.OBJ_OFS_DELTA, reuse.getRawSize());
 
 			final ObjectToPack deltaBase = otp.getDeltaBase();
 			long offsetDiff = otp.getOffset() - deltaBase.getOffset();
@@ -752,12 +787,11 @@ private void writeDeltaObject(final ObjectToPack otp) throws IOException {
 
 			out.write(buf, pos, buf.length - pos);
 		} else {
-			writeObjectHeader(Constants.OBJ_REF_DELTA, loader.getRawSize());
+			writeObjectHeader(Constants.OBJ_REF_DELTA, reuse.getRawSize());
 			otp.getDeltaBaseId().copyRawTo(buf, 0);
 			out.write(buf, 0, Constants.OBJECT_ID_LENGTH);
 		}
-		loader.copyRawData(out, buf, windowCursor);
-		otp.disposeLoader();
+		reuse.copyRawData(out, buf, windowCursor);
 	}
 
 	private void writeObjectHeader(final int objectType, long dataLength)
@@ -955,8 +989,10 @@ boolean isWritten() {
 			return getOffset() != 0;
 		}
 
-		PackedObjectLoader getReuseLoader() {
-			return reuseLoader;
+		PackedObjectLoader useLoader() {
+			final PackedObjectLoader r = reuseLoader;
+			reuseLoader = null;
+			return r;
 		}
 
 		boolean hasReuseLoader() {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackedObjectLoader.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackedObjectLoader.java
index 60333e7..6066ba1 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackedObjectLoader.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackedObjectLoader.java
@@ -106,6 +106,30 @@ public final long getDataOffset() {
 	}
 
 	/**
+	 * Peg the pack file open to support data copying.
+	 * <p>
+	 * Applications trying to copy raw pack data should ensure the pack stays
+	 * open and available throughout the entire copy. To do that use:
+	 * 
+	 * <pre>
+	 * loader.beginCopyRawData();
+	 * try {
+	 * 	loader.copyRawData(out, tmpbuf, curs);
+	 * } finally {
+	 * 	loader.endCopyRawData();
+	 * }
+	 * </pre>
+	 * 
+	 * @throws IOException
+	 *             this loader contains stale information and cannot be used.
+	 *             The most likely cause is the underlying pack file has been
+	 *             deleted, and the object has moved to another pack file.
+	 */
+	public void beginCopyRawData() throws IOException {
+		WindowCache.pin(pack);
+	}
+
+	/**
 	 * Copy raw object representation from storage to provided output stream.
 	 * <p>
 	 * Copied data doesn't include object header. User must provide temporary
@@ -121,12 +145,18 @@ public final long getDataOffset() {
 	 *            temporary thread storage during data access.
 	 * @throws IOException
 	 *             when the object cannot be read.
+	 * @see #beginCopyRawData()
 	 */
 	public void copyRawData(OutputStream out, byte buf[], WindowCursor curs)
 			throws IOException {
 		pack.copyRawData(this, out, buf, curs);
 	}
 
+	/** Release resources after {@link #beginCopyRawData()}. */
+	public void endCopyRawData() {
+		WindowCache.unpin(pack);
+	}
+
 	/**
 	 * @return true if this loader is capable of fast raw-data copying basing on
 	 *         compressed data checksum; false if raw-data copying needs
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java
index 03e531a..51d149c 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java
@@ -223,6 +223,19 @@ public static final void get(final WindowCursor curs, final PackFile wp,
 		curs.window.ensureLoaded(curs.handle);
 	}
 
+	static synchronized final void pin(final PackFile wp) throws IOException {
+		if (++wp.openCount == 1) {
+			openFile(wp);
+		}
+	}
+
+	static synchronized final void unpin(final PackFile wp) {
+		if (--wp.openCount == 0) {
+			openFileCount--;
+			wp.cacheClose();
+		}
+	}
+
 	private static synchronized final void getImpl(final WindowCursor curs,
 			final PackFile wp, final long position) throws IOException {
 		final int id = (int) (position >> windowSizeShift);
@@ -241,27 +254,7 @@ private static synchronized final void getImpl(final WindowCursor curs,
 		}
 
 		if (wp.openCount == 0) {
-			try {
-				openFileCount++;
-				releaseMemory();
-				runClearedWindowQueue();
-				wp.openCount = 1;
-				wp.cacheOpen();
-			} catch (IOException ioe) {
-				openFileCount--;
-				wp.openCount = 0;
-				throw ioe;
-			} catch (RuntimeException ioe) {
-				openFileCount--;
-				wp.openCount = 0;
-				throw ioe;
-			} catch (Error ioe) {
-				openFileCount--;
-				wp.openCount = 0;
-				throw ioe;
-			} finally {
-				wp.openCount--;
-			}
+			openFile(wp);
 
 			// The cacheOpen may have mapped the window we are trying to
 			// map ourselves. Retrying the search ensures that does not
@@ -294,6 +287,30 @@ private static synchronized final void getImpl(final WindowCursor curs,
 		insertLRU(e);
 	}
 
+	private static void openFile(final PackFile wp) throws IOException {
+		try {
+			openFileCount++;
+			releaseMemory();
+			runClearedWindowQueue();
+			wp.openCount = 1;
+			wp.cacheOpen();
+		} catch (IOException ioe) {
+			openFileCount--;
+			wp.openCount = 0;
+			throw ioe;
+		} catch (RuntimeException ioe) {
+			openFileCount--;
+			wp.openCount = 0;
+			throw ioe;
+		} catch (Error ioe) {
+			openFileCount--;
+			wp.openCount = 0;
+			throw ioe;
+		} finally {
+			wp.openCount--;
+		}
+	}
+
 	static synchronized void markLoaded(final ByteWindow w) {
 		if (--w.provider.openCount == 0) {
 			openFileCount--;
-- 
1.6.3.rc1.205.g37f8

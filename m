From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 4/9] Allow PackFile to lazily load its PackIndex on first demand
Date: Wed, 11 Feb 2009 18:36:54 -0800
Message-ID: <1234406219-19547-5-git-send-email-spearce@spearce.org>
References: <1234406219-19547-1-git-send-email-spearce@spearce.org>
 <1234406219-19547-2-git-send-email-spearce@spearce.org>
 <1234406219-19547-3-git-send-email-spearce@spearce.org>
 <1234406219-19547-4-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 03:39:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXRTc-0002tJ-QH
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 03:38:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758242AbZBLChQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 21:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757562AbZBLChP
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 21:37:15 -0500
Received: from george.spearce.org ([209.20.77.23]:39180 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756590AbZBLChE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 21:37:04 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 23F7638265; Thu, 12 Feb 2009 02:37:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 3127B38210;
	Thu, 12 Feb 2009 02:37:01 +0000 (UTC)
X-Mailer: git-send-email 1.6.2.rc0.204.gf6b427
In-Reply-To: <1234406219-19547-4-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109563>

Repositories which contain several pack files may have a very large
historical pack holding the bulk of the project data, and a much
smaller more recent pack holding current data.  In such cases we
may be able to answer queries entirely by reading the recent pack
index, and never reading the larger historical index.  Since JGit
reads the entire index into memory, avoiding reading the larger
index can save some time on short uses of a Repository.

This change only sets up the lazy loading of the index.  Because
the packs aren't sorted by newest-to-oldest in Repository we are
still very likely to demand load packs we didn't need to examine.

This change also opens the door for potentially releasing one or
more PackIndex objects when memory gets low, but doesn't actually
implement any sort of soft reference semantics.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/PackFile.java         |   67 +++++++++++++-------
 .../org/spearce/jgit/lib/PackedObjectLoader.java   |    4 +-
 .../src/org/spearce/jgit/lib/Repository.java       |   19 +++---
 3 files changed, 56 insertions(+), 34 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
index 8368827..3542560 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
@@ -42,6 +42,7 @@
 import java.io.File;
 import java.io.IOException;
 import java.io.OutputStream;
+import java.util.Collections;
 import java.util.Iterator;
 import java.util.zip.CRC32;
 import java.util.zip.CheckedOutputStream;
@@ -56,9 +57,11 @@
  * objects are similar.
  */
 public class PackFile implements Iterable<PackIndex.MutableEntry> {
+	private final File idxFile;
+
 	private final WindowedFile pack;
 
-	private final PackIndex idx;
+	private PackIndex loadedIdx;
 
 	private PackReverseIndex reverseIdx;
 
@@ -69,21 +72,22 @@
 	 *            path of the <code>.idx</code> file listing the contents.
 	 * @param packFile
 	 *            path of the <code>.pack</code> file holding the data.
-	 * @throws IOException
-	 *             the index file cannot be accessed at this time.
 	 */
-	public PackFile(final File idxFile, final File packFile) throws IOException {
+	public PackFile(final File idxFile, final File packFile) {
+		this.idxFile = idxFile;
 		pack = new WindowedFile(packFile) {
 			@Override
 			protected void onOpen() throws IOException {
 				readPackHeader();
 			}
 		};
-		try {
-			idx = PackIndex.open(idxFile);
-		} catch (IOException ioe) {
-			throw ioe;
+	}
+
+	private synchronized PackIndex idx() throws IOException {
+		if (loadedIdx == null) {
+			loadedIdx = PackIndex.open(idxFile);
 		}
+		return loadedIdx;
 	}
 
 	final PackedObjectLoader resolveBase(final WindowCursor curs, final long ofs)
@@ -106,9 +110,11 @@ public File getPackFile() {
 	 * @param id
 	 *            the object to look for. Must not be null.
 	 * @return true if the object is in this pack; false otherwise.
+	 * @throws IOException
+	 *             the index file cannot be loaded into memory.
 	 */
-	public boolean hasObject(final AnyObjectId id) {
-		return idx.hasObject(id);
+	public boolean hasObject(final AnyObjectId id) throws IOException {
+		return idx().hasObject(id);
 	}
 
 	/**
@@ -125,7 +131,7 @@ public boolean hasObject(final AnyObjectId id) {
 	 */
 	public PackedObjectLoader get(final WindowCursor curs, final AnyObjectId id)
 			throws IOException {
-		final long offset = idx.findOffset(id);
+		final long offset = idx().findOffset(id);
 		return 0 < offset ? reader(curs, offset) : null;
 	}
 
@@ -135,6 +141,9 @@ public PackedObjectLoader get(final WindowCursor curs, final AnyObjectId id)
 	public void close() {
 		UnpackedObjectCache.purge(pack);
 		pack.close();
+		synchronized (this) {
+			loadedIdx = null;
+		}
 	}
 
 	/**
@@ -150,7 +159,11 @@ public void close() {
 	 * @see PackIndex#iterator()
 	 */
 	public Iterator<PackIndex.MutableEntry> iterator() {
-		return idx.iterator();
+		try {
+			return idx().iterator();
+		} catch (IOException e) {
+			return Collections.<PackIndex.MutableEntry> emptyList().iterator();
+		}
 	}
 
 	/**
@@ -158,9 +171,11 @@ public void close() {
 	 * relies on pack index, giving number of effectively available objects.
 	 * 
 	 * @return number of objects in index of this pack, likewise in this pack
+	 * @throws IOException
+	 *             the index file cannot be loaded into memory.
 	 */
-	long getObjectCount() {
-		return idx.getObjectCount();
+	long getObjectCount() throws IOException {
+		return idx().getObjectCount();
 	}
 
 	/**
@@ -170,8 +185,10 @@ long getObjectCount() {
 	 * @param offset
 	 *            start offset of object to find
 	 * @return object id for this offset, or null if no object was found
+	 * @throws IOException
+	 *             the index file cannot be loaded into memory.
 	 */
-	ObjectId findObjectForOffset(final long offset) {
+	ObjectId findObjectForOffset(final long offset) throws IOException {
 		return getReverseIdx().findObject(offset);
 	}
 
@@ -196,6 +213,7 @@ final void copyRawData(final PackedObjectLoader loader,
 		final long dataOffset = loader.dataOffset;
 		final int cnt = (int) (findEndOffset(objectOffset) - dataOffset);
 		final WindowCursor curs = loader.curs;
+		final PackIndex idx = idx();
 
 		if (idx.hasCRC32Support()) {
 			final CRC32 crc = new CRC32();
@@ -231,8 +249,8 @@ final void copyRawData(final PackedObjectLoader loader,
 		}
 	}
 
-	boolean supportsFastCopyRawData() {
-		return idx.hasCRC32Support();
+	boolean supportsFastCopyRawData() throws IOException {
+		return idx().hasCRC32Support();
 	}
 
 
@@ -258,11 +276,12 @@ private void readPackHeader() throws IOException {
 		position += 4;
 
 		pack.readFully(position, intbuf, curs);
-		final long objectCnt = NB.decodeUInt32(intbuf, 0);
-		if (idx.getObjectCount() != objectCnt)
+		final long packCnt = NB.decodeUInt32(intbuf, 0);
+		final long idxCnt = idx().getObjectCount();
+		if (idxCnt != packCnt)
 			throw new IOException("Pack index"
-					+ " object count mismatch; expected " + objectCnt
-					+ " found " + idx.getObjectCount() + ": " + pack.getName());
+					+ " object count mismatch; expected " + packCnt
+					+ " found " + idxCnt + ": " + pack.getName());
 	}
 
 	private PackedObjectLoader reader(final WindowCursor curs,
@@ -315,14 +334,14 @@ private PackedObjectLoader reader(final WindowCursor curs,
 	}
 
 	private long findEndOffset(final long startOffset)
-			throws CorruptObjectException {
+			throws IOException, CorruptObjectException {
 		final long maxOffset = pack.length() - Constants.OBJECT_ID_LENGTH;
 		return getReverseIdx().findNextOffset(startOffset, maxOffset);
 	}
 
-	private synchronized PackReverseIndex getReverseIdx() {
+	private synchronized PackReverseIndex getReverseIdx() throws IOException {
 		if (reverseIdx == null)
-			reverseIdx = new PackReverseIndex(idx);
+			reverseIdx = new PackReverseIndex(idx());
 		return reverseIdx;
 	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackedObjectLoader.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackedObjectLoader.java
index 35983fe..56985c1 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackedObjectLoader.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackedObjectLoader.java
@@ -103,8 +103,10 @@ public void copyRawData(OutputStream out, byte buf[]) throws IOException {
 	 * @return true if this loader is capable of fast raw-data copying basing on
 	 *         compressed data checksum; false if raw-data copying needs
 	 *         uncompressing and compressing data
+	 * @throws IOException
+	 *             the index file format cannot be determined.
 	 */
-	public boolean supportsFastCopyRawData() {
+	public boolean supportsFastCopyRawData() throws IOException {
 		return pack.supportsFastCopyRawData();
 	}
 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index 963b6e0..b9c7b2e 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -248,8 +248,15 @@ public boolean hasObject(final AnyObjectId objectId) {
 		final PackFile[] packs = packs();
 		int k = packs.length;
 		while (k > 0) {
-			if (packs[--k].hasObject(objectId))
-				return true;
+			try {
+				if (packs[--k].hasObject(objectId))
+					return true;
+			} catch (IOException e) {
+				// Assume that means the pack is invalid, and such
+				// packs are treated as though they are empty.
+				//
+				continue;
+			}
 		}
 		return toFile(objectId).isFile();
 	}
@@ -848,13 +855,7 @@ public boolean accept(final File baseDir, final String n) {
 						continue SCAN;
 				}
 
-				try {
-					packList.add(new PackFile(idxFile, packFile));
-				} catch (IOException ioe) {
-					// Whoops. That's not a pack!
-					//
-					ioe.printStackTrace();
-				}
+				packList.add(new PackFile(idxFile, packFile));
 			}
 		}
 	}
-- 
1.6.2.rc0.204.gf6b427

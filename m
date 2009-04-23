From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 3/5] Fully materialize an ObjectLoader before returning it from ObjectDatabase
Date: Wed, 22 Apr 2009 20:36:21 -0700
Message-ID: <1240457783-21434-4-git-send-email-spearce@spearce.org>
References: <1240457783-21434-1-git-send-email-spearce@spearce.org>
 <1240457783-21434-2-git-send-email-spearce@spearce.org>
 <1240457783-21434-3-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Apr 23 05:38:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwplU-0005xI-Ec
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 05:38:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754008AbZDWDgd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 23:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753145AbZDWDgb
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 23:36:31 -0400
Received: from george.spearce.org ([209.20.77.23]:47544 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753245AbZDWDg1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 23:36:27 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 82D9A38260; Thu, 23 Apr 2009 03:36:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id BC5BD38211;
	Thu, 23 Apr 2009 03:36:24 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.rc1.205.g37f8
In-Reply-To: <1240457783-21434-3-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117286>

By forcing the ObjectLoader to fully reconstruct the requested object
and store it under getCachedBytes() before we return the ObjectLoader
to the caller we can ensure that the underlying PackFile remains valid
throughout the entire load.

If memory pressure causes the PackFile's windows to be evicted, and
the pack closes, and is replaced underneath of us, we can correctly
catch and handle the PackMismatchException or IOException by closing
the pack, rescanning the ObjectDirectory, and starting our search all
over again.  Doing so is expensive, as we may have already unpacked
a large part of the object's delta chain before finding the pack was
modified, but its better than failing outright due to a race condition.

Note that this does not resolve the concurrent access problems in
PackWriter, as the cached PackedObjectLoaders are referenced very
late, and go back to the original PackFile, not the cached store.

Because we fully access the pack data up front during materialize()
we no longer need to hold the WindowCursor inside of the individual
loader instance.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../jgit/lib/DeltaOfsPackedObjectLoader.java       |    7 ++-
 .../spearce/jgit/lib/DeltaPackedObjectLoader.java  |   41 +++++++---------
 .../jgit/lib/DeltaRefPackedObjectLoader.java       |    9 ++--
 .../src/org/spearce/jgit/lib/ObjectDirectory.java  |    3 +-
 .../src/org/spearce/jgit/lib/ObjectLoader.java     |   23 +++-------
 .../src/org/spearce/jgit/lib/PackFile.java         |   14 +++---
 .../src/org/spearce/jgit/lib/PackWriter.java       |    4 +-
 .../org/spearce/jgit/lib/PackedObjectLoader.java   |   48 +++++++++++++++----
 .../spearce/jgit/lib/WholePackedObjectLoader.java  |   21 +++++----
 9 files changed, 94 insertions(+), 76 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/DeltaOfsPackedObjectLoader.java b/org.spearce.jgit/src/org/spearce/jgit/lib/DeltaOfsPackedObjectLoader.java
index 5c9fb00..ee2a0de 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/DeltaOfsPackedObjectLoader.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/DeltaOfsPackedObjectLoader.java
@@ -46,14 +46,15 @@
 class DeltaOfsPackedObjectLoader extends DeltaPackedObjectLoader {
 	private final long deltaBase;
 
-	DeltaOfsPackedObjectLoader(final WindowCursor curs, final PackFile pr,
+	DeltaOfsPackedObjectLoader(final PackFile pr,
 			final long dataOffset, final long objectOffset, final int deltaSz,
 			final long base) {
-		super(curs, pr, dataOffset, objectOffset, deltaSz);
+		super(pr, dataOffset, objectOffset, deltaSz);
 		deltaBase = base;
 	}
 
-	protected PackedObjectLoader getBaseLoader() throws IOException {
+	protected PackedObjectLoader getBaseLoader(final WindowCursor curs)
+			throws IOException {
 		return pack.resolveBase(curs, deltaBase);
 	}
 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/DeltaPackedObjectLoader.java b/org.spearce.jgit/src/org/spearce/jgit/lib/DeltaPackedObjectLoader.java
index 85f2bda..8194d94 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/DeltaPackedObjectLoader.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/DeltaPackedObjectLoader.java
@@ -49,47 +49,39 @@
 
 	private final int deltaSize;
 
-	DeltaPackedObjectLoader(final WindowCursor curs, final PackFile pr,
-			final long dataOffset, final long objectOffset, final int deltaSz) {
-		super(curs, pr, dataOffset, objectOffset);
+	DeltaPackedObjectLoader(final PackFile pr, final long dataOffset,
+			final long objectOffset, final int deltaSz) {
+		super(pr, dataOffset, objectOffset);
 		objectType = -1;
 		deltaSize = deltaSz;
 	}
 
-	public int getType() throws IOException {
-		if (objectType < 0)
-			getCachedBytes();
-		return objectType;
-	}
-
-	public long getSize() throws IOException {
-		if (objectType < 0)
-			getCachedBytes();
-		return objectSize;
-	}
-
 	@Override
-	public byte[] getCachedBytes() throws IOException {
+	public void materialize(final WindowCursor curs) throws IOException {
+		if (cachedBytes != null) {
+			return;
+		}
+
 		if (objectType != OBJ_COMMIT) {
 			final UnpackedObjectCache.Entry cache = pack.readCache(dataOffset);
 			if (cache != null) {
 				curs.release();
 				objectType = cache.type;
 				objectSize = cache.data.length;
-				return cache.data;
+				cachedBytes = cache.data;
 			}
 		}
 
 		try {
-			final PackedObjectLoader baseLoader = getBaseLoader();
-			final byte[] data = BinaryDelta.apply(baseLoader.getCachedBytes(),
+			final PackedObjectLoader baseLoader = getBaseLoader(curs);
+			baseLoader.materialize(curs);
+			cachedBytes = BinaryDelta.apply(baseLoader.getCachedBytes(),
 					pack.decompress(dataOffset, deltaSize, curs));
 			curs.release();
 			objectType = baseLoader.getType();
-			objectSize = data.length;
+			objectSize = cachedBytes.length;
 			if (objectType != OBJ_COMMIT)
-				pack.saveCache(dataOffset, data, objectType);
-			return data;
+				pack.saveCache(dataOffset, cachedBytes, objectType);
 		} catch (DataFormatException dfe) {
 			final CorruptObjectException coe;
 			coe = new CorruptObjectException("Object at " + dataOffset + " in "
@@ -105,8 +97,11 @@ public long getRawSize() {
 	}
 
 	/**
+	 * @param curs
+	 *            temporary thread storage during data access.
 	 * @return the object loader for the base object
 	 * @throws IOException
 	 */
-	protected abstract PackedObjectLoader getBaseLoader() throws IOException;
+	protected abstract PackedObjectLoader getBaseLoader(WindowCursor curs)
+			throws IOException;
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/DeltaRefPackedObjectLoader.java b/org.spearce.jgit/src/org/spearce/jgit/lib/DeltaRefPackedObjectLoader.java
index b126bbd..82a3a7f 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/DeltaRefPackedObjectLoader.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/DeltaRefPackedObjectLoader.java
@@ -46,14 +46,15 @@
 class DeltaRefPackedObjectLoader extends DeltaPackedObjectLoader {
 	private final ObjectId deltaBase;
 
-	DeltaRefPackedObjectLoader(final WindowCursor curs, final PackFile pr,
+	DeltaRefPackedObjectLoader(final PackFile pr,
 			final long dataOffset, final long objectOffset, final int deltaSz,
 			final ObjectId base) {
-		super(curs, pr, dataOffset, objectOffset, deltaSz);
+		super(pr, dataOffset, objectOffset, deltaSz);
 		deltaBase = base;
 	}
 
-	protected PackedObjectLoader getBaseLoader() throws IOException {
+	protected PackedObjectLoader getBaseLoader(final WindowCursor curs)
+			throws IOException {
 		final PackedObjectLoader or = pack.get(curs, deltaBase);
 		if (or == null)
 			throw new MissingObjectException(deltaBase, "delta base");
@@ -61,7 +62,7 @@ protected PackedObjectLoader getBaseLoader() throws IOException {
 	}
 
 	@Override
-	public int getRawType() throws IOException {
+	public int getRawType() {
 		return Constants.OBJ_REF_DELTA;
 	}
 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDirectory.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDirectory.java
index 6ba0180..3e9ed1c 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDirectory.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDirectory.java
@@ -197,8 +197,9 @@ protected ObjectLoader openObject1(final WindowCursor curs,
 		SEARCH: for (;;) {
 			for (final PackFile p : pList) {
 				try {
-					final ObjectLoader ldr = p.get(curs, objectId);
+					final PackedObjectLoader ldr = p.get(curs, objectId);
 					if (ldr != null) {
+						ldr.materialize(curs);
 						return ldr;
 					}
 				} catch (PackMismatchException e) {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectLoader.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectLoader.java
index 5485d8d..6b92694 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectLoader.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectLoader.java
@@ -38,7 +38,6 @@
 
 package org.spearce.jgit.lib;
 
-import java.io.IOException;
 
 /**
  * Base class for a set of loaders for different representations of Git objects.
@@ -47,15 +46,13 @@
 public abstract class ObjectLoader {
 	/**
 	 * @return Git in pack object type, see {@link Constants}.
-	 * @throws IOException
 	 */
-	public abstract int getType() throws IOException;
+	public abstract int getType();
 
 	/**
 	 * @return size of object in bytes
-	 * @throws IOException
 	 */
-	public abstract long getSize() throws IOException;
+	public abstract long getSize();
 
 	/**
 	 * Obtain a copy of the bytes of this object.
@@ -64,10 +61,8 @@
 	 * be modified by the caller.
 	 * 
 	 * @return the bytes of this object.
-	 * @throws IOException
-	 *             the object cannot be read.
 	 */
-	public final byte[] getBytes() throws IOException {
+	public final byte[] getBytes() {
 		final byte[] data = getCachedBytes();
 		final byte[] copy = new byte[data.length];
 		System.arraycopy(data, 0, copy, 0, data.length);
@@ -83,25 +78,19 @@
 	 * Changes (if made) will affect the cache but not the repository itself.
 	 * 
 	 * @return the cached bytes of this object. Do not modify it.
-	 * @throws IOException
-	 *             the object cannot be read.
 	 */
-	public abstract byte[] getCachedBytes() throws IOException;
+	public abstract byte[] getCachedBytes();
 
 	/**
 	 * @return raw object type from object header, as stored in storage (pack,
 	 *         loose file). This may be different from {@link #getType()} result
 	 *         for packs (see {@link Constants}).
-	 * @throws IOException
-	 *             when type cannot be read from the object header.
 	 */
-	public abstract int getRawType() throws IOException;
+	public abstract int getRawType();
 
 	/**
 	 * @return raw size of object from object header (pack, loose file).
 	 *         Interpretation of this value depends on {@link #getRawType()}.
-	 * @throws IOException
-	 *             when raw size cannot be read from the object header.
 	 */
-	public abstract long getRawSize() throws IOException;
+	public abstract long getRawSize();
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
index dccc067..813ebc7 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
@@ -244,11 +244,11 @@ final void saveCache(final long position, final byte[] data, final int type) {
 	}
 
 	final void copyRawData(final PackedObjectLoader loader,
-			final OutputStream out, final byte buf[]) throws IOException {
+			final OutputStream out, final byte buf[], final WindowCursor curs)
+			throws IOException {
 		final long objectOffset = loader.objectOffset;
 		final long dataOffset = loader.dataOffset;
 		final int cnt = (int) (findEndOffset(objectOffset) - dataOffset);
-		final WindowCursor curs = loader.curs;
 		final PackIndex idx = idx();
 
 		if (idx.hasCRC32Support()) {
@@ -436,8 +436,8 @@ private PackedObjectLoader reader(final WindowCursor curs,
 		case Constants.OBJ_TREE:
 		case Constants.OBJ_BLOB:
 		case Constants.OBJ_TAG:
-			return new WholePackedObjectLoader(curs, this, pos, objOffset,
-					typeCode, (int) dataSize);
+			return new WholePackedObjectLoader(this, pos, objOffset, typeCode,
+					(int) dataSize);
 
 		case Constants.OBJ_OFS_DELTA: {
 			readFully(pos, ib, 0, 20, curs);
@@ -450,12 +450,12 @@ private PackedObjectLoader reader(final WindowCursor curs,
 				ofs <<= 7;
 				ofs += (c & 127);
 			}
-			return new DeltaOfsPackedObjectLoader(curs, this, pos + p,
-					objOffset, (int) dataSize, objOffset - ofs);
+			return new DeltaOfsPackedObjectLoader(this, pos + p, objOffset,
+					(int) dataSize, objOffset - ofs);
 		}
 		case Constants.OBJ_REF_DELTA: {
 			readFully(pos, ib, 0, 20, curs);
-			return new DeltaRefPackedObjectLoader(curs, this, pos + ib.length,
+			return new DeltaRefPackedObjectLoader(this, pos + ib.length,
 					objOffset, (int) dataSize, ObjectId.fromRaw(ib));
 		}
 		default:
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
index c2e6c4b..e1397fd 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
@@ -720,7 +720,7 @@ private void writeWholeObject(final ObjectToPack otp) throws IOException {
 		if (otp.hasReuseLoader()) {
 			final PackedObjectLoader loader = otp.getReuseLoader();
 			writeObjectHeader(otp.getType(), loader.getSize());
-			loader.copyRawData(out, buf);
+			loader.copyRawData(out, buf, windowCursor);
 			otp.disposeLoader();
 		} else {
 			final ObjectLoader loader = db.openObject(windowCursor, otp);
@@ -756,7 +756,7 @@ private void writeDeltaObject(final ObjectToPack otp) throws IOException {
 			otp.getDeltaBaseId().copyRawTo(buf, 0);
 			out.write(buf, 0, Constants.OBJECT_ID_LENGTH);
 		}
-		loader.copyRawData(out, buf);
+		loader.copyRawData(out, buf, windowCursor);
 		otp.disposeLoader();
 	}
 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackedObjectLoader.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackedObjectLoader.java
index 56985c1..60333e7 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackedObjectLoader.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackedObjectLoader.java
@@ -47,8 +47,6 @@
 abstract class PackedObjectLoader extends ObjectLoader {
 	protected final PackFile pack;
 
-	protected final WindowCursor curs;
-
 	protected final long dataOffset;
 
 	protected final long objectOffset;
@@ -57,26 +55,53 @@
 
 	protected int objectSize;
 
-	PackedObjectLoader(final WindowCursor c, final PackFile pr,
-			final long dataOffset, final long objectOffset) {
-		curs = c;
+	protected byte[] cachedBytes;
+
+	PackedObjectLoader(final PackFile pr, final long dataOffset,
+			final long objectOffset) {
 		pack = pr;
 		this.dataOffset = dataOffset;
 		this.objectOffset = objectOffset;
 	}
 
-	public int getType() throws IOException {
+	/**
+	 * Force this object to be loaded into memory and pinned in this loader.
+	 * <p>
+	 * Once materialized, subsequent get operations for the following methods
+	 * will always succeed without raising an exception, as all information is
+	 * pinned in memory by this loader instance.
+	 * <ul>
+	 * <li>{@link #getType()}</li>
+	 * <li>{@link #getSize()}</li>
+	 * <li>{@link #getBytes()}, {@link #getCachedBytes}</li>
+	 * <li>{@link #getRawSize()}</li>
+	 * <li>{@link #getRawType()}</li>
+	 * </ul>
+	 *
+	 * @param curs
+	 *            temporary thread storage during data access.
+	 * @throws IOException
+	 *             the object cannot be read.
+	 */
+	public abstract void materialize(WindowCursor curs) throws IOException;
+
+	public final int getType() {
 		return objectType;
 	}
 
-	public long getSize() throws IOException {
+	public final long getSize() {
 		return objectSize;
 	}
 
+	@Override
+	public final byte[] getCachedBytes() {
+		return cachedBytes;
+	}
+
 	/**
 	 * @return offset of object data within pack file
 	 */
-	public long getDataOffset() {
+	public final long getDataOffset() {
 		return dataOffset;
 	}
 
@@ -92,11 +117,14 @@ public long getDataOffset() {
 	 * @param buf
 	 *            temporary buffer used during copying. Recommended size is at
 	 *            least few kB.
+	 * @param curs
+	 *            temporary thread storage during data access.
 	 * @throws IOException
 	 *             when the object cannot be read.
 	 */
-	public void copyRawData(OutputStream out, byte buf[]) throws IOException {
-		pack.copyRawData(this, out, buf);
+	public void copyRawData(OutputStream out, byte buf[], WindowCursor curs)
+			throws IOException {
+		pack.copyRawData(this, out, buf, curs);
 	}
 
 	/**
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/WholePackedObjectLoader.java b/org.spearce.jgit/src/org/spearce/jgit/lib/WholePackedObjectLoader.java
index 3b4f90d..a1df3d2 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/WholePackedObjectLoader.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/WholePackedObjectLoader.java
@@ -46,30 +46,33 @@
 class WholePackedObjectLoader extends PackedObjectLoader {
 	private static final int OBJ_COMMIT = Constants.OBJ_COMMIT;
 
-	WholePackedObjectLoader(final WindowCursor curs, final PackFile pr,
-			final long dataOffset, final long objectOffset, final int type,
-			final int size) {
-		super(curs, pr, dataOffset, objectOffset);
+	WholePackedObjectLoader(final PackFile pr, final long dataOffset,
+			final long objectOffset, final int type, final int size) {
+		super(pr, dataOffset, objectOffset);
 		objectType = type;
 		objectSize = size;
 	}
 
 	@Override
-	public byte[] getCachedBytes() throws IOException {
+	public void materialize(final WindowCursor curs) throws IOException {
+		if (cachedBytes != null) {
+			return;
+		}
+
 		if (objectType != OBJ_COMMIT) {
 			final UnpackedObjectCache.Entry cache = pack.readCache(dataOffset);
 			if (cache != null) {
 				curs.release();
-				return cache.data;
+				cachedBytes = cache.data;
+				return;
 			}
 		}
 
 		try {
-			final byte[] data = pack.decompress(dataOffset, objectSize, curs);
+			cachedBytes = pack.decompress(dataOffset, objectSize, curs);
 			curs.release();
 			if (objectType != OBJ_COMMIT)
-				pack.saveCache(dataOffset, data, objectType);
-			return data;
+				pack.saveCache(dataOffset, cachedBytes, objectType);
 		} catch (DataFormatException dfe) {
 			final CorruptObjectException coe;
 			coe = new CorruptObjectException("Object at " + dataOffset + " in "
-- 
1.6.3.rc1.205.g37f8

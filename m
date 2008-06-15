From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 13/20] Raw-data operations in ObjectLoaders and PackFile
Date: Sun, 15 Jun 2008 23:45:42 +0200
Message-ID: <1213566349-25395-14-git-send-email-marek.zawirski@gmail.com>
References: <1213566349-25395-1-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-2-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-3-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-4-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-5-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-6-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-7-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-8-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-9-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-10-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-11-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-12-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-13-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Jun 15 23:48:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K805I-0001vQ-Jv
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 23:48:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753683AbYFOVrd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 17:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753626AbYFOVrc
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 17:47:32 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:31454 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753345AbYFOVrb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 17:47:31 -0400
Received: by yw-out-2324.google.com with SMTP id 9so2958678ywe.1
        for <git@vger.kernel.org>; Sun, 15 Jun 2008 14:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=SrS9SLvz17Ef7xdCtu8U9aw4Elx4tcufoNS9rcWXZKE=;
        b=aZGK8mQE9Q23fY5Y68ngxicA3mCFMbjB5CUMfycJwXeTmghF/O/bc78UULujryrZq3
         oi7o8CSve3tfUwycbCql1TIIRAXPV3YddGyrCw7itcKUi2UXlcjZbBPX90b22T80biHo
         ObpbSk5xYRnJUjdNS3m47VVKfJZRUcfcEApBw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Nn+c8b6ppMtoyTt679YTgokif5jJWA63RWl3LGIbP1K/fdf32+m6VrZyKvjQu9f1+e
         Tkj5X5aiKZhTjVkFI46mg3JRSpH3T+2PkY8upZoob2qtoKMy+UneHC9+IL/XyZWiMauX
         cGFTS3XzIl/DI8QoEHPjJCDMs3LHZMS5MCzuo=
Received: by 10.150.199.21 with SMTP id w21mr592981ybf.121.1213566450818;
        Sun, 15 Jun 2008 14:47:30 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id p31sm4741564qbp.6.2008.06.15.14.47.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 15 Jun 2008 14:47:29 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1213566349-25395-13-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85138>

Expose operations on raw-data (storage specific) in ObjectLoaders and
subclasses:
- getRawType() giving access to the object type at PackFile header level
- getRawSize() giving access to the size of this object at PackFile
  header level
- getDeltaBase() determining delta base if applicable
- copyRawData() allowing direct copying raw (compressed or delitified)
  object data if possible
+ helper fields, methods in ObjectLoaders
+ helper methods/core engine in PackFile

New operations do not introduce any signifficant performance overhead
when not used.

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../jgit/lib/DeltaOfsPackedObjectLoader.java       |   21 ++++++-
 .../spearce/jgit/lib/DeltaPackedObjectLoader.java  |    9 ++-
 .../jgit/lib/DeltaRefPackedObjectLoader.java       |   15 ++++-
 .../src/org/spearce/jgit/lib/ObjectLoader.java     |   24 +++++++
 .../src/org/spearce/jgit/lib/PackFile.java         |   65 ++++++++++++++++++-
 .../org/spearce/jgit/lib/PackedObjectLoader.java   |   44 +++++++++++++-
 .../org/spearce/jgit/lib/UnpackedObjectLoader.java |   10 +++
 .../spearce/jgit/lib/WholePackedObjectLoader.java  |   20 ++++++-
 8 files changed, 194 insertions(+), 14 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/DeltaOfsPackedObjectLoader.java b/org.spearce.jgit/src/org/spearce/jgit/lib/DeltaOfsPackedObjectLoader.java
index edbeef9..5c9fb00 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/DeltaOfsPackedObjectLoader.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/DeltaOfsPackedObjectLoader.java
@@ -40,17 +40,34 @@ package org.spearce.jgit.lib;
 
 import java.io.IOException;
 
+import org.spearce.jgit.errors.CorruptObjectException;
+
 /** Reads a deltified object which uses an offset to find its base. */
 class DeltaOfsPackedObjectLoader extends DeltaPackedObjectLoader {
 	private final long deltaBase;
 
 	DeltaOfsPackedObjectLoader(final WindowCursor curs, final PackFile pr,
-			final long offset, final int deltaSz, final long base) {
-		super(curs, pr, offset, deltaSz);
+			final long dataOffset, final long objectOffset, final int deltaSz,
+			final long base) {
+		super(curs, pr, dataOffset, objectOffset, deltaSz);
 		deltaBase = base;
 	}
 
 	protected PackedObjectLoader getBaseLoader() throws IOException {
 		return pack.resolveBase(curs, deltaBase);
 	}
+
+	@Override
+	public int getRawType() {
+		return Constants.OBJ_OFS_DELTA;
+	}
+
+	@Override
+	public ObjectId getDeltaBase() throws IOException {
+		final ObjectId id = pack.findObjectForOffset(deltaBase);
+		if (id == null)
+			throw new CorruptObjectException(
+					"Offset-written delta base for object not found in a pack");
+		return id;
+	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/DeltaPackedObjectLoader.java b/org.spearce.jgit/src/org/spearce/jgit/lib/DeltaPackedObjectLoader.java
index 4813572..e73f8e5 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/DeltaPackedObjectLoader.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/DeltaPackedObjectLoader.java
@@ -50,8 +50,8 @@ abstract class DeltaPackedObjectLoader extends PackedObjectLoader {
 	private final int deltaSize;
 
 	DeltaPackedObjectLoader(final WindowCursor curs, final PackFile pr,
-			final long offset, final int deltaSz) {
-		super(curs, pr, offset);
+			final long dataOffset, final long objectOffset, final int deltaSz) {
+		super(curs, pr, dataOffset, objectOffset);
 		objectType = -1;
 		deltaSize = deltaSz;
 	}
@@ -98,6 +98,11 @@ abstract class DeltaPackedObjectLoader extends PackedObjectLoader {
 		}
 	}
 
+	@Override
+	public long getRawSize() {
+		return deltaSize;
+	}
+
 	/**
 	 * @return the object loader for the base object
 	 * @throws IOException
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/DeltaRefPackedObjectLoader.java b/org.spearce.jgit/src/org/spearce/jgit/lib/DeltaRefPackedObjectLoader.java
index fb87abc..042d3a8 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/DeltaRefPackedObjectLoader.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/DeltaRefPackedObjectLoader.java
@@ -47,8 +47,9 @@ class DeltaRefPackedObjectLoader extends DeltaPackedObjectLoader {
 	private final ObjectId deltaBase;
 
 	DeltaRefPackedObjectLoader(final WindowCursor curs, final PackFile pr,
-			final long offset, final int deltaSz, final ObjectId base) {
-		super(curs, pr, offset, deltaSz);
+			final long dataOffset, final long objectOffset, final int deltaSz,
+			final ObjectId base) {
+		super(curs, pr, dataOffset, objectOffset, deltaSz);
 		deltaBase = base;
 	}
 
@@ -58,4 +59,14 @@ class DeltaRefPackedObjectLoader extends DeltaPackedObjectLoader {
 			throw new MissingObjectException(deltaBase, "delta base");
 		return or;
 	}
+
+	@Override
+	public int getRawType() throws IOException {
+		return Constants.OBJ_REF_DELTA;
+	}
+
+	@Override
+	public ObjectId getDeltaBase() throws IOException {
+		return deltaBase;
+	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectLoader.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectLoader.java
index 3a96dd1..5282491 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectLoader.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectLoader.java
@@ -66,6 +66,13 @@ public abstract class ObjectLoader {
 	}
 
 	/**
+	 * @return true if id of loaded object is already known, false otherwise.
+	 */
+	protected boolean hasComputedId() {
+		return objectId != null;
+	}
+
+	/**
 	 * Set the SHA-1 id of the object handled by this loader
 	 * 
 	 * @param id
@@ -113,4 +120,21 @@ public abstract class ObjectLoader {
 	 *             the object cannot be read.
 	 */
 	public abstract byte[] getCachedBytes() throws IOException;
+
+	/**
+	 * @return raw object type from object header, as stored in storage (pack,
+	 *         loose file). This may be different from {@link #getType()} result
+	 *         for packs (see {@link Constants}).
+	 * @throws IOException
+	 *             when type cannot be read from the object header.
+	 */
+	public abstract int getRawType() throws IOException;
+
+	/**
+	 * @return raw size of object from object header (pack, loose file).
+	 *         Interpretation of this value depends on {@link #getRawType()}.
+	 * @throws IOException
+	 *             when raw size cannot be read from the object header.
+	 */
+	public abstract long getRawSize() throws IOException;
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
index 3880966..9992615 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
@@ -38,11 +38,16 @@
 
 package org.spearce.jgit.lib;
 
+import java.io.EOFException;
 import java.io.File;
 import java.io.IOException;
+import java.io.OutputStream;
 import java.util.Iterator;
+import java.util.zip.CRC32;
+import java.util.zip.CheckedOutputStream;
 import java.util.zip.DataFormatException;
 
+import org.spearce.jgit.errors.CorruptObjectException;
 import org.spearce.jgit.util.NB;
 
 /**
@@ -201,6 +206,52 @@ public class PackFile implements Iterable<PackIndex.MutableEntry> {
 		return dstbuf;
 	}
 
+	final void copyRawData(final PackedObjectLoader loader,
+			final OutputStream out, final byte buf[]) throws IOException {
+		final long objectOffset = loader.objectOffset;
+		final long dataOffset = loader.dataOffset;
+		final int cnt = (int) (findEndOffset(objectOffset) - dataOffset);
+		final WindowCursor curs = loader.curs;
+
+		if (idx.hasCRC32Support()) {
+			final CRC32 crc = new CRC32();
+			int headerCnt = (int) (dataOffset - objectOffset);
+			while (headerCnt > 0) {
+				int toRead = Math.min(headerCnt, buf.length);
+				int read = pack.read(objectOffset, buf, 0, toRead, curs);
+				if (read != toRead)
+					throw new EOFException();
+				crc.update(buf, 0, read);
+				headerCnt -= toRead;
+			}
+			final CheckedOutputStream crcOut = new CheckedOutputStream(out, crc);
+			pack.copyToStream(dataOffset, buf, cnt, crcOut, curs);
+			final long computed = crc.getValue();
+
+			ObjectId id;
+			if (loader.hasComputedId())
+				id = loader.getId();
+			else
+				id = findObjectForOffset(objectOffset);
+			final long expected = idx.findCRC32(id);
+			if (computed != expected)
+				throw new CorruptObjectException(id,
+						"Possible data corruption - CRC32 of raw pack data (object offset "
+								+ objectOffset
+								+ ") mismatch CRC32 from pack index");
+		} else {
+			pack.copyToStream(dataOffset, buf, cnt, out, curs);
+
+			// read to verify against Adler32 zlib checksum
+			loader.getCachedBytes();
+		}
+	}
+	
+	boolean supportsFastCopyRawData() {
+		return idx.hasCRC32Support();
+	}
+
+
 	private void readPackHeader() throws IOException {
 		final WindowCursor curs = new WindowCursor();
 		long position = 0;
@@ -252,8 +303,8 @@ public class PackFile implements Iterable<PackIndex.MutableEntry> {
 		case Constants.OBJ_TREE:
 		case Constants.OBJ_BLOB:
 		case Constants.OBJ_TAG:
-			return new WholePackedObjectLoader(curs, this, pos, typeCode,
-					(int) dataSize);
+			return new WholePackedObjectLoader(curs, this, pos, objOffset,
+					typeCode, (int) dataSize);
 
 		case Constants.OBJ_OFS_DELTA: {
 			pack.readFully(pos, ib, curs);
@@ -267,18 +318,24 @@ public class PackFile implements Iterable<PackIndex.MutableEntry> {
 				ofs += (c & 127);
 			}
 			return new DeltaOfsPackedObjectLoader(curs, this, pos + p,
-					(int) dataSize, objOffset - ofs);
+					objOffset, (int) dataSize, objOffset - ofs);
 		}
 		case Constants.OBJ_REF_DELTA: {
 			pack.readFully(pos, ib, curs);
 			return new DeltaRefPackedObjectLoader(curs, this, pos + ib.length,
-					(int) dataSize, ObjectId.fromRaw(ib));
+					objOffset, (int) dataSize, ObjectId.fromRaw(ib));
 		}
 		default:
 			throw new IOException("Unknown object type " + typeCode + ".");
 		}
 	}
 
+	private long findEndOffset(final long startOffset)
+			throws CorruptObjectException {
+		final long maxOffset = pack.length() - Constants.OBJECT_ID_LENGTH;
+		return getReverseIdx().findNextOffset(startOffset, maxOffset);
+	}
+
 	private PackReverseIndex getReverseIdx() {
 		if (reverseIdx == null)
 			reverseIdx = new PackReverseIndex(idx);
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackedObjectLoader.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackedObjectLoader.java
index 43d43e6..b433609 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackedObjectLoader.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackedObjectLoader.java
@@ -39,6 +39,7 @@
 package org.spearce.jgit.lib;
 
 import java.io.IOException;
+import java.io.OutputStream;
 
 /**
  * Base class for a set of object loader classes for packed objects.
@@ -50,15 +51,18 @@ abstract class PackedObjectLoader extends ObjectLoader {
 
 	protected final long dataOffset;
 
+	protected final long objectOffset;
+
 	protected int objectType;
 
 	protected int objectSize;
 
 	PackedObjectLoader(final WindowCursor c, final PackFile pr,
-			final long offset) {
+			final long dataOffset, final long objectOffset) {
 		curs = c;
 		pack = pr;
-		dataOffset = offset;
+		this.dataOffset = dataOffset;
+		this.objectOffset = objectOffset;
 	}
 
 	public int getType() throws IOException {
@@ -82,4 +86,40 @@ abstract class PackedObjectLoader extends ObjectLoader {
 		System.arraycopy(data, 0, copy, 0, data.length);
 		return data;
 	}
+
+	/**
+	 * Copy raw object representation from storage to provided output stream.
+	 * <p>
+	 * Copied data doesn't include object header. User must provide temporary
+	 * buffer used during copying by underlying I/O layer.
+	 * </p>
+	 * 
+	 * @param out
+	 *            output stream when data is copied. No buffering is guaranteed.
+	 * @param buf
+	 *            temporary buffer used during copying. Recommended size is at
+	 *            least few kB.
+	 * @throws IOException
+	 *             when the object cannot be read.
+	 */
+	public void copyRawData(OutputStream out, byte buf[]) throws IOException {
+		pack.copyRawData(this, out, buf);
+	}
+
+	/**
+	 * @return true if this loader is capable of fast raw-data copying basing on
+	 *         compressed data checksum; false if raw-data copying needs
+	 *         uncompressing and compressing data
+	 */
+	public boolean supportsFastCopyRawData() {
+		return pack.supportsFastCopyRawData();
+	}
+
+	/**
+	 * @return id of delta base object for this object representation. null if
+	 *         object is not stored as delta.
+	 * @throws IOException
+	 *             when delta base cannot read.
+	 */
+	public abstract ObjectId getDeltaBase() throws IOException;
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/UnpackedObjectLoader.java b/org.spearce.jgit/src/org/spearce/jgit/lib/UnpackedObjectLoader.java
index a5c484b..65072f0 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/UnpackedObjectLoader.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/UnpackedObjectLoader.java
@@ -208,4 +208,14 @@ public class UnpackedObjectLoader extends ObjectLoader {
 	public byte[] getCachedBytes() throws IOException {
 		return bytes;
 	}
+
+	@Override
+	public int getRawType() {
+		return objectType;
+	}
+
+	@Override
+	public long getRawSize() {
+		return objectSize;
+	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/WholePackedObjectLoader.java b/org.spearce.jgit/src/org/spearce/jgit/lib/WholePackedObjectLoader.java
index e54fba6..7185df5 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/WholePackedObjectLoader.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/WholePackedObjectLoader.java
@@ -47,8 +47,9 @@ class WholePackedObjectLoader extends PackedObjectLoader {
 	private static final int OBJ_COMMIT = Constants.OBJ_COMMIT;
 
 	WholePackedObjectLoader(final WindowCursor curs, final PackFile pr,
-			final long offset, final int type, final int size) {
-		super(curs, pr, offset);
+			final long dataOffset, final long objectOffset, final int type,
+			final int size) {
+		super(curs, pr, dataOffset, objectOffset);
 		objectType = type;
 		objectSize = size;
 	}
@@ -76,4 +77,19 @@ class WholePackedObjectLoader extends PackedObjectLoader {
 			throw coe;
 		}
 	}
+
+	@Override
+	public int getRawType() {
+		return objectType;
+	}
+
+	@Override
+	public long getRawSize() {
+		return objectSize;
+	}
+
+	@Override
+	public ObjectId getDeltaBase() {
+		return null;
+	}
 }
-- 
1.5.5.1

From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 09/23] Remove getId from ObjectLoader API as its unnecessary overhead
Date: Wed, 24 Dec 2008 18:11:05 -0800
Message-ID: <1230171079-17156-10-git-send-email-spearce@spearce.org>
References: <1230171079-17156-1-git-send-email-spearce@spearce.org>
 <1230171079-17156-2-git-send-email-spearce@spearce.org>
 <1230171079-17156-3-git-send-email-spearce@spearce.org>
 <1230171079-17156-4-git-send-email-spearce@spearce.org>
 <1230171079-17156-5-git-send-email-spearce@spearce.org>
 <1230171079-17156-6-git-send-email-spearce@spearce.org>
 <1230171079-17156-7-git-send-email-spearce@spearce.org>
 <1230171079-17156-8-git-send-email-spearce@spearce.org>
 <1230171079-17156-9-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Dec 25 03:13:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LFfjL-00029A-3T
	for gcvg-git-2@gmane.org; Thu, 25 Dec 2008 03:13:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751779AbYLYCLo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Dec 2008 21:11:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751755AbYLYCLk
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Dec 2008 21:11:40 -0500
Received: from george.spearce.org ([209.20.77.23]:59414 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751549AbYLYCL0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Dec 2008 21:11:26 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 84FD838222; Thu, 25 Dec 2008 02:11:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id BAD783821F;
	Thu, 25 Dec 2008 02:11:22 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc4.301.g5497a
In-Reply-To: <1230171079-17156-9-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103874>

Apparently nobody actually requires the getId() method on an ObjectLoader.
In every single location where the getId() is being used the caller has
an AnyObjectId wich the proper value already in-scope, typically the value
they passed into Repository.openObject().  Avoiding having the id in the
loader API means PackFile doesn't have to copy a MutableObjectId into an
immutable ObjectId, saving an object allocation per object lookup.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../tst/org/spearce/jgit/lib/T0004_PackReader.java |    2 -
 .../jgit/errors/CorruptObjectException.java        |   12 ++++++
 .../src/org/spearce/jgit/lib/Constants.java        |    2 +-
 .../spearce/jgit/lib/DeltaPackedObjectLoader.java  |    3 +-
 .../src/org/spearce/jgit/lib/ObjectLoader.java     |   38 --------------------
 .../src/org/spearce/jgit/lib/PackFile.java         |   12 +-----
 .../src/org/spearce/jgit/lib/Repository.java       |    2 +-
 .../org/spearce/jgit/lib/UnpackedObjectLoader.java |   12 +++----
 .../spearce/jgit/lib/WholePackedObjectLoader.java  |    3 +-
 .../src/org/spearce/jgit/revwalk/RevWalk.java      |    8 ++--
 .../jgit/transport/WalkFetchConnection.java        |   15 +++++++-
 11 files changed, 42 insertions(+), 67 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0004_PackReader.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0004_PackReader.java
index f6fff52..6ffb904 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0004_PackReader.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0004_PackReader.java
@@ -57,7 +57,6 @@ public void test003_lookupCompressedObject() throws IOException {
 		pr = new PackFile(db, TEST_IDX, TEST_PACK);
 		or = pr.get(new WindowCursor(), id);
 		assertNotNull(or);
-		assertEquals(id, or.getId());
 		assertEquals(Constants.OBJ_TREE, or.getType());
 		assertEquals(35, or.getSize());
 		assertEquals(7738, or.getDataOffset());
@@ -72,7 +71,6 @@ public void test004_lookupDeltifiedObject() throws IOException {
 		or = db.openObject(id);
 		assertNotNull(or);
 		assertTrue(or instanceof PackedObjectLoader);
-		assertEquals(id, or.getId());
 		assertEquals(Constants.OBJ_BLOB, or.getType());
 		assertEquals(18009, or.getSize());
 		assertEquals(537, ((PackedObjectLoader) or).getDataOffset());
diff --git a/org.spearce.jgit/src/org/spearce/jgit/errors/CorruptObjectException.java b/org.spearce.jgit/src/org/spearce/jgit/errors/CorruptObjectException.java
index 4eb7aa6..2b0e287 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/errors/CorruptObjectException.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/errors/CorruptObjectException.java
@@ -40,6 +40,7 @@
 
 import java.io.IOException;
 
+import org.spearce.jgit.lib.AnyObjectId;
 import org.spearce.jgit.lib.ObjectId;
 
 /**
@@ -55,6 +56,17 @@
 	 * @param id
 	 * @param why
 	 */
+	public CorruptObjectException(final AnyObjectId id, final String why) {
+		this(id.toObjectId(), why);
+	}
+
+	/**
+	 * Construct a CorruptObjectException for reporting a problem specified
+	 * object id
+	 *
+	 * @param id
+	 * @param why
+	 */
 	public CorruptObjectException(final ObjectId id, final String why) {
 		super("Object " + id.name() + " is corrupt: " + why);
 	}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java
index 9613d07..8f093d6 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java
@@ -311,7 +311,7 @@ public static String typeString(final int typeCode) {
 	 * @throws CorruptObjectException
 	 *             there is no valid type identified by <code>typeString</code>.
 	 */
-	public static int decodeTypeString(final ObjectId id,
+	public static int decodeTypeString(final AnyObjectId id,
 			final byte[] typeString, final byte endMark,
 			final MutableInteger offset) throws CorruptObjectException {
 		try {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/DeltaPackedObjectLoader.java b/org.spearce.jgit/src/org/spearce/jgit/lib/DeltaPackedObjectLoader.java
index e73f8e5..85f2bda 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/DeltaPackedObjectLoader.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/DeltaPackedObjectLoader.java
@@ -92,7 +92,8 @@ public long getSize() throws IOException {
 			return data;
 		} catch (DataFormatException dfe) {
 			final CorruptObjectException coe;
-			coe = new CorruptObjectException(getId(), "bad stream");
+			coe = new CorruptObjectException("Object at " + dataOffset + " in "
+					+ pack.getPackFile() + " has bad zlib stream");
 			coe.initCause(dfe);
 			throw coe;
 		}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectLoader.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectLoader.java
index 8d745dd..5485d8d 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectLoader.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectLoader.java
@@ -39,50 +39,12 @@
 package org.spearce.jgit.lib;
 
 import java.io.IOException;
-import java.security.MessageDigest;
 
 /**
  * Base class for a set of loaders for different representations of Git objects.
  * New loaders are constructed for every object.
  */
 public abstract class ObjectLoader {
-	private ObjectId objectId;
-
-	/**
-	 * @return the id of this object, possibly computed on demand
-	 * @throws IOException
-	 */
-	public ObjectId getId() throws IOException {
-		if (objectId == null) {
-			final MessageDigest md = Constants.newMessageDigest();
-			md.update(Constants.encodedTypeString(getType()));
-			md.update((byte) ' ');
-			md.update(Constants.encodeASCII(getSize()));
-			md.update((byte) 0);
-			md.update(getCachedBytes());
-			objectId = ObjectId.fromRaw(md.digest());
-		}
-		return objectId;
-	}
-
-	/**
-	 * @return true if id of loaded object is already known, false otherwise.
-	 */
-	protected boolean hasComputedId() {
-		return objectId != null;
-	}
-
-	/**
-	 * Set the SHA-1 id of the object handled by this loader
-	 * 
-	 * @param id
-	 */
-	protected void setId(final ObjectId id) {
-		if (objectId != null)
-			throw new IllegalStateException("Id already set.");
-		objectId = id;
-	}
-
 	/**
 	 * @return Git in pack object type, see {@link Constants}.
 	 * @throws IOException
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
index cd17bd4..3cdca8f 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
@@ -129,11 +129,7 @@ public boolean hasObject(final AnyObjectId id) {
 	public PackedObjectLoader get(final WindowCursor curs, final AnyObjectId id)
 			throws IOException {
 		final long offset = idx.findOffset(id);
-		if (offset == -1)
-			return null;
-		final PackedObjectLoader objReader = reader(curs, offset);
-		objReader.setId(id.toObjectId());
-		return objReader;
+		return 0 < offset ? reader(curs, offset) : null;
 	}
 
 	/**
@@ -219,11 +215,7 @@ final void copyRawData(final PackedObjectLoader loader,
 			pack.copyToStream(dataOffset, buf, cnt, crcOut, curs);
 			final long computed = crc.getValue();
 
-			ObjectId id;
-			if (loader.hasComputedId())
-				id = loader.getId();
-			else
-				id = findObjectForOffset(objectOffset);
+			final ObjectId id = findObjectForOffset(objectOffset);
 			final long expected = idx.findCRC32(id);
 			if (computed != expected)
 				throw new CorruptObjectException(id,
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index 8f6e96e..02f8103 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -317,7 +317,7 @@ public ObjectLoader openObject(final WindowCursor curs, final AnyObjectId id)
 			} while (k > 0);
 		}
 		try {
-			return new UnpackedObjectLoader(this, id.toObjectId());
+			return new UnpackedObjectLoader(this, id);
 		} catch (FileNotFoundException fnfe) {
 			return null;
 		}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/UnpackedObjectLoader.java b/org.spearce.jgit/src/org/spearce/jgit/lib/UnpackedObjectLoader.java
index 3ad273f..0560c3a 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/UnpackedObjectLoader.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/UnpackedObjectLoader.java
@@ -67,13 +67,13 @@
 	 *            SHA-1
 	 * @throws IOException
 	 */
-	public UnpackedObjectLoader(final Repository db, final ObjectId id)
+	public UnpackedObjectLoader(final Repository db, final AnyObjectId id)
 			throws IOException {
 		this(readCompressed(db, id), id);
 	}
 
-	private static byte[] readCompressed(final Repository db, final ObjectId id)
-			throws FileNotFoundException, IOException {
+	private static byte[] readCompressed(final Repository db,
+			final AnyObjectId id) throws FileNotFoundException, IOException {
 		final FileInputStream objStream = new FileInputStream(db.toFile(id));
 		final byte[] compressed;
 		try {
@@ -101,10 +101,8 @@ public UnpackedObjectLoader(final byte[] compressed)
 		this(compressed, null);
 	}
 
-	private UnpackedObjectLoader(final byte[] compressed, final ObjectId id)
+	private UnpackedObjectLoader(final byte[] compressed, final AnyObjectId id)
 			throws CorruptObjectException {
-		setId(id);
-
 		// Try to determine if this is a legacy format loose object or
 		// a new style loose object. The legacy format was completely
 		// compressed with zlib so the first byte must be 0x78 (15-bit
@@ -177,7 +175,7 @@ private UnpackedObjectLoader(final byte[] compressed, final ObjectId id)
 		}
 	}
 
-	private void decompress(final ObjectId id, final Inflater inf, int p)
+	private void decompress(final AnyObjectId id, final Inflater inf, int p)
 			throws CorruptObjectException {
 		try {
 			while (!inf.finished())
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/WholePackedObjectLoader.java b/org.spearce.jgit/src/org/spearce/jgit/lib/WholePackedObjectLoader.java
index 7185df5..3b4f90d 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/WholePackedObjectLoader.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/WholePackedObjectLoader.java
@@ -72,7 +72,8 @@ WholePackedObjectLoader(final WindowCursor curs, final PackFile pr,
 			return data;
 		} catch (DataFormatException dfe) {
 			final CorruptObjectException coe;
-			coe = new CorruptObjectException(getId(), "bad stream");
+			coe = new CorruptObjectException("Object at " + dataOffset + " in "
+					+ pack.getPackFile() + " has bad zlib stream");
 			coe.initCause(dfe);
 			throw coe;
 		}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevWalk.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevWalk.java
index b1571ab..dfb34d9 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevWalk.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevWalk.java
@@ -687,23 +687,23 @@ public RevObject parseAny(final AnyObjectId id)
 			final int type = ldr.getType();
 			switch (type) {
 			case Constants.OBJ_COMMIT: {
-				final RevCommit c = createCommit(ldr.getId());
+				final RevCommit c = createCommit(id);
 				c.parseCanonical(this, data);
 				r = c;
 				break;
 			}
 			case Constants.OBJ_TREE: {
-				r = new RevTree(ldr.getId());
+				r = new RevTree(id);
 				r.flags |= PARSED;
 				break;
 			}
 			case Constants.OBJ_BLOB: {
-				r = new RevBlob(ldr.getId());
+				r = new RevBlob(id);
 				r.flags |= PARSED;
 				break;
 			}
 			case Constants.OBJ_TAG: {
-				final RevTag t = new RevTag(ldr.getId());
+				final RevTag t = new RevTag(id);
 				t.parseCanonical(this, data);
 				r = t;
 				break;
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkFetchConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkFetchConnection.java
index 5d0c6bc..93b5bd2 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkFetchConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkFetchConnection.java
@@ -42,6 +42,7 @@
 import java.io.FileNotFoundException;
 import java.io.FileOutputStream;
 import java.io.IOException;
+import java.security.MessageDigest;
 import java.util.ArrayList;
 import java.util.Collection;
 import java.util.HashMap;
@@ -155,6 +156,8 @@
 
 	private final MutableObjectId idBuffer = new MutableObjectId();
 
+	private final MessageDigest objectDigest = Constants.newMessageDigest();
+
 	/**
 	 * Errors received while trying to obtain an object.
 	 * <p>
@@ -573,9 +576,17 @@ private void verifyLooseObject(final AnyObjectId id, final byte[] compressed)
 			throw e;
 		}
 
-		if (!AnyObjectId.equals(id, uol.getId())) {
+		objectDigest.reset();
+		objectDigest.update(Constants.encodedTypeString(uol.getType()));
+		objectDigest.update((byte) ' ');
+		objectDigest.update(Constants.encodeASCII(uol.getSize()));
+		objectDigest.update((byte) 0);
+		objectDigest.update(uol.getCachedBytes());
+		idBuffer.fromRaw(objectDigest.digest(), 0);
+
+		if (!AnyObjectId.equals(id, idBuffer)) {
 			throw new TransportException("Incorrect hash for " + id.name()
-					+ "; computed " + uol.getId().name() + " as a "
+					+ "; computed " + idBuffer.name() + " as a "
 					+ Constants.encodedTypeString(uol.getType()) + " from "
 					+ compressed.length + " bytes.");
 		}
-- 
1.6.1.rc4.301.g5497a

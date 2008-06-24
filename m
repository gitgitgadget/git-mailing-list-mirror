From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 08/10] Compute packed object entry CRC32 data during IndexPack
Date: Mon, 23 Jun 2008 22:10:06 -0400
Message-ID: <1214273408-70793-9-git-send-email-spearce@spearce.org>
References: <1214273408-70793-1-git-send-email-spearce@spearce.org>
 <1214273408-70793-2-git-send-email-spearce@spearce.org>
 <1214273408-70793-3-git-send-email-spearce@spearce.org>
 <1214273408-70793-4-git-send-email-spearce@spearce.org>
 <1214273408-70793-5-git-send-email-spearce@spearce.org>
 <1214273408-70793-6-git-send-email-spearce@spearce.org>
 <1214273408-70793-7-git-send-email-spearce@spearce.org>
 <1214273408-70793-8-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 04:11:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAy0Y-0005iO-IJ
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 04:11:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753283AbYFXCKt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 22:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753364AbYFXCKs
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 22:10:48 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:49783 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753081AbYFXCKp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 22:10:45 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1KAxzJ-0001P4-Iw; Mon, 23 Jun 2008 22:10:29 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1007)
	id 397F220FBAE; Mon, 23 Jun 2008 22:10:40 -0400 (EDT)
Received: from localhost.localdomain (i2.home.spearce.org [10.123.0.15])
	by asimov.home.spearce.org (Postfix) with ESMTP id 2835320FBCD;
	Mon, 23 Jun 2008 22:10:09 -0400 (EDT)
X-Mailer: git-send-email 1.5.6.74.g8a5e
In-Reply-To: <1214273408-70793-8-git-send-email-spearce@spearce.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85976>

In order to create a pack index using the v2 file format we must
have the CRC32 data available for every object we discovered in
that pack stream.  We now compute this on the fly as we read the
object entries in from the input stream.  Always running the CRC
computation isn't that expensive and we can be certain we would
always have the information necessary to create a v2 index file.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/transport/IndexPack.java  |  135 ++++++++++++++------
 .../spearce/jgit/transport/PackedObjectInfo.java   |   25 ++++-
 2 files changed, 117 insertions(+), 43 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java b/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
index 60e0bce..047f0dc 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
@@ -49,6 +49,7 @@ import java.util.ArrayList;
 import java.util.Arrays;
 import java.util.HashMap;
 import java.util.List;
+import java.util.zip.CRC32;
 import java.util.zip.DataFormatException;
 import java.util.zip.Deflater;
 import java.util.zip.Inflater;
@@ -136,6 +137,8 @@ public class IndexPack {
 
 	private int entryCount;
 
+	private final CRC32 crc = new CRC32();
+
 	private ObjectIdMap<ArrayList<UnresolvedDelta>> baseById;
 
 	private HashMap<Long, ArrayList<UnresolvedDelta>> baseByPos;
@@ -282,13 +285,15 @@ public class IndexPack {
 	}
 
 	private void resolveDeltas(final PackedObjectInfo oe) throws IOException {
+		final int oldCRC = oe.getCRC();
 		if (baseById.containsKey(oe)
 				|| baseByPos.containsKey(new Long(oe.getOffset())))
-			resolveDeltas(oe.getOffset(), Constants.OBJ_BAD, null, oe);
+			resolveDeltas(oe.getOffset(), oldCRC, Constants.OBJ_BAD, null, oe);
 	}
 
-	private void resolveDeltas(final long pos, int type, byte[] data,
-			PackedObjectInfo oe) throws IOException {
+	private void resolveDeltas(final long pos, final int oldCRC, int type,
+			byte[] data, PackedObjectInfo oe) throws IOException {
+		crc.reset();
 		position(pos);
 		int c = readFromFile();
 		final int typeCode = (c >> 4) & 7;
@@ -309,14 +314,14 @@ public class IndexPack {
 			data = inflateFromFile((int) sz);
 			break;
 		case Constants.OBJ_OFS_DELTA: {
-			c = readFromInput() & 0xff;
+			c = readFromFile() & 0xff;
 			while ((c & 128) != 0)
-				c = readFromInput() & 0xff;
+				c = readFromFile() & 0xff;
 			data = BinaryDelta.apply(data, inflateFromFile((int) sz));
 			break;
 		}
 		case Constants.OBJ_REF_DELTA: {
-			fillFromInput(20);
+			crc.update(buf, fillFromFile(20), 20);
 			use(20);
 			data = BinaryDelta.apply(data, inflateFromFile((int) sz));
 			break;
@@ -325,6 +330,9 @@ public class IndexPack {
 			throw new IOException("Unknown object type " + typeCode + ".");
 		}
 
+		final int crc32 = (int) crc.getValue();
+		if (oldCRC != crc32)
+			throw new IOException("Corruption detected re-reading at " + pos);
 		if (oe == null) {
 			objectDigest.update(Constants.encodedTypeString(type));
 			objectDigest.update((byte) ' ');
@@ -332,7 +340,8 @@ public class IndexPack {
 			objectDigest.update((byte) 0);
 			objectDigest.update(data);
 			tempObjectId.fromRaw(objectDigest.digest(), 0);
-			oe = new PackedObjectInfo(pos, tempObjectId);
+
+			oe = new PackedObjectInfo(pos, crc32, tempObjectId);
 			entries[entryCount++] = oe;
 		}
 
@@ -349,20 +358,24 @@ public class IndexPack {
 				final UnresolvedDelta ad = a.get(ai);
 				final UnresolvedDelta bd = b.get(bi);
 				if (ad.position < bd.position) {
-					resolveDeltas(ad.position, type, data, null);
+					resolveDeltas(ad.position, ad.crc, type, data, null);
 					ai++;
 				} else {
-					resolveDeltas(bd.position, type, data, null);
+					resolveDeltas(bd.position, bd.crc, type, data, null);
 					bi++;
 				}
 			}
 		}
 		if (a != null)
-			while (ai < a.size())
-				resolveDeltas(a.get(ai++).position, type, data, null);
+			while (ai < a.size()) {
+				final UnresolvedDelta ad = a.get(ai++);
+				resolveDeltas(ad.position, ad.crc, type, data, null);
+			}
 		if (b != null)
-			while (bi < b.size())
-				resolveDeltas(b.get(bi++).position, type, data, null);
+			while (bi < b.size()) {
+				final UnresolvedDelta bd = b.get(bi++);
+				resolveDeltas(bd.position, bd.crc, type, data, null);
+			}
 	}
 
 	private void fixThinPack(final ProgressMonitor progress) throws IOException {
@@ -377,10 +390,11 @@ public class IndexPack {
 			final int typeCode = ldr.getType();
 			final PackedObjectInfo oe;
 
-			oe = new PackedObjectInfo(end, baseId);
+			crc.reset();
+			writeWhole(def, typeCode, data);
+			oe = new PackedObjectInfo(end, (int) crc.getValue(), baseId);
 			entries[entryCount++] = oe;
 			packOut.seek(end);
-			writeWhole(def, typeCode, data);
 			end = packOut.getFilePointer();
 
 			resolveChildDeltas(oe.getOffset(), typeCode, data, oe);
@@ -403,12 +417,16 @@ public class IndexPack {
 			buf[hdrlen++] = (byte) (sz & 0x7f);
 			sz >>>= 7;
 		}
+		crc.update(buf, 0, hdrlen);
 		packOut.write(buf, 0, hdrlen);
 		def.reset();
 		def.setInput(data);
 		def.finish();
-		while (!def.finished())
-			packOut.write(buf, 0, def.deflate(buf));
+		while (!def.finished()) {
+			final int datlen = def.deflate(buf);
+			crc.update(buf, 0, datlen);
+			packOut.write(buf, 0, datlen);
+		}
 	}
 
 	private void fixHeaderFooter() throws IOException {
@@ -493,6 +511,7 @@ public class IndexPack {
 	private void indexOneObject() throws IOException {
 		final long pos = position();
 
+		crc.reset();
 		int c = readFromInput();
 		final int typeCode = (c >> 4) & 7;
 		long sz = c & 15;
@@ -511,11 +530,11 @@ public class IndexPack {
 			whole(typeCode, pos, sz);
 			break;
 		case Constants.OBJ_OFS_DELTA: {
-			c = readFromInput() & 0xff;
+			c = readFromInput();
 			long ofs = c & 127;
 			while ((c & 128) != 0) {
 				ofs += 1;
-				c = readFromInput() & 0xff;
+				c = readFromInput();
 				ofs <<= 7;
 				ofs += (c & 127);
 			}
@@ -525,25 +544,24 @@ public class IndexPack {
 				r = new ArrayList<UnresolvedDelta>(8);
 				baseByPos.put(base, r);
 			}
-			r.add(new UnresolvedDelta(pos));
-			deltaCount++;
 			inflateFromInput(false);
+			r.add(new UnresolvedDelta(pos, (int) crc.getValue()));
+			deltaCount++;
 			break;
 		}
 		case Constants.OBJ_REF_DELTA: {
 			c = fillFromInput(20);
-			final byte[] ref = new byte[20];
-			System.arraycopy(buf, c, ref, 0, 20);
+			crc.update(buf, c, 20);
+			final ObjectId base = ObjectId.fromRaw(buf, c);
 			use(20);
-			final ObjectId base = ObjectId.fromRaw(ref);
 			ArrayList<UnresolvedDelta> r = baseById.get(base);
 			if (r == null) {
 				r = new ArrayList<UnresolvedDelta>(8);
 				baseById.put(base, r);
 			}
-			r.add(new UnresolvedDelta(pos));
-			deltaCount++;
 			inflateFromInput(false);
+			r.add(new UnresolvedDelta(pos, (int) crc.getValue()));
+			deltaCount++;
 			break;
 		}
 		default:
@@ -559,7 +577,9 @@ public class IndexPack {
 		objectDigest.update((byte) 0);
 		inflateFromInput(true);
 		tempObjectId.fromRaw(objectDigest.digest(), 0);
-		entries[entryCount++] = new PackedObjectInfo(pos, tempObjectId);
+
+		final int crc32 = (int) crc.getValue();
+		entries[entryCount++] = new PackedObjectInfo(pos, crc32, tempObjectId);
 	}
 
 	// Current position of {@link #bOffset} within the entire file.
@@ -579,15 +599,19 @@ public class IndexPack {
 		if (bAvail == 0)
 			fillFromInput(1);
 		bAvail--;
-		return buf[bOffset++] & 0xff;
+		final int b = buf[bOffset++] & 0xff;
+		crc.update(b);
+		return b;
 	}
 
 	// Consume exactly one byte from the buffer and return it.
 	private int readFromFile() throws IOException {
 		if (bAvail == 0)
-			fillFromFile();
+			fillFromFile(1);
 		bAvail--;
-		return buf[bOffset++] & 0xff;
+		final int b = buf[bOffset++] & 0xff;
+		crc.update(b);
+		return b;
 	}
 
 	// Consume cnt bytes from the buffer.
@@ -615,13 +639,21 @@ public class IndexPack {
 	}
 
 	// Ensure at least need bytes are available in in {@link #buf}.
-	private int fillFromFile() throws IOException {
-		if (bAvail == 0) {
-			final int next = packOut.read(buf, 0, buf.length);
+	private int fillFromFile(final int need) throws IOException {
+		if (bAvail < need) {
+			int next = bOffset + bAvail;
+			int free = buf.length - next;
+			if (free + bAvail < need) {
+				if (bAvail > 0)
+					System.arraycopy(buf, bOffset, buf, 0, bAvail);
+				bOffset = 0;
+				next = bAvail;
+				free = buf.length - next;
+			}
+			next = packOut.read(buf, next, free);
 			if (next <= 0)
 				throw new EOFException("Packfile is truncated.");
-			bAvail = next;
-			bOffset = 0;
+			bAvail += next;
 		}
 		return bOffset;
 	}
@@ -642,11 +674,15 @@ public class IndexPack {
 		try {
 			final byte[] dst = objectData;
 			int n = 0;
+			int p = -1;
 			while (!inf.finished()) {
 				if (inf.needsInput()) {
-					final int p = fillFromInput(1);
+					if (p >= 0) {
+						crc.update(buf, p, bAvail);
+						use(bAvail);
+					}
+					p = fillFromInput(1);
 					inf.setInput(buf, p, bAvail);
-					use(bAvail);
 				}
 
 				int free = dst.length - n;
@@ -661,7 +697,11 @@ public class IndexPack {
 			}
 			if (digest)
 				objectDigest.update(dst, 0, n);
-			use(-inf.getRemaining());
+			n = bAvail - inf.getRemaining();
+			if (n > 0) {
+				crc.update(buf, p, n);
+				use(n);
+			}
 		} catch (DataFormatException dfe) {
 			throw corrupt(dfe);
 		} finally {
@@ -674,15 +714,23 @@ public class IndexPack {
 		try {
 			final byte[] dst = new byte[sz];
 			int n = 0;
+			int p = -1;
 			while (!inf.finished()) {
 				if (inf.needsInput()) {
-					final int p = fillFromFile();
+					if (p >= 0) {
+						crc.update(buf, p, bAvail);
+						use(bAvail);
+					}
+					p = fillFromFile(1);
 					inf.setInput(buf, p, bAvail);
-					use(bAvail);
 				}
 				n += inf.inflate(dst, n, sz - n);
 			}
-			use(-inf.getRemaining());
+			n = bAvail - inf.getRemaining();
+			if (n > 0) {
+				crc.update(buf, p, n);
+				use(n);
+			}
 			return dst;
 		} catch (DataFormatException dfe) {
 			throw corrupt(dfe);
@@ -699,8 +747,11 @@ public class IndexPack {
 	private static class UnresolvedDelta {
 		final long position;
 
-		UnresolvedDelta(final long headerOffset) {
+		final int crc;
+
+		UnresolvedDelta(final long headerOffset, final int crc32) {
 			position = headerOffset;
+			crc = crc32;
 		}
 	}
 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/PackedObjectInfo.java b/org.spearce.jgit/src/org/spearce/jgit/transport/PackedObjectInfo.java
index 58feada..eae34df 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/PackedObjectInfo.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/PackedObjectInfo.java
@@ -51,9 +51,13 @@ import org.spearce.jgit.lib.ObjectId;
 public class PackedObjectInfo extends ObjectId {
 	private long offset;
 
-	PackedObjectInfo(final long headerOffset, final AnyObjectId id) {
+	private int crc;
+
+	PackedObjectInfo(final long headerOffset, final int packedCRC,
+			final AnyObjectId id) {
 		super(id);
 		offset = headerOffset;
+		crc = packedCRC;
 	}
 
 	/**
@@ -83,4 +87,23 @@ public class PackedObjectInfo extends ObjectId {
 	public void setOffset(final long offset) {
 		this.offset = offset;
 	}
+
+	/**
+	 * @return the 32 bit CRC checksum for the packed data.
+	 */
+	public int getCRC() {
+		return crc;
+	}
+
+	/**
+	 * Record the 32 bit CRC checksum for the packed data.
+	 * 
+	 * @param crc
+	 *            checksum of all packed data (including object type code,
+	 *            inflated length and delta base reference) as computed by
+	 *            {@link java.util.zip.CRC32}.
+	 */
+	public void setCRC(final int crc) {
+		this.crc = crc;
+	}
 }
-- 
1.5.6.74.g8a5e

From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH] index-pack: Detect SHA-1 hash collisions to avoid replacing objects
Date: Mon, 29 Sep 2008 20:54:47 -0700
Message-ID: <1222746887-7711-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Sep 30 05:55:59 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkWL7-0002WI-78
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 05:55:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753204AbYI3Dyv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2008 23:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751704AbYI3Dyu
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Sep 2008 23:54:50 -0400
Received: from george.spearce.org ([209.20.77.23]:55832 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751590AbYI3Dyt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Sep 2008 23:54:49 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 0455538360; Tue, 30 Sep 2008 03:54:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 4401C38268;
	Tue, 30 Sep 2008 03:54:48 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.2.513.g6dbd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97063>

When indexing a pack file coming in from the network there may
be an object contained in the pack that we already have.  Its
only safe to retain that object in our newly stored pack if it
exactly matches the content we already have on disk.  Storing
a different content for the same object name runs the risk of
allowing a malicious attacker to replace an object in our store.

Data validation is performed the first time we have the object
in memory, which occurs when we first compute its SHA-1.  This
is the earliest opportunity we have to validate that there is
no collision, and it reduces the number of times we need to do
a read for an object.  However our memory usage when we process
a whole object is now increased as the collision test is done
by loading the entire object into memory.  Future improvements
may permit a streaming compare of the objects.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 This is only the first in what will be a series to add basic fsck
 support to jgit.  My day-job application is accepting untrusted
 input through IndexPack so I need to fully validate the objects
 are sane before I can allow them to enter the local repository.

 In the end we'll honor receive.fsckObjects.  But right now this
 is enough to detect evil SHA-1 collisions, and is the same level
 of protection that git.git's index-pack has.

 I'm offering this up for comment because its done and ready for
 inclusion.  The rest of the object fsck rules are going to take
 a bit more time, but I hope to have most of them done tomorrow or
 the day after.

 .../src/org/spearce/jgit/transport/IndexPack.java  |   63 +++++++++++++++++---
 1 files changed, 54 insertions(+), 9 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java b/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
index bc52896..8a66ec9 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
@@ -375,6 +375,7 @@ private void resolveDeltas(final long pos, final int oldCRC, int type,
 			objectDigest.update(data);
 			tempObjectId.fromRaw(objectDigest.digest(), 0);
 
+			verifyNoCollision(type, data);
 			oe = new PackedObjectInfo(pos, crc32, tempObjectId);
 			entries[entryCount++] = oe;
 		}
@@ -622,7 +623,7 @@ private void indexOneObject() throws IOException {
 				r = new ArrayList<UnresolvedDelta>(8);
 				baseByPos.put(base, r);
 			}
-			inflateFromInput(false);
+			skipInflateFromInput(sz);
 			r.add(new UnresolvedDelta(pos, (int) crc.getValue()));
 			deltaCount++;
 			break;
@@ -637,7 +638,7 @@ private void indexOneObject() throws IOException {
 				r = new ArrayList<UnresolvedDelta>(8);
 				baseById.put(base, r);
 			}
-			inflateFromInput(false);
+			skipInflateFromInput(sz);
 			r.add(new UnresolvedDelta(pos, (int) crc.getValue()));
 			deltaCount++;
 			break;
@@ -649,17 +650,30 @@ private void indexOneObject() throws IOException {
 
 	private void whole(final int type, final long pos, final long sz)
 			throws IOException {
+		final byte[] data = inflateFromInput(sz);
 		objectDigest.update(Constants.encodedTypeString(type));
 		objectDigest.update((byte) ' ');
 		objectDigest.update(Constants.encodeASCII(sz));
 		objectDigest.update((byte) 0);
-		inflateFromInput(true);
+		objectDigest.update(data);
 		tempObjectId.fromRaw(objectDigest.digest(), 0);
 
+		verifyNoCollision(type, data);
 		final int crc32 = (int) crc.getValue();
 		entries[entryCount++] = new PackedObjectInfo(pos, crc32, tempObjectId);
 	}
 
+	private void verifyNoCollision(final int type, final byte[] data)
+			throws IOException {
+		final ObjectLoader ldr = repo.openObject(tempObjectId);
+		if (ldr != null) {
+			final byte[] existingData = ldr.getCachedBytes();
+			if (ldr.getType() != type || !Arrays.equals(data, existingData)) {
+				throw new IOException("collision in " + tempObjectId.name());
+			}
+		}
+	}
+
 	// Current position of {@link #bOffset} within the entire file.
 	private long position() {
 		return bBase + bOffset;
@@ -747,7 +761,7 @@ private void sync() throws IOException {
 		bOffset = 0;
 	}
 
-	private void inflateFromInput(final boolean digest) throws IOException {
+	private void skipInflateFromInput(long sz) throws IOException {
 		final Inflater inf = inflater;
 		try {
 			final byte[] dst = objectData;
@@ -765,21 +779,52 @@ private void inflateFromInput(final boolean digest) throws IOException {
 
 				int free = dst.length - n;
 				if (free < 8) {
-					if (digest)
-						objectDigest.update(dst, 0, n);
+					sz -= n;
 					n = 0;
 					free = dst.length;
 				}
-
 				n += inf.inflate(dst, n, free);
 			}
-			if (digest)
-				objectDigest.update(dst, 0, n);
+			if (n != sz)
+				throw new DataFormatException("wrong decompressed length");
+			n = bAvail - inf.getRemaining();
+			if (n > 0) {
+				crc.update(buf, p, n);
+				use(n);
+			}
+		} catch (DataFormatException dfe) {
+			throw corrupt(dfe);
+		} finally {
+			inf.reset();
+		}
+	}
+
+	private byte[] inflateFromInput(final long sz) throws IOException {
+		final byte[] dst = new byte[(int) sz];
+		final Inflater inf = inflater;
+		try {
+			int n = 0;
+			int p = -1;
+			while (!inf.finished()) {
+				if (inf.needsInput()) {
+					if (p >= 0) {
+						crc.update(buf, p, bAvail);
+						use(bAvail);
+					}
+					p = fillFromInput(1);
+					inf.setInput(buf, p, bAvail);
+				}
+
+				n += inf.inflate(dst, n, dst.length - n);
+			}
+			if (n != sz)
+				throw new DataFormatException("wrong decompressed length");
 			n = bAvail - inf.getRemaining();
 			if (n > 0) {
 				crc.update(buf, p, n);
 				use(n);
 			}
+			return dst;
 		} catch (DataFormatException dfe) {
 			throw corrupt(dfe);
 		} finally {
-- 
1.6.0.2.513.g6dbd

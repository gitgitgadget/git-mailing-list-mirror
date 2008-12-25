From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 14/23] Don't unpack delta chains while writing a pack from a pack v1 index
Date: Wed, 24 Dec 2008 18:11:10 -0800
Message-ID: <1230171079-17156-15-git-send-email-spearce@spearce.org>
References: <1230171079-17156-1-git-send-email-spearce@spearce.org>
 <1230171079-17156-2-git-send-email-spearce@spearce.org>
 <1230171079-17156-3-git-send-email-spearce@spearce.org>
 <1230171079-17156-4-git-send-email-spearce@spearce.org>
 <1230171079-17156-5-git-send-email-spearce@spearce.org>
 <1230171079-17156-6-git-send-email-spearce@spearce.org>
 <1230171079-17156-7-git-send-email-spearce@spearce.org>
 <1230171079-17156-8-git-send-email-spearce@spearce.org>
 <1230171079-17156-9-git-send-email-spearce@spearce.org>
 <1230171079-17156-10-git-send-email-spearce@spearce.org>
 <1230171079-17156-11-git-send-email-spearce@spearce.org>
 <1230171079-17156-12-git-send-email-spearce@spearce.org>
 <1230171079-17156-13-git-send-email-spearce@spearce.org>
 <1230171079-17156-14-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Dec 25 03:14:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LFfjN-00029A-Pp
	for gcvg-git-2@gmane.org; Thu, 25 Dec 2008 03:13:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751639AbYLYCLy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Dec 2008 21:11:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751600AbYLYCLv
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Dec 2008 21:11:51 -0500
Received: from george.spearce.org ([209.20.77.23]:59420 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751613AbYLYCLa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Dec 2008 21:11:30 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id EC29538267; Thu, 25 Dec 2008 02:11:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 4C2DC38197;
	Thu, 25 Dec 2008 02:11:24 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc4.301.g5497a
In-Reply-To: <1230171079-17156-14-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103883>

We only need to inflate the delta to verify the content is sane;
going all the way through the delta chain by getCachedBytes is
a massive expensive that we just cannot afford to pay.  This
simple change improves clone time for the Linux kernel from
14m50s to 3m20s, due to the improved throughput in our write
objects phase.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/ByteArrayWindow.java  |   14 ++++++++++++++
 .../src/org/spearce/jgit/lib/ByteBufferWindow.java |   17 +++++++++++++++++
 .../src/org/spearce/jgit/lib/ByteWindow.java       |   10 ++++++++++
 .../src/org/spearce/jgit/lib/PackFile.java         |   18 +++++++++++-------
 .../src/org/spearce/jgit/lib/WindowCursor.java     |   16 ++++++++++++++++
 .../src/org/spearce/jgit/lib/WindowedFile.java     |    5 +++++
 6 files changed, 73 insertions(+), 7 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ByteArrayWindow.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ByteArrayWindow.java
index b32d4f8..7b7c7a4 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/ByteArrayWindow.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ByteArrayWindow.java
@@ -89,6 +89,20 @@ int inflate(final byte[] array, final int pos, final byte[] b, int o,
 		return o;
 	}
 
+	void inflateVerify(final byte[] array, final int pos, final Inflater inf)
+			throws DataFormatException {
+		ensureLoaded(array);
+		while (!inf.finished()) {
+			if (inf.needsInput()) {
+				inf.setInput(array, pos, array.length - pos);
+				break;
+			}
+			inf.inflate(verifyGarbageBuffer, 0, verifyGarbageBuffer.length);
+		}
+		while (!inf.finished() && !inf.needsInput())
+			inf.inflate(verifyGarbageBuffer, 0, verifyGarbageBuffer.length);
+	}
+
 	private synchronized void ensureLoaded(final byte[] array) {
 		if (!loaded) {
 			try {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ByteBufferWindow.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ByteBufferWindow.java
index 03bafb1..a6757e8 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/ByteBufferWindow.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ByteBufferWindow.java
@@ -90,4 +90,21 @@ int inflate(final ByteBuffer buffer, final int pos, final byte[] b, int o,
 			o += inf.inflate(b, o, b.length - o);
 		return o;
 	}
+
+	void inflateVerify(final ByteBuffer buffer, final int pos,
+			final Inflater inf) throws DataFormatException {
+		final byte[] tmp = new byte[512];
+		final ByteBuffer s = buffer.slice();
+		s.position(pos);
+		while (s.remaining() > 0 && !inf.finished()) {
+			if (inf.needsInput()) {
+				final int n = Math.min(s.remaining(), tmp.length);
+				s.get(tmp, 0, n);
+				inf.setInput(tmp, 0, n);
+			}
+			inf.inflate(verifyGarbageBuffer, 0, verifyGarbageBuffer.length);
+		}
+		while (!inf.finished() && !inf.needsInput())
+			inf.inflate(verifyGarbageBuffer, 0, verifyGarbageBuffer.length);
+	}
 }
\ No newline at end of file
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ByteWindow.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ByteWindow.java
index 8d37de7..732664b 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/ByteWindow.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ByteWindow.java
@@ -207,4 +207,14 @@ final int inflate(T ref, long pos, byte[] dstbuf, int dstoff, Inflater inf)
 	 */
 	abstract int inflate(T ref, int pos, byte[] dstbuf, int dstoff, Inflater inf)
 			throws DataFormatException;
+
+	protected static final byte[] verifyGarbageBuffer = new byte[2048];
+
+	final void inflateVerify(T ref, long pos, Inflater inf)
+			throws DataFormatException {
+		inflateVerify(ref, (int) (pos - start), inf);
+	}
+
+	abstract void inflateVerify(T ref, int pos, Inflater inf)
+			throws DataFormatException;
 }
\ No newline at end of file
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
index 3cdca8f..0de4c55 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
@@ -218,15 +218,19 @@ final void copyRawData(final PackedObjectLoader loader,
 			final ObjectId id = findObjectForOffset(objectOffset);
 			final long expected = idx.findCRC32(id);
 			if (computed != expected)
-				throw new CorruptObjectException(id,
-						"Possible data corruption - CRC32 of raw pack data (object offset "
-								+ objectOffset
-								+ ") mismatch CRC32 from pack index");
+				throw new CorruptObjectException("Object at " + dataOffset
+						+ " in " + getPackFile() + " has bad zlib stream");
 		} else {
+			try {
+				pack.verifyCompressed(dataOffset, curs);
+			} catch (DataFormatException dfe) {
+				final CorruptObjectException coe;
+				coe = new CorruptObjectException("Object at " + dataOffset
+						+ " in " + getPackFile() + " has bad zlib stream");
+				coe.initCause(dfe);
+				throw coe;
+			}
 			pack.copyToStream(dataOffset, buf, cnt, out, curs);
-
-			// read to verify against Adler32 zlib checksum
-			loader.getCachedBytes();
 		}
 	}
 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCursor.java b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCursor.java
index 7aad081..5c8bec5 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCursor.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCursor.java
@@ -125,6 +125,22 @@ int inflate(final WindowedFile provider, long position,
 		}
 	}
 
+	void inflateVerify(final WindowedFile provider, long position)
+			throws IOException, DataFormatException {
+		if (inf == null)
+			inf = InflaterCache.get();
+		else
+			inf.reset();
+		for (;;) {
+			pin(provider, position);
+			window.inflateVerify(handle, position, inf);
+			if (inf.finished())
+				return;
+			position = window.end;
+		}
+	}
+
+	
 	private void pin(final WindowedFile provider, final long position)
 			throws IOException {
 		final ByteWindow w = window;
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowedFile.java b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowedFile.java
index 7626693..5eb8465 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowedFile.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowedFile.java
@@ -248,6 +248,11 @@ void readCompressed(final long position, final byte[] dstbuf,
 			throw new EOFException("Short compressed stream at " + position);
 	}
 
+	void verifyCompressed(final long position, final WindowCursor curs)
+			throws IOException, DataFormatException {
+		curs.inflateVerify(this, position);
+	}
+
 	/**
 	 * Overridable hook called after the file is opened.
 	 * <p>
-- 
1.6.1.rc4.301.g5497a

From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 02/13] Don't use ByteWindows when checking pack file headers/footers
Date: Tue, 28 Apr 2009 14:12:15 -0700
Message-ID: <1240953146-12878-3-git-send-email-spearce@spearce.org>
References: <1240953146-12878-1-git-send-email-spearce@spearce.org>
 <1240953146-12878-2-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Apr 28 23:12:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lyubc-0004xr-Pz
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 23:12:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756989AbZD1VMj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2009 17:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756806AbZD1VMg
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 17:12:36 -0400
Received: from george.spearce.org ([209.20.77.23]:58313 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756028AbZD1VM3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2009 17:12:29 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id D5F4F38268; Tue, 28 Apr 2009 21:12:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 1093638222;
	Tue, 28 Apr 2009 21:12:27 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.rc1.205.g37f8
In-Reply-To: <1240953146-12878-2-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Its highly unlikely we need the 8 KiB surrounding the pack file header
or footer immediately after opening the pack file.  Reading those as
full blocks and registering them in the WindowCache is probably just
churning garbage through the cache.  Instead, read the header with a
single 12 byte read, and the footer with a single 20 byte read, and
bypass the cache altogether.

This nicely removes a deadlock condition we had previously where the
WindowCache was recursively calling itself during the pack file open,
and got stuck on its own locks.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/PackFile.java         |    5 +--
 org.spearce.jgit/src/org/spearce/jgit/util/NB.java |   32 ++++++++++++++++++++
 2 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
index 813ebc7..360442f 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
@@ -389,10 +389,9 @@ void allocWindow(final WindowCursor curs, final int windowId,
 
 	private void onOpenPack() throws IOException {
 		final PackIndex idx = idx();
-		final WindowCursor curs = new WindowCursor();
 		final byte[] buf = new byte[20];
 
-		readFully(0, buf, 0, 12, curs);
+		NB.readFully(fd.getChannel(), 0, buf, 0, 12);
 		if (RawParseUtils.match(buf, 0, Constants.PACK_SIGNATURE) != 4)
 			throw new IOException("Not a PACK file.");
 		final long vers = NB.decodeUInt32(buf, 4);
@@ -406,7 +405,7 @@ private void onOpenPack() throws IOException {
 					+ " index " + idx.getObjectCount()
 					+ ": " + getPackFile());
 
-		readFully(length - 20, buf, 0, 20, curs);
+		NB.readFully(fd.getChannel(), length - 20, buf, 0, 20);
 		if (!Arrays.equals(buf, idx.packChecksum))
 			throw new PackMismatchException("Pack checksum mismatch:"
 					+ " pack " + ObjectId.fromRaw(buf).name()
diff --git a/org.spearce.jgit/src/org/spearce/jgit/util/NB.java b/org.spearce.jgit/src/org/spearce/jgit/util/NB.java
index c65c6fa..4a9c9b9 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/util/NB.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/util/NB.java
@@ -40,6 +40,8 @@
 import java.io.EOFException;
 import java.io.IOException;
 import java.io.InputStream;
+import java.nio.ByteBuffer;
+import java.nio.channels.FileChannel;
 
 /** Conversion utilities for network byte order handling. */
 public final class NB {
@@ -71,6 +73,36 @@ public static void readFully(final InputStream fd, final byte[] dst,
 	}
 
 	/**
+	 * Read the entire byte array into memory, or throw an exception.
+	 * 
+	 * @param fd
+	 *            file to read the data from.
+	 * @param pos
+	 *            position to read from the file at.
+	 * @param dst
+	 *            buffer that must be fully populated, [off, off+len).
+	 * @param off
+	 *            position within the buffer to start writing to.
+	 * @param len
+	 *            number of bytes that must be read.
+	 * @throws EOFException
+	 *             the stream ended before dst was fully populated.
+	 * @throws IOException
+	 *             there was an error reading from the stream.
+	 */
+	public static void readFully(final FileChannel fd, long pos,
+			final byte[] dst, int off, int len) throws IOException {
+		while (len > 0) {
+			final int r = fd.read(ByteBuffer.wrap(dst, off, len), pos);
+			if (r <= 0)
+				throw new EOFException("Short read of block.");
+			pos += r;
+			off += r;
+			len -= r;
+		}
+	}
+
+	/**
 	 * Skip an entire region of an input stream.
 	 * <p>
 	 * The input stream's position is moved forward by the number of requested
-- 
1.6.3.rc1.205.g37f8

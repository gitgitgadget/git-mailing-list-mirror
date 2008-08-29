From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH] index-pack: Avoid disk corruption in objects appended to thin packs
Date: Thu, 28 Aug 2008 22:54:10 -0700
Message-ID: <1219989250-39943-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Aug 29 07:56:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYwx4-0002ZG-04
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 07:55:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbYH2FyN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 01:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbYH2FyN
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 01:54:13 -0400
Received: from george.spearce.org ([209.20.77.23]:39423 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751025AbYH2FyN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 01:54:13 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 600C738376; Fri, 29 Aug 2008 05:54:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 4B93E38360;
	Fri, 29 Aug 2008 05:54:11 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.272.g9ab4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we are appending onto a thin pack we need to make sure the whole
object we wrote into the pack is what is there when we re-read the
pack to compute the final footer.

Nicolas Pitre pointed out the need to perform this sort of compare
in C Git.  We missed it in my first round of index-pack improvements.

We also now take advantage of "roughly" block aligned reads during
the fixup operation.  4k is a popular filesystem block size and by
arranging the code a little differently we can always perform reads
on 4k alignments within the file.  This should make it easier for
the OS to move data to us.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/transport/IndexPack.java  |   47 ++++++++++++++-----
 1 files changed, 34 insertions(+), 13 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java b/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
index 7b1f7ee..d8e6548 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
@@ -76,7 +76,7 @@
 	/** Progress message when computing names of delta compressed objects. */
 	public static final String PROGRESS_RESOLVE_DELTA = "Resolving deltas";
 
-	private static final int BUFFER_SIZE = 2048;
+	private static final int BUFFER_SIZE = 4096;
 
 	/**
 	 * Create an index pack instance to load a new pack into a repository.
@@ -403,6 +403,7 @@ while (bi < b.size()) {
 	private void fixThinPack(final ProgressMonitor progress) throws IOException {
 		growEntries();
 
+		packDigest.reset();
 		originalEOF = packOut.length() - 20;
 		final Deflater def = new Deflater(Deflater.DEFAULT_COMPRESSION, false);
 		long end = originalEOF;
@@ -432,7 +433,7 @@ if (!baseById.isEmpty()) {
 			throw new MissingObjectException(need, "delta base");
 		}
 
-		fixHeaderFooter();
+		fixHeaderFooter(packcsum, packDigest.digest());
 	}
 
 	private void writeWhole(final Deflater def, final int typeCode,
@@ -446,6 +447,7 @@ while (sz > 0) {
 			buf[hdrlen++] = (byte) (sz & 0x7f);
 			sz >>>= 7;
 		}
+		packDigest.update(buf, 0, hdrlen);
 		crc.update(buf, 0, hdrlen);
 		packOut.write(buf, 0, hdrlen);
 		def.reset();
@@ -453,37 +455,56 @@ while (sz > 0) {
 		def.finish();
 		while (!def.finished()) {
 			final int datlen = def.deflate(buf);
+			packDigest.update(buf, 0, datlen);
 			crc.update(buf, 0, datlen);
 			packOut.write(buf, 0, datlen);
 		}
 	}
 
-	private void fixHeaderFooter() throws IOException {
+	private void fixHeaderFooter(final byte[] origcsum, final byte[] tailcsum)
+			throws IOException {
 		final MessageDigest origDigest = Constants.newMessageDigest();
-		long origRemaining = originalEOF - 12;
+		final MessageDigest tailDigest = Constants.newMessageDigest();
+		long origRemaining = originalEOF;
 
 		packOut.seek(0);
-		if (packOut.read(buf, 0, 12) != 12)
-			throw new IOException("Cannot re-read pack header to fix count");
-		origDigest.update(buf, 0, 12);
+		bAvail = 0;
+		bOffset = 0;
+		fillFromFile(12);
+
+		{
+			final int origCnt = (int) Math.min(bAvail, origRemaining);
+			origDigest.update(buf, 0, origCnt);
+			origRemaining -= origCnt;
+			if (origRemaining == 0)
+				tailDigest.update(buf, origCnt, bAvail - origCnt);
+		}
+
 		NB.encodeInt32(buf, 8, entryCount);
 		packOut.seek(0);
 		packOut.write(buf, 0, 12);
+		packOut.seek(bAvail);
 
 		packDigest.reset();
-		packDigest.update(buf, 0, 12);
+		packDigest.update(buf, 0, bAvail);
 		for (;;) {
 			final int n = packOut.read(buf);
 			if (n < 0)
 				break;
-			if (origRemaining > 0) {
-				origDigest.update(buf, 0, (int) Math.min(n, origRemaining));
-				origRemaining -= n;
-			}
+			if (origRemaining != 0) {
+				final int origCnt = (int) Math.min(n, origRemaining);
+				origDigest.update(buf, 0, origCnt);
+				origRemaining -= origCnt;
+				if (origRemaining == 0)
+					tailDigest.update(buf, origCnt, n - origCnt);
+			} else
+				tailDigest.update(buf, 0, n);
+
 			packDigest.update(buf, 0, n);
 		}
 
-		if (!Arrays.equals(origDigest.digest(), packcsum))
+		if (!Arrays.equals(origDigest.digest(), origcsum)
+				|| !Arrays.equals(tailDigest.digest(), tailcsum))
 			throw new IOException("Pack corrupted while writing to filesystem");
 
 		packcsum = packDigest.digest();
-- 
1.6.0.272.g9ab4

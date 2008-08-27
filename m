From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 1/2] index-pack: Avoid disk corruption yielding a valid pack footer checksum
Date: Wed, 27 Aug 2008 14:48:43 -0700
Message-ID: <1219873724-13348-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Aug 27 23:50:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYSto-00014B-Jd
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 23:49:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753286AbYH0Vss (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 17:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753251AbYH0Vsr
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 17:48:47 -0400
Received: from george.spearce.org ([209.20.77.23]:60379 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753044AbYH0Vsq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 17:48:46 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 28D5F38378; Wed, 27 Aug 2008 21:48:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 2905D38360;
	Wed, 27 Aug 2008 21:48:45 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.174.gd789c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93960>

When we are processing a thin pack and making it non-thin we need
to update the header with a new object count.  That causes us to
recompute the footer checksum for the entire pack, and the only
way to do that is to re-read the data from disk.

If there was filesystem corruption in the process (e.g. a bad
disk sector, or a kernel bug) we don't want to produce a valid
pack at the end.  Instead we need to fail-fast with the error
so the user is aware of the corruption.

We now keep track of where the end of the original data is and
run two SHA-1 computations during the header-footer fixup.  If
the original data region doesn't match the original footer we
got over the network we know there was corruption and we just
cannot trust this pack file.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

  This was inspired by the data corruption thread started
  by J. Bruce Fields.  At some point in the thread Linus
  pointed out the C Git index-pack isn't as safe as it can
  be, and offered a strategy to fix it.

  We weren't as safe as we could be either in jgit, even
  though we do verify CRC codes when we re-read a delta
  base from disk.  Not all objects are used as a base and
  thus we could miss some forms of corruption.

 .../src/org/spearce/jgit/transport/IndexPack.java  |   17 ++++++++++++++++-
 1 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java b/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
index 29d99db..db9268e 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
@@ -156,6 +156,9 @@ public static IndexPack create(final Repository db, final InputStream is)
 
 	private byte[] packcsum;
 
+	/** If {@link #fixThin} this is the last byte of the original checksum. */
+	private long originalEOF;
+
 	/**
 	 * Create a new pack indexer utility.
 	 * 
@@ -398,8 +401,9 @@ private void resolveChildDeltas(final long pos, int type, byte[] data,
 	private void fixThinPack(final ProgressMonitor progress) throws IOException {
 		growEntries();
 
+		originalEOF = packOut.length() - 20;
 		final Deflater def = new Deflater(Deflater.DEFAULT_COMPRESSION, false);
-		long end = packOut.length() - 20;
+		long end = originalEOF;
 		for (final ObjectId baseId : new ArrayList<ObjectId>(baseById.keySet())) {
 			final ObjectLoader ldr = repo.openObject(baseId);
 			if (ldr == null)
@@ -453,9 +457,13 @@ private void writeWhole(final Deflater def, final int typeCode,
 	}
 
 	private void fixHeaderFooter() throws IOException {
+		final MessageDigest origDigest = Constants.newMessageDigest();
+		long origRemaining = originalEOF - 12;
+
 		packOut.seek(0);
 		if (packOut.read(buf, 0, 12) != 12)
 			throw new IOException("Cannot re-read pack header to fix count");
+		origDigest.update(buf, 0, 12);
 		NB.encodeInt32(buf, 8, entryCount);
 		packOut.seek(0);
 		packOut.write(buf, 0, 12);
@@ -466,9 +474,16 @@ private void fixHeaderFooter() throws IOException {
 			final int n = packOut.read(buf);
 			if (n < 0)
 				break;
+			if (origRemaining > 0) {
+				origDigest.update(buf, 0, (int) Math.min(n, origRemaining));
+				origRemaining -= n;
+			}
 			packDigest.update(buf, 0, n);
 		}
 
+		if (!Arrays.equals(origDigest.digest(), packcsum))
+			throw new IOException("Pack corrupted while writing to filesystem");
+
 		packcsum = packDigest.digest();
 		packOut.write(packcsum);
 	}
-- 
1.6.0.174.gd789c

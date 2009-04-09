From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 2/2] Validate the DIRC footer during read
Date: Thu,  9 Apr 2009 08:28:19 -0700
Message-ID: <1239290899-24589-2-git-send-email-spearce@spearce.org>
References: <1239205852-28138-1-git-send-email-robin.rosenberg@dewire.com>
 <1239290899-24589-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Apr 09 17:30:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrwDI-0003eD-V7
	for gcvg-git-2@gmane.org; Thu, 09 Apr 2009 17:30:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933393AbZDIP2Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2009 11:28:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759471AbZDIP2X
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 11:28:23 -0400
Received: from george.spearce.org ([209.20.77.23]:51727 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754019AbZDIP2W (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Apr 2009 11:28:22 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 3996D38215; Thu,  9 Apr 2009 15:28:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 4971538211;
	Thu,  9 Apr 2009 15:28:20 +0000 (UTC)
X-Mailer: git-send-email 1.6.2.2.600.g24c24
In-Reply-To: <1239290899-24589-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116171>

To ensure we didn't read a partial file, or a file that has a corrupt
content (e.g. due power failure on a buggy unjournaled filesystem)
we now validate the entire content of the DIRC file through its final
SHA1 checksum at the end of the stream.

This slightly slows down the read path, as we now have to process a
lot of small buffers (info and path objects) through the digest, but
we're better off ensuring the content is reasonably sane.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 This isn't strictly necessary to fix the bug you identified, but
 I was in the neighboorhood and stronger data validation on input
 is potentially worthwhile...

 .../src/org/spearce/jgit/dircache/DirCache.java    |   12 +++++++++++-
 .../org/spearce/jgit/dircache/DirCacheEntry.java   |   13 +++++++++++--
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCache.java b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCache.java
index 5df0f59..58da014 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCache.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCache.java
@@ -47,6 +47,7 @@
 import java.nio.ByteBuffer;
 import java.security.DigestOutputStream;
 import java.security.MessageDigest;
+import java.util.Arrays;
 import java.util.Comparator;
 
 import org.spearce.jgit.errors.CorruptObjectException;
@@ -344,11 +345,13 @@ public void clear() {
 	private void readFrom(final FileInputStream inStream) throws IOException,
 			CorruptObjectException {
 		final BufferedInputStream in = new BufferedInputStream(inStream);
+		final MessageDigest md = Constants.newMessageDigest();
 
 		// Read the index header and verify we understand it.
 		//
 		final byte[] hdr = new byte[20];
 		NB.readFully(in, hdr, 0, 12);
+		md.update(hdr, 0, 12);
 		if (!is_DIRC(hdr))
 			throw new CorruptObjectException("Not a DIRC file.");
 		final int ver = NB.decodeInt32(hdr, 4);
@@ -363,7 +366,7 @@ private void readFrom(final FileInputStream inStream) throws IOException,
 		final byte[] infos = new byte[INFO_LEN * entryCnt];
 		sortedEntries = new DirCacheEntry[entryCnt];
 		for (int i = 0; i < entryCnt; i++)
-			sortedEntries[i] = new DirCacheEntry(infos, i * INFO_LEN, in);
+			sortedEntries[i] = new DirCacheEntry(infos, i * INFO_LEN, in, md);
 		lastModified = liveFile.lastModified();
 
 		// After the file entries are index extensions, and then a footer.
@@ -381,8 +384,10 @@ private void readFrom(final FileInputStream inStream) throws IOException,
 			switch (NB.decodeInt32(hdr, 0)) {
 			case EXT_TREE: {
 				final byte[] raw = new byte[NB.decodeInt32(hdr, 4)];
+				md.update(hdr, 0, 8);
 				NB.skipFully(in, 8);
 				NB.readFully(in, raw, 0, raw.length);
+				md.update(raw, 0, raw.length);
 				tree = new DirCacheTree(raw, new MutableInteger(), null);
 				break;
 			}
@@ -405,6 +410,11 @@ private void readFrom(final FileInputStream inStream) throws IOException,
 				}
 			}
 		}
+
+		final byte[] exp = md.digest();
+		if (!Arrays.equals(exp, hdr)) {
+			throw new CorruptObjectException("DIRC checksum mismatch");
+		}
 	}
 
 	private static boolean is_DIRC(final byte[] hdr) {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheEntry.java b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheEntry.java
index 6d46648..47b1cc5 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheEntry.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheEntry.java
@@ -43,6 +43,7 @@
 import java.io.InputStream;
 import java.io.OutputStream;
 import java.nio.ByteBuffer;
+import java.security.MessageDigest;
 import java.util.Arrays;
 
 import org.spearce.jgit.lib.AnyObjectId;
@@ -113,17 +114,19 @@
 	final byte[] path;
 
 	DirCacheEntry(final byte[] sharedInfo, final int infoAt,
-			final InputStream in) throws IOException {
+			final InputStream in, final MessageDigest md) throws IOException {
 		info = sharedInfo;
 		infoOffset = infoAt;
 
 		NB.readFully(in, info, infoOffset, INFO_LEN);
+		md.update(info, infoOffset, INFO_LEN);
 
 		int pathLen = NB.decodeUInt16(info, infoOffset + P_FLAGS) & NAME_MASK;
 		int skipped = 0;
 		if (pathLen < NAME_MASK) {
 			path = new byte[pathLen];
 			NB.readFully(in, path, 0, pathLen);
+			md.update(path, 0, pathLen);
 		} else {
 			final ByteArrayOutputStream tmp = new ByteArrayOutputStream();
 			{
@@ -142,6 +145,8 @@ DirCacheEntry(final byte[] sharedInfo, final int infoAt,
 			path = tmp.toByteArray();
 			pathLen = path.length;
 			skipped = 1; // we already skipped 1 '\0' above to break the loop.
+			md.update(path, 0, pathLen);
+			md.update((byte) 0);
 		}
 
 		// Index records are padded out to the next 8 byte alignment
@@ -149,7 +154,11 @@ DirCacheEntry(final byte[] sharedInfo, final int infoAt,
 		//
 		final int actLen = INFO_LEN + pathLen;
 		final int expLen = (actLen + 8) & ~7;
-		NB.skipFully(in, expLen - actLen - skipped);
+		final int padLen = expLen - actLen - skipped;
+		if (padLen > 0) {
+			NB.skipFully(in, padLen);
+			md.update(nullpad, 0, padLen);
+		}
 	}
 
 	/**
-- 
1.6.2.2.600.g24c24

From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 7/9] Validate the pack's footer checksum matches that in the index
Date: Wed, 11 Feb 2009 18:36:57 -0800
Message-ID: <1234406219-19547-8-git-send-email-spearce@spearce.org>
References: <1234406219-19547-1-git-send-email-spearce@spearce.org>
 <1234406219-19547-2-git-send-email-spearce@spearce.org>
 <1234406219-19547-3-git-send-email-spearce@spearce.org>
 <1234406219-19547-4-git-send-email-spearce@spearce.org>
 <1234406219-19547-5-git-send-email-spearce@spearce.org>
 <1234406219-19547-6-git-send-email-spearce@spearce.org>
 <1234406219-19547-7-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 03:39:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXRTe-0002tJ-9U
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 03:38:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758282AbZBLChY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 21:37:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758234AbZBLChW
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 21:37:22 -0500
Received: from george.spearce.org ([209.20.77.23]:39180 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756696AbZBLChF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 21:37:05 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id B1B5C38210; Thu, 12 Feb 2009 02:37:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 573DD38211;
	Thu, 12 Feb 2009 02:37:02 +0000 (UTC)
X-Mailer: git-send-email 1.6.2.rc0.204.gf6b427
In-Reply-To: <1234406219-19547-7-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109565>

If the SHA-1 checksum of the entire pack content does not match the
checksum stored in the corresponding *.idx file we cannot use the
index, as the offsets recorded with it are most likely incorrect.

This situation can arise if another application repacks the pack
with different compression settings, but puts the same set of
objects into it.  The offsets are going to be different, but the
resulting pack file and index file names will be the same.  If we
had previously read the old index into memory, but the pack isn't
a match anymore, we can't safely access this pack.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/PackFile.java         |   11 ++++++++++-
 .../src/org/spearce/jgit/lib/PackIndex.java        |    3 +++
 .../src/org/spearce/jgit/lib/PackIndexV1.java      |    3 +++
 .../src/org/spearce/jgit/lib/PackIndexV2.java      |    3 +++
 4 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
index d34df03..1ee0ad7 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
@@ -42,6 +42,7 @@
 import java.io.File;
 import java.io.IOException;
 import java.io.OutputStream;
+import java.util.Arrays;
 import java.util.Collections;
 import java.util.Comparator;
 import java.util.Iterator;
@@ -265,6 +266,7 @@ boolean supportsFastCopyRawData() throws IOException {
 	}
 
 	private void onOpenPack() throws IOException {
+		final PackIndex idx = idx();
 		final WindowCursor curs = new WindowCursor();
 		long position = 0;
 		final byte[] sig = new byte[Constants.PACK_SIGNATURE.length];
@@ -287,11 +289,18 @@ private void onOpenPack() throws IOException {
 
 		pack.readFully(position, intbuf, curs);
 		final long packCnt = NB.decodeUInt32(intbuf, 0);
-		final long idxCnt = idx().getObjectCount();
+		final long idxCnt = idx.getObjectCount();
 		if (idxCnt != packCnt)
 			throw new IOException("Pack index"
 					+ " object count mismatch; expected " + packCnt
 					+ " found " + idxCnt + ": " + pack.getName());
+		
+		final byte[] csumbuf = new byte[20];
+		pack.readFully(pack.length() - 20, csumbuf, curs);
+		if (!Arrays.equals(csumbuf, idx.packChecksum))
+			throw new IOException("Pack index mismatch; pack SHA-1 is "
+					+ ObjectId.fromRaw(csumbuf).name() + ", index expects "
+					+ ObjectId.fromRaw(idx.packChecksum).name());
 	}
 
 	private PackedObjectLoader reader(final WindowCursor curs,
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndex.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndex.java
index 13acbd1..473ce1e 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndex.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndex.java
@@ -112,6 +112,9 @@ private static boolean isTOC(final byte[] h) {
 		return true;
 	}
 
+	/** Footer checksum applied on the bottom of the pack file. */
+	protected byte[] packChecksum;
+
 	/**
 	 * Determine if an object is contained within the pack file.
 	 * 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexV1.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexV1.java
index 90b5f6f..fdaa094 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexV1.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexV1.java
@@ -79,6 +79,9 @@ PackIndexV1(final InputStream fd, final byte[] hdr)
 			}
 		}
 		objectCnt = idxHeader[255];
+
+		packChecksum = new byte[20];
+		NB.readFully(fd, packChecksum, 0, packChecksum.length);
 	}
 
 	long getObjectCount() {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexV2.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexV2.java
index 48a5206..eb56ed9 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexV2.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexV2.java
@@ -142,6 +142,9 @@ PackIndexV2(final InputStream fd) throws IOException {
 		} else {
 			offset64 = NO_BYTES;
 		}
+
+		packChecksum = new byte[20];
+		NB.readFully(fd, packChecksum, 0, packChecksum.length);
 	}
 
 	@Override
-- 
1.6.2.rc0.204.gf6b427

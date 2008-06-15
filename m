From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 08/20] CRC32 support for PackIndex
Date: Sun, 15 Jun 2008 23:45:37 +0200
Message-ID: <1213566349-25395-9-git-send-email-marek.zawirski@gmail.com>
References: <1213566349-25395-1-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-2-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-3-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-4-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-5-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-6-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-7-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-8-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Jun 15 23:48:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K804n-0001nA-GJ
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 23:47:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753418AbYFOVqb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 17:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753313AbYFOVqb
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 17:46:31 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:49881 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753345AbYFOVq1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 17:46:27 -0400
Received: by fg-out-1718.google.com with SMTP id 19so3137938fgg.17
        for <git@vger.kernel.org>; Sun, 15 Jun 2008 14:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=/n6U7gjn/R3UQ6WmJ0DsOd/d+OmP3dWgqTDRAOWpyfM=;
        b=AK6B3FvfxOlXpGwq43dZ9obS1QnUVfAcgok9FVTWd8CUe9pu63alO5p4AHq8deB1Q7
         LQ3i9p1EwafVknxB840P2Kzm/J8cOZZ5CmSy1urW0z7ehnKLMb5Hbe1xWKJFjiz7f/JS
         sCRQizn2KMnmRWgB68GySuZVr/9lukjhTYokU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=kpO26KbVg99d8ioycTOgC3VwZlbn6OKsN7duwWxoIVzxDthsWDf7i3xspJTwy1i6js
         lZUyWTx4dFa8pZ8ubf44m8OUnr+ZfKMTC6L8CkYYGvkNyCiRP8coFCY4PNSQwsoYFD72
         bp1DWjaxBqBNdtXPS5najtZfXzyMFf9BunPtE=
Received: by 10.86.4.2 with SMTP id 2mr7259491fgd.16.1213566386653;
        Sun, 15 Jun 2008 14:46:26 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id l12sm9666057fgb.6.2008.06.15.14.46.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 15 Jun 2008 14:46:25 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1213566349-25395-8-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85135>

Add findCRC32() and hasCRC32Support() methods in PackIndex with
implementation for index v2.

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../src/org/spearce/jgit/lib/PackIndex.java        |   23 ++++++++++++
 .../src/org/spearce/jgit/lib/PackIndexV1.java      |   10 +++++
 .../src/org/spearce/jgit/lib/PackIndexV2.java      |   38 ++++++++++++-------
 3 files changed, 57 insertions(+), 14 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndex.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndex.java
index 3935d4f..e34cd36 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndex.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndex.java
@@ -44,6 +44,7 @@ import java.io.FileNotFoundException;
 import java.io.IOException;
 import java.util.Iterator;
 
+import org.spearce.jgit.errors.MissingObjectException;
 import org.spearce.jgit.util.NB;
 
 /**
@@ -151,6 +152,28 @@ public abstract class PackIndex implements Iterable<PackIndex.MutableEntry> {
 	abstract long findOffset(AnyObjectId objId);
 
 	/**
+	 * Retrieve stored CRC32 checksum of the requested object raw-data
+	 * (including header).
+	 * 
+	 * @param objId
+	 *            id of object to look for
+	 * @return CRC32 checksum of specified object (at 32 less significant bits)
+	 * @throws MissingObjectException
+	 *             when requested ObjectId was not found in this index
+	 * @throws UnsupportedOperationException
+	 *             when this index doesn't support CRC32 checksum
+	 */
+	abstract long findCRC32(AnyObjectId objId) throws MissingObjectException,
+			UnsupportedOperationException;
+
+	/**
+	 * Check whether this index supports (has) CRC32 checksums for objects.
+	 * 
+	 * @return true if CRC32 is stored, false otherwise
+	 */
+	abstract boolean hasCRC32Support();
+
+	/**
 	 * Represent mutable entry of pack index consisting of object id and offset
 	 * in pack (both mutable).
 	 * 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexV1.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexV1.java
index b8d9de3..86b939a 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexV1.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexV1.java
@@ -107,6 +107,16 @@ class PackIndexV1 extends PackIndex {
 		return -1;
 	}
 
+	@Override
+	long findCRC32(AnyObjectId objId) {
+		throw new UnsupportedOperationException();
+	}
+
+	@Override
+	boolean hasCRC32Support() {
+		return false;
+	}
+
 	public Iterator<MutableEntry> iterator() {
 		return new IndexV1Iterator();
 	}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexV2.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexV2.java
index a0b9827..fc1f08b 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexV2.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexV2.java
@@ -37,12 +37,12 @@
 
 package org.spearce.jgit.lib;
 
-import java.io.EOFException;
 import java.io.IOException;
 import java.io.InputStream;
 import java.util.Iterator;
 import java.util.NoSuchElementException;
 
+import org.spearce.jgit.errors.MissingObjectException;
 import org.spearce.jgit.util.NB;
 
 /** Support for the pack index v2 format. */
@@ -63,6 +63,9 @@ class PackIndexV2 extends PackIndex {
 	/** 256 arrays of the 32 bit offset data, matching {@link #names}. */
 	private byte[][] offset32;
 
+	/** 256 arrays of the CRC-32 of objects, matching {@link #names}. */
+	private byte[][] crc32;
+
 	/** 64 bit offset table. */
 	private byte[] offset64;
 
@@ -76,6 +79,7 @@ class PackIndexV2 extends PackIndex {
 
 		names = new int[FANOUT][];
 		offset32 = new byte[FANOUT][];
+		crc32 = new byte[FANOUT][];
 
 		// Object name table. The size we can permit per fan-out bucket
 		// is limited to Java's 2 GB per byte array limitation. That is
@@ -91,6 +95,7 @@ class PackIndexV2 extends PackIndex {
 			if (bucketCnt == 0) {
 				names[k] = NO_INTS;
 				offset32[k] = NO_BYTES;
+				crc32[k] = NO_BYTES;
 				continue;
 			}
 
@@ -107,11 +112,12 @@ class PackIndexV2 extends PackIndex {
 
 			names[k] = bin;
 			offset32[k] = new byte[(int) (bucketCnt * 4)];
+			crc32[k] = new byte[(int) (bucketCnt * 4)];
 		}
 
-		// CRC32 table. Currently unused.
-		//
-		skipFully(fd, objectCnt * 4);
+		// CRC32 table.
+		for (int k = 0; k < FANOUT; k++)
+			NB.readFully(fd, crc32[k], 0, crc32[k].length);
 
 		// 32 bit offset table. Any entries with the most significant bit
 		// set require a 64 bit offset entry in another table.
@@ -135,16 +141,6 @@ class PackIndexV2 extends PackIndex {
 		}
 	}
 
-	private static void skipFully(final InputStream fd, long toSkip)
-			throws IOException {
-		while (toSkip > 0) {
-			final long r = fd.skip(toSkip);
-			if (r <= 0)
-				throw new EOFException("Cannot skip index section.");
-			toSkip -= r;
-		}
-	}
-
 	@Override
 	long getObjectCount() {
 		return objectCnt;
@@ -162,6 +158,20 @@ class PackIndexV2 extends PackIndex {
 		return p;
 	}
 
+	@Override
+	long findCRC32(AnyObjectId objId) throws MissingObjectException {
+		final int levelOne = objId.getFirstByte();
+		final int levelTwo = binarySearchLevelTwo(objId, levelOne);
+		if (levelTwo == -1)
+			throw new MissingObjectException(objId.copy(), "unknown");
+		return NB.decodeUInt32(crc32[levelOne], levelTwo << 2);
+	}
+
+	@Override
+	boolean hasCRC32Support() {
+		return true;
+	}
+
 	public Iterator<MutableEntry> iterator() {
 		return new EntriesIteratorV2();
 	}
-- 
1.5.5.1

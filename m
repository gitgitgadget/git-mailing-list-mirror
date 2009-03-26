From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 2/5] Implement CRC32 computation during PackWriter
Date: Wed, 25 Mar 2009 18:21:52 -0700
Message-ID: <1238030515-31768-2-git-send-email-spearce@spearce.org>
References: <1238030515-31768-1-git-send-email-spearce@spearce.org>
Cc: Marek Zawirski <marek.zawirski@gmail.com>,
	Daniel Cheng <j16sdiz+freenet@gmail.com>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Mar 26 02:23:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmeJi-0001u1-V9
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 02:23:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755018AbZCZBWE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 21:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754981AbZCZBWD
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 21:22:03 -0400
Received: from george.spearce.org ([209.20.77.23]:40175 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754127AbZCZBV6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 21:21:58 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 1A91338222; Thu, 26 Mar 2009 01:21:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 1DBA238211;
	Thu, 26 Mar 2009 01:21:56 +0000 (UTC)
X-Mailer: git-send-email 1.6.2.1.471.g682837
In-Reply-To: <1238030515-31768-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114699>

To correctly create a v2 index file for a pack we must compute the
CRC32 code for each object entry as they are written out, otherwise
the CRC32 table will be full of 0's, and fail verification if the
resulting pack were to be reused.

Reported-by: Daniel Cheng (aka SDiZ) <j16sdiz+freenet@gmail.com>
Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../tst/org/spearce/jgit/lib/PackWriterTest.java   |   17 +++---
 .../PackOutputStream.java}                         |   65 +++++++++++++-------
 .../src/org/spearce/jgit/lib/PackWriter.java       |   16 ++---
 3 files changed, 57 insertions(+), 41 deletions(-)
 rename org.spearce.jgit/src/org/spearce/jgit/{util/CountingOutputStream.java => lib/PackOutputStream.java} (61%)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackWriterTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackWriterTest.java
index f7139fc..46616e3 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackWriterTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackWriterTest.java
@@ -56,7 +56,6 @@
 import org.spearce.jgit.revwalk.RevObject;
 import org.spearce.jgit.revwalk.RevWalk;
 import org.spearce.jgit.transport.IndexPack;
-import org.spearce.jgit.util.CountingOutputStream;
 import org.spearce.jgit.util.JGitTestUtil;
 
 public class PackWriterTest extends RepositoryTestCase {
@@ -71,7 +70,7 @@
 
 	private ByteArrayOutputStream os;
 
-	private CountingOutputStream cos;
+	private PackOutputStream cos;
 
 	private File packBase;
 
@@ -84,7 +83,7 @@
 	public void setUp() throws Exception {
 		super.setUp();
 		os = new ByteArrayOutputStream();
-		cos = new CountingOutputStream(os);
+		cos = new PackOutputStream(os);
 		packBase = new File(trash, "tmp_pack");
 		packFile = new File(trash, "tmp_pack.pack");
 		indexFile = new File(trash, "tmp_pack.idx");
@@ -308,11 +307,11 @@ public void testWritePack4ThinPack() throws IOException {
 	 */
 	public void testWritePack2SizeDeltasVsNoDeltas() throws Exception {
 		testWritePack2();
-		final long sizePack2NoDeltas = cos.getCount();
+		final long sizePack2NoDeltas = cos.length();
 		tearDown();
 		setUp();
 		testWritePack2DeltasReuseRefs();
-		final long sizePack2DeltasRefs = cos.getCount();
+		final long sizePack2DeltasRefs = cos.length();
 
 		assertTrue(sizePack2NoDeltas > sizePack2DeltasRefs);
 	}
@@ -327,11 +326,11 @@ public void testWritePack2SizeDeltasVsNoDeltas() throws Exception {
 	 */
 	public void testWritePack2SizeOffsetsVsRefs() throws Exception {
 		testWritePack2DeltasReuseRefs();
-		final long sizePack2DeltasRefs = cos.getCount();
+		final long sizePack2DeltasRefs = cos.length();
 		tearDown();
 		setUp();
 		testWritePack2DeltasReuseOffsets();
-		final long sizePack2DeltasOffsets = cos.getCount();
+		final long sizePack2DeltasOffsets = cos.length();
 
 		assertTrue(sizePack2DeltasRefs > sizePack2DeltasOffsets);
 	}
@@ -345,11 +344,11 @@ public void testWritePack2SizeOffsetsVsRefs() throws Exception {
 	 */
 	public void testWritePack4SizeThinVsNoThin() throws Exception {
 		testWritePack4();
-		final long sizePack4 = cos.getCount();
+		final long sizePack4 = cos.length();
 		tearDown();
 		setUp();
 		testWritePack4ThinPack();
-		final long sizePack4Thin = cos.getCount();
+		final long sizePack4Thin = cos.length();
 
 		assertTrue(sizePack4 > sizePack4Thin);
 	}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/util/CountingOutputStream.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackOutputStream.java
similarity index 61%
rename from org.spearce.jgit/src/org/spearce/jgit/util/CountingOutputStream.java
rename to org.spearce.jgit/src/org/spearce/jgit/lib/PackOutputStream.java
index 5f333f5..403b892 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/util/CountingOutputStream.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackOutputStream.java
@@ -1,4 +1,5 @@
 /*
+ * Copyright (C) 2009, Google Inc.
  * Copyright (C) 2008, Marek Zawirski <marek.zawirski@gmail.com>
  *
  * All rights reserved.
@@ -35,46 +36,66 @@
  * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
-package org.spearce.jgit.util;
+package org.spearce.jgit.lib;
 
-import java.io.FilterOutputStream;
 import java.io.IOException;
 import java.io.OutputStream;
+import java.security.MessageDigest;
+import java.util.zip.CRC32;
+
+/** Custom output stream to support {@link PackWriter}. */
+final class PackOutputStream extends OutputStream {
+	private final OutputStream out;
+
+	private final CRC32 crc = new CRC32();
+
+	private final MessageDigest md = Constants.newMessageDigest();
 
-/**
- * Counting output stream decoration. Counts bytes written to stream.
- */
-public class CountingOutputStream extends FilterOutputStream {
 	private long count;
 
-	/**
-	 * Create counting stream being decorated to provided real output stream.
-	 *
-	 * @param out
-	 *            output stream where data should be written
-	 */
-	public CountingOutputStream(OutputStream out) {
-		super(out);
+	PackOutputStream(final OutputStream out) {
+		this.out = out;
 	}
 
 	@Override
-	public void write(int b) throws IOException {
+	public void write(final int b) throws IOException {
 		out.write(b);
+		crc.update(b);
+		md.update((byte) b);
 		count++;
 	}
 
 	@Override
-	public void write(byte[] b, int off, int len) throws IOException {
+	public void write(final byte[] b, final int off, final int len)
+			throws IOException {
 		out.write(b, off, len);
+		crc.update(b, off, len);
+		md.update(b, off, len);
 		count += len;
 	}
 
-	/**
-	 * Return number of already written bytes.
-	 *
-	 * @return number of written bytes since stream start.
-	 */
-	public long getCount() {
+	@Override
+	public void flush() throws IOException {
+		out.flush();
+	}
+
+	/** @return total number of bytes written since stream start. */
+	long length() {
 		return count;
 	}
+
+	/** @return obtain the current CRC32 register. */
+	int getCRC32() {
+		return (int) crc.getValue();
+	}
+
+	/** Reinitialize the CRC32 register for a new region. */
+	void resetCRC32() {
+		crc.reset();
+	}
+
+	/** @return obtain the current SHA-1 digest. */
+	byte[] getDigest() {
+		return md.digest();
+	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
index 601ce71..cfec35c 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
@@ -40,7 +40,6 @@
 import java.io.BufferedOutputStream;
 import java.io.IOException;
 import java.io.OutputStream;
-import java.security.DigestOutputStream;
 import java.security.MessageDigest;
 import java.util.ArrayList;
 import java.util.Collection;
@@ -57,7 +56,6 @@
 import org.spearce.jgit.revwalk.RevObject;
 import org.spearce.jgit.revwalk.RevSort;
 import org.spearce.jgit.transport.PackedObjectInfo;
-import org.spearce.jgit.util.CountingOutputStream;
 import org.spearce.jgit.util.NB;
 
 /**
@@ -166,9 +164,7 @@
 
 	private final Repository db;
 
-	private DigestOutputStream out;
-
-	private CountingOutputStream countingOut;
+	private PackOutputStream out;
 
 	private final Deflater deflater;
 
@@ -563,8 +559,7 @@ public void writePack(OutputStream packStream) throws IOException {
 
 		if (!(packStream instanceof BufferedOutputStream))
 			packStream = new BufferedOutputStream(packStream);
-		countingOut = new CountingOutputStream(packStream);
-		out = new DigestOutputStream(countingOut, Constants.newMessageDigest());
+		out = new PackOutputStream(packStream);
 
 		writeMonitor.beginTask(WRITING_OBJECTS_PROGRESS, getObjectsNumber());
 		writeHeader();
@@ -687,11 +682,13 @@ private void writeObject(final ObjectToPack otp) throws IOException {
 
 		assert !otp.isWritten();
 
-		otp.setOffset(countingOut.getCount());
+		out.resetCRC32();
+		otp.setOffset(out.length());
 		if (otp.isDeltaRepresentation())
 			writeDeltaObject(otp);
 		else
 			writeWholeObject(otp);
+		otp.setCRC(out.getCRC32());
 
 		writeMonitor.update(1);
 	}
@@ -753,8 +750,7 @@ private void writeObjectHeader(final int objectType, long dataLength)
 	}
 
 	private void writeChecksum() throws IOException {
-		out.on(false);
-		packcsum = out.getMessageDigest().digest();
+		packcsum = out.getDigest();
 		out.write(packcsum);
 	}
 
-- 
1.6.2.1.471.g682837

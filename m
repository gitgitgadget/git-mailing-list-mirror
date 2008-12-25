From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 18/23] Correctly use a long for the offsets within a generated pack
Date: Wed, 24 Dec 2008 18:11:14 -0800
Message-ID: <1230171079-17156-19-git-send-email-spearce@spearce.org>
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
 <1230171079-17156-15-git-send-email-spearce@spearce.org>
 <1230171079-17156-16-git-send-email-spearce@spearce.org>
 <1230171079-17156-17-git-send-email-spearce@spearce.org>
 <1230171079-17156-18-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Dec 25 03:14:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LFfjP-00029A-Rb
	for gcvg-git-2@gmane.org; Thu, 25 Dec 2008 03:13:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751688AbYLYCMB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Dec 2008 21:12:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751817AbYLYCL6
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Dec 2008 21:11:58 -0500
Received: from george.spearce.org ([209.20.77.23]:59446 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751641AbYLYCLb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Dec 2008 21:11:31 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id A332138260; Thu, 25 Dec 2008 02:11:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 9596C38215;
	Thu, 25 Dec 2008 02:11:25 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc4.301.g5497a
In-Reply-To: <1230171079-17156-18-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103884>

Pack files can be larger than 2 GiB, especially if the PackIndexV2
format is being used.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../tst/org/spearce/jgit/lib/PackWriterTest.java   |   12 ++++++------
 .../spearce/jgit/util/CountingOutputStream.java    |    5 ++---
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackWriterTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackWriterTest.java
index ec138a0..98e0d3a 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackWriterTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackWriterTest.java
@@ -308,11 +308,11 @@ public void testWritePack4ThinPack() throws IOException {
 	 */
 	public void testWritePack2SizeDeltasVsNoDeltas() throws Exception {
 		testWritePack2();
-		final int sizePack2NoDeltas = cos.getCount();
+		final long sizePack2NoDeltas = cos.getCount();
 		tearDown();
 		setUp();
 		testWritePack2DeltasReuseRefs();
-		final int sizePack2DeltasRefs = cos.getCount();
+		final long sizePack2DeltasRefs = cos.getCount();
 
 		assertTrue(sizePack2NoDeltas > sizePack2DeltasRefs);
 	}
@@ -327,11 +327,11 @@ public void testWritePack2SizeDeltasVsNoDeltas() throws Exception {
 	 */
 	public void testWritePack2SizeOffsetsVsRefs() throws Exception {
 		testWritePack2DeltasReuseRefs();
-		final int sizePack2DeltasRefs = cos.getCount();
+		final long sizePack2DeltasRefs = cos.getCount();
 		tearDown();
 		setUp();
 		testWritePack2DeltasReuseOffsets();
-		final int sizePack2DeltasOffsets = cos.getCount();
+		final long sizePack2DeltasOffsets = cos.getCount();
 
 		assertTrue(sizePack2DeltasRefs > sizePack2DeltasOffsets);
 	}
@@ -345,11 +345,11 @@ public void testWritePack2SizeOffsetsVsRefs() throws Exception {
 	 */
 	public void testWritePack4SizeThinVsNoThin() throws Exception {
 		testWritePack4();
-		final int sizePack4 = cos.getCount();
+		final long sizePack4 = cos.getCount();
 		tearDown();
 		setUp();
 		testWritePack4ThinPack();
-		final int sizePack4Thin = cos.getCount();
+		final long sizePack4Thin = cos.getCount();
 
 		assertTrue(sizePack4 > sizePack4Thin);
 	}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/util/CountingOutputStream.java b/org.spearce.jgit/src/org/spearce/jgit/util/CountingOutputStream.java
index 53935dc..b0b5f7d 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/util/CountingOutputStream.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/util/CountingOutputStream.java
@@ -45,8 +45,7 @@
  * Counting output stream decoration. Counts bytes written to stream.
  */
 public class CountingOutputStream extends FilterOutputStream {
-
-	private int count;
+	private long count;
 
 	/**
 	 * Create counting stream being decorated to provided real output stream.
@@ -76,7 +75,7 @@ public void write(byte[] b, int off, int len) throws IOException {
 	 * @return number of written bytes since last reset (object is reset upon
 	 *         creation)
 	 */
-	public int getCount() {
+	public long getCount() {
 		return count;
 	}
 
-- 
1.6.1.rc4.301.g5497a

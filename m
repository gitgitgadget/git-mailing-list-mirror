From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 3/5] Test case for pack index CRC32 when written by PackWriter
Date: Wed, 25 Mar 2009 18:21:53 -0700
Message-ID: <1238030515-31768-3-git-send-email-spearce@spearce.org>
References: <1238030515-31768-1-git-send-email-spearce@spearce.org>
 <1238030515-31768-2-git-send-email-spearce@spearce.org>
Cc: Marek Zawirski <marek.zawirski@gmail.com>,
	Daniel Cheng <j16sdiz+freenet@gmail.com>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Mar 26 02:23:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmeJj-0001u1-OE
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 02:23:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755140AbZCZBWH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 21:22:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754981AbZCZBWF
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 21:22:05 -0400
Received: from george.spearce.org ([209.20.77.23]:40178 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754212AbZCZBV7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 21:21:59 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 79DBF38239; Thu, 26 Mar 2009 01:21:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 8B107381D2;
	Thu, 26 Mar 2009 01:21:56 +0000 (UTC)
X-Mailer: git-send-email 1.6.2.1.471.g682837
In-Reply-To: <1238030515-31768-2-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114701>

Suggested-by: Daniel Cheng (aka SDiZ) <j16sdiz+freenet@gmail.com>
Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../tst/org/spearce/jgit/lib/PackWriterTest.java   |   33 ++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackWriterTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackWriterTest.java
index 46616e3..636059f 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackWriterTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackWriterTest.java
@@ -40,6 +40,7 @@
 import java.io.ByteArrayInputStream;
 import java.io.ByteArrayOutputStream;
 import java.io.File;
+import java.io.FileOutputStream;
 import java.io.IOException;
 import java.io.InputStream;
 import java.util.ArrayList;
@@ -353,6 +354,37 @@ public void testWritePack4SizeThinVsNoThin() throws Exception {
 		assertTrue(sizePack4 > sizePack4Thin);
 	}
 
+	public void testWriteIndex() throws Exception {
+		writer.setIndexVersion(2);
+		writeVerifyPack4(false);
+
+		// Validate that IndexPack came up with the right CRC32 value.
+		final PackIndex idx1 = PackIndex.open(indexFile);
+		assertTrue(idx1 instanceof PackIndexV2);
+		assertEquals(0x4743F1E4L, idx1.findCRC32(ObjectId
+				.fromString("82c6b885ff600be425b4ea96dee75dca255b69e7")));
+
+		// Validate that an index written by PackWriter is the same.
+		final File idx2File = new File(indexFile.getAbsolutePath() + ".2");
+		final FileOutputStream is = new FileOutputStream(idx2File);
+		try {
+			writer.writeIndex(is);
+		} finally {
+			is.close();
+		}
+		final PackIndex idx2 = PackIndex.open(idx2File);
+		assertTrue(idx2 instanceof PackIndexV2);
+		assertEquals(idx1.getObjectCount(), idx2.getObjectCount());
+		assertEquals(idx1.getOffset64Count(), idx2.getOffset64Count());
+
+		for (int i = 0; i < idx1.getObjectCount(); i++) {
+			final ObjectId id = idx1.getObjectId(i);
+			assertEquals(id, idx2.getObjectId(i));
+			assertEquals(idx1.findOffset(id), idx2.findOffset(id));
+			assertEquals(idx1.findCRC32(id), idx2.findCRC32(id));
+		}
+	}
+
 	// TODO: testWritePackDeltasCycle()
 	// TODO: testWritePackDeltasDepth()
 
@@ -469,6 +501,7 @@ private void verifyOpenPack(final boolean thin) throws IOException {
 		final IndexPack indexer = new IndexPack(db, is, packBase);
 		indexer.setKeepEmpty(true);
 		indexer.setFixThin(thin);
+		indexer.setIndexVersion(2);
 		indexer.index(new TextProgressMonitor());
 		pack = new PackFile(indexFile, packFile);
 	}
-- 
1.6.2.1.471.g682837

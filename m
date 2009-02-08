From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH v2] Don't keep an empty pack uploaded through receive-pack
Date: Sun,  8 Feb 2009 12:46:13 -0800
Message-ID: <1234125973-15077-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sun Feb 08 21:47:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWGZ5-00026E-L4
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 21:47:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753287AbZBHUqQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 15:46:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753338AbZBHUqQ
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 15:46:16 -0500
Received: from george.spearce.org ([209.20.77.23]:34324 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753157AbZBHUqP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 15:46:15 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 30CC838211; Sun,  8 Feb 2009 20:46:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 21FE53819E;
	Sun,  8 Feb 2009 20:46:14 +0000 (UTC)
X-Mailer: git-send-email 1.6.2.rc0.173.g5e148
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109012>

The receive-pack protocol sometimes gets an empty pack file if
there are commands to process but no data was needed to be sent.
In such cases we shouldn't create an empty 32 byte pack on disk,
but instead should discard it.

Since ReceivePack doesn't read the pack header, we only know
the empty state inside of IndexPack.  So we fix it here, to
avoid duplicating the header parsing code into ReceivePack.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 I missed the test case that assumes we kept an empty pack on disk.
 This version of the patch fixes that test case.

 .../tst/org/spearce/jgit/lib/PackWriterTest.java   |    1 +
 .../src/org/spearce/jgit/transport/IndexPack.java  |   34 ++++++++++++++++---
 2 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackWriterTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackWriterTest.java
index 98e0d3a..e828ccc 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackWriterTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackWriterTest.java
@@ -468,6 +468,7 @@ private void verifyOpenPack(final boolean thin) throws IOException {
 		}
 		final InputStream is = new ByteArrayInputStream(os.toByteArray());
 		final IndexPack indexer = new IndexPack(db, is, packBase);
+		indexer.setKeepEmpty(true);
 		indexer.setFixThin(thin);
 		indexer.index(new TextProgressMonitor());
 		pack = new PackFile(db, indexFile, packFile);
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java b/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
index 82cd615..bd7bfd0 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
@@ -143,6 +143,8 @@ public static IndexPack create(final Repository db, final InputStream is)
 
 	private boolean fixThin;
 
+	private boolean keepEmpty;
+
 	private int outputVersion;
 
 	private final File dstPack;
@@ -239,6 +241,19 @@ public void setFixThin(final boolean fix) {
 	}
 
 	/**
+	 * Configure this index pack instance to keep an empty pack.
+	 * <p>
+	 * By default an empty pack (a pack with no objects) is not kept, as doing
+	 * so is completely pointless. With no objects in the pack there is no data
+	 * stored by it, so the pack is unnecessary.
+	 * 
+	 * @param empty true to enable keeping an empty pack.
+	 */
+	public void setKeepEmpty(final boolean empty) {
+		keepEmpty = empty;
+	}
+
+	/**
 	 * Configure the checker used to validate received objects.
 	 * <p>
 	 * Usually object checking isn't necessary, as Git implementations only
@@ -313,14 +328,14 @@ public void index(final ProgressMonitor progress) throws IOException {
 						fixThinPack(progress);
 					}
 				}
-				if (packOut != null)
+				if (packOut != null && (keepEmpty || entryCount > 0))
 					packOut.getChannel().force(true);
 
 				packDigest = null;
 				baseById = null;
 				baseByPos = null;
 
-				if (dstIdx != null)
+				if (dstIdx != null && (keepEmpty || entryCount > 0))
 					writeIdx();
 
 			} finally {
@@ -336,10 +351,12 @@ public void index(final ProgressMonitor progress) throws IOException {
 					packOut.close();
 			}
 
-			if (dstPack != null)
-				dstPack.setReadOnly();
-			if (dstIdx != null)
-				dstIdx.setReadOnly();
+			if (keepEmpty || entryCount > 0) {
+				if (dstPack != null)
+					dstPack.setReadOnly();
+				if (dstIdx != null)
+					dstIdx.setReadOnly();
+			}
 		} catch (IOException err) {
 			if (dstPack != null)
 				dstPack.delete();
@@ -946,6 +963,11 @@ UnresolvedDelta(final long headerOffset, final int crc32) {
 	 *             removed prior to throwing the exception to the caller.
 	 */
 	public void renameAndOpenPack() throws IOException {
+		if (!keepEmpty && entryCount == 0) {
+			cleanupTemporaryFiles();
+			return;
+		}
+
 		final MessageDigest d = Constants.newMessageDigest();
 		final byte[] oeBytes = new byte[Constants.OBJECT_ID_LENGTH];
 		for (int i = 0; i < entryCount; i++) {
-- 
1.6.2.rc0.173.g5e148

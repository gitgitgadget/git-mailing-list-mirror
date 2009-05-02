From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 1/2] Ensure that a PackFile instance stays invalid when overwritten
Date: Sat,  2 May 2009 13:30:29 -0700
Message-ID: <1241296230-19342-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sat May 02 22:30:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0Lr9-0000Ub-02
	for gcvg-git-2@gmane.org; Sat, 02 May 2009 22:30:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757715AbZEBUad (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 May 2009 16:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757384AbZEBUac
	(ORCPT <rfc822;git-outgoing>); Sat, 2 May 2009 16:30:32 -0400
Received: from george.spearce.org ([209.20.77.23]:36501 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756343AbZEBUab (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 May 2009 16:30:31 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 0E8253808A; Sat,  2 May 2009 20:30:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 4830D3807F;
	Sat,  2 May 2009 20:30:31 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.rc3.212.g8c698
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118143>

If a PackFile gets overwritten after we read its pack-*.idx we
throw a PackMismatchException and then close the PackFile, which
discards the index.  At this point the PackFile instance is dead
and must be discarded by the GC, as it is used as part of the key
in the WindowCache and the UnpackedObjectCache.

There is however a subtle race condition here.  If the PackFile is
opened again after the PackMismatchException is thrown we load the
new index file into memory, possibly seeing the footer in the index
match the footer in the pack, and believing that the file is valid.
This can mean that stale windows that haven't yet expired out of the
WindowCache suddenly become valid again, even though they contain
data from the old version of the pack.

By caching the pack signature the very first time we open it we
can more reliably detect this overwrite race condition and keep
the PackFile instance invalid.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/PackFile.java         |   18 ++++++++++++++++--
 1 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
index b107dfe..85690a7 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
@@ -89,6 +89,8 @@ public int compare(final PackFile a, final PackFile b) {
 
 	private volatile boolean invalid;
 
+	private byte[] packChecksum;
+
 	private PackIndex loadedIdx;
 
 	private PackReverseIndex reverseIdx;
@@ -115,8 +117,18 @@ public PackFile(final File idxFile, final File packFile) {
 
 	private synchronized PackIndex idx() throws IOException {
 		if (loadedIdx == null) {
+			if (invalid)
+				throw new PackMismatchException("Pack checksum mismatch");
+
 			try {
-				loadedIdx = PackIndex.open(idxFile);
+				final PackIndex idx = PackIndex.open(idxFile);
+
+				if (packChecksum == null)
+					packChecksum = idx.packChecksum;
+				else if (!Arrays.equals(packChecksum, idx.packChecksum))
+					throw new PackMismatchException("Pack checksum mismatch");
+
+				loadedIdx = idx;
 			} catch (IOException e) {
 				invalid = true;
 				throw e;
@@ -339,6 +351,8 @@ synchronized boolean endWindowCache() {
 
 	private void doOpen() throws IOException {
 		try {
+			if (invalid)
+				throw new PackMismatchException("Pack checksum mismatch");
 			fd = new RandomAccessFile(packFile, "r");
 			length = fd.length();
 			onOpenPack();
@@ -423,7 +437,7 @@ private void onOpenPack() throws IOException {
 					+ ": " + getPackFile());
 
 		NB.readFully(fd.getChannel(), length - 20, buf, 0, 20);
-		if (!Arrays.equals(buf, idx.packChecksum))
+		if (!Arrays.equals(buf, packChecksum))
 			throw new PackMismatchException("Pack checksum mismatch:"
 					+ " pack " + ObjectId.fromRaw(buf).name()
 					+ " index " + ObjectId.fromRaw(idx.packChecksum).name()
-- 
1.6.3.rc3.212.g8c698

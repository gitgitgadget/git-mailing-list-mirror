From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 1/9] Remove the Repository parameter from PackFile's constructor
Date: Wed, 11 Feb 2009 18:36:51 -0800
Message-ID: <1234406219-19547-2-git-send-email-spearce@spearce.org>
References: <1234406219-19547-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 03:39:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXRTb-0002tJ-BB
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 03:38:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756481AbZBLChH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 21:37:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756491AbZBLChG
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 21:37:06 -0500
Received: from george.spearce.org ([209.20.77.23]:39171 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755620AbZBLChD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 21:37:03 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 049FF38221; Thu, 12 Feb 2009 02:37:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id CD31A38210;
	Thu, 12 Feb 2009 02:36:59 +0000 (UTC)
X-Mailer: git-send-email 1.6.2.rc0.204.gf6b427
In-Reply-To: <1234406219-19547-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109562>

This is a legacy parameter, from back when the WindowCache was
per-repository and not per-process.  We no longer need to pass
it down, so I'm ripping it out.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../tst/org/spearce/jgit/lib/PackWriterTest.java   |    2 +-
 .../tst/org/spearce/jgit/lib/T0004_PackReader.java |    2 +-
 .../org/spearce/jgit/transport/IndexPackTest.java  |    4 ++--
 .../src/org/spearce/jgit/lib/PackFile.java         |    5 +----
 .../src/org/spearce/jgit/lib/Repository.java       |    4 ++--
 5 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackWriterTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackWriterTest.java
index e828ccc..f7139fc 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackWriterTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackWriterTest.java
@@ -471,7 +471,7 @@ private void verifyOpenPack(final boolean thin) throws IOException {
 		indexer.setKeepEmpty(true);
 		indexer.setFixThin(thin);
 		indexer.index(new TextProgressMonitor());
-		pack = new PackFile(db, indexFile, packFile);
+		pack = new PackFile(indexFile, packFile);
 	}
 
 	private void verifyObjectsOrder(final ObjectId objectsOrder[]) {
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0004_PackReader.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0004_PackReader.java
index 6ffb904..b9e5b49 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0004_PackReader.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0004_PackReader.java
@@ -54,7 +54,7 @@ public void test003_lookupCompressedObject() throws IOException {
 		final PackedObjectLoader or;
 
 		id = ObjectId.fromString("902d5476fa249b7abc9d84c611577a81381f0327");
-		pr = new PackFile(db, TEST_IDX, TEST_PACK);
+		pr = new PackFile(TEST_IDX, TEST_PACK);
 		or = pr.get(new WindowCursor(), id);
 		assertNotNull(or);
 		assertEquals(Constants.OBJ_TREE, or.getType());
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/transport/IndexPackTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/transport/IndexPackTest.java
index 46bd969..0c6e678 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/transport/IndexPackTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/transport/IndexPackTest.java
@@ -68,7 +68,7 @@ public void test1() throws  IOException {
 		try {
 			IndexPack pack = new IndexPack(db, is, new File(trash, "tmp_pack1"));
 			pack.index(new TextProgressMonitor());
-			PackFile file = new PackFile(db, new File(trash, "tmp_pack1.idx"), new File(trash, "tmp_pack1.pack"));
+			PackFile file = new PackFile(new File(trash, "tmp_pack1.idx"), new File(trash, "tmp_pack1.pack"));
 			assertTrue(file.hasObject(ObjectId.fromString("4b825dc642cb6eb9a060e54bf8d69288fbee4904")));
 			assertTrue(file.hasObject(ObjectId.fromString("540a36d136cf413e4b064c2b0e0a4db60f77feab")));
 			assertTrue(file.hasObject(ObjectId.fromString("5b6e7c66c276e7610d4a73c70ec1a1f7c1003259")));
@@ -94,7 +94,7 @@ public void test2() throws  IOException {
 		try {
 			IndexPack pack = new IndexPack(db, is, new File(trash, "tmp_pack2"));
 			pack.index(new TextProgressMonitor());
-			PackFile file = new PackFile(db, new File(trash, "tmp_pack2.idx"), new File(trash, "tmp_pack2.pack"));
+			PackFile file = new PackFile(new File(trash, "tmp_pack2.idx"), new File(trash, "tmp_pack2.pack"));
 			assertTrue(file.hasObject(ObjectId.fromString("02ba32d3649e510002c21651936b7077aa75ffa9")));
 			assertTrue(file.hasObject(ObjectId.fromString("0966a434eb1a025db6b71485ab63a3bfbea520b6")));
 			assertTrue(file.hasObject(ObjectId.fromString("09efc7e59a839528ac7bda9fa020dc9101278680")));
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
index 0de4c55..8368827 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
@@ -65,8 +65,6 @@
 	/**
 	 * Construct a reader for an existing, pre-indexed packfile.
 	 * 
-	 * @param parentRepo
-	 *            Git repository holding this pack file
 	 * @param idxFile
 	 *            path of the <code>.idx</code> file listing the contents.
 	 * @param packFile
@@ -74,8 +72,7 @@
 	 * @throws IOException
 	 *             the index file cannot be accessed at this time.
 	 */
-	public PackFile(final Repository parentRepo, final File idxFile,
-			final File packFile) throws IOException {
+	public PackFile(final File idxFile, final File packFile) throws IOException {
 		pack = new WindowedFile(packFile) {
 			@Override
 			protected void onOpen() throws IOException {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index 8d35f82..963b6e0 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -800,7 +800,7 @@ synchronized (this) {
 			final PackFile[] cur = packFileList;
 			final PackFile[] arr = new PackFile[cur.length + 1];
 			System.arraycopy(cur, 0, arr, 1, cur.length);
-			arr[0] = new PackFile(this, idx, pack);
+			arr[0] = new PackFile(idx, pack);
 			packFileList = arr;
 		}
 	}
@@ -849,7 +849,7 @@ public boolean accept(final File baseDir, final String n) {
 				}
 
 				try {
-					packList.add(new PackFile(this, idxFile, packFile));
+					packList.add(new PackFile(idxFile, packFile));
 				} catch (IOException ioe) {
 					// Whoops. That's not a pack!
 					//
-- 
1.6.2.rc0.204.gf6b427

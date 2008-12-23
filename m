From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 07/13] Don't open a PackFile multiple times on scanForPacks
Date: Mon, 22 Dec 2008 16:27:17 -0800
Message-ID: <1229992043-1053-8-git-send-email-spearce@spearce.org>
References: <1229992043-1053-1-git-send-email-spearce@spearce.org>
 <1229992043-1053-2-git-send-email-spearce@spearce.org>
 <1229992043-1053-3-git-send-email-spearce@spearce.org>
 <1229992043-1053-4-git-send-email-spearce@spearce.org>
 <1229992043-1053-5-git-send-email-spearce@spearce.org>
 <1229992043-1053-6-git-send-email-spearce@spearce.org>
 <1229992043-1053-7-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Dec 23 01:30:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEv9w-0005lu-EP
	for gcvg-git-2@gmane.org; Tue, 23 Dec 2008 01:30:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752784AbYLWA1l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2008 19:27:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752649AbYLWA1k
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Dec 2008 19:27:40 -0500
Received: from george.spearce.org ([209.20.77.23]:54483 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797AbYLWA13 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2008 19:27:29 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id F2FC838239; Tue, 23 Dec 2008 00:27:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 9514A38221;
	Tue, 23 Dec 2008 00:27:26 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc4.301.g5497a
In-Reply-To: <1229992043-1053-7-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103787>

If we already have a given PackFile open in this repository then
we should reuse the existing PackFile handle.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/PackFile.java         |    5 +++++
 .../src/org/spearce/jgit/lib/Repository.java       |    8 +++++++-
 .../src/org/spearce/jgit/lib/WindowedFile.java     |    7 ++++++-
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
index ca5681b..fc1b6ea 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
@@ -94,6 +94,11 @@ final PackedObjectLoader resolveBase(final WindowCursor curs, final long ofs)
 		return reader(curs, ofs);
 	}
 
+	/** @return the File object which locates this pack on disk. */
+	public File getPackFile() {
+		return pack.getFile();
+	}
+
 	/**
 	 * Determine if an object is contained within the pack file.
 	 * <p>
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index 89ad991..8f6e96e 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -825,6 +825,7 @@ synchronized (this) {
 	 */
 	public void scanForPacks() {
 		final ArrayList<PackFile> p = new ArrayList<PackFile>();
+		p.addAll(Arrays.asList(packs()));
 		for (final File d : objectsDirs())
 			scanForPacks(new File(d, "pack"), p);
 		final PackFile[] arr = new PackFile[p.size()];
@@ -843,7 +844,7 @@ public boolean accept(final File baseDir, final String n) {
 			}
 		});
 		if (idxList != null) {
-			for (final String indexName : idxList) {
+			SCAN: for (final String indexName : idxList) {
 				final String n = indexName.substring(0, indexName.length() - 4);
 				final File idxFile = new File(packDir, n + ".idx");
 				final File packFile = new File(packDir, n + ".pack");
@@ -856,6 +857,11 @@ public boolean accept(final File baseDir, final String n) {
 					continue;
 				}
 
+				for (final PackFile p : packList) {
+					if (packFile.equals(p.getPackFile()))
+						continue SCAN;
+				}
+
 				try {
 					packList.add(new PackFile(this, idxFile, packFile));
 				} catch (IOException ioe) {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowedFile.java b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowedFile.java
index 454f98b..f640c42 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowedFile.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowedFile.java
@@ -101,13 +101,18 @@ public long length() {
 		return length;
 	}
 
+	/** @return the absolute file object this file reads from. */
+	public File getFile() {
+		return fPath.getAbsoluteFile();
+	}
+
 	/**
 	 * Get the path name of this file.
 	 * 
 	 * @return the absolute path name of the file.
 	 */
 	public String getName() {
-		return fPath.getAbsolutePath();
+		return getFile().getPath();
 	}
 
 	/**
-- 
1.6.1.rc4.301.g5497a

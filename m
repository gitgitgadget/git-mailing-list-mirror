From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 4/8] Allow a DirCache to be created with no backing store file
Date: Mon, 13 Oct 2008 14:10:13 -0700
Message-ID: <1223932217-4771-5-git-send-email-spearce@spearce.org>
References: <1223932217-4771-1-git-send-email-spearce@spearce.org>
 <1223932217-4771-2-git-send-email-spearce@spearce.org>
 <1223932217-4771-3-git-send-email-spearce@spearce.org>
 <1223932217-4771-4-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon Oct 13 23:11:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpUhY-0001zY-J3
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 23:11:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756031AbYJMVKc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 17:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754362AbYJMVKa
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 17:10:30 -0400
Received: from george.spearce.org ([209.20.77.23]:39776 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756042AbYJMVKW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 17:10:22 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 6520538360; Mon, 13 Oct 2008 21:10:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 2880438360;
	Mon, 13 Oct 2008 21:10:19 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.2.706.g340fc
In-Reply-To: <1223932217-4771-4-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98147>

This permits using a DirCache as a temporary storage area in memory
only, with no chance of it being written out to disk.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/dircache/DirCache.java    |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCache.java b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCache.java
index b3c57ad..c5a4f91 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCache.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCache.java
@@ -111,6 +111,17 @@ static int cmp(final byte[] aPath, final int aLen, final byte[] bPath,
 	}
 
 	/**
+	 * Create a new empty index which is never stored on disk.
+	 * 
+	 * @return an empty cache which has no backing store file. The cache may not
+	 *         be read or written, but it may be queried and updated (in
+	 *         memory).
+	 */
+	public static DirCache newInCore() {
+		return new DirCache(null);
+	}
+
+	/**
 	 * Create a new in-core index representation and read an index from disk.
 	 * <p>
 	 * The new index will be read before it is returned to the caller. Read
@@ -297,6 +308,8 @@ void replace(final DirCacheEntry[] e, final int cnt) {
 	 *             library does not support.
 	 */
 	public void read() throws IOException, CorruptObjectException {
+		if (liveFile == null)
+			throw new IOException("DirCache does not have a backing file");
 		if (!liveFile.exists())
 			clear();
 		else if (liveFile.lastModified() != lastModified) {
@@ -407,6 +420,8 @@ private static boolean is_DIRC(final byte[] hdr) {
 	 *             hold the lock.
 	 */
 	public boolean lock() throws IOException {
+		if (liveFile == null)
+			throw new IOException("DirCache does not have a backing file");
 		final LockFile tmp = new LockFile(liveFile);
 		if (tmp.lock()) {
 			tmp.setNeedStatInformation(true);
@@ -515,6 +530,8 @@ public boolean commit() {
 	}
 
 	private void requireLocked(final LockFile tmp) {
+		if (liveFile == null)
+			throw new IllegalStateException("DirCache is not locked");
 		if (tmp == null)
 			throw new IllegalStateException("DirCache "
 					+ liveFile.getAbsolutePath() + " not locked.");
-- 
1.6.0.2.706.g340fc

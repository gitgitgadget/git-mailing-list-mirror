From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [EGIT PATCH 1/4] Detect path names which overflow the name length field in the index
Date: Mon, 18 Aug 2008 09:35:30 -0700
Message-ID: <1219077333-29226-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org, John Franey <jjfraney@gmail.com>
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon Aug 18 18:36:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KV7ij-0002lV-Ew
	for gcvg-git-2@gmane.org; Mon, 18 Aug 2008 18:36:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752809AbYHRQfg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 12:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752398AbYHRQfg
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 12:35:36 -0400
Received: from george.spearce.org ([209.20.77.23]:43110 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752165AbYHRQff (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 12:35:35 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 9757438379; Mon, 18 Aug 2008 16:35:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id DE5C538368;
	Mon, 18 Aug 2008 16:35:33 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.87.g2858d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92712>

C Git allows a path name to be longer than 4095 bytes by storing 4095
into the path name length field within flags and then searching for a
null terminator at the end of the path name, instead of relying on the
length indicatior.  We cannot do this (easily) from an InputStream so
we are currently going to just abort with an exception if we find such
an extremely long path name.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../org/spearce/jgit/dircache/DirCacheEntry.java   |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheEntry.java b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheEntry.java
index c481e43..bcf5596 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheEntry.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheEntry.java
@@ -81,6 +81,9 @@
 
 	private static final int P_FLAGS = 60;
 
+	/** Mask applied to data in {@link #P_FLAGS} to get the name length. */
+	private static final int NAME_MASK = 0xfff;
+
 	static final int INFO_LEN = 62;
 
 	private static final int ASSUME_VALID = 0x80;
@@ -101,7 +104,9 @@ DirCacheEntry(final byte[] sharedInfo, final int infoAt,
 
 		NB.readFully(in, info, infoOffset, INFO_LEN);
 
-		int pathLen = NB.decodeUInt16(info, infoOffset + P_FLAGS) & 0xfff;
+		int pathLen = NB.decodeUInt16(info, infoOffset + P_FLAGS) & NAME_MASK;
+		if (pathLen == NAME_MASK)
+			throw new IOException("Path name too long for jgit");
 		path = new byte[pathLen];
 		NB.readFully(in, path, 0, pathLen);
 
@@ -135,6 +140,8 @@ public DirCacheEntry(final byte[] newPath) {
 		infoOffset = 0;
 
 		path = newPath;
+		if (path.length >= NAME_MASK)
+			throw new IllegalArgumentException("Path name too long for jgit");
 		NB.encodeInt16(info, infoOffset + P_FLAGS, path.length);
 	}
 
@@ -364,10 +371,10 @@ public String getPathString() {
 	 *            the entry to copy ObjectId and meta fields from.
 	 */
 	public void copyMetaData(final DirCacheEntry src) {
-		final int pLen = NB.decodeUInt16(info, infoOffset + P_FLAGS) & 0xfff;
+		final int pLen = NB.decodeUInt16(info, infoOffset + P_FLAGS) & NAME_MASK;
 		System.arraycopy(src.info, src.infoOffset, info, infoOffset, INFO_LEN);
 		NB.encodeInt16(info, infoOffset + P_FLAGS, pLen
-				| NB.decodeUInt16(info, infoOffset + P_FLAGS) & ~0xfff);
+				| NB.decodeUInt16(info, infoOffset + P_FLAGS) & ~NAME_MASK);
 	}
 
 	private long decodeTS(final int pIdx) {
-- 
1.6.0.87.g2858d

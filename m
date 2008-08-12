From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [EGIT PATCH 17/26] Support copying meta fields from one DirCacheEntry to another
Date: Mon, 11 Aug 2008 18:08:04 -0700
Message-ID: <1218503293-14057-18-git-send-email-spearce@spearce.org>
References: <1218503293-14057-1-git-send-email-spearce@spearce.org>
 <1218503293-14057-2-git-send-email-spearce@spearce.org>
 <1218503293-14057-3-git-send-email-spearce@spearce.org>
 <1218503293-14057-4-git-send-email-spearce@spearce.org>
 <1218503293-14057-5-git-send-email-spearce@spearce.org>
 <1218503293-14057-6-git-send-email-spearce@spearce.org>
 <1218503293-14057-7-git-send-email-spearce@spearce.org>
 <1218503293-14057-8-git-send-email-spearce@spearce.org>
 <1218503293-14057-9-git-send-email-spearce@spearce.org>
 <1218503293-14057-10-git-send-email-spearce@spearce.org>
 <1218503293-14057-11-git-send-email-spearce@spearce.org>
 <1218503293-14057-12-git-send-email-spearce@spearce.org>
 <1218503293-14057-13-git-send-email-spearce@spearce.org>
 <1218503293-14057-14-git-send-email-spearce@spearce.org>
 <1218503293-14057-15-git-send-email-spearce@spearce.org>
 <1218503293-14057-16-git-send-email-spearce@spearce.org>
 <1218503293-14057-17-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Aug 12 03:11:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSiPX-0006OQ-0h
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 03:10:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751709AbYHLBIw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 21:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751705AbYHLBIu
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 21:08:50 -0400
Received: from george.spearce.org ([209.20.77.23]:38607 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876AbYHLBI0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 21:08:26 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id F05083837A; Tue, 12 Aug 2008 01:08:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 3276C381FD;
	Tue, 12 Aug 2008 01:08:18 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.rc2.22.g71b99
In-Reply-To: <1218503293-14057-17-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92040>

When an application moves a DirCacheEntry record from one path to
another path in the index we need to recreate the entry object and
also copy the meta fields from the old entry to the new entry.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../org/spearce/jgit/dircache/DirCacheEntry.java   |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheEntry.java b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheEntry.java
index eba2678..2b5ce03 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheEntry.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheEntry.java
@@ -354,6 +354,22 @@ public class DirCacheEntry {
 		return Constants.CHARSET.decode(ByteBuffer.wrap(path)).toString();
 	}
 
+	/**
+	 * Copy the ObjectId and other meta fields from an existing entry.
+	 * <p>
+	 * This method copies everything except the path from one entry to another,
+	 * supporting renaming.
+	 * 
+	 * @param src
+	 *            the entry to copy ObjectId and meta fields from.
+	 */
+	public void copyMetaData(final DirCacheEntry src) {
+		final int pLen = NB.decodeUInt16(info, infoOffset + P_FLAGS) & 0xfff;
+		System.arraycopy(src.info, src.infoOffset, info, infoOffset, INFO_LEN);
+		NB.encodeInt16(info, infoOffset + P_FLAGS, pLen
+				| NB.decodeUInt16(info, infoOffset + P_FLAGS) & ~0xfff);
+	}
+
 	private long decodeTS(final int pIdx) {
 		final int base = infoOffset + pIdx;
 		final int sec = NB.decodeInt32(info, base);
-- 
1.6.0.rc2.22.g71b99

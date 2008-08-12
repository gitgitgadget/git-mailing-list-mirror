From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [EGIT PATCH 16/26] Support recursively getting all entries under a subtree path
Date: Mon, 11 Aug 2008 18:08:03 -0700
Message-ID: <1218503293-14057-17-git-send-email-spearce@spearce.org>
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
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Aug 12 03:11:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSiPX-0006OQ-M3
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 03:10:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751738AbYHLBIx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 21:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751733AbYHLBIw
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 21:08:52 -0400
Received: from george.spearce.org ([209.20.77.23]:38604 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751376AbYHLBIZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 21:08:25 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 39AB438393; Tue, 12 Aug 2008 01:08:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id E0A8C38376;
	Tue, 12 Aug 2008 01:08:17 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.rc2.22.g71b99
In-Reply-To: <1218503293-14057-16-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92038>

Some applications need to process through all entries of a subtree.
A good example is if the entries need to be recreated into another
subtree to support a "cp -r a b" or "mv a b" operation.

The getEntriesWithin method returns an array of all entries within
a single subtree path, allowing the aplication to process over that
array in order.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/dircache/DirCache.java    |   22 ++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCache.java b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCache.java
index e48fdec..302c514 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCache.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCache.java
@@ -631,6 +631,28 @@ public class DirCache {
 		return i < 0 ? null : sortedEntries[i];
 	}
 
+	/**
+	 * Recursively get all entries within a subtree.
+	 * 
+	 * @param path
+	 *            the subtree path to get all entries within.
+	 * @return all entries recursively contained within the subtree.
+	 */
+	public DirCacheEntry[] getEntriesWithin(String path) {
+		if (!path.endsWith("/"))
+			path += "/";
+		final byte[] p = Constants.encode(path);
+		final int pLen = p.length;
+
+		int eIdx = findEntry(p, pLen);
+		if (eIdx < 0)
+			eIdx = -(eIdx + 1);
+		final int lastIdx = nextEntry(p, pLen, eIdx);
+		final DirCacheEntry[] r = new DirCacheEntry[lastIdx - eIdx];
+		System.arraycopy(sortedEntries, eIdx, r, 0, r.length);
+		return r;
+	}
+
 	void toArray(final int i, final DirCacheEntry[] dst, final int off,
 			final int cnt) {
 		System.arraycopy(sortedEntries, i, dst, off, cnt);
-- 
1.6.0.rc2.22.g71b99

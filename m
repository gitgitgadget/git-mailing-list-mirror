From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [EGIT PATCH 14/26] Support creating a new DirCacheEntry for an arbitrary path
Date: Mon, 11 Aug 2008 18:08:01 -0700
Message-ID: <1218503293-14057-15-git-send-email-spearce@spearce.org>
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
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Aug 12 03:11:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSiPV-0006OQ-7Q
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 03:10:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386AbYHLBIr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 21:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751674AbYHLBIp
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 21:08:45 -0400
Received: from george.spearce.org ([209.20.77.23]:38598 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751207AbYHLBIX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 21:08:23 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 2F1073838B; Tue, 12 Aug 2008 01:08:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 604C238393;
	Tue, 12 Aug 2008 01:08:17 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.rc2.22.g71b99
In-Reply-To: <1218503293-14057-14-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92055>

Applications which use a DirCacheBuilder may need to build their own
DirCacheEntry in order to insert new records into the index file.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../org/spearce/jgit/dircache/DirCacheEntry.java   |   24 ++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheEntry.java b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheEntry.java
index 8ca8f22..eba2678 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheEntry.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheEntry.java
@@ -114,6 +114,30 @@ public class DirCacheEntry {
 			in.skip(expLen - actLen);
 	}
 
+	/**
+	 * Create an empty entry.
+	 * 
+	 * @param newPath
+	 *            name of the cache entry.
+	 */
+	public DirCacheEntry(final String newPath) {
+		this(Constants.encode(newPath));
+	}
+
+	/**
+	 * Create an empty entry.
+	 * 
+	 * @param newPath
+	 *            name of the cache entry, in the standard encoding.
+	 */
+	public DirCacheEntry(final byte[] newPath) {
+		info = new byte[INFO_LEN];
+		infoOffset = 0;
+
+		path = newPath;
+		NB.encodeInt16(info, infoOffset + P_FLAGS, path.length);
+	}
+
 	void write(final OutputStream os) throws IOException {
 		final int pathLen = path.length;
 		os.write(info, infoOffset, INFO_LEN);
-- 
1.6.0.rc2.22.g71b99

From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 7/8] Allow DirCacheEntry instances to be created with stage > 0
Date: Mon, 13 Oct 2008 14:10:16 -0700
Message-ID: <1223932217-4771-8-git-send-email-spearce@spearce.org>
References: <1223932217-4771-1-git-send-email-spearce@spearce.org>
 <1223932217-4771-2-git-send-email-spearce@spearce.org>
 <1223932217-4771-3-git-send-email-spearce@spearce.org>
 <1223932217-4771-4-git-send-email-spearce@spearce.org>
 <1223932217-4771-5-git-send-email-spearce@spearce.org>
 <1223932217-4771-6-git-send-email-spearce@spearce.org>
 <1223932217-4771-7-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon Oct 13 23:11:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpUhX-0001zY-Q6
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 23:11:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756516AbYJMVKa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 17:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756429AbYJMVK2
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 17:10:28 -0400
Received: from george.spearce.org ([209.20.77.23]:39785 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754362AbYJMVKX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 17:10:23 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id B304A383A6; Mon, 13 Oct 2008 21:10:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 9F6223826E;
	Mon, 13 Oct 2008 21:10:20 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.2.706.g340fc
In-Reply-To: <1223932217-4771-7-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98152>

As the stage is part of the sorting criteria for DirCacheEntry
objects we don't allow the stage to be modified on the fly in
an existing instance.  Instead the stage must be set by reading
it from the on-disk format or by creating a new entry with the
proper path and stage components.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../org/spearce/jgit/dircache/DirCacheEntry.java   |   52 +++++++++++++++++---
 1 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheEntry.java b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheEntry.java
index 355cd3e..9304501 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheEntry.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheEntry.java
@@ -60,6 +60,18 @@
 public class DirCacheEntry {
 	private static final byte[] nullpad = new byte[8];
 
+	/** The standard (fully merged) stage for an entry. */
+	public static final int STAGE_0 = 0;
+
+	/** The base tree revision for an entry. */
+	public static final int STAGE_1 = 1;
+
+	/** The first tree revision (usually called "ours"). */
+	public static final int STAGE_2 = 2;
+
+	/** The second tree revision (usually called "theirs"). */
+	public static final int STAGE_3 = 3;
+
 	// private static final int P_CTIME = 0;
 
 	// private static final int P_CTIME_NSEC = 4;
@@ -141,8 +153,8 @@ DirCacheEntry(final byte[] sharedInfo, final int infoAt,
 	}
 
 	/**
-	 * Create an empty entry.
-	 *
+	 * Create an empty entry at stage 0.
+	 * 
 	 * @param newPath
 	 *            name of the cache entry.
 	 */
@@ -151,20 +163,46 @@ public DirCacheEntry(final String newPath) {
 	}
 
 	/**
-	 * Create an empty entry.
-	 *
+	 * Create an empty entry at the specified stage.
+	 * 
+	 * @param newPath
+	 *            name of the cache entry.
+	 * @param stage
+	 *            the stage index of the new entry.
+	 */
+	public DirCacheEntry(final String newPath, final int stage) {
+		this(Constants.encode(newPath), stage);
+	}
+
+	/**
+	 * Create an empty entry at stage 0.
+	 * 
 	 * @param newPath
 	 *            name of the cache entry, in the standard encoding.
 	 */
 	public DirCacheEntry(final byte[] newPath) {
+		this(newPath, STAGE_0);
+	}
+
+	/**
+	 * Create an empty entry at the specified stage.
+	 * 
+	 * @param newPath
+	 *            name of the cache entry, in the standard encoding.
+	 * @param stage
+	 *            the stage index of the new entry.
+	 */
+	public DirCacheEntry(final byte[] newPath, final int stage) {
 		info = new byte[INFO_LEN];
 		infoOffset = 0;
-
 		path = newPath;
+
+		int flags = ((stage & 0x3) << 12);
 		if (path.length < NAME_MASK)
-			NB.encodeInt16(info, infoOffset + P_FLAGS, path.length);
+			flags |= path.length;
 		else
-			NB.encodeInt16(info, infoOffset + P_FLAGS, NAME_MASK);
+			flags |= NAME_MASK;
+		NB.encodeInt16(info, infoOffset + P_FLAGS, flags);
 	}
 
 	void write(final OutputStream os) throws IOException {
-- 
1.6.0.2.706.g340fc

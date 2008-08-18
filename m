From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 12/14] Allow application code to set ObjectIds in DirCacheEntry
Date: Mon, 18 Aug 2008 16:53:20 -0700
Message-ID: <1219103602-32222-13-git-send-email-spearce@spearce.org>
References: <1219103602-32222-1-git-send-email-spearce@spearce.org>
 <1219103602-32222-2-git-send-email-spearce@spearce.org>
 <1219103602-32222-3-git-send-email-spearce@spearce.org>
 <1219103602-32222-4-git-send-email-spearce@spearce.org>
 <1219103602-32222-5-git-send-email-spearce@spearce.org>
 <1219103602-32222-6-git-send-email-spearce@spearce.org>
 <1219103602-32222-7-git-send-email-spearce@spearce.org>
 <1219103602-32222-8-git-send-email-spearce@spearce.org>
 <1219103602-32222-9-git-send-email-spearce@spearce.org>
 <1219103602-32222-10-git-send-email-spearce@spearce.org>
 <1219103602-32222-11-git-send-email-spearce@spearce.org>
 <1219103602-32222-12-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 01:55:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVEZA-0006i3-OY
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 01:55:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753813AbYHRXx6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 19:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754169AbYHRXx4
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 19:53:56 -0400
Received: from george.spearce.org ([209.20.77.23]:45155 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753723AbYHRXxb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 19:53:31 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id B1EB138375; Mon, 18 Aug 2008 23:53:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 36C563838A;
	Mon, 18 Aug 2008 23:53:26 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.87.g2858d
In-Reply-To: <1219103602-32222-12-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92777>

We support setting the ObjectId both from AnyObjectId (as we copy it)
and from a raw byte[] (as we are really copying into a raw byte[]).
The latter form is the most efficient as it probably permits callers
to avoid unnecessary conversion to some form of AnyObjectId.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../org/spearce/jgit/dircache/DirCacheEntry.java   |   26 ++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheEntry.java b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheEntry.java
index 011bc16..a83cc78 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheEntry.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheEntry.java
@@ -43,6 +43,7 @@
 import java.nio.ByteBuffer;
 import java.util.Arrays;
 
+import org.spearce.jgit.lib.AnyObjectId;
 import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.FileMode;
 import org.spearce.jgit.lib.ObjectId;
@@ -346,6 +347,31 @@ public ObjectId getObjectId() {
 	}
 
 	/**
+	 * Set the ObjectId for the entry.
+	 * 
+	 * @param id
+	 *            new object identifier for the entry. May be
+	 *            {@link ObjectId#zeroId()} to remove the current identifier.
+	 */
+	public void setObjectId(final AnyObjectId id) {
+		id.copyRawTo(idBuffer(), idOffset());
+	}
+
+	/**
+	 * Set the ObjectId for the entry from the raw binary representation.
+	 * 
+	 * @param bs
+	 *            the raw byte buffer to read from. At least 20 bytes after p
+	 *            must be available within this byte array.
+	 * @param p
+	 *            position to read the first byte of data from.
+	 */
+	public void setObjectIdFromRaw(final byte[] bs, final int p) {
+		final int n = Constants.OBJECT_ID_LENGTH;
+		System.arraycopy(bs, p, idBuffer(), idOffset(), n);
+	}
+
+	/**
 	 * Get the entry's complete path.
 	 * <p>
 	 * This method is not very efficient and is primarily meant for debugging
-- 
1.6.0.87.g2858d

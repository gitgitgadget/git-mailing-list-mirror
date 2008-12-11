From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 1/5] Add toByteArray() to TemporaryBuffer
Date: Wed, 10 Dec 2008 20:58:38 -0800
Message-ID: <1228971522-28764-2-git-send-email-spearce@spearce.org>
References: <1228971522-28764-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Dec 11 06:00:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAdeg-000260-1y
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 06:00:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754560AbYLKE6s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 23:58:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754486AbYLKE6r
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 23:58:47 -0500
Received: from george.spearce.org ([209.20.77.23]:51651 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753023AbYLKE6p (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 23:58:45 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 801CC3821F; Thu, 11 Dec 2008 04:58:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 7FFC738200;
	Thu, 11 Dec 2008 04:58:43 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc2.299.gead4c
In-Reply-To: <1228971522-28764-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102776>

It can be more useful to convert a buffered output stream into
a single byte array, without paying the penalties associated
with ByteArrayOutputStream to do the same action.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/util/TemporaryBuffer.java |   34 ++++++++++++++++++++
 1 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/util/TemporaryBuffer.java b/org.spearce.jgit/src/org/spearce/jgit/util/TemporaryBuffer.java
index d597c38..b1ffd6e 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/util/TemporaryBuffer.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/util/TemporaryBuffer.java
@@ -182,6 +182,40 @@ public long length() {
 	}
 
 	/**
+	 * Convert this buffer's contents into a contiguous byte array.
+	 * <p>
+	 * The buffer is only complete after {@link #close()} has been invoked.
+	 * 
+	 * @return the complete byte array; length matches {@link #length()}.
+	 * @throws IOException
+	 *             an error occurred reading from a local temporary file
+	 * @throws OutOfMemoryError
+	 *             the buffer cannot fit in memory
+	 */
+	public byte[] toByteArray() throws IOException {
+		final long len = length();
+		if (Integer.MAX_VALUE < len)
+			throw new OutOfMemoryError("Length exceeds maximum array size");
+
+		final byte[] out = new byte[(int) len];
+		if (blocks != null) {
+			int outPtr = 0;
+			for (final Block b : blocks) {
+				System.arraycopy(b.buffer, 0, out, outPtr, b.count);
+				outPtr += b.count;
+			}
+		} else {
+			final FileInputStream in = new FileInputStream(onDiskFile);
+			try {
+				NB.readFully(in, out, 0, (int) len);
+			} finally {
+				in.close();
+			}
+		}
+		return out;
+	}
+
+	/**
 	 * Send this buffer to an output stream.
 	 * <p>
 	 * This method may only be invoked after {@link #close()} has completed
-- 
1.6.1.rc2.299.gead4c

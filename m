From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [EGIT PATCH 11/11] Teach NB how to encode/decode an unsigned 16 bit integer
Date: Sun, 10 Aug 2008 01:46:26 -0700
Message-ID: <1218357986-19671-12-git-send-email-spearce@spearce.org>
References: <1218357986-19671-1-git-send-email-spearce@spearce.org>
 <1218357986-19671-2-git-send-email-spearce@spearce.org>
 <1218357986-19671-3-git-send-email-spearce@spearce.org>
 <1218357986-19671-4-git-send-email-spearce@spearce.org>
 <1218357986-19671-5-git-send-email-spearce@spearce.org>
 <1218357986-19671-6-git-send-email-spearce@spearce.org>
 <1218357986-19671-7-git-send-email-spearce@spearce.org>
 <1218357986-19671-8-git-send-email-spearce@spearce.org>
 <1218357986-19671-9-git-send-email-spearce@spearce.org>
 <1218357986-19671-10-git-send-email-spearce@spearce.org>
 <1218357986-19671-11-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 10 10:48:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KS6b8-00020G-8l
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 10:48:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752646AbYHJIqz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 04:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752430AbYHJIqy
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 04:46:54 -0400
Received: from george.spearce.org ([209.20.77.23]:51273 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752470AbYHJIqf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 04:46:35 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id EDBF538376; Sun, 10 Aug 2008 08:46:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 5CB3038375;
	Sun, 10 Aug 2008 08:46:33 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.rc2.219.g1250ab
In-Reply-To: <1218357986-19671-11-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91822>

The DIRC (aka index) file format in Git uses a 16 bit unsigned int
field in at least one of the members for a file record.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 org.spearce.jgit/src/org/spearce/jgit/util/NB.java |   35 ++++++++++++++++++++
 1 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/util/NB.java b/org.spearce.jgit/src/org/spearce/jgit/util/NB.java
index 3af293a..ef21a4b 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/util/NB.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/util/NB.java
@@ -91,6 +91,22 @@ public final class NB {
 	}
 
 	/**
+	 * Convert sequence of 2 bytes (network byte order) into unsigned value.
+	 * 
+	 * @param intbuf
+	 *            buffer to acquire the 2 bytes of data from.
+	 * @param offset
+	 *            position within the buffer to begin reading from. This
+	 *            position and the next byte after it (for a total of 2 bytes)
+	 *            will be read.
+	 * @return unsigned integer value that matches the 16 bits read.
+	 */
+	public static int decodeUInt16(final byte[] intbuf, final int offset) {
+		int r = (intbuf[offset] << 8) & 0xff;
+		return r | (intbuf[offset + 1] & 0xff);
+	}
+
+	/**
 	 * Convert sequence of 4 bytes (network byte order) into signed value.
 	 * 
 	 * @param intbuf
@@ -148,6 +164,25 @@ public final class NB {
 	}
 
 	/**
+	 * Write a 16 bit integer as a sequence of 2 bytes (network byte order).
+	 * 
+	 * @param intbuf
+	 *            buffer to write the 2 bytes of data into.
+	 * @param offset
+	 *            position within the buffer to begin writing to. This position
+	 *            and the next byte after it (for a total of 2 bytes) will be
+	 *            replaced.
+	 * @param v
+	 *            the value to write.
+	 */
+	public static void encodeInt16(final byte[] intbuf, final int offset, int v) {
+		intbuf[offset + 1] = (byte) v;
+		v >>>= 8;
+
+		intbuf[offset] = (byte) v;
+	}
+
+	/**
 	 * Write a 32 bit integer as a sequence of 4 bytes (network byte order).
 	 * 
 	 * @param intbuf
-- 
1.6.0.rc2.219.g1250ab

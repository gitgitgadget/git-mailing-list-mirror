From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 07/10] Add 64 bit network byte order encoding to NB
Date: Mon, 23 Jun 2008 22:10:05 -0400
Message-ID: <1214273408-70793-8-git-send-email-spearce@spearce.org>
References: <1214273408-70793-1-git-send-email-spearce@spearce.org>
 <1214273408-70793-2-git-send-email-spearce@spearce.org>
 <1214273408-70793-3-git-send-email-spearce@spearce.org>
 <1214273408-70793-4-git-send-email-spearce@spearce.org>
 <1214273408-70793-5-git-send-email-spearce@spearce.org>
 <1214273408-70793-6-git-send-email-spearce@spearce.org>
 <1214273408-70793-7-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 04:11:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAy0X-0005iO-UI
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 04:11:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753334AbYFXCKn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 22:10:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753081AbYFXCKn
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 22:10:43 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:49777 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753161AbYFXCKl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 22:10:41 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1KAxzG-0001Oo-S2; Mon, 23 Jun 2008 22:10:26 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1007)
	id 19F5A20FBAE; Mon, 23 Jun 2008 22:10:37 -0400 (EDT)
Received: from localhost.localdomain (i2.home.spearce.org [10.123.0.15])
	by asimov.home.spearce.org (Postfix) with ESMTP id 23A2D20FBD1;
	Mon, 23 Jun 2008 22:10:09 -0400 (EDT)
X-Mailer: git-send-email 1.5.6.74.g8a5e
In-Reply-To: <1214273408-70793-7-git-send-email-spearce@spearce.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85977>

The pack index v2 file format uses a 64 bit network byte order
element for the 64 bit offset table.  We already have code to
read these elements, but we do not yet have code to write such
an element to an output file.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 org.spearce.jgit/src/org/spearce/jgit/util/NB.java |   37 ++++++++++++++++++++
 1 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/util/NB.java b/org.spearce.jgit/src/org/spearce/jgit/util/NB.java
index 61877b8..6bb65d4 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/util/NB.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/util/NB.java
@@ -172,6 +172,43 @@ public final class NB {
 		intbuf[offset] = (byte) v;
 	}
 
+	/**
+	 * Write a 64 bit integer as a sequence of 8 bytes (network byte order).
+	 * 
+	 * @param intbuf
+	 *            buffer to write the 48bytes of data into.
+	 * @param offset
+	 *            position within the buffer to begin writing to. This position
+	 *            and the next 7 bytes after it (for a total of 8 bytes) will be
+	 *            replaced.
+	 * @param v
+	 *            the value to write.
+	 */
+	public static void encodeInt64(final byte[] intbuf, final int offset, long v) {
+		intbuf[offset + 7] = (byte) v;
+		v >>>= 8;
+
+		intbuf[offset + 6] = (byte) v;
+		v >>>= 8;
+
+		intbuf[offset + 5] = (byte) v;
+		v >>>= 8;
+
+		intbuf[offset + 4] = (byte) v;
+		v >>>= 8;
+
+		intbuf[offset + 3] = (byte) v;
+		v >>>= 8;
+
+		intbuf[offset + 2] = (byte) v;
+		v >>>= 8;
+
+		intbuf[offset + 1] = (byte) v;
+		v >>>= 8;
+
+		intbuf[offset] = (byte) v;
+	}
+
 	private NB() {
 		// Don't create instances of a static only utility.
 	}
-- 
1.5.6.74.g8a5e

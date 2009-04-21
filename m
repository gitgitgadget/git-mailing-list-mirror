From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 03/10] Replace hand-coded read fully loop with NB.readFully
Date: Mon, 20 Apr 2009 18:21:05 -0700
Message-ID: <1240276872-17893-4-git-send-email-spearce@spearce.org>
References: <1240276872-17893-1-git-send-email-spearce@spearce.org>
 <1240276872-17893-2-git-send-email-spearce@spearce.org>
 <1240276872-17893-3-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 03:23:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lw4hS-00021g-S6
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 03:23:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757656AbZDUBVY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 21:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757634AbZDUBVV
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 21:21:21 -0400
Received: from george.spearce.org ([209.20.77.23]:33019 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756556AbZDUBVQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 21:21:16 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id C61A538265; Tue, 21 Apr 2009 01:21:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 5179438221;
	Tue, 21 Apr 2009 01:21:14 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.rc1.188.ga02b
In-Reply-To: <1240276872-17893-3-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117063>

This code predates the NB utility class.  I'd prefer to reuse the
code over keeping this duplicate copy of the logic.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../org/spearce/jgit/lib/UnpackedObjectLoader.java |   14 ++++++--------
 1 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/UnpackedObjectLoader.java b/org.spearce.jgit/src/org/spearce/jgit/lib/UnpackedObjectLoader.java
index f2cae87..b086821 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/UnpackedObjectLoader.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/UnpackedObjectLoader.java
@@ -46,6 +46,7 @@
 
 import org.spearce.jgit.errors.CorruptObjectException;
 import org.spearce.jgit.util.MutableInteger;
+import org.spearce.jgit.util.NB;
 import org.spearce.jgit.util.RawParseUtils;
 
 /**
@@ -74,17 +75,14 @@ public UnpackedObjectLoader(final Repository db, final AnyObjectId id)
 
 	private static byte[] readCompressed(final Repository db,
 			final AnyObjectId id) throws FileNotFoundException, IOException {
-		final FileInputStream objStream = new FileInputStream(db.toFile(id));
-		final byte[] compressed;
+		final FileInputStream in = new FileInputStream(db.toFile(id));
 		try {
-			compressed = new byte[objStream.available()];
-			int off = 0;
-			while (off < compressed.length)
-				off += objStream.read(compressed, off, compressed.length - off);
+			final byte[] compressed = new byte[(int) in.getChannel().size()];
+			NB.readFully(in, compressed, 0, compressed.length);
+			return compressed;
 		} finally {
-			objStream.close();
+			in.close();
 		}
-		return compressed;
 	}
 
 	/**
-- 
1.6.3.rc1.188.ga02b

From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 1/8] Correct thin pack completion in IndexPack to handle some bundles
Date: Mon, 30 Jun 2008 23:03:58 -0400
Message-ID: <1214881445-3931-2-git-send-email-spearce@spearce.org>
References: <1214881445-3931-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 01 05:14:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDWK7-0003pl-G5
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 05:14:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466AbYGADMu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 23:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbYGADMt
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 23:12:49 -0400
Received: from george.spearce.org ([209.20.77.23]:58260 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750825AbYGADMs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 23:12:48 -0400
X-Greylist: delayed 521 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Jun 2008 23:12:48 EDT
Received: by george.spearce.org (Postfix, from userid 1000)
	id E0AEA381FD; Tue,  1 Jul 2008 03:04:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=4.0 tests=ALL_TRUSTED,AWL autolearn=ham
	version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 76F0F38193;
	Tue,  1 Jul 2008 03:04:28 +0000 (UTC)
X-Mailer: git-send-email 1.5.6.74.g8a5e
In-Reply-To: <1214881445-3931-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86994>

Recently I saw a bundle with a chain of deltas to base objects as
A->B->C, where A was the delta depending on the base B.  In this
pack all of the objects used OBJ_REF_DELTA to link to their base
and C was not in the pack (it was assumed to be in the repository).

Because of the ordering of the ObjectIds for B and C jgit tried to
resolve A's delta base by pulling from the repository, as B was not
found in the pack file.  The reason B was not found was because it
was waiting in the queue (to be processed next) and we did not know
what B's ObjectId was.

By skipping objects whose ObjectLoader's aren't found we should be
able to resolve those objects later when their delta base does get
resolved in this pack.  However by the end of of this loop we must
have no more objects depending on something by ObjectId, as that is
an indication that the local repository is missing the objects we
must have to complete this thin pack.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/transport/IndexPack.java  |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java b/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
index 24a0577..29d99db 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
@@ -55,6 +55,7 @@ import java.util.zip.Deflater;
 import java.util.zip.Inflater;
 
 import org.spearce.jgit.errors.CorruptObjectException;
+import org.spearce.jgit.errors.MissingObjectException;
 import org.spearce.jgit.lib.BinaryDelta;
 import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.InflaterCache;
@@ -399,9 +400,10 @@ public class IndexPack {
 
 		final Deflater def = new Deflater(Deflater.DEFAULT_COMPRESSION, false);
 		long end = packOut.length() - 20;
-		while (!baseById.isEmpty()) {
-			final ObjectId baseId = baseById.keySet().iterator().next();
+		for (final ObjectId baseId : new ArrayList<ObjectId>(baseById.keySet())) {
 			final ObjectLoader ldr = repo.openObject(baseId);
+			if (ldr == null)
+				continue;
 			final byte[] data = ldr.getBytes();
 			final int typeCode = ldr.getType();
 			final PackedObjectInfo oe;
@@ -419,6 +421,11 @@ public class IndexPack {
 		}
 		def.end();
 
+		if (!baseById.isEmpty()) {
+			final ObjectId need = baseById.keySet().iterator().next();
+			throw new MissingObjectException(need, "delta base");
+		}
+
 		fixHeaderFooter();
 	}
 
-- 
1.5.6.74.g8a5e

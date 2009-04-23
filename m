From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 4/5] Test that ObjectLoader stays valid across repacks
Date: Wed, 22 Apr 2009 20:36:22 -0700
Message-ID: <1240457783-21434-5-git-send-email-spearce@spearce.org>
References: <1240457783-21434-1-git-send-email-spearce@spearce.org>
 <1240457783-21434-2-git-send-email-spearce@spearce.org>
 <1240457783-21434-3-git-send-email-spearce@spearce.org>
 <1240457783-21434-4-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Apr 23 05:38:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwplW-0005xI-4K
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 05:38:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753775AbZDWDgh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 23:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753145AbZDWDgf
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 23:36:35 -0400
Received: from george.spearce.org ([209.20.77.23]:47547 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752465AbZDWDg1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 23:36:27 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id E36D43821F; Thu, 23 Apr 2009 03:36:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 5E4C438215;
	Thu, 23 Apr 2009 03:36:25 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.rc1.205.g37f8
In-Reply-To: <1240457783-21434-4-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117287>

What we are trying to verify is that an ObjectLoader remains valid
if the underlying storage for the object has moved, such as when a
repository is repacked, the old pack was deleted, and the object is
now in the new pack.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../org/spearce/jgit/lib/ConcurrentRepackTest.java |   40 ++++++++++++++++++++
 1 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ConcurrentRepackTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ConcurrentRepackTest.java
index 825fbb8..b56e0f4 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ConcurrentRepackTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ConcurrentRepackTest.java
@@ -41,6 +41,7 @@
 import java.io.File;
 import java.io.FileOutputStream;
 import java.io.IOException;
+import java.util.Arrays;
 
 import org.spearce.jgit.errors.IncorrectObjectTypeException;
 import org.spearce.jgit.errors.MissingObjectException;
@@ -128,6 +129,45 @@ public void testObjectMovedWithinPack()
 		assertEquals(o2.name(), parse(o2).name());
 	}
 
+	public void testObjectMovedToNewPack2()
+			throws IncorrectObjectTypeException, IOException {
+		// Create an object and pack it. Then remove that pack and put the
+		// object into a different pack file, with some other object. We
+		// still should be able to access the objects.
+		//
+		final Repository eden = createNewEmptyRepo();
+		final RevObject o1 = writeBlob(eden, "o1");
+		final File[] out1 = pack(eden, o1);
+		assertEquals(o1.name(), parse(o1).name());
+
+		final ObjectLoader load1 = db.openBlob(o1);
+		assertNotNull(load1);
+
+		final RevObject o2 = writeBlob(eden, "o2");
+		pack(eden, o2, o1);
+
+		// Force close, and then delete, the old pack.
+		//
+		whackCache();
+		delete(out1);
+
+		// Now here is the interesting thing... can the loader we made
+		// earlier still resolve the object, even though its underlying
+		// pack is gone, but the object still exists.
+		//
+		final ObjectLoader load2 = db.openBlob(o1);
+		assertNotNull(load2);
+		assertNotSame(load1, load2);
+
+		final byte[] data2 = load2.getCachedBytes();
+		final byte[] data1 = load1.getCachedBytes();
+		assertNotNull(data2);
+		assertNotNull(data1);
+		assertNotSame(data1, data2); // cache should be per-pack, not per object
+		assertTrue(Arrays.equals(data1, data2));
+		assertEquals(load2.getType(), load1.getType());
+	}
+
 	private static void whackCache() {
 		final WindowCacheConfig config = new WindowCacheConfig();
 
-- 
1.6.3.rc1.205.g37f8

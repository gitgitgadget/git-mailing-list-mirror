From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 1/6] Make sure we get the right storage for loose/pack/loose and packed refs
Date: Wed, 20 May 2009 01:13:13 +0200
Message-ID: <1242774798-23639-2-git-send-email-robin.rosenberg@dewire.com>
References: <20090507155117.GS30527@spearce.org>
 <1242774798-23639-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed May 20 01:13:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6YV9-0003FB-SU
	for gcvg-git-2@gmane.org; Wed, 20 May 2009 01:13:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755036AbZESXNc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2009 19:13:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754608AbZESXNb
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 19:13:31 -0400
Received: from mail.dewire.com ([83.140.172.130]:25878 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755093AbZESXN1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2009 19:13:27 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 7C4F0145D128;
	Wed, 20 May 2009 01:13:26 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KUmME12mDtyl; Wed, 20 May 2009 01:13:22 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.11])
	by dewire.com (Postfix) with ESMTP id D781C145D120;
	Wed, 20 May 2009 01:13:21 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.dirty
In-Reply-To: <1242774798-23639-1-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119574>

Also adds a few some more test for refs, though not complete.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../tst/org/spearce/jgit/lib/RefTest.java          |   94 ++++++++++++++++++++
 .../src/org/spearce/jgit/lib/RefDatabase.java      |   26 ++++--
 2 files changed, 114 insertions(+), 6 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RefTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RefTest.java
index cae5143..7b0c9a9 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RefTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RefTest.java
@@ -36,8 +36,14 @@
  */
 package org.spearce.jgit.lib;
 
+import java.io.File;
+import java.io.FileOutputStream;
+import java.io.IOException;
 import java.util.Map;
 
+import org.spearce.jgit.lib.Ref.Storage;
+import org.spearce.jgit.lib.RefUpdate.Result;
+
 /**
  * Misc tests for refs. A lot of things are tested elsewhere so not having a
  * test for a ref related method, does not mean it is untested.
@@ -69,4 +75,92 @@ public void testReadAllIncludingSymrefs() throws Exception {
 		assertFalse(refmaster.isPeeled());
 		assertNull(refmaster.getPeeledObjectId());
 	}
+
+	public void testReadSymRefToPacked() throws IOException {
+		db.writeSymref("HEAD", "refs/heads/master");
+		Ref ref = db.getRef("HEAD");
+		assertEquals(Ref.Storage.LOOSE, ref.getStorage());
+	}
+
+	public void testReadSymRefToLoosePacked() throws IOException {
+		ObjectId pid = db.resolve("refs/heads/master^");
+		RefUpdate updateRef = db.updateRef("refs/heads/master");
+		updateRef.setNewObjectId(pid);
+		updateRef.setForceUpdate(true);
+		Result update = updateRef.update();
+		assertEquals(Result.FORCED, update); // internal
+
+		db.writeSymref("HEAD", "refs/heads/master");
+		Ref ref = db.getRef("HEAD");
+		assertEquals(Ref.Storage.LOOSE, ref.getStorage());
+	}
+
+	public void testReadLooseRef() throws IOException {
+		RefUpdate updateRef = db.updateRef("ref/heads/new");
+		updateRef.setNewObjectId(db.resolve("refs/heads/master"));
+		Result update = updateRef.update();
+		assertEquals(Result.NEW, update);
+		Ref ref = db.getRef("ref/heads/new");
+		assertEquals(Storage.LOOSE, ref.getStorage());
+	}
+
+	/**
+	 * Let an "outsider" create a loose ref with the same name as a packed one
+	 *
+	 * @throws IOException
+	 * @throws InterruptedException
+	 */
+	public void testReadLoosePackedRef() throws IOException,
+			InterruptedException {
+		Ref ref = db.getRef("refs/heads/master");
+		assertEquals(Storage.PACKED, ref.getStorage());
+		FileOutputStream os = new FileOutputStream(new File(db.getDirectory(),
+				"refs/heads/master"));
+		os.write(ref.getObjectId().name().getBytes());
+		os.write('\n');
+		os.close();
+
+		ref = db.getRef("refs/heads/master");
+		assertEquals(Storage.LOOSE_PACKED, ref.getStorage());
+	}
+
+	/**
+	 * Modify a packed ref using the API. This creates a loose ref too, ie.
+	 * LOOSE_PACKED
+	 *
+	 * @throws IOException
+	 */
+	public void testReadSimplePackedRefSameRepo() throws IOException {
+		Ref ref = db.getRef("refs/heads/master");
+		ObjectId pid = db.resolve("refs/heads/master^");
+		assertEquals(Storage.PACKED, ref.getStorage());
+		RefUpdate updateRef = db.updateRef("refs/heads/master");
+		updateRef.setNewObjectId(pid);
+		updateRef.setForceUpdate(true);
+		Result update = updateRef.update();
+		assertEquals(Result.FORCED, update);
+
+		ref = db.getRef("refs/heads/master");
+		assertEquals(Storage.LOOSE_PACKED, ref.getStorage());
+	}
+
+	/**
+	 * Delete a ref that exists both as packed and loose. Make sure the ref
+	 * cannot be resolved after delete.
+	 *
+	 * @throws IOException
+	 */
+	public void testDeleteLoosePacked() throws IOException {
+		ObjectId pid = db.resolve("refs/heads/master^");
+		RefUpdate updateRef = db.updateRef("refs/heads/master");
+		updateRef.setNewObjectId(pid);
+		updateRef.setForceUpdate(true);
+		Result update = updateRef.update();
+		assertEquals(Result.FORCED, update); // internal
+
+		RefUpdate updateRef2 = db.updateRef("refs/heads/master");
+		Result delete = updateRef2.delete();
+		assertEquals(Result.FORCED, delete);
+		assertNull(db.resolve("refs/heads/master"));
+	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
index 155ed9a..573fcac 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
@@ -283,8 +283,14 @@ private synchronized Ref readRefBasic(final String origName,
 		final long mtime = loose.lastModified();
 		if (ref != null) {
 			Long cachedlastModified = looseRefsMTime.get(name);
-			if (cachedlastModified != null && cachedlastModified == mtime)
-				return ref;
+			if (cachedlastModified != null && cachedlastModified == mtime) {
+				if (packedRefs.containsKey(origName))
+					return new Ref(Storage.LOOSE_PACKED, origName, ref
+							.getObjectId(), ref.getPeeledObjectId(), ref
+							.isPeeled());
+				else
+					return ref;
+			}
 			looseRefs.remove(origName);
 			looseRefsMTime.remove(origName);
 		}
@@ -349,12 +355,20 @@ private synchronized Ref readRefBasic(final String origName,
 			throw new IOException("Not a ref: " + name + ": " + line);
 		}
 
-		ref = new Ref(Ref.Storage.LOOSE, origName, name, id);
-
-		looseRefs.put(origName, ref);
-		ref = new Ref(Ref.Storage.LOOSE, origName, id);
+		Storage storage;
+		if (packedRefs.containsKey(name))
+			storage = Ref.Storage.LOOSE_PACKED;
+		else
+			storage = Ref.Storage.LOOSE;
+		ref = new Ref(storage, name, id);
 		looseRefs.put(name, ref);
 		looseRefsMTime.put(name, mtime);
+
+		if (!origName.equals(name)) {
+			ref = new Ref(Ref.Storage.LOOSE, origName, name, id);
+			looseRefs.put(origName, ref);
+		}
+
 		return ref;
 	}
 
-- 
1.6.3.dirty

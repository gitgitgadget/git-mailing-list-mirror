From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 04/10] Add more tests for RefUpdate
Date: Thu, 28 May 2009 00:08:51 +0200
Message-ID: <1243462137-24133-5-git-send-email-robin.rosenberg@dewire.com>
References: <20090520221651.GR30527@spearce.org>
 <1243462137-24133-1-git-send-email-robin.rosenberg@dewire.com>
 <1243462137-24133-2-git-send-email-robin.rosenberg@dewire.com>
 <1243462137-24133-3-git-send-email-robin.rosenberg@dewire.com>
 <1243462137-24133-4-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Thu May 28 00:09:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9RJk-0005Vu-6R
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 00:09:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757983AbZE0WJi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 18:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757457AbZE0WJg
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 18:09:36 -0400
Received: from mail.dewire.com ([83.140.172.130]:25352 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756483AbZE0WJe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 18:09:34 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id EF785145D123;
	Thu, 28 May 2009 00:09:33 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mu2juNQyxUqD; Thu, 28 May 2009 00:09:21 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.10])
	by dewire.com (Postfix) with ESMTP id 19F36145D131;
	Thu, 28 May 2009 00:09:00 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.dirty
In-Reply-To: <1243462137-24133-4-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120118>

Also checks more in one of the old tests

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../tst/org/spearce/jgit/lib/RefUpdateTest.java    |  189 ++++++++++++++++----
 1 files changed, 156 insertions(+), 33 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RefUpdateTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RefUpdateTest.java
index 55d7441..6b1975a 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RefUpdateTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RefUpdateTest.java
@@ -72,7 +72,8 @@ public void testNoCacheObjectIdSubclass() throws IOException {
 			// empty
 		};
 		ru.setNewObjectId(newid);
-		ru.update();
+		Result update = ru.update();
+		assertEquals(Result.NEW, update);
 		final Ref r = db.getAllRefs().get(newRef);
 		assertNotNull(r);
 		assertEquals(newRef, r.getName());
@@ -82,6 +83,25 @@ public void testNoCacheObjectIdSubclass() throws IOException {
 		assertEquals(newid.copy(), r.getObjectId());
 	}
 
+	/**
+	 * Delete a ref that is pointed to by HEAD
+	 *
+	 * @throws IOException
+	 */
+	public void testDeleteHEADreferencedRef() throws IOException {
+		ObjectId pid = db.resolve("refs/heads/master^");
+		RefUpdate updateRef = db.updateRef("refs/heads/master");
+		updateRef.setNewObjectId(pid);
+		updateRef.setForceUpdate(true);
+		Result update = updateRef.update();
+		assertEquals(Result.FORCED, update); // internal
+
+		RefUpdate updateRef2 = db.updateRef("refs/heads/master");
+		Result delete = updateRef2.delete();
+		assertEquals(Result.REJECTED_CURRENT_BRANCH, delete);
+		assertEquals(pid, db.resolve("refs/heads/master"));
+	}
+
 	public void testLooseDelete() throws IOException {
 		final String newRef = "refs/heads/abc";
 		RefUpdate ref = updateRef(newRef);
@@ -95,21 +115,32 @@ public void testDeleteHead() throws IOException {
 		delete(ref, Result.REJECTED_CURRENT_BRANCH, true, false);
 	}
 
-	public void testLogDeleted() throws IOException {
-		String refName = "refs/heads/a";
-		final File log = createLog(refName);
-		assertTrue(log.exists());
-		final RefUpdate ref = updateRef(refName);
-		delete(ref, Result.FAST_FORWARD);
-		assertFalse(log.exists());
-	}
+	/**
+	 * Delete a loose ref and make sure the directory in refs is deleted too,
+	 * and the reflog dir too
+	 *
+	 * @throws IOException
+	 */
+	public void testDeleteLooseAndItsDirectory() throws IOException {
+		ObjectId pid = db.resolve("refs/heads/c^");
+		RefUpdate updateRef = db.updateRef("refs/heads/z/c");
+		updateRef.setNewObjectId(pid);
+		updateRef.setForceUpdate(true);
+		Result update = updateRef.update();
+		assertEquals(Result.NEW, update); // internal
+		assertTrue(new File(db.getDirectory(), Constants.R_HEADS + "z")
+				.exists());
+		assertTrue(new File(db.getDirectory(), "logs/refs/heads/z").exists());
 
-	private File createLog(String name) throws IOException {
-		final File log = new File(db.getDirectory(), Constants.LOGS + "/"
-				+ name);
-		log.getParentFile().mkdirs();
-		log.createNewFile();
-		return log;
+		// The real test here
+		RefUpdate updateRef2 = db.updateRef("refs/heads/z/c");
+		updateRef2.setForceUpdate(true);
+		Result delete = updateRef2.delete();
+		assertEquals(Result.FORCED, delete);
+		assertNull(db.resolve("refs/heads/z/c"));
+		assertFalse(new File(db.getDirectory(), Constants.R_HEADS + "z")
+				.exists());
+		assertFalse(new File(db.getDirectory(), "logs/refs/heads/z").exists());
 	}
 
 	public void testDeleteNotFound() throws IOException {
@@ -130,24 +161,6 @@ public void testDeleteForce() throws IOException {
 		delete(ref, Result.FORCED);
 	}
 
-	public void testDeleteEmptyDirs() throws IOException {
-		final String top = "refs/heads/a";
-		final String newRef = top + "/b/c";
-		final String newRef2 = top + "/d";
-		updateRef(newRef).update();
-		updateRef(newRef2).update();
-		delete(updateRef(newRef2), Result.NO_CHANGE);
-		assertExists(true, top);
-		createLog(newRef);
-		delete(updateRef(newRef), Result.NO_CHANGE);
-		assertExists(false, top);
-		assertExists(false, Constants.LOGS + "/" + top);
-	}
-
-	private void assertExists(final boolean expected, final String name) {
-		assertEquals(expected, new File(db.getDirectory(), name).exists());
-	}
-
 	public void testRefKeySameAsOrigName() {
 		Map<String, Ref> allRefs = db.getAllRefs();
 		for (Entry<String, Ref> e : allRefs.entrySet()) {
@@ -155,4 +168,114 @@ public void testRefKeySameAsOrigName() {
 
 		}
 	}
+
+	/**
+	 * Try modify a ref forward, fast forward
+	 *
+	 * @throws IOException
+	 */
+	public void testUpdateRefForward() throws IOException {
+		ObjectId ppid = db.resolve("refs/heads/master^");
+		ObjectId pid = db.resolve("refs/heads/master");
+
+		RefUpdate updateRef = db.updateRef("refs/heads/master");
+		updateRef.setNewObjectId(ppid);
+		updateRef.setForceUpdate(true);
+		Result update = updateRef.update();
+		assertEquals(Result.FORCED, update);
+		assertEquals(ppid, db.resolve("refs/heads/master"));
+
+		// real test
+		RefUpdate updateRef2 = db.updateRef("refs/heads/master");
+		updateRef2.setNewObjectId(pid);
+		Result update2 = updateRef2.update();
+		assertEquals(Result.FAST_FORWARD, update2);
+		assertEquals(pid, db.resolve("refs/heads/master"));
+	}
+
+	/**
+	 * Delete a ref that exists both as packed and loose. Make sure the ref
+	 * cannot be resolved after delete.
+	 *
+	 * @throws IOException
+	 */
+	public void testDeleteLoosePacked() throws IOException {
+		ObjectId pid = db.resolve("refs/heads/c^");
+		RefUpdate updateRef = db.updateRef("refs/heads/c");
+		updateRef.setNewObjectId(pid);
+		updateRef.setForceUpdate(true);
+		Result update = updateRef.update();
+		assertEquals(Result.FORCED, update); // internal
+
+		// The real test here
+		RefUpdate updateRef2 = db.updateRef("refs/heads/c");
+		updateRef2.setForceUpdate(true);
+		Result delete = updateRef2.delete();
+		assertEquals(Result.FORCED, delete);
+		assertNull(db.resolve("refs/heads/c"));
+	}
+
+	/**
+	 * Try modify a ref to same
+	 *
+	 * @throws IOException
+	 */
+	public void testUpdateRefNoChange() throws IOException {
+		ObjectId pid = db.resolve("refs/heads/master");
+		RefUpdate updateRef = db.updateRef("refs/heads/master");
+		updateRef.setNewObjectId(pid);
+		Result update = updateRef.update();
+		assertEquals(Result.NO_CHANGE, update);
+		assertEquals(pid, db.resolve("refs/heads/master"));
+	}
+
+	/**
+	 * Try modify a ref, but get wrong expected old value
+	 *
+	 * @throws IOException
+	 */
+	public void testUpdateRefLockFailureWrongOldValue() throws IOException {
+		ObjectId pid = db.resolve("refs/heads/master");
+		RefUpdate updateRef = db.updateRef("refs/heads/master");
+		updateRef.setNewObjectId(pid);
+		updateRef.setExpectedOldObjectId(db.resolve("refs/heads/master^"));
+		Result update = updateRef.update();
+		assertEquals(Result.LOCK_FAILURE, update);
+		assertEquals(pid, db.resolve("refs/heads/master"));
+	}
+
+	/**
+	 * Try modify a ref that is locked
+	 *
+	 * @throws IOException
+	 */
+	public void testUpdateRefLockFailureLocked() throws IOException {
+		ObjectId opid = db.resolve("refs/heads/master");
+		ObjectId pid = db.resolve("refs/heads/master^");
+		RefUpdate updateRef = db.updateRef("refs/heads/master");
+		updateRef.setNewObjectId(pid);
+		LockFile lockFile1 = new LockFile(new File(db.getDirectory(),"refs/heads/master"));
+		assertTrue(lockFile1.lock()); // precondition to test
+		Result update = updateRef.update();
+		assertEquals(Result.LOCK_FAILURE, update);
+		assertEquals(opid, db.resolve("refs/heads/master"));
+		LockFile lockFile2 = new LockFile(new File(db.getDirectory(),"refs/heads/master"));
+		assertFalse(lockFile2.lock()); // was locked, still is
+	}
+
+	/**
+	 * Try to delete a ref. Delete requires force.
+	 *
+	 * @throws IOException
+	 */
+	public void testDeleteLoosePackedRejected() throws IOException {
+		ObjectId pid = db.resolve("refs/heads/c^");
+		ObjectId oldpid = db.resolve("refs/heads/c");
+		RefUpdate updateRef = db.updateRef("refs/heads/c");
+		updateRef.setNewObjectId(pid);
+		Result update = updateRef.update();
+		assertEquals(Result.REJECTED, update);
+		assertEquals(oldpid, db.resolve("refs/heads/c"));
+	}
+
 }
-- 
1.6.3.dirty

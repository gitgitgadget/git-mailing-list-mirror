From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [JGIT PATCH 2/2] Update the reflog for HEAD when the referenced branch is modified
Date: Sun, 16 Aug 2009 23:36:52 +0200
Message-ID: <1250458612-21095-2-git-send-email-robin.rosenberg@dewire.com>
References: <1250458612-21095-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Aug 16 23:37:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McnPa-0004jt-2X
	for gcvg-git-2@lo.gmane.org; Sun, 16 Aug 2009 23:37:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756148AbZHPVg5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Aug 2009 17:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755960AbZHPVg4
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Aug 2009 17:36:56 -0400
Received: from mail.dewire.com ([83.140.172.130]:13000 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756121AbZHPVgz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Aug 2009 17:36:55 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id A66D180280F;
	Sun, 16 Aug 2009 23:36:55 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mDSYyud3YNO0; Sun, 16 Aug 2009 23:36:54 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 907C41434E8C;
	Sun, 16 Aug 2009 23:36:54 +0200 (CEST)
X-Mailer: git-send-email 1.6.4.115.gc0eb0
In-Reply-To: <1250458612-21095-1-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126082>

This omission was mentioned in http://code.google.com/p/egit/issues/detail?id=5

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../tst/org/spearce/jgit/lib/RefUpdateTest.java    |   32 ++++++++++++++++++++
 .../src/org/spearce/jgit/lib/RefLogWriter.java     |    6 ++-
 .../src/org/spearce/jgit/lib/RefRename.java        |    6 +++-
 .../src/org/spearce/jgit/lib/RefUpdate.java        |   11 ++++++-
 4 files changed, 51 insertions(+), 4 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RefUpdateTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RefUpdateTest.java
index 655e54e..edccf37 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RefUpdateTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RefUpdateTest.java
@@ -82,6 +82,15 @@ public void testNoCacheObjectIdSubclass() throws IOException {
 		assertNotSame(newid, r.getObjectId());
 		assertSame(ObjectId.class, r.getObjectId().getClass());
 		assertEquals(newid.copy(), r.getObjectId());
+		List<org.spearce.jgit.lib.ReflogReader.Entry> reverseEntries1 = db.getReflogReader("refs/heads/abc").getReverseEntries();
+		org.spearce.jgit.lib.ReflogReader.Entry entry1 = reverseEntries1.get(0);
+		assertEquals(1, reverseEntries1.size());
+		assertEquals(ObjectId.zeroId(), entry1.getOldId());
+		assertEquals(r.getObjectId(), entry1.getNewId());
+		assertEquals(new PersonIdent(db).toString(),  entry1.getWho().toString());
+		assertEquals("", entry1.getComment());
+		List<org.spearce.jgit.lib.ReflogReader.Entry> reverseEntries2 = db.getReflogReader("HEAD").getReverseEntries();
+		assertEquals(0, reverseEntries2.size());
 	}
 
 	public void testNewNamespaceConflictWithLoosePrefixNameExists()
@@ -103,6 +112,8 @@ public void testNewNamespaceConflictWithLoosePrefixNameExists()
 		ru.setNewObjectId(newid2);
 		Result update2 = ru2.update();
 		assertEquals(Result.LOCK_FAILURE, update2);
+		assertEquals(1, db.getReflogReader("refs/heads/z").getReverseEntries().size());
+		assertEquals(0, db.getReflogReader("HEAD").getReverseEntries().size());
 	}
 
 	public void testNewNamespaceConflictWithPackedPrefixNameExists()
@@ -115,6 +126,8 @@ public void testNewNamespaceConflictWithPackedPrefixNameExists()
 		ru.setNewObjectId(newid);
 		Result update = ru.update();
 		assertEquals(Result.LOCK_FAILURE, update);
+		assertNull(db.getReflogReader("refs/heads/master/x"));
+		assertEquals(0, db.getReflogReader("HEAD").getReverseEntries().size());
 	}
 
 	public void testNewNamespaceConflictWithLoosePrefixOfExisting()
@@ -136,6 +149,9 @@ public void testNewNamespaceConflictWithLoosePrefixOfExisting()
 		ru.setNewObjectId(newid2);
 		Result update2 = ru2.update();
 		assertEquals(Result.LOCK_FAILURE, update2);
+		assertEquals(1, db.getReflogReader("refs/heads/z/a").getReverseEntries().size());
+		assertNull(db.getReflogReader("refs/heads/z"));
+		assertEquals(0, db.getReflogReader("HEAD").getReverseEntries().size());
 	}
 
 	public void testNewNamespaceConflictWithPackedPrefixOfExisting()
@@ -148,6 +164,8 @@ public void testNewNamespaceConflictWithPackedPrefixOfExisting()
 		ru.setNewObjectId(newid);
 		Result update = ru.update();
 		assertEquals(Result.LOCK_FAILURE, update);
+		assertNull(db.getReflogReader("refs/heads/prefix"));
+		assertEquals(0, db.getReflogReader("HEAD").getReverseEntries().size());
 	}
 
 	/**
@@ -167,6 +185,8 @@ public void testDeleteHEADreferencedRef() throws IOException {
 		Result delete = updateRef2.delete();
 		assertEquals(Result.REJECTED_CURRENT_BRANCH, delete);
 		assertEquals(pid, db.resolve("refs/heads/master"));
+		assertEquals(1,db.getReflogReader("refs/heads/master").getReverseEntries().size());
+		assertEquals(0,db.getReflogReader("HEAD").getReverseEntries().size());
 	}
 
 	public void testLooseDelete() throws IOException {
@@ -175,11 +195,14 @@ public void testLooseDelete() throws IOException {
 		ref.update(); // create loose ref
 		ref = updateRef(newRef); // refresh
 		delete(ref, Result.NO_CHANGE);
+		assertNull(db.getReflogReader("refs/heads/abc"));
 	}
 
 	public void testDeleteHead() throws IOException {
 		final RefUpdate ref = updateRef(Constants.HEAD);
 		delete(ref, Result.REJECTED_CURRENT_BRANCH, true, false);
+		assertEquals(0, db.getReflogReader("refs/heads/master").getReverseEntries().size());
+		assertEquals(0, db.getReflogReader("HEAD").getReverseEntries().size());
 	}
 
 	/**
@@ -498,6 +521,10 @@ public void testRenameBranchAlsoInPack() throws IOException {
 		assertNull(db.resolve("refs/heads/b"));
 		assertEquals("Branch: renamed b to new/name", db.getReflogReader(
 				"new/name").getLastEntry().getComment());
+		assertEquals(3, db.getReflogReader("refs/heads/new/name").getReverseEntries().size());
+		assertEquals("Branch: renamed b to new/name", db.getReflogReader("refs/heads/new/name").getReverseEntries().get(0).getComment());
+		assertEquals(0, db.getReflogReader("HEAD").getReverseEntries().size());
+		// make sure b's log file is gone too.
 		assertFalse(new File(db.getDirectory(), "logs/refs/heads/b").exists());
 
 		// Create new Repository instance, to reread caches and make sure our
@@ -640,6 +667,9 @@ public void testRenameRefNameColission1avoided() throws IOException {
 				.getReverseEntries().get(1).getComment());
 		assertEquals("Setup", db.getReflogReader("a/b").getReverseEntries()
 				.get(2).getComment());
+		// same thing was logged to HEAD
+		assertEquals("Branch: renamed a to a/b", db.getReflogReader("HEAD")
+				.getReverseEntries().get(0).getComment());
 	}
 
 	public void testRenameRefNameColission2avoided() throws IOException {
@@ -673,5 +703,7 @@ public void testRenameRefNameColission2avoided() throws IOException {
 				.getReverseEntries().get(1).getComment());
 		assertEquals("Setup", db.getReflogReader("prefix").getReverseEntries()
 				.get(2).getComment());
+		assertEquals("Branch: renamed prefix/a to prefix", db.getReflogReader(
+				"HEAD").getReverseEntries().get(0).getComment());
 	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefLogWriter.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefLogWriter.java
index 0864209..4aad809 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RefLogWriter.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RefLogWriter.java
@@ -56,13 +56,15 @@ static void append(final RefUpdate u, final String msg) throws IOException {
 		final PersonIdent ident = u.getRefLogIdent();
 
 		appendOneRecord(oldId, newId, ident, msg, db, u.getName());
+		if (!u.getName().equals(u.getOrigName()))
+			appendOneRecord(oldId, newId, ident, msg, db, u.getOrigName());
 	}
 
-	static void append(RefRename refRename, String msg) throws IOException {
+	static void append(RefRename refRename, String logName, String msg) throws IOException {
 		final ObjectId id = refRename.getObjectId();
 		final Repository db = refRename.getRepository();
 		final PersonIdent ident = refRename.getRefLogIdent();
-		appendOneRecord(id, id, ident, msg, db, refRename.getToName());
+		appendOneRecord(id, id, ident, msg, db, logName);
 	}
 
 	static void renameTo(final Repository db, final RefUpdate from,
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefRename.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefRename.java
index c89459b..0718620 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RefRename.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RefRename.java
@@ -136,9 +136,13 @@ public Result rename() throws IOException {
 			} else {
 				db.fireRefsMaybeChanged();
 			}
-			RefLogWriter.append(this, "Branch: renamed "
+			RefLogWriter.append(this, newToUpdate.getName(), "Branch: renamed "
 					+ db.shortenRefName(oldFromDelete.getName()) + " to "
 					+ db.shortenRefName(newToUpdate.getName()));
+			if (renameHEADtoo)
+				RefLogWriter.append(this, Constants.HEAD, "Branch: renamed "
+						+ db.shortenRefName(oldFromDelete.getName()) + " to "
+						+ db.shortenRefName(newToUpdate.getName()));
 			return renameResult = Result.RENAMED;
 		} catch (RuntimeException e) {
 			throw e;
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java
index f8ecc3c..69399ec 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java
@@ -182,13 +182,22 @@ public Repository getRepository() {
 	/**
 	 * Get the name of the ref this update will operate on.
 	 * 
-	 * @return name of this ref.
+	 * @return name of underlying ref.
 	 */
 	public String getName() {
 		return ref.getName();
 	}
 
 	/**
+	 * Get the requested name of the ref thit update will operate on
+	 *
+	 * @return original (requested) name of the underlying ref.
+	 */
+	public String getOrigName() {
+		return ref.getOrigName();
+	}
+
+	/**
 	 * Get the new value the ref will be (or was) updated to.
 	 * 
 	 * @return new value. Null if the caller has not configured it.
-- 
1.6.4.115.gc0eb0

From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 08/10] Add ref rename support to JGit
Date: Thu, 28 May 2009 00:08:55 +0200
Message-ID: <1243462137-24133-9-git-send-email-robin.rosenberg@dewire.com>
References: <20090520221651.GR30527@spearce.org>
 <1243462137-24133-1-git-send-email-robin.rosenberg@dewire.com>
 <1243462137-24133-2-git-send-email-robin.rosenberg@dewire.com>
 <1243462137-24133-3-git-send-email-robin.rosenberg@dewire.com>
 <1243462137-24133-4-git-send-email-robin.rosenberg@dewire.com>
 <1243462137-24133-5-git-send-email-robin.rosenberg@dewire.com>
 <1243462137-24133-6-git-send-email-robin.rosenberg@dewire.com>
 <1243462137-24133-7-git-send-email-robin.rosenberg@dewire.com>
 <1243462137-24133-8-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Thu May 28 00:10:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9RKO-0005qi-C7
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 00:10:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759039AbZE0WJs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 18:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758255AbZE0WJr
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 18:09:47 -0400
Received: from mail.dewire.com ([83.140.172.130]:25372 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758010AbZE0WJj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 18:09:39 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 397D9145B3DA;
	Thu, 28 May 2009 00:09:40 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id whh02RDcUEfr; Thu, 28 May 2009 00:09:36 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.10])
	by dewire.com (Postfix) with ESMTP id A3654145D135;
	Thu, 28 May 2009 00:09:00 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.dirty
In-Reply-To: <1243462137-24133-8-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120122>

Now refs can be renamed. The intent is that should be safe. Only the named
refs and associated logs are updated. Any symbolic refs referring to the renames
branches are unaffected, except HEAD, which is updated if the branch it refers
to is being renamed.

In order to perform operations like rename from a to a/b and vice verse, we
perform the rename similar to the way C git does it, i.e. one ref update at
a time using the same temporary intermediate names as the C version does.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../org/spearce/jgit/test/resources/packed-refs    |    1 +
 .../tst/org/spearce/jgit/lib/RefUpdateTest.java    |  293 ++++++++++++++++++++
 .../org/spearce/jgit/transport/TransportTest.java  |    2 +-
 .../src/org/spearce/jgit/lib/RefDatabase.java      |   34 +++
 .../src/org/spearce/jgit/lib/RefLogWriter.java     |   34 +++-
 .../src/org/spearce/jgit/lib/RefRename.java        |  163 +++++++++++
 .../src/org/spearce/jgit/lib/RefUpdate.java        |   62 +++-
 .../src/org/spearce/jgit/lib/Repository.java       |   16 +
 8 files changed, 588 insertions(+), 17 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/RefRename.java

diff --git a/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/packed-refs b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/packed-refs
index 38a70ec..a6a14f2 100644
--- a/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/packed-refs
+++ b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/packed-refs
@@ -6,6 +6,7 @@ f73b95671f326616d66b2afb3bdfcdbbce110b44 refs/heads/d
 d0114ab8ac326bab30e3a657a0397578c5a1af88 refs/heads/e
 47d3697c3747e8184e0dc479ccbd01e359023577 refs/heads/f
 175d5b80bd9768884d8fced02e9bd33488174396 refs/heads/g
+175d5b80bd9768884d8fced02e9bd33488174396 refs/heads/prefix/a
 49322bb17d3acc9146f98c97d078513228bbf3c0 refs/heads/master
 d86a2aada2f5e7ccf6f11880bfb9ab404e8a8864 refs/heads/pa
 6db9c2ebf75590eef973081736730a9ea169a0c4 refs/tags/A
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RefUpdateTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RefUpdateTest.java
index 84653c8..8c6ca0c 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RefUpdateTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RefUpdateTest.java
@@ -83,6 +83,68 @@ public void testNoCacheObjectIdSubclass() throws IOException {
 		assertEquals(newid.copy(), r.getObjectId());
 	}
 
+	public void testNewNamespaceConflictWithLoosePrefixNameExists() throws IOException {
+		final String newRef = "refs/heads/z";
+		final RefUpdate ru = updateRef(newRef);
+		final RevCommit newid = new RevCommit(ru.getNewObjectId()) {
+			// empty
+		};
+		ru.setNewObjectId(newid);
+		Result update = ru.update();
+		assertEquals(Result.NEW, update);
+		// end setup
+		final String newRef2 = "refs/heads/z/a";
+		final RefUpdate ru2 = updateRef(newRef2);
+		final RevCommit newid2 = new RevCommit(ru2.getNewObjectId()) {
+			// empty
+		};
+		ru.setNewObjectId(newid2);
+		Result update2 = ru2.update();
+		assertEquals(Result.LOCK_FAILURE, update2);
+	}
+
+	public void testNewNamespaceConflictWithPackedPrefixNameExists() throws IOException {
+		final String newRef = "refs/heads/master/x";
+		final RefUpdate ru = updateRef(newRef);
+		final RevCommit newid = new RevCommit(ru.getNewObjectId()) {
+			// empty
+		};
+		ru.setNewObjectId(newid);
+		Result update = ru.update();
+		assertEquals(Result.LOCK_FAILURE, update);
+	}
+
+	public void testNewNamespaceConflictWithLoosePrefixOfExisting() throws IOException {
+		final String newRef = "refs/heads/z/a";
+		final RefUpdate ru = updateRef(newRef);
+		final RevCommit newid = new RevCommit(ru.getNewObjectId()) {
+			// empty
+		};
+		ru.setNewObjectId(newid);
+		Result update = ru.update();
+		assertEquals(Result.NEW, update);
+		// end setup
+		final String newRef2 = "refs/heads/z";
+		final RefUpdate ru2 = updateRef(newRef2);
+		final RevCommit newid2 = new RevCommit(ru2.getNewObjectId()) {
+			// empty
+		};
+		ru.setNewObjectId(newid2);
+		Result update2 = ru2.update();
+		assertEquals(Result.LOCK_FAILURE, update2);
+	}
+
+	public void testNewNamespaceConflictWithPackedPrefixOfExisting() throws IOException {
+		final String newRef = "refs/heads/prefix";
+		final RefUpdate ru = updateRef(newRef);
+		final RevCommit newid = new RevCommit(ru.getNewObjectId()) {
+			// empty
+		};
+		ru.setNewObjectId(newid);
+		Result update = ru.update();
+		assertEquals(Result.LOCK_FAILURE, update);
+	}
+
 	/**
 	 * Delete a ref that is pointed to by HEAD
 	 *
@@ -279,4 +341,235 @@ public void testDeleteLoosePackedRejected() throws IOException {
 		assertEquals(oldpid, db.resolve("refs/heads/c"));
 	}
 
+	public void testRenameBranchNoPreviousLog() throws IOException {
+		assertFalse("precondition, no log on old branchg", new File(db
+				.getDirectory(), "logs/refs/heads/b").exists());
+		ObjectId rb = db.resolve("refs/heads/b");
+		ObjectId oldHead = db.resolve(Constants.HEAD);
+		assertFalse(rb.equals(oldHead)); // assumption for this test
+		RefRename renameRef = db.renameRef("refs/heads/b",
+				"refs/heads/new/name");
+		Result result = renameRef.rename();
+		assertEquals(Result.RENAMED, result);
+		assertEquals(rb, db.resolve("refs/heads/new/name"));
+		assertNull(db.resolve("refs/heads/b"));
+		assertTrue(new File(db.getDirectory(), "logs/refs/heads/new/name")
+				.exists());
+		assertFalse(new File(db.getDirectory(), "logs/refs/heads/b").exists());
+		assertEquals(oldHead, db.resolve(Constants.HEAD));
+	}
+
+	public void testRenameBranchHasPreviousLog() throws IOException {
+		ObjectId rb = db.resolve("refs/heads/b");
+		ObjectId oldHead = db.resolve(Constants.HEAD);
+		assertFalse("precondition for this test, branch b != HEAD", rb
+				.equals(oldHead));
+		RefLogWriter.writeReflog(db, rb, rb, "Just a message", "refs/heads/b");
+		assertTrue("no log on old branch", new File(db.getDirectory(),
+				"logs/refs/heads/b").exists());
+		RefRename renameRef = db.renameRef("refs/heads/b",
+				"refs/heads/new/name");
+		Result result = renameRef.rename();
+		assertEquals(Result.RENAMED, result);
+		assertEquals(rb, db.resolve("refs/heads/new/name"));
+		assertNull(db.resolve("refs/heads/b"));
+		assertTrue(new File(db.getDirectory(), "logs/refs/heads/new/name")
+				.exists());
+		assertFalse(new File(db.getDirectory(), "logs/refs/heads/b").exists());
+		assertEquals(oldHead, db.resolve(Constants.HEAD));
+		// TODO: test content of log file
+	}
+
+	public void testRenameCurrentBranch() throws IOException {
+		ObjectId rb = db.resolve("refs/heads/b");
+		db.writeSymref(Constants.HEAD, "refs/heads/b");
+		ObjectId oldHead = db.resolve(Constants.HEAD);
+		assertTrue("internal test condition, b == HEAD", rb.equals(oldHead));
+		RefLogWriter.writeReflog(db, rb, rb, "Just a message", "refs/heads/b");
+		assertTrue("no log on old branch", new File(db.getDirectory(),
+				"logs/refs/heads/b").exists());
+		RefRename renameRef = db.renameRef("refs/heads/b",
+				"refs/heads/new/name");
+		Result result = renameRef.rename();
+		assertEquals(Result.RENAMED, result);
+		assertEquals(rb, db.resolve("refs/heads/new/name"));
+		assertNull(db.resolve("refs/heads/b"));
+		assertTrue(new File(db.getDirectory(), "logs/refs/heads/new/name")
+				.exists());
+		assertFalse(new File(db.getDirectory(), "logs/refs/heads/b").exists());
+		assertEquals(rb, db.resolve(Constants.HEAD));
+		// TODO: test content of log file
+	}
+
+	public void testRenameBranchAlsoInPack() throws IOException {
+		ObjectId rb = db.resolve("refs/heads/b");
+		ObjectId rb2 = db.resolve("refs/heads/b~1");
+		assertEquals(Ref.Storage.PACKED, db.getRef("refs/heads/b").getStorage());
+		RefUpdate updateRef = db.updateRef("refs/heads/b");
+		updateRef.setNewObjectId(rb2);
+		updateRef.setForceUpdate(true);
+		Result update = updateRef.update();
+		assertEquals("internal check new ref is loose", Result.FORCED, update);
+		assertEquals(Ref.Storage.LOOSE_PACKED, db.getRef("refs/heads/b").getStorage());
+		RefLogWriter.writeReflog(db, rb, rb, "Just a message", "refs/heads/b");
+		assertTrue("no log on old branch", new File(db.getDirectory(),
+				"logs/refs/heads/b").exists());
+		RefRename renameRef = db.renameRef("refs/heads/b",
+				"refs/heads/new/name");
+		Result result = renameRef.rename();
+		assertEquals(Result.RENAMED, result);
+		assertEquals(rb2, db.resolve("refs/heads/new/name"));
+		assertNull(db.resolve("refs/heads/b"));
+		assertTrue(new File(db.getDirectory(), "logs/refs/heads/new/name")
+				.exists());
+		assertFalse(new File(db.getDirectory(), "logs/refs/heads/b").exists());
+
+		// Create new Repository instance, to reread caches and make sure our
+		// assumptions are persistent.
+		Repository ndb = new Repository(db.getDirectory());
+		assertEquals(rb2, ndb.resolve("refs/heads/new/name"));
+		assertNull(ndb.resolve("refs/heads/b"));
+	}
+
+	public void tryRenameWhenLocked(String toLock, String fromName,
+			String toName, String headPointsTo) throws IOException {
+		// setup
+		db.writeSymref(Constants.HEAD, headPointsTo);
+		ObjectId oldfromId = db.resolve(fromName);
+		ObjectId oldHeadId = db.resolve(Constants.HEAD);
+
+		RefLogWriter.writeReflog(db, oldfromId, oldfromId, "Just a message", fromName);
+		assertTrue("internal check, we have a log", new File(db.getDirectory(),
+				"logs/" + fromName).exists());
+
+		// "someone" has branch X locked
+		assertTrue(new LockFile(new File(db.getDirectory(), toLock)).lock());
+
+		// Now this is our test
+		RefRename renameRef = db.renameRef(fromName, toName);
+		Result result = renameRef.rename();
+		assertEquals(Result.LOCK_FAILURE, result);
+
+		// Check that the involved refs are sane despite the failure
+		assertExists(false, toName);
+		if (!toLock.equals(toName))
+			assertExists(false, toName + ".lock");
+		assertExists(true, toLock + ".lock");
+		if (!toLock.equals(fromName))
+			assertExists(false, "logs/" + fromName + ".lock");
+		assertExists(false, "logs/" + toName + ".lock");
+		assertEquals(oldHeadId, db.resolve(Constants.HEAD));
+		assertEquals(oldfromId, db.resolve(fromName));
+		assertNull(db.resolve(toName));
+	}
+
+	private void assertExists(boolean positive, String toName) {
+		assertEquals(toName + (positive ? " " : " does not ") + "exist",
+				positive, new File(db.getDirectory(), toName).exists());
+	}
+
+	public void testRenameBranchCannotLockAFileHEADisFromLockHEAD() throws IOException {
+		tryRenameWhenLocked("HEAD", "refs/heads/b", "refs/heads/new/name",
+				"refs/heads/b");
+	}
+	public void testRenameBranchCannotLockAFileHEADisFromLockFrom() throws IOException {
+		tryRenameWhenLocked("refs/heads/b", "refs/heads/b",
+				"refs/heads/new/name", "refs/heads/b");
+	}
+	public void testRenameBranchCannotLockAFileHEADisFromLockTo() throws IOException {
+		tryRenameWhenLocked("refs/heads/new/name", "refs/heads/b",
+				"refs/heads/new/name", "refs/heads/b");
+	}
+	public void testRenameBranchCannotLockAFileHEADisFromLockTmp() throws IOException {
+		tryRenameWhenLocked("RENAMED-REF", "refs/heads/b",
+				"refs/heads/new/name", "refs/heads/b");
+	}
+
+//	public void testRenameBranchCannotLockAFileHEADisToLockHead() throws IOException {
+//		an example following the rename failure pattern, but this one is ok!
+//		tryRenameWhenLocked("HEAD", "refs/heads/b", "refs/heads/new/name",
+//				"refs/heads/new/name");
+//	}
+
+	public void testRenameBranchCannotLockAFileHEADisToLockFrom() throws IOException {
+		tryRenameWhenLocked("refs/heads/b", "refs/heads/b",
+				"refs/heads/new/name", "refs/heads/new/name");
+	}
+
+	public void testRenameBranchCannotLockAFileHEADisToLockTo() throws IOException {
+		tryRenameWhenLocked("refs/heads/new/name", "refs/heads/b",
+				"refs/heads/new/name", "refs/heads/new/name");
+	}
+
+	public void testRenameBranchCannotLockAFileHEADisToLockTmp() throws IOException {
+		tryRenameWhenLocked("RENAMED-REF", "refs/heads/b",
+				"refs/heads/new/name", "refs/heads/new/name");
+	}
+
+//	public void testRenameBranchCannotLockAFileHEADisOtherLockHead() throws IOException {
+//		an example following the rename failure pattern, but this one is ok!
+//		tryRenameWhenLocked("HEAD", "refs/heads/b", "refs/heads/new/name",
+//				"refs/heads/a");
+//	}
+
+	public void testRenameBranchCannotLockAFileHEADisOtherLockFrom() throws IOException {
+		tryRenameWhenLocked("refs/heads/b", "refs/heads/b",
+				"refs/heads/new/name", "refs/heads/a");
+	}
+
+	public void testRenameBranchCannotLockAFileHEADisOtherLockTo() throws IOException {
+		tryRenameWhenLocked("refs/heads/new/name", "refs/heads/b",
+				"refs/heads/new/name", "refs/heads/a");
+	}
+
+	public void testRenameBranchCannotLockAFileHEADisOtherLockTmp() throws IOException {
+		tryRenameWhenLocked("RENAMED-REF", "refs/heads/b",
+				"refs/heads/new/name", "refs/heads/a");
+	}
+
+	public void testRenameRefNameColission1avoided() throws IOException {
+		// setup
+		ObjectId rb = db.resolve("refs/heads/b");
+		db.writeSymref(Constants.HEAD, "refs/heads/a");
+		RefUpdate updateRef = db.updateRef("refs/heads/a");
+		updateRef.setNewObjectId(rb);
+		assertEquals(Result.FAST_FORWARD, updateRef.update());
+		ObjectId oldHead = db.resolve(Constants.HEAD);
+		assertTrue(rb.equals(oldHead)); // assumption for this test
+		RefLogWriter.writeReflog(db, rb, rb, "Just a message", "refs/heads/a");
+		assertTrue("internal check, we have a log", new File(db.getDirectory(),
+				"logs/refs/heads/a").exists());
+
+		// Now this is our test
+		RefRename renameRef = db.renameRef("refs/heads/a",
+				"refs/heads/a/b");
+		Result result = renameRef.rename();
+		assertEquals(Result.RENAMED, result);
+		assertNull(db.resolve("refs/heads/a"));
+		assertEquals(rb, db.resolve("refs/heads/a/b"));
+	}
+
+	public void testRenameRefNameColission2avoided() throws IOException {
+		// setup
+		ObjectId rb = db.resolve("refs/heads/b");
+		db.writeSymref(Constants.HEAD, "refs/heads/prefix/a");
+		RefUpdate updateRef = db.updateRef("refs/heads/prefix/a");
+		updateRef.setNewObjectId(rb);
+		updateRef.setForceUpdate(true);
+		assertEquals(Result.FORCED, updateRef.update());
+		ObjectId oldHead = db.resolve(Constants.HEAD);
+		assertTrue(rb.equals(oldHead)); // assumption for this test
+		RefLogWriter.writeReflog(db, rb, rb, "Just a message", "refs/heads/prefix/a");
+		assertTrue("internal check, we have a log", new File(db.getDirectory(),
+				"logs/refs/heads/prefix/a").exists());
+
+		// Now this is our test
+		RefRename renameRef = db.renameRef("refs/heads/prefix/a",
+				"refs/heads/prefix");
+		Result result = renameRef.rename();
+		assertEquals(Result.RENAMED, result);
+
+		assertNull(db.resolve("refs/heads/prefix/a"));
+		assertEquals(rb, db.resolve("refs/heads/prefix"));
+	}
 }
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/transport/TransportTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/transport/TransportTest.java
index c6e3335..fcf3f5c 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/transport/TransportTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/transport/TransportTest.java
@@ -123,7 +123,7 @@ public void testFindRemoteRefUpdatesWildcardNoTracking() throws IOException {
 				.findRemoteRefUpdatesFor(Collections.nCopies(1, new RefSpec(
 						"+refs/heads/*:refs/heads/test/*")));
 
-		assertEquals(9, result.size());
+		assertEquals(10, result.size());
 		boolean foundA = false;
 		boolean foundB = false;
 		for (final RemoteRefUpdate rru : result) {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
index 869d012..babef0b 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
@@ -146,6 +146,26 @@ synchronized (this) {
 	}
 
 	/**
+	 * An set of update operations for renaming a ref
+	 *
+	 * @param fromRef Old ref name
+	 * @param toRef New ref name
+	 * @return a RefUpdate operation to rename a ref
+	 * @throws IOException
+	 */
+	RefRename newRename(String fromRef, String toRef) throws IOException {
+		refreshPackedRefs();
+		Ref f = readRefBasic(fromRef, 0);
+		Ref t = readRefBasic(toRef, 0);
+		if (t != null)
+			throw new IOException("Ref rename target exists: " + t.getName());
+		t = new Ref(Ref.Storage.NEW, toRef, null);
+		RefUpdate refUpdateFrom = new RefUpdate(this, f, fileForRef(f.getName()));
+		RefUpdate refUpdateTo = new RefUpdate(this, t, fileForRef(t.getName()));
+		return new RefRename(refUpdateTo, refUpdateFrom);
+	}
+
+	/**
 	 * Writes a symref (e.g. HEAD) to disk
 	 * 
 	 * @param name
@@ -158,11 +178,25 @@ void link(final String name, final String target) throws IOException {
 		final byte[] content = Constants.encode("ref: " + target + "\n");
 		lockAndWriteFile(fileForRef(name), content);
 		synchronized (this) {
+			looseSymRefs.remove(name);
 			setModified();
 		}
 		db.fireRefsMaybeChanged();
 	}
 
+	void uncacheSymRef(String name) {
+		synchronized(this) {
+			looseSymRefs.remove(name);
+			setModified();
+		}
+	}
+
+	void uncacheRef(String name) {
+		looseRefs.remove(name);
+		looseRefsMTime.remove(name);
+		packedRefs.remove(name);
+	}
+
 	private void setModified() {
 		lastRefModification = refModificationCounter++;
 	}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefLogWriter.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefLogWriter.java
index a077051..18cf2ed 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RefLogWriter.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RefLogWriter.java
@@ -44,7 +44,7 @@
 import java.io.IOException;
 
 /**
- * Utility class to add reflog entries
+ * Utility class to work with reflog files
  * 
  * @author Dave Watson
  */
@@ -58,6 +58,38 @@ static void append(final RefUpdate u, final String msg) throws IOException {
 		appendOneRecord(oldId, newId, ident, msg, db, u.getName());
 	}
 
+	static void append(RefRename refRename, String msg) throws IOException {
+		final ObjectId id = refRename.getObjectId();
+		final Repository db = refRename.getRepository();
+		final PersonIdent ident = refRename.getRefLogIdent();
+		appendOneRecord(id, id, ident, msg, db, refRename.getToName());
+	}
+
+	static void renameTo(final Repository db, final RefUpdate from,
+			final RefUpdate to) throws IOException {
+		final File logdir = new File(db.getDirectory(), Constants.LOGS);
+		final File reflogFrom = new File(logdir, from.getName());
+		if (!reflogFrom.exists())
+			return;
+		final File reflogTo = new File(logdir, to.getName());
+		final File reflogToDir = reflogTo.getParentFile();
+		File tmp = new File(logdir,"tmp-renamed-log");
+		tmp.delete(); // if any exists
+		if (!reflogFrom.renameTo(tmp)) {
+			throw new IOException("Cannot rename " + reflogFrom + " to (" + tmp
+					+ ")" + reflogTo);
+		}
+		RefUpdate.deleteEmptyDir(reflogFrom, RefUpdate.count(from.getName(),
+				'/'));
+		if (!reflogToDir.exists() && !reflogToDir.mkdirs()) {
+			throw new IOException("Cannot create directory " + reflogToDir);
+		}
+		if (!tmp.renameTo(reflogTo)) {
+			throw new IOException("Cannot rename (" + tmp + ")" + reflogFrom
+					+ " to " + reflogTo);
+		}
+	}
+
 	private static void appendOneRecord(final ObjectId oldId,
 			final ObjectId newId, PersonIdent ident, final String msg,
 			final Repository db, final String refName) throws IOException {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefRename.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefRename.java
new file mode 100644
index 0000000..589d752
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RefRename.java
@@ -0,0 +1,163 @@
+/*
+ * Copyright (C) 2009, Robin Rosenberg
+ *
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or
+ * without modification, are permitted provided that the following
+ * conditions are met:
+ *
+ * - Redistributions of source code must retain the above copyright
+ *   notice, this list of conditions and the following disclaimer.
+ *
+ * - Redistributions in binary form must reproduce the above
+ *   copyright notice, this list of conditions and the following
+ *   disclaimer in the documentation and/or other materials provided
+ *   with the distribution.
+ *
+ * - Neither the name of the Git Development Community nor the
+ *   names of its contributors may be used to endorse or promote
+ *   products derived from this software without specific prior
+ *   written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
+ * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
+ * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+package org.spearce.jgit.lib;
+
+import java.io.IOException;
+
+import org.spearce.jgit.lib.RefUpdate.Result;
+
+/**
+ * A RefUpdate combination for renaming a ref
+ */
+public class RefRename {
+	private RefUpdate newToUpdate;
+
+	private RefUpdate oldFromDelete;
+
+	private Result renameResult = Result.NOT_ATTEMPTED;
+
+	RefRename(final RefUpdate toUpdate, final RefUpdate fromUpdate) {
+		newToUpdate = toUpdate;
+		oldFromDelete = fromUpdate;
+	}
+
+	/**
+	 * @return result of rename operation
+	 */
+	public Result getResult() {
+		return renameResult;
+	}
+
+	/**
+	 * @return the result of the new ref update
+	 * @throws IOException
+	 */
+	public Result rename() throws IOException {
+		Ref oldRef = oldFromDelete.db.readRef(Constants.HEAD);
+		boolean renameHEADtoo = oldRef != null
+				&& oldRef.getName().equals(oldFromDelete.getName());
+		try {
+			Repository db = oldFromDelete.getRepository();
+			RefLogWriter.renameTo(db, oldFromDelete,
+					newToUpdate);
+			newToUpdate.setRefLogMessage(null, false);
+			RefUpdate tmpUpdateRef = oldFromDelete.db.getRepository().updateRef(
+					"RENAMED-REF");
+			if (renameHEADtoo) {
+				try {
+					oldFromDelete.db.link(Constants.HEAD, "RENAMED-REF");
+				} catch (IOException e) {
+					RefLogWriter.renameTo(db,
+							newToUpdate, oldFromDelete);
+					return renameResult = Result.LOCK_FAILURE;
+				}
+			}
+			tmpUpdateRef.setNewObjectId(oldFromDelete.getOldObjectId());
+			tmpUpdateRef.setForceUpdate(true);
+			Result update = tmpUpdateRef.update();
+			if (update != Result.FORCED && update != Result.NEW && update != Result.NO_CHANGE) {
+				RefLogWriter.renameTo(db,
+						newToUpdate, oldFromDelete);
+				if (renameHEADtoo) {
+					oldFromDelete.db.link(Constants.HEAD, oldFromDelete.getName());
+				}
+				return renameResult = update;
+			}
+
+			oldFromDelete.setForceUpdate(true);
+			Result delete = oldFromDelete.delete();
+			if (delete != Result.FORCED) {
+				if (db.getRef(
+						oldFromDelete.getName()) != null) {
+					RefLogWriter.renameTo(db,
+							newToUpdate, oldFromDelete);
+					if (renameHEADtoo) {
+						oldFromDelete.db.link(Constants.HEAD, oldFromDelete
+								.getName());
+					}
+				}
+				return renameResult = delete;
+			}
+
+			newToUpdate.setNewObjectId(tmpUpdateRef.getNewObjectId());
+			Result updateResult = newToUpdate.update();
+			if (updateResult != Result.NEW) {
+				RefLogWriter.renameTo(db,
+						newToUpdate, oldFromDelete);
+				if (renameHEADtoo) {
+					oldFromDelete.db.link(Constants.HEAD, oldFromDelete.getName());
+				}
+				oldFromDelete.setNewObjectId(oldFromDelete.getOldObjectId());
+				Result undelete = oldFromDelete.update();
+				if (undelete != Result.NEW)
+					return renameResult = Result.IO_FAILURE;
+				return renameResult = Result.LOCK_FAILURE;
+			}
+
+			if (renameHEADtoo) {
+				oldFromDelete.db.link(Constants.HEAD, newToUpdate.getName());
+			} else {
+				oldFromDelete.db.getRepository().fireRefsMaybeChanged();
+			}
+			RefLogWriter.append(this, "jgit branch: renamed "
+					+ db.shortenRefName(oldFromDelete.getName()) + " to "
+					+ db.shortenRefName(newToUpdate.getName()));
+			return renameResult = Result.RENAMED;
+		} catch (RuntimeException e) {
+			throw e;
+		} catch (IOException e) {
+			System.err.println(e);
+			return renameResult = Result.IO_FAILURE;
+		}
+	}
+
+	ObjectId getObjectId() {
+		return oldFromDelete.getOldObjectId();
+	}
+
+	Repository getRepository() {
+		return oldFromDelete.getRepository();
+	}
+
+	PersonIdent getRefLogIdent() {
+		return newToUpdate.getRefLogIdent();
+	}
+
+	String getToName() {
+		return newToUpdate.getName();
+	}
+}
\ No newline at end of file
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java
index 79d9f2d..a2041de 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java
@@ -125,14 +125,20 @@
 		 * This kind of error doesn't include {@link #LOCK_FAILURE}, which is a
 		 * different case.
 		 */
-		IO_FAILURE
+		IO_FAILURE,
+
+		/**
+		 * The ref was renamed from another name
+		 * <p>
+		 */
+		RENAMED
 	}
 
 	/** Repository the ref is stored in. */
-	private final RefDatabase db;
+	final RefDatabase db;
 
 	/** Location of the loose file holding the value of this ref. */
-	private final File looseFile;
+	final File looseFile;
 
 	/** New value the caller wants this ref to have. */
 	private ObjectId newValue;
@@ -156,7 +162,7 @@
 	private ObjectId expValue;
 
 	/** Result of the update operation. */
-	private Result result = Result.NOT_ATTEMPTED;
+	Result result = Result.NOT_ATTEMPTED;
 
 	private final Ref ref;
 
@@ -418,6 +424,15 @@ private Result updateImpl(final RevWalk walk, final Store store)
 		RevObject newObj;
 		RevObject oldObj;
 
+		int lastSlash = getName().lastIndexOf('/');
+		if (lastSlash > 0)
+			if (db.getRepository().getRef(getName().substring(0, lastSlash)) != null)
+				return Result.LOCK_FAILURE;
+		String rName = getName() + "/";
+		for (Ref r : db.getAllRefs().values()) {
+			if (r.getName().startsWith(rName))
+				return Result.LOCK_FAILURE;
+		}
 		lock = new LockFile(looseFile);
 		if (!lock.lock())
 			return Result.LOCK_FAILURE;
@@ -478,6 +493,9 @@ else if (status == Result.FAST_FORWARD)
 				msg += ": fast forward";
 			else if (status == Result.NEW)
 				msg += ": created";
+			else if (status == Result.RENAMED) {
+				// don't amend the message here
+			}
 		}
 		if (msg != null)
 			RefLogWriter.append(this, msg);
@@ -496,7 +514,7 @@ abstract Result store(final LockFile lock, final Result status)
 				throws IOException;
 	}
 
-	private class UpdateStore extends Store {
+	class UpdateStore extends Store {
 
 		@Override
 		Result store(final LockFile lock, final Result status)
@@ -505,7 +523,7 @@ Result store(final LockFile lock, final Result status)
 		}
 	}
 
-	private class DeleteStore extends Store {
+	class DeleteStore extends Store {
 
 		@Override
 		Result store(LockFile lock, Result status) throws IOException {
@@ -526,28 +544,42 @@ Result store(LockFile lock, Result status) throws IOException {
 			lock.unlock();
 			if (storage.isLoose())
 				deleteFileAndEmptyDir(looseFile, levels);
+			db.uncacheRef(ref.getName());
 			return status;
 		}
 
 		private void deleteFileAndEmptyDir(final File file, final int depth)
 				throws IOException {
-			if (file.exists()) {
+			if (file.isFile()) {
 				if (!file.delete())
 					throw new IOException("File cannot be deleted: " + file);
-				deleteEmptyDir(file.getParentFile(), depth);
+				File dir = file.getParentFile();
+				for  (int i = 0; i < depth; ++i) {
+					if (!dir.delete())
+						break; // ignore problem here
+					dir = dir.getParentFile();
+				}
 			}
 		}
+	}
 
-		private void deleteEmptyDir(File dir, int depth) {
-			for (; depth > 0 && dir != null; depth--) {
-				if (!dir.delete())
-					break;
-				dir = dir.getParentFile();
-			}
+	UpdateStore newUpdateStore() {
+		return new UpdateStore();
+	}
+
+	DeleteStore newDeleteStore() {
+		return new DeleteStore();
+	}
+
+	static void deleteEmptyDir(File dir, int depth) {
+		for (; depth > 0 && dir != null; depth--) {
+			if (dir.exists() && !dir.delete())
+				break;
+			dir = dir.getParentFile();
 		}
 	}
 
-	private static int count(final String s, final char c) {
+	static int count(final String s, final char c) {
 		int count = 0;
 		for (int p = s.indexOf(c); p >= 0; p = s.indexOf(c, p + 1)) {
 			count++;
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index 55dae27..06e0c7b 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -468,6 +468,22 @@ public RefUpdate updateRef(final String ref) throws IOException {
 	}
 
 	/**
+	 * Create a command to rename a ref in this repository
+	 *
+	 * @param fromRef
+	 *            name of ref to rename from
+	 * @param toRef
+	 *            name of ref to rename to
+	 * @return an update command that knows how to rename a branch to another.
+	 * @throws IOException
+	 *             the rename could not be performed.
+	 *
+	 */
+	public RefRename renameRef(final String fromRef, final String toRef) throws IOException {
+		return refs.newRename(fromRef, toRef);
+	}
+
+	/**
 	 * Parse a git revision string and return an object id.
 	 *
 	 * Currently supported is combinations of these.
-- 
1.6.3.dirty

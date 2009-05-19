From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 2/6] Add ref rename support to JGit
Date: Wed, 20 May 2009 01:13:14 +0200
Message-ID: <1242774798-23639-3-git-send-email-robin.rosenberg@dewire.com>
References: <20090507155117.GS30527@spearce.org>
 <1242774798-23639-1-git-send-email-robin.rosenberg@dewire.com>
 <1242774798-23639-2-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed May 20 01:14:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6YVk-0003TA-31
	for gcvg-git-2@gmane.org; Wed, 20 May 2009 01:14:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755093AbZESXNk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2009 19:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754183AbZESXNh
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 19:13:37 -0400
Received: from mail.dewire.com ([83.140.172.130]:25880 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755251AbZESXN1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2009 19:13:27 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 2B0CD800277;
	Wed, 20 May 2009 01:13:24 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ckcd6b0o+mN0; Wed, 20 May 2009 01:13:23 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.11])
	by dewire.com (Postfix) with ESMTP id 0E454145D123;
	Wed, 20 May 2009 01:13:22 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.dirty
In-Reply-To: <1242774798-23639-2-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119576>

Now refs can be renamed. The intent is that should be safe. Only the named
refs and associated logs are updated. Any symbolic refs referring to the renames
branches are unaffected, except HEAD.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../tst/org/spearce/jgit/lib/RefUpdateTest.java    |  152 ++++++++++++++++++++
 .../src/org/spearce/jgit/lib/RefDatabase.java      |   28 ++++
 .../src/org/spearce/jgit/lib/RefLogWriter.java     |   20 +++-
 .../src/org/spearce/jgit/lib/RefRename.java        |  101 +++++++++++++
 .../src/org/spearce/jgit/lib/RefUpdate.java        |   29 +++-
 .../src/org/spearce/jgit/lib/Repository.java       |   16 ++
 6 files changed, 339 insertions(+), 7 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/RefRename.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RefUpdateTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RefUpdateTest.java
index 55d7441..cd66eb1 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RefUpdateTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RefUpdateTest.java
@@ -155,4 +155,156 @@ public void testRefKeySameAsOrigName() {
 
 		}
 	}
+
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
+	public void testRenameBranchCannotLockFirstBranch() throws IOException {
+		// "someone" has branch b locked
+		assertTrue(new LockFile(new File(db.getDirectory(), "refs/heads/b"))
+				.lock());
+
+		// setup
+		ObjectId rb = db.resolve("refs/heads/b");
+		db.writeSymref(Constants.HEAD, "refs/heads/b");
+		ObjectId oldHead = db.resolve(Constants.HEAD);
+		assertTrue(rb.equals(oldHead)); // assumption for this test
+		RefLogWriter.writeReflog(db, rb, rb, "Just a message", "refs/heads/b");
+		assertTrue("internal check, we have a log", new File(db.getDirectory(),
+				"logs/refs/heads/b").exists());
+
+		// Now this is our test
+		RefRename renameRef = db.renameRef("refs/heads/b",
+				"refs/heads/new/name");
+		Result result = renameRef.rename();
+		assertEquals(Result.LOCK_FAILURE, result);
+
+		// Check that the involved refs are sane despite the failure
+		assertFalse(new File(db.getDirectory(), "refs/heads/new/name").exists());
+		assertFalse(new File(db.getDirectory(), "refs/heads/new/name.lock")
+				.exists());
+		assertFalse(new File(db.getDirectory(), "logs/refs/heads/b/lock")
+				.exists());
+		assertFalse(new File(db.getDirectory(), "logs/refs/heads/new/name.lock")
+				.exists());
+		assertEquals(rb, db.resolve(Constants.HEAD));
+	}
+
+	public void testRenameBranchCannotLockHEAD() throws IOException {
+		// setup
+		ObjectId rb = db.resolve("refs/heads/b");
+		db.writeSymref(Constants.HEAD, "refs/heads/b");
+
+		// "someone" has branch b locked
+		assertTrue(new LockFile(new File(db.getDirectory(), "HEAD")).lock());
+
+		ObjectId oldHead = db.resolve(Constants.HEAD);
+		assertTrue("internal test branch b == HEAD", rb.equals(oldHead));
+		RefLogWriter.writeReflog(db, rb, rb, "Just a message", "refs/heads/b");
+		assertTrue("no log on old branch", new File(db.getDirectory(),
+				"logs/refs/heads/b").exists());
+
+		// Now this is our test
+		RefRename renameRef = db.renameRef("refs/heads/b",
+				"refs/heads/new/name");
+		Result result = renameRef.rename();
+		assertEquals(Result.LOCK_FAILURE, result);
+
+		// Check that the involved refs are sane despite the failure
+		assertFalse(new File(db.getDirectory(), "refs/heads/new/name").exists());
+		assertFalse(new File(db.getDirectory(), "refs/heads/new/name.lock")
+				.exists());
+		assertFalse(new File(db.getDirectory(), "logs/refs/heads/b/lock")
+				.exists());
+		assertFalse(new File(db.getDirectory(), "logs/refs/heads/new/name.lock")
+				.exists());
+		assertEquals(rb, db.resolve(Constants.HEAD));
+	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
index 573fcac..9c0d114 100644
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
@@ -158,11 +178,19 @@ void link(final String name, final String target) throws IOException {
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
 	private void setModified() {
 		lastRefModification = refModificationCounter++;
 	}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefLogWriter.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefLogWriter.java
index a077051..2efa12d 100644
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
@@ -58,6 +58,24 @@ static void append(final RefUpdate u, final String msg) throws IOException {
 		appendOneRecord(oldId, newId, ident, msg, db, u.getName());
 	}
 
+	static void renameTo(final Repository db, final RefUpdate from,
+			final RefUpdate to) throws IOException {
+		final File logdir = new File(db.getDirectory(), Constants.LOGS);
+		final File reflogFrom = new File(logdir, from.getName());
+		if (!reflogFrom.exists())
+			return;
+		final File reflogTo = new File(logdir, to.getName());
+		final File refdirTo = reflogTo.getParentFile();
+		if (!refdirTo.exists() && !refdirTo.mkdirs()) {
+			throw new IOException("Cannot create directory " + refdirTo);
+		}
+		if (!reflogFrom.renameTo(reflogTo)) {
+			reflogTo.delete(); // try
+			throw new IOException("Cannot rename " + reflogFrom + " to "
+					+ reflogTo);
+		}
+	}
+
 	private static void appendOneRecord(final ObjectId oldId,
 			final ObjectId newId, PersonIdent ident, final String msg,
 			final Repository db, final String refName) throws IOException {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefRename.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefRename.java
new file mode 100644
index 0000000..4ea9cfa
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RefRename.java
@@ -0,0 +1,101 @@
+package org.spearce.jgit.lib;
+
+import java.io.File;
+import java.io.IOException;
+import java.util.ArrayList;
+import java.util.List;
+
+import org.spearce.jgit.lib.RefUpdate.DeleteStore;
+import org.spearce.jgit.lib.RefUpdate.Result;
+import org.spearce.jgit.lib.RefUpdate.UpdateStore;
+
+/**
+ * A RefUpdate combination for renaming a ref
+ */
+public class RefRename {
+	private RefUpdate newToUpdate;
+
+	private RefUpdate oldFromDelete;
+
+	private Result renameResult;
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
+		List<LockFile> lockFiles = new ArrayList<LockFile>();
+		LockFile lockFileFrom = new LockFile(oldFromDelete.looseFile);
+		LockFile lockFileTo = new LockFile(newToUpdate.looseFile);
+		LockFile lockFileHEAD = new LockFile(new File(oldFromDelete.db
+				.getRepository().getDirectory(), Constants.HEAD));
+		lockFiles.add(lockFileTo);
+		lockFiles.add(lockFileFrom);
+		lockFiles.add(lockFileHEAD);
+		try {
+			for (LockFile l : lockFiles) {
+				if (!l.lock()) {
+					unlock(lockFiles);
+					return Result.LOCK_FAILURE;
+				}
+			}
+		} catch (RuntimeException e) {
+			unlock(lockFiles);
+			throw e;
+		} catch (IOException e) {
+			unlock(lockFiles);
+			throw e;
+		}
+		boolean renameHEADtoo = oldFromDelete.db.readRef(Constants.HEAD)
+				.getName().equals(oldFromDelete.getName());
+		try {
+			UpdateStore toStore = newToUpdate.newUpdateStore();
+			RefLogWriter.renameTo(oldFromDelete.getRepository(), oldFromDelete,
+					newToUpdate);
+			newToUpdate.setNewObjectId(oldFromDelete.getOldObjectId());
+			newToUpdate.setExpectedOldObjectId(oldFromDelete.getOldObjectId());
+			newToUpdate.setRefLogMessage("jgit branch: renamed "
+					+ oldFromDelete.getName() + " to "
+					+ oldFromDelete.getName(), false);
+			newToUpdate.result = toStore.store(lockFileTo, Result.RENAMED);
+			DeleteStore fromStore = oldFromDelete.newDeleteStore();
+			Result store = fromStore.store(lockFileFrom, Result.RENAMED);
+			if (store == Result.RENAMED && renameHEADtoo) {
+				final byte[] content = Constants.encode("ref: "
+						+ newToUpdate.getName() + "\n");
+				lockFileHEAD.write(content);
+				oldFromDelete.db.uncacheSymRef(Constants.HEAD);
+				if (!lockFileHEAD.commit())
+					throw new IOException("Failed to commit HEAD during rename");
+			}
+			oldFromDelete.db.getRepository().fireRefsMaybeChanged();
+			return store;
+		} catch (RuntimeException e) {
+			unlock(lockFiles);
+			throw e;
+		} catch (IOException e) {
+			System.err.println(e);
+			return Result.IO_FAILURE;
+		} finally {
+			unlock(lockFiles);
+		}
+	}
+
+	private void unlock(List<LockFile> lockFiles) {
+		for (LockFile lockFile : lockFiles) {
+			lockFile.unlock();
+		}
+	}
+}
\ No newline at end of file
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java
index a9ab73b..7a1074d 100644
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
 
@@ -478,6 +484,9 @@ else if (status == Result.FAST_FORWARD)
 				msg += ": fast forward";
 			else if (status == Result.NEW)
 				msg += ": created";
+			else if (status == Result.RENAMED) {
+				// don't amend the message here
+			}
 		}
 		RefLogWriter.append(this, msg);
 		if (!lock.commit())
@@ -495,7 +504,7 @@ abstract Result store(final LockFile lock, final Result status)
 				throws IOException;
 	}
 
-	private class UpdateStore extends Store {
+	class UpdateStore extends Store {
 
 		@Override
 		Result store(final LockFile lock, final Result status)
@@ -504,7 +513,7 @@ Result store(final LockFile lock, final Result status)
 		}
 	}
 
-	private class DeleteStore extends Store {
+	class DeleteStore extends Store {
 
 		@Override
 		Result store(LockFile lock, Result status) throws IOException {
@@ -553,4 +562,12 @@ private static int count(final String s, final char c) {
 		}
 		return count;
 	}
+
+	UpdateStore newUpdateStore() {
+		return new UpdateStore();
+	}
+
+	DeleteStore newDeleteStore() {
+		return new DeleteStore();
+	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index 9bed1b7..08539fa 100644
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

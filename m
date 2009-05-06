From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 1/3] Add ref rename support to JGit
Date: Thu,  7 May 2009 01:32:59 +0200
Message-ID: <1241652781-16873-2-git-send-email-robin.rosenberg@dewire.com>
References: <1241652781-16873-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Thu May 07 01:33:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1qcM-000346-5d
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 01:33:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753358AbZEFXdO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2009 19:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753164AbZEFXdL
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 19:33:11 -0400
Received: from mail.dewire.com ([83.140.172.130]:27518 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752775AbZEFXdI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2009 19:33:08 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 1B2DF14A8B5A;
	Thu,  7 May 2009 01:33:07 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DKQDxVSS5cf3; Thu,  7 May 2009 01:33:03 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.7])
	by dewire.com (Postfix) with ESMTP id F18FF14A8B5C;
	Thu,  7 May 2009 01:33:02 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.rc2.1.g868b6
In-Reply-To: <1241652781-16873-1-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118412>

Now refs can be renamed. The intent is that should be safe. Only the named
refs and associated logs are updated. Any symbolic refs referring to the renames
branches are unaffected, except HEAD.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../tst/org/spearce/jgit/lib/RefUpdateTest.java    |  109 +++++++++++++++++++
 .../src/org/spearce/jgit/lib/RefDatabase.java      |   32 +++++-
 .../src/org/spearce/jgit/lib/RefLogWriter.java     |   21 ++++-
 .../src/org/spearce/jgit/lib/RefUpdate.java        |  112 +++++++++++++++++++-
 .../src/org/spearce/jgit/lib/Repository.java       |   33 ++++++
 5 files changed, 303 insertions(+), 4 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RefUpdateTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RefUpdateTest.java
index 55d7441..b02773d 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RefUpdateTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RefUpdateTest.java
@@ -42,6 +42,7 @@
 import java.util.Map;
 import java.util.Map.Entry;
 
+import org.spearce.jgit.lib.RefUpdate.RenameRefUpdates;
 import org.spearce.jgit.lib.RefUpdate.Result;
 import org.spearce.jgit.revwalk.RevCommit;
 
@@ -155,4 +156,112 @@ public void testRefKeySameAsOrigName() {
 
 		}
 	}
+
+	public void testRenameBranchNoPreviousLog() throws IOException {
+		assertFalse(new File(db.getDirectory(),"logs/refs/heads/b").exists()); // no log on old branch
+		ObjectId rb = db.resolve("refs/heads/b");
+		ObjectId oldHead = db.resolve(Constants.HEAD);
+		assertFalse(rb.equals(oldHead)); // assumption for this test
+		RenameRefUpdates renameRef = db.renameRef("refs/heads/b",
+				"refs/heads/new/name");
+		Result result = renameRef.rename();
+		assertEquals(Result.RENAMED, result);
+		assertEquals(rb, db.resolve("refs/heads/new/name"));
+		assertNull(db.resolve("refs/heads/b"));
+		assertTrue(new File(db.getDirectory(),"logs/refs/heads/new/name").exists());
+		assertFalse(new File(db.getDirectory(),"logs/refs/heads/b").exists());
+		assertEquals(oldHead, db.resolve(Constants.HEAD));
+		// TODO: test coprivate void assertNotEquals(ObjectId rb, ObjectId oldHead) {
+		// TODO Auto-generated method stub
+	}
+
+	public void testRenameBranchHasPreviousLog() throws IOException {
+		ObjectId rb = db.resolve("refs/heads/b");
+		ObjectId oldHead = db.resolve(Constants.HEAD);
+		assertFalse(rb.equals(oldHead)); // assumption for this test
+		RefLogWriter.writeReflog(db, rb, rb, "Just a message", "refs/heads/b");
+		assertTrue(new File(db.getDirectory(),"logs/refs/heads/b").exists()); // no log on old branch
+		RenameRefUpdates renameRef = db.renameRef("refs/heads/b",
+				"refs/heads/new/name");
+		Result result = renameRef.rename();
+		assertEquals(Result.RENAMED, result);
+		assertEquals(rb, db.resolve("refs/heads/new/name"));
+		assertNull(db.resolve("refs/heads/b"));
+		assertTrue(new File(db.getDirectory(),"logs/refs/heads/new/name").exists());
+		assertFalse(new File(db.getDirectory(),"logs/refs/heads/b").exists());
+		assertEquals(oldHead, db.resolve(Constants.HEAD));
+		// TODO: test content of log file
+	}
+
+	public void testRenameCurrentBranch() throws IOException {
+		ObjectId rb = db.resolve("refs/heads/b");
+		db.link(Constants.HEAD, "refs/heads/b");
+		ObjectId oldHead = db.resolve(Constants.HEAD);
+		assertTrue(rb.equals(oldHead)); // assumption for this test
+		RefLogWriter.writeReflog(db, rb, rb, "Just a message", "refs/heads/b");
+		assertTrue(new File(db.getDirectory(),"logs/refs/heads/b").exists()); // no log on old branch
+		RenameRefUpdates renameRef = db.renameRef("refs/heads/b",
+				"refs/heads/new/name");
+		Result result = renameRef.rename();
+		assertEquals(Result.RENAMED, result);
+		assertEquals(rb, db.resolve("refs/heads/new/name"));
+		assertNull(db.resolve("refs/heads/b"));
+		assertTrue(new File(db.getDirectory(),"logs/refs/heads/new/name").exists());
+		assertFalse(new File(db.getDirectory(),"logs/refs/heads/b").exists());
+		assertEquals(rb, db.resolve(Constants.HEAD));
+		// TODO: test content of log file
+	}
+
+	public void testRenameBranchCannotLockFirstBranch() throws IOException {
+		// "someone" has branch b locked
+		assertTrue(new LockFile(new File(db.getDirectory(), "refs/heads/b")).lock());
+
+		// setup
+		ObjectId rb = db.resolve("refs/heads/b");
+		db.link(Constants.HEAD, "refs/heads/b");
+		ObjectId oldHead = db.resolve(Constants.HEAD);
+		assertTrue(rb.equals(oldHead)); // assumption for this test
+		RefLogWriter.writeReflog(db, rb, rb, "Just a message", "refs/heads/b");
+		assertTrue(new File(db.getDirectory(),"logs/refs/heads/b").exists()); // no log on old branch
+
+		// Now this is our test
+		RenameRefUpdates renameRef = db.renameRef("refs/heads/b",
+				"refs/heads/new/name");
+		Result result = renameRef.rename();
+		assertEquals(Result.LOCK_FAILURE, result);
+
+		// Check that the involved refs are sane despite the failure
+		assertFalse(new File(db.getDirectory(), "refs/heads/new/name").exists());
+		assertFalse(new File(db.getDirectory(), "refs/heads/new/name.lock").exists());
+		assertFalse(new File(db.getDirectory(), "logs/refs/heads/b/lock").exists());
+		assertFalse(new File(db.getDirectory(), "logs/refs/heads/new/name.lock").exists());
+		assertEquals(rb, db.resolve(Constants.HEAD));
+	}
+
+	public void testRenameBranchCannotLockHEAD() throws IOException {
+		// setup
+		ObjectId rb = db.resolve("refs/heads/b");
+		db.link(Constants.HEAD, "refs/heads/b");
+
+		// "someone" has branch b locked
+		assertTrue(new LockFile(new File(db.getDirectory(), "HEAD")).lock());
+
+		ObjectId oldHead = db.resolve(Constants.HEAD);
+		assertTrue(rb.equals(oldHead)); // assumption for this test
+		RefLogWriter.writeReflog(db, rb, rb, "Just a message", "refs/heads/b");
+		assertTrue(new File(db.getDirectory(),"logs/refs/heads/b").exists()); // no log on old branch
+
+		// Now this is our test
+		RenameRefUpdates renameRef = db.renameRef("refs/heads/b",
+				"refs/heads/new/name");
+		Result result = renameRef.rename();
+		assertEquals(Result.LOCK_FAILURE, result);
+
+		// Check that the involved refs are sane despite the failure
+		assertFalse(new File(db.getDirectory(), "refs/heads/new/name").exists());
+		assertFalse(new File(db.getDirectory(), "refs/heads/new/name.lock").exists());
+		assertFalse(new File(db.getDirectory(), "logs/refs/heads/b/lock").exists());
+		assertFalse(new File(db.getDirectory(), "logs/refs/heads/new/name.lock").exists());
+		assertEquals(rb, db.resolve(Constants.HEAD));
+	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
index 87f26bf..a73467a 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
@@ -52,6 +52,7 @@
 
 import org.spearce.jgit.errors.ObjectWritingException;
 import org.spearce.jgit.lib.Ref.Storage;
+import org.spearce.jgit.lib.RefUpdate.RenameRefUpdates;
 import org.spearce.jgit.util.FS;
 import org.spearce.jgit.util.NB;
 
@@ -148,6 +149,25 @@ synchronized (this) {
 	}
 
 	/**
+	 * An set of update operations for renaming a ref
+	 *
+	 * @param fromRef Old ref name
+	 * @param toRef New ref name
+	 * @return a RefUpdate operation to rename a ref
+	 * @throws IOException
+	 */
+	public RenameRefUpdates newRename(String fromRef, String toRef) throws IOException {
+		refreshPackedRefs();
+		Ref f = readRefBasic(fromRef, 0);
+		Ref t = readRefBasic(toRef, 0);
+		if (t != null)
+			throw new IOException("Ref rename target exists: " + t.getName());
+		RefUpdate refUpdateFrom = new RefUpdate(this, f, fileForRef(f.getName()));
+		RefUpdate refUpdateTo = db.updateRef(toRef);
+		return new RenameRefUpdates(refUpdateTo, refUpdateFrom, null);
+	}
+
+	/**
 	 * Writes a symref (e.g. HEAD) to disk
 	 * 
 	 * @param name
@@ -160,11 +180,19 @@ void link(final String name, final String target) throws IOException {
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
@@ -484,8 +512,8 @@ private void lockAndWriteFile(File file, byte[] content) throws IOException {
 	}
 
 	synchronized void removePackedRef(String name) throws IOException {
-		packedRefs.remove(name);
-		writePackedRefs();
+		if (packedRefs.remove(name) != null)
+			writePackedRefs();
 	}
 
 	private void writePackedRefs() throws IOException {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefLogWriter.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefLogWriter.java
index a077051..bbf26eb 100644
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
@@ -58,6 +58,25 @@ static void append(final RefUpdate u, final String msg) throws IOException {
 		appendOneRecord(oldId, newId, ident, msg, db, u.getName());
 	}
 
+	static boolean renameTo(final Repository db, final RefUpdate from,
+			final RefUpdate to) throws IOException {
+		final File logdir = new File(db.getDirectory(), Constants.LOGS);
+		final File reflogFrom = new File(logdir, from.getName());
+		if (!reflogFrom.exists())
+			return true;
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
+		return true;
+	}
+
 	private static void appendOneRecord(final ObjectId oldId,
 			final ObjectId newId, PersonIdent ident, final String msg,
 			final Repository db, final String refName) throws IOException {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java
index a9ab73b..8ecccfe 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java
@@ -50,6 +50,100 @@
  * Updates any locally stored ref.
  */
 public class RefUpdate {
+	/**
+	 * A RefUpdate combination for renaming a ref
+	 */
+	public static class RenameRefUpdates {
+		RenameRefUpdates(final RefUpdate toUpdate, final RefUpdate fromUpdate,
+				final RefUpdate headUpdate) {
+			newToUpdate = toUpdate;
+			oldFromDelete = fromUpdate;
+		}
+		private RefUpdate newToUpdate;
+
+		private RefUpdate oldFromDelete;
+
+		private Result renameResult;
+
+		/**
+		 * @return result of rename operation
+		 */
+		public Result getResult() {
+			return renameResult;
+		}
+
+		/**
+		 * @return the result of the new ref update
+		 * @throws IOException
+		 */
+		public Result rename() throws IOException {
+			LockFile lockFileFrom = new LockFile(oldFromDelete.looseFile);
+			boolean lockFrom = lockFileFrom.lock();
+			if (!lockFrom)
+				return Result.LOCK_FAILURE;
+			LockFile lockFileTo = null;
+			try {
+				lockFileTo = new LockFile(newToUpdate.looseFile);
+				boolean lockTo = lockFileTo.lock();
+				if (!lockTo) {
+					lockFileFrom.unlock();
+					return renameResult = Result.LOCK_FAILURE;
+				}
+			} catch (IOException e) {
+				lockFileFrom.unlock();
+				throw e;
+			}
+			LockFile lockFileHEAD = new LockFile(new File(oldFromDelete.db.getRepository().getDirectory(), Constants.HEAD));
+			boolean renameHEADtoo;
+			try {
+				boolean lockHEAD = lockFileHEAD.lock();
+				renameHEADtoo = oldFromDelete.db.readRef(Constants.HEAD).getName().equals(oldFromDelete.getName());
+				if (!renameHEADtoo)
+					lockFileHEAD.unlock();
+				else {
+					if (!lockHEAD) {
+						lockFileFrom.unlock();
+						lockFileTo.unlock();
+						return renameResult = Result.LOCK_FAILURE;
+					}
+				}
+			} catch (IOException e) {
+				lockFileHEAD.unlock();
+				lockFileFrom.unlock();
+				lockFileTo.unlock();
+				throw e;
+			}
+			try {
+				UpdateStore toStore = newToUpdate.newUpdateStore();
+				if (RefLogWriter.renameTo(oldFromDelete.getRepository(), oldFromDelete, newToUpdate)) {
+					newToUpdate.setNewObjectId(oldFromDelete.getOldObjectId());
+					newToUpdate.setExpectedOldObjectId(oldFromDelete.getOldObjectId());
+					newToUpdate.setRefLogMessage("jgit branch: renamed " + oldFromDelete.getName() + " to " + oldFromDelete.getName(), false);
+					newToUpdate.result = toStore.store(lockFileTo, Result.RENAMED);
+					DeleteStore fromStore = oldFromDelete.newDeleteStore();
+					Result store = fromStore.store(lockFileFrom, Result.RENAMED);
+					if (renameHEADtoo) {
+						final byte[] content = Constants.encode("ref: " + newToUpdate.getName() + "\n");
+						lockFileHEAD.write(content);
+						synchronized (this) {
+							oldFromDelete.db.getRepository().uncacheSymRef(Constants.HEAD);
+						}
+						if (!lockFileHEAD.commit())
+							throw new IOException("Failed to commit HEAD during rename");
+					}
+					oldFromDelete.db.getRepository().fireRefsMaybeChanged();
+					return store;
+				} else {
+					return Result.IO_FAILURE;
+				}
+			} finally {
+				lockFileFrom.unlock();
+				lockFileTo.unlock();
+				lockFileHEAD.unlock();
+			}
+		}
+	}
+
 	/** Status of an update request. */
 	public static enum Result {
 		/** The ref update/delete has not been attempted by the caller. */
@@ -125,7 +219,13 @@
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
@@ -478,6 +578,8 @@ else if (status == Result.FAST_FORWARD)
 				msg += ": fast forward";
 			else if (status == Result.NEW)
 				msg += ": created";
+			else if (status == Result.RENAMED)
+				msg += ": renamed";
 		}
 		RefLogWriter.append(this, msg);
 		if (!lock.commit())
@@ -553,4 +655,12 @@ private static int count(final String s, final char c) {
 		}
 		return count;
 	}
+
+	private UpdateStore newUpdateStore() {
+		return new UpdateStore();
+	}
+
+	private DeleteStore newDeleteStore() {
+		return new DeleteStore();
+	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index 5baa7a0..e704aeb 100644
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
+	public RefUpdate.RenameRefUpdates renameRef(final String fromRef, final String toRef) throws IOException {
+		return refs.newRename(fromRef, toRef);
+	}
+
+	/**
 	 * Parse a git revision string and return an object id.
 	 *
 	 * Currently supported is combinations of these.
@@ -1067,4 +1083,21 @@ public void scanForRepoChanges() throws IOException {
 		getAllRefs(); // This will look for changes to refs
 		getIndex(); // This will detect changes in the index
 	}
+
+	/**
+	 * Writes a symref (e.g. HEAD) to disk
+	 *
+	 * @param name
+	 *            symref name
+	 * @param target
+	 *            pointed to ref
+	 * @throws IOException
+	 */
+	public void link(final String name, final String target) throws IOException {
+		refs.link(name, target);
+	}
+
+	void uncacheSymRef(String name) {
+		refs.uncacheSymRef(name);
+	}
 }
-- 
1.6.3.rc2.1.g868b6

From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 07/11] Introduce RepositoryCache to cache handles of Repository objects
Date: Sat, 11 Jul 2009 13:19:22 -0700
Message-ID: <1247343566-19025-8-git-send-email-spearce@spearce.org>
References: <1247343566-19025-1-git-send-email-spearce@spearce.org>
 <1247343566-19025-2-git-send-email-spearce@spearce.org>
 <1247343566-19025-3-git-send-email-spearce@spearce.org>
 <1247343566-19025-4-git-send-email-spearce@spearce.org>
 <1247343566-19025-5-git-send-email-spearce@spearce.org>
 <1247343566-19025-6-git-send-email-spearce@spearce.org>
 <1247343566-19025-7-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org,
	Constantine Plotnikov <constantine.plotnikov@gmail.com>
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sat Jul 11 22:20:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPj3r-0003g9-RY
	for gcvg-git-2@gmane.org; Sat, 11 Jul 2009 22:20:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753791AbZGKUTt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jul 2009 16:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753723AbZGKUTn
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Jul 2009 16:19:43 -0400
Received: from george.spearce.org ([209.20.77.23]:39709 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751037AbZGKUTc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jul 2009 16:19:32 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 10BDC38267; Sat, 11 Jul 2009 20:19:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 3579638215;
	Sat, 11 Jul 2009 20:19:29 +0000 (UTC)
X-Mailer: git-send-email 1.6.4.rc0.117.g28cb
In-Reply-To: <1247343566-19025-7-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123128>

In almost any application using JGit the application code wants to
open more than one Repository at once.  Most applications wind up
creating their own form of this RepositoryCache concept, where we
attempt to map some unique key (e.g. the directory path on disk)
to the open Repository instance, so that concurrent accesses to
the same Git repository go through the same JGit object and thus
can share the same memory pools.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
CC: Constantine Plotnikov <constantine.plotnikov@gmail.com>
---
 .../org/spearce/jgit/lib/RepositoryCacheTest.java  |  126 +++++++
 .../org/spearce/jgit/lib/RepositoryTestCase.java   |   16 +-
 .../jgit/errors/RepositoryNotFoundException.java   |   65 ++++
 .../src/org/spearce/jgit/lib/RepositoryCache.java  |  386 ++++++++++++++++++++
 4 files changed, 592 insertions(+), 1 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryCacheTest.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/errors/RepositoryNotFoundException.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryCache.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryCacheTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryCacheTest.java
new file mode 100644
index 0000000..f466e00
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryCacheTest.java
@@ -0,0 +1,126 @@
+/*
+ * Copyright (C) 2009, Google Inc.
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
+
+package org.spearce.jgit.lib;
+
+import java.io.File;
+import java.io.IOException;
+
+import org.spearce.jgit.errors.RepositoryNotFoundException;
+import org.spearce.jgit.lib.RepositoryCache.FileKey;
+
+public class RepositoryCacheTest extends RepositoryTestCase {
+	public void testNonBareFileKey() {
+		File gitdir = db.getDirectory();
+		File parent = gitdir.getParentFile();
+		File other = new File(parent, "notagit");
+		assertEquals(gitdir, FileKey.exact(gitdir).getFile());
+		assertEquals(parent, FileKey.exact(parent).getFile());
+		assertEquals(other, FileKey.exact(other).getFile());
+
+		assertEquals(gitdir, FileKey.lenient(gitdir).getFile());
+		assertEquals(gitdir, FileKey.lenient(parent).getFile());
+		assertEquals(other, FileKey.lenient(other).getFile());
+	}
+
+	public void testBareFileKey() throws IOException {
+		Repository bare = createNewEmptyRepo(true);
+		File gitdir = bare.getDirectory();
+		File parent = gitdir.getParentFile();
+		String name = gitdir.getName();
+		assertTrue(name.endsWith(".git"));
+		name = name.substring(0, name.length() - 4);
+
+		assertEquals(gitdir, FileKey.exact(gitdir).getFile());
+
+		assertEquals(gitdir, FileKey.lenient(gitdir).getFile());
+		assertEquals(gitdir, FileKey.lenient(new File(parent, name)).getFile());
+	}
+
+	public void testFileKeyOpenExisting() throws IOException {
+		Repository r;
+
+		r = new FileKey(db.getDirectory()).open(true);
+		assertNotNull(r);
+		assertEquals(db.getDirectory(), r.getDirectory());
+		r.close();
+
+		r = new FileKey(db.getDirectory()).open(false);
+		assertNotNull(r);
+		assertEquals(db.getDirectory(), r.getDirectory());
+		r.close();
+	}
+
+	public void testFileKeyOpenNew() throws IOException {
+		final Repository n = createNewEmptyRepo(true);
+		final File gitdir = n.getDirectory();
+		n.close();
+		recursiveDelete(gitdir);
+		assertFalse(gitdir.exists());
+
+		try {
+			new FileKey(gitdir).open(true);
+			fail("incorrectly opened a non existant repository");
+		} catch (RepositoryNotFoundException e) {
+			assertEquals("repository not found: " + gitdir, e.getMessage());
+		}
+
+		final Repository o = new FileKey(gitdir).open(false);
+		assertNotNull(o);
+		assertEquals(gitdir, o.getDirectory());
+		assertFalse(gitdir.exists());
+	}
+
+	public void testCacheRegisterOpen() throws Exception {
+		final File dir = db.getDirectory();
+		RepositoryCache.register(db);
+		assertSame(db, RepositoryCache.open(FileKey.exact(dir)));
+
+		assertEquals(".git", dir.getName());
+		final File parent = dir.getParentFile();
+		assertSame(db, RepositoryCache.open(FileKey.lenient(parent)));
+	}
+
+	public void testCacheOpen() throws Exception {
+		final FileKey loc = FileKey.exact(db.getDirectory());
+		final Repository d2 = RepositoryCache.open(loc);
+		assertNotSame(db, d2);
+		assertSame(d2, RepositoryCache.open(FileKey.exact(loc.getFile())));
+		d2.close();
+		d2.close();
+	}
+}
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
index 3837ea9..2783180 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
@@ -307,6 +307,7 @@ public void run() {
 	}
 
 	protected void tearDown() throws Exception {
+		RepositoryCache.clear();
 		db.close();
 		for (Repository r : repositoriesToClose)
 			r.close();
@@ -334,8 +335,21 @@ protected void tearDown() throws Exception {
 	 * @throws IOException
 	 */
 	protected Repository createNewEmptyRepo() throws IOException {
+		return createNewEmptyRepo(false);
+	}
+
+	/**
+	 * Helper for creating extra empty repos
+	 *
+	 * @param bare if true, create a bare repository.
+	 * @return a new empty git repository for testing purposes
+	 *
+	 * @throws IOException
+	 */
+	protected Repository createNewEmptyRepo(boolean bare) throws IOException {
 		final File newTestRepo = new File(trashParent, "new"
-				+ System.currentTimeMillis() + "." + (testcount++) + "/.git");
+				+ System.currentTimeMillis() + "." + (testcount++)
+				+ (bare ? "" : "/") + ".git");
 		assertFalse(newTestRepo.exists());
 		final Repository newRepo = new Repository(newTestRepo);
 		newRepo.create();
diff --git a/org.spearce.jgit/src/org/spearce/jgit/errors/RepositoryNotFoundException.java b/org.spearce.jgit/src/org/spearce/jgit/errors/RepositoryNotFoundException.java
new file mode 100644
index 0000000..f47f577
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/errors/RepositoryNotFoundException.java
@@ -0,0 +1,65 @@
+/*
+ * Copyright (C) 2009, Google Inc.
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
+
+package org.spearce.jgit.errors;
+
+import java.io.File;
+
+/** Indicates a local repository does not exist. */
+public class RepositoryNotFoundException extends TransportException {
+	private static final long serialVersionUID = 1L;
+
+	/**
+	 * Constructs an exception indicating a local repository does not exist.
+	 * 
+	 * @param location
+	 *            description of the repository not found, usually file path.
+	 */
+	public RepositoryNotFoundException(final File location) {
+		this(location.getPath());
+	}
+
+	/**
+	 * Constructs an exception indicating a local repository does not exist.
+	 * 
+	 * @param location
+	 *            description of the repository not found, usually file path.
+	 */
+	public RepositoryNotFoundException(final String location) {
+		super("repository not found: " + location);
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryCache.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryCache.java
new file mode 100644
index 0000000..50b4330
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryCache.java
@@ -0,0 +1,386 @@
+/*
+ * Copyright (C) 2009, Google Inc.
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
+
+package org.spearce.jgit.lib;
+
+import java.io.BufferedReader;
+import java.io.File;
+import java.io.FileInputStream;
+import java.io.IOException;
+import java.io.InputStreamReader;
+import java.lang.ref.Reference;
+import java.lang.ref.WeakReference;
+import java.util.Iterator;
+import java.util.Map;
+import java.util.concurrent.ConcurrentHashMap;
+
+import org.spearce.jgit.errors.RepositoryNotFoundException;
+import org.spearce.jgit.util.FS;
+
+/** Cache of active {@link Repository} instances. */
+public class RepositoryCache {
+	private static final RepositoryCache cache = new RepositoryCache();
+
+	/**
+	 * Open an existing repository, reusing a cached instance if possible.
+	 * <p>
+	 * When done with the repository, the caller must call
+	 * {@link Repository#close()} to decrement the repository's usage counter.
+	 * 
+	 * @param location
+	 *            where the local repository is. Typically a {@link FileKey}.
+	 * @return the repository instance requested; caller must close when done.
+	 * @throws IOException
+	 *             the repository could not be read (likely its core.version
+	 *             property is not supported).
+	 * @throws RepositoryNotFoundException
+	 *             there is no repository at the given location.
+	 */
+	public static Repository open(final Key location) throws IOException,
+			RepositoryNotFoundException {
+		return open(location, true);
+	}
+
+	/**
+	 * Open a repository, reusing a cached instance if possible.
+	 * <p>
+	 * When done with the repository, the caller must call
+	 * {@link Repository#close()} to decrement the repository's usage counter.
+	 * 
+	 * @param location
+	 *            where the local repository is. Typically a {@link FileKey}.
+	 * @param mustExist
+	 *            If true, and the repository is not found, throws {@code
+	 *            RepositoryNotFoundException}. If false, a repository instance
+	 *            is created and registered anyway.
+	 * @return the repository instance requested; caller must close when done.
+	 * @throws IOException
+	 *             the repository could not be read (likely its core.version
+	 *             property is not supported).
+	 * @throws RepositoryNotFoundException
+	 *             There is no repository at the given location, only thrown if
+	 *             {@code mustExist} is true.
+	 */
+	public static Repository open(final Key location, final boolean mustExist)
+			throws IOException {
+		return cache.openRepository(location, mustExist);
+	}
+
+	/**
+	 * Register one repository into the cache.
+	 * <p>
+	 * During registration the cache automatically increments the usage counter,
+	 * permitting it to retain the reference. A {@link FileKey} for the
+	 * repository's {@link Repository#getDirectory()} is used to index the
+	 * repository in the cache.
+	 * <p>
+	 * If another repository already is registered in the cache at this
+	 * location, the other instance is closed.
+	 * 
+	 * @param db
+	 *            repository to register.
+	 */
+	public static void register(final Repository db) {
+		cache.registerRepository(FileKey.exact(db.getDirectory()), db);
+	}
+
+	/**
+	 * Remove a repository from the cache.
+	 * <p>
+	 * Removes a repository from the cache, if it is still registered here,
+	 * permitting it to close.
+	 * 
+	 * @param db
+	 *            repository to unregister.
+	 */
+	public static void close(final Repository db) {
+		cache.unregisterRepository(FileKey.exact(db.getDirectory()));
+	}
+
+	/** Unregister all repositories from the cache. */
+	public static void clear() {
+		cache.clearAll();
+	}
+
+	private final ConcurrentHashMap<Key, Reference<Repository>> cacheMap;
+
+	private final Lock[] openLocks;
+
+	private RepositoryCache() {
+		cacheMap = new ConcurrentHashMap<Key, Reference<Repository>>();
+		openLocks = new Lock[4];
+		for (int i = 0; i < openLocks.length; i++)
+			openLocks[i] = new Lock();
+	}
+
+	private Repository openRepository(final Key location,
+			final boolean mustExist) throws IOException {
+		Reference<Repository> ref = cacheMap.get(location);
+		Repository db = ref != null ? ref.get() : null;
+		if (db == null) {
+			synchronized (lockFor(location)) {
+				ref = cacheMap.get(location);
+				db = ref != null ? ref.get() : null;
+				if (db == null) {
+					db = location.open(mustExist);
+					ref = new WeakReference<Repository>(db);
+					cacheMap.put(location, ref);
+				}
+			}
+		}
+		db.incrementOpen();
+		return db;
+	}
+
+	private void registerRepository(final Key location, final Repository db) {
+		db.incrementOpen();
+		WeakReference<Repository> newRef = new WeakReference<Repository>(db);
+		Reference<Repository> oldRef = cacheMap.put(location, newRef);
+		Repository oldDb = oldRef != null ? oldRef.get() : null;
+		if (oldDb != null)
+			oldDb.close();
+	}
+
+	private void unregisterRepository(final Key location) {
+		Reference<Repository> oldRef = cacheMap.remove(location);
+		Repository oldDb = oldRef != null ? oldRef.get() : null;
+		if (oldDb != null)
+			oldDb.close();
+	}
+
+	private void clearAll() {
+		for (int stage = 0; stage < 2; stage++) {
+			for (Iterator<Map.Entry<Key, Reference<Repository>>> i = cacheMap
+					.entrySet().iterator(); i.hasNext();) {
+				final Map.Entry<Key, Reference<Repository>> e = i.next();
+				final Repository db = e.getValue().get();
+				if (db != null)
+					db.close();
+				i.remove();
+			}
+		}
+	}
+
+	private Lock lockFor(final Key location) {
+		return openLocks[(location.hashCode() >>> 1) % openLocks.length];
+	}
+
+	private static class Lock {
+		// Used only for its monitor.
+	}
+
+	/**
+	 * Abstract hash key for {@link RepositoryCache} entries.
+	 * <p>
+	 * A Key instance should be lightweight, and implement hashCode() and
+	 * equals() such that two Key instances are equal if they represent the same
+	 * Repository location.
+	 */
+	public static interface Key {
+		/**
+		 * Called by {@link RepositoryCache#open(Key)} if it doesn't exist yet.
+		 * <p>
+		 * If a repository does not exist yet in the cache, the cache will call
+		 * this method to acquire a handle to it.
+		 * 
+		 * @param mustExist
+		 *            true if the repository must exist in order to be opened;
+		 *            false if a new non-existent repository is permitted to be
+		 *            created (the caller is responsible for calling create).
+		 * @return the new repository instance.
+		 * @throws IOException
+		 *             the repository could not be read (likely its core.version
+		 *             property is not supported).
+		 * @throws RepositoryNotFoundException
+		 *             There is no repository at the given location, only thrown
+		 *             if {@code mustExist} is true.
+		 */
+		Repository open(boolean mustExist) throws IOException,
+				RepositoryNotFoundException;
+	}
+
+	/** Location of a Repository, using the standard java.io.File API. */
+	public static class FileKey implements Key {
+		/**
+		 * Obtain a pointer to an exact location on disk.
+		 * <p>
+		 * No guessing is performed, the given location is exactly the GIT_DIR
+		 * directory of the repository.
+		 * 
+		 * @param directory
+		 *            location where the repository database is.
+		 * @return a key for the given directory.
+		 * @see #lenient(File)
+		 */
+		public static FileKey exact(final File directory) {
+			return new FileKey(directory);
+		}
+
+		/**
+		 * Obtain a pointer to a location on disk.
+		 * <p>
+		 * The method performs some basic guessing to locate the repository.
+		 * Searched paths are:
+		 * <ol>
+		 * <li>{@code directory} // assume exact match</li>
+		 * <li>{@code directory} + "/.git" // assume working directory</li>
+		 * <li>{@code directory} + ".git" // assume bare</li>
+		 * </ol>
+		 * 
+		 * @param directory
+		 *            location where the repository database might be.
+		 * @return a key for the given directory.
+		 * @see #exact(File)
+		 */
+		public static FileKey lenient(final File directory) {
+			final File gitdir = resolve(directory);
+			return new FileKey(gitdir != null ? gitdir : directory);
+		}
+
+		private final File path;
+
+		/**
+		 * @param directory
+		 *            exact location of the repository.
+		 */
+		protected FileKey(final File directory) {
+			path = canonical(directory);
+		}
+
+		private static File canonical(final File path) {
+			try {
+				return path.getCanonicalFile();
+			} catch (IOException e) {
+				return path.getAbsoluteFile();
+			}
+		}
+
+		/** @return location supplied to the constructor. */
+		public final File getFile() {
+			return path;
+		}
+
+		public Repository open(final boolean mustExist) throws IOException {
+			if (mustExist && !isGitRepository(path))
+				throw new RepositoryNotFoundException(path);
+			return new Repository(path);
+		}
+
+		@Override
+		public int hashCode() {
+			return path.hashCode();
+		}
+
+		@Override
+		public boolean equals(final Object o) {
+			return o instanceof FileKey && path.equals(((FileKey) o).path);
+		}
+
+		@Override
+		public String toString() {
+			return path.toString();
+		}
+
+		/**
+		 * Guess if a directory contains a Git repository.
+		 * <p>
+		 * This method guesses by looking for the existence of some key files
+		 * and directories.
+		 * 
+		 * @param dir
+		 *            the location of the directory to examine.
+		 * @return true if the directory "looks like" a Git repository; false if
+		 *         it doesn't look enough like a Git directory to really be a
+		 *         Git directory.
+		 */
+		public static boolean isGitRepository(final File dir) {
+			return FS.resolve(dir, "objects").exists()
+					&& FS.resolve(dir, "refs").exists()
+					&& isValidHead(new File(dir, Constants.HEAD));
+		}
+
+		private static boolean isValidHead(final File head) {
+			final String ref = readFirstLine(head);
+			return ref != null
+					&& (ref.startsWith("ref: refs/") || ObjectId.isId(ref));
+		}
+
+		private static String readFirstLine(final File head) {
+			try {
+				final BufferedReader br = new BufferedReader(
+						new InputStreamReader(new FileInputStream(head),
+								Constants.CHARSET));
+				try {
+					return br.readLine();
+				} finally {
+					br.close();
+				}
+			} catch (IOException e) {
+				return null;
+			}
+		}
+
+		/**
+		 * Guess the proper path for a Git repository.
+		 * <p>
+		 * The method performs some basic guessing to locate the repository.
+		 * Searched paths are:
+		 * <ol>
+		 * <li>{@code directory} // assume exact match</li>
+		 * <li>{@code directory} + "/.git" // assume working directory</li>
+		 * <li>{@code directory} + ".git" // assume bare</li>
+		 * </ol>
+		 * 
+		 * @param directory
+		 *            location to guess from. Several permutations are tried.
+		 * @return the actual directory location if a better match is found;
+		 *         null if there is no suitable match.
+		 */
+		public static File resolve(final File directory) {
+			if (isGitRepository(directory))
+				return directory;
+			if (isGitRepository(new File(directory, ".git")))
+				return new File(directory, ".git");
+
+			final String name = directory.getName();
+			final File parent = directory.getParentFile();
+			if (isGitRepository(new File(parent, name + ".git")))
+				return new File(parent, name + ".git");
+			return null;
+		}
+	}
+}
-- 
1.6.4.rc0.117.g28cb

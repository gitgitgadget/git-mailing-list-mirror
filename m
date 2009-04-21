From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 06/10] Refactor object database access with new abstraction
Date: Mon, 20 Apr 2009 18:21:08 -0700
Message-ID: <1240276872-17893-7-git-send-email-spearce@spearce.org>
References: <1240276872-17893-1-git-send-email-spearce@spearce.org>
 <1240276872-17893-2-git-send-email-spearce@spearce.org>
 <1240276872-17893-3-git-send-email-spearce@spearce.org>
 <1240276872-17893-4-git-send-email-spearce@spearce.org>
 <1240276872-17893-5-git-send-email-spearce@spearce.org>
 <1240276872-17893-6-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 03:23:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lw4hW-00021g-Bx
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 03:23:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753892AbZDUBVc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 21:21:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757676AbZDUBVa
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 21:21:30 -0400
Received: from george.spearce.org ([209.20.77.23]:33022 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757078AbZDUBVT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 21:21:19 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 655FF38260; Tue, 21 Apr 2009 01:21:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 662263821F;
	Tue, 21 Apr 2009 01:21:15 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.rc1.188.ga02b
In-Reply-To: <1240276872-17893-6-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117065>

By moving object database access out of the Repository class we
start to open the door for less-traditional databases, such as
storing objects in a distributed hash table or in-memory.

This change doesn't introduce any new functionality, nor does it
fix any existing bugs.  A Repository instance still assumes that
its object database is in "$GIT_DIR/objects", and there is no way
to override that assumption.

Unlike the prior implementation, alternates are maintained as
discrete instances, rather than being inlined into the same list
as the repository's own object directory.  This cleans up that
search logic as its now more clear when we scan the alternate
and when we scan the local repository.  It also opens the door
for sharing shared repositories, e.g. if an IDE were to open
two repositories both forked from the same reference location
we could reuse the same ObjectDatabase instance between them.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../org/spearce/jgit/lib/RepositoryTestCase.java   |    2 -
 .../tst/org/spearce/jgit/lib/T0004_PackReader.java |    1 -
 .../src/org/spearce/jgit/lib/ObjectDatabase.java   |  354 +++++++++++++++++
 .../src/org/spearce/jgit/lib/ObjectDirectory.java  |  401 ++++++++++++++++++++
 .../src/org/spearce/jgit/lib/Repository.java       |  174 +--------
 .../org/spearce/jgit/lib/UnpackedObjectLoader.java |   22 +-
 6 files changed, 779 insertions(+), 175 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDatabase.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDirectory.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
index 588daf4..b85d3eb 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
@@ -297,8 +297,6 @@ copyFile(JGitTestUtil.getTestResourceFile(packs[k] + ".idx"), new File(packDir,
 
 		copyFile(JGitTestUtil.getTestResourceFile("packed-refs"), new File(trash_git,"packed-refs"));
 
-		db.scanForPacks();
-
 		fakeSystemReader.values.clear();
 		fakeSystemReader.values.put(Constants.OS_USER_NAME_KEY, Constants.OS_USER_NAME_KEY);
 		fakeSystemReader.values.put(Constants.GIT_AUTHOR_NAME_KEY, Constants.GIT_AUTHOR_NAME_KEY);
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0004_PackReader.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0004_PackReader.java
index b9e5b49..e35e623 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0004_PackReader.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0004_PackReader.java
@@ -89,7 +89,6 @@ copyFile(new File(todopack, packname + ".pack"), new File(packDir,
 				packname + ".pack"));
 		copyFile(new File(todopack, packname + ".idx"), new File(packDir,
 				packname + ".idx"));
-		db.scanForPacks();
 		Tree t;
 
 		t = db
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDatabase.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDatabase.java
new file mode 100644
index 0000000..ed1290f
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDatabase.java
@@ -0,0 +1,354 @@
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
+import java.io.IOException;
+import java.util.Collection;
+import java.util.concurrent.atomic.AtomicReference;
+
+/**
+ * Abstraction of arbitrary object storage.
+ * <p>
+ * An object database stores one or more Git objects, indexed by their unique
+ * {@link ObjectId}. Optionally an object database can reference one or more
+ * alternates; other ObjectDatabase instances that are searched in addition to
+ * the current database.
+ * <p>
+ * Databases are usually divided into two halves: a half that is considered to
+ * be fast to search, and a half that is considered to be slow to search. When
+ * alternates are present the fast half is fully searched (recursively through
+ * all alternates) before the slow half is considered.
+ */
+public abstract class ObjectDatabase {
+	/** Constant indicating no alternate databases exist. */
+	protected static final ObjectDatabase[] NO_ALTERNATES = {};
+
+	private final AtomicReference<ObjectDatabase[]> alternates;
+
+	/** Initialize a new database instance for access. */
+	protected ObjectDatabase() {
+		alternates = new AtomicReference<ObjectDatabase[]>();
+	}
+
+	/**
+	 * Does this database exist yet?
+	 * 
+	 * @return true if this database is already created; false if the caller
+	 *         should invoke {@link #create()} to create this database location.
+	 */
+	public boolean exists() {
+		return true;
+	}
+
+	/**
+	 * Initialize a new object database at this location.
+	 * 
+	 * @throws IOException
+	 *             the database could not be created.
+	 */
+	public void create() throws IOException {
+		// Assume no action is required.
+	}
+
+	/**
+	 * Close any resources held by this database and its active alternates.
+	 */
+	public final void close() {
+		closeSelf();
+		closeAlternates();
+	}
+
+	/**
+	 * Close any resources held by this database only; ignoring alternates.
+	 * <p>
+	 * To fully close this database and its referenced alternates, the caller
+	 * should instead invoke {@link #close()}.
+	 */
+	public void closeSelf() {
+		// Assume no action is required.
+	}
+
+	/** Fully close all loaded alternates and clear the alternate list. */
+	public final void closeAlternates() {
+		ObjectDatabase[] alt = alternates.get();
+		if (alt != null) {
+			alternates.set(null);
+			for (final ObjectDatabase d : alt) {
+				d.close();
+			}
+		}
+	}
+
+	/**
+	 * Does the requested object exist in this database?
+	 * <p>
+	 * Alternates (if present) are searched automatically.
+	 * 
+	 * @param objectId
+	 *            identity of the object to test for existence of.
+	 * @return true if the specified object is stored in this database, or any
+	 *         of the alternate databases.
+	 */
+	public final boolean hasObject(final AnyObjectId objectId) {
+		return hasObjectImpl1(objectId) || hasObjectImpl2(objectId.name());
+	}
+
+	private final boolean hasObjectImpl1(final AnyObjectId objectId) {
+		if (hasObject1(objectId)) {
+			return true;
+		}
+		for (final ObjectDatabase alt : getAlternates()) {
+			if (alt.hasObjectImpl1(objectId)) {
+				return true;
+			}
+		}
+		return false;
+	}
+
+	private final boolean hasObjectImpl2(final String objectId) {
+		if (hasObject2(objectId)) {
+			return true;
+		}
+		for (final ObjectDatabase alt : getAlternates()) {
+			if (alt.hasObjectImpl2(objectId)) {
+				return true;
+			}
+		}
+		return false;
+	}
+
+	/**
+	 * Fast half of {@link #hasObject(AnyObjectId)}.
+	 * 
+	 * @param objectId
+	 *            identity of the object to test for existence of.
+	 * @return true if the specified object is stored in this database.
+	 */
+	protected abstract boolean hasObject1(AnyObjectId objectId);
+
+	/**
+	 * Slow half of {@link #hasObject(AnyObjectId)}.
+	 * 
+	 * @param objectName
+	 *            identity of the object to test for existence of.
+	 * @return true if the specified object is stored in this database.
+	 */
+	protected boolean hasObject2(String objectName) {
+		// Assume the search took place during hasObject1.
+		return false;
+	}
+
+	/**
+	 * Open an object from this database.
+	 * <p>
+	 * Alternates (if present) are searched automatically.
+	 * 
+	 * @param curs
+	 *            temporary working space associated with the calling thread.
+	 * @param objectId
+	 *            identity of the object to open.
+	 * @return a {@link ObjectLoader} for accessing the data of the named
+	 *         object, or null if the object does not exist.
+	 * @throws IOException
+	 */
+	public final ObjectLoader openObject(final WindowCursor curs,
+			final AnyObjectId objectId) throws IOException {
+		ObjectLoader ldr;
+
+		ldr = openObjectImpl1(curs, objectId);
+		if (ldr != null) {
+			return ldr;
+		}
+
+		ldr = openObjectImpl2(curs, objectId.name(), objectId);
+		if (ldr != null) {
+			return ldr;
+		}
+		return null;
+	}
+
+	private ObjectLoader openObjectImpl1(final WindowCursor curs,
+			final AnyObjectId objectId) throws IOException {
+		ObjectLoader ldr;
+
+		ldr = openObject1(curs, objectId);
+		if (ldr != null) {
+			return ldr;
+		}
+		for (final ObjectDatabase alt : getAlternates()) {
+			ldr = alt.openObjectImpl1(curs, objectId);
+			if (ldr != null) {
+				return ldr;
+			}
+		}
+		return null;
+	}
+
+	private ObjectLoader openObjectImpl2(final WindowCursor curs,
+			final String objectName, final AnyObjectId objectId)
+			throws IOException {
+		ObjectLoader ldr;
+
+		ldr = openObject2(curs, objectName, objectId);
+		if (ldr != null) {
+			return ldr;
+		}
+		for (final ObjectDatabase alt : getAlternates()) {
+			ldr = alt.openObjectImpl2(curs, objectName, objectId);
+			if (ldr != null) {
+				return ldr;
+			}
+		}
+		return null;
+	}
+
+	/**
+	 * Fast half of {@link #openObject(WindowCursor, AnyObjectId)}.
+	 * 
+	 * @param curs
+	 *            temporary working space associated with the calling thread.
+	 * @param objectId
+	 *            identity of the object to open.
+	 * @return a {@link ObjectLoader} for accessing the data of the named
+	 *         object, or null if the object does not exist.
+	 * @throws IOException
+	 */
+	protected abstract ObjectLoader openObject1(WindowCursor curs,
+			AnyObjectId objectId) throws IOException;
+
+	/**
+	 * Slow half of {@link #openObject(WindowCursor, AnyObjectId)}.
+	 * 
+	 * @param curs
+	 *            temporary working space associated with the calling thread.
+	 * @param objectName
+	 *            name of the object to open.
+	 * @param objectId
+	 *            identity of the object to open.
+	 * @return a {@link ObjectLoader} for accessing the data of the named
+	 *         object, or null if the object does not exist.
+	 * @throws IOException
+	 */
+	protected ObjectLoader openObject2(WindowCursor curs, String objectName,
+			AnyObjectId objectId) throws IOException {
+		// Assume the search took place during openObject1.
+		return null;
+	}
+
+	/**
+	 * Open the object from all packs containing it.
+	 * <p>
+	 * If any alternates are present, their packs are also considered.
+	 * 
+	 * @param out
+	 *            result collection of loaders for this object, filled with
+	 *            loaders from all packs containing specified object
+	 * @param curs
+	 *            temporary working space associated with the calling thread.
+	 * @param objectId
+	 *            id of object to search for
+	 * @throws IOException
+	 */
+	final void openObjectInAllPacks(final Collection<PackedObjectLoader> out,
+			final WindowCursor curs, final AnyObjectId objectId)
+			throws IOException {
+		openObjectInAllPacks1(out, curs, objectId);
+		for (final ObjectDatabase alt : getAlternates()) {
+			alt.openObjectInAllPacks1(out, curs, objectId);
+		}
+	}
+
+	/**
+	 * Open the object from all packs containing it.
+	 * 
+	 * @param out
+	 *            result collection of loaders for this object, filled with
+	 *            loaders from all packs containing specified object
+	 * @param curs
+	 *            temporary working space associated with the calling thread.
+	 * @param objectId
+	 *            id of object to search for
+	 * @throws IOException
+	 */
+	void openObjectInAllPacks1(Collection<PackedObjectLoader> out,
+			WindowCursor curs, AnyObjectId objectId) throws IOException {
+		// Assume no pack support
+	}
+
+	/**
+	 * Get the alternate databases known to this database.
+	 * 
+	 * @return the alternate list. Never null, but may be an empty array.
+	 */
+	public final ObjectDatabase[] getAlternates() {
+		ObjectDatabase[] r = alternates.get();
+		if (r == null) {
+			synchronized (alternates) {
+				r = alternates.get();
+				if (r == null) {
+					try {
+						r = loadAlternates();
+					} catch (IOException e) {
+						r = NO_ALTERNATES;
+					}
+					alternates.set(r);
+				}
+			}
+		}
+		return r;
+	}
+
+	/**
+	 * Load the list of alternate databases into memory.
+	 * <p>
+	 * This method is invoked by {@link #getAlternates()} if the alternate list
+	 * has not yet been populated, or if {@link #closeAlternates()} has been
+	 * called on this instance and the alternate list is needed again.
+	 * <p>
+	 * If the alternate array is empty, implementors should consider using the
+	 * constant {@link #NO_ALTERNATES}.
+	 * 
+	 * @return the alternate list for this database.
+	 * @throws IOException
+	 *             the alternate list could not be accessed. The empty alternate
+	 *             array {@link #NO_ALTERNATES} will be assumed by the caller.
+	 */
+	protected ObjectDatabase[] loadAlternates() throws IOException {
+		return NO_ALTERNATES;
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDirectory.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDirectory.java
new file mode 100644
index 0000000..e7156c4
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDirectory.java
@@ -0,0 +1,401 @@
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
+import java.io.FileNotFoundException;
+import java.io.FileReader;
+import java.io.FilenameFilter;
+import java.io.IOException;
+import java.util.ArrayList;
+import java.util.Arrays;
+import java.util.Collection;
+import java.util.HashMap;
+import java.util.List;
+import java.util.Map;
+import java.util.concurrent.atomic.AtomicReference;
+
+import org.spearce.jgit.util.FS;
+
+/**
+ * Traditional file system based {@link ObjectDatabase}.
+ * <p>
+ * This is the classical object database representation for a Git repository,
+ * where objects are stored loose by hashing them into directories by their
+ * {@link ObjectId}, or are stored in compressed containers known as
+ * {@link PackFile}s.
+ */
+public class ObjectDirectory extends ObjectDatabase {
+	private static final PackFile[] NO_PACKS = {};
+
+	private final File objects;
+
+	private final File infoDirectory;
+
+	private final File packDirectory;
+
+	private final File alternatesFile;
+
+	private final AtomicReference<PackFile[]> packList;
+
+	/**
+	 * Initialize a reference to an on-disk object directory.
+	 * 
+	 * @param dir
+	 *            the location of the <code>objects</code> directory.
+	 */
+	public ObjectDirectory(final File dir) {
+		objects = dir;
+		infoDirectory = new File(objects, "info");
+		packDirectory = new File(objects, "pack");
+		alternatesFile = new File(infoDirectory, "alternates");
+
+		packList = new AtomicReference<PackFile[]>();
+	}
+
+	/**
+	 * @return the location of the <code>objects</code> directory.
+	 */
+	public final File getDirectory() {
+		return objects;
+	}
+
+	@Override
+	public boolean exists() {
+		return objects.exists();
+	}
+
+	@Override
+	public void create() throws IOException {
+		objects.mkdirs();
+		infoDirectory.mkdir();
+		packDirectory.mkdir();
+	}
+
+	@Override
+	public void closeSelf() {
+		PackFile[] packs = packList.get();
+		if (packs != null) {
+			packList.set(null);
+			for (final PackFile p : packs) {
+				p.close();
+			}
+		}
+	}
+
+	/**
+	 * Compute the location of a loose object file.
+	 * 
+	 * @param objectId
+	 *            identity of the loose object to map to the directory.
+	 * @return location of the object, if it were to exist as a loose object.
+	 */
+	public File fileFor(final AnyObjectId objectId) {
+		return fileFor(objectId.name());
+	}
+
+	private File fileFor(final String objectName) {
+		final String d = objectName.substring(0, 2);
+		final String f = objectName.substring(2);
+		return new File(new File(objects, d), f);
+	}
+
+	/**
+	 * Add a single existing pack to the list of available pack files.
+	 * 
+	 * @param pack
+	 *            path of the pack file to open.
+	 * @param idx
+	 *            path of the corresponding index file.
+	 * @throws IOException
+	 *             index file could not be opened, read, or is not recognized as
+	 *             a Git pack file index.
+	 */
+	public void openPack(final File pack, final File idx) throws IOException {
+		final String p = pack.getName();
+		final String i = idx.getName();
+
+		if (p.length() != 50 || !p.startsWith("pack-") || !p.endsWith(".pack"))
+			throw new IOException("Not a valid pack " + pack);
+
+		if (i.length() != 49 || !i.startsWith("pack-") || !i.endsWith(".idx"))
+			throw new IOException("Not a valid pack " + idx);
+
+		if (!p.substring(0, 45).equals(i.substring(0, 45)))
+			throw new IOException("Pack " + pack + "does not match index");
+
+		insertPack(new PackFile(idx, pack));
+	}
+
+	@Override
+	public String toString() {
+		return "ObjectDirectory[" + getDirectory() + "]";
+	}
+
+	@Override
+	protected boolean hasObject1(final AnyObjectId objectId) {
+		for (final PackFile p : packs()) {
+			try {
+				if (p.hasObject(objectId)) {
+					return true;
+				}
+			} catch (IOException e) {
+				// The hasObject call should have only touched the index,
+				// so any failure here indicates the index is unreadable
+				// by this process, and the pack is likewise not readable.
+				//
+				removePack(p);
+				continue;
+			}
+		}
+		return false;
+	}
+
+	@Override
+	protected ObjectLoader openObject1(final WindowCursor curs,
+			final AnyObjectId objectId) throws IOException {
+		for (final PackFile p : packs()) {
+			try {
+				final ObjectLoader ldr = p.get(curs, objectId);
+				if (ldr != null) {
+					return ldr;
+				}
+			} catch (IOException e) {
+				// Assume the pack is corrupted.
+				//
+				removePack(p);
+				continue;
+			}
+		}
+		return null;
+	}
+
+	@Override
+	void openObjectInAllPacks1(final Collection<PackedObjectLoader> out,
+			final WindowCursor curs, final AnyObjectId objectId)
+			throws IOException {
+		for (final PackFile p : packs()) {
+			try {
+				final PackedObjectLoader ldr = p.get(curs, objectId);
+				if (ldr != null) {
+					out.add(ldr);
+				}
+			} catch (IOException e) {
+				// Assume the pack is corrupted.
+				//
+				removePack(p);
+				continue;
+			}
+		}
+	}
+
+	@Override
+	protected boolean hasObject2(final String objectName) {
+		return fileFor(objectName).exists();
+	}
+
+	@Override
+	protected ObjectLoader openObject2(final WindowCursor curs,
+			final String objectName, final AnyObjectId objectId)
+			throws IOException {
+		try {
+			return new UnpackedObjectLoader(fileFor(objectName), objectId);
+		} catch (FileNotFoundException noFile) {
+			return null;
+		}
+	}
+
+	private void insertPack(final PackFile pf) {
+		PackFile[] o, n;
+		do {
+			o = packs();
+			n = new PackFile[1 + o.length];
+			n[0] = pf;
+			System.arraycopy(o, 0, n, 1, o.length);
+		} while (!packList.compareAndSet(o, n));
+	}
+
+	private void removePack(final PackFile deadPack) {
+		PackFile[] o, n;
+		do {
+			o = packList.get();
+			if (o == null || !inList(o, deadPack)) {
+				break;
+
+			} else if (o.length == 1) {
+				n = NO_PACKS;
+
+			} else {
+				n = new PackFile[o.length - 1];
+				int j = 0;
+				for (final PackFile p : o) {
+					if (p != deadPack) {
+						n[j++] = p;
+					}
+				}
+			}
+		} while (!packList.compareAndSet(o, n));
+		deadPack.close();
+	}
+
+	private static boolean inList(final PackFile[] list, final PackFile pack) {
+		for (final PackFile p : list) {
+			if (p == pack) {
+				return true;
+			}
+		}
+		return false;
+	}
+
+	private PackFile[] packs() {
+		PackFile[] r = packList.get();
+		if (r == null) {
+			r = scanPacks(r);
+		}
+		return r;
+	}
+
+	private PackFile[] scanPacks(final PackFile[] original) {
+		synchronized (packList) {
+			PackFile[] o, n;
+			do {
+				o = packList.get();
+				if (o != original) {
+					// Another thread did the scan for us, while we
+					// were blocked on the monitor above.
+					//
+					return o;
+				}
+				n = scanPacksImpl(o != null ? o : NO_PACKS);
+			} while (!packList.compareAndSet(o, n));
+			return n;
+		}
+	}
+
+	private PackFile[] scanPacksImpl(final PackFile[] old) {
+		final Map<String, PackFile> forReuse = reuseMap(old);
+		final String[] idxList = listPackIdx();
+		final List<PackFile> list = new ArrayList<PackFile>(idxList.length);
+		for (final String indexName : idxList) {
+			final String base = indexName.substring(0, indexName.length() - 4);
+			final String packName = base + ".pack";
+
+			final PackFile oldPack = forReuse.remove(packName);
+			if (oldPack != null) {
+				list.add(oldPack);
+				continue;
+			}
+
+			final File packFile = new File(packDirectory, packName);
+			if (!packFile.isFile()) {
+				// Sometimes C Git's HTTP fetch transport leaves a
+				// .idx file behind and does not download the .pack.
+				// We have to skip over such useless indexes.
+				//
+				continue;
+			}
+
+			final File idxFile = new File(packDirectory, indexName);
+			list.add(new PackFile(idxFile, packFile));
+		}
+
+		for (final PackFile p : forReuse.values()) {
+			p.close();
+		}
+
+		if (list.isEmpty()) {
+			return NO_PACKS;
+		}
+		final PackFile[] r = list.toArray(new PackFile[list.size()]);
+		Arrays.sort(r, PackFile.SORT);
+		return r;
+	}
+
+	private static Map<String, PackFile> reuseMap(final PackFile[] old) {
+		final Map<String, PackFile> forReuse = new HashMap<String, PackFile>();
+		for (final PackFile p : old) {
+			final PackFile prior = forReuse.put(p.getPackFile().getName(), p);
+			if (prior != null) {
+				// This should never occur. It should be impossible for us
+				// to have two pack files with the same name, as all of them
+				// came out of the same directory. If it does, we promised to
+				// close any PackFiles we did not reuse, so close the one we
+				// just evicted out of the reuse map.
+				//
+				prior.close();
+			}
+		}
+		return forReuse;
+	}
+
+	private String[] listPackIdx() {
+		final String[] idxList = packDirectory.list(new FilenameFilter() {
+			public boolean accept(final File baseDir, final String n) {
+				// Must match "pack-[0-9a-f]{40}.idx" to be an index.
+				return n.length() == 49 && n.endsWith(".idx")
+						&& n.startsWith("pack-");
+			}
+		});
+		return idxList != null ? idxList : new String[0];
+	}
+
+	@Override
+	protected ObjectDatabase[] loadAlternates() throws IOException {
+		final BufferedReader br = open(alternatesFile);
+		final List<ObjectDirectory> l = new ArrayList<ObjectDirectory>(4);
+		try {
+			String line;
+			while ((line = br.readLine()) != null) {
+				l.add(new ObjectDirectory(FS.resolve(objects, line)));
+			}
+		} finally {
+			br.close();
+		}
+
+		if (l.isEmpty()) {
+			return NO_ALTERNATES;
+		}
+		return l.toArray(new ObjectDirectory[l.size()]);
+	}
+
+	private static BufferedReader open(final File f)
+			throws FileNotFoundException {
+		return new BufferedReader(new FileReader(f));
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index cfd92b8..f7bacf3 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -43,10 +43,8 @@
 import java.io.File;
 import java.io.FileNotFoundException;
 import java.io.FileReader;
-import java.io.FilenameFilter;
 import java.io.IOException;
 import java.util.ArrayList;
-import java.util.Arrays;
 import java.util.Collection;
 import java.util.Collections;
 import java.util.HashMap;
@@ -93,9 +91,7 @@
 
 	private final RefDatabase refs;
 
-	private File[] objectDirectoryList;
-
-	private PackFile[] packFileList;
+	private final ObjectDirectory objectDatabase;
 
 	private GitIndex index;
 
@@ -113,21 +109,11 @@
 	 */
 	public Repository(final File d) throws IOException {
 		gitDir = d.getAbsoluteFile();
-		try {
-			objectDirectoryList = readObjectsDirs(
-					FS.resolve(gitDir, "objects"), new ArrayList<File>())
-					.toArray(new File[0]);
-		} catch (IOException e) {
-			IOException ex = new IOException("Cannot find all object dirs for " + gitDir);
-			ex.initCause(e);
-			throw ex;
-		}
 		refs = new RefDatabase(this);
-		packFileList = new PackFile[0];
+		objectDatabase = new ObjectDirectory(FS.resolve(gitDir, "objects"));
 		config = new RepositoryConfig(this);
 
-		final boolean isExisting = objectDirectoryList[0].exists();
-		if (isExisting) {
+		if (objectDatabase.exists()) {
 			getConfig().load();
 			final String repositoryFormatVersion = getConfig().getString(
 					"core", null, "repositoryFormatVersion");
@@ -138,25 +124,6 @@ public Repository(final File d) throws IOException {
 		} else {
 			getConfig().create();
 		}
-		if (isExisting)
-			scanForPacks();
-	}
-
-	private static Collection<File> readObjectsDirs(File objectsDir,
-			Collection<File> ret) throws IOException {
-		ret.add(objectsDir);
-		final File altFile = FS.resolve(objectsDir, "info/alternates");
-		if (altFile.exists()) {
-			BufferedReader ar = new BufferedReader(new FileReader(altFile));
-			try {
-				for (String alt=ar.readLine(); alt!=null; alt=ar.readLine()) {
-					readObjectsDirs(FS.resolve(objectsDir, alt), ret);
-				}
-			} finally {
-				ar.close();
-			}
-		}
-		return ret;
 	}
 
 	/**
@@ -173,10 +140,7 @@ public synchronized void create() throws IOException {
 
 		gitDir.mkdirs();
 		refs.create();
-
-		objectDirectoryList[0].mkdirs();
-		new File(objectDirectoryList[0], "pack").mkdir();
-		new File(objectDirectoryList[0], "info").mkdir();
+		objectDatabase.create();
 
 		new File(gitDir, "branches").mkdir();
 		new File(gitDir, "remotes").mkdir();
@@ -187,14 +151,6 @@ public synchronized void create() throws IOException {
 		getConfig().save();
 	}
 
-	private synchronized File[] objectsDirs(){
-		return objectDirectoryList;
-	}
-
-	private synchronized PackFile[] packs(){
-		return packFileList;
-	}
-
 	/**
 	 * @return GIT_DIR
 	 */
@@ -206,7 +162,7 @@ public File getDirectory() {
 	 * @return the directory containing the objects owned by this repository.
 	 */
 	public File getObjectsDirectory() {
-		return objectsDirs()[0];
+		return objectDatabase.getDirectory();
 	}
 
 	/**
@@ -227,16 +183,7 @@ public RepositoryConfig getConfig() {
 	 * @return suggested file name
 	 */
 	public File toFile(final AnyObjectId objectId) {
-		final String n = objectId.name();
-		String d=n.substring(0, 2);
-		String f=n.substring(2);
-		final File[] objectsDirs = objectsDirs();
-		for (File objectsDir : objectsDirs) {
-			File ret = new File(new File(objectsDir, d), f);
-			if (ret.exists())
-				return ret;
-		}
-		return new File(new File(objectsDirs[0], d), f);
+		return objectDatabase.fileFor(objectId);
 	}
 
 	/**
@@ -245,20 +192,7 @@ public File toFile(final AnyObjectId objectId) {
 	 *         known shared repositories.
 	 */
 	public boolean hasObject(final AnyObjectId objectId) {
-		final PackFile[] packs = packs();
-		int k = packs.length;
-		while (k > 0) {
-			try {
-				if (packs[--k].hasObject(objectId))
-					return true;
-			} catch (IOException e) {
-				// Assume that means the pack is invalid, and such
-				// packs are treated as though they are empty.
-				//
-				continue;
-			}
-		}
-		return toFile(objectId).isFile();
+		return objectDatabase.hasObject(objectId);
 	}
 
 	/**
@@ -291,18 +225,7 @@ public ObjectLoader openObject(final AnyObjectId id)
 	 */
 	public ObjectLoader openObject(final WindowCursor curs, final AnyObjectId id)
 			throws IOException {
-		final PackFile[] packs = packs();
-		int k = packs.length;
-		while (k > 0) {
-			final ObjectLoader ol = packs[--k].get(curs, id);
-			if (ol != null)
-				return ol;
-		}
-		try {
-			return new UnpackedObjectLoader(this, id);
-		} catch (FileNotFoundException fnfe) {
-			return null;
-		}
+		return objectDatabase.openObject(curs, id);
 	}
 
 	/**
@@ -339,11 +262,7 @@ public ObjectLoader openObject(final WindowCursor curs, final AnyObjectId id)
 	void openObjectInAllPacks(final AnyObjectId objectId,
 			final Collection<PackedObjectLoader> resultLoaders,
 			final WindowCursor curs) throws IOException {
-		for (PackFile pack : packs()) {
-			final PackedObjectLoader loader = pack.get(curs, objectId);
-			if (loader != null)
-				resultLoaders.add(loader);
-		}
+		objectDatabase.openObjectInAllPacks(resultLoaders, curs, objectId);
 	}
 
 	/**
@@ -772,13 +691,7 @@ private ObjectId resolveSimple(final String revstr) throws IOException {
 	 * Close all resources used by this repository
 	 */
 	public void close() {
-		closePacks();
-	}
-
-	synchronized void closePacks() {
-		for (int k = packFileList.length - 1; k >= 0; k--)
-			packFileList[k].close();
-		packFileList = new PackFile[0];
+		objectDatabase.close();
 	}
 
 	/**
@@ -793,72 +706,7 @@ synchronized void closePacks() {
 	 *             a Git pack file index.
 	 */
 	public void openPack(final File pack, final File idx) throws IOException {
-		final String p = pack.getName();
-		final String i = idx.getName();
-		if (p.length() != 50 || !p.startsWith("pack-") || !p.endsWith(".pack"))
-		    throw new IllegalArgumentException("Not a valid pack " + pack);
-		if (i.length() != 49 || !i.startsWith("pack-") || !i.endsWith(".idx"))
-		    throw new IllegalArgumentException("Not a valid pack " + idx);
-		if (!p.substring(0,45).equals(i.substring(0,45)))
-			throw new IllegalArgumentException("Pack " + pack
-					+ "does not match index " + idx);
-
-		synchronized (this) {
-			final PackFile[] cur = packFileList;
-			final PackFile[] arr = new PackFile[cur.length + 1];
-			System.arraycopy(cur, 0, arr, 1, cur.length);
-			arr[0] = new PackFile(idx, pack);
-			packFileList = arr;
-		}
-	}
-
-	/**
-	 * Scan the object dirs, including alternates for packs
-	 * to use.
-	 */
-	public void scanForPacks() {
-		final ArrayList<PackFile> p = new ArrayList<PackFile>();
-		p.addAll(Arrays.asList(packs()));
-		for (final File d : objectsDirs())
-			scanForPacks(new File(d, "pack"), p);
-		final PackFile[] arr = new PackFile[p.size()];
-		p.toArray(arr);
-		Arrays.sort(arr, PackFile.SORT);
-		synchronized (this) {
-			packFileList = arr;
-		}
-	}
-
-	private void scanForPacks(final File packDir, Collection<PackFile> packList) {
-		final String[] idxList = packDir.list(new FilenameFilter() {
-			public boolean accept(final File baseDir, final String n) {
-				// Must match "pack-[0-9a-f]{40}.idx" to be an index.
-				return n.length() == 49 && n.endsWith(".idx")
-						&& n.startsWith("pack-");
-			}
-		});
-		if (idxList != null) {
-			SCAN: for (final String indexName : idxList) {
-				final String n = indexName.substring(0, indexName.length() - 4);
-				final File idxFile = new File(packDir, n + ".idx");
-				final File packFile = new File(packDir, n + ".pack");
-
-				if (!packFile.isFile()) {
-					// Sometimes C Git's http fetch transport leaves a
-					// .idx file behind and does not download the .pack.
-					// We have to skip over such useless indexes.
-					//
-					continue;
-				}
-
-				for (final PackFile p : packList) {
-					if (packFile.equals(p.getPackFile()))
-						continue SCAN;
-				}
-
-				packList.add(new PackFile(idxFile, packFile));
-			}
-		}
+		objectDatabase.openPack(pack, idx);
 	}
 
     /**
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/UnpackedObjectLoader.java b/org.spearce.jgit/src/org/spearce/jgit/lib/UnpackedObjectLoader.java
index b086821..7552b42 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/UnpackedObjectLoader.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/UnpackedObjectLoader.java
@@ -38,6 +38,7 @@
 
 package org.spearce.jgit.lib;
 
+import java.io.File;
 import java.io.FileInputStream;
 import java.io.FileNotFoundException;
 import java.io.IOException;
@@ -60,22 +61,25 @@
 	private final byte[] bytes;
 
 	/**
-	 * Construct an ObjectLoader for the specified SHA-1
+	 * Construct an ObjectLoader to read from the file.
 	 *
-	 * @param db
-	 *            repository
+	 * @param path
+	 *            location of the loose object to read.
 	 * @param id
-	 *            SHA-1
+	 *            expected identity of the object being loaded, if known.
+	 * @throws FileNotFoundException
+	 *             the loose object file does not exist.
 	 * @throws IOException
+	 *             the loose object file exists, but is corrupt.
 	 */
-	public UnpackedObjectLoader(final Repository db, final AnyObjectId id)
+	public UnpackedObjectLoader(final File path, final AnyObjectId id)
 			throws IOException {
-		this(readCompressed(db, id), id);
+		this(readCompressed(path), id);
 	}
 
-	private static byte[] readCompressed(final Repository db,
-			final AnyObjectId id) throws FileNotFoundException, IOException {
-		final FileInputStream in = new FileInputStream(db.toFile(id));
+	private static byte[] readCompressed(final File path)
+			throws FileNotFoundException, IOException {
+		final FileInputStream in = new FileInputStream(path);
 		try {
 			final byte[] compressed = new byte[(int) in.getChannel().size()];
 			NB.readFully(in, compressed, 0, compressed.length);
-- 
1.6.3.rc1.188.ga02b

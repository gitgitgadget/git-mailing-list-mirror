From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 2/3] Don't allow DirCacheEntry with mode of 0
Date: Fri, 11 Sep 2009 12:58:48 -0700
Message-ID: <1252699129-6961-2-git-send-email-spearce@spearce.org>
References: <1252699129-6961-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org, "Shawn O. Pearce" <sop@google.com>,
	"Adam W. Hawks" <awhawks@writeme.com>
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Sep 11 21:59:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmCGp-0001tD-FA
	for gcvg-git-2@lo.gmane.org; Fri, 11 Sep 2009 21:59:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756182AbZIKT6x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2009 15:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756068AbZIKT6w
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Sep 2009 15:58:52 -0400
Received: from george.spearce.org ([209.20.77.23]:53651 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755992AbZIKT6t (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2009 15:58:49 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id A0DFB381FF; Fri, 11 Sep 2009 19:58:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id A36443815E;
	Fri, 11 Sep 2009 19:58:50 +0000 (UTC)
X-Mailer: git-send-email 1.6.5.rc0.164.g5f6b0
In-Reply-To: <1252699129-6961-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128213>

A 0 file mode in a DirCacheEntry is not a valid mode.  To C git
such a value indicates the record should not be present.  We already
were catching this bad state and exceptioning out when writing tree
objects to disk, but we did not fail when writing the dircache back
to disk.  This allowed JGit applications to create a dircache file
which C git would not like to read.

Instead of checking the mode during writes, we now check during
mutation.  This allows application bugs to be detected sooner and
closer to the cause site.  It also allows us to avoid checking most
of the records which we read in from disk, as we can assume these
are formatted correctly.

Some of our unit tests were not setting the FileMode on their test
entry, so they had to be updated to use REGULAR_FILE.

Signed-off-by: Shawn O. Pearce <sop@google.com>
CC: Adam W. Hawks <awhawks@writeme.com>
---
 .../spearce/jgit/dircache/DirCacheBasicTest.java   |    5 ++-
 .../spearce/jgit/dircache/DirCacheBuilderTest.java |   27 +++++++++++++--
 .../spearce/jgit/dircache/DirCacheEntryTest.java   |   37 ++++++++++++++++++++
 .../spearce/jgit/dircache/DirCacheFindTest.java    |    5 ++-
 .../jgit/dircache/DirCacheIteratorTest.java        |    4 ++-
 .../jgit/dircache/DirCacheLargePathTest.java       |    5 +++
 .../spearce/jgit/dircache/DirCacheTreeTest.java    |   13 +++++--
 .../org/spearce/jgit/dircache/DirCacheBuilder.java |    8 +++--
 .../org/spearce/jgit/dircache/DirCacheEditor.java  |   11 ++++--
 .../org/spearce/jgit/dircache/DirCacheEntry.java   |   12 ++++++-
 .../org/spearce/jgit/dircache/DirCacheTree.java    |    4 --
 11 files changed, 111 insertions(+), 20 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheBasicTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheBasicTest.java
index 4d737c0..3b48b11 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheBasicTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheBasicTest.java
@@ -40,6 +40,7 @@
 import java.io.File;
 
 import org.spearce.jgit.lib.Constants;
+import org.spearce.jgit.lib.FileMode;
 import org.spearce.jgit.lib.RepositoryTestCase;
 
 public class DirCacheBasicTest extends RepositoryTestCase {
@@ -170,8 +171,10 @@ public void testBuildThenClear() throws Exception {
 
 		final String[] paths = { "a.", "a.b", "a/b", "a0b" };
 		final DirCacheEntry[] ents = new DirCacheEntry[paths.length];
-		for (int i = 0; i < paths.length; i++)
+		for (int i = 0; i < paths.length; i++) {
 			ents[i] = new DirCacheEntry(paths[i]);
+			ents[i].setFileMode(FileMode.REGULAR_FILE);
+		}
 
 		final DirCacheBuilder b = dc.builder();
 		for (int i = 0; i < ents.length; i++)
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheBuilderTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheBuilderTest.java
index 2cf1d92..f64e4f6 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheBuilderTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheBuilderTest.java
@@ -59,6 +59,20 @@ public void testBuildEmpty() throws Exception {
 		}
 	}
 
+	public void testBuildRejectsUnsetFileMode() throws Exception {
+		final DirCache dc = DirCache.newInCore();
+		final DirCacheBuilder b = dc.builder();
+		assertNotNull(b);
+
+		final DirCacheEntry e = new DirCacheEntry("a");
+		assertEquals(0, e.getRawMode());
+		try {
+			b.add(e);
+		} catch (IllegalArgumentException err) {
+			assertEquals("FileMode not set for path a", err.getMessage());
+		}
+	}
+
 	public void testBuildOneFile_FinishWriteCommit() throws Exception {
 		final String path = "a-file-path";
 		final FileMode mode = FileMode.REGULAR_FILE;
@@ -162,6 +176,7 @@ public void testFindSingleFile() throws Exception {
 		assertNotNull(b);
 
 		final DirCacheEntry entOrig = new DirCacheEntry(path);
+		entOrig.setFileMode(FileMode.REGULAR_FILE);
 		assertNotSame(path, entOrig.getPathString());
 		assertEquals(path, entOrig.getPathString());
 		b.add(entOrig);
@@ -185,8 +200,10 @@ public void testAdd_InGitSortOrder() throws Exception {
 
 		final String[] paths = { "a.", "a.b", "a/b", "a0b" };
 		final DirCacheEntry[] ents = new DirCacheEntry[paths.length];
-		for (int i = 0; i < paths.length; i++)
+		for (int i = 0; i < paths.length; i++) {
 			ents[i] = new DirCacheEntry(paths[i]);
+			ents[i].setFileMode(FileMode.REGULAR_FILE);
+		}
 
 		final DirCacheBuilder b = dc.builder();
 		for (int i = 0; i < ents.length; i++)
@@ -207,8 +224,10 @@ public void testAdd_ReverseGitSortOrder() throws Exception {
 
 		final String[] paths = { "a.", "a.b", "a/b", "a0b" };
 		final DirCacheEntry[] ents = new DirCacheEntry[paths.length];
-		for (int i = 0; i < paths.length; i++)
+		for (int i = 0; i < paths.length; i++) {
 			ents[i] = new DirCacheEntry(paths[i]);
+			ents[i].setFileMode(FileMode.REGULAR_FILE);
+		}
 
 		final DirCacheBuilder b = dc.builder();
 		for (int i = ents.length - 1; i >= 0; i--)
@@ -229,8 +248,10 @@ public void testBuilderClear() throws Exception {
 
 		final String[] paths = { "a.", "a.b", "a/b", "a0b" };
 		final DirCacheEntry[] ents = new DirCacheEntry[paths.length];
-		for (int i = 0; i < paths.length; i++)
+		for (int i = 0; i < paths.length; i++) {
 			ents[i] = new DirCacheEntry(paths[i]);
+			ents[i].setFileMode(FileMode.REGULAR_FILE);
+		}
 		{
 			final DirCacheBuilder b = dc.builder();
 			for (int i = 0; i < ents.length; i++)
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheEntryTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheEntryTest.java
index a6ff5a8..971f201 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheEntryTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheEntryTest.java
@@ -40,6 +40,7 @@
 import junit.framework.TestCase;
 
 import org.spearce.jgit.lib.Constants;
+import org.spearce.jgit.lib.FileMode;
 
 public class DirCacheEntryTest extends TestCase {
 	public void testIsValidPath() {
@@ -112,4 +113,40 @@ public void testCreate_ByStringPathAndStage() {
 			assertEquals("Invalid stage 4 for path a", err.getMessage());
 		}
 	}
+
+	public void testSetFileMode() {
+		final DirCacheEntry e = new DirCacheEntry("a");
+
+		assertEquals(0, e.getRawMode());
+
+		e.setFileMode(FileMode.REGULAR_FILE);
+		assertSame(FileMode.REGULAR_FILE, e.getFileMode());
+		assertEquals(FileMode.REGULAR_FILE.getBits(), e.getRawMode());
+
+		e.setFileMode(FileMode.EXECUTABLE_FILE);
+		assertSame(FileMode.EXECUTABLE_FILE, e.getFileMode());
+		assertEquals(FileMode.EXECUTABLE_FILE.getBits(), e.getRawMode());
+
+		e.setFileMode(FileMode.SYMLINK);
+		assertSame(FileMode.SYMLINK, e.getFileMode());
+		assertEquals(FileMode.SYMLINK.getBits(), e.getRawMode());
+
+		e.setFileMode(FileMode.GITLINK);
+		assertSame(FileMode.GITLINK, e.getFileMode());
+		assertEquals(FileMode.GITLINK.getBits(), e.getRawMode());
+
+		try {
+			e.setFileMode(FileMode.MISSING);
+			fail("incorrectly accepted FileMode.MISSING");
+		} catch (IllegalArgumentException err) {
+			assertEquals("Invalid mode 0 for path a", err.getMessage());
+		}
+
+		try {
+			e.setFileMode(FileMode.TREE);
+			fail("incorrectly accepted FileMode.TREE");
+		} catch (IllegalArgumentException err) {
+			assertEquals("Invalid mode 40000 for path a", err.getMessage());
+		}
+	}
 }
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheFindTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheFindTest.java
index 0eb0302..470c80a 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheFindTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheFindTest.java
@@ -37,6 +37,7 @@
 
 package org.spearce.jgit.dircache;
 
+import org.spearce.jgit.lib.FileMode;
 import org.spearce.jgit.lib.RepositoryTestCase;
 
 public class DirCacheFindTest extends RepositoryTestCase {
@@ -45,8 +46,10 @@ public void testEntriesWithin() throws Exception {
 
 		final String[] paths = { "a.", "a/b", "a/c", "a/d", "a0b" };
 		final DirCacheEntry[] ents = new DirCacheEntry[paths.length];
-		for (int i = 0; i < paths.length; i++)
+		for (int i = 0; i < paths.length; i++) {
 			ents[i] = new DirCacheEntry(paths[i]);
+			ents[i].setFileMode(FileMode.REGULAR_FILE);
+		}
 		final int aFirst = 1;
 		final int aLast = 3;
 
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheIteratorTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheIteratorTest.java
index 047c989..71581dc 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheIteratorTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheIteratorTest.java
@@ -68,8 +68,10 @@ public void testNoSubtree_NoTreeWalk() throws Exception {
 
 		final String[] paths = { "a.", "a0b" };
 		final DirCacheEntry[] ents = new DirCacheEntry[paths.length];
-		for (int i = 0; i < paths.length; i++)
+		for (int i = 0; i < paths.length; i++) {
 			ents[i] = new DirCacheEntry(paths[i]);
+			ents[i].setFileMode(FileMode.REGULAR_FILE);
+		}
 
 		final DirCacheBuilder b = dc.builder();
 		for (int i = 0; i < ents.length; i++)
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheLargePathTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheLargePathTest.java
index 4ea286c..a9945f1 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheLargePathTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheLargePathTest.java
@@ -40,6 +40,7 @@
 import java.io.IOException;
 
 import org.spearce.jgit.errors.CorruptObjectException;
+import org.spearce.jgit.lib.FileMode;
 import org.spearce.jgit.lib.RepositoryTestCase;
 
 public class DirCacheLargePathTest extends RepositoryTestCase {
@@ -70,6 +71,10 @@ private void testLongPath(final int len) throws CorruptObjectException,
 
 		final DirCacheEntry longEnt = new DirCacheEntry(longPath);
 		final DirCacheEntry shortEnt = new DirCacheEntry(shortPath);
+
+		longEnt.setFileMode(FileMode.REGULAR_FILE);
+		shortEnt.setFileMode(FileMode.REGULAR_FILE);
+
 		assertEquals(longPath, longEnt.getPathString());
 		assertEquals(shortPath, shortEnt.getPathString());
 
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheTreeTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheTreeTest.java
index aca0b90..6efa207 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheTreeTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheTreeTest.java
@@ -40,6 +40,7 @@
 import java.io.IOException;
 
 import org.spearce.jgit.errors.CorruptObjectException;
+import org.spearce.jgit.lib.FileMode;
 import org.spearce.jgit.lib.RepositoryTestCase;
 
 public class DirCacheTreeTest extends RepositoryTestCase {
@@ -75,8 +76,10 @@ public void testSingleSubtree() throws Exception {
 
 		final String[] paths = { "a.", "a/b", "a/c", "a/d", "a0b" };
 		final DirCacheEntry[] ents = new DirCacheEntry[paths.length];
-		for (int i = 0; i < paths.length; i++)
+		for (int i = 0; i < paths.length; i++) {
 			ents[i] = new DirCacheEntry(paths[i]);
+			ents[i].setFileMode(FileMode.REGULAR_FILE);
+		}
 		final int aFirst = 1;
 		final int aLast = 3;
 
@@ -110,8 +113,10 @@ public void testTwoLevelSubtree() throws Exception {
 
 		final String[] paths = { "a.", "a/b", "a/c/e", "a/c/f", "a/d", "a0b" };
 		final DirCacheEntry[] ents = new DirCacheEntry[paths.length];
-		for (int i = 0; i < paths.length; i++)
+		for (int i = 0; i < paths.length; i++) {
 			ents[i] = new DirCacheEntry(paths[i]);
+			ents[i].setFileMode(FileMode.REGULAR_FILE);
+		}
 		final int aFirst = 1;
 		final int aLast = 4;
 		final int acFirst = 2;
@@ -167,8 +172,10 @@ public void testWriteReadTree() throws CorruptObjectException, IOException {
 		final String B = String.format("b%2000s", "b");
 		final String[] paths = { A + ".", A + "." + B, A + "/" + B, A + "0" + B };
 		final DirCacheEntry[] ents = new DirCacheEntry[paths.length];
-		for (int i = 0; i < paths.length; i++)
+		for (int i = 0; i < paths.length; i++) {
 			ents[i] = new DirCacheEntry(paths[i]);
+			ents[i].setFileMode(FileMode.REGULAR_FILE);
+		}
 
 		final DirCacheBuilder b = dc.builder();
 		for (int i = 0; i < ents.length; i++)
diff --git a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheBuilder.java b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheBuilder.java
index aee12fb..8acb3d0 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheBuilder.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheBuilder.java
@@ -41,7 +41,6 @@
 import java.util.Arrays;
 
 import org.spearce.jgit.lib.AnyObjectId;
-import org.spearce.jgit.lib.FileMode;
 import org.spearce.jgit.lib.Repository;
 import org.spearce.jgit.lib.WindowCursor;
 import org.spearce.jgit.treewalk.AbstractTreeIterator;
@@ -90,8 +89,13 @@ protected DirCacheBuilder(final DirCache dc, final int ecnt) {
 	 *
 	 * @param newEntry
 	 *            the new entry to add.
+	 * @throws IllegalArgumentException
+	 *             If the FileMode of the entry was not set by the caller.
 	 */
 	public void add(final DirCacheEntry newEntry) {
+		if (newEntry.getRawMode() == 0)
+			throw new IllegalArgumentException("FileMode not set for path "
+					+ newEntry.getPathString());		
 		beforeAdd(newEntry);
 		fastAdd(newEntry);
 	}
@@ -187,8 +191,6 @@ public void finish() {
 	}
 
 	private void beforeAdd(final DirCacheEntry newEntry) {
-		if (FileMode.TREE.equals(newEntry.getRawMode()))
-			throw bad(newEntry, "Adding subtree not allowed");
 		if (sorted && entryCnt > 0) {
 			final DirCacheEntry lastEntry = entries[entryCnt - 1];
 			final int cr = DirCache.cmp(lastEntry, newEntry);
diff --git a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheEditor.java b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheEditor.java
index 10b554e..6eaceb7 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheEditor.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheEditor.java
@@ -138,11 +138,16 @@ private void applyEdits() {
 			}
 
 			final DirCacheEntry ent;
-			if (missing)
+			if (missing) {
 				ent = new DirCacheEntry(e.path);
-			else
+				e.apply(ent);
+				if (ent.getRawMode() == 0)
+					throw new IllegalArgumentException("FileMode not set"
+							+ " for path " + ent.getPathString());							
+			} else {
 				ent = cache.getEntry(eIdx);
-			e.apply(ent);
+				e.apply(ent);
+			}
 			fastAdd(ent);
 		}
 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheEntry.java b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheEntry.java
index d7abd6e..872ef33 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheEntry.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheEntry.java
@@ -377,11 +377,21 @@ public FileMode getFileMode() {
 
 	/**
 	 * Set the file mode for this entry.
-	 *
+	 * 
 	 * @param mode
 	 *            the new mode constant.
+	 * @throws IllegalArgumentException
+	 *             If {@code mode} is {@link FileMode#MISSING},
+	 *             {@link FileMode#TREE}, or any other type code not permitted
+	 *             in a tree object.
 	 */
 	public void setFileMode(final FileMode mode) {
+		switch (mode.getBits() & FileMode.TYPE_MASK) {
+		case FileMode.TYPE_MISSING:
+		case FileMode.TYPE_TREE:
+			throw new IllegalArgumentException("Invalid mode " + mode
+					+ " for path " + getPathString());
+		}
 		NB.encodeInt32(info, infoOffset + P_MODE, mode.getBits());
 	}
 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheTree.java b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheTree.java
index 79e95cb..2f2a5ed 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheTree.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheTree.java
@@ -376,10 +376,6 @@ private int computeSize(final DirCacheEntry[] cache, int cIdx,
 			}
 
 			final FileMode mode = e.getFileMode();
-			if (mode.getObjectType() == Constants.OBJ_BAD)
-				throw new IllegalStateException("Entry \"" + e.getPathString()
-						+ "\" has incorrect mode set up.");
-
 			size += mode.copyToLength();
 			size += ep.length - pathOffset;
 			size += OBJECT_ID_LENGTH + 2;
-- 
1.6.5.rc0.164.g5f6b0

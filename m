From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [EGIT PATCH 12/26] Support recreating a .git/index through DirCache
Date: Mon, 11 Aug 2008 18:07:59 -0700
Message-ID: <1218503293-14057-13-git-send-email-spearce@spearce.org>
References: <1218503293-14057-1-git-send-email-spearce@spearce.org>
 <1218503293-14057-2-git-send-email-spearce@spearce.org>
 <1218503293-14057-3-git-send-email-spearce@spearce.org>
 <1218503293-14057-4-git-send-email-spearce@spearce.org>
 <1218503293-14057-5-git-send-email-spearce@spearce.org>
 <1218503293-14057-6-git-send-email-spearce@spearce.org>
 <1218503293-14057-7-git-send-email-spearce@spearce.org>
 <1218503293-14057-8-git-send-email-spearce@spearce.org>
 <1218503293-14057-9-git-send-email-spearce@spearce.org>
 <1218503293-14057-10-git-send-email-spearce@spearce.org>
 <1218503293-14057-11-git-send-email-spearce@spearce.org>
 <1218503293-14057-12-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Aug 12 03:11:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSiPU-0006OQ-BX
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 03:10:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751677AbYHLBIo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 21:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751654AbYHLBIo
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 21:08:44 -0400
Received: from george.spearce.org ([209.20.77.23]:38592 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751040AbYHLBIX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 21:08:23 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 66D9B38395; Tue, 12 Aug 2008 01:08:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id DAF3E3837A;
	Tue, 12 Aug 2008 01:08:16 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.rc2.22.g71b99
In-Reply-To: <1218503293-14057-12-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92043>

The DirCacheBuilder is meant for building up a new DirCache content
by iterating through the paths in proper Git sort order.  This is
mostly useful during a TreeWalk, where the paths are being fed to
the application in the correct sort ordering.  Appending them into
the new entry table in order avoids sorting costs later on when we
try to write the file back to disk.

The API is designed for speed, not ease-of-use.  Performing updates
in order and by copying large ranges of the existing index into the
new index is incredibly fast, but requires the application to work
harder to construct the right sequence of calls.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../spearce/jgit/dircache/BaseDirCacheEditor.java  |  194 ++++++++++++++++++++
 .../src/org/spearce/jgit/dircache/DirCache.java    |   23 +++
 .../org/spearce/jgit/dircache/DirCacheBuilder.java |  173 +++++++++++++++++
 3 files changed, 390 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/dircache/BaseDirCacheEditor.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheBuilder.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/dircache/BaseDirCacheEditor.java b/org.spearce.jgit/src/org/spearce/jgit/dircache/BaseDirCacheEditor.java
new file mode 100644
index 0000000..268c01e
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/dircache/BaseDirCacheEditor.java
@@ -0,0 +1,194 @@
+/*
+ * Copyright (C) 2008, Shawn O. Pearce <spearce@spearce.org>
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
+package org.spearce.jgit.dircache;
+
+import java.io.IOException;
+
+/**
+ * Generic update/editing support for {@link DirCache}.
+ * <p>
+ * The different update strategies extend this class to provide their own unique
+ * services to applications.
+ */
+abstract class BaseDirCacheEditor {
+	/** The cache instance this editor updates during {@link #finish()}. */
+	protected DirCache cache;
+
+	/**
+	 * Entry table this builder will eventually replace into {@link #cache}.
+	 * <p>
+	 * Use {@link #fastAdd(DirCacheEntry)} or {@link #fastKeep(int, int)} to
+	 * make additions to this table. The table is automatically expanded if it
+	 * is too small for a new addition.
+	 * <p>
+	 * Typically the entries in here are sorted by their path names, just like
+	 * they are in the DirCache instance.
+	 */
+	protected DirCacheEntry[] entries;
+
+	/** Total number of valid entries in {@link #entries}. */
+	protected int entryCnt;
+
+	/**
+	 * Construct a new editor.
+	 * 
+	 * @param dc
+	 *            the cache this editor will eventually update.
+	 * @param ecnt
+	 *            estimated number of entries the editor will have upon
+	 *            completion. This sizes the initial entry table.
+	 */
+	protected BaseDirCacheEditor(final DirCache dc, final int ecnt) {
+		cache = dc;
+		entries = new DirCacheEntry[ecnt];
+	}
+
+	/**
+	 * @return the cache we will update on {@link #finish()}.
+	 */
+	public DirCache getDirCache() {
+		return cache;
+	}
+
+	/**
+	 * Append one entry into the resulting entry list.
+	 * <p>
+	 * The entry is placed at the end of the entry list. The caller is
+	 * responsible for making sure the final table is correctly sorted.
+	 * <p>
+	 * The {@link #entries} table is automatically expanded if there is
+	 * insufficient space for the new addition.
+	 * 
+	 * @param newEntry
+	 *            the new entry to add.
+	 */
+	protected void fastAdd(final DirCacheEntry newEntry) {
+		if (entries.length == entryCnt) {
+			final DirCacheEntry[] n = new DirCacheEntry[(entryCnt + 16) * 3 / 2];
+			System.arraycopy(entries, 0, n, 0, entryCnt);
+			entries = n;
+		}
+		entries[entryCnt++] = newEntry;
+	}
+
+	/**
+	 * Add a range of existing entries from the destination cache.
+	 * <p>
+	 * The entries are placed at the end of the entry list, preserving their
+	 * current order. The caller is responsible for making sure the final table
+	 * is correctly sorted.
+	 * <p>
+	 * This method copies from the destination cache, which has not yet been
+	 * updated with this editor's new table. So all offsets into the destination
+	 * cache are not affected by any updates that may be currently taking place
+	 * in this editor.
+	 * <p>
+	 * The {@link #entries} table is automatically expanded if there is
+	 * insufficient space for the new additions.
+	 * 
+	 * @param pos
+	 *            first entry to copy from the destination cache.
+	 * @param cnt
+	 *            number of entries to copy.
+	 */
+	protected void fastKeep(final int pos, int cnt) {
+		if (entryCnt + cnt > entries.length) {
+			final int m1 = (entryCnt + 16) * 3 / 2;
+			final int m2 = entryCnt + cnt;
+			final DirCacheEntry[] n = new DirCacheEntry[Math.max(m1, m2)];
+			System.arraycopy(entries, 0, n, 0, entryCnt);
+			entries = n;
+		}
+
+		cache.toArray(pos, entries, entryCnt, cnt);
+		entryCnt += cnt;
+	}
+
+	/**
+	 * Finish this builder and update the destination {@link DirCache}.
+	 * <p>
+	 * When this method completes this builder instance is no longer usable by
+	 * the calling application. A new builder must be created to make additional
+	 * changes to the index entries.
+	 * <p>
+	 * After completion the DirCache returned by {@link #getDirCache()} will
+	 * contain all modifications.
+	 * <p>
+	 * <i>Note to implementors:</i> Make sure {@link #entries} is fully sorted
+	 * then invoke {@link #replace()} to update the DirCache with the new table.
+	 */
+	public abstract void finish();
+
+	/**
+	 * Update the DirCache with the contents of {@link #entries}.
+	 * <p>
+	 * This method should be invoked only during an implementation of
+	 * {@link #finish()}, and only after {@link #entries} is sorted.
+	 */
+	protected void replace() {
+		if (entryCnt < entries.length / 2) {
+			final DirCacheEntry[] n = new DirCacheEntry[entryCnt];
+			System.arraycopy(entries, 0, n, 0, entryCnt);
+			entries = n;
+		}
+		cache.replace(entries, entryCnt);
+	}
+
+	/**
+	 * Finish, write, commit this change, and release the index lock.
+	 * <p>
+	 * If this method fails (returns false) the lock is still released.
+	 * <p>
+	 * This is a utility method for applications as the finish-write-commit
+	 * pattern is very common after using a builder to update entries.
+	 * 
+	 * @return true if the commit was successful and the file contains the new
+	 *         data; false if the commit failed and the file remains with the
+	 *         old data.
+	 * @throws IllegalStateException
+	 *             the lock is not held.
+	 * @throws IOException
+	 *             the output file could not be created. The caller no longer
+	 *             holds the lock.
+	 */
+	public boolean commit() throws IOException {
+		finish();
+		cache.write();
+		return cache.commit();
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCache.java b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCache.java
index b5fdd46..810b479 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCache.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCache.java
@@ -236,6 +236,24 @@ public class DirCache {
 	}
 
 	/**
+	 * Create a new builder to update this cache.
+	 * <p>
+	 * Callers should add all entries to the builder, then use
+	 * {@link DirCacheBuilder#finish()} to update this instance.
+	 * 
+	 * @return a new builder instance for this cache.
+	 */
+	public DirCacheBuilder builder() {
+		return new DirCacheBuilder(this, entryCnt + 16);
+	}
+
+	void replace(final DirCacheEntry[] e, final int cnt) {
+		sortedEntries = e;
+		entryCnt = cnt;
+		tree = null;
+	}
+
+	/**
 	 * Read the index from disk, if it has changed on disk.
 	 * <p>
 	 * This method tries to avoid loading the index if it has not changed since
@@ -591,6 +609,11 @@ public class DirCache {
 		return i < 0 ? null : sortedEntries[i];
 	}
 
+	void toArray(final int i, final DirCacheEntry[] dst, final int off,
+			final int cnt) {
+		System.arraycopy(sortedEntries, i, dst, off, cnt);
+	}
+
 	/**
 	 * Obtain (or build) the current cache tree structure.
 	 * <p>
diff --git a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheBuilder.java b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheBuilder.java
new file mode 100644
index 0000000..e303b43
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheBuilder.java
@@ -0,0 +1,173 @@
+/*
+ * Copyright (C) 2008, Shawn O. Pearce <spearce@spearce.org>
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
+package org.spearce.jgit.dircache;
+
+import java.util.Arrays;
+
+/**
+ * Updates a {@link DirCache} by adding individual {@link DirCacheEntry}s.
+ * <p>
+ * A builder always starts from a clean slate and appends in every single
+ * <code>DirCacheEntry</code> which the final updated index must have to reflect
+ * its new content.
+ * <p>
+ * For maximum performance applications should add entries in path name order.
+ * Adding entries out of order is permitted, however a final sorting pass will
+ * be implicitly performed during {@link #finish()} to correct any out-of-order
+ * entries. Duplicate detection is also delayed until the sorting is complete.
+ */
+public class DirCacheBuilder extends BaseDirCacheEditor {
+	private boolean sorted;
+
+	/**
+	 * Construct a new builder.
+	 * 
+	 * @param dc
+	 *            the cache this builder will eventually update.
+	 * @param ecnt
+	 *            estimated number of entries the builder will have upon
+	 *            completion. This sizes the initial entry table.
+	 */
+	protected DirCacheBuilder(final DirCache dc, final int ecnt) {
+		super(dc, ecnt);
+	}
+
+	/**
+	 * Append one entry into the resulting entry list.
+	 * <p>
+	 * The entry is placed at the end of the entry list. If the entry causes the
+	 * list to now be incorrectly sorted a final sorting phase will be
+	 * automatically enabled within {@link #finish()}.
+	 * <p>
+	 * The internal entry table is automatically expanded if there is
+	 * insufficient space for the new addition.
+	 * 
+	 * @param newEntry
+	 *            the new entry to add.
+	 */
+	public void add(final DirCacheEntry newEntry) {
+		beforeAdd(newEntry);
+		fastAdd(newEntry);
+	}
+
+	/**
+	 * Add a range of existing entries from the destination cache.
+	 * <p>
+	 * The entries are placed at the end of the entry list. If any of the
+	 * entries causes the list to now be incorrectly sorted a final sorting
+	 * phase will be automatically enabled within {@link #finish()}.
+	 * <p>
+	 * This method copies from the destination cache, which has not yet been
+	 * updated with this editor's new table. So all offsets into the destination
+	 * cache are not affected by any updates that may be currently taking place
+	 * in this editor.
+	 * <p>
+	 * The internal entry table is automatically expanded if there is
+	 * insufficient space for the new additions.
+	 * 
+	 * @param pos
+	 *            first entry to copy from the destination cache.
+	 * @param cnt
+	 *            number of entries to copy.
+	 */
+	public void keep(final int pos, int cnt) {
+		beforeAdd(cache.getEntry(pos));
+		fastKeep(pos, cnt);
+	}
+
+	public void finish() {
+		if (!sorted)
+			resort();
+		replace();
+	}
+
+	private void beforeAdd(final DirCacheEntry newEntry) {
+		if (sorted && entryCnt > 0) {
+			final DirCacheEntry lastEntry = entries[entryCnt - 1];
+			final int cr = DirCache.cmp(lastEntry, newEntry);
+			if (cr > 0) {
+				// The new entry sorts before the old entry; we are
+				// no longer sorted correctly. We'll need to redo
+				// the sorting before we can close out the build.
+				//
+				sorted = false;
+			} else if (cr == 0) {
+				// Same file path; we can only insert this if the
+				// stages won't be violated.
+				//
+				final int peStage = lastEntry.getStage();
+				final int dceStage = newEntry.getStage();
+				if (peStage == dceStage)
+					throw bad(newEntry, "Duplicate stages not allowed");
+				if (peStage == 0 || dceStage == 0)
+					throw bad(newEntry, "Mixed stages not allowed");
+				if (peStage > dceStage)
+					sorted = false;
+			}
+		}
+	}
+
+	private void resort() {
+		Arrays.sort(entries, 0, entryCnt, DirCache.ENT_CMP);
+
+		for (int entryIdx = 1; entryIdx < entryCnt; entryIdx++) {
+			final DirCacheEntry pe = entries[entryIdx - 1];
+			final DirCacheEntry ce = entries[entryIdx];
+			final int cr = DirCache.cmp(pe, ce);
+			if (cr == 0) {
+				// Same file path; we can only allow this if the stages
+				// are 1-3 and no 0 exists.
+				//
+				final int peStage = pe.getStage();
+				final int ceStage = ce.getStage();
+				if (peStage == ceStage)
+					throw bad(ce, "Duplicate stages not allowed");
+				if (peStage == 0 || ceStage == 0)
+					throw bad(ce, "Mixed stages not allowed");
+			}
+		}
+
+		sorted = true;
+	}
+
+	private static IllegalStateException bad(final DirCacheEntry a,
+			final String msg) {
+		return new IllegalStateException(msg + ": " + a.getStage() + " "
+				+ a.getPathString());
+	}
+}
-- 
1.6.0.rc2.22.g71b99

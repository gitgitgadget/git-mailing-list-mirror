From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [EGIT PATCH 15/26] Support a simplified model of editing index entries
Date: Mon, 11 Aug 2008 18:08:02 -0700
Message-ID: <1218503293-14057-16-git-send-email-spearce@spearce.org>
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
 <1218503293-14057-13-git-send-email-spearce@spearce.org>
 <1218503293-14057-14-git-send-email-spearce@spearce.org>
 <1218503293-14057-15-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Aug 12 03:11:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSiPY-0006OQ-B8
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 03:10:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510AbYHLBI4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 21:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbYHLBIz
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 21:08:55 -0400
Received: from george.spearce.org ([209.20.77.23]:38601 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750975AbYHLBIY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 21:08:24 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id E67CC3838F; Tue, 12 Aug 2008 01:08:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 9B38D38394;
	Tue, 12 Aug 2008 01:08:17 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.rc2.22.g71b99
In-Reply-To: <1218503293-14057-15-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92053>

Some applications may find using DirCacheBuilder difficult and/or just
impossible, as it requires inserting entries in order to have any sort
of good performance.

DirCacheEditor tries to bridge that gap by allowing applications to
insert edit commands out-of-order, then merge-sorts those edits onto
the index entry list from the DirCache.  Since the edit list is likely
to be shorter than the index entry list sorting the edit list and doing
a merge-sort onto the index entry list allows for large range copies in
the regions that are not modified.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/dircache/DirCache.java    |   22 ++
 .../org/spearce/jgit/dircache/DirCacheBuilder.java |    2 +
 .../org/spearce/jgit/dircache/DirCacheEditor.java  |  265 ++++++++++++++++++++
 3 files changed, 289 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheEditor.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCache.java b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCache.java
index 810b479..e48fdec 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCache.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCache.java
@@ -247,6 +247,18 @@ public class DirCache {
 		return new DirCacheBuilder(this, entryCnt + 16);
 	}
 
+	/**
+	 * Create a new editor to recreate this cache.
+	 * <p>
+	 * Callers should add commands to the editor, then use
+	 * {@link DirCacheEditor#finish()} to update this instance.
+	 * 
+	 * @return a new builder instance for this cache.
+	 */
+	public DirCacheEditor editor() {
+		return new DirCacheEditor(this, entryCnt + 16);
+	}
+
 	void replace(final DirCacheEntry[] e, final int cnt) {
 		sortedEntries = e;
 		entryCnt = cnt;
@@ -569,6 +581,16 @@ public class DirCache {
 		return nextIdx;
 	}
 
+	int nextEntry(final byte[] p, final int pLen, int nextIdx) {
+		while (nextIdx < entryCnt) {
+			final DirCacheEntry next = sortedEntries[nextIdx];
+			if (!DirCacheTree.peq(p, next.path, pLen))
+				break;
+			nextIdx++;
+		}
+		return nextIdx;
+	}
+
 	/**
 	 * Total number of file entries stored in the index.
 	 * <p>
diff --git a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheBuilder.java b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheBuilder.java
index e303b43..b1d0a1d 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheBuilder.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheBuilder.java
@@ -50,6 +50,8 @@ import java.util.Arrays;
  * Adding entries out of order is permitted, however a final sorting pass will
  * be implicitly performed during {@link #finish()} to correct any out-of-order
  * entries. Duplicate detection is also delayed until the sorting is complete.
+ * 
+ * @see DirCacheEditor
  */
 public class DirCacheBuilder extends BaseDirCacheEditor {
 	private boolean sorted;
diff --git a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheEditor.java b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheEditor.java
new file mode 100644
index 0000000..e371d9e
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheEditor.java
@@ -0,0 +1,265 @@
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
+import java.util.ArrayList;
+import java.util.Collections;
+import java.util.Comparator;
+import java.util.List;
+
+import org.spearce.jgit.lib.Constants;
+
+/**
+ * Updates a {@link DirCache} by supplying discrete edit commands.
+ * <p>
+ * An editor updates a DirCache by taking a list of {@link PathEdit} commands
+ * and executing them against the entries of the destination cache to produce a
+ * new cache. This edit style allows applications to insert a few commands and
+ * then have the editor compute the proper entry indexes necessary to perform an
+ * efficient in-order update of the index records. This can be easier to use
+ * than {@link DirCacheBuilder}.
+ * <p>
+ * 
+ * @see DirCacheBuilder
+ */
+public class DirCacheEditor extends BaseDirCacheEditor {
+	private static final Comparator<PathEdit> EDIT_CMP = new Comparator<PathEdit>() {
+		public int compare(final PathEdit o1, final PathEdit o2) {
+			final byte[] a = o1.path;
+			final byte[] b = o2.path;
+			return DirCache.cmp(a, a.length, b, b.length);
+		}
+	};
+
+	private final List<PathEdit> edits;
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
+	protected DirCacheEditor(final DirCache dc, final int ecnt) {
+		super(dc, ecnt);
+		edits = new ArrayList<PathEdit>();
+	}
+
+	/**
+	 * Append one edit command to the list of commands to be applied.
+	 * <p>
+	 * Edit commands may be added in any order chosen by the application. They
+	 * are automatically rearranged by the builder to provide the most efficient
+	 * update possible.
+	 * 
+	 * @param edit
+	 *            another edit command.
+	 */
+	public void add(final PathEdit edit) {
+		edits.add(edit);
+	}
+
+	@Override
+	public boolean commit() throws IOException {
+		if (edits.isEmpty()) {
+			// No changes? Don't rewrite the index.
+			//
+			cache.unlock();
+			return true;
+		}
+		return super.commit();
+	}
+
+	public void finish() {
+		if (!edits.isEmpty()) {
+			applyEdits();
+			replace();
+		}
+	}
+
+	private void applyEdits() {
+		Collections.sort(edits, EDIT_CMP);
+
+		final int maxIdx = cache.getEntryCount();
+		int lastIdx = 0;
+		for (final PathEdit e : edits) {
+			int eIdx = cache.findEntry(e.path, e.path.length);
+			final boolean missing = eIdx < 0;
+			if (eIdx < 0)
+				eIdx = -(eIdx + 1);
+			final int cnt = Math.min(eIdx, maxIdx) - lastIdx;
+			if (cnt > 0)
+				fastKeep(lastIdx, cnt);
+			lastIdx = missing ? eIdx : cache.nextEntry(eIdx);
+
+			if (e instanceof DeletePath)
+				continue;
+			if (e instanceof DeleteTree) {
+				lastIdx = cache.nextEntry(e.path, e.path.length, eIdx);
+				continue;
+			}
+
+			final DirCacheEntry ent;
+			if (missing)
+				ent = new DirCacheEntry(e.path);
+			else
+				ent = cache.getEntry(eIdx);
+			e.apply(ent);
+			fastAdd(ent);
+		}
+
+		final int cnt = maxIdx - lastIdx;
+		if (cnt > 0)
+			fastKeep(lastIdx, cnt);
+	}
+
+	/**
+	 * Any index record update.
+	 * <p>
+	 * Applications should subclass and provide their own implementation for the
+	 * {@link #apply(DirCacheEntry)} method. The editor will invoke apply once
+	 * for each record in the index which matches the path name. If there are
+	 * multiple records (for example in stages 1, 2 and 3), the edit instance
+	 * will be called multiple times, once for each stage.
+	 */
+	public abstract static class PathEdit {
+		final byte[] path;
+
+		/**
+		 * Create a new update command by path name.
+		 * 
+		 * @param entryPath
+		 *            path of the file within the repository.
+		 */
+		public PathEdit(final String entryPath) {
+			path = Constants.encode(entryPath);
+		}
+
+		/**
+		 * Create a new update command for an existing entry instance.
+		 * 
+		 * @param ent
+		 *            entry instance to match path of. Only the path of this
+		 *            entry is actually considered during command evaluation.
+		 */
+		public PathEdit(final DirCacheEntry ent) {
+			path = ent.path;
+		}
+
+		/**
+		 * Apply the update to a single cache entry matching the path.
+		 * <p>
+		 * After apply is invoked the entry is added to the output table, and
+		 * will be included in the new index.
+		 * 
+		 * @param ent
+		 *            the entry being processed. All fields are zeroed out if
+		 *            the path is a new path in the index.
+		 */
+		public abstract void apply(DirCacheEntry ent);
+	}
+
+	/**
+	 * Deletes a single file entry from the index.
+	 * <p>
+	 * This deletion command removes only a single file at the given location,
+	 * but removes multiple stages (if present) for that path. To remove a
+	 * complete subtree use {@link DeleteTree} instead.
+	 * 
+	 * @see DeleteTree
+	 */
+	public static final class DeletePath extends PathEdit {
+		/**
+		 * Create a new deletion command by path name.
+		 * 
+		 * @param entryPath
+		 *            path of the file within the repository.
+		 */
+		public DeletePath(final String entryPath) {
+			super(entryPath);
+		}
+
+		/**
+		 * Create a new deletion command for an existing entry instance.
+		 * 
+		 * @param ent
+		 *            entry instance to remove. Only the path of this entry is
+		 *            actually considered during command evaluation.
+		 */
+		public DeletePath(final DirCacheEntry ent) {
+			super(ent);
+		}
+
+		public void apply(final DirCacheEntry ent) {
+			throw new UnsupportedOperationException("No apply in delete");
+		}
+	}
+
+	/**
+	 * Recursively deletes all paths under a subtree.
+	 * <p>
+	 * This deletion command is more generic than {@link DeletePath} as it can
+	 * remove all records which appear recursively under the same subtree.
+	 * Multiple stages are removed (if present) for any deleted entry.
+	 * <p>
+	 * This command will not remove a single file entry. To remove a single file
+	 * use {@link DeletePath}.
+	 * 
+	 * @see DeletePath
+	 */
+	public static final class DeleteTree extends PathEdit {
+		/**
+		 * Create a new tree deletion command by path name.
+		 * 
+		 * @param entryPath
+		 *            path of the subtree within the repository. If the path
+		 *            does not end with "/" a "/" is implicitly added to ensure
+		 *            only the subtree's contents are matched by the command.
+		 */
+		public DeleteTree(final String entryPath) {
+			super(entryPath.endsWith("/") ? entryPath : entryPath + "/");
+		}
+
+		public void apply(final DirCacheEntry ent) {
+			throw new UnsupportedOperationException("No apply in delete");
+		}
+	}
+}
-- 
1.6.0.rc2.22.g71b99

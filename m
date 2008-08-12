From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [EGIT PATCH 11/26] Support using a DirCache within a TreeWalk
Date: Mon, 11 Aug 2008 18:07:58 -0700
Message-ID: <1218503293-14057-12-git-send-email-spearce@spearce.org>
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
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Aug 12 03:11:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSiPT-0006OQ-LH
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 03:10:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751636AbYHLBIm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 21:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751565AbYHLBIk
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 21:08:40 -0400
Received: from george.spearce.org ([209.20.77.23]:38589 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750977AbYHLBIW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 21:08:22 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 82ABC38430; Tue, 12 Aug 2008 01:08:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 9E7903838B;
	Tue, 12 Aug 2008 01:08:16 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.rc2.22.g71b99
In-Reply-To: <1218503293-14057-11-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92052>

Being able to include the .git/index file as part of a parallel TreeWalk
which also covers one or more canonical tree objects from the database
and the working directory makes it much easier to handle differences or
merges between the various states.

This iterator implementation adapts a loaded DirCache instance into a
tree structure that the TreeWalk can iterate.  Since TreeWalk wants to
use a hierarchical structure and the DirCache is flat we force the TREE
extension to load (or generate) and work off that.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../spearce/jgit/dircache/DirCacheIterator.java    |  205 ++++++++++++++++++++
 1 files changed, 205 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheIterator.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheIterator.java b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheIterator.java
new file mode 100644
index 0000000..f7ef15d
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheIterator.java
@@ -0,0 +1,205 @@
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
+import java.util.Arrays;
+
+import org.spearce.jgit.errors.CorruptObjectException;
+import org.spearce.jgit.errors.IncorrectObjectTypeException;
+import org.spearce.jgit.lib.Constants;
+import org.spearce.jgit.lib.FileMode;
+import org.spearce.jgit.lib.Repository;
+import org.spearce.jgit.treewalk.AbstractTreeIterator;
+
+/**
+ * Iterate a {@link DirCache} as part of a <code>TreeWalk</code>.
+ * <p>
+ * This is an iterator to adapt a loaded <code>DirCache</code> instance (such as
+ * read from an existing <code>.git/index</code> file) to the tree structure
+ * used by a <code>TreeWalk</code>, making it possible for applications to walk
+ * over any combination of tree objects already in the object database, index
+ * files, or working directories.
+ * 
+ * @see org.spearce.jgit.treewalk.TreeWalk
+ */
+public class DirCacheIterator extends AbstractTreeIterator {
+	/** The cache this iterator was created to walk. */
+	protected final DirCache cache;
+
+	/** The tree this iterator is walking. */
+	private final DirCacheTree tree;
+
+	/** Special buffer to hold the ObjectId of {@link #currentSubtree}. */
+	private final byte[] subtreeId;
+
+	/** Index of entry within {@link #cache}. */
+	protected int cachePos;
+
+	/** Position of entry within {@link #tree}'s entry span. */
+	private int treePos;
+
+	/** Next subtree to consider within {@link #tree}. */
+	private int subtreeIdx;
+
+	/** The current file entry from {@link #cache}, matching {@link #cachePos}. */
+	protected DirCacheEntry currentEntry;
+
+	/** The subtree containing {@link #currentEntry} if this is first entry. */
+	protected DirCacheTree currentSubtree;
+
+	/**
+	 * Create a new iterator for an already loaded DirCache instance.
+	 * <p>
+	 * The iterator implementation may copy part of the cache's data during
+	 * construction, so the cache must be read in prior to creating the
+	 * iterator.
+	 * 
+	 * @param dc
+	 *            the cache to walk. It must be already loaded into memory.
+	 */
+	public DirCacheIterator(final DirCache dc) {
+		cache = dc;
+		tree = dc.getCacheTree(true);
+		subtreeId = new byte[Constants.OBJECT_ID_LENGTH];
+		cachePos = -1;
+		treePos = -1;
+	}
+
+	protected DirCacheIterator(final DirCacheIterator p, final DirCacheTree dct) {
+		super(p, p.path, p.pathLen + 1);
+		cache = p.cache;
+		tree = dct;
+		subtreeId = p.subtreeId;
+		cachePos = p.cachePos - 1; // back up so first next() call enters it
+		treePos = -1;
+	}
+
+	@Override
+	public AbstractTreeIterator createSubtreeIterator(final Repository repo)
+			throws IncorrectObjectTypeException, IOException {
+		if (currentSubtree == null)
+			throw new IncorrectObjectTypeException(getEntryObjectId(),
+					Constants.TYPE_TREE);
+		return new DirCacheIterator(this, currentSubtree);
+	}
+
+	@Override
+	public byte[] idBuffer() {
+		if (currentSubtree != null)
+			return subtreeId;
+		if (currentEntry != null)
+			return currentEntry.idBuffer();
+		return zeroid;
+	}
+
+	@Override
+	public int idOffset() {
+		if (currentSubtree != null)
+			return 0;
+		if (currentEntry != null)
+			return currentEntry.idOffset();
+		return 0;
+	}
+
+	@Override
+	public boolean eof() {
+		return treePos >= tree.getEntrySpan();
+	}
+
+	@Override
+	public void next() throws CorruptObjectException {
+		if (currentSubtree != null) {
+			// If our last position was a subtree we need to skip over
+			// its entire span to get to the item after the subtree.
+			//
+			final int n = currentSubtree.getEntrySpan();
+			cachePos += n;
+			treePos += n;
+			currentSubtree = null;
+		} else {
+			// Our last position was a file/symlink/gitlink, so we
+			// only skip the one entry.
+			//
+			cachePos++;
+			treePos++;
+		}
+
+		if (treePos >= tree.getEntrySpan())
+			return; // this iterator is now at EOF.
+
+		currentEntry = cache.getEntry(cachePos);
+		final byte[] cep = currentEntry.path;
+		if (subtreeIdx < tree.getChildCount()) {
+			final DirCacheTree s = tree.getChild(subtreeIdx);
+			if (s.contains(cep, pathOffset, cep.length)) {
+				// The current position is the first file of this subtree.
+				// Use the subtree instead as the current position.
+				//
+				currentSubtree = s;
+				subtreeIdx++;
+
+				if (s.isValid())
+					s.getObjectId().copyRawTo(subtreeId, 0);
+				else
+					Arrays.fill(subtreeId, (byte) 0);
+				mode = FileMode.TREE.getBits();
+				path = cep;
+				pathLen = pathOffset + s.nameLength();
+				return;
+			}
+		}
+
+		// The current position is a file/symlink/gitlink so we
+		// do not have a subtree located here.
+		//
+		mode = currentEntry.getRawMode();
+		path = cep;
+		pathLen = cep.length;
+	}
+
+	/**
+	 * Get the DirCacheEntry for the current file.
+	 * 
+	 * @return the current cache entry, if this iterator is positioned on a
+	 *         non-tree.
+	 */
+	public DirCacheEntry getDirCacheEntry() {
+		return currentSubtree == null ? currentEntry : null;
+	}
+}
-- 
1.6.0.rc2.22.g71b99

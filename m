From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [EGIT PATCH 13/26] Support iterating and building a DirCache at the same time
Date: Mon, 11 Aug 2008 18:08:00 -0700
Message-ID: <1218503293-14057-14-git-send-email-spearce@spearce.org>
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
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Aug 12 03:11:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSiPZ-0006OQ-75
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 03:10:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751772AbYHLBI6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 21:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbYHLBI5
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 21:08:57 -0400
Received: from george.spearce.org ([209.20.77.23]:38595 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750988AbYHLBIX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 21:08:23 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id DF12738389; Tue, 12 Aug 2008 01:08:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 2675D3838F;
	Tue, 12 Aug 2008 01:08:17 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.rc2.22.g71b99
In-Reply-To: <1218503293-14057-13-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92048>

This iterator combines the DirCacheBuilder add-in-order update strategy
with a suitable TreeWalk iterator, allowing entries which the TreeWalk
does not return to the application to be automatically carried into the
new index, and the application to handle the entires which the TreeWalk
does return to it.

This can be used to implement a simple "rm" function which removes one
or more paths from the index, while leaving the rest of the index alone.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../jgit/dircache/DirCacheBuildIterator.java       |  124 ++++++++++++++++++++
 1 files changed, 124 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheBuildIterator.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheBuildIterator.java b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheBuildIterator.java
new file mode 100644
index 0000000..ca934ec
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheBuildIterator.java
@@ -0,0 +1,124 @@
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
+import org.spearce.jgit.errors.CorruptObjectException;
+import org.spearce.jgit.errors.IncorrectObjectTypeException;
+import org.spearce.jgit.lib.Constants;
+import org.spearce.jgit.lib.Repository;
+import org.spearce.jgit.treewalk.AbstractTreeIterator;
+
+/**
+ * Iterate and update a {@link DirCache} as part of a <code>TreeWalk</code>.
+ * <p>
+ * Like {@link DirCacheIterator} this iterator allows a DirCache to be used in
+ * parallel with other sorts of iterators in a TreeWalk. However any entry which
+ * appears in the source DirCache and which is skipped by the TreeFilter is
+ * automatically copied into {@link DirCacheBuilder}, thus retaining it in the
+ * newly updated index.
+ * <p>
+ * This iterator is suitable for update processes, or even a simple delete
+ * algorithm. For example deleting a path:
+ * 
+ * <pre>
+ * final DirCache dirc = DirCache.lock(db);
+ * final DirCacheBuilder edit = dirc.builder();
+ * 
+ * final TreeWalk walk = new TreeWalk(db);
+ * walk.reset();
+ * walk.setRecursive(true);
+ * walk.setFilter(PathFilter.create(&quot;name/to/remove&quot;));
+ * walk.addTree(new DirCacheBuildIterator(edit));
+ * 
+ * while (walk.next())
+ * 	; // do nothing on a match as we want to remove matches
+ * edit.commit();
+ * </pre>
+ */
+public class DirCacheBuildIterator extends DirCacheIterator {
+	private final DirCacheBuilder builder;
+
+	/**
+	 * Create a new iterator for an already loaded DirCache instance.
+	 * <p>
+	 * The iterator implementation may copy part of the cache's data during
+	 * construction, so the cache must be read in prior to creating the
+	 * iterator.
+	 * 
+	 * @param dcb
+	 *            the cache builder for the cache to walk. The cache must be
+	 *            already loaded into memory.
+	 */
+	public DirCacheBuildIterator(final DirCacheBuilder dcb) {
+		super(dcb.getDirCache());
+		builder = dcb;
+	}
+
+	protected DirCacheBuildIterator(final DirCacheBuildIterator p,
+			final DirCacheTree dct) {
+		super(p, dct);
+		builder = p.builder;
+	}
+
+	@Override
+	public AbstractTreeIterator createSubtreeIterator(final Repository repo)
+			throws IncorrectObjectTypeException, IOException {
+		if (currentSubtree == null)
+			throw new IncorrectObjectTypeException(getEntryObjectId(),
+					Constants.TYPE_TREE);
+		return new DirCacheBuildIterator(this, currentSubtree);
+	}
+
+	@Override
+	public void skip() throws CorruptObjectException {
+		if (currentSubtree != null)
+			builder.keep(cachePos, currentSubtree.getEntrySpan());
+		else
+			builder.add(currentEntry);
+		next();
+	}
+
+	@Override
+	public void stopWalk() {
+		final int cnt = cache.getEntryCount();
+		if (cachePos < cnt)
+			builder.keep(cachePos, cnt - cachePos);
+	}
+}
-- 
1.6.0.rc2.22.g71b99

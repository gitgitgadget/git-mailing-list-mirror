From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 07/10] Recursively load an entire tree into a DirCacheBuilder
Date: Thu, 22 Jan 2009 15:28:07 -0800
Message-ID: <1232666890-23488-8-git-send-email-spearce@spearce.org>
References: <1232666890-23488-1-git-send-email-spearce@spearce.org>
 <1232666890-23488-2-git-send-email-spearce@spearce.org>
 <1232666890-23488-3-git-send-email-spearce@spearce.org>
 <1232666890-23488-4-git-send-email-spearce@spearce.org>
 <1232666890-23488-5-git-send-email-spearce@spearce.org>
 <1232666890-23488-6-git-send-email-spearce@spearce.org>
 <1232666890-23488-7-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 00:30:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQ90N-0008Aq-Bc
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 00:30:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755081AbZAVX2c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 18:28:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758488AbZAVX22
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 18:28:28 -0500
Received: from george.spearce.org ([209.20.77.23]:55235 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753502AbZAVX2Q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 18:28:16 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 7697E38215; Thu, 22 Jan 2009 23:28:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id B9B323821F;
	Thu, 22 Jan 2009 23:28:13 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.399.g0d272
In-Reply-To: <1232666890-23488-7-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106799>

This implements the DirCache portion of "git read-tree", where a
tree can be recursively read into a DirCache instance without an
impact on the working directory.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../org/spearce/jgit/dircache/DirCacheBuilder.java |   65 ++++++++++++++++++++
 1 files changed, 65 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheBuilder.java b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheBuilder.java
index 3a37054..10161fa 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheBuilder.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheBuilder.java
@@ -37,8 +37,16 @@
 
 package org.spearce.jgit.dircache;
 
+import java.io.IOException;
 import java.util.Arrays;
 
+import org.spearce.jgit.lib.AnyObjectId;
+import org.spearce.jgit.lib.Repository;
+import org.spearce.jgit.lib.WindowCursor;
+import org.spearce.jgit.treewalk.AbstractTreeIterator;
+import org.spearce.jgit.treewalk.CanonicalTreeParser;
+import org.spearce.jgit.treewalk.TreeWalk;
+
 /**
  * Updates a {@link DirCache} by adding individual {@link DirCacheEntry}s.
  * <p>
@@ -112,6 +120,63 @@ public void keep(final int pos, int cnt) {
 		fastKeep(pos, cnt);
 	}
 
+	/**
+	 * Recursively add an entire tree into this builder.
+	 * <p>
+	 * If pathPrefix is "a/b" and the tree contains file "c" then the resulting
+	 * DirCacheEntry will have the path "a/b/c".
+	 * <p>
+	 * All entries are inserted at stage 0, therefore assuming that the
+	 * application will not insert any other paths with the same pathPrefix.
+	 * 
+	 * @param pathPrefix
+	 *            UTF-8 encoded prefix to mount the tree's entries at. If the
+	 *            path does not end with '/' one will be automatically inserted
+	 *            as necessary.
+	 * @param db
+	 *            repository the tree(s) will be read from during recursive
+	 *            traversal. This must be the same repository that the resulting
+	 *            DirCache would be written out to (or used in) otherwise the
+	 *            caller is simply asking for deferred MissingObjectExceptions.
+	 * @param tree
+	 *            the tree to recursively add. This tree's contents will appear
+	 *            under <code>pathPrefix</code>. The ObjectId must be that of a
+	 *            tree; the caller is responsible for dereferencing a tag or
+	 *            commit (if necessary).
+	 * @throws IOException
+	 *             a tree cannot be read to iterate through its entries.
+	 */
+	public void addTree(final byte[] pathPrefix, final Repository db,
+			final AnyObjectId tree) throws IOException {
+		final TreeWalk tw = new TreeWalk(db);
+		tw.reset();
+		final WindowCursor curs = new WindowCursor();
+		try {
+			tw.addTree(new CanonicalTreeParser(pathPrefix, db, tree
+					.toObjectId(), curs));
+		} finally {
+			curs.release();
+		}
+		tw.setRecursive(true);
+		if (tw.next()) {
+			final DirCacheEntry newEntry = toEntry(tw);
+			beforeAdd(newEntry);
+			fastAdd(newEntry);
+			while (tw.next())
+				fastAdd(toEntry(tw));
+		}
+	}
+
+	private DirCacheEntry toEntry(final TreeWalk tw) {
+		final DirCacheEntry e = new DirCacheEntry(tw.getRawPath());
+		final AbstractTreeIterator i;
+
+		i = tw.getTree(0, AbstractTreeIterator.class);
+		e.setFileMode(tw.getFileMode(0));
+		e.setObjectIdFromRaw(i.idBuffer(), i.idOffset());
+		return e;
+	}
+
 	public void finish() {
 		if (!sorted)
 			resort();
-- 
1.6.1.399.g0d272

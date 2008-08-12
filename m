From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [EGIT PATCH 22/26] Add a basic command line implementation of rm
Date: Mon, 11 Aug 2008 18:08:09 -0700
Message-ID: <1218503293-14057-23-git-send-email-spearce@spearce.org>
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
 <1218503293-14057-16-git-send-email-spearce@spearce.org>
 <1218503293-14057-17-git-send-email-spearce@spearce.org>
 <1218503293-14057-18-git-send-email-spearce@spearce.org>
 <1218503293-14057-19-git-send-email-spearce@spearce.org>
 <1218503293-14057-20-git-send-email-spearce@spearce.org>
 <1218503293-14057-21-git-send-email-spearce@spearce.org>
 <1218503293-14057-22-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Aug 12 03:11:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSiPd-0006OQ-HV
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 03:11:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752237AbYHLBJ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 21:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752159AbYHLBJ0
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 21:09:26 -0400
Received: from george.spearce.org ([209.20.77.23]:38622 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751608AbYHLBIl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 21:08:41 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 9F5C538430; Tue, 12 Aug 2008 01:08:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 3516338391;
	Tue, 12 Aug 2008 01:08:20 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.rc2.22.g71b99
In-Reply-To: <1218503293-14057-22-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92050>

Removing entries from the index and from the working directory is a
very trivial operation now that we have DirCacheBuilder able to do
an update of the index, automatically keeping the paths that were
skipped over by the TreeWalk.  Therefore we only need to match the
paths the user wants to remove, and do nothing with them.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../services/org.spearce.jgit.pgm.TextBuiltin      |    1 +
 .../src/org/spearce/jgit/pgm/Rm.java               |   92 ++++++++++++++++++++
 2 files changed, 93 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Rm.java

diff --git a/org.spearce.jgit.pgm/src/META-INF/services/org.spearce.jgit.pgm.TextBuiltin b/org.spearce.jgit.pgm/src/META-INF/services/org.spearce.jgit.pgm.TextBuiltin
index 8ff815a..39ae664 100644
--- a/org.spearce.jgit.pgm/src/META-INF/services/org.spearce.jgit.pgm.TextBuiltin
+++ b/org.spearce.jgit.pgm/src/META-INF/services/org.spearce.jgit.pgm.TextBuiltin
@@ -9,6 +9,7 @@ org.spearce.jgit.pgm.LsTree
 org.spearce.jgit.pgm.MergeBase
 org.spearce.jgit.pgm.Push
 org.spearce.jgit.pgm.RevList
+org.spearce.jgit.pgm.Rm
 org.spearce.jgit.pgm.ShowRev
 org.spearce.jgit.pgm.Tag
 
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Rm.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Rm.java
new file mode 100644
index 0000000..9a0d863
--- /dev/null
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Rm.java
@@ -0,0 +1,92 @@
+/*
+ * Copyright (C) 2008, Google Inc.
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
+package org.spearce.jgit.pgm;
+
+import java.io.File;
+
+import org.kohsuke.args4j.Argument;
+import org.kohsuke.args4j.Option;
+import org.kohsuke.args4j.spi.StopOptionHandler;
+import org.spearce.jgit.dircache.DirCache;
+import org.spearce.jgit.dircache.DirCacheBuildIterator;
+import org.spearce.jgit.dircache.DirCacheBuilder;
+import org.spearce.jgit.lib.Constants;
+import org.spearce.jgit.lib.FileMode;
+import org.spearce.jgit.pgm.opt.PathTreeFilterHandler;
+import org.spearce.jgit.treewalk.TreeWalk;
+import org.spearce.jgit.treewalk.filter.TreeFilter;
+
+@Command(usage = "Stop tracking a file", common = true)
+class Rm extends TextBuiltin {
+	@Argument(metaVar = "path", usage = "path", multiValued = true, required = true, handler = PathTreeFilterHandler.class)
+	@Option(name = "--", handler = StopOptionHandler.class)
+	private TreeFilter paths;
+
+	private File root;
+
+	@Override
+	protected void run() throws Exception {
+		root = db.getWorkDir();
+
+		final DirCache dirc = DirCache.lock(db);
+		final DirCacheBuilder edit = dirc.builder();
+
+		final TreeWalk walk = new TreeWalk(db);
+		walk.reset(); // drop the first empty tree, which we do not need here
+		walk.setRecursive(true);
+		walk.setFilter(paths);
+		walk.addTree(new DirCacheBuildIterator(edit));
+
+		while (walk.next()) {
+			final File path = new File(root, walk.getPathString());
+			final FileMode mode = walk.getFileMode(0);
+			if (mode.getObjectType() == Constants.OBJ_BLOB) {
+				// Deleting a blob is simply a matter of removing
+				// the file or symlink named by the tree entry.
+				delete(path);
+			}
+		}
+
+		edit.commit();
+	}
+
+	private void delete(File p) {
+		while (p != null && !p.equals(root) && p.delete())
+			p = p.getParentFile();
+	}
+}
-- 
1.6.0.rc2.22.g71b99

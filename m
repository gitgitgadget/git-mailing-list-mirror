From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [JGIT PATCH 5/5] Add the "jgit diff" command
Date: Thu, 3 Sep 2009 12:47:08 +0200 (CEST)
Message-ID: <258665cf172892785f4b72496f033b7cc18b8a2f.1251974493u.git.johannes.schindelin@gmx.de>
References: <alpine.DEB.1.00.0909030846230.8306@pacific.mpi-cbg.de> <cover.1251974493u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, spearce@spearce.org
X-From: git-owner@vger.kernel.org Thu Sep 03 12:47:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mj9qh-0008C4-Sd
	for gcvg-git-2@lo.gmane.org; Thu, 03 Sep 2009 12:47:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754338AbZICKrK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2009 06:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754214AbZICKrJ
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Sep 2009 06:47:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:34696 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754191AbZICKrI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2009 06:47:08 -0400
Received: (qmail invoked by alias); 03 Sep 2009 10:47:09 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp023) with SMTP; 03 Sep 2009 12:47:09 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/fCNFxMGTfnB+FmnRwdxUX6YdTu3H1t/RbjWDyws
	oeFhXS30wElytP
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <cover.1251974493u.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.43
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127649>

This commit contains fixes provided by Christian Halstrick.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .../services/org.spearce.jgit.pgm.TextBuiltin      |    1 +
 .../src/org/spearce/jgit/pgm/Diff.java             |  133 ++++++++++++++++++++
 .../src/org/spearce/jgit/diff/DiffFormatter.java   |    2 +-
 3 files changed, 135 insertions(+), 1 deletions(-)
 create mode 100644 org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Diff.java

diff --git a/org.spearce.jgit.pgm/src/META-INF/services/org.spearce.jgit.pgm.TextBuiltin b/org.spearce.jgit.pgm/src/META-INF/services/org.spearce.jgit.pgm.TextBuiltin
index 3a8cc09..107ef38 100644
--- a/org.spearce.jgit.pgm/src/META-INF/services/org.spearce.jgit.pgm.TextBuiltin
+++ b/org.spearce.jgit.pgm/src/META-INF/services/org.spearce.jgit.pgm.TextBuiltin
@@ -1,6 +1,7 @@
 org.spearce.jgit.pgm.Branch
 org.spearce.jgit.pgm.Clone
 org.spearce.jgit.pgm.Daemon
+org.spearce.jgit.pgm.Diff
 org.spearce.jgit.pgm.DiffTree
 org.spearce.jgit.pgm.Fetch
 org.spearce.jgit.pgm.Glog
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Diff.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Diff.java
new file mode 100644
index 0000000..56e352d
--- /dev/null
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Diff.java
@@ -0,0 +1,133 @@
+/*
+ * Copyright (C) 2009, Johannes E. Schindelin
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
+import java.io.IOException;
+import java.io.PrintStream;
+
+import java.util.ArrayList;
+import java.util.List;
+
+import org.kohsuke.args4j.Argument;
+import org.kohsuke.args4j.ExampleMode;
+import org.kohsuke.args4j.Option;
+
+import org.spearce.jgit.diff.DiffFormatter;
+import org.spearce.jgit.diff.MyersDiff;
+import org.spearce.jgit.diff.RawText;
+
+import org.spearce.jgit.lib.Constants;
+import org.spearce.jgit.lib.FileMode;
+import org.spearce.jgit.lib.ObjectId;
+import org.spearce.jgit.lib.Ref;
+
+import org.spearce.jgit.pgm.opt.CmdLineParser;
+import org.spearce.jgit.pgm.opt.PathTreeFilterHandler;
+
+import org.spearce.jgit.treewalk.AbstractTreeIterator;
+import org.spearce.jgit.treewalk.TreeWalk;
+
+import org.spearce.jgit.treewalk.filter.AndTreeFilter;
+import org.spearce.jgit.treewalk.filter.TreeFilter;
+
+@Command(common = true, usage = "Show diffs")
+class Diff extends TextBuiltin {
+	@Argument(index = 0, metaVar = "tree-ish", required = true)
+	void tree_0(final AbstractTreeIterator c) {
+		trees.add(c);
+	}
+
+	@Argument(index = 1, metaVar = "tree-ish", required = true)
+	private final List<AbstractTreeIterator> trees = new ArrayList<AbstractTreeIterator>();
+
+	@Option(name = "--", metaVar = "path", multiValued = true, handler = PathTreeFilterHandler.class)
+	private TreeFilter pathFilter = TreeFilter.ALL;
+
+	private DiffFormatter fmt = new DiffFormatter();
+
+	@Override
+	protected void run() throws Exception {
+		final TreeWalk walk = new TreeWalk(db);
+		walk.reset();
+		walk.setRecursive(true);
+		for (final AbstractTreeIterator i : trees)
+			walk.addTree(i);
+		walk.setFilter(AndTreeFilter.create(TreeFilter.ANY_DIFF, pathFilter));
+
+		final int nTree = walk.getTreeCount();
+		while (walk.next())
+			outputDiff(System.out, walk.getPathString(),
+				walk.getObjectId(0), walk.getFileMode(0),
+				walk.getObjectId(1), walk.getFileMode(1));
+	}
+
+	protected void outputDiff(PrintStream out, String path,
+			ObjectId id1, FileMode mode1, ObjectId id2, FileMode mode2) throws IOException {
+		String name1 = "a/" + path;
+		String name2 =  "b/" + path;
+		out.println("diff --git " + name1 + " " + name2);
+		boolean isNew=false;
+		boolean isDelete=false;
+		if (id1.equals(id1.zeroId())) {
+			out.println("new file mode " + mode2);
+			isNew=true;
+		} else if (id2.equals(id2.zeroId())) {
+			out.println("deleted file mode " + mode1);
+			isDelete=true;
+		} else if (!mode1.equals(mode2)) {
+			out.println("old mode " + mode1);
+			out.println("new mode " + mode2);
+		}
+		out.println("index " + id1.abbreviate(db, 7).name()
+			+ ".." + id2.abbreviate(db, 7).name()
+			+ (mode1.equals(mode2) ? " " + mode1 : ""));
+		out.println("--- " + (isNew ?  "/dev/null" : name1));
+		out.println("+++ " + (isDelete ?  "/dev/null" : name2));
+		RawText a = getRawText(id1);
+		RawText b = getRawText(id2);
+		MyersDiff diff = new MyersDiff(a, b);
+		fmt.formatEdits(out, a, b, diff.getEdits());
+	}
+
+	private RawText getRawText(ObjectId id) throws IOException {
+		if (id.equals(id.zeroId()))
+			return new RawText(new byte[] { });
+		return new RawText(db.openBlob(id).getCachedBytes());
+	}
+}
+
diff --git a/org.spearce.jgit/src/org/spearce/jgit/diff/DiffFormatter.java b/org.spearce.jgit/src/org/spearce/jgit/diff/DiffFormatter.java
index fa86737..fda3f4c 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/diff/DiffFormatter.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/diff/DiffFormatter.java
@@ -108,7 +108,7 @@ public void format(final OutputStream out, final FileHeader head,
 		formatEdits(out, a, b, head.toEditList());
 	}
 
-	private void formatEdits(final OutputStream out, final RawText a,
+	public void formatEdits(final OutputStream out, final RawText a,
 			final RawText b, final EditList edits) throws IOException {
 		for (int curIdx = 0; curIdx < edits.size();) {
 			Edit curEdit = edits.get(curIdx);
-- 
1.6.4.297.gcb4cc

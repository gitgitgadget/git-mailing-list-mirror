From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 18/28] Convert diff-tree program to args4j
Date: Thu, 17 Jul 2008 21:44:11 -0400
Message-ID: <1216345461-59382-19-git-send-email-spearce@spearce.org>
References: <1216345461-59382-1-git-send-email-spearce@spearce.org>
 <1216345461-59382-2-git-send-email-spearce@spearce.org>
 <1216345461-59382-3-git-send-email-spearce@spearce.org>
 <1216345461-59382-4-git-send-email-spearce@spearce.org>
 <1216345461-59382-5-git-send-email-spearce@spearce.org>
 <1216345461-59382-6-git-send-email-spearce@spearce.org>
 <1216345461-59382-7-git-send-email-spearce@spearce.org>
 <1216345461-59382-8-git-send-email-spearce@spearce.org>
 <1216345461-59382-9-git-send-email-spearce@spearce.org>
 <1216345461-59382-10-git-send-email-spearce@spearce.org>
 <1216345461-59382-11-git-send-email-spearce@spearce.org>
 <1216345461-59382-12-git-send-email-spearce@spearce.org>
 <1216345461-59382-13-git-send-email-spearce@spearce.org>
 <1216345461-59382-14-git-send-email-spearce@spearce.org>
 <1216345461-59382-15-git-send-email-spearce@spearce.org>
 <1216345461-59382-16-git-send-email-spearce@spearce.org>
 <1216345461-59382-17-git-send-email-spearce@spearce.org>
 <1216345461-59382-18-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 03:47:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJf4G-0006LD-V8
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 03:47:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758981AbYGRBpl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 21:45:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758915AbYGRBpi
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 21:45:38 -0400
Received: from george.spearce.org ([209.20.77.23]:47012 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758316AbYGRBot (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 21:44:49 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id C62D438577; Fri, 18 Jul 2008 01:44:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 278E73844E;
	Fri, 18 Jul 2008 01:44:30 +0000 (UTC)
X-Mailer: git-send-email 1.5.6.3.569.ga9185
In-Reply-To: <1216345461-59382-18-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88975>

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/pgm/DiffTree.java         |   57 ++++++++------------
 1 files changed, 23 insertions(+), 34 deletions(-)

diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/DiffTree.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/DiffTree.java
index 17858ba..b3f6738 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/DiffTree.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/DiffTree.java
@@ -40,50 +40,39 @@ package org.spearce.jgit.pgm;
 import java.util.ArrayList;
 import java.util.List;
 
+import org.kohsuke.args4j.Argument;
+import org.kohsuke.args4j.Option;
 import org.spearce.jgit.lib.FileMode;
+import org.spearce.jgit.pgm.opt.PathTreeFilterHandler;
+import org.spearce.jgit.treewalk.AbstractTreeIterator;
 import org.spearce.jgit.treewalk.TreeWalk;
 import org.spearce.jgit.treewalk.filter.AndTreeFilter;
-import org.spearce.jgit.treewalk.filter.OrTreeFilter;
-import org.spearce.jgit.treewalk.filter.PathFilter;
 import org.spearce.jgit.treewalk.filter.TreeFilter;
 
 class DiffTree extends TextBuiltin {
+	@Option(name = "--recursive", usage = "recurse into subtrees", aliases = { "-r" })
+	private boolean recursive;
+
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
 	@Override
-	public void execute(String[] args) throws Exception {
+	protected void run() throws Exception {
 		final TreeWalk walk = new TreeWalk(db);
-		final List<String> argList = new ArrayList<String>();
-		List<TreeFilter> pathLimiter = null;
-		for (final String a : args) {
-			if (pathLimiter != null)
-				pathLimiter.add(PathFilter.create(a));
-			else if ("--".equals(a))
-				pathLimiter = new ArrayList<TreeFilter>();
-			else if ("-r".equals(a))
-				walk.setRecursive(true);
-			else
-				argList.add(a);
-		}
-
-		final TreeFilter pathFilter;
-		if (pathLimiter == null || pathLimiter.isEmpty())
-			pathFilter = TreeFilter.ALL;
-		else if (pathLimiter.size() == 1)
-			pathFilter = pathLimiter.get(0);
-		else
-			pathFilter = OrTreeFilter.create(pathLimiter);
+		walk.reset();
+		walk.setRecursive(recursive);
+		for (final AbstractTreeIterator i : trees)
+			walk.addTree(i);
 		walk.setFilter(AndTreeFilter.create(TreeFilter.ANY_DIFF, pathFilter));
 
-		if (argList.size() == 0)
-			argList.add("HEAD");
-		if (argList.size() == 1) {
-			final String a = argList.get(0);
-			argList.clear();
-			argList.add(a + "^^{tree}");
-			argList.add(a + "^{tree}");
-		}
-		for (final String a : argList)
-			walk.addTree(resolve(a));
-
 		final int nTree = walk.getTreeCount();
 		while (walk.next()) {
 			for (int i = 1; i < nTree; i++)
-- 
1.5.6.3.569.ga9185

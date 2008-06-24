From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [JGIT PATCH 4/4] LsTree: Enable pattern matching in LsTree
Date: Tue, 24 Jun 2008 23:36:32 +0200
Message-ID: <1214343392-5341-5-git-send-email-robin.rosenberg@dewire.com>
References: <20080622233525.GJ11793@spearce.org>
 <1214343392-5341-1-git-send-email-robin.rosenberg@dewire.com>
 <1214343392-5341-2-git-send-email-robin.rosenberg@dewire.com>
 <1214343392-5341-3-git-send-email-robin.rosenberg@dewire.com>
 <1214343392-5341-4-git-send-email-robin.rosenberg@dewire.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Marek Zawirski <marek.zawirski@gmail.com>,
	Florian Koeberle <florianskarten@web.de>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 25 00:51:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBHM7-0008Lh-IB
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 00:51:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754196AbYFXWuG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 18:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752897AbYFXWuE
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 18:50:04 -0400
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:55702 "EHLO
	pne-smtpout1-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752993AbYFXWt7 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Jun 2008 18:49:59 -0400
Received: from localhost.localdomain (213.67.100.250) by pne-smtpout1-sn2.hy.skanova.net (7.3.129)
        id 483EBD680054AA46; Tue, 24 Jun 2008 23:40:31 +0200
X-Mailer: git-send-email 1.5.5.1.178.g1f811
In-Reply-To: <1214343392-5341-4-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86171>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../src/org/spearce/jgit/pgm/LsTree.java           |   19 +++++++++++++------
 .../jgit/treewalk/filter/WildCardTreeFilter.java   |    2 +-
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/pgm/LsTree.java b/org.spearce.jgit/src/org/spearce/jgit/pgm/LsTree.java
index 05ec8c3..6bb4192 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/pgm/LsTree.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/pgm/LsTree.java
@@ -43,8 +43,11 @@ import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.FileMode;
 import org.spearce.jgit.treewalk.FileTreeIterator;
 import org.spearce.jgit.treewalk.TreeWalk;
+import org.spearce.jgit.treewalk.filter.TreeFilter;
+import org.spearce.jgit.treewalk.filter.WildCardTreeFilter;
 
 class LsTree extends TextBuiltin {
+
 	@Override
 	void execute(final String[] args) throws Exception {
 		final TreeWalk walk = new TreeWalk(db);
@@ -60,18 +63,22 @@ class LsTree extends TextBuiltin {
 				break;
 		}
 
-		if (argi == args.length)
-			throw die("usage: [-r] treename");
-		else if (argi + 1 < args.length)
-			throw die("too many arguments");
-
 		walk.reset(); // drop the first empty tree, which we do not need here
-		final String n = args[argi];
+		final String n = args[argi++];
 		if (is_WorkDir(n))
 			walk.addTree(new FileTreeIterator(new File(n)));
 		else
 			walk.addTree(resolve(n));
 
+		if (argi == args.length - 1) {
+			TreeFilter filter = WildCardTreeFilter.create(args[argi++]);
+			walk.setFilter(filter);
+		}
+		if (argi + 1 == args.length)
+			throw die("usage: [-r] treename [pattern]");
+		else if (argi + 1 < args.length)
+			throw die("too many arguments");
+
 		while (walk.next()) {
 			final FileMode mode = walk.getFileMode(0);
 			if (mode == FileMode.TREE)
diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/filter/WildCardTreeFilter.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/filter/WildCardTreeFilter.java
index ce6da5e..8b22e25 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/treewalk/filter/WildCardTreeFilter.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/filter/WildCardTreeFilter.java
@@ -76,7 +76,7 @@ public class WildCardTreeFilter extends TreeFilter {
 		if (walker.isRecursive() && walker.isSubtree())
 			return true;
 		matcher.reset();
-		matcher.append(walker.getPathString());
+		matcher.append(walker.getName());
 		if (matcher.isMatch())
 			return true;
 		return false;
-- 
1.5.5.1.178.g1f811

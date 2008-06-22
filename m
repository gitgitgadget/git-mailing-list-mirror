From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [PATCH 2/2] LsTree: Enable pattern matching in LsTree
Date: Mon, 23 Jun 2008 01:25:45 +0200
Message-ID: <1214177145-18963-2-git-send-email-robin.rosenberg@dewire.com>
References: <1214177145-18963-1-git-send-email-robin.rosenberg@dewire.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Marek Zawirski <marek.zawirski@gmail.com>,
	Florian Koeberle <florianskarten@web.de>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 23 01:30:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAZ13-0005Kj-MI
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 01:30:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755978AbYFVX3l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jun 2008 19:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755785AbYFVX3l
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jun 2008 19:29:41 -0400
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:37394 "EHLO
	pne-smtpout1-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753886AbYFVX3j (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Jun 2008 19:29:39 -0400
Received: from localhost.localdomain (213.67.100.250) by pne-smtpout1-sn1.fre.skanova.net (7.3.129)
        id 47A979500284CF06; Mon, 23 Jun 2008 01:29:37 +0200
X-Mailer: git-send-email 1.5.5.1.178.g1f811
In-Reply-To: <1214177145-18963-1-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85816>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../src/org/spearce/jgit/pgm/LsTree.java           |   19 +++++++++++++------
 1 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/pgm/LsTree.java b/org.spearce.jgit/src/org/spearce/jgit/pgm/LsTree.java
index c242bd7..2cda485 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/pgm/LsTree.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/pgm/LsTree.java
@@ -41,10 +41,13 @@ import java.io.File;
 
 import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.FileMode;
+import org.spearce.jgit.revwalk.filter.WildCardTreeFilter;
 import org.spearce.jgit.treewalk.FileTreeIterator;
 import org.spearce.jgit.treewalk.TreeWalk;
+import org.spearce.jgit.treewalk.filter.TreeFilter;
 
 class LsTree extends TextBuiltin {
+
 	@Override
 	void execute(final String[] args) throws Exception {
 		final TreeWalk walk = new TreeWalk(db);
@@ -60,17 +63,21 @@ class LsTree extends TextBuiltin {
 				break;
 		}
 
-		if (argi == args.length)
-			throw die("usage: [-r] treename");
-		else if (argi + 1 < args.length)
-			throw die("too many arguments");
-
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
 			final FileMode mode = walk.getFileMode(1);
 			if (mode == FileMode.TREE)
-- 
1.5.5.1.178.g1f811

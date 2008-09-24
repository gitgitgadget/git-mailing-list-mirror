From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 2/3] Add create support to the branch command
Date: Wed, 24 Sep 2008 23:56:22 +0200
Message-ID: <1222293383-26016-2-git-send-email-robin.rosenberg@dewire.com>
References: <1222293383-26016-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Sep 24 23:59:26 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KicO9-0000DW-O6
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 23:59:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752095AbYIXV5l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 17:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752114AbYIXV5k
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 17:57:40 -0400
Received: from av8-2-sn3.vrr.skanova.net ([81.228.9.184]:34421 "EHLO
	av8-2-sn3.vrr.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752061AbYIXV5h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 17:57:37 -0400
Received: by av8-2-sn3.vrr.skanova.net (Postfix, from userid 502)
	id 159E9390A5; Wed, 24 Sep 2008 23:57:24 +0200 (CEST)
Received: from smtp3-1-sn3.vrr.skanova.net (smtp3-1-sn3.vrr.skanova.net [81.228.9.101])
	by av8-2-sn3.vrr.skanova.net (Postfix) with ESMTP
	id CA70638B23; Wed, 24 Sep 2008 23:57:23 +0200 (CEST)
Received: from localhost.localdomain (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp3-1-sn3.vrr.skanova.net (Postfix) with ESMTP id A229437E44;
	Wed, 24 Sep 2008 23:57:23 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.1.310.gf789d0.dirty
In-Reply-To: <1222293383-26016-1-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96695>

The help string hinted it could create branches, but it was not implemented.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../src/org/spearce/jgit/pgm/Branch.java           |   38 ++++++++++++++++++--
 1 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Branch.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Branch.java
index a266244..db0aab8 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Branch.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Branch.java
@@ -45,13 +45,16 @@
 import java.util.Map.Entry;
 
 import org.kohsuke.args4j.Argument;
+import org.kohsuke.args4j.ExampleMode;
 import org.kohsuke.args4j.Option;
 import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.ObjectId;
 import org.spearce.jgit.lib.Ref;
 import org.spearce.jgit.lib.RefComparator;
 import org.spearce.jgit.lib.RefUpdate;
+import org.spearce.jgit.lib.Repository;
 import org.spearce.jgit.lib.RefUpdate.Result;
+import org.spearce.jgit.pgm.opt.CmdLineParser;
 import org.spearce.jgit.revwalk.RevWalk;
 
 @Command(common = true, usage = "List, create, or delete branches")
@@ -69,6 +72,9 @@
 	@Option(name = "--delete-force", aliases = { "-D" }, usage = "delete branch (even if not merged)")
 	private boolean deleteForce = false;
 
+	@Option(name = "--create-force", aliases = { "-f" }, usage = "force create branch even exists")
+	private boolean createForce = false;
+
 	@Option(name = "--verbose", aliases = { "-v" }, usage = "be verbose")
 	private boolean verbose = false;
 
@@ -87,9 +93,35 @@ protected void run() throws Exception {
 		if (delete || deleteForce)
 			delete(deleteForce);
 		else {
-			if (verbose)
-				rw = new RevWalk(db);
-			list();
+			if (branches.size() > 2)
+				throw die("Too many refs given\n" + new CmdLineParser(this).printExample(ExampleMode.ALL));
+
+			if (branches.size() > 0) {
+				String newHead = branches.get(0);
+				ObjectId startAt;
+				if (branches.size() == 2)
+					startAt = db.resolve(branches.get(1) + "^0");
+				else
+					startAt = db.resolve(Constants.HEAD + "^0");
+
+				String newRefName = newHead;
+				if (!newRefName.startsWith(Constants.R_HEADS))
+					newRefName = Constants.R_HEADS + newRefName;
+				if (!Repository.isValidRefName(newRefName))
+					throw die(String.format("%s is not a valid ref name", newRefName));
+				if (!createForce && db.resolve(newRefName) != null)
+					throw die(String.format("branch %s already exists", newHead));
+				RefUpdate updateRef = db.updateRef(newRefName);
+				updateRef.setNewObjectId(startAt);
+				updateRef.setForceUpdate(createForce);
+				Result update = updateRef.update();
+				if (update == Result.REJECTED)
+					throw die(String.format("Could not create branch %s: %s", newHead, update.toString()));
+			} else {
+				if (verbose)
+					rw = new RevWalk(db);
+				list();
+			}
 		}
 	}
 
-- 
1.6.0.1.310.gf789d0.dirty

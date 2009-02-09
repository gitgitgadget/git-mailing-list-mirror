From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH] Permit a wider range of repository names in jgit daemon requests
Date: Sun,  8 Feb 2009 19:58:03 -0800
Message-ID: <1234151883-30479-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon Feb 09 05:00:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWNJd-00007Y-Dk
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 05:00:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753857AbZBID6J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 22:58:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753853AbZBID6I
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 22:58:08 -0500
Received: from george.spearce.org ([209.20.77.23]:34403 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753706AbZBID6H (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 22:58:07 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id ED4E538211; Mon,  9 Feb 2009 03:58:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 0C6273819E;
	Mon,  9 Feb 2009 03:58:03 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.422.g7298
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109042>

The earlier restriction was too narrow for some applications, for
example repositories named "jgit.dev" and "jgit.test" are perfectly
valid Git repositories and should still be able to be served by
the daemon.

By blocking out only uses of ".." as a path component and Windows
UNC paths (by blocking "\") we can reasonably prevent the client
from escaping the base dirctories configured in the daemon.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 I knew I wrote this patch, but I couldn't find it in tree, or
 on the mailing list.  So I'm sending/resending it.  :-)

 .../src/org/spearce/jgit/transport/Daemon.java     |   42 +++++++++----------
 1 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/Daemon.java b/org.spearce.jgit/src/org/spearce/jgit/transport/Daemon.java
index 646c88d..d39fd04 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/Daemon.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/Daemon.java
@@ -51,7 +51,6 @@
 import java.util.Collection;
 import java.util.HashMap;
 import java.util.Map;
-import java.util.regex.Pattern;
 
 import org.spearce.jgit.lib.Repository;
 
@@ -62,9 +61,6 @@
 
 	private static final int BACKLOG = 5;
 
-	private static final Pattern SAFE_REPOSITORY_NAME = Pattern
-			.compile("^[A-Za-z][A-Za-z0-9/_ -]+(\\.git)?$");
-
 	private InetSocketAddress myAddress;
 
 	private final DaemonService[] services;
@@ -292,24 +288,26 @@ synchronized (exports) {
 				return db;
 		}
 
-		if (SAFE_REPOSITORY_NAME.matcher(name).matches()) {
-			final File[] search;
-			synchronized (exportBase) {
-				search = exportBase.toArray(new File[exportBase.size()]);
-			}
-			for (final File f : search) {
-				db = openRepository(new File(f, name));
-				if (db != null)
-					return db;
-
-				db = openRepository(new File(f, name + ".git"));
-				if (db != null)
-					return db;
-
-				db = openRepository(new File(f, name + "/.git"));
-				if (db != null)
-					return db;
-			}
+		if (name.startsWith("../") || name.contains("/../")
+				|| name.contains("\\"))
+			return null;
+
+		final File[] search;
+		synchronized (exportBase) {
+			search = exportBase.toArray(new File[exportBase.size()]);
+		}
+		for (final File f : search) {
+			db = openRepository(new File(f, name));
+			if (db != null)
+				return db;
+
+			db = openRepository(new File(f, name + ".git"));
+			if (db != null)
+				return db;
+
+			db = openRepository(new File(f, name + "/.git"));
+			if (db != null)
+				return db;
 		}
 		return null;
 	}
-- 
1.6.1.422.g7298

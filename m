From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 08/11] Change Daemon to use RepositoryCache
Date: Sat, 11 Jul 2009 13:19:23 -0700
Message-ID: <1247343566-19025-9-git-send-email-spearce@spearce.org>
References: <1247343566-19025-1-git-send-email-spearce@spearce.org>
 <1247343566-19025-2-git-send-email-spearce@spearce.org>
 <1247343566-19025-3-git-send-email-spearce@spearce.org>
 <1247343566-19025-4-git-send-email-spearce@spearce.org>
 <1247343566-19025-5-git-send-email-spearce@spearce.org>
 <1247343566-19025-6-git-send-email-spearce@spearce.org>
 <1247343566-19025-7-git-send-email-spearce@spearce.org>
 <1247343566-19025-8-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sat Jul 11 22:19:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPj2z-0003MO-Fg
	for gcvg-git-2@gmane.org; Sat, 11 Jul 2009 22:19:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752950AbZGKUTr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jul 2009 16:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753670AbZGKUTl
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Jul 2009 16:19:41 -0400
Received: from george.spearce.org ([209.20.77.23]:39713 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751043AbZGKUTd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jul 2009 16:19:33 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 8149E38260; Sat, 11 Jul 2009 20:19:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 97593381FF;
	Sat, 11 Jul 2009 20:19:29 +0000 (UTC)
X-Mailer: git-send-email 1.6.4.rc0.117.g28cb
In-Reply-To: <1247343566-19025-8-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123121>

Now that we have a nice JVM wide cache for Repository instances,
we can use that inside of the Daemon code to manage setting up
a Repository and locating it on disk using the standard search
rules defined by FileKey.resolve().

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/transport/Daemon.java     |   38 +++++++++-----------
 .../org/spearce/jgit/transport/DaemonService.java  |   14 +++++---
 2 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/Daemon.java b/org.spearce.jgit/src/org/spearce/jgit/transport/Daemon.java
index f55e049..790745d 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/Daemon.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/Daemon.java
@@ -53,6 +53,8 @@
 
 import org.spearce.jgit.lib.PersonIdent;
 import org.spearce.jgit.lib.Repository;
+import org.spearce.jgit.lib.RepositoryCache;
+import org.spearce.jgit.lib.RepositoryCache.FileKey;
 
 /** Basic daemon for the anonymous <code>git://</code> transport protocol. */
 public class Daemon {
@@ -199,6 +201,7 @@ public void exportRepository(String name, final Repository db) {
 		if (!name.endsWith(".git"))
 			name = name + ".git";
 		exports.put(name, db);
+		RepositoryCache.register(db);
 	}
 
 	/**
@@ -350,34 +353,27 @@ Repository openRepository(String name) {
 
 		Repository db;
 		db = exports.get(name.endsWith(".git") ? name : name + ".git");
-		if (db != null)
+		if (db != null) {
+			db.incrementOpen();
 			return db;
+		}
 
-		for (final File f : exportBase) {
-			db = openRepository(new File(f, name));
-			if (db != null)
-				return db;
-
-			db = openRepository(new File(f, name + ".git"));
-			if (db != null)
-				return db;
-
-			db = openRepository(new File(f, name + "/.git"));
-			if (db != null)
-				return db;
+		for (final File baseDir : exportBase) {
+			final File gitdir = FileKey.resolve(new File(baseDir, name));
+			if (gitdir != null && canExport(gitdir))
+				return openRepository(gitdir);
 		}
 		return null;
 	}
 
-	private Repository openRepository(final File d) {
-		if (d.isDirectory() && canExport(d)) {
-			try {
-				return new Repository(d);
-			} catch (IOException err) {
-				// Ignore
-			}
+	private static Repository openRepository(final File gitdir) {
+		try {
+			return RepositoryCache.open(FileKey.exact(gitdir));
+		} catch (IOException err) {
+			// null signals it "wasn't found", which is all that is suitable
+			// for the remote client to know. 
+			return null;
 		}
-		return null;
 	}
 
 	private boolean canExport(final File d) {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/DaemonService.java b/org.spearce.jgit/src/org/spearce/jgit/transport/DaemonService.java
index c511d5a..817aeee 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/DaemonService.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/DaemonService.java
@@ -108,11 +108,15 @@ void execute(final DaemonClient client, final String commandLine)
 		final Repository db = client.getDaemon().openRepository(name);
 		if (db == null)
 			return;
-		boolean on = isEnabled();
-		if (isOverridable())
-			on = db.getConfig().getBoolean("daemon", config, on);
-		if (on)
-			execute(client, db);
+		try {
+			boolean on = isEnabled();
+			if (isOverridable())
+				on = db.getConfig().getBoolean("daemon", config, on);
+			if (on)
+				execute(client, db);
+		} finally {
+			db.close();
+		}
 	}
 
 	abstract void execute(DaemonClient client, Repository db)
-- 
1.6.4.rc0.117.g28cb

From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 01/11] Change Daemon to use concurrent collections for exported repositories
Date: Sat, 11 Jul 2009 13:19:16 -0700
Message-ID: <1247343566-19025-2-git-send-email-spearce@spearce.org>
References: <1247343566-19025-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sat Jul 11 22:19:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPj2x-0003MO-3E
	for gcvg-git-2@gmane.org; Sat, 11 Jul 2009 22:19:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511AbZGKUTf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jul 2009 16:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750855AbZGKUTa
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Jul 2009 16:19:30 -0400
Received: from george.spearce.org ([209.20.77.23]:39691 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716AbZGKUT2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jul 2009 16:19:28 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 10CD73819F; Sat, 11 Jul 2009 20:19:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 586393819F;
	Sat, 11 Jul 2009 20:19:27 +0000 (UTC)
X-Mailer: git-send-email 1.6.4.rc0.117.g28cb
In-Reply-To: <1247343566-19025-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123119>

A ConcurrentHashMap can be read without taking a lock, which makes it
more efficient when serving the concurrent client connections.  This
is also true of a CopyOnWriteArrayList, where again the readers far
outweigh the writers.  Copying on write is much more efficient than
copying on read.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/transport/Daemon.java     |   36 +++++++------------
 1 files changed, 13 insertions(+), 23 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/Daemon.java b/org.spearce.jgit/src/org/spearce/jgit/transport/Daemon.java
index 3101d6f..d3f7b2e 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/Daemon.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/Daemon.java
@@ -46,10 +46,10 @@
 import java.net.ServerSocket;
 import java.net.Socket;
 import java.net.SocketAddress;
-import java.util.ArrayList;
 import java.util.Collection;
-import java.util.HashMap;
 import java.util.Map;
+import java.util.concurrent.ConcurrentHashMap;
+import java.util.concurrent.CopyOnWriteArrayList;
 
 import org.spearce.jgit.lib.PersonIdent;
 import org.spearce.jgit.lib.Repository;
@@ -93,8 +93,8 @@ public Daemon() {
 	 */
 	public Daemon(final InetSocketAddress addr) {
 		myAddress = addr;
-		exports = new HashMap<String, Repository>();
-		exportBase = new ArrayList<File>();
+		exports = new ConcurrentHashMap<String, Repository>();
+		exportBase = new CopyOnWriteArrayList<File>();
 		processors = new ThreadGroup("Git-Daemon");
 
 		services = new DaemonService[] {
@@ -196,9 +196,7 @@ public synchronized void setExportAll(final boolean export) {
 	 *            the repository instance.
 	 */
 	public void exportRepository(final String name, final Repository db) {
-		synchronized (exports) {
-			exports.put(name, db);
-		}
+		exports.put(name, db);
 	}
 
 	/**
@@ -210,9 +208,7 @@ public void exportRepository(final String name, final Repository db) {
 	 *            named <code>git-daemon-export-ok</code> will be published.
 	 */
 	public void exportDirectory(final File dir) {
-		synchronized (exportBase) {
-			exportBase.add(dir);
-		}
+		exportBase.add(dir);
 	}
 
 	/** @return timeout (in seconds) before aborting an IO operation. */
@@ -351,21 +347,15 @@ Repository openRepository(String name) {
 		name = name.substring(1);
 
 		Repository db;
-		synchronized (exports) {
-			db = exports.get(name);
-			if (db != null)
-				return db;
+		db = exports.get(name);
+		if (db != null)
+			return db;
 
-			db = exports.get(name + ".git");
-			if (db != null)
-				return db;
-		}
+		db = exports.get(name + ".git");
+		if (db != null)
+			return db;
 
-		final File[] search;
-		synchronized (exportBase) {
-			search = exportBase.toArray(new File[exportBase.size()]);
-		}
-		for (final File f : search) {
+		for (final File f : exportBase) {
 			db = openRepository(new File(f, name));
 			if (db != null)
 				return db;
-- 
1.6.4.rc0.117.g28cb

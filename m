From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH] Add --export-all to jgit daemon
Date: Wed, 11 Feb 2009 14:59:38 -0800
Message-ID: <1234393178-4429-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 00:01:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXO4r-00085K-0M
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 00:01:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755936AbZBKW7m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 17:59:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755900AbZBKW7l
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 17:59:41 -0500
Received: from george.spearce.org ([209.20.77.23]:49879 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755794AbZBKW7k (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 17:59:40 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id DBE4638211; Wed, 11 Feb 2009 22:59:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 5460B3819E;
	Wed, 11 Feb 2009 22:59:39 +0000 (UTC)
X-Mailer: git-send-email 1.6.2.rc0.204.gf6b427
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109543>

Sometimes its useful to export an entire directory tree,
without needing to create git-daemon-export-ok everywhere.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/pgm/Daemon.java           |    4 ++
 .../src/org/spearce/jgit/transport/Daemon.java     |   37 +++++++++++++++++++-
 2 files changed, 40 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Daemon.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Daemon.java
index 39b43b2..e064fd8 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Daemon.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Daemon.java
@@ -66,6 +66,9 @@
 	@Option(name = "--forbid-override", metaVar = "SERVICE", usage = "configure the service in daemon.servicename", multiValued = true)
 	final List<String> forbidOverride = new ArrayList<String>();
 
+	@Option(name = "--export-all", usage = "export without git-daemon-export-ok")
+	boolean exportAll;
+
 	@Argument(required = true, metaVar = "DIRECTORY", usage = "directories to export")
 	final List<File> directory = new ArrayList<File>();
 
@@ -81,6 +84,7 @@ protected void run() throws Exception {
 		d = new org.spearce.jgit.transport.Daemon(
 				host != null ? new InetSocketAddress(host, port)
 						: new InetSocketAddress(port));
+		d.setExportAll(exportAll);
 
 		for (final String n : enable)
 			service(d, n).setEnabled(true);
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/Daemon.java b/org.spearce.jgit/src/org/spearce/jgit/transport/Daemon.java
index e5b446c..be27732 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/Daemon.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/Daemon.java
@@ -69,6 +69,8 @@
 
 	private final ThreadGroup processors;
 
+	private boolean exportAll;
+
 	private Map<String, Repository> exports;
 
 	private Collection<File> exportBase;
@@ -155,6 +157,32 @@ public synchronized DaemonService getService(String name) {
 	}
 
 	/**
+	 * @return false if <code>git-daemon-export-ok</code> is required to export
+	 *         a repository; true if <code>git-daemon-export-ok</code> is
+	 *         ignored.
+	 * @see #setExportAll(boolean)
+	 */
+	public synchronized boolean isExportAll() {
+		return exportAll;
+	}
+
+	/**
+	 * Set whether or not to export all repositories.
+	 * <p>
+	 * If false (the default), repositories must have a
+	 * <code>git-daemon-export-ok</code> file to be accessed through this
+	 * daemon.
+	 * <p>
+	 * If true, all repositories are available through the daemon, whether or
+	 * not <code>git-daemon-export-ok</code> exists.
+	 *
+	 * @param export
+	 */
+	public synchronized void setExportAll(final boolean export) {
+		exportAll = export;
+	}
+
+	/**
 	 * Add a single repository to the set that is exported by this daemon.
 	 * <p>
 	 * The existence (or lack-thereof) of <code>git-daemon-export-ok</code> is
@@ -336,7 +364,7 @@ synchronized (exportBase) {
 	}
 
 	private Repository openRepository(final File d) {
-		if (d.isDirectory() && new File(d, "git-daemon-export-ok").exists()) {
+		if (d.isDirectory() && canExport(d)) {
 			try {
 				return new Repository(d);
 			} catch (IOException err) {
@@ -345,4 +373,11 @@ private Repository openRepository(final File d) {
 		}
 		return null;
 	}
+
+	private boolean canExport(final File d) {
+		if (isExportAll()) {
+			return true;
+		}
+		return new File(d, "git-daemon-export-ok").exists();
+	}
 }
-- 
1.6.2.rc0.204.gf6b427

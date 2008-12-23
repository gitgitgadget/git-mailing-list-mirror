From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 3/5] Modify "jgit daemon" so it can run outside of a repository
Date: Tue, 23 Dec 2008 10:03:41 -0800
Message-ID: <1230055423-9944-4-git-send-email-spearce@spearce.org>
References: <1230055423-9944-1-git-send-email-spearce@spearce.org>
 <1230055423-9944-2-git-send-email-spearce@spearce.org>
 <1230055423-9944-3-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Dec 23 19:05:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LFBdc-0002sv-Tw
	for gcvg-git-2@gmane.org; Tue, 23 Dec 2008 19:05:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbYLWSD4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2008 13:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbYLWSDz
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Dec 2008 13:03:55 -0500
Received: from george.spearce.org ([209.20.77.23]:58226 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751163AbYLWSDv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2008 13:03:51 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id B39CE38200; Tue, 23 Dec 2008 18:03:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 494DB38210;
	Tue, 23 Dec 2008 18:03:44 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc4.301.g5497a
In-Reply-To: <1230055423-9944-3-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103840>

We no longer export the current repository, but instead export the
directory trees given.  This behavior is more closely matches that
of "git daemon".

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/pgm/Daemon.java           |   33 +++++--------------
 1 files changed, 9 insertions(+), 24 deletions(-)

diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Daemon.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Daemon.java
index aafc82e..39b43b2 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Daemon.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Daemon.java
@@ -44,7 +44,6 @@
 
 import org.kohsuke.args4j.Argument;
 import org.kohsuke.args4j.Option;
-import org.spearce.jgit.lib.Repository;
 import org.spearce.jgit.transport.DaemonService;
 
 @Command(common = true, usage = "Export repositories over git://")
@@ -67,10 +66,15 @@
 	@Option(name = "--forbid-override", metaVar = "SERVICE", usage = "configure the service in daemon.servicename", multiValued = true)
 	final List<String> forbidOverride = new ArrayList<String>();
 
-	@Argument(metaVar = "DIRECTORY", usage = "directories to export")
+	@Argument(required = true, metaVar = "DIRECTORY", usage = "directories to export")
 	final List<File> directory = new ArrayList<File>();
 
 	@Override
+	protected boolean requiresRepository() {
+		return false;
+	}
+
+	@Override
 	protected void run() throws Exception {
 		final org.spearce.jgit.transport.Daemon d;
 
@@ -88,13 +92,9 @@ protected void run() throws Exception {
 		for (final String n : forbidOverride)
 			service(d, n).setOverridable(false);
 
-		if (directory.isEmpty()) {
-			export(d, db);
-		} else {
-			for (final File f : directory) {
-				out.println("Exporting " + f.getAbsolutePath());
-				d.exportDirectory(f);
-			}
+		for (final File f : directory) {
+			out.println("Exporting " + f.getAbsolutePath());
+			d.exportDirectory(f);
 		}
 		d.start();
 		out.println("Listening on " + d.getAddress());
@@ -107,19 +107,4 @@ private DaemonService service(final org.spearce.jgit.transport.Daemon d,
 			throw die("Service '" + n + "' not supported");
 		return svc;
 	}
-
-	private void export(final org.spearce.jgit.transport.Daemon daemon,
-			final Repository repo) {
-		File d = repo.getDirectory();
-		String name = d.getName();
-		while (name.equals(".git") || name.equals(".")) {
-			d = d.getParentFile();
-			name = d.getName();
-		}
-		if (!name.endsWith(".git"))
-			name += ".git";
-
-		out.println("Exporting current repository as \"" + name + "\"");
-		daemon.exportRepository(name, repo);
-	}
 }
-- 
1.6.1.rc4.301.g5497a

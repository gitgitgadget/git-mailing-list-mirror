From: Constantine Plotnikov <constantine.plotnikov@gmail.com>
Subject: [JGIT PATCH] Added support for creating bare repositories
Date: Fri, 24 Apr 2009 19:36:57 +0400
Message-ID: <1240587417-3732-1-git-send-email-constantine.plotnikov@gmail.com>
Cc: Constantine Plotnikov <constantine.plotnikov@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 24 17:45:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxNaX-0001kG-8z
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 17:45:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbZDXPnn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 11:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbZDXPnn
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 11:43:43 -0400
Received: from mail.intellij.net ([213.182.181.98]:51219 "EHLO
	mail.intellij.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750890AbZDXPnm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 11:43:42 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Fri, 24 Apr 2009 11:43:41 EDT
Received: (qmail 8533 invoked by uid 89); 24 Apr 2009 15:36:58 -0000
Received: by simscan 1.1.0 ppid: 8487, pid: 8525, t: 0.0100s
         scanners: regex: 1.1.0
Received: from unknown (HELO localhost.localdomain) (Constantine.Plotnikov@jetbrains.com@172.26.240.76)
  by mail.intellij.net with ESMTPA; 24 Apr 2009 15:36:58 -0000
X-Mailer: git-send-email 1.6.1.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117461>

Now it is possible to create bare repositories.
The difference from normal repository creation is
that directory where repository is created might
exists and that core.bare property is set to true.

Signed-off-by: Constantine Plotnikov <constantine.plotnikov@gmail.com>
---
 .../src/org/spearce/jgit/pgm/Init.java             |    8 ++++-
 .../src/org/spearce/jgit/lib/Repository.java       |   28 ++++++++++++++++---
 2 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Init.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Init.java
index 197864d..3ab1599 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Init.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Init.java
@@ -39,10 +39,14 @@
 
 import java.io.File;
 
+import org.kohsuke.args4j.Option;
 import org.spearce.jgit.lib.Repository;
 
 @Command(common = true, usage = "Create an empty git repository")
 class Init extends TextBuiltin {
+	@Option(name = "--bare", usage = "Create a bare repository")
+	private boolean bare;
+
 	@Override
 	protected final boolean requiresRepository() {
 		return false;
@@ -51,9 +55,9 @@ protected final boolean requiresRepository() {
 	@Override
 	protected void run() throws Exception {
 		if (gitdir == null)
-			gitdir = new File(".git");
+			gitdir = new File(bare ? "." : ".git");
 		db = new Repository(gitdir);
-		db.create();
+		db.create(bare);
 		out.println("Initialized empty Git repository in "
 				+ gitdir.getAbsolutePath());
 	}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index cfd92b8..f2b0b3f 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -161,16 +161,30 @@ public Repository(final File d) throws IOException {
 
 	/**
 	 * Create a new Git repository initializing the necessary files and
-	 * directories.
+	 * directories. Repository with working tree is created using this method.
 	 *
 	 * @throws IOException
+	 * @see #create(boolean)
 	 */
 	public synchronized void create() throws IOException {
-		if (gitDir.exists()) {
+		create(false);
+	}
+
+	/**
+	 * Create a new Git repository initializing the necessary files and
+	 * directories.
+	 * 
+	 * @param bare
+	 *            if true, a bare repository is created.
+	 * 
+	 * @throws IOException
+	 *             in case of IO problem
+	 */
+	public void create(boolean bare) throws IOException {
+		if ((bare ? new File(gitDir, "config") : gitDir).exists()) {
 			throw new IllegalStateException("Repository already exists: "
 					+ gitDir);
 		}
-
 		gitDir.mkdirs();
 		refs.create();
 
@@ -183,8 +197,12 @@ public synchronized void create() throws IOException {
 		final String master = Constants.R_HEADS + Constants.MASTER;
 		refs.link(Constants.HEAD, master);
 
-		getConfig().create();
-		getConfig().save();
+		RepositoryConfig cfg = getConfig();
+		cfg.create();
+		if (bare) {
+			cfg.setString("core", null, "bare", "true");
+		}
+		cfg.save();
 	}
 
 	private synchronized File[] objectsDirs(){
-- 
1.6.1.2

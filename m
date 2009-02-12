From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 9/9] Make pack.indexversion config option default to version 2
Date: Wed, 11 Feb 2009 18:36:59 -0800
Message-ID: <1234406219-19547-10-git-send-email-spearce@spearce.org>
References: <1234406219-19547-1-git-send-email-spearce@spearce.org>
 <1234406219-19547-2-git-send-email-spearce@spearce.org>
 <1234406219-19547-3-git-send-email-spearce@spearce.org>
 <1234406219-19547-4-git-send-email-spearce@spearce.org>
 <1234406219-19547-5-git-send-email-spearce@spearce.org>
 <1234406219-19547-6-git-send-email-spearce@spearce.org>
 <1234406219-19547-7-git-send-email-spearce@spearce.org>
 <1234406219-19547-8-git-send-email-spearce@spearce.org>
 <1234406219-19547-9-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 03:39:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXRTf-0002tJ-Oc
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 03:39:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756712AbZBLChe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 21:37:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756852AbZBLChd
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 21:37:33 -0500
Received: from george.spearce.org ([209.20.77.23]:39186 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755620AbZBLChG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 21:37:06 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 10B8E38215; Thu, 12 Feb 2009 02:37:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 0A0733821F;
	Thu, 12 Feb 2009 02:37:02 +0000 (UTC)
X-Mailer: git-send-email 1.6.2.rc0.204.gf6b427
In-Reply-To: <1234406219-19547-9-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109567>

Git 1.6.0 (released Sun Aug 17 11:42:22 2008 -0700) defaults
to creating the much safer pack index version 2 format when
writing a pack to disk.  Most clients trying to use Git will
be running a recent version of C Git alongside JGit so it is
reasonably safe to assume they have index version 2 reading
support, and are thus prepared to accept this change in the
default output format.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/pgm/IndexPack.java        |    4 +++-
 .../src/org/spearce/jgit/lib/CoreConfig.java       |    3 ++-
 .../src/org/spearce/jgit/lib/PackWriter.java       |    1 +
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/IndexPack.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/IndexPack.java
index 5eacaa4..22803a4 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/IndexPack.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/IndexPack.java
@@ -49,13 +49,15 @@
 	private boolean fixThin;
 
 	@Option(name = "--index-version", usage = "index file format to create")
-	private int indexVersion;
+	private int indexVersion = -1;
 
 	@Argument(index = 0, required = true, metaVar = "base")
 	private File base;
 
 	@Override
 	protected void run() throws Exception {
+		if (indexVersion == -1)
+			indexVersion = db.getConfig().getCore().getPackIndexVersion();
 		final BufferedInputStream in;
 		final org.spearce.jgit.transport.IndexPack ip;
 		in = new BufferedInputStream(System.in);
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/CoreConfig.java b/org.spearce.jgit/src/org/spearce/jgit/lib/CoreConfig.java
index 2dd8aea..e98e0bc 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/CoreConfig.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/CoreConfig.java
@@ -45,6 +45,7 @@
  */
 public class CoreConfig {
 	private static final int DEFAULT_COMPRESSION = Deflater.DEFAULT_COMPRESSION;
+	private static final int DEFAULT_INDEXVERSION = 2;
 
 	private final int compression;
 
@@ -52,7 +53,7 @@
 
 	CoreConfig(final RepositoryConfig rc) {
 		compression = rc.getInt("core", "compression", DEFAULT_COMPRESSION);
-		packIndexVersion = rc.getInt("pack", "indexversion", 0);
+		packIndexVersion = rc.getInt("pack", "indexversion", DEFAULT_INDEXVERSION);
 	}
 
 	/**
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
index cba2ee7..f9945c4 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
@@ -237,6 +237,7 @@ public PackWriter(final Repository repo, final ProgressMonitor imonitor,
 		initMonitor = imonitor;
 		writeMonitor = wmonitor;
 		this.deflater = new Deflater(db.getConfig().getCore().getCompression());
+		outputVersion = repo.getConfig().getCore().getPackIndexVersion();
 	}
 
 	/**
-- 
1.6.2.rc0.204.gf6b427

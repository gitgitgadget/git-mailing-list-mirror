From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 17/19] Move repository config creation fully into Repository class
Date: Sat, 25 Jul 2009 11:53:00 -0700
Message-ID: <1248547982-4003-18-git-send-email-spearce@spearce.org>
References: <1248547982-4003-1-git-send-email-spearce@spearce.org>
 <1248547982-4003-2-git-send-email-spearce@spearce.org>
 <1248547982-4003-3-git-send-email-spearce@spearce.org>
 <1248547982-4003-4-git-send-email-spearce@spearce.org>
 <1248547982-4003-5-git-send-email-spearce@spearce.org>
 <1248547982-4003-6-git-send-email-spearce@spearce.org>
 <1248547982-4003-7-git-send-email-spearce@spearce.org>
 <1248547982-4003-8-git-send-email-spearce@spearce.org>
 <1248547982-4003-9-git-send-email-spearce@spearce.org>
 <1248547982-4003-10-git-send-email-spearce@spearce.org>
 <1248547982-4003-11-git-send-email-spearce@spearce.org>
 <1248547982-4003-12-git-send-email-spearce@spearce.org>
 <1248547982-4003-13-git-send-email-spearce@spearce.org>
 <1248547982-4003-14-git-send-email-spearce@spearce.org>
 <1248547982-4003-15-git-send-email-spearce@spearce.org>
 <1248547982-4003-16-git-send-email-spearce@spearce.org>
 <1248547982-4003-17-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sat Jul 25 20:54:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUmOA-0002ZF-UX
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 20:54:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752344AbZGYSxl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 14:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752219AbZGYSxl
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 14:53:41 -0400
Received: from george.spearce.org ([209.20.77.23]:35588 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752222AbZGYSxO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 14:53:14 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id EF970381FE; Sat, 25 Jul 2009 18:53:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 5350738222;
	Sat, 25 Jul 2009 18:53:08 +0000 (UTC)
X-Mailer: git-send-email 1.6.4.rc2.216.g769fa
In-Reply-To: <1248547982-4003-17-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124051>

Rather than having the core properties initialized in two different
locations its cleaner to do all of the setup work here in one place,
in case we need to make any further changes to the repository create
code path.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/Repository.java       |    5 ++---
 .../src/org/spearce/jgit/lib/RepositoryConfig.java |    9 ---------
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index 7fb1ef7..468cf4c 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -144,8 +144,6 @@ public Repository(final File d) throws IOException {
 				throw new IOException("Unknown repository format \""
 						+ repositoryFormatVersion + "\"; expected \"0\".");
 			}
-		} else {
-			getConfig().create();
 		}
 	}
 
@@ -185,7 +183,8 @@ public void create(boolean bare) throws IOException {
 		final String master = Constants.R_HEADS + Constants.MASTER;
 		refs.link(Constants.HEAD, master);
 
-		cfg.create();
+		cfg.setInt("core", null, "repositoryformatversion", 0);
+		cfg.setBoolean("core", null, "filemode", true);
 		if (bare)
 			cfg.setBoolean("core", null, "bare", true);
 		cfg.save();
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
index 15fe9de..ccfe184 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
@@ -123,13 +123,4 @@ public String getAuthorEmail() {
 	public String getCommitterEmail() {
 		return getUserConfig().getCommitterEmail();
 	}
-
-	/**
-	 * Create a new default config
-	 */
-	public void create() {
-		clear();
-		setInt("core", null, "repositoryformatversion", 0);
-		setBoolean("core", null, "filemode", true);
-	}
 }
-- 
1.6.4.rc2.216.g769fa

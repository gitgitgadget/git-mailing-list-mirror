From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 07/19] Correct user config to be of type FileBasedConfig
Date: Sat, 25 Jul 2009 11:52:50 -0700
Message-ID: <1248547982-4003-8-git-send-email-spearce@spearce.org>
References: <1248547982-4003-1-git-send-email-spearce@spearce.org>
 <1248547982-4003-2-git-send-email-spearce@spearce.org>
 <1248547982-4003-3-git-send-email-spearce@spearce.org>
 <1248547982-4003-4-git-send-email-spearce@spearce.org>
 <1248547982-4003-5-git-send-email-spearce@spearce.org>
 <1248547982-4003-6-git-send-email-spearce@spearce.org>
 <1248547982-4003-7-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sat Jul 25 20:54:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUmOE-0002ZF-Pp
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 20:54:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752430AbZGYSyC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 14:54:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750986AbZGYSx0
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 14:53:26 -0400
Received: from george.spearce.org ([209.20.77.23]:35555 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751479AbZGYSxG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 14:53:06 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id BB65338239; Sat, 25 Jul 2009 18:53:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id E9C1E381FE;
	Sat, 25 Jul 2009 18:53:04 +0000 (UTC)
X-Mailer: git-send-email 1.6.4.rc2.216.g769fa
In-Reply-To: <1248547982-4003-7-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124049>

The user's ~/.gitconfig file is a file, but not a repository specific
file.  Since RepositoryConfig has been refactored into base classes
that handle file based configuration, we no longer need to use the
RepositoryConfig type to access ~/.gitconfig.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/RepositoryConfig.java |    4 ++--
 .../src/org/spearce/jgit/util/SystemReader.java    |    5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
index 9be7c1b..5c912b7 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
@@ -60,7 +60,7 @@
 	 * @return a new configuration instance to read the user's global
 	 *         configuration file from their home directory.
 	 */
-	public static RepositoryConfig openUserConfig() {
+	public static FileBasedConfig openUserConfig() {
 		return SystemReader.getInstance().openUserConfig();
 	}
 
@@ -85,7 +85,7 @@ public static RepositoryConfig openUserConfig() {
 	 * @param cfgLocation
 	 *            path of the file to load (or save).
 	 */
-	public RepositoryConfig(final RepositoryConfig base, final File cfgLocation) {
+	public RepositoryConfig(final Config base, final File cfgLocation) {
 		super(base, cfgLocation);
 	}
 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/util/SystemReader.java b/org.spearce.jgit/src/org/spearce/jgit/util/SystemReader.java
index 36c188c..a30dfef 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/util/SystemReader.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/util/SystemReader.java
@@ -41,6 +41,7 @@
 import java.net.InetAddress;
 import java.net.UnknownHostException;
 
+import org.spearce.jgit.lib.FileBasedConfig;
 import org.spearce.jgit.lib.RepositoryConfig;
 
 /**
@@ -63,7 +64,7 @@ public String getProperty(String key) {
 			return System.getProperty(key);
 		}
 
-		public RepositoryConfig openUserConfig() {
+		public FileBasedConfig openUserConfig() {
 			final File home = FS.userHome();
 			return new RepositoryConfig(null, new File(home, ".gitconfig"));
 		}
@@ -119,5 +120,5 @@ public static void setInstance(SystemReader newReader) {
 	/**
 	 * @return the git configuration found in the user home
 	 */
-	public abstract RepositoryConfig openUserConfig();
+	public abstract FileBasedConfig openUserConfig();
 }
-- 
1.6.4.rc2.216.g769fa

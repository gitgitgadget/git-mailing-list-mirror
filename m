From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 4/5] Add no fallback constructor to FileBasedConfig
Date: Wed, 29 Jul 2009 08:50:26 -0700
Message-ID: <1248882627-7285-5-git-send-email-spearce@spearce.org>
References: <1248882627-7285-1-git-send-email-spearce@spearce.org>
 <1248882627-7285-2-git-send-email-spearce@spearce.org>
 <1248882627-7285-3-git-send-email-spearce@spearce.org>
 <1248882627-7285-4-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 17:51:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWBQq-0000Sa-8U
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 17:51:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755165AbZG2Puf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 11:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755137AbZG2Puf
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 11:50:35 -0400
Received: from george.spearce.org ([209.20.77.23]:45990 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755042AbZG2Puc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2009 11:50:32 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 9D1A0381FF; Wed, 29 Jul 2009 15:50:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 06DA03821F;
	Wed, 29 Jul 2009 15:50:29 +0000 (UTC)
X-Mailer: git-send-email 1.6.4.rc3.201.gd9d59
In-Reply-To: <1248882627-7285-4-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124361>

Sometimes when reading a FileBasedConfig the caller does not want any
fallback lookup.  Instead always passing a null first parameter to the
constructor, we can use a 1-arg constructor that takes only the File
path for this file.  This simplifies a number of cases within the JGit
library and test cases, as well as some application code.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../tst/org/spearce/jgit/lib/MockSystemReader.java |    2 +-
 .../org/spearce/jgit/lib/RepositoryTestCase.java   |    2 +-
 .../src/org/spearce/jgit/lib/FileBasedConfig.java  |   10 ++++++++++
 .../src/org/spearce/jgit/util/SystemReader.java    |    3 +--
 4 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/MockSystemReader.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/MockSystemReader.java
index 62862d1..7a65f99 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/MockSystemReader.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/MockSystemReader.java
@@ -53,7 +53,7 @@
 		init(Constants.GIT_AUTHOR_EMAIL_KEY);
 		init(Constants.GIT_COMMITTER_NAME_KEY);
 		init(Constants.GIT_COMMITTER_EMAIL_KEY);
-		userGitConfig = new FileBasedConfig(null, null);
+		userGitConfig = new FileBasedConfig(null);
 	}
 
 	private void init(final String n) {
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
index 24a99ca..6de9afe 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
@@ -237,7 +237,7 @@ public void run() {
 		}
 
 		final MockSystemReader mockSystemReader = new MockSystemReader();
-		mockSystemReader.userGitConfig = new FileBasedConfig(null, new File(
+		mockSystemReader.userGitConfig = new FileBasedConfig(new File(
 				trash_git, "usergitconfig"));
 		SystemReader.setInstance(mockSystemReader);
 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/FileBasedConfig.java b/org.spearce.jgit/src/org/spearce/jgit/lib/FileBasedConfig.java
index a419e7f..adf85c6 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/FileBasedConfig.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/FileBasedConfig.java
@@ -55,6 +55,16 @@
 	private final File configFile;
 
 	/**
+	 * Create a configuration with no default fallback.
+	 *
+	 * @param cfgLocation
+	 *            the location of the configuration file on the file system
+	 */
+	public FileBasedConfig(File cfgLocation) {
+		this(null, cfgLocation);
+	}
+
+	/**
 	 * The constructor
 	 *
 	 * @param base
diff --git a/org.spearce.jgit/src/org/spearce/jgit/util/SystemReader.java b/org.spearce.jgit/src/org/spearce/jgit/util/SystemReader.java
index a30dfef..51a0d29 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/util/SystemReader.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/util/SystemReader.java
@@ -42,7 +42,6 @@
 import java.net.UnknownHostException;
 
 import org.spearce.jgit.lib.FileBasedConfig;
-import org.spearce.jgit.lib.RepositoryConfig;
 
 /**
  * Interface to read values from the system.
@@ -66,7 +65,7 @@ public String getProperty(String key) {
 
 		public FileBasedConfig openUserConfig() {
 			final File home = FS.userHome();
-			return new RepositoryConfig(null, new File(home, ".gitconfig"));
+			return new FileBasedConfig(new File(home, ".gitconfig"));
 		}
 
 		public String getHostname() {
-- 
1.6.4.rc3.201.gd9d59

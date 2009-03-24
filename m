From: Yann Simon <yann.simon.fr@gmail.com>
Subject: [PATCH JGIT] Do not read ~/.gitconfig during JUnit tests
Date: Tue, 24 Mar 2009 14:36:40 +0100
Message-ID: <49C8E1E8.5020706@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Mar 24 14:39:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lm6qQ-000517-22
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 14:39:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758369AbZCXNgr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 09:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753626AbZCXNgr
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 09:36:47 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:27201 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757397AbZCXNgq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 09:36:46 -0400
Received: by ey-out-2122.google.com with SMTP id 4so660925eyf.37
        for <git@vger.kernel.org>; Tue, 24 Mar 2009 06:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=4U0YVkavQj4zp3V78rh/8mhe94guLUjgfUXWYoeASFc=;
        b=CQfpRe4nbLLUNta3/EbCcOA2NfoJ3eB94d+AvO98I7lLArl6dhAruYqju/yfS9+7wJ
         u4XzZH4RV3UdJJjAaXwVPsVP0qUrBYDlH0FF3XZTpDQZrqSIQ9uSVYQ04z0mJn9BophA
         /KCSuE4taKDofyWkpWk7lLVu+G9mHibeUEcZM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=ui0pTSO1Ckd8s6b2bMeLbWsBSo3oqTm/v18tM7rfdCO44YVHz1gIGJzMr9TdgJl7y/
         oH9sfH+paaWLBqxvlVDtWQcXSv1+9jQQVms1imb3UrnUIcW9a1Oqv47UGxFf4JXvx257
         KcVbUr0IoT7uqNWsVvuYniEpRJT1qMLjAs0Ss=
Received: by 10.216.6.213 with SMTP id 63mr3085417wen.208.1237901802540;
        Tue, 24 Mar 2009 06:36:42 -0700 (PDT)
Received: from ?10.11.2.21? (port-87-193-216-74.static.qsc.de [87.193.216.74])
        by mx.google.com with ESMTPS id 10sm3425766eyd.13.2009.03.24.06.36.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Mar 2009 06:36:42 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114458>

Extend the SystemReader interface to add the responsability
to get the user's global configuration.
This extension is used in the JUnit tests to provide a
custom global configuration instance independant
from ~/.gitconfig.

Signed-off-by: Yann Simon <yann.simon.fr@gmail.com>
---
This should close the issue #42.

 .../org/spearce/jgit/lib/RepositoryConfigTest.java |    8 +++-----
 .../org/spearce/jgit/lib/RepositoryTestCase.java   |   19 +++++++++++++++++++
 .../src/org/spearce/jgit/lib/RepositoryConfig.java |    7 +++++--
 .../src/org/spearce/jgit/util/SystemReader.java    |   10 +++++++++-
 4 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryConfigTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryConfigTest.java
index 259bc05..4b5314c 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryConfigTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryConfigTest.java
@@ -128,12 +128,10 @@ public void test007_readUserInfos() throws IOException {
 			hostname = "localhost";
 		}
 
-		final File globalConfig = writeTrashFile("global.config", "");
 		final File localConfig = writeTrashFile("local.config", "");
 		System.clearProperty(Constants.OS_USER_NAME_KEY);
 
-		RepositoryConfig globalRepositoryConfig = new RepositoryConfig(null, globalConfig);
-		RepositoryConfig localRepositoryConfig = new RepositoryConfig(globalRepositoryConfig, localConfig);
+		RepositoryConfig localRepositoryConfig = new RepositoryConfig(userGitConfig, localConfig);
 		fakeSystemReader.values.clear();
 
 		String authorName;
@@ -164,8 +162,8 @@ public void test007_readUserInfos() throws IOException {
 		assertEquals("author@email", authorEmail);
 
 		// the values are defined in the global configuration
-		globalRepositoryConfig.setString("user", null, "name", "global username");
-		globalRepositoryConfig.setString("user", null, "email", "author@globalemail");
+		userGitConfig.setString("user", null, "name", "global username");
+		userGitConfig.setString("user", null, "email", "author@globalemail");
 		authorName = localRepositoryConfig.getAuthorName();
 		authorEmail = localRepositoryConfig.getAuthorEmail();
 		assertEquals("global username", authorName);
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
index 5d8c056..588daf4 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
@@ -89,12 +89,19 @@
 
 	protected static class FakeSystemReader implements SystemReader {
 		Map<String, String> values = new HashMap<String, String>();
+		RepositoryConfig userGitConfig;
 		public String getenv(String variable) {
 			return values.get(variable);
 		}
 		public String getProperty(String key) {
 			return values.get(key);
 		}
+		public RepositoryConfig openUserConfig() {
+			return userGitConfig;
+		}
+		public void setUserGitConfig(RepositoryConfig userGitConfig) {
+			this.userGitConfig = userGitConfig;
+		}
 	}
 
 	/**
@@ -227,6 +234,13 @@ protected static void checkFile(File f, final String checkData)
 	}
 
 	protected Repository db;
+
+	/**
+	 * mock user's global configuration used instead ~/.gitconfig.
+	 * This configuration can be modified by the tests without any
+	 * effect for ~/.gitconfig.
+	 */
+	protected RepositoryConfig userGitConfig;
 	private static Thread shutdownhook;
 	private static List<Runnable> shutDownCleanups = new ArrayList<Runnable>();
 	private static int testcount;
@@ -257,6 +271,11 @@ public void run() {
 			};
 			Runtime.getRuntime().addShutdownHook(shutdownhook);
 		}
+
+		final File userGitConfigFile = new File(trash_git, "usergitconfig").getAbsoluteFile();
+		userGitConfig = new RepositoryConfig(null, userGitConfigFile);
+		fakeSystemReader.setUserGitConfig(userGitConfig);
+
 		db = new Repository(trash_git);
 		db.create();
 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
index 8d19c1b..87fc254 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
@@ -73,12 +73,12 @@
 public class RepositoryConfig {
 	/**
 	 * Obtain a new configuration instance for ~/.gitconfig.
-	 * 
+	 *
 	 * @return a new configuration instance to read the user's global
 	 *         configuration file from their home directory.
 	 */
 	public static RepositoryConfig openUserConfig() {
-		return new RepositoryConfig(null, new File(FS.userHome(), ".gitconfig"));
+		return systemReader.openUserConfig();
 	}
 
 	private final RepositoryConfig baseConfig;
@@ -113,6 +113,9 @@ public String getenv(String variable) {
 		public String getProperty(String key) {
 			return System.getProperty(key);
 		}
+		public RepositoryConfig openUserConfig() {
+			return new RepositoryConfig(null, new File(FS.userHome(), ".gitconfig"));
+		}
 	};
 
 	RepositoryConfig(final Repository repo) {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/util/SystemReader.java b/org.spearce.jgit/src/org/spearce/jgit/util/SystemReader.java
index 9187504..32c2e20 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/util/SystemReader.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/util/SystemReader.java
@@ -37,11 +37,14 @@
 
 package org.spearce.jgit.util;
 
+import org.spearce.jgit.lib.RepositoryConfig;
+
 /**
  * Interface to read values from the system.
  * <p>
  * When writing unit tests, extending this interface with a custom class
- * permits to simulate an access to a system variable or property.
+ * permits to simulate an access to a system variable or property and
+ * permits to control the user's global configuration.
  * </p>
  */
 public interface SystemReader {
@@ -56,4 +59,9 @@
 	 * @return value of the system property
 	 */
 	String getProperty(String key);
+
+	/**
+	 * @return the git configuration found in the user home
+	 */
+	RepositoryConfig openUserConfig();
 }
-- 
1.6.1.2

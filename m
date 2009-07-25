From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 16/19] Refactor author/committer lookup to use cached data
Date: Sat, 25 Jul 2009 11:52:59 -0700
Message-ID: <1248547982-4003-17-git-send-email-spearce@spearce.org>
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
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sat Jul 25 20:54:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUmOC-0002ZF-FP
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 20:54:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752352AbZGYSxo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 14:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752219AbZGYSxn
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 14:53:43 -0400
Received: from george.spearce.org ([209.20.77.23]:35586 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752221AbZGYSxO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 14:53:14 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 89F4A381FD; Sat, 25 Jul 2009 18:53:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 119EC3821F;
	Sat, 25 Jul 2009 18:53:08 +0000 (UTC)
X-Mailer: git-send-email 1.6.4.rc2.216.g769fa
In-Reply-To: <1248547982-4003-16-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124054>

The author and committer don't typically change when processing,
so we can maintain them in a cached entity just like we do with
the TransferConfig and the CoreConfig.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../org/spearce/jgit/lib/RepositoryConfigTest.java |   29 ++--
 .../src/org/spearce/jgit/lib/RepositoryConfig.java |   56 ++------
 .../src/org/spearce/jgit/lib/UserConfig.java       |  149 ++++++++++++++++++++
 3 files changed, 173 insertions(+), 61 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/UserConfig.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryConfigTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryConfigTest.java
index d4a6dd2..67d9964 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryConfigTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryConfigTest.java
@@ -109,55 +109,56 @@ public void test007_readUserConfig() {
 		SystemReader.setInstance(mockSystemReader);
 		final String hostname = mockSystemReader.getHostname();
 		final Config userGitConfig = mockSystemReader.userGitConfig;
-		final RepositoryConfig localConfig = new RepositoryConfig(userGitConfig, null);
-		localConfig.create();
+		final Config localConfig = new Config(userGitConfig);
 		mockSystemReader.values.clear();
 
 		String authorName;
 		String authorEmail;
 
 		// no values defined nowhere
-		authorName = localConfig.getAuthorName();
-		authorEmail = localConfig.getAuthorEmail();
+		authorName = localConfig.get(UserConfig.KEY).getAuthorName();
+		authorEmail = localConfig.get(UserConfig.KEY).getAuthorEmail();
 		assertEquals(Constants.UNKNOWN_USER_DEFAULT, authorName);
 		assertEquals(Constants.UNKNOWN_USER_DEFAULT + "@" + hostname, authorEmail);
 
 		// the system user name is defined
 		mockSystemReader.values.put(Constants.OS_USER_NAME_KEY, "os user name");
-		authorName = localConfig.getAuthorName();
+		localConfig.uncache(UserConfig.KEY);
+		authorName = localConfig.get(UserConfig.KEY).getAuthorName();
 		assertEquals("os user name", authorName);
 
 		if (hostname != null && hostname.length() != 0) {
-			authorEmail = localConfig.getAuthorEmail();
+			authorEmail = localConfig.get(UserConfig.KEY).getAuthorEmail();
 			assertEquals("os user name@" + hostname, authorEmail);
 		}
 
 		// the git environment variables are defined
 		mockSystemReader.values.put(Constants.GIT_AUTHOR_NAME_KEY, "git author name");
 		mockSystemReader.values.put(Constants.GIT_AUTHOR_EMAIL_KEY, "author@email");
-		authorName = localConfig.getAuthorName();
-		authorEmail = localConfig.getAuthorEmail();
+		localConfig.uncache(UserConfig.KEY);
+		authorName = localConfig.get(UserConfig.KEY).getAuthorName();
+		authorEmail = localConfig.get(UserConfig.KEY).getAuthorEmail();
 		assertEquals("git author name", authorName);
 		assertEquals("author@email", authorEmail);
 
 		// the values are defined in the global configuration
 		userGitConfig.setString("user", null, "name", "global username");
 		userGitConfig.setString("user", null, "email", "author@globalemail");
-		authorName = localConfig.getAuthorName();
-		authorEmail = localConfig.getAuthorEmail();
+		authorName = localConfig.get(UserConfig.KEY).getAuthorName();
+		authorEmail = localConfig.get(UserConfig.KEY).getAuthorEmail();
 		assertEquals("global username", authorName);
 		assertEquals("author@globalemail", authorEmail);
 
 		// the values are defined in the local configuration
 		localConfig.setString("user", null, "name", "local username");
 		localConfig.setString("user", null, "email", "author@localemail");
-		authorName = localConfig.getAuthorName();
-		authorEmail = localConfig.getAuthorEmail();
+		authorName = localConfig.get(UserConfig.KEY).getAuthorName();
+		authorEmail = localConfig.get(UserConfig.KEY).getAuthorEmail();
 		assertEquals("local username", authorName);
 		assertEquals("author@localemail", authorEmail);
 
-		authorName = localConfig.getCommitterName();
-		authorEmail = localConfig.getCommitterEmail();
+		authorName = localConfig.get(UserConfig.KEY).getCommitterName();
+		authorEmail = localConfig.get(UserConfig.KEY).getCommitterEmail();
 		assertEquals("local username", authorName);
 		assertEquals("author@localemail", authorEmail);
 	}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
index c6a13b6..15fe9de 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
@@ -43,8 +43,6 @@
 
 import java.io.File;
 
-import org.spearce.jgit.util.SystemReader;
-
 /**
  * An object representing the Git config file.
  *
@@ -83,13 +81,18 @@ public TransferConfig getTransfer() {
 		return get(TransferConfig.KEY);
 	}
 
+	/** @return standard user configuration data */
+	public UserConfig getUserConfig() {
+		return get(UserConfig.KEY);
+	}
+
 	/**
 	 * @return the author name as defined in the git variables
 	 *         and configurations. If no name could be found, try
 	 *         to use the system user name instead.
 	 */
 	public String getAuthorName() {
-		return getUsernameInternal(Constants.GIT_AUTHOR_NAME_KEY);
+		return getUserConfig().getAuthorName();
 	}
 
 	/**
@@ -98,26 +101,7 @@ public String getAuthorName() {
 	 *         to use the system user name instead.
 	 */
 	public String getCommitterName() {
-		return getUsernameInternal(Constants.GIT_COMMITTER_NAME_KEY);
-	}
-
-	private String getUsernameInternal(String gitVariableKey) {
-		SystemReader systemReader = SystemReader.getInstance();
-		// try to get the user name from the local and global configurations.
-		String username = getString("user", null, "name");
-
-		if (username == null) {
-			// try to get the user name for the system property GIT_XXX_NAME
-			username = systemReader.getenv(gitVariableKey);
-		}
-		if (username == null) {
-			// get the system user name
-			username = systemReader.getProperty(Constants.OS_USER_NAME_KEY);
-		}
-		if (username == null) {
-			username = Constants.UNKNOWN_USER_DEFAULT;
-		}
-		return username;
+		return getUserConfig().getCommitterName();
 	}
 
 	/**
@@ -127,7 +111,7 @@ private String getUsernameInternal(String gitVariableKey) {
 	 *         host name.
 	 */
 	public String getAuthorEmail() {
-		return getUserEmailInternal(Constants.GIT_AUTHOR_EMAIL_KEY);
+		return getUserConfig().getAuthorEmail();
 	}
 
 	/**
@@ -137,29 +121,7 @@ public String getAuthorEmail() {
 	 *         host name.
 	 */
 	public String getCommitterEmail() {
-		return getUserEmailInternal(Constants.GIT_COMMITTER_EMAIL_KEY);
-	}
-
-	private String getUserEmailInternal(String gitVariableKey) {
-		SystemReader systemReader = SystemReader.getInstance();
-		// try to get the email from the local and global configurations.
-		String email = getString("user", null, "email");
-
-		if (email == null) {
-			// try to get the email for the system property GIT_XXX_EMAIL
-			email = systemReader.getenv(gitVariableKey);
-		}
-
-		if (email == null) {
-			// try to construct an email
-			String username = systemReader.getProperty(Constants.OS_USER_NAME_KEY);
-			if (username == null){
-				username = Constants.UNKNOWN_USER_DEFAULT;
-			}
-			email = username + "@" + systemReader.getHostname();
-		}
-
-		return email;
+		return getUserConfig().getCommitterEmail();
 	}
 
 	/**
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/UserConfig.java b/org.spearce.jgit/src/org/spearce/jgit/lib/UserConfig.java
new file mode 100644
index 0000000..27c7d69
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/UserConfig.java
@@ -0,0 +1,149 @@
+/*
+ * Copyright (C) 2009, Yann Simon <yann.simon.fr@gmail.com>
+ * Copyright (C) 2009, Google Inc.
+ *
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or
+ * without modification, are permitted provided that the following
+ * conditions are met:
+ *
+ * - Redistributions of source code must retain the above copyright
+ *   notice, this list of conditions and the following disclaimer.
+ *
+ * - Redistributions in binary form must reproduce the above
+ *   copyright notice, this list of conditions and the following
+ *   disclaimer in the documentation and/or other materials provided
+ *   with the distribution.
+ *
+ * - Neither the name of the Git Development Community nor the
+ *   names of its contributors may be used to endorse or promote
+ *   products derived from this software without specific prior
+ *   written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
+ * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
+ * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+package org.spearce.jgit.lib;
+
+import org.spearce.jgit.lib.Config.SectionParser;
+import org.spearce.jgit.util.SystemReader;
+
+/** The standard "user" configuration parameters. */
+public class UserConfig {
+	/** Key for {@link Config#get(SectionParser)}. */
+	public static final Config.SectionParser<UserConfig> KEY = new SectionParser<UserConfig>() {
+		public UserConfig parse(final Config cfg) {
+			return new UserConfig(cfg);
+		}
+	};
+
+	private final String authorName;
+
+	private final String authorEmail;
+
+	private final String committerName;
+
+	private final String committerEmail;
+
+	private UserConfig(final Config rc) {
+		authorName = getNameInternal(rc, Constants.GIT_AUTHOR_NAME_KEY);
+		authorEmail = getEmailInternal(rc, Constants.GIT_AUTHOR_EMAIL_KEY);
+
+		committerName = getNameInternal(rc, Constants.GIT_COMMITTER_NAME_KEY);
+		committerEmail = getEmailInternal(rc, Constants.GIT_COMMITTER_EMAIL_KEY);
+	}
+
+	/**
+	 * @return the author name as defined in the git variables and
+	 *         configurations. If no name could be found, try to use the system
+	 *         user name instead.
+	 */
+	public String getAuthorName() {
+		return authorName;
+	}
+
+	/**
+	 * @return the committer name as defined in the git variables and
+	 *         configurations. If no name could be found, try to use the system
+	 *         user name instead.
+	 */
+	public String getCommitterName() {
+		return committerName;
+	}
+
+	/**
+	 * @return the author email as defined in git variables and
+	 *         configurations. If no email could be found, try to
+	 *         propose one default with the user name and the
+	 *         host name.
+	 */
+	public String getAuthorEmail() {
+		return authorEmail;
+	}
+
+	/**
+	 * @return the committer email as defined in git variables and
+	 *         configurations. If no email could be found, try to
+	 *         propose one default with the user name and the
+	 *         host name.
+	 */
+	public String getCommitterEmail() {
+		return committerEmail;
+	}
+
+	private static String getNameInternal(Config rc, String envKey) {
+		// try to get the user name from the local and global configurations.
+		String username = rc.getString("user", null, "name");
+
+		if (username == null) {
+			// try to get the user name for the system property GIT_XXX_NAME
+			username = system().getenv(envKey);
+		}
+		if (username == null) {
+			// get the system user name
+			username = system().getProperty(Constants.OS_USER_NAME_KEY);
+		}
+		if (username == null) {
+			username = Constants.UNKNOWN_USER_DEFAULT;
+		}
+		return username;
+	}
+
+	private static String getEmailInternal(Config rc, String envKey) {
+		// try to get the email from the local and global configurations.
+		String email = rc.getString("user", null, "email");
+
+		if (email == null) {
+			// try to get the email for the system property GIT_XXX_EMAIL
+			email = system().getenv(envKey);
+		}
+
+		if (email == null) {
+			// try to construct an email
+			String username = system().getProperty(Constants.OS_USER_NAME_KEY);
+			if (username == null){
+				username = Constants.UNKNOWN_USER_DEFAULT;
+			}
+			email = username + "@" + system().getHostname();
+		}
+
+		return email;
+	}
+
+	private static SystemReader system() {
+		return SystemReader.getInstance();
+	}
+}
-- 
1.6.4.rc2.216.g769fa

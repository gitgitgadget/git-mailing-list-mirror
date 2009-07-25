From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 08/19] Extract the test specific SystemReader out of RepositoryTestCase
Date: Sat, 25 Jul 2009 11:52:51 -0700
Message-ID: <1248547982-4003-9-git-send-email-spearce@spearce.org>
References: <1248547982-4003-1-git-send-email-spearce@spearce.org>
 <1248547982-4003-2-git-send-email-spearce@spearce.org>
 <1248547982-4003-3-git-send-email-spearce@spearce.org>
 <1248547982-4003-4-git-send-email-spearce@spearce.org>
 <1248547982-4003-5-git-send-email-spearce@spearce.org>
 <1248547982-4003-6-git-send-email-spearce@spearce.org>
 <1248547982-4003-7-git-send-email-spearce@spearce.org>
 <1248547982-4003-8-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sat Jul 25 20:54:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUmO2-0002ZF-I2
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 20:54:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752276AbZGYSx0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 14:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751868AbZGYSxY
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 14:53:24 -0400
Received: from george.spearce.org ([209.20.77.23]:35561 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751236AbZGYSxH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 14:53:07 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id A57BD38260; Sat, 25 Jul 2009 18:53:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 3AA08381FD;
	Sat, 25 Jul 2009 18:53:05 +0000 (UTC)
X-Mailer: git-send-email 1.6.4.rc2.216.g769fa
In-Reply-To: <1248547982-4003-8-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124039>

We may need this in tests that don't extend off RepositoryTestCase,
as not all tests require a local Git repository to be created in
the host filesystem.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../tst/org/spearce/jgit/lib/MockSystemReader.java |   78 ++++++++++++++++++++
 .../org/spearce/jgit/lib/RepositoryConfigTest.java |   49 ++++++------
 .../org/spearce/jgit/lib/RepositoryTestCase.java   |   56 +-------------
 3 files changed, 107 insertions(+), 76 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/lib/MockSystemReader.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/MockSystemReader.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/MockSystemReader.java
new file mode 100644
index 0000000..62862d1
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/MockSystemReader.java
@@ -0,0 +1,78 @@
+/*
+ * Copyright (C) 2009, Yann Simon <yann.simon.fr@gmail.com>
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
+import java.util.HashMap;
+import java.util.Map;
+
+import org.spearce.jgit.util.SystemReader;
+
+class MockSystemReader extends SystemReader {
+	final Map<String, String> values = new HashMap<String, String>();
+
+	FileBasedConfig userGitConfig;
+
+	MockSystemReader() {
+		init(Constants.OS_USER_NAME_KEY);
+		init(Constants.GIT_AUTHOR_NAME_KEY);
+		init(Constants.GIT_AUTHOR_EMAIL_KEY);
+		init(Constants.GIT_COMMITTER_NAME_KEY);
+		init(Constants.GIT_COMMITTER_EMAIL_KEY);
+		userGitConfig = new FileBasedConfig(null, null);
+	}
+
+	private void init(final String n) {
+		values.put(n, n);
+	}
+
+	public String getenv(String variable) {
+		return values.get(variable);
+	}
+
+	public String getProperty(String key) {
+		return values.get(key);
+	}
+
+	public FileBasedConfig openUserConfig() {
+		return userGitConfig;
+	}
+
+	public String getHostname() {
+		return "fake.host.example.com";
+	}
+}
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryConfigTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryConfigTest.java
index 5bb9afb..e320679 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryConfigTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryConfigTest.java
@@ -45,6 +45,8 @@
 import java.util.Arrays;
 import java.util.LinkedList;
 
+import org.spearce.jgit.util.SystemReader;
+
 /**
  * Test reading of git config
  */
@@ -113,59 +115,58 @@ public void test006_readCaseInsensitive() throws IOException {
 		assertEquals("", repositoryConfig.getString("foo", null, "bar"));
 	}
 
-	public void test007_readUserInfos() throws IOException {
-		final String hostname = FAKE_HOSTNAME;
-		final File localConfig = writeTrashFile("local.config", "");
-		System.clearProperty(Constants.OS_USER_NAME_KEY);
-
-		RepositoryConfig localRepositoryConfig = new RepositoryConfig(userGitConfig, localConfig);
-		fakeSystemReader.values.clear();
+	public void test007_readUserConfig() {
+		final MockSystemReader mockSystemReader = (MockSystemReader)SystemReader.getInstance();
+		final String hostname = mockSystemReader.getHostname();
+		final Config userGitConfig = mockSystemReader.userGitConfig;
+		final RepositoryConfig localConfig = db.getConfig();
+		mockSystemReader.values.clear();
 
 		String authorName;
 		String authorEmail;
 
 		// no values defined nowhere
-		authorName = localRepositoryConfig.getAuthorName();
-		authorEmail = localRepositoryConfig.getAuthorEmail();
+		authorName = localConfig.getAuthorName();
+		authorEmail = localConfig.getAuthorEmail();
 		assertEquals(Constants.UNKNOWN_USER_DEFAULT, authorName);
 		assertEquals(Constants.UNKNOWN_USER_DEFAULT + "@" + hostname, authorEmail);
 
 		// the system user name is defined
-		fakeSystemReader.values.put(Constants.OS_USER_NAME_KEY, "os user name");
-		authorName = localRepositoryConfig.getAuthorName();
+		mockSystemReader.values.put(Constants.OS_USER_NAME_KEY, "os user name");
+		authorName = localConfig.getAuthorName();
 		assertEquals("os user name", authorName);
 
 		if (hostname != null && hostname.length() != 0) {
-			authorEmail = localRepositoryConfig.getAuthorEmail();
+			authorEmail = localConfig.getAuthorEmail();
 			assertEquals("os user name@" + hostname, authorEmail);
 		}
 
 		// the git environment variables are defined
-		fakeSystemReader.values.put(Constants.GIT_AUTHOR_NAME_KEY, "git author name");
-		fakeSystemReader.values.put(Constants.GIT_AUTHOR_EMAIL_KEY, "author@email");
-		authorName = localRepositoryConfig.getAuthorName();
-		authorEmail = localRepositoryConfig.getAuthorEmail();
+		mockSystemReader.values.put(Constants.GIT_AUTHOR_NAME_KEY, "git author name");
+		mockSystemReader.values.put(Constants.GIT_AUTHOR_EMAIL_KEY, "author@email");
+		authorName = localConfig.getAuthorName();
+		authorEmail = localConfig.getAuthorEmail();
 		assertEquals("git author name", authorName);
 		assertEquals("author@email", authorEmail);
 
 		// the values are defined in the global configuration
 		userGitConfig.setString("user", null, "name", "global username");
 		userGitConfig.setString("user", null, "email", "author@globalemail");
-		authorName = localRepositoryConfig.getAuthorName();
-		authorEmail = localRepositoryConfig.getAuthorEmail();
+		authorName = localConfig.getAuthorName();
+		authorEmail = localConfig.getAuthorEmail();
 		assertEquals("global username", authorName);
 		assertEquals("author@globalemail", authorEmail);
 
 		// the values are defined in the local configuration
-		localRepositoryConfig.setString("user", null, "name", "local username");
-		localRepositoryConfig.setString("user", null, "email", "author@localemail");
-		authorName = localRepositoryConfig.getAuthorName();
-		authorEmail = localRepositoryConfig.getAuthorEmail();
+		localConfig.setString("user", null, "name", "local username");
+		localConfig.setString("user", null, "email", "author@localemail");
+		authorName = localConfig.getAuthorName();
+		authorEmail = localConfig.getAuthorEmail();
 		assertEquals("local username", authorName);
 		assertEquals("author@localemail", authorEmail);
 
-		authorName = localRepositoryConfig.getCommitterName();
-		authorEmail = localRepositoryConfig.getCommitterEmail();
+		authorName = localConfig.getCommitterName();
+		authorEmail = localConfig.getCommitterEmail();
 		assertEquals("local username", authorName);
 		assertEquals("author@localemail", authorEmail);
 	}
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
index 9dfaeef..24a99ca 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
@@ -47,9 +47,7 @@
 import java.io.OutputStreamWriter;
 import java.io.Reader;
 import java.util.ArrayList;
-import java.util.HashMap;
 import java.util.List;
-import java.util.Map;
 
 import junit.framework.TestCase;
 
@@ -81,8 +79,6 @@
 
 	protected static final PersonIdent jcommitter;
 
-	protected static final String FAKE_HOSTNAME = "fake.host.example.com";
-
 	static {
 		jauthor = new PersonIdent("J. Author", "jauthor@example.com");
 		jcommitter = new PersonIdent("J. Committer", "jcommitter@example.com");
@@ -90,38 +86,6 @@
 
 	protected boolean packedGitMMAP;
 
-	protected static class FakeSystemReader extends SystemReader {
-		Map<String, String> values = new HashMap<String, String>();
-		RepositoryConfig userGitConfig;
-		public String getenv(String variable) {
-			return values.get(variable);
-		}
-		public String getProperty(String key) {
-			return values.get(key);
-		}
-		public RepositoryConfig openUserConfig() {
-			return userGitConfig;
-		}
-		public void setUserGitConfig(RepositoryConfig userGitConfig) {
-			this.userGitConfig = userGitConfig;
-		}
-		public String getHostname() {
-			return FAKE_HOSTNAME;
-		}
-	}
-
-	/**
-	 * Simulates the reading of system variables and properties.
-	 * Unit test can control the returned values by manipulating
-	 * {@link FakeSystemReader#values}.
-	 */
-	protected static FakeSystemReader fakeSystemReader;
-
-	static {
-		fakeSystemReader = new FakeSystemReader();
-		SystemReader.setInstance(fakeSystemReader);
-	}
-
 	/**
 	 * Configure JGit before setting up test repositories.
 	 */
@@ -241,12 +205,6 @@ protected static void checkFile(File f, final String checkData)
 
 	protected Repository db;
 
-	/**
-	 * mock user's global configuration used instead ~/.gitconfig.
-	 * This configuration can be modified by the tests without any
-	 * effect for ~/.gitconfig.
-	 */
-	protected RepositoryConfig userGitConfig;
 	private static Thread shutdownhook;
 	private static List<Runnable> shutDownCleanups = new ArrayList<Runnable>();
 	private static int testcount;
@@ -278,9 +236,10 @@ public void run() {
 			Runtime.getRuntime().addShutdownHook(shutdownhook);
 		}
 
-		final File userGitConfigFile = new File(trash_git, "usergitconfig").getAbsoluteFile();
-		userGitConfig = new RepositoryConfig(null, userGitConfigFile);
-		fakeSystemReader.setUserGitConfig(userGitConfig);
+		final MockSystemReader mockSystemReader = new MockSystemReader();
+		mockSystemReader.userGitConfig = new FileBasedConfig(null, new File(
+				trash_git, "usergitconfig"));
+		SystemReader.setInstance(mockSystemReader);
 
 		db = new Repository(trash_git);
 		db.create();
@@ -302,13 +261,6 @@ public void run() {
 		}
 
 		copyFile(JGitTestUtil.getTestResourceFile("packed-refs"), new File(trash_git,"packed-refs"));
-
-		fakeSystemReader.values.clear();
-		fakeSystemReader.values.put(Constants.OS_USER_NAME_KEY, Constants.OS_USER_NAME_KEY);
-		fakeSystemReader.values.put(Constants.GIT_AUTHOR_NAME_KEY, Constants.GIT_AUTHOR_NAME_KEY);
-		fakeSystemReader.values.put(Constants.GIT_AUTHOR_EMAIL_KEY, Constants.GIT_AUTHOR_EMAIL_KEY);
-		fakeSystemReader.values.put(Constants.GIT_COMMITTER_NAME_KEY, Constants.GIT_COMMITTER_NAME_KEY);
-		fakeSystemReader.values.put(Constants.GIT_COMMITTER_EMAIL_KEY, Constants.GIT_COMMITTER_EMAIL_KEY);
 	}
 
 	protected void tearDown() throws Exception {
-- 
1.6.4.rc2.216.g769fa

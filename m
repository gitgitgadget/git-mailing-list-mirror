From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 06/19] Move SystemReader out of RepositoryConfig
Date: Sat, 25 Jul 2009 11:52:49 -0700
Message-ID: <1248547982-4003-7-git-send-email-spearce@spearce.org>
References: <1248547982-4003-1-git-send-email-spearce@spearce.org>
 <1248547982-4003-2-git-send-email-spearce@spearce.org>
 <1248547982-4003-3-git-send-email-spearce@spearce.org>
 <1248547982-4003-4-git-send-email-spearce@spearce.org>
 <1248547982-4003-5-git-send-email-spearce@spearce.org>
 <1248547982-4003-6-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sat Jul 25 20:54:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUmO5-0002ZF-61
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 20:54:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752285AbZGYSxa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 14:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751868AbZGYSx2
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 14:53:28 -0400
Received: from george.spearce.org ([209.20.77.23]:35552 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752017AbZGYSxF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 14:53:05 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 573323821F; Sat, 25 Jul 2009 18:53:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 9B69938221;
	Sat, 25 Jul 2009 18:53:04 +0000 (UTC)
X-Mailer: git-send-email 1.6.4.rc2.216.g769fa
In-Reply-To: <1248547982-4003-6-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124045>

Reading basic properties of the JVM has nothing to do with reading
a Git style configuration file for a repository, or for the current
user account.  Instead pull all of that logic into its own abstract
class, and provide a default implementation available through a
singleton pattern.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../org/spearce/jgit/lib/RepositoryConfigTest.java |   11 +---
 .../org/spearce/jgit/lib/RepositoryTestCase.java   |    9 ++-
 .../src/org/spearce/jgit/lib/RepositoryConfig.java |   50 +--------------
 .../src/org/spearce/jgit/util/SystemReader.java    |   64 ++++++++++++++++++-
 4 files changed, 72 insertions(+), 62 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryConfigTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryConfigTest.java
index 5e2328b..5bb9afb 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryConfigTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryConfigTest.java
@@ -42,8 +42,6 @@
 
 import java.io.File;
 import java.io.IOException;
-import java.net.InetAddress;
-import java.net.UnknownHostException;
 import java.util.Arrays;
 import java.util.LinkedList;
 
@@ -116,14 +114,7 @@ public void test006_readCaseInsensitive() throws IOException {
 	}
 
 	public void test007_readUserInfos() throws IOException {
-		String hostname;
-		try {
-			InetAddress localMachine = InetAddress.getLocalHost();
-			hostname = localMachine.getCanonicalHostName();
-		} catch (UnknownHostException e) {
-			hostname = "localhost";
-		}
-
+		final String hostname = FAKE_HOSTNAME;
 		final File localConfig = writeTrashFile("local.config", "");
 		System.clearProperty(Constants.OS_USER_NAME_KEY);
 
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
index 2783180..9dfaeef 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
@@ -81,6 +81,8 @@
 
 	protected static final PersonIdent jcommitter;
 
+	protected static final String FAKE_HOSTNAME = "fake.host.example.com";
+
 	static {
 		jauthor = new PersonIdent("J. Author", "jauthor@example.com");
 		jcommitter = new PersonIdent("J. Committer", "jcommitter@example.com");
@@ -88,7 +90,7 @@
 
 	protected boolean packedGitMMAP;
 
-	protected static class FakeSystemReader implements SystemReader {
+	protected static class FakeSystemReader extends SystemReader {
 		Map<String, String> values = new HashMap<String, String>();
 		RepositoryConfig userGitConfig;
 		public String getenv(String variable) {
@@ -103,6 +105,9 @@ public RepositoryConfig openUserConfig() {
 		public void setUserGitConfig(RepositoryConfig userGitConfig) {
 			this.userGitConfig = userGitConfig;
 		}
+		public String getHostname() {
+			return FAKE_HOSTNAME;
+		}
 	}
 
 	/**
@@ -114,7 +119,7 @@ public void setUserGitConfig(RepositoryConfig userGitConfig) {
 
 	static {
 		fakeSystemReader = new FakeSystemReader();
-		RepositoryConfig.setSystemReader(fakeSystemReader);
+		SystemReader.setInstance(fakeSystemReader);
 	}
 
 	/**
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
index c80db00..9be7c1b 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
@@ -43,8 +43,6 @@
 
 import java.io.File;
 import java.io.IOException;
-import java.net.InetAddress;
-import java.net.UnknownHostException;
 
 import org.spearce.jgit.util.FS;
 import org.spearce.jgit.util.SystemReader;
@@ -63,7 +61,7 @@
 	 *         configuration file from their home directory.
 	 */
 	public static RepositoryConfig openUserConfig() {
-		return systemReader.openUserConfig();
+		return SystemReader.getInstance().openUserConfig();
 	}
 
 	/** Section name for a branch configuration. */
@@ -73,21 +71,6 @@ public static RepositoryConfig openUserConfig() {
 
 	TransferConfig transfer;
 
-	private static String hostname;
-
-	// default system reader gets the value from the system
-	private static SystemReader systemReader = new SystemReader() {
-		public String getenv(String variable) {
-			return System.getenv(variable);
-		}
-		public String getProperty(String key) {
-			return System.getProperty(key);
-		}
-		public RepositoryConfig openUserConfig() {
-			return new RepositoryConfig(null, new File(FS.userHome(), ".gitconfig"));
-		}
-	};
-
 	RepositoryConfig(final Repository repo) {
 		this(openUserConfig(), FS.resolve(repo.getDirectory(), "config"));
 	}
@@ -139,6 +122,7 @@ public String getCommitterName() {
 	}
 
 	private String getUsernameInternal(String gitVariableKey) {
+		SystemReader systemReader = SystemReader.getInstance();
 		// try to get the user name from the local and global configurations.
 		String username = getString("user", null, "name");
 
@@ -177,6 +161,7 @@ public String getCommitterEmail() {
 	}
 
 	private String getUserEmailInternal(String gitVariableKey) {
+		SystemReader systemReader = SystemReader.getInstance();
 		// try to get the email from the local and global configurations.
 		String email = getString("user", null, "email");
 
@@ -191,7 +176,7 @@ private String getUserEmailInternal(String gitVariableKey) {
 			if (username == null){
 				username = Constants.UNKNOWN_USER_DEFAULT;
 			}
-			email = username + "@" + getHostname();
+			email = username + "@" + systemReader.getHostname();
 		}
 
 		return email;
@@ -216,31 +201,4 @@ public void load() throws IOException {
 		core = new CoreConfig(this);
 		transfer = new TransferConfig(this);
 	}
-
-	/**
-	 * Gets the hostname of the local host.
-	 * If no hostname can be found, the hostname is set to the default value "localhost".
-	 * @return the canonical hostname
-	 */
-	private static String getHostname() {
-		if (hostname == null) {
-			try {
-				InetAddress localMachine = InetAddress.getLocalHost();
-				hostname = localMachine.getCanonicalHostName();
-			} catch (UnknownHostException e) {
-				// we do nothing
-				hostname = "localhost";
-			}
-			assert hostname != null;
-		}
-		return hostname;
-	}
-
-	/**
-	 * Overrides the default system reader by a custom one.
-	 * @param newSystemReader new system reader
-	 */
-	public static void setSystemReader(SystemReader newSystemReader) {
-		systemReader = newSystemReader;
-	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/util/SystemReader.java b/org.spearce.jgit/src/org/spearce/jgit/util/SystemReader.java
index 32c2e20..36c188c 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/util/SystemReader.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/util/SystemReader.java
@@ -37,6 +37,10 @@
 
 package org.spearce.jgit.util;
 
+import java.io.File;
+import java.net.InetAddress;
+import java.net.UnknownHostException;
+
 import org.spearce.jgit.lib.RepositoryConfig;
 
 /**
@@ -47,21 +51,73 @@
  * permits to control the user's global configuration.
  * </p>
  */
-public interface SystemReader {
+public abstract class SystemReader {
+	private static SystemReader INSTANCE = new SystemReader() {
+		private volatile String hostname;
+
+		public String getenv(String variable) {
+			return System.getenv(variable);
+		}
+
+		public String getProperty(String key) {
+			return System.getProperty(key);
+		}
+
+		public RepositoryConfig openUserConfig() {
+			final File home = FS.userHome();
+			return new RepositoryConfig(null, new File(home, ".gitconfig"));
+		}
+
+		public String getHostname() {
+			if (hostname == null) {
+				try {
+					InetAddress localMachine = InetAddress.getLocalHost();
+					hostname = localMachine.getCanonicalHostName();
+				} catch (UnknownHostException e) {
+					// we do nothing
+					hostname = "localhost";
+				}
+				assert hostname != null;
+			}
+			return hostname;
+		}
+	};
+
+	/** @return the live instance to read system properties. */
+	public static SystemReader getInstance() {
+		return INSTANCE;
+	}
+
+	/**
+	 * @param newReader
+	 *            the new instance to use when accessing properties.
+	 */
+	public static void setInstance(SystemReader newReader) {
+		INSTANCE = newReader;
+	}
+
+	/**
+	 * Gets the hostname of the local host. If no hostname can be found, the
+	 * hostname is set to the default value "localhost".
+	 *
+	 * @return the canonical hostname
+	 */
+	public abstract String getHostname();
+
 	/**
 	 * @param variable system variable to read
 	 * @return value of the system variable
 	 */
-	String getenv(String variable);
+	public abstract String getenv(String variable);
 
 	/**
 	 * @param key of the system property to read
 	 * @return value of the system property
 	 */
-	String getProperty(String key);
+	public abstract String getProperty(String key);
 
 	/**
 	 * @return the git configuration found in the user home
 	 */
-	RepositoryConfig openUserConfig();
+	public abstract RepositoryConfig openUserConfig();
 }
-- 
1.6.4.rc2.216.g769fa

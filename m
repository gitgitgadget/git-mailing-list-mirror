From: Yann Simon <yann.simon.fr@gmail.com>
Subject: [PATCH JGIT] Compute the author/commiter name and email from the
 git configuration
Date: Wed, 04 Feb 2009 13:28:54 +0100
Message-ID: <49898A06.5040603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Feb 04 13:30:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUgtf-0005PW-2u
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 13:30:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752458AbZBDM27 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 07:28:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752341AbZBDM27
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 07:28:59 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:35227 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751677AbZBDM26 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 07:28:58 -0500
Received: by fg-out-1718.google.com with SMTP id 16so1214305fgg.17
        for <git@vger.kernel.org>; Wed, 04 Feb 2009 04:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=HOJVK0LyxCHeuxen46NFr953FFccM32+uypGz9pE94U=;
        b=rYUe5EB5CEn40QkVUBFleMl3nCNGgLvWZO623B+DLKLBhr49bym6Q6ZxOubHDg3/Yl
         KmQWxBRB1a0s95fNs/irwiwXjnOhcPpo4BkLFegxYXiaQQLYrtEiwbeRWhvE2LrG8RGX
         t9XNLBj09ERt+Qf+D265J8RADKBFmZF9OxOd4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=f7cxeKv4VFCGIiEt1yN/WnlfzaeEzK0TZ4BSqB5/pHqk2+4H/5FtmPKZXiipDJXaZt
         VBkTIHs0rpEGvkeb/G8KVGBkXJ2RNhYgAMpA+5g4o2bPRgpUXTlaWHsHHPjGoRFZ41o4
         /QVVGrSOYmUHsxMJvM9LYPtJarylbAN6j1Axk=
Received: by 10.86.94.11 with SMTP id r11mr1263694fgb.53.1233750536118;
        Wed, 04 Feb 2009 04:28:56 -0800 (PST)
Received: from ?10.11.2.21? (port-87-193-216-74.static.qsc.de [87.193.216.74])
        by mx.google.com with ESMTPS id d6sm6636356fga.59.2009.02.04.04.28.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Feb 2009 04:28:55 -0800 (PST)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108344>

The author/commiter name and email are retrieved from the system configuration
and the local and global git configurations.

When the name is not available, propose one default by using the system user name.

When the email is not available, propose one default by concatenate the
user name and the host name.

The author name and email are used as default value in the author field
while committing with the GUI.

Fix issue 47 (field Author don't fill)

Signed-off-by: Yann Simon <yann.simon.fr@gmail.com>
---
This is the second version of the patch.

The differences are the following ones:
- use System.getenv for environment variables
- use canonical host name.
- static cache the host name

 .../egit/ui/internal/actions/CommitAction.java     |   17 +++
 .../org/spearce/jgit/lib/RepositoryConfigTest.java |   70 ++++++++++++
 .../src/org/spearce/jgit/lib/Constants.java        |   16 +++
 .../src/org/spearce/jgit/lib/RepositoryConfig.java |  116 ++++++++++++++++++++
 .../src/org/spearce/jgit/util/SystemReader.java    |   24 ++++
 5 files changed, 243 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/util/SystemReader.java

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CommitAction.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CommitAction.java
index 17232d6..456745c 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CommitAction.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CommitAction.java
@@ -41,6 +41,7 @@
 import org.spearce.jgit.lib.PersonIdent;
 import org.spearce.jgit.lib.RefUpdate;
 import org.spearce.jgit.lib.Repository;
+import org.spearce.jgit.lib.RepositoryConfig;
 import org.spearce.jgit.lib.Tree;
 import org.spearce.jgit.lib.TreeEntry;
 import org.spearce.jgit.lib.GitIndex.Entry;
@@ -70,8 +71,10 @@ public void run(IAction act) {
 		}
 
 		Repository[] repos = getRepositoriesFor(getProjectsForSelectedResources());
+		Repository repository = null;
 		amendAllowed = repos.length == 1;
 		for (Repository repo : repos) {
+			repository = repo;
 			if (!repo.getRepositoryState().canCommit()) {
 				MessageDialog.openError(getTargetPart().getSite().getShell(),
 					"Cannot commit now", "Repository state:"
@@ -95,12 +98,26 @@ public void run(IAction act) {
 			}
 		}
 
+		assert repository != null;
+		RepositoryConfig repositoryConfig = repository.getConfig();
+		String author = null;
+		String username = repositoryConfig.getAuthorName();
+		if (username != null && username.length() != 0) {
+			author = username;
+			String email = repositoryConfig.getAuthorEmail();
+			if (email != null && email.length() != 0) {
+				author = author + " <" + email + ">";
+			}
+		}
+
 		loadPreviousCommit();
 
 		CommitDialog commitDialog = new CommitDialog(getTargetPart().getSite().getShell());
 		commitDialog.setAmending(amending);
 		commitDialog.setAmendAllowed(amendAllowed);
 		commitDialog.setFileList(files);
+		commitDialog.setAuthor(author);
+
 		if (previousCommit != null)
 			commitDialog.setPreviousCommitMessage(previousCommit.getMessage());
 
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryConfigTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryConfigTest.java
index 34ce04a..113eb1c 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryConfigTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryConfigTest.java
@@ -43,7 +43,11 @@
 import java.io.File;
 import java.io.IOException;
 import java.util.Arrays;
+import java.util.HashMap;
 import java.util.LinkedList;
+import java.util.Map;
+
+import org.spearce.jgit.util.SystemReader;
 
 /**
  * Test reading of git config
@@ -116,4 +120,70 @@ public void test006_readCaseInsensitive() throws IOException {
 		assertEquals(true, repositoryConfig.getBoolean("foo", null, "bar", false));
 		assertEquals("", repositoryConfig.getString("foo", null, "bar"));
 	}
+
+	private class FakeSystemReader implements SystemReader {
+		Map<String, String> values = new HashMap<String, String>();
+		public String getEnvironmentVariable(String variable) {
+			return values.get(variable);
+		}
+		public String getProperty(String key) {
+			return values.get(key);
+		}
+	}
+
+	public void test007_readUserInfos() throws IOException {
+		final File globalConfig = writeTrashFile("global.config", "");
+		final File localConfig = writeTrashFile("local.config", "");
+		System.clearProperty(Constants.OS_USER_NAME_KEY);
+
+		FakeSystemReader fakeSystemReader = new FakeSystemReader();
+
+		RepositoryConfig globalRepositoryConfig = new RepositoryConfig(null, globalConfig);
+		RepositoryConfig localRepositoryConfig = new RepositoryConfig(globalRepositoryConfig, localConfig);
+		localRepositoryConfig.setSystemReader(fakeSystemReader);
+
+		String authorName;
+		String authorEmail;
+
+		// no values defined nowhere
+		authorName = localRepositoryConfig.getAuthorName();
+		authorEmail = localRepositoryConfig.getAuthorEmail();
+		assertNull(authorName);
+		assertNull(authorEmail);
+
+		// the system user name is defined
+		fakeSystemReader.values.put(Constants.OS_USER_NAME_KEY, "os user name");
+		authorName = localRepositoryConfig.getAuthorName();
+		assertEquals("os user name", authorName);
+
+		String hostname = RepositoryConfig.getHostname();
+		if (hostname != null && hostname.length() != 0) {
+			authorEmail = localRepositoryConfig.getAuthorEmail();
+			assertEquals("os user name@" + hostname, authorEmail);
+		}
+
+		// the git environment variables are defined
+		fakeSystemReader.values.put(Constants.GIT_AUTHOR_NAME_KEY, "git author name");
+		fakeSystemReader.values.put(Constants.GIT_AUTHOR_EMAIL_KEY, "author@email");
+		authorName = localRepositoryConfig.getAuthorName();
+		authorEmail = localRepositoryConfig.getAuthorEmail();
+		assertEquals("git author name", authorName);
+		assertEquals("author@email", authorEmail);
+
+		// the values are defined in the global configuration
+		globalRepositoryConfig.setString("user", null, "name", "global username");
+		globalRepositoryConfig.setString("user", null, "email", "author@globalemail");
+		authorName = localRepositoryConfig.getAuthorName();
+		authorEmail = localRepositoryConfig.getAuthorEmail();
+		assertEquals("global username", authorName);
+		assertEquals("author@globalemail", authorEmail);
+
+		// the values are defined in the local configuration
+		localRepositoryConfig.setString("user", null, "name", "local username");
+		localRepositoryConfig.setString("user", null, "email", "author@localemail");
+		authorName = localRepositoryConfig.getAuthorName();
+		authorEmail = localRepositoryConfig.getAuthorEmail();
+		assertEquals("local username", authorName);
+		assertEquals("author@localemail", authorEmail);
+	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java
index 8f093d6..372fba5 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java
@@ -228,6 +228,22 @@
 	/** Packed refs file */
 	public static final String PACKED_REFS = "packed-refs";
 
+	/** The environment variable that contains the system user name */
+	public static final String OS_USER_NAME_KEY = "user.name";
+
+	/** The environment variable that contains the author's name */
+	public static final String GIT_AUTHOR_NAME_KEY = "GIT_AUTHOR_NAME";
+
+	/** The environment variable that contains the author's email */
+	public static final String GIT_AUTHOR_EMAIL_KEY = "GIT_AUTHOR_EMAIL";
+
+	/** The environment variable that contains the commiter's name */
+	public static final String GIT_COMMITER_NAME_KEY = "GIT_COMMITER_NAME";
+
+	/** The environment variable that contains the commiter's email */
+	public static final String GIT_COMMITER_EMAIL_KEY = "GIT_COMMITER_EMAIL";
+
+
 	/**
 	 * Create a new digest function for objects.
 	 * 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
index 7df90cd..0fa4b1f 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
@@ -50,6 +50,8 @@
 import java.io.InputStreamReader;
 import java.io.OutputStreamWriter;
 import java.io.PrintWriter;
+import java.net.InetAddress;
+import java.net.UnknownHostException;
 import java.util.ArrayList;
 import java.util.Collections;
 import java.util.HashMap;
@@ -60,6 +62,7 @@
 import java.util.Set;
 
 import org.spearce.jgit.util.FS;
+import org.spearce.jgit.util.SystemReader;
 
 /**
  * An object representing the Git config file.
@@ -98,8 +101,20 @@ public static RepositoryConfig openUserConfig() {
 
 	private Map<String, Object> byName;
 
+	private static String hostname;
+
 	private static final String MAGIC_EMPTY_VALUE = "%%magic%%empty%%";
 
+	// default system reader gets the value from the system
+	private static SystemReader systemReader = new SystemReader() {
+		public String getEnvironmentVariable(String variable) {
+			return System.getenv(variable);
+		}
+		public String getProperty(String key) {
+			return System.getProperty(key);
+		}
+	};
+
 	RepositoryConfig(final Repository repo) {
 		this(openUserConfig(), FS.resolve(repo.getDirectory(), "config"));
 	}
@@ -308,6 +323,83 @@ public String getString(final String section, String subsection, final String na
 		return result;
 	}
 
+	/**
+	 * @return the author name as defined in the git variables
+	 *         and configurations. If no name could be found, try
+	 *         to use the system user name instead.
+	 */
+	public String getAuthorName() {
+		return getUsernameInternal(Constants.GIT_AUTHOR_NAME_KEY);
+	}
+
+	/**
+	 * @return the commiter name as defined in the git variables
+	 *         and configurations. If no name could be found, try
+	 *         to use the system user name instead.
+	 */
+	public String getCommiterName() {
+		return getUsernameInternal(Constants.GIT_COMMITER_NAME_KEY);
+	}
+
+	private String getUsernameInternal(String gitVariableKey) {
+		// try to get the user name from the local and global configurations.
+		String username = getString("user", null, "name");
+
+		if (username == null) {
+			// try to get the user name for the system property GIT_XXX_NAME
+			username = systemReader.getEnvironmentVariable(gitVariableKey);
+		}
+		if (username == null) {
+			// get the system user name
+			username = systemReader.getProperty(Constants.OS_USER_NAME_KEY);
+		}
+
+		return username;
+	}
+
+	/**
+	 * @return the author email as defined in git variables and
+	 *         configurations. If no email could be found, try to
+	 *         propose one default with the author name and the
+	 *         host name.
+	 */
+	public String getAuthorEmail() {
+		return getUserEmailInternal(Constants.GIT_AUTHOR_EMAIL_KEY, true);
+	}
+
+	/**
+	 * @return the commiter email as defined in git variables and
+	 *         configurations. If no email could be found, try to
+	 *         propose one default with the author name and the
+	 *         host name.
+	 */
+	public String getCommiterEmail() {
+		return getUserEmailInternal(Constants.GIT_COMMITER_EMAIL_KEY, false);
+	}
+
+	private String getUserEmailInternal(String gitVariableKey, boolean author) {
+		// try to get the email from the local and global configurations.
+		String email = getString("user", null, "email");
+
+		if (email == null) {
+			// try to get the email for the system property GIT_XXX_EMAIL
+			email = systemReader.getEnvironmentVariable(gitVariableKey);
+		}
+
+		if (email == null) {
+			// try to construct an email
+			String userName = author ? getAuthorName() : getCommiterName();
+			if (userName != null && userName.length() != 0) {
+				String hostnameTmp = getHostname();
+				if (hostnameTmp != null && hostnameTmp.length() != 0) {
+					email = userName + "@" + hostnameTmp;
+				}
+			}
+		}
+
+		return email;
+	}
+
 	private String getRawString(final String section, final String subsection,
 			final String name) {
 		final Object o = getRawEntry(section, subsection, name);
@@ -957,4 +1049,28 @@ private static boolean eq(final String a, final String b) {
 			return a.equalsIgnoreCase(b);
 		}
 	}
+
+	/**
+	 * @return the canonical hostname
+	 */
+	public static String getHostname() {
+		if (hostname == null) {
+			try {
+				InetAddress localMachine = InetAddress.getLocalHost();
+				hostname = localMachine.getCanonicalHostName();
+			} catch (UnknownHostException e) {
+				// we do nothing
+			}
+		}
+		return hostname;
+	}
+
+	/**
+	 * Overrides the default system reader by a custom one.
+	 * @param systemReader new system reader
+	 */
+	public void setSystemReader(SystemReader systemReader) {
+		RepositoryConfig.systemReader = systemReader;
+	}
+
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/util/SystemReader.java b/org.spearce.jgit/src/org/spearce/jgit/util/SystemReader.java
new file mode 100644
index 0000000..89b4021
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/util/SystemReader.java
@@ -0,0 +1,24 @@
+package org.spearce.jgit.util;
+
+/**
+ * Interface to read values from the system.
+ * <p>
+ * When writing unit tests, extending this interface with a custom class
+ * permits to simulate an access to a system variable or property.
+ * </p>
+ */
+public interface SystemReader {
+
+	/**
+	 * @param variable system variable to read
+	 * @return value of the system variable
+	 */
+	String getEnvironmentVariable(String variable);
+
+	/**
+	 * @param key of the system property to read
+	 * @return value of the system property
+	 */
+	String getProperty(String key);
+
+}
-- 
1.6.0.4

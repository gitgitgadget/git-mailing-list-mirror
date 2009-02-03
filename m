From: Yann Simon <yann.simon.fr@gmail.com>
Subject: [PATCH JGIT] Compute the author/commiter name and email from the
	git configuration
Date: Tue, 03 Feb 2009 22:13:14 +0100
Message-ID: <1233695594.8042.6.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Feb 03 22:14:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUSbW-00025V-9B
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 22:14:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752329AbZBCVNV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 16:13:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752325AbZBCVNU
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 16:13:20 -0500
Received: from mail-ew0-f21.google.com ([209.85.219.21]:47288 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755210AbZBCVNS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 16:13:18 -0500
Received: by ewy14 with SMTP id 14so2884606ewy.13
        for <git@vger.kernel.org>; Tue, 03 Feb 2009 13:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=ue20cq5wNmpKqEIbTuFOu21DKp6iPqGdQFujb0+3uDI=;
        b=Dcr5knefLedVdj+1DLzc3auFq541zIN2yQ54LdcXAFtcITWLw4jFAQXGn+OnMezV2C
         MA6C7pMypw0QT7mRGmGM3tQkh6H0rxCLDcdArzV2B9v4MLVhvk+VvjAHMSsce6lNjDO9
         rRM9NDeBbmrf1EkZ8YQXMq0aseluneqBwTxr0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        b=cOZKfa5EVh0p8KR19W5W8UXwinh372dnUt5zlU6vM3oemQIyLw+l5Cewhm4lBs9Awl
         JA/Otk6XuSkaYC5vPLNBzjY5wukDHnDEAMHJczuOBeHEdRrmZB4xbZhM/CwTdXkHMxbg
         CDUUy6HOaClhB0iQlE9acjniqoKoNpWb3xdLM=
Received: by 10.103.193.13 with SMTP id v13mr2172851mup.1.1233695596460;
        Tue, 03 Feb 2009 13:13:16 -0800 (PST)
Received: from ?85.178.74.59? (e178074059.adsl.alicedsl.de [85.178.74.59])
        by mx.google.com with ESMTPS id j10sm776263mue.56.2009.02.03.13.13.15
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 03 Feb 2009 13:13:16 -0800 (PST)
X-Mailer: Evolution 2.22.3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108252>

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
 .../egit/ui/internal/actions/CommitAction.java     |   17 ++++
 .../org/spearce/jgit/lib/RepositoryConfigTest.java |   56 +++++++++++
 .../src/org/spearce/jgit/lib/Constants.java        |   16 +++
 .../src/org/spearce/jgit/lib/RepositoryConfig.java |   97 ++++++++++++++++++++
 4 files changed, 186 insertions(+), 0 deletions(-)

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
index 34ce04a..4f53ca0 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryConfigTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryConfigTest.java
@@ -42,6 +42,8 @@
 
 import java.io.File;
 import java.io.IOException;
+import java.net.InetAddress;
+import java.net.UnknownHostException;
 import java.util.Arrays;
 import java.util.LinkedList;
 
@@ -116,4 +118,58 @@ public void test006_readCaseInsensitive() throws IOException {
 		assertEquals(true, repositoryConfig.getBoolean("foo", null, "bar", false));
 		assertEquals("", repositoryConfig.getString("foo", null, "bar"));
 	}
+
+	public void test007_readUserInfos() throws IOException {
+		final File globalConfig = writeTrashFile("global.config", "");
+		final File localConfig = writeTrashFile("global.config", "");
+		System.clearProperty(Constants.OS_USER_NAME_KEY);
+		System.clearProperty(Constants.GIT_AUTHOR_NAME_KEY);
+		System.clearProperty(Constants.GIT_AUTHOR_EMAIL_KEY);
+
+		RepositoryConfig globalRepositoryConfig = new RepositoryConfig(null, globalConfig);
+		RepositoryConfig localRepositoryConfig = new RepositoryConfig(globalRepositoryConfig, localConfig);
+
+		String authorName;
+		String authorEmail;
+
+		authorName = localRepositoryConfig.getAuthorName();
+		authorEmail = localRepositoryConfig.getAuthorEmail();
+		assertNull(authorName);
+		assertNull(authorEmail);
+
+		System.setProperty(Constants.OS_USER_NAME_KEY, "os user name");
+		authorName = localRepositoryConfig.getAuthorName();
+		assertEquals("os user name", authorName);
+		InetAddress localMachine;
+		try {
+			localMachine = InetAddress.getLocalHost();
+			String hostname = localMachine.getHostName();
+			authorEmail = localRepositoryConfig.getAuthorEmail();
+			assertEquals("os user name@" + hostname, authorEmail);
+		} catch (UnknownHostException e) {
+			// we do nothing
+		}
+
+
+		System.setProperty(Constants.GIT_AUTHOR_NAME_KEY, "git author name");
+		System.setProperty(Constants.GIT_AUTHOR_EMAIL_KEY, "author@email");
+		authorName = localRepositoryConfig.getAuthorName();
+		authorEmail = localRepositoryConfig.getAuthorEmail();
+		assertEquals("git author name", authorName);
+		assertEquals("author@email", authorEmail);
+
+		globalRepositoryConfig.setString("user", null, "name", "global username");
+		globalRepositoryConfig.setString("user", null, "email", "author@globalemail");
+		authorName = localRepositoryConfig.getAuthorName();
+		authorEmail = localRepositoryConfig.getAuthorEmail();
+		assertEquals("global username", authorName);
+		assertEquals("author@globalemail", authorEmail);
+
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
index 7df90cd..5821f83 100644
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
@@ -98,6 +100,8 @@ public static RepositoryConfig openUserConfig() {
 
 	private Map<String, Object> byName;
 
+	private String hostname;
+
 	private static final String MAGIC_EMPTY_VALUE = "%%magic%%empty%%";
 
 	RepositoryConfig(final Repository repo) {
@@ -308,6 +312,83 @@ public String getString(final String section, String subsection, final String na
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
+			username = System.getProperty(gitVariableKey);
+		}
+		if (username == null) {
+			// get the system user name
+			username = System.getProperty(Constants.OS_USER_NAME_KEY);
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
+		// try to get the email from the local and global configs.
+		String email = getString("user", null, "email");
+
+		if (email == null) {
+			// try to get the email for the system property GIT_XXX_EMAIL 
+			email = System.getProperty(gitVariableKey);
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
@@ -957,4 +1038,20 @@ private static boolean eq(final String a, final String b) {
 			return a.equalsIgnoreCase(b);
 		}
 	}
+
+	/**
+	 * @return the hostname
+	 */
+	public String getHostname() {
+		if (hostname == null) {
+			InetAddress localMachine;
+			try {
+				localMachine = InetAddress.getLocalHost();
+				hostname = localMachine.getHostName();
+			} catch (UnknownHostException e) {
+				// we do nothing
+			}
+		}
+		return hostname;
+	}
 }
-- 
1.6.0.6

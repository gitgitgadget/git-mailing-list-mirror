From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 09/19] Refactor Config hierarchy to make IO more explicit
Date: Sat, 25 Jul 2009 11:52:52 -0700
Message-ID: <1248547982-4003-10-git-send-email-spearce@spearce.org>
References: <1248547982-4003-1-git-send-email-spearce@spearce.org>
 <1248547982-4003-2-git-send-email-spearce@spearce.org>
 <1248547982-4003-3-git-send-email-spearce@spearce.org>
 <1248547982-4003-4-git-send-email-spearce@spearce.org>
 <1248547982-4003-5-git-send-email-spearce@spearce.org>
 <1248547982-4003-6-git-send-email-spearce@spearce.org>
 <1248547982-4003-7-git-send-email-spearce@spearce.org>
 <1248547982-4003-8-git-send-email-spearce@spearce.org>
 <1248547982-4003-9-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org,
	Constantine Plotnikov <constantine.plotnikov@gmail.com>
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sat Jul 25 20:54:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUmO7-0002ZF-G3
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 20:54:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752315AbZGYSxg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 14:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752192AbZGYSxf
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 14:53:35 -0400
Received: from george.spearce.org ([209.20.77.23]:35565 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752169AbZGYSxK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 14:53:10 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 6A53538265; Sat, 25 Jul 2009 18:53:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 89BE838196;
	Sat, 25 Jul 2009 18:53:05 +0000 (UTC)
X-Mailer: git-send-email 1.6.4.rc2.216.g769fa
In-Reply-To: <1248547982-4003-9-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124048>

Accessing a config file may or may not require IO, e.g. if we are
reading a file that was already loaded from a blob in the repository
then there is no additional IO required.  Moving the IO portions out
of the base Config class helps to isolate it to only where we really
know we have to do IO, making it easier to handle the IO conditions.

This makes it easier to deal with test cases for config files, as
we no longer need to perform local disk IO just to test the parse
and formatting logic.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
CC: Constantine Plotnikov <constantine.plotnikov@gmail.com>
---
 .../org/spearce/jgit/lib/RepositoryConfigTest.java |  138 +++----
 .../tst/org/spearce/jgit/lib/T0003_Basic.java      |   16 +-
 .../spearce/jgit/transport/RemoteConfigTest.java   |  166 ++++-----
 .../jgit/errors/ConfigInvalidException.java        |   53 +++
 .../src/org/spearce/jgit/lib/BlobBasedConfig.java  |  110 ++----
 .../src/org/spearce/jgit/lib/Config.java           |  410 ++++++++++----------
 .../src/org/spearce/jgit/lib/FileBasedConfig.java  |   83 +++--
 .../src/org/spearce/jgit/lib/Repository.java       |   24 +-
 .../src/org/spearce/jgit/lib/RepositoryConfig.java |   19 +-
 9 files changed, 507 insertions(+), 512 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/errors/ConfigInvalidException.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryConfigTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryConfigTest.java
index e320679..d4a6dd2 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryConfigTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryConfigTest.java
@@ -40,86 +40,77 @@
 
 package org.spearce.jgit.lib;
 
-import java.io.File;
-import java.io.IOException;
 import java.util.Arrays;
 import java.util.LinkedList;
 
+import junit.framework.TestCase;
+
+import org.spearce.jgit.errors.ConfigInvalidException;
 import org.spearce.jgit.util.SystemReader;
 
 /**
  * Test reading of git config
  */
-public class RepositoryConfigTest extends RepositoryTestCase {
-	/**
-	 * Read config item with no value from a section without a subsection.
-	 *
-	 * @throws IOException
-	 */
-	public void test001_ReadBareKey() throws IOException {
-		final RepositoryConfig repositoryConfig = read("[foo]\nbar\n");
-		assertEquals(true, repositoryConfig.getBoolean("foo", null, "bar", false));
-		assertEquals("", repositoryConfig.getString("foo", null, "bar"));
+public class RepositoryConfigTest extends TestCase {
+	public void test001_ReadBareKey() throws ConfigInvalidException {
+		final Config c = parse("[foo]\nbar\n");
+		assertEquals(true, c.getBoolean("foo", null, "bar", false));
+		assertEquals("", c.getString("foo", null, "bar"));
 	}
 
-	/**
-	 * Read various data from a subsection.
-	 *
-	 * @throws IOException
-	 */
-	public void test002_ReadWithSubsection() throws IOException {
-		final RepositoryConfig repositoryConfig = read("[foo \"zip\"]\nbar\n[foo \"zap\"]\nbar=false\nn=3\n");
-		assertEquals(true, repositoryConfig.getBoolean("foo", "zip", "bar", false));
-		assertEquals("", repositoryConfig.getString("foo","zip", "bar"));
-		assertEquals(false, repositoryConfig.getBoolean("foo", "zap", "bar", true));
-		assertEquals("false", repositoryConfig.getString("foo", "zap", "bar"));
-		assertEquals(3, repositoryConfig.getInt("foo", "zap", "n", 4));
-		assertEquals(4, repositoryConfig.getInt("foo", "zap","m", 4));
+	public void test002_ReadWithSubsection() throws ConfigInvalidException {
+		final Config c = parse("[foo \"zip\"]\nbar\n[foo \"zap\"]\nbar=false\nn=3\n");
+		assertEquals(true, c.getBoolean("foo", "zip", "bar", false));
+		assertEquals("", c.getString("foo","zip", "bar"));
+		assertEquals(false, c.getBoolean("foo", "zap", "bar", true));
+		assertEquals("false", c.getString("foo", "zap", "bar"));
+		assertEquals(3, c.getInt("foo", "zap", "n", 4));
+		assertEquals(4, c.getInt("foo", "zap","m", 4));
 	}
 
-	public void test003_PutRemote() throws IOException {
-		File cfgFile = writeTrashFile("config_003", "");
-		RepositoryConfig repositoryConfig = new RepositoryConfig(null, cfgFile);
-		repositoryConfig.setString("sec", "ext", "name", "value");
-		repositoryConfig.setString("sec", "ext", "name2", "value2");
-		repositoryConfig.save();
-		checkFile(cfgFile, "[sec \"ext\"]\n\tname = value\n\tname2 = value2\n");
+	public void test003_PutRemote() {
+		final Config c = new Config();
+		c.setString("sec", "ext", "name", "value");
+		c.setString("sec", "ext", "name2", "value2");
+		final String expText = "[sec \"ext\"]\n\tname = value\n\tname2 = value2\n";
+		assertEquals(expText, c.toText());
 	}
 
-	public void test004_PutGetSimple() throws IOException {
-		File cfgFile = writeTrashFile("config_004", "");
-		RepositoryConfig repositoryConfig = new RepositoryConfig(null, cfgFile);
-		repositoryConfig.setString("my", null, "somename", "false");
-		repositoryConfig.save();
-		checkFile(cfgFile, "[my]\n\tsomename = false\n");
-		assertEquals("false", repositoryConfig
-				.getString("my", null, "somename"));
+	public void test004_PutGetSimple() {
+		Config c = new Config();
+		c.setString("my", null, "somename", "false");
+		assertEquals("false", c.getString("my", null, "somename"));
+		assertEquals("[my]\n\tsomename = false\n", c.toText());
 	}
 
-	public void test005_PutGetStringList() throws IOException {
-		File cfgFile = writeTrashFile("config_005", "");
-		RepositoryConfig repositoryConfig = new RepositoryConfig(null, cfgFile);
+	public void test005_PutGetStringList() {
+		Config c = new Config();
 		final LinkedList<String> values = new LinkedList<String>();
 		values.add("value1");
 		values.add("value2");
-		repositoryConfig.setStringList("my", null, "somename", values);
-		repositoryConfig.save();
-		assertTrue(Arrays.equals(values.toArray(), repositoryConfig
-				.getStringList("my", null, "somename")));
-		checkFile(cfgFile, "[my]\n\tsomename = value1\n\tsomename = value2\n");
+		c.setStringList("my", null, "somename", values);		
+
+		final Object[] expArr = values.toArray();
+		final String[] actArr = c.getStringList("my", null, "somename");
+		assertTrue(Arrays.equals(expArr, actArr));
+
+		final String expText = "[my]\n\tsomename = value1\n\tsomename = value2\n";
+		assertEquals(expText, c.toText());
 	}
 
-	public void test006_readCaseInsensitive() throws IOException {
-		final RepositoryConfig repositoryConfig = read("[Foo]\nBar\n");
-		assertEquals(true, repositoryConfig.getBoolean("foo", null, "bar", false));
-		assertEquals("", repositoryConfig.getString("foo", null, "bar"));
+	public void test006_readCaseInsensitive() throws ConfigInvalidException {
+		final Config c = parse("[Foo]\nBar\n");
+		assertEquals(true, c.getBoolean("foo", null, "bar", false));
+		assertEquals("", c.getString("foo", null, "bar"));
 	}
 
 	public void test007_readUserConfig() {
-		final MockSystemReader mockSystemReader = (MockSystemReader)SystemReader.getInstance();
+		final MockSystemReader mockSystemReader = new MockSystemReader();
+		SystemReader.setInstance(mockSystemReader);
 		final String hostname = mockSystemReader.getHostname();
 		final Config userGitConfig = mockSystemReader.userGitConfig;
-		final RepositoryConfig localConfig = db.getConfig();
+		final RepositoryConfig localConfig = new RepositoryConfig(userGitConfig, null);
+		localConfig.create();
 		mockSystemReader.values.clear();
 
 		String authorName;
@@ -171,8 +162,8 @@ public void test007_readUserConfig() {
 		assertEquals("author@localemail", authorEmail);
 	}
 
-	public void testReadBoolean_TrueFalse1() throws IOException {
-		final RepositoryConfig c = read("[s]\na = true\nb = false\n");
+	public void testReadBoolean_TrueFalse1() throws ConfigInvalidException {
+		final Config c = parse("[s]\na = true\nb = false\n");
 		assertEquals("true", c.getString("s", null, "a"));
 		assertEquals("false", c.getString("s", null, "b"));
 
@@ -180,8 +171,8 @@ public void testReadBoolean_TrueFalse1() throws IOException {
 		assertFalse(c.getBoolean("s", "b", true));
 	}
 
-	public void testReadBoolean_TrueFalse2() throws IOException {
-		final RepositoryConfig c = read("[s]\na = TrUe\nb = fAlSe\n");
+	public void testReadBoolean_TrueFalse2() throws ConfigInvalidException {
+		final Config c = parse("[s]\na = TrUe\nb = fAlSe\n");
 		assertEquals("TrUe", c.getString("s", null, "a"));
 		assertEquals("fAlSe", c.getString("s", null, "b"));
 
@@ -189,8 +180,8 @@ public void testReadBoolean_TrueFalse2() throws IOException {
 		assertFalse(c.getBoolean("s", "b", true));
 	}
 
-	public void testReadBoolean_YesNo1() throws IOException {
-		final RepositoryConfig c = read("[s]\na = yes\nb = no\n");
+	public void testReadBoolean_YesNo1() throws ConfigInvalidException {
+		final Config c = parse("[s]\na = yes\nb = no\n");
 		assertEquals("yes", c.getString("s", null, "a"));
 		assertEquals("no", c.getString("s", null, "b"));
 
@@ -198,8 +189,8 @@ public void testReadBoolean_YesNo1() throws IOException {
 		assertFalse(c.getBoolean("s", "b", true));
 	}
 
-	public void testReadBoolean_YesNo2() throws IOException {
-		final RepositoryConfig c = read("[s]\na = yEs\nb = NO\n");
+	public void testReadBoolean_YesNo2() throws ConfigInvalidException {
+		final Config c = parse("[s]\na = yEs\nb = NO\n");
 		assertEquals("yEs", c.getString("s", null, "a"));
 		assertEquals("NO", c.getString("s", null, "b"));
 
@@ -207,8 +198,8 @@ public void testReadBoolean_YesNo2() throws IOException {
 		assertFalse(c.getBoolean("s", "b", true));
 	}
 
-	public void testReadBoolean_OnOff1() throws IOException {
-		final RepositoryConfig c = read("[s]\na = on\nb = off\n");
+	public void testReadBoolean_OnOff1() throws ConfigInvalidException {
+		final Config c = parse("[s]\na = on\nb = off\n");
 		assertEquals("on", c.getString("s", null, "a"));
 		assertEquals("off", c.getString("s", null, "b"));
 
@@ -216,8 +207,8 @@ public void testReadBoolean_OnOff1() throws IOException {
 		assertFalse(c.getBoolean("s", "b", true));
 	}
 
-	public void testReadBoolean_OnOff2() throws IOException {
-		final RepositoryConfig c = read("[s]\na = ON\nb = OFF\n");
+	public void testReadBoolean_OnOff2() throws ConfigInvalidException {
+		final Config c = parse("[s]\na = ON\nb = OFF\n");
 		assertEquals("ON", c.getString("s", null, "a"));
 		assertEquals("OFF", c.getString("s", null, "b"));
 
@@ -225,7 +216,7 @@ public void testReadBoolean_OnOff2() throws IOException {
 		assertFalse(c.getBoolean("s", "b", true));
 	}
 
-	public void testReadLong() throws IOException {
+	public void testReadLong() throws ConfigInvalidException {
 		assertReadLong(1L);
 		assertReadLong(-1L);
 		assertReadLong(Long.MIN_VALUE);
@@ -242,18 +233,19 @@ public void testReadLong() throws IOException {
 		}
 	}
 
-	private void assertReadLong(long exp) throws IOException {
+	private void assertReadLong(long exp) throws ConfigInvalidException {
 		assertReadLong(exp, String.valueOf(exp));
 	}
 
-	private void assertReadLong(long exp, String act) throws IOException {
-		final RepositoryConfig c = read("[s]\na = " + act + "\n");
+	private void assertReadLong(long exp, String act)
+			throws ConfigInvalidException {
+		final Config c = parse("[s]\na = " + act + "\n");
 		assertEquals(exp, c.getLong("s", null, "a", 0L));
 	}
 
-	private RepositoryConfig read(final String content) throws IOException {
-		final File p = writeTrashFile(getName() + ".config", content);
-		final RepositoryConfig c = new RepositoryConfig(null, p);
+	private Config parse(final String content) throws ConfigInvalidException {
+		final Config c = new Config(null);
+		c.fromText(content);
 		return c;
 	}
 }
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0003_Basic.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0003_Basic.java
index df55b4f..3660b45 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0003_Basic.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0003_Basic.java
@@ -47,6 +47,8 @@
 import java.io.IOException;
 import java.io.PrintWriter;
 
+import org.spearce.jgit.errors.ConfigInvalidException;
+
 public class T0003_Basic extends RepositoryTestCase {
 	public void test001_Initalize() {
 		final File gitdir = new File(trash, ".git");
@@ -118,7 +120,7 @@ public void test003_WriteShouldBeEmptyTree() throws IOException {
 		assertTrue("Read-only " + o, !o.canWrite());
 	}
 
-	public void test004_CheckNewConfig() throws IOException {
+	public void test004_CheckNewConfig() {
 		final RepositoryConfig c = db.getConfig();
 		assertNotNull(c);
 		assertEquals("0", c.getString("core", null, "repositoryformatversion"));
@@ -126,13 +128,11 @@ public void test004_CheckNewConfig() throws IOException {
 		assertEquals("true", c.getString("core", null, "filemode"));
 		assertEquals("true", c.getString("cOrE", null, "fIlEModE"));
 		assertNull(c.getString("notavalue", null, "reallyNotAValue"));
-		c.load();
 	}
 
-	public void test005_ReadSimpleConfig() throws IOException {
+	public void test005_ReadSimpleConfig() {
 		final RepositoryConfig c = db.getConfig();
 		assertNotNull(c);
-		c.load();
 		assertEquals("0", c.getString("core", null, "repositoryformatversion"));
 		assertEquals("0", c.getString("CoRe", null, "REPOSITORYFoRmAtVeRsIoN"));
 		assertEquals("true", c.getString("core", null, "filemode"));
@@ -140,7 +140,8 @@ public void test005_ReadSimpleConfig() throws IOException {
 		assertNull(c.getString("notavalue", null, "reallyNotAValue"));
 	}
 
-	public void test006_ReadUglyConfig() throws IOException {
+	public void test006_ReadUglyConfig() throws IOException,
+			ConfigInvalidException {
 		final RepositoryConfig c = db.getConfig();
 		final File cfg = new File(db.getDirectory(), "config");
 		final FileWriter pw = new FileWriter(cfg);
@@ -192,7 +193,8 @@ public void test008_FailOnWrongVersion() throws IOException {
 		}
 	}
 
-	public void test009_CreateCommitOldFormat() throws IOException {
+	public void test009_CreateCommitOldFormat() throws IOException,
+			ConfigInvalidException {
 		writeTrashFile(".git/config", "[core]\n" + "legacyHeaders=1\n");
 		db.getConfig().load();
 
@@ -417,8 +419,6 @@ public void test025_computeSha1NoStore() throws IOException {
 	}
 
 	public void test026_CreateCommitMultipleparents() throws IOException {
-		db.getConfig().load();
-
 		final Tree t = new Tree(db);
 		final FileTreeEntry f = t.addFile("i-am-a-file");
 		writeTrashFile(f.getName(), "and this is the data in me\n");
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/transport/RemoteConfigTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/transport/RemoteConfigTest.java
index 3965bdb..752019d 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/transport/RemoteConfigTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/transport/RemoteConfigTest.java
@@ -38,26 +38,28 @@
 
 package org.spearce.jgit.transport;
 
-import java.io.File;
-import java.io.FileNotFoundException;
-import java.io.FileOutputStream;
-import java.io.IOException;
-import java.io.UnsupportedEncodingException;
 import java.util.List;
 
-import org.spearce.jgit.lib.RepositoryTestCase;
-
-public class RemoteConfigTest extends RepositoryTestCase {
-	private void writeConfig(final String dat) throws FileNotFoundException,
-			IOException, UnsupportedEncodingException {
-		final File file = new File(db.getDirectory(), "config");
-		final FileOutputStream stream = new FileOutputStream(file, true);
-		try {
-			stream.write(dat.getBytes("UTF-8"));
-		} finally {
-			stream.close();
-		}
-		db.getConfig().load();
+import junit.framework.TestCase;
+
+import org.spearce.jgit.errors.ConfigInvalidException;
+import org.spearce.jgit.lib.Config;
+
+public class RemoteConfigTest extends TestCase {
+	private Config config;
+
+	protected void setUp() throws Exception {
+		super.setUp();
+		config = new Config();
+	}
+
+	private void readConfig(final String dat) throws ConfigInvalidException {
+		config = new Config();
+		config.fromText(dat);
+	}
+
+	private void checkConfig(final String exp) {
+		assertEquals(exp, config.toText());
 	}
 
 	private static void assertEquals(final String exp, final URIish act) {
@@ -65,11 +67,11 @@ private static void assertEquals(final String exp, final URIish act) {
 	}
 
 	public void testSimple() throws Exception {
-		writeConfig("[remote \"spearce\"]\n"
+		readConfig("[remote \"spearce\"]\n"
 				+ "url = http://www.spearce.org/egit.git\n"
 				+ "fetch = +refs/heads/*:refs/remotes/spearce/*\n");
 
-		final RemoteConfig rc = new RemoteConfig(db.getConfig(), "spearce");
+		final RemoteConfig rc = new RemoteConfig(config, "spearce");
 		final List<URIish> allURIs = rc.getURIs();
 		RefSpec spec;
 
@@ -95,30 +97,30 @@ public void testSimple() throws Exception {
 	}
 
 	public void testSimpleNoTags() throws Exception {
-		writeConfig("[remote \"spearce\"]\n"
+		readConfig("[remote \"spearce\"]\n"
 				+ "url = http://www.spearce.org/egit.git\n"
 				+ "fetch = +refs/heads/*:refs/remotes/spearce/*\n"
 				+ "tagopt = --no-tags\n");
-		final RemoteConfig rc = new RemoteConfig(db.getConfig(), "spearce");
+		final RemoteConfig rc = new RemoteConfig(config, "spearce");
 		assertSame(TagOpt.NO_TAGS, rc.getTagOpt());
 	}
 
 	public void testSimpleAlwaysTags() throws Exception {
-		writeConfig("[remote \"spearce\"]\n"
+		readConfig("[remote \"spearce\"]\n"
 				+ "url = http://www.spearce.org/egit.git\n"
 				+ "fetch = +refs/heads/*:refs/remotes/spearce/*\n"
 				+ "tagopt = --tags\n");
-		final RemoteConfig rc = new RemoteConfig(db.getConfig(), "spearce");
+		final RemoteConfig rc = new RemoteConfig(config, "spearce");
 		assertSame(TagOpt.FETCH_TAGS, rc.getTagOpt());
 	}
 
 	public void testMirror() throws Exception {
-		writeConfig("[remote \"spearce\"]\n"
+		readConfig("[remote \"spearce\"]\n"
 				+ "url = http://www.spearce.org/egit.git\n"
 				+ "fetch = +refs/heads/*:refs/heads/*\n"
 				+ "fetch = refs/tags/*:refs/tags/*\n");
 
-		final RemoteConfig rc = new RemoteConfig(db.getConfig(), "spearce");
+		final RemoteConfig rc = new RemoteConfig(config, "spearce");
 		final List<URIish> allURIs = rc.getURIs();
 		RefSpec spec;
 
@@ -148,13 +150,13 @@ public void testMirror() throws Exception {
 	}
 
 	public void testBackup() throws Exception {
-		writeConfig("[remote \"backup\"]\n"
+		readConfig("[remote \"backup\"]\n"
 				+ "url = http://www.spearce.org/egit.git\n"
 				+ "url = user@repo.or.cz:/srv/git/egit.git\n"
 				+ "push = +refs/heads/*:refs/heads/*\n"
 				+ "push = refs/tags/*:refs/tags/*\n");
 
-		final RemoteConfig rc = new RemoteConfig(db.getConfig(), "backup");
+		final RemoteConfig rc = new RemoteConfig(config, "backup");
 		final List<URIish> allURIs = rc.getURIs();
 		RefSpec spec;
 
@@ -184,13 +186,13 @@ public void testBackup() throws Exception {
 	}
 
 	public void testUploadPack() throws Exception {
-		writeConfig("[remote \"example\"]\n"
+		readConfig("[remote \"example\"]\n"
 				+ "url = user@example.com:egit.git\n"
 				+ "fetch = +refs/heads/*:refs/remotes/example/*\n"
 				+ "uploadpack = /path/to/git/git-upload-pack\n"
 				+ "receivepack = /path/to/git/git-receive-pack\n");
 
-		final RemoteConfig rc = new RemoteConfig(db.getConfig(), "example");
+		final RemoteConfig rc = new RemoteConfig(config, "example");
 		final List<URIish> allURIs = rc.getURIs();
 		RefSpec spec;
 
@@ -216,9 +218,9 @@ public void testUploadPack() throws Exception {
 	}
 
 	public void testUnknown() throws Exception {
-		writeConfig("");
+		readConfig("");
 
-		final RemoteConfig rc = new RemoteConfig(db.getConfig(), "backup");
+		final RemoteConfig rc = new RemoteConfig(config, "backup");
 		assertEquals(0, rc.getURIs().size());
 		assertEquals(0, rc.getFetchRefSpecs().size());
 		assertEquals(0, rc.getPushRefSpecs().size());
@@ -227,10 +229,10 @@ public void testUnknown() throws Exception {
 	}
 
 	public void testAddURI() throws Exception {
-		writeConfig("");
+		readConfig("");
 
 		final URIish uri = new URIish("/some/dir");
-		final RemoteConfig rc = new RemoteConfig(db.getConfig(), "backup");
+		final RemoteConfig rc = new RemoteConfig(config, "backup");
 		assertEquals(0, rc.getURIs().size());
 
 		assertTrue(rc.addURI(uri));
@@ -242,12 +244,12 @@ public void testAddURI() throws Exception {
 	}
 
 	public void testRemoveFirstURI() throws Exception {
-		writeConfig("");
+		readConfig("");
 
 		final URIish a = new URIish("/some/dir");
 		final URIish b = new URIish("/another/dir");
 		final URIish c = new URIish("/more/dirs");
-		final RemoteConfig rc = new RemoteConfig(db.getConfig(), "backup");
+		final RemoteConfig rc = new RemoteConfig(config, "backup");
 		assertTrue(rc.addURI(a));
 		assertTrue(rc.addURI(b));
 		assertTrue(rc.addURI(c));
@@ -264,12 +266,12 @@ public void testRemoveFirstURI() throws Exception {
 	}
 
 	public void testRemoveMiddleURI() throws Exception {
-		writeConfig("");
+		readConfig("");
 
 		final URIish a = new URIish("/some/dir");
 		final URIish b = new URIish("/another/dir");
 		final URIish c = new URIish("/more/dirs");
-		final RemoteConfig rc = new RemoteConfig(db.getConfig(), "backup");
+		final RemoteConfig rc = new RemoteConfig(config, "backup");
 		assertTrue(rc.addURI(a));
 		assertTrue(rc.addURI(b));
 		assertTrue(rc.addURI(c));
@@ -286,12 +288,12 @@ public void testRemoveMiddleURI() throws Exception {
 	}
 
 	public void testRemoveLastURI() throws Exception {
-		writeConfig("");
+		readConfig("");
 
 		final URIish a = new URIish("/some/dir");
 		final URIish b = new URIish("/another/dir");
 		final URIish c = new URIish("/more/dirs");
-		final RemoteConfig rc = new RemoteConfig(db.getConfig(), "backup");
+		final RemoteConfig rc = new RemoteConfig(config, "backup");
 		assertTrue(rc.addURI(a));
 		assertTrue(rc.addURI(b));
 		assertTrue(rc.addURI(c));
@@ -308,10 +310,10 @@ public void testRemoveLastURI() throws Exception {
 	}
 
 	public void testRemoveOnlyURI() throws Exception {
-		writeConfig("");
+		readConfig("");
 
 		final URIish a = new URIish("/some/dir");
-		final RemoteConfig rc = new RemoteConfig(db.getConfig(), "backup");
+		final RemoteConfig rc = new RemoteConfig(config, "backup");
 		assertTrue(rc.addURI(a));
 
 		assertEquals(1, rc.getURIs().size());
@@ -322,130 +324,102 @@ public void testRemoveOnlyURI() throws Exception {
 	}
 
 	public void testCreateOrigin() throws Exception {
-		final RemoteConfig rc = new RemoteConfig(db.getConfig(), "origin");
+		final RemoteConfig rc = new RemoteConfig(config, "origin");
 		rc.addURI(new URIish("/some/dir"));
 		rc.addFetchRefSpec(new RefSpec("+refs/heads/*:refs/remotes/"
 				+ rc.getName() + "/*"));
-		rc.update(db.getConfig());
-		db.getConfig().save();
-
-		checkFile(new File(db.getDirectory(), "config"), "[core]\n"
-				+ "\trepositoryformatversion = 0\n" + "\tfilemode = true\n"
-				+ "[remote \"origin\"]\n" + "\turl = /some/dir\n"
+		rc.update(config);
+		checkConfig("[remote \"origin\"]\n" + "\turl = /some/dir\n"
 				+ "\tfetch = +refs/heads/*:refs/remotes/origin/*\n");
 	}
 
 	public void testSaveAddURI() throws Exception {
-		writeConfig("[remote \"spearce\"]\n"
+		readConfig("[remote \"spearce\"]\n"
 				+ "url = http://www.spearce.org/egit.git\n"
 				+ "fetch = +refs/heads/*:refs/remotes/spearce/*\n");
 
-		final RemoteConfig rc = new RemoteConfig(db.getConfig(), "spearce");
+		final RemoteConfig rc = new RemoteConfig(config, "spearce");
 		rc.addURI(new URIish("/some/dir"));
 		assertEquals(2, rc.getURIs().size());
-		rc.update(db.getConfig());
-		db.getConfig().save();
-
-		checkFile(new File(db.getDirectory(), "config"), "[core]\n"
-				+ "\trepositoryformatversion = 0\n" + "\tfilemode = true\n"
-				+ "[remote \"spearce\"]\n"
+		rc.update(config);
+		checkConfig("[remote \"spearce\"]\n"
 				+ "\turl = http://www.spearce.org/egit.git\n"
 				+ "\turl = /some/dir\n"
 				+ "\tfetch = +refs/heads/*:refs/remotes/spearce/*\n");
 	}
 
 	public void testSaveRemoveLastURI() throws Exception {
-		writeConfig("[remote \"spearce\"]\n"
+		readConfig("[remote \"spearce\"]\n"
 				+ "url = http://www.spearce.org/egit.git\n"
 				+ "url = /some/dir\n"
 				+ "fetch = +refs/heads/*:refs/remotes/spearce/*\n");
 
-		final RemoteConfig rc = new RemoteConfig(db.getConfig(), "spearce");
+		final RemoteConfig rc = new RemoteConfig(config, "spearce");
 		assertEquals(2, rc.getURIs().size());
 		rc.removeURI(new URIish("/some/dir"));
 		assertEquals(1, rc.getURIs().size());
-		rc.update(db.getConfig());
-		db.getConfig().save();
-
-		checkFile(new File(db.getDirectory(), "config"), "[core]\n"
-				+ "\trepositoryformatversion = 0\n" + "\tfilemode = true\n"
-				+ "[remote \"spearce\"]\n"
+		rc.update(config);
+		checkConfig("[remote \"spearce\"]\n"
 				+ "\turl = http://www.spearce.org/egit.git\n"
 				+ "\tfetch = +refs/heads/*:refs/remotes/spearce/*\n");
 	}
 
 	public void testSaveRemoveFirstURI() throws Exception {
-		writeConfig("[remote \"spearce\"]\n"
+		readConfig("[remote \"spearce\"]\n"
 				+ "url = http://www.spearce.org/egit.git\n"
 				+ "url = /some/dir\n"
 				+ "fetch = +refs/heads/*:refs/remotes/spearce/*\n");
 
-		final RemoteConfig rc = new RemoteConfig(db.getConfig(), "spearce");
+		final RemoteConfig rc = new RemoteConfig(config, "spearce");
 		assertEquals(2, rc.getURIs().size());
 		rc.removeURI(new URIish("http://www.spearce.org/egit.git"));
 		assertEquals(1, rc.getURIs().size());
-		rc.update(db.getConfig());
-		db.getConfig().save();
-
-		checkFile(new File(db.getDirectory(), "config"), "[core]\n"
-				+ "\trepositoryformatversion = 0\n" + "\tfilemode = true\n"
-				+ "[remote \"spearce\"]\n" + "\turl = /some/dir\n"
+		rc.update(config);
+		checkConfig("[remote \"spearce\"]\n" + "\turl = /some/dir\n"
 				+ "\tfetch = +refs/heads/*:refs/remotes/spearce/*\n");
 	}
 
 	public void testSaveNoTags() throws Exception {
-		final RemoteConfig rc = new RemoteConfig(db.getConfig(), "origin");
+		final RemoteConfig rc = new RemoteConfig(config, "origin");
 		rc.addURI(new URIish("/some/dir"));
 		rc.addFetchRefSpec(new RefSpec("+refs/heads/*:refs/remotes/"
 				+ rc.getName() + "/*"));
 		rc.setTagOpt(TagOpt.NO_TAGS);
-		rc.update(db.getConfig());
-		db.getConfig().save();
-
-		checkFile(new File(db.getDirectory(), "config"), "[core]\n"
-				+ "\trepositoryformatversion = 0\n" + "\tfilemode = true\n"
-				+ "[remote \"origin\"]\n" + "\turl = /some/dir\n"
+		rc.update(config);
+		checkConfig("[remote \"origin\"]\n" + "\turl = /some/dir\n"
 				+ "\tfetch = +refs/heads/*:refs/remotes/origin/*\n"
 				+ "\ttagopt = --no-tags\n");
 	}
 
 	public void testSaveAllTags() throws Exception {
-		final RemoteConfig rc = new RemoteConfig(db.getConfig(), "origin");
+		final RemoteConfig rc = new RemoteConfig(config, "origin");
 		rc.addURI(new URIish("/some/dir"));
 		rc.addFetchRefSpec(new RefSpec("+refs/heads/*:refs/remotes/"
 				+ rc.getName() + "/*"));
 		rc.setTagOpt(TagOpt.FETCH_TAGS);
-		rc.update(db.getConfig());
-		db.getConfig().save();
-
-		checkFile(new File(db.getDirectory(), "config"), "[core]\n"
-				+ "\trepositoryformatversion = 0\n" + "\tfilemode = true\n"
-				+ "[remote \"origin\"]\n" + "\turl = /some/dir\n"
+		rc.update(config);
+		checkConfig("[remote \"origin\"]\n" + "\turl = /some/dir\n"
 				+ "\tfetch = +refs/heads/*:refs/remotes/origin/*\n"
 				+ "\ttagopt = --tags\n");
 	}
 
 	public void testSimpleTimeout() throws Exception {
-		writeConfig("[remote \"spearce\"]\n"
+		readConfig("[remote \"spearce\"]\n"
 				+ "url = http://www.spearce.org/egit.git\n"
 				+ "fetch = +refs/heads/*:refs/remotes/spearce/*\n"
 				+ "timeout = 12\n");
-		final RemoteConfig rc = new RemoteConfig(db.getConfig(), "spearce");
+		final RemoteConfig rc = new RemoteConfig(config, "spearce");
 		assertEquals(12, rc.getTimeout());
 	}
 
 	public void testSaveTimeout() throws Exception {
-		final RemoteConfig rc = new RemoteConfig(db.getConfig(), "origin");
+		final RemoteConfig rc = new RemoteConfig(config, "origin");
 		rc.addURI(new URIish("/some/dir"));
 		rc.addFetchRefSpec(new RefSpec("+refs/heads/*:refs/remotes/"
 				+ rc.getName() + "/*"));
 		rc.setTimeout(60);
-		rc.update(db.getConfig());
-		db.getConfig().save();
-
-		checkFile(new File(db.getDirectory(), "config"), "[core]\n"
-				+ "\trepositoryformatversion = 0\n" + "\tfilemode = true\n"
-				+ "[remote \"origin\"]\n" + "\turl = /some/dir\n"
+		rc.update(config);
+		checkConfig("[remote \"origin\"]\n" + "\turl = /some/dir\n"
 				+ "\tfetch = +refs/heads/*:refs/remotes/origin/*\n"
 				+ "\ttimeout = 60\n");
 	}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/errors/ConfigInvalidException.java b/org.spearce.jgit/src/org/spearce/jgit/errors/ConfigInvalidException.java
new file mode 100644
index 0000000..ae6ad58
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/errors/ConfigInvalidException.java
@@ -0,0 +1,53 @@
+/*
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
+package org.spearce.jgit.errors;
+
+/** Indicates a text string is not a valid Git style configuration. */
+public class ConfigInvalidException extends Exception {
+	private static final long serialVersionUID = 1L;
+
+	/**
+	 * Construct an invalid configuration error.
+	 * 
+	 * @param message
+	 *            why the configuration is invalid.
+	 */
+	public ConfigInvalidException(final String message) {
+		super(message);
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/BlobBasedConfig.java b/org.spearce.jgit/src/org/spearce/jgit/lib/BlobBasedConfig.java
index 8763c6c..e97d797 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/BlobBasedConfig.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/BlobBasedConfig.java
@@ -36,111 +36,85 @@
  */
 package org.spearce.jgit.lib;
 
-import java.io.ByteArrayInputStream;
 import java.io.FileNotFoundException;
 import java.io.IOException;
-import java.io.InputStream;
-import java.util.concurrent.Callable;
 
+import org.spearce.jgit.errors.ConfigInvalidException;
 import org.spearce.jgit.treewalk.TreeWalk;
+import org.spearce.jgit.util.RawParseUtils;
 
 /**
  * The configuration file based on the blobs stored in the repository
  */
 public class BlobBasedConfig extends Config {
-	private Callable<byte[]> blobProvider;
-
-	/**
-	 * The constructor for blob based config
-	 *
-	 * @param base
-	 *            the base configuration file
-	 * @param blob
-	 *            the provider for blobs
-	 */
-	public BlobBasedConfig(Config base, Callable<byte[]> blob) {
-		super(base);
-		blobProvider = blob;
-	}
-
 	/**
 	 * The constructor from a byte array
-	 *
+	 * 
 	 * @param base
 	 *            the base configuration file
 	 * @param blob
-	 *            the byte array
+	 *            the byte array, should be UTF-8 encoded text.
+	 * @throws ConfigInvalidException
+	 *             the byte array is not a valid configuration format.
 	 */
-	public BlobBasedConfig(Config base, final byte[] blob) {
-		this(base, new Callable<byte[]>() {
-			public byte[] call() throws Exception {
-				return blob;
-			}
-		});
+	public BlobBasedConfig(Config base, final byte[] blob)
+			throws ConfigInvalidException {
+		super(base);
+		fromText(RawParseUtils.decode(blob));
 	}
 
 	/**
 	 * The constructor from object identifier
-	 *
+	 * 
 	 * @param base
 	 *            the base configuration file
 	 * @param r
 	 *            the repository
 	 * @param objectId
 	 *            the object identifier
+	 * @throws IOException
+	 *             the blob cannot be read from the repository.
+	 * @throws ConfigInvalidException
+	 *             the blob is not a valid configuration format.
 	 */
 	public BlobBasedConfig(Config base, final Repository r,
-			final ObjectId objectId) {
-		this(base, new Callable<byte[]>() {
-			public byte[] call() throws Exception {
-				ObjectLoader loader = r.openBlob(objectId);
-				if (loader == null) {
-					throw new IOException("Blob not found: " + objectId);
-				}
-				return loader.getBytes();
-			}
-		});
+			final ObjectId objectId) throws IOException, ConfigInvalidException {
+		super(base);
+		final ObjectLoader loader = r.openBlob(objectId);
+		if (loader == null)
+			throw new IOException("Blob not found: " + objectId);
+		fromText(RawParseUtils.decode(loader.getBytes()));
 	}
 
 	/**
 	 * The constructor from commit and path
-	 *
+	 * 
 	 * @param base
 	 *            the base configuration file
 	 * @param commit
 	 *            the commit that contains the object
 	 * @param path
 	 *            the path within the tree of the commit
+	 * @throws FileNotFoundException
+	 *             the path does not exist in the commit's tree.
+	 * @throws IOException
+	 *             the tree and/or blob cannot be accessed.
+	 * @throws ConfigInvalidException
+	 *             the blob is not a valid configuration format.
 	 */
-	public BlobBasedConfig(Config base, final Commit commit, final String path) {
-		this(base, new Callable<byte[]>() {
-			public byte[] call() throws Exception {
-				final ObjectId treeId = commit.getTreeId();
-				final Repository r = commit.getRepository();
-				final TreeWalk tree = TreeWalk.forPath(r, path, treeId);
-				if (tree == null) {
-					throw new FileNotFoundException("Entry not found by path: " + path);
-				}
-				ObjectId blobId = tree.getObjectId(0);
-				ObjectLoader loader = tree.getRepository().openBlob(blobId);
-				if (loader == null) {
-					throw new IOException("Blob not found: " + blobId + " for path: " + path);
-				}
-				return loader.getBytes();
-			}
-		});
-	}
-
-	@Override
-	protected InputStream openInputStream() throws IOException {
-		try {
-			return new ByteArrayInputStream(blobProvider.call());
-		} catch (IOException e) {
-			throw e;
-		} catch (Exception e) {
-			final IOException e2 = new IOException("Unable to read config");
-			e2.initCause(e);
-			throw e2;
-		}
+	public BlobBasedConfig(Config base, final Commit commit, final String path)
+			throws FileNotFoundException, IOException, ConfigInvalidException {
+		super(base);
+		final ObjectId treeId = commit.getTreeId();
+		final Repository r = commit.getRepository();
+		final TreeWalk tree = TreeWalk.forPath(r, path, treeId);
+		if (tree == null)
+			throw new FileNotFoundException("Entry not found by path: " + path);
+		final ObjectId blobId = tree.getObjectId(0);
+		final ObjectLoader loader = tree.getRepository().openBlob(blobId);
+		if (loader == null)
+			throw new IOException("Blob not found: " + blobId + " for path: "
+					+ path);
+		fromText(RawParseUtils.decode(loader.getBytes()));
 	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java
index a2f5c6a..d63e926 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java
@@ -41,12 +41,6 @@
  */
 package org.spearce.jgit.lib;
 
-import java.io.BufferedReader;
-import java.io.FileNotFoundException;
-import java.io.IOException;
-import java.io.InputStream;
-import java.io.InputStreamReader;
-import java.io.PrintWriter;
 import java.util.ArrayList;
 import java.util.Collections;
 import java.util.HashMap;
@@ -55,19 +49,18 @@
 import java.util.Map;
 import java.util.Set;
 
+import org.spearce.jgit.errors.ConfigInvalidException;
 import org.spearce.jgit.util.StringUtils;
 
+
 /**
- * The configuration file stored in the format similar to the ".git/config"
- * file.
+ * Git style {@code .config}, {@code .gitconfig}, {@code .gitmodules} file.
  */
-public abstract class Config {
+public class Config {
 	private static final long KiB = 1024;
 	private static final long MiB = 1024 * KiB;
 	private static final long GiB = 1024 * MiB;
 
-	private boolean fileRead;
-
 	private List<Entry> entries;
 
 	final Config baseConfig;
@@ -86,26 +79,21 @@
 	 */
 	private static final String MAGIC_EMPTY_VALUE = new String();
 
-	/**
-	 * The constructor for configuration file
-	 *
-	 * @param base
-	 *            the base configuration file to be consulted when value is
-	 *            missing from this file
-	 */
-	protected Config(Config base) {
-		baseConfig = base;
-		clear();
+	/** Create a configuration with no default fallback. */
+	public Config() {
+		this(null);
 	}
 
 	/**
-	 * Set file read indicator
+	 * Create an empty configuration with a fallback for missing keys.
 	 *
-	 * @param ok
-	 *            true if file does not need loading
+	 * @param defaultConfig
+	 *            the base configuration to be consulted when a key is missing
+	 *            from this configuration instance.
 	 */
-	protected void setFileRead(boolean ok) {
-		fileRead = ok;
+	public Config(Config defaultConfig) {
+		baseConfig = defaultConfig;
+		clear();
 	}
 
 	/**
@@ -373,8 +361,6 @@ public String getString(final String section, String subsection,
 	 */
 	public Set<String> getSubsections(final String section) {
 		final Set<String> result = new HashSet<String>();
-		ensureLoaded();
-
 		for (final Entry e : entries) {
 			if (StringUtils.equalsIgnoreCase(section, e.section)
 					&& e.subsection != null)
@@ -398,22 +384,8 @@ private String getRawString(final String section, final String subsection,
 			return null;
 	}
 
-	private void ensureLoaded() {
-		if (!fileRead) {
-			try {
-				load();
-			} catch (FileNotFoundException err) {
-				// Oh well. No sense in complaining about it.
-				//
-			} catch (IOException err) {
-				err.printStackTrace();
-			}
-		}
-	}
-
 	private Object getRawEntry(final String section, final String subsection,
 			final String name) {
-		ensureLoaded();
 		return byName.get(concatenateKey(section, subsection, name));
 	}
 
@@ -678,129 +650,116 @@ private int findSectionEnd(final String section, final String subsection) {
 	}
 
 	/**
-	 * Print configuration file to the PrintWriter
-	 *
-	 * @param r
-	 *             stream to write the configuration to.
+	 * @return this configuration, formatted as a Git style text file.
 	 */
-	protected void printConfig(final PrintWriter r) {
+	public String toText() {
+		final StringBuilder out = new StringBuilder();
 		for (final Entry e : entries) {
-			if (e.prefix != null) {
-				r.print(e.prefix);
-			}
+			if (e.prefix != null)
+				out.append(e.prefix);			
 			if (e.section != null && e.name == null) {
-				r.print('[');
-				r.print(e.section);
+				out.append('[');
+				out.append(e.section);
 				if (e.subsection != null) {
-					r.print(' ');
-					r.print('"');
-					r.print(escapeValue(e.subsection));
-					r.print('"');
+					out.append(' ');
+					out.append('"');
+					out.append(escapeValue(e.subsection));
+					out.append('"');
 				}
-				r.print(']');
+				out.append(']');
 			} else if (e.section != null && e.name != null) {
-				if (e.prefix == null || "".equals(e.prefix)) {
-					r.print('\t');
-				}
-				r.print(e.name);
+				if (e.prefix == null || "".equals(e.prefix))
+					out.append('\t');
+				out.append(e.name);
 				if (e.value != null) {
 					if (MAGIC_EMPTY_VALUE != e.value) {
-						r.print(" = ");
-						r.print(escapeValue(e.value));
+						out.append(" = ");
+						out.append(escapeValue(e.value));
 					}
 				}
-				if (e.suffix != null) {
-					r.print(' ');
-				}
+				if (e.suffix != null)
+					out.append(' ');
 			}
-			if (e.suffix != null) {
-				r.print(e.suffix);
-			}
-			r.print('\n');
+			if (e.suffix != null)
+				out.append(e.suffix);
+			out.append('\n');
 		}
+		return out.toString();
 	}
 
 	/**
-	 * Read the config file
+	 * Clear this configuration and reset to the contents of the parsed string.
 	 *
-	 * @throws IOException in case of IO error
+	 * @param text
+	 *            Git style text file listing configuration properties.
+	 * @throws ConfigInvalidException
+	 *             the text supplied is not formatted correctly. No changes were
+	 *             made to {@code this}.
 	 */
-	public void load() throws IOException {
-		clear();
-		fileRead = true;
-		final BufferedReader r = new BufferedReader(new InputStreamReader(
-				openInputStream(), Constants.CHARSET));
-		try {
-			Entry last = null;
-			Entry e = new Entry();
-			for (;;) {
-				r.mark(1);
-				int input = r.read();
-				final char in = (char) input;
-				if (-1 == input) {
-					break;
-				} else if ('\n' == in) {
-					// End of this entry.
-					add(e);
-					if (e.section != null) {
-						last = e;
-					}
-					e = new Entry();
-				} else if (e.suffix != null) {
-					// Everything up until the end-of-line is in the suffix.
-					e.suffix += in;
-				} else if (';' == in || '#' == in) {
-					// The rest of this line is a comment; put into suffix.
-					e.suffix = String.valueOf(in);
-				} else if (e.section == null && Character.isWhitespace(in)) {
-					// Save the leading whitespace (if any).
-					if (e.prefix == null) {
-						e.prefix = "";
-					}
-					e.prefix += in;
-				} else if ('[' == in) {
-					// This is a section header.
-					e.section = readSectionName(r);
-					input = r.read();
-					if ('"' == input) {
-						e.subsection = readValue(r, true, '"');
-						input = r.read();
-					}
-					if (']' != input) {
-						throw new IOException("Bad group header.");
-					}
-					e.suffix = "";
-				} else if (last != null) {
-					// Read a value.
-					e.section = last.section;
-					e.subsection = last.subsection;
-					r.reset();
-					e.name = readKeyName(r);
-					if (e.name.endsWith("\n")) {
-						e.name = e.name.substring(0, e.name.length() - 1);
-						e.value = MAGIC_EMPTY_VALUE;
-					} else
-						e.value = readValue(r, false, -1);
-				} else {
-					throw new IOException("Invalid line in config file.");
+	public void fromText(final String text) throws ConfigInvalidException {
+		entries = new ArrayList<Entry>();
+		byName = new HashMap<String, Object>();
+
+		final StringReader in = new StringReader(text);
+		Entry last = null;
+		Entry e = new Entry();
+		for (;;) {
+			int input = in.read();
+			if (-1 == input)
+				break;
+
+			final char c = (char) input;
+			if ('\n' == c) {
+				// End of this entry.
+				add(e);
+				if (e.section != null)
+					last = e;
+				e = new Entry();
+
+			} else if (e.suffix != null) {
+				// Everything up until the end-of-line is in the suffix.
+				e.suffix += c;
+
+			} else if (';' == c || '#' == c) {
+				// The rest of this line is a comment; put into suffix.
+				e.suffix = String.valueOf(c);
+
+			} else if (e.section == null && Character.isWhitespace(c)) {
+				// Save the leading whitespace (if any).
+				if (e.prefix == null)
+					e.prefix = "";
+				e.prefix += c;
+
+			} else if ('[' == c) {
+				// This is a section header.
+				e.section = readSectionName(in);
+				input = in.read();
+				if ('"' == input) {
+					e.subsection = readValue(in, true, '"');
+					input = in.read();
 				}
-			}
-		} finally {
-			r.close();
+				if (']' != input)
+					throw new ConfigInvalidException("Bad group header");
+				e.suffix = "";
+
+			} else if (last != null) {
+				// Read a value.
+				e.section = last.section;
+				e.subsection = last.subsection;
+				in.reset();
+				e.name = readKeyName(in);
+				if (e.name.endsWith("\n")) {
+					e.name = e.name.substring(0, e.name.length() - 1);
+					e.value = MAGIC_EMPTY_VALUE;
+				} else
+					e.value = readValue(in, false, -1);
+
+			} else
+				throw new ConfigInvalidException("Invalid line in config file");
 		}
 	}
 
 	/**
-	 * Open input stream for configuration file. It is used during the
-	 * {@link #load()} method.
-	 *
-	 * @return input stream for the configuration file.
-	 * @throws IOException
-	 *             if the stream cannot be created
-	 */
-	protected abstract InputStream openInputStream() throws IOException;
-
-	/**
 	 * Clear the configuration file
 	 */
 	protected void clear() {
@@ -827,132 +786,136 @@ private void add(final Entry e) {
 		}
 	}
 
-	private static String readSectionName(final BufferedReader r)
-			throws IOException {
-		final StringBuffer name = new StringBuffer();
+	private static String readSectionName(final StringReader in)
+			throws ConfigInvalidException {
+		final StringBuilder name = new StringBuilder();
 		for (;;) {
-			r.mark(1);
-			int c = r.read();
-			if (c < 0) {
-				throw new IOException("Unexpected end of config file.");
-			} else if (']' == c) {
-				r.reset();
+			int c = in.read();
+			if (c < 0)
+				throw new ConfigInvalidException("Unexpected end of config file");
+
+			if (']' == c) {
+				in.reset();
 				break;
-			} else if (' ' == c || '\t' == c) {
+			}
+
+			if (' ' == c || '\t' == c) {
 				for (;;) {
-					r.mark(1);
-					c = r.read();
-					if (c < 0) {
-						throw new IOException("Unexpected end of config file.");
-					} else if ('"' == c) {
-						r.reset();
+					c = in.read();
+					if (c < 0)
+						throw new ConfigInvalidException("Unexpected end of config file");
+
+					if ('"' == c) {
+						in.reset();
 						break;
-					} else if (' ' == c || '\t' == c) {
-						// Skipped...
-					} else {
-						throw new IOException("Bad section entry. : " + name
-								+ "," + c);
 					}
+
+					if (' ' == c || '\t' == c)
+						continue; // Skipped...
+					throw new ConfigInvalidException("Bad section entry: " + name);
 				}
 				break;
-			} else if (Character.isLetterOrDigit((char) c) || '.' == c
-					|| '-' == c) {
-				name.append((char) c);
-			} else {
-				throw new IOException("Bad section entry. : " + name + ", " + c);
 			}
+
+			if (Character.isLetterOrDigit((char) c) || '.' == c || '-' == c)
+				name.append((char) c);
+			else
+				throw new ConfigInvalidException("Bad section entry: " + name);
 		}
 		return name.toString();
 	}
 
-	private static String readKeyName(final BufferedReader r)
-			throws IOException {
+	private static String readKeyName(final StringReader in)
+			throws ConfigInvalidException {
 		final StringBuffer name = new StringBuffer();
 		for (;;) {
-			r.mark(1);
-			int c = r.read();
-			if (c < 0) {
-				throw new IOException("Unexpected end of config file.");
-			} else if ('=' == c) {
+			int c = in.read();
+			if (c < 0)
+				throw new ConfigInvalidException("Unexpected end of config file");
+
+			if ('=' == c)
 				break;
-			} else if (' ' == c || '\t' == c) {
+
+			if (' ' == c || '\t' == c) {
 				for (;;) {
-					r.mark(1);
-					c = r.read();
-					if (c < 0) {
-						throw new IOException("Unexpected end of config file.");
-					} else if ('=' == c) {
+					c = in.read();
+					if (c < 0)
+						throw new ConfigInvalidException("Unexpected end of config file");
+
+					if ('=' == c)
 						break;
-					} else if (';' == c || '#' == c || '\n' == c) {
-						r.reset();
+
+					if (';' == c || '#' == c || '\n' == c) {
+						in.reset();
 						break;
-					} else if (' ' == c || '\t' == c) {
-						// Skipped...
-					} else {
-						throw new IOException("Bad entry delimiter.");
 					}
+
+					if (' ' == c || '\t' == c) 
+						continue; // Skipped...
+					throw new ConfigInvalidException("Bad entry delimiter");
 				}
 				break;
-			} else if (Character.isLetterOrDigit((char) c) || c == '-') {
+			}
+
+			if (Character.isLetterOrDigit((char) c) || c == '-') {
 				// From the git-config man page:
 				// The variable names are case-insensitive and only
 				// alphanumeric characters and - are allowed.
 				name.append((char) c);
 			} else if ('\n' == c) {
-				r.reset();
+				in.reset();
 				name.append((char) c);
 				break;
-			} else {
-				throw new IOException("Bad config entry name: " + name
-						+ (char) c);
-			}
+			} else
+				throw new ConfigInvalidException("Bad entry name: " + name);
 		}
 		return name.toString();
 	}
 
-	private static String readValue(final BufferedReader r, boolean quote,
-			final int eol) throws IOException {
+	private static String readValue(final StringReader in, boolean quote,
+			final int eol) throws ConfigInvalidException {
 		final StringBuffer value = new StringBuffer();
 		boolean space = false;
 		for (;;) {
-			r.mark(1);
-			int c = r.read();
+			int c = in.read();
 			if (c < 0) {
 				if (value.length() == 0)
-					throw new IOException("Unexpected end of config file.");
+					throw new ConfigInvalidException("Unexpected end of config file");
 				break;
 			}
+
 			if ('\n' == c) {
-				if (quote) {
-					throw new IOException("Newline in quotes not allowed.");
-				}
-				r.reset();
+				if (quote)
+					throw new ConfigInvalidException("Newline in quotes not allowed");
+				in.reset();
 				break;
 			}
-			if (eol == c) {
+
+			if (eol == c)
 				break;
-			}
+
 			if (!quote) {
 				if (Character.isWhitespace((char) c)) {
 					space = true;
 					continue;
 				}
 				if (';' == c || '#' == c) {
-					r.reset();
+					in.reset();
 					break;
 				}
 			}
+
 			if (space) {
-				if (value.length() > 0) {
+				if (value.length() > 0)
 					value.append(' ');
-				}
 				space = false;
 			}
+
 			if ('\\' == c) {
-				c = r.read();
+				c = in.read();
 				switch (c) {
 				case -1:
-					throw new IOException("End of file in escape.");
+					throw new ConfigInvalidException("End of file in escape");
 				case '\n':
 					continue;
 				case 't':
@@ -971,13 +934,15 @@ private static String readValue(final BufferedReader r, boolean quote,
 					value.append('"');
 					continue;
 				default:
-					throw new IOException("Bad escape: " + ((char) c));
+					throw new ConfigInvalidException("Bad escape: " + ((char) c));
 				}
 			}
+
 			if ('"' == c) {
 				quote = !quote;
 				continue;
 			}
+
 			value.append((char) c);
 		}
 		return value.length() > 0 ? value.toString() : null;
@@ -1040,4 +1005,27 @@ private static boolean eqSameCase(final String a, final String b) {
 			return a.equals(b);
 		}
 	}
+
+	private static class StringReader {
+		private final char[] buf;
+
+		private int pos;
+
+		StringReader(final String in) {
+			buf = in.toCharArray();
+		}
+
+		int read() {
+			try {
+				return buf[pos++];
+			} catch (ArrayIndexOutOfBoundsException e) {
+				pos = buf.length;
+				return -1;
+			}
+		}
+
+		void reset() {
+			pos--;
+		}
+	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/FileBasedConfig.java b/org.spearce.jgit/src/org/spearce/jgit/lib/FileBasedConfig.java
index aa1dbee..a419e7f 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/FileBasedConfig.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/FileBasedConfig.java
@@ -40,20 +40,18 @@
  */
 package org.spearce.jgit.lib;
 
-import java.io.BufferedWriter;
 import java.io.File;
-import java.io.FileInputStream;
-import java.io.FileOutputStream;
+import java.io.FileNotFoundException;
 import java.io.IOException;
-import java.io.InputStream;
-import java.io.OutputStreamWriter;
-import java.io.PrintWriter;
+
+import org.spearce.jgit.errors.ConfigInvalidException;
+import org.spearce.jgit.util.NB;
+import org.spearce.jgit.util.RawParseUtils;
 
 /**
  * The configuration file that is stored in the file of the file system.
  */
 public class FileBasedConfig extends Config {
-
 	private final File configFile;
 
 	/**
@@ -69,47 +67,58 @@ public FileBasedConfig(Config base, File cfgLocation) {
 		configFile = cfgLocation;
 	}
 
+	/** @return location of the configuration file on disk */
+	public final File getFile() {
+		return configFile;
+	}
+
 	/**
-	 * Save config data to the git config file
+	 * Load the configuration as a Git text style configuration file.
+	 * <p>
+	 * If the file does not exist, this configuration is cleared, and thus
+	 * behaves the same as though the file exists, but is empty.
 	 *
 	 * @throws IOException
+	 *             the file could not be read (but does exist).
+	 * @throws ConfigInvalidException
+	 *             the file is not a properly formatted configuration file.
 	 */
-	public void save() throws IOException {
-		final File tmp = new File(configFile.getParentFile(), configFile
-				.getName()
-				+ ".lock");
-		final PrintWriter r = new PrintWriter(new BufferedWriter(
-				new OutputStreamWriter(new FileOutputStream(tmp),
-						Constants.CHARSET)));
-		boolean ok = false;
+	public void load() throws IOException, ConfigInvalidException {
 		try {
-			printConfig(r);
-			ok = true;
-			r.close();
-			if (!tmp.renameTo(configFile)) {
-				configFile.delete();
-				if (!tmp.renameTo(configFile))
-					throw new IOException("Cannot save config file "
-							+ configFile + ", rename failed");
-			}
-		} finally {
-			r.close();
-			if (tmp.exists() && !tmp.delete()) {
-				System.err
-						.println("(warning) failed to delete tmp config file: "
-								+ tmp);
-			}
+			fromText(RawParseUtils.decode(NB.readFully(getFile())));
+		} catch (FileNotFoundException noFile) {
+			clear();
 		}
-		setFileRead(ok);
 	}
 
-	@Override
-	protected InputStream openInputStream() throws IOException {
-		return new FileInputStream(configFile);
+	/**
+	 * Save the configuration as a Git text style configuration file.
+	 * <p>
+	 * <b>Warning:</b> Although this method uses the traditional Git file
+	 * locking approach to protect against concurrent writes of the
+	 * configuration file, it does not ensure that the file has not been
+	 * modified since the last read, which means updates performed by other
+	 * objects accessing the same backing file may be lost.
+	 *
+	 * @throws IOException
+	 *             the file could not be written.
+	 */
+	public void save() throws IOException {
+		final byte[] out = Constants.encode(toText());
+		final LockFile lf = new LockFile(getFile());
+		if (!lf.lock())
+			throw new IOException("Cannot lock " + getFile());
+		try {
+			lf.write(out);
+			if (!lf.commit())
+				throw new IOException("Cannot commit write to " + getFile());
+		} finally {
+			lf.unlock();
+		}
 	}
 
 	@Override
 	public String toString() {
-		return getClass().getSimpleName() + "[" + configFile.getPath() + "]";
+		return getClass().getSimpleName() + "[" + getFile().getPath() + "]";
 	}
 }
\ No newline at end of file
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index 98a276b..4e987e1 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -56,9 +56,11 @@
 import java.util.Vector;
 import java.util.concurrent.atomic.AtomicInteger;
 
+import org.spearce.jgit.errors.ConfigInvalidException;
 import org.spearce.jgit.errors.IncorrectObjectTypeException;
 import org.spearce.jgit.errors.RevisionSyntaxException;
 import org.spearce.jgit.util.FS;
+import org.spearce.jgit.util.SystemReader;
 
 /**
  * Represents a Git repository. A repository holds all objects and refs used for
@@ -114,10 +116,28 @@ public Repository(final File d) throws IOException {
 		gitDir = d.getAbsoluteFile();
 		refs = new RefDatabase(this);
 		objectDatabase = new ObjectDirectory(FS.resolve(gitDir, "objects"));
-		config = new RepositoryConfig(this);
+
+		final FileBasedConfig userConfig;
+		userConfig = SystemReader.getInstance().openUserConfig();
+		try {
+			userConfig.load();
+		} catch (ConfigInvalidException e1) {
+			IOException e2 = new IOException("User config file "
+					+ userConfig.getFile().getAbsolutePath() + " invalid: "
+					+ e1);
+			e2.initCause(e1);
+			throw e2;
+		}
+		config = new RepositoryConfig(userConfig, FS.resolve(gitDir, "config"));
 
 		if (objectDatabase.exists()) {
-			getConfig().load();
+			try {
+				getConfig().load();
+			} catch (ConfigInvalidException e1) {
+				IOException e2 = new IOException("Unknown repository format");
+				e2.initCause(e1);
+				throw e2;
+			}
 			final String repositoryFormatVersion = getConfig().getString(
 					"core", null, "repositoryFormatVersion");
 			if (!"0".equals(repositoryFormatVersion)) {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
index 5c912b7..fb97747 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
@@ -44,7 +44,7 @@
 import java.io.File;
 import java.io.IOException;
 
-import org.spearce.jgit.util.FS;
+import org.spearce.jgit.errors.ConfigInvalidException;
 import org.spearce.jgit.util.SystemReader;
 
 /**
@@ -54,16 +54,6 @@
  * file depending on how it is instantiated.
  */
 public class RepositoryConfig extends FileBasedConfig {
-	/**
-	 * Obtain a new configuration instance for ~/.gitconfig.
-	 *
-	 * @return a new configuration instance to read the user's global
-	 *         configuration file from their home directory.
-	 */
-	public static FileBasedConfig openUserConfig() {
-		return SystemReader.getInstance().openUserConfig();
-	}
-
 	/** Section name for a branch configuration. */
 	public static final String BRANCH_SECTION = "branch";
 
@@ -71,10 +61,6 @@ public static FileBasedConfig openUserConfig() {
 
 	TransferConfig transfer;
 
-	RepositoryConfig(final Repository repo) {
-		this(openUserConfig(), FS.resolve(repo.getDirectory(), "config"));
-	}
-
 	/**
 	 * Create a Git configuration file reader/writer/cache for a specific file.
 	 *
@@ -187,7 +173,6 @@ private String getUserEmailInternal(String gitVariableKey) {
 	 */
 	public void create() {
 		clear();
-		setFileRead(true);
 		setInt("core", null, "repositoryformatversion", 0);
 		setBoolean("core", null, "filemode", true);
 
@@ -196,7 +181,7 @@ public void create() {
 	}
 
 	@Override
-	public void load() throws IOException {
+	public void load() throws IOException, ConfigInvalidException {
 		super.load();
 		core = new CoreConfig(this);
 		transfer = new TransferConfig(this);
-- 
1.6.4.rc2.216.g769fa

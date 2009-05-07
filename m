From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 1/2] Add support for boolean config values "yes", "no"
Date: Thu,  7 May 2009 08:05:13 -0700
Message-ID: <1241708714-20326-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu May 07 17:07:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M25Ad-0001U1-Lp
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 17:06:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758969AbZEGPFT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 11:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756184AbZEGPFR
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 11:05:17 -0400
Received: from george.spearce.org ([209.20.77.23]:41348 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757957AbZEGPFP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 11:05:15 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id C6B19381D3; Thu,  7 May 2009 15:05:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id C3190381D0;
	Thu,  7 May 2009 15:05:14 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.195.gad81
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118484>

In 8f8c6fafd92f (shipped in 1.6.3) Linus taught C Git how to read
boolean configuration values set to "yes" as true and "no" as false.
Add support for these values, and some test cases.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 This little 2 patch series is to adjust some cases in JGit to
 match Git 1.6.3 semantics.

 .../org/spearce/jgit/lib/RepositoryConfigTest.java |   70 ++++++++++++++++++--
 .../src/org/spearce/jgit/lib/RepositoryConfig.java |   13 +++-
 2 files changed, 74 insertions(+), 9 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryConfigTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryConfigTest.java
index 4b5314c..ed573e1 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryConfigTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryConfigTest.java
@@ -57,9 +57,7 @@
 	 * @throws IOException
 	 */
 	public void test001_ReadBareKey() throws IOException {
-		final File path = writeTrashFile("config_001", "[foo]\nbar\n");
-		RepositoryConfig repositoryConfig = new RepositoryConfig(null, path);
-		System.out.println(repositoryConfig.getString("foo", null, "bar"));
+		final RepositoryConfig repositoryConfig = read("[foo]\nbar\n");
 		assertEquals(true, repositoryConfig.getBoolean("foo", null, "bar", false));
 		assertEquals("", repositoryConfig.getString("foo", null, "bar"));
 	}
@@ -70,8 +68,7 @@ public void test001_ReadBareKey() throws IOException {
 	 * @throws IOException
 	 */
 	public void test002_ReadWithSubsection() throws IOException {
-		final File path = writeTrashFile("config_002", "[foo \"zip\"]\nbar\n[foo \"zap\"]\nbar=false\nn=3\n");
-		RepositoryConfig repositoryConfig = new RepositoryConfig(null, path);
+		final RepositoryConfig repositoryConfig = read("[foo \"zip\"]\nbar\n[foo \"zap\"]\nbar=false\nn=3\n");
 		assertEquals(true, repositoryConfig.getBoolean("foo", "zip", "bar", false));
 		assertEquals("", repositoryConfig.getString("foo","zip", "bar"));
 		assertEquals(false, repositoryConfig.getBoolean("foo", "zap", "bar", true));
@@ -113,8 +110,7 @@ assertTrue(Arrays.equals(values.toArray(), repositoryConfig
 	}
 
 	public void test006_readCaseInsensitive() throws IOException {
-		final File path = writeTrashFile("config_001", "[Foo]\nBar\n");
-		RepositoryConfig repositoryConfig = new RepositoryConfig(null, path);
+		final RepositoryConfig repositoryConfig = read("[Foo]\nBar\n");
 		assertEquals(true, repositoryConfig.getBoolean("foo", null, "bar", false));
 		assertEquals("", repositoryConfig.getString("foo", null, "bar"));
 	}
@@ -182,4 +178,64 @@ public void test007_readUserInfos() throws IOException {
 		assertEquals("local username", authorName);
 		assertEquals("author@localemail", authorEmail);
 	}
+
+	public void testReadBoolean_TrueFalse1() throws IOException {
+		final RepositoryConfig c = read("[s]\na = true\nb = false\n");
+		assertEquals("true", c.getString("s", null, "a"));
+		assertEquals("false", c.getString("s", null, "b"));
+
+		assertTrue(c.getBoolean("s", "a", false));
+		assertFalse(c.getBoolean("s", "b", true));
+	}
+
+	public void testReadBoolean_TrueFalse2() throws IOException {
+		final RepositoryConfig c = read("[s]\na = TrUe\nb = fAlSe\n");
+		assertEquals("TrUe", c.getString("s", null, "a"));
+		assertEquals("fAlSe", c.getString("s", null, "b"));
+
+		assertTrue(c.getBoolean("s", "a", false));
+		assertFalse(c.getBoolean("s", "b", true));
+	}
+
+	public void testReadBoolean_YesNo1() throws IOException {
+		final RepositoryConfig c = read("[s]\na = yes\nb = no\n");
+		assertEquals("yes", c.getString("s", null, "a"));
+		assertEquals("no", c.getString("s", null, "b"));
+
+		assertTrue(c.getBoolean("s", "a", false));
+		assertFalse(c.getBoolean("s", "b", true));
+	}
+
+	public void testReadBoolean_YesNo2() throws IOException {
+		final RepositoryConfig c = read("[s]\na = yEs\nb = NO\n");
+		assertEquals("yEs", c.getString("s", null, "a"));
+		assertEquals("NO", c.getString("s", null, "b"));
+
+		assertTrue(c.getBoolean("s", "a", false));
+		assertFalse(c.getBoolean("s", "b", true));
+	}
+
+	public void testReadBoolean_OnOff1() throws IOException {
+		final RepositoryConfig c = read("[s]\na = on\nb = off\n");
+		assertEquals("on", c.getString("s", null, "a"));
+		assertEquals("off", c.getString("s", null, "b"));
+
+		assertTrue(c.getBoolean("s", "a", false));
+		assertFalse(c.getBoolean("s", "b", true));
+	}
+
+	public void testReadBoolean_OnOff2() throws IOException {
+		final RepositoryConfig c = read("[s]\na = ON\nb = OFF\n");
+		assertEquals("ON", c.getString("s", null, "a"));
+		assertEquals("OFF", c.getString("s", null, "b"));
+
+		assertTrue(c.getBoolean("s", "a", false));
+		assertFalse(c.getBoolean("s", "b", true));
+	}
+
+	private RepositoryConfig read(final String content) throws IOException {
+		final File p = writeTrashFile(getName() + ".config", content);
+		final RepositoryConfig c = new RepositoryConfig(null, p);
+		return c;
+	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
index cb287ee..e3a303f 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
@@ -254,10 +254,19 @@ public boolean getBoolean(final String section, String subsection,
 			return defaultValue;
 
 		n = n.toLowerCase();
-		if (MAGIC_EMPTY_VALUE.equals(n) || "yes".equalsIgnoreCase(n) || "true".equalsIgnoreCase(n) || "1".equals(n)) {
+		if (MAGIC_EMPTY_VALUE.equals(n)
+				|| "yes".equalsIgnoreCase(n)
+				|| "true".equalsIgnoreCase(n)
+				|| "1".equals(n)
+				|| "on".equals(n)) {
 			return true;
-		} else if ("no".equalsIgnoreCase(n) || "false".equalsIgnoreCase(n) || "0".equalsIgnoreCase(n)) {
+
+		} else if ("no".equalsIgnoreCase(n)
+				|| "false".equalsIgnoreCase(n)
+				|| "0".equalsIgnoreCase(n)
+				|| "off".equalsIgnoreCase(n)) {
 			return false;
+
 		} else {
 			throw new IllegalArgumentException("Invalid boolean value: "
 					+ section + "." + name + "=" + n);
-- 
1.6.3.195.gad81

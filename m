From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH v2 1/2] Add support for boolean config values "on",
	"off"
Date: Thu, 7 May 2009 11:01:47 -0700
Message-ID: <20090507180147.GT30527@spearce.org>
References: <1241708714-20326-1-git-send-email-spearce@spearce.org> <eOxTQ_L3wmawK8rFbXMLnksiI7lh8eiyptpquFGaI28e3RO7dN9GMw@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu May 07 20:02:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M27ur-0002wU-01
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 20:01:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762347AbZEGSBt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 14:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758124AbZEGSBt
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 14:01:49 -0400
Received: from george.spearce.org ([209.20.77.23]:52784 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752832AbZEGSBr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 14:01:47 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id CF8CE381D0; Thu,  7 May 2009 18:01:47 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <eOxTQ_L3wmawK8rFbXMLnksiI7lh8eiyptpquFGaI28e3RO7dN9GMw@cipher.nrlssc.navy.mil>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118500>

In 8f8c6fafd92f (shipped in 1.6.3) Linus taught C Git how to read
boolean configuration values set to "on" as true and "off" as false.
Add support for these values, and some test cases.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
  Brandon Casey <casey@nrlssc.navy.mil> wrote:
  > Shawn O. Pearce wrote:
  > > In 8f8c6fafd92f (shipped in 1.6.3) Linus taught C Git how to read
  > > boolean configuration values set to "yes" as true and "no" as false.
  > > Add support for these values, and some test cases.
  > 
  > Linus added support for "on" and "off" in that commit as it appears
  > your commit is also doing. :)

  Whoops, good catch, thanks.

  > I was about to point out that you are not ignoring case for "on", but
  > using equalsIgnoreCase() appears to be unnecessary since above that
  > you are already doing n = n.toLowerCase().

  I dropped the toLowerCase and used equalsIgnoreCase instead.
  There is no reason to be allocating a copy of the string when
  equalsIgnorCase is sufficient.
  
 .../org/spearce/jgit/lib/RepositoryConfigTest.java |   70 ++++++++++++++++++--
 .../src/org/spearce/jgit/lib/RepositoryConfig.java |   14 +++-
 2 files changed, 74 insertions(+), 10 deletions(-)

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
index cb287ee..b816604 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
@@ -253,11 +253,19 @@ public boolean getBoolean(final String section, String subsection,
 		if (n == null)
 			return defaultValue;
 
-		n = n.toLowerCase();
-		if (MAGIC_EMPTY_VALUE.equals(n) || "yes".equalsIgnoreCase(n) || "true".equalsIgnoreCase(n) || "1".equals(n)) {
+		if (MAGIC_EMPTY_VALUE.equals(n)
+				|| "yes".equalsIgnoreCase(n)
+				|| "true".equalsIgnoreCase(n)
+				|| "1".equals(n)
+				|| "on".equalsIgnoreCase(n)) {
 			return true;
-		} else if ("no".equalsIgnoreCase(n) || "false".equalsIgnoreCase(n) || "0".equalsIgnoreCase(n)) {
+
+		} else if ("no".equalsIgnoreCase(n)
+				|| "false".equalsIgnoreCase(n)
+				|| "0".equals(n)
+				|| "off".equalsIgnoreCase(n)) {
 			return false;
+
 		} else {
 			throw new IllegalArgumentException("Invalid boolean value: "
 					+ section + "." + name + "=" + n);
-- 
1.6.3.195.gad81

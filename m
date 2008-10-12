From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [JGIT PATCH 3/4] The git config file is case insensitive
Date: Mon, 13 Oct 2008 00:50:59 +0200
Message-ID: <1223851860-13068-4-git-send-email-robin.rosenberg@dewire.com>
References: <1223851860-13068-1-git-send-email-robin.rosenberg@dewire.com>
 <1223851860-13068-2-git-send-email-robin.rosenberg@dewire.com>
 <1223851860-13068-3-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Mon Oct 13 00:54:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kp9pB-0001nz-SA
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 00:54:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754068AbYJLWw5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Oct 2008 18:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754003AbYJLWw5
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Oct 2008 18:52:57 -0400
Received: from [83.140.172.130] ([83.140.172.130]:19066 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754014AbYJLWwz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Oct 2008 18:52:55 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id E6A7D8026D3;
	Mon, 13 Oct 2008 00:52:53 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p4-vj0mCOXQa; Mon, 13 Oct 2008 00:52:35 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 2E4918026ED;
	Mon, 13 Oct 2008 00:52:18 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.2.308.gef4a
In-Reply-To: <1223851860-13068-3-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98063>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../org/spearce/jgit/lib/RepositoryConfigTest.java |    8 ++++++++
 .../src/org/spearce/jgit/lib/RepositoryConfig.java |   18 ++++++++++++------
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryConfigTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryConfigTest.java
index da7e704..bd5329c 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryConfigTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryConfigTest.java
@@ -109,4 +109,12 @@ assertTrue(Arrays.equals(values.toArray(), repositoryConfig
 				.getStringList("my", null, "somename")));
 		checkFile(cfgFile, "[my]\n\tsomename = value1\n\tsomename = value2\n");
 	}
+
+	public void test006_readCaseInsensitive() throws IOException {
+		final File path = writeTrashFile("config_001", "[Foo]\nBar\n");
+		RepositoryConfig repositoryConfig = new RepositoryConfig(null, path);
+		System.out.println(repositoryConfig.getString("foo", null, "bar"));
+		assertEquals(true, repositoryConfig.getBoolean("foo", null, "bar", false));
+		assertEquals("", repositoryConfig.getString("foo", null, "bar"));
+	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
index 45c2f8a..7a34cde 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
@@ -52,12 +52,13 @@
 import java.io.PrintWriter;
 import java.util.ArrayList;
 import java.util.Collections;
-import java.util.HashMap;
+import java.util.Comparator;
 import java.util.HashSet;
 import java.util.Iterator;
 import java.util.List;
 import java.util.Map;
 import java.util.Set;
+import java.util.TreeMap;
 
 import org.spearce.jgit.util.FS;
 
@@ -236,9 +237,9 @@ protected boolean getBoolean(final String section, String subsection,
 			return defaultValue;
 
 		n = n.toLowerCase();
-		if (MAGIC_EMPTY_VALUE.equals(n) || "yes".equals(n) || "true".equals(n) || "1".equals(n)) {
+		if (MAGIC_EMPTY_VALUE.equals(n) || "yes".equalsIgnoreCase(n) || "true".equalsIgnoreCase(n) || "1".equals(n)) {
 			return true;
-		} else if ("no".equals(n) || "false".equals(n) || "0".equals(n)) {
+		} else if ("no".equalsIgnoreCase(n) || "false".equalsIgnoreCase(n) || "0".equalsIgnoreCase(n)) {
 			return false;
 		} else {
 			throw new IllegalArgumentException("Invalid boolean value: "
@@ -300,7 +301,7 @@ public String getString(final String section, String subsection, final String na
 		final Set<String> result = new HashSet<String>();
 
 		for (final Entry e : entries) {
-			if (section.equals(e.base) && e.extendedBase != null)
+			if (section.equalsIgnoreCase(e.base) && e.extendedBase != null)
 				result.add(e.extendedBase);
 		}
 		if (baseConfig != null)
@@ -682,7 +683,12 @@ public void load() throws IOException {
 
 	private void clear() {
 		entries = new ArrayList<Entry>();
-		byName = new HashMap<String, Object>();
+		byName = new TreeMap<String, Object>(new Comparator<String>() {
+
+			public int compare(String o1, String o2) {
+				return o1.compareToIgnoreCase(o2);
+			}
+		});
 	}
 
 	@SuppressWarnings("unchecked")
@@ -954,7 +960,7 @@ private static boolean eq(final String a, final String b) {
 				return true;
 			if (a == null || b == null)
 				return false;
-			return a.equals(b);
+			return a.equalsIgnoreCase(b);
 		}
 	}
 }
-- 
1.6.0.2.308.gef4a

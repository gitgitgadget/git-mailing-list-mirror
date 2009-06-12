From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 1/2] Add getLong to RepositoryConfig
Date: Fri, 12 Jun 2009 16:23:05 -0700
Message-ID: <1244848986-10526-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sat Jun 13 01:23:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFG5e-0000eu-EA
	for gcvg-git-2@gmane.org; Sat, 13 Jun 2009 01:23:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752046AbZFLXXH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2009 19:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751976AbZFLXXG
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 19:23:06 -0400
Received: from george.spearce.org ([209.20.77.23]:52468 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751065AbZFLXXF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2009 19:23:05 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 27DEE381FF; Fri, 12 Jun 2009 23:23:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00,
	SUBJECT_FUZZY_TION autolearn=no version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 549F7381D6;
	Fri, 12 Jun 2009 23:23:06 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.2.367.gf0de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121468>

This supports parsing 64 bit configuration values.  We want to use
it for values like core.packedGitLimit where a 64 bit JVM may want
to support a very large value, well past the 2 GiB barrier.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../org/spearce/jgit/lib/RepositoryConfigTest.java |   26 ++++++++++++++++++++
 .../src/org/spearce/jgit/lib/RepositoryConfig.java |   26 ++++++++++++++++++-
 2 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryConfigTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryConfigTest.java
index ed573e1..5e2328b 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryConfigTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryConfigTest.java
@@ -233,6 +233,32 @@ public void testReadBoolean_OnOff2() throws IOException {
 		assertFalse(c.getBoolean("s", "b", true));
 	}
 
+	public void testReadLong() throws IOException {
+		assertReadLong(1L);
+		assertReadLong(-1L);
+		assertReadLong(Long.MIN_VALUE);
+		assertReadLong(Long.MAX_VALUE);
+		assertReadLong(4L * 1024 * 1024 * 1024, "4g");
+		assertReadLong(3L * 1024 * 1024, "3 m");
+		assertReadLong(8L * 1024, "8 k");
+
+		try {
+			assertReadLong(-1, "1.5g");
+			fail("incorrectly accepted 1.5g");
+		} catch (IllegalArgumentException e) {
+			assertEquals("Invalid integer value: s.a=1.5g", e.getMessage());
+		}
+	}
+
+	private void assertReadLong(long exp) throws IOException {
+		assertReadLong(exp, String.valueOf(exp));
+	}
+
+	private void assertReadLong(long exp, String act) throws IOException {
+		final RepositoryConfig c = read("[s]\na = " + act + "\n");
+		assertEquals(exp, c.getLong("s", null, "a", 0L));
+	}
+
 	private RepositoryConfig read(final String content) throws IOException {
 		final File p = writeTrashFile(getName() + ".config", content);
 		final RepositoryConfig c = new RepositoryConfig(null, p);
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
index b816604..a339514 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
@@ -183,6 +183,28 @@ public int getInt(final String section, final String name,
 	 */
 	public int getInt(final String section, String subsection,
 			final String name, final int defaultValue) {
+		final long val = getLong(section, subsection, name, defaultValue);
+		if (Integer.MIN_VALUE <= val && val <= Integer.MAX_VALUE)
+			return (int) val;
+		throw new IllegalArgumentException("Integer value " + section + "."
+				+ name + " out of range");
+	}
+
+	/**
+	 * Obtain an integer value from the configuration.
+	 *
+	 * @param section
+	 *            section the key is grouped within.
+	 * @param subsection
+	 *            subsection name, such a remote or branch name.
+	 * @param name
+	 *            name of the key to get.
+	 * @param defaultValue
+	 *            default value to return if no value was present.
+	 * @return an integer value from the configuration, or defaultValue.
+	 */
+	public long getLong(final String section, String subsection,
+			final String name, final long defaultValue) {
 		final String str = getString(section, subsection, name);
 		if (str == null)
 			return defaultValue;
@@ -191,7 +213,7 @@ public int getInt(final String section, String subsection,
 		if (n.length() == 0)
 			return defaultValue;
 
-		int mul = 1;
+		long mul = 1;
 		switch (Character.toLowerCase(n.charAt(n.length() - 1))) {
 		case 'g':
 			mul = 1024 * 1024 * 1024;
@@ -209,7 +231,7 @@ public int getInt(final String section, String subsection,
 			return defaultValue;
 
 		try {
-			return mul * Integer.parseInt(n);
+			return mul * Long.parseLong(n);
 		} catch (NumberFormatException nfe) {
 			throw new IllegalArgumentException("Invalid integer value: "
 					+ section + "." + name + "=" + str);
-- 
1.6.3.2.367.gf0de

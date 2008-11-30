From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [JGIT PATCH 3/8] Turn off memory mapping in JGit unit tests by default
Date: Mon,  1 Dec 2008 00:40:30 +0100
Message-ID: <1228088435-23722-4-git-send-email-robin.rosenberg@dewire.com>
References: <20081127214916.GD23984@spearce.org>
 <1228088435-23722-1-git-send-email-robin.rosenberg@dewire.com>
 <1228088435-23722-2-git-send-email-robin.rosenberg@dewire.com>
 <1228088435-23722-3-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, fonseca@diku.dk,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Mon Dec 01 00:42:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6vvh-0001xS-CA
	for gcvg-git-2@gmane.org; Mon, 01 Dec 2008 00:42:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754012AbYK3Xkw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Nov 2008 18:40:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754188AbYK3Xkt
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Nov 2008 18:40:49 -0500
Received: from mail.dewire.com ([83.140.172.130]:25204 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753835AbYK3Xkp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2008 18:40:45 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id A1F2214433E9;
	Mon,  1 Dec 2008 00:40:43 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ar4JqnxFLyt7; Mon,  1 Dec 2008 00:40:41 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 86E89147D525;
	Mon,  1 Dec 2008 00:40:37 +0100 (CET)
X-Mailer: git-send-email 1.6.0.3.640.g6331a
In-Reply-To: <1228088435-23722-3-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101989>

A system property named jgit.junit.usemmmap can be set to true to enable
memory mapping during unit testing.

The protected method configure can be overridden to do things
like configuring the JGit engine.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../org/spearce/jgit/lib/RepositoryTestCase.java   |   30 ++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
index e164faf..3b08fa5 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
@@ -49,6 +49,19 @@
 import junit.framework.TestCase;
 import org.spearce.jgit.util.JGitTestUtil;
 
+/**
+ * Base class for most JGit unit tests.
+ *
+ * Sets up a predefined test repository and has support for creating additional
+ * repositories and destroying them when the tests are finished.
+ *
+ * A system property <em>jgit.junit.usemmmap</em> defines whether memory mapping
+ * is used. Memory mapping has an effect on the file system, in that memory
+ * mapped files in java cannot be deleted as long as they mapped arrays have not
+ * been reclaimed by the garbage collector. The programmer cannot control this
+ * with precision, though hinting using <em>{@link java.lang.System#gc}</em>
+ * often helps.
+ */
 public abstract class RepositoryTestCase extends TestCase {
 
 	protected final File trashParent = new File("trash");
@@ -66,6 +79,22 @@
 		jcommitter = new PersonIdent("J. Committer", "jcommitter@example.com");
 	}
 
+	protected boolean packedGitMMAP;
+
+	/**
+	 * Configure JGit before setting up test repositories.
+	 */
+	protected void configure() {
+		packedGitMMAP = "true".equals(System.getProperty("jgit.junit.usemmmap"));
+		WindowCache.reconfigure(128*1024, 8192, packedGitMMAP, 8192);
+	}
+
+	/**
+	 * Utility method to delete a directory recursively. It is
+	 * also used internally.
+	 *
+	 * @param dir
+	 */
 	protected static void recursiveDelete(final File dir) {
 		final File[] ls = dir.listFiles();
 		if (ls != null) {
@@ -123,6 +152,7 @@ protected static void checkFile(File f, final String checkData)
 
 	public void setUp() throws Exception {
 		super.setUp();
+		configure();
 		recursiveDelete(trashParent);
 		trash = new File(trashParent,"trash"+System.currentTimeMillis());
 		trash_git = new File(trash, ".git");
-- 
1.6.0.3.640.g6331a

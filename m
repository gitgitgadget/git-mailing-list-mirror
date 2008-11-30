From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [JGIT PATCH 6/8] Cleanup after each test.
Date: Mon,  1 Dec 2008 00:40:33 +0100
Message-ID: <1228088435-23722-7-git-send-email-robin.rosenberg@dewire.com>
References: <20081127214916.GD23984@spearce.org>
 <1228088435-23722-1-git-send-email-robin.rosenberg@dewire.com>
 <1228088435-23722-2-git-send-email-robin.rosenberg@dewire.com>
 <1228088435-23722-3-git-send-email-robin.rosenberg@dewire.com>
 <1228088435-23722-4-git-send-email-robin.rosenberg@dewire.com>
 <1228088435-23722-5-git-send-email-robin.rosenberg@dewire.com>
 <1228088435-23722-6-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, fonseca@diku.dk,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Mon Dec 01 00:42:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6vvk-0001xS-4D
	for gcvg-git-2@gmane.org; Mon, 01 Dec 2008 00:42:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754697AbYK3XlE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Nov 2008 18:41:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754546AbYK3Xk5
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Nov 2008 18:40:57 -0500
Received: from mail.dewire.com ([83.140.172.130]:25229 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753648AbYK3Xku (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2008 18:40:50 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id EA4A4147D525;
	Mon,  1 Dec 2008 00:40:48 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JCNX6TNjmInM; Mon,  1 Dec 2008 00:40:44 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 0F9C6147D542;
	Mon,  1 Dec 2008 00:40:38 +0100 (CET)
X-Mailer: git-send-email 1.6.0.3.640.g6331a
In-Reply-To: <1228088435-23722-6-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101994>

Automatically clean up any repositories created by the test cases.
Cleanup is attempted at the end of each test, but if that fails
Shutdown hooks attempt to clean up when the JVM exits. If memmory
mapping is enabled (disabled by default in unit tests), gc is
invoked to make it more likely that cleanup will occur successfully.
The drawback is that this is much slower, which is the reason we
disble memory mapping by default in unit tests.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../org/spearce/jgit/lib/RepositoryTestCase.java   |   62 ++++++++++++++++----
 1 files changed, 50 insertions(+), 12 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
index 8e23bc1..aaa3592 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
@@ -45,6 +45,8 @@
 import java.io.InputStreamReader;
 import java.io.OutputStreamWriter;
 import java.io.Reader;
+import java.util.ArrayList;
+import java.util.List;
 
 import junit.framework.TestCase;
 import org.spearce.jgit.util.JGitTestUtil;
@@ -95,8 +97,8 @@ protected void configure() {
 	 *
 	 * @param dir
 	 */
-	protected static void recursiveDelete(final File dir) {
-		recursiveDelete(dir, false, null);
+	protected void recursiveDelete(final File dir) {
+		recursiveDelete(dir, false, getClass().getName() + "." + getName());
 	}
 
 	protected static boolean recursiveDelete(final File dir, boolean silent,
@@ -170,9 +172,12 @@ protected static void checkFile(File f, final String checkData)
 	}
 
 	protected Repository db;
-
+	private static Thread shutdownhook;
+	private static List<Runnable> shutDownCleanups = new ArrayList<Runnable>();
 	private static int testcount;
 
+	private ArrayList<Repository> repositoriesToClose = new ArrayList<Repository>();
+
 	public void setUp() throws Exception {
 		super.setUp();
 		configure();
@@ -180,14 +185,23 @@ public void setUp() throws Exception {
 		recursiveDelete(trashParent, true, name);
 		trash = new File(trashParent,"trash"+System.currentTimeMillis()+"."+(testcount++));
 		trash_git = new File(trash, ".git");
-
-		Runtime.getRuntime().addShutdownHook(new Thread() {
-			@Override
-			public void run() {
-				recursiveDelete(trashParent, false, name);
-			}
-		});
-
+		if (shutdownhook == null) {
+			shutdownhook = new Thread() {
+				@Override
+				public void run() {
+					// This may look superfluous, but is an extra attempt
+					// to clean up. First GC to release as many resources
+					// as possible and then try to clean up one test repo
+					// at a time (to record problems) and finally to drop
+					// the directory containing all test repositories.
+					System.gc();
+					for (Runnable r : shutDownCleanups)
+						r.run();
+					recursiveDelete(trashParent, false, null);
+				}
+			};
+			Runtime.getRuntime().addShutdownHook(shutdownhook);
+		}
 		db = new Repository(trash_git);
 		db.create();
 
@@ -213,6 +227,22 @@ copyFile(JGitTestUtil.getTestResourceFile(packs[k] + ".idx"), new File(packDir,
 
 	protected void tearDown() throws Exception {
 		db.close();
+		for (Repository r : repositoriesToClose)
+			r.close();
+
+		// Since memory mapping is controlled by the GC we need to
+		// tell it this is a good time to clean up and unlock
+		// memory mapped files.
+		if (packedGitMMAP)
+			System.gc();
+
+		final String name = getClass().getName() + "." + getName();
+		recursiveDelete(trash, false, name);
+		for (Repository r : repositoriesToClose)
+			recursiveDelete(r.getWorkDir(), false, name);
+
+		repositoriesToClose.clear();
+
 		super.tearDown();
 	}
 
@@ -224,10 +254,18 @@ protected void tearDown() throws Exception {
 	 * @throws IOException
 	 */
 	protected Repository createNewEmptyRepo() throws IOException {
-		File newTestRepo = new File(trashParent, "new"+System.currentTimeMillis()+"."+(testcount++)+"/.git");
+		final File newTestRepo = new File(trashParent, "new"
+				+ System.currentTimeMillis() + "." + (testcount++) + "/.git");
 		assertFalse(newTestRepo.exists());
 		final Repository newRepo = new Repository(newTestRepo);
 		newRepo.create();
+		final String name = getClass().getName() + "." + getName();
+		shutDownCleanups.add(new Runnable() {
+			public void run() {
+				recursiveDelete(newTestRepo, false, name);
+			}
+		});
+		repositoriesToClose.add(newRepo);
 		return newRepo;
 	}
 
-- 
1.6.0.3.640.g6331a

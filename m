From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [JGIT PATCH 8/8] Hard failure on unit test cleanups if they fail.
Date: Mon,  1 Dec 2008 00:40:35 +0100
Message-ID: <1228088435-23722-9-git-send-email-robin.rosenberg@dewire.com>
References: <20081127214916.GD23984@spearce.org>
 <1228088435-23722-1-git-send-email-robin.rosenberg@dewire.com>
 <1228088435-23722-2-git-send-email-robin.rosenberg@dewire.com>
 <1228088435-23722-3-git-send-email-robin.rosenberg@dewire.com>
 <1228088435-23722-4-git-send-email-robin.rosenberg@dewire.com>
 <1228088435-23722-5-git-send-email-robin.rosenberg@dewire.com>
 <1228088435-23722-6-git-send-email-robin.rosenberg@dewire.com>
 <1228088435-23722-7-git-send-email-robin.rosenberg@dewire.com>
 <1228088435-23722-8-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, fonseca@diku.dk,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Mon Dec 01 00:42:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6vvk-0001xS-Pq
	for gcvg-git-2@gmane.org; Mon, 01 Dec 2008 00:42:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754546AbYK3XlH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Nov 2008 18:41:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754647AbYK3Xk7
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Nov 2008 18:40:59 -0500
Received: from mail.dewire.com ([83.140.172.130]:25223 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754108AbYK3Xks (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2008 18:40:48 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id AE730147CE86;
	Mon,  1 Dec 2008 00:40:47 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 07QSQLU1pX7W; Mon,  1 Dec 2008 00:40:46 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 7C061147D544;
	Mon,  1 Dec 2008 00:40:38 +0100 (CET)
X-Mailer: git-send-email 1.6.0.3.640.g6331a
In-Reply-To: <1228088435-23722-8-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101990>

This only has an effect on Windows that locks open files, but
is a nice test that we actually clean up.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../org/spearce/jgit/lib/RepositoryTestCase.java   |   52 ++++++++++++--------
 1 files changed, 32 insertions(+), 20 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
index 376a76e..22bf395 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
@@ -49,6 +49,7 @@
 import java.util.List;
 
 import junit.framework.TestCase;
+
 import org.spearce.jgit.util.JGitTestUtil;
 
 /**
@@ -93,16 +94,18 @@ protected void configure() {
 
 	/**
 	 * Utility method to delete a directory recursively. It is
-	 * also used internally.
+	 * also used internally. If a file or directory cannote be removed
+	 * it throws an AssertionFailure.
 	 *
 	 * @param dir
 	 */
 	protected void recursiveDelete(final File dir) {
-		recursiveDelete(dir, false, getClass().getName() + "." + getName());
+		recursiveDelete(dir, false, getClass().getName() + "." + getName(), true);
 	}
 
 	protected static boolean recursiveDelete(final File dir, boolean silent,
-			final String name) {
+			final String name, boolean failOnError) {
+		assert !(silent && failOnError);
 		if (!dir.exists())
 			return silent;
 		final File[] ls = dir.listFiles();
@@ -110,32 +113,42 @@ protected static boolean recursiveDelete(final File dir, boolean silent,
 			for (int k = 0; k < ls.length; k++) {
 				final File e = ls[k];
 				if (e.isDirectory()) {
-					silent = recursiveDelete(e, silent, name);
+					silent = recursiveDelete(e, silent, name, failOnError);
 				} else {
 					if (!e.delete()) {
 						if (!silent) {
-							String msg = "Warning: Failed to delete " + e;
-							if (name != null)
-								msg += " in " + name;
-							System.out.println(msg);
+							reportDeleteFailure(name, failOnError, e);
 						}
-						silent = true;
+						silent = !failOnError;
 					}
 				}
 			}
 		}
 		if (!dir.delete()) {
 			if (!silent) {
-				String msg = "Warning: Failed to delete " + dir;
-				if (name != null)
-					msg += " in " + name;
-				System.out.println(msg);
+				reportDeleteFailure(name, failOnError, dir);
 			}
-			silent = true;
+			silent = !failOnError;
 		}
 		return silent;
 	}
 
+	private static void reportDeleteFailure(final String name,
+			boolean failOnError, final File e) {
+		String severity;
+		if (failOnError)
+			severity = "Error";
+		else
+			severity = "Warning";
+		String msg = severity + ": Failed to delete " + e;
+		if (name != null)
+			msg += " in " + name;
+		if (failOnError)
+			fail(msg);
+		else
+			System.out.println(msg);
+	}
+
 	protected static void copyFile(final File src, final File dst)
 			throws IOException {
 		final FileInputStream fis = new FileInputStream(src);
@@ -186,7 +199,7 @@ public void setUp() throws Exception {
 		super.setUp();
 		configure();
 		final String name = getClass().getName() + "." + getName();
-		recursiveDelete(trashParent, true, name);
+		recursiveDelete(trashParent, true, name, false); // Cleanup old failed stuff
 		trash = new File(trashParent,"trash"+System.currentTimeMillis()+"."+(testcount++));
 		trash_git = new File(trash, ".git");
 		if (shutdownhook == null) {
@@ -201,7 +214,7 @@ public void run() {
 					System.gc();
 					for (Runnable r : shutDownCleanups)
 						r.run();
-					recursiveDelete(trashParent, false, null);
+					recursiveDelete(trashParent, false, null, false);
 				}
 			};
 			Runtime.getRuntime().addShutdownHook(shutdownhook);
@@ -241,10 +254,9 @@ protected void tearDown() throws Exception {
 			System.gc();
 
 		final String name = getClass().getName() + "." + getName();
-		recursiveDelete(trash, false, name);
+		recursiveDelete(trash, false, name, true);
 		for (Repository r : repositoriesToClose)
-			recursiveDelete(r.getWorkDir(), false, name);
-
+			recursiveDelete(r.getWorkDir(), false, name, true);
 		repositoriesToClose.clear();
 
 		super.tearDown();
@@ -266,7 +278,7 @@ protected Repository createNewEmptyRepo() throws IOException {
 		final String name = getClass().getName() + "." + getName();
 		shutDownCleanups.add(new Runnable() {
 			public void run() {
-				recursiveDelete(newTestRepo, false, name);
+				recursiveDelete(newTestRepo, false, name, false);
 			}
 		});
 		repositoriesToClose.add(newRepo);
-- 
1.6.0.3.640.g6331a

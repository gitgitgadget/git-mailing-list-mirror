From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [JGIT PATCH 4/4] Automatically clean up any repositories created by the test cases
Date: Thu, 27 Nov 2008 22:15:35 +0100
Message-ID: <1227820535-9785-5-git-send-email-robin.rosenberg@dewire.com>
References: <1227820535-9785-1-git-send-email-robin.rosenberg@dewire.com>
 <1227820535-9785-2-git-send-email-robin.rosenberg@dewire.com>
 <1227820535-9785-3-git-send-email-robin.rosenberg@dewire.com>
 <1227820535-9785-4-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, fonseca@diku.dk,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Thu Nov 27 22:17:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5oEh-0006HN-Lp
	for gcvg-git-2@gmane.org; Thu, 27 Nov 2008 22:17:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752968AbYK0VPq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Nov 2008 16:15:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752964AbYK0VPp
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Nov 2008 16:15:45 -0500
Received: from mail.dewire.com ([83.140.172.130]:6577 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752866AbYK0VPj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Nov 2008 16:15:39 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 489C1147D535;
	Thu, 27 Nov 2008 22:15:38 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pSBcPi6Pkhds; Thu, 27 Nov 2008 22:15:37 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 444C6147D53D;
	Thu, 27 Nov 2008 22:15:36 +0100 (CET)
X-Mailer: git-send-email 1.6.0.3.640.g6331a
In-Reply-To: <1227820535-9785-4-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101834>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../org/spearce/jgit/lib/RepositoryTestCase.java   |   21 +++++++++++++++++++-
 1 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
index ef4fd1b..cab65a0 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
@@ -45,6 +45,7 @@
 import java.io.InputStreamReader;
 import java.io.OutputStreamWriter;
 import java.io.Reader;
+import java.util.ArrayList;
 
 import junit.framework.TestCase;
 import org.spearce.jgit.util.JGitTestUtil;
@@ -145,6 +146,8 @@ protected static void checkFile(File f, final String checkData)
 	private static int testcount;
 	private static Thread shutdownhook;
 
+	private ArrayList<Repository> repositoriesToClose = new ArrayList<Repository>();
+
 	public void setUp() throws Exception {
 		super.setUp();
 		System.gc();
@@ -192,6 +195,20 @@ copyFile(JGitTestUtil.getTestResourceFile(packs[k] + ".idx"), new File(packDir,
 
 	protected void tearDown() throws Exception {
 		db.close();
+		for (Repository r : repositoriesToClose) {
+			r.close();
+		}
+		// Since memory mapping is controlled by the GC we need to
+		// tell it this is a good time to clean up and unlock
+		// mmemory mapped files.
+		System.gc();
+
+		recursiveDelete(trash, false, getName());
+		for (Repository r : repositoriesToClose) {
+			recursiveDelete(r.getWorkDir(), false, getName());
+		}
+		repositoriesToClose.clear();
+
 		super.tearDown();
 	}
 
@@ -209,12 +226,14 @@ protected Repository createNewEmptyRepo() throws IOException {
 		assertTrue(unusedDir.mkdirs());
 		final Repository newRepo = new Repository(newTestRepo);
 		newRepo.create();
+		final String name = getClass().getName() + "." + getName();
 		Runtime.getRuntime().addShutdownHook(new Thread() {
 			@Override
 			public void run() {
-				recursiveDelete(newTestRepo);
+				recursiveDelete(newTestRepo, false, name);
 			}
 		});
+		repositoriesToClose.add(newRepo);
 		return newRepo;
 	}
 
-- 
1.6.0.3.640.g6331a

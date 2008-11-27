From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [JGIT PATCH 2/4] Add shutdown hooks to try to clean up after unit tests anyway
Date: Thu, 27 Nov 2008 22:15:33 +0100
Message-ID: <1227820535-9785-3-git-send-email-robin.rosenberg@dewire.com>
References: <1227820535-9785-1-git-send-email-robin.rosenberg@dewire.com>
 <1227820535-9785-2-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, fonseca@diku.dk,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Thu Nov 27 22:17:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5oEg-0006HN-VD
	for gcvg-git-2@gmane.org; Thu, 27 Nov 2008 22:17:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752960AbYK0VPo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Nov 2008 16:15:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752938AbYK0VPo
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Nov 2008 16:15:44 -0500
Received: from mail.dewire.com ([83.140.172.130]:6581 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752888AbYK0VPk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Nov 2008 16:15:40 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 6EF94147D53B;
	Thu, 27 Nov 2008 22:15:39 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WtMt5Rac2Itd; Thu, 27 Nov 2008 22:15:36 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id EA20F147D53C;
	Thu, 27 Nov 2008 22:15:35 +0100 (CET)
X-Mailer: git-send-email 1.6.0.3.640.g6331a
In-Reply-To: <1227820535-9785-2-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101835>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../org/spearce/jgit/lib/RepositoryTestCase.java   |   18 +++++++++++++++---
 1 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
index 9c272f6..ef4fd1b 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
@@ -66,8 +66,8 @@
 		jcommitter = new PersonIdent("J. Committer", "jcommitter@example.com");
 	}
 
-	protected static boolean recursiveDelete(final File dir) {
-		return recursiveDelete(dir, false, null);
+	protected boolean recursiveDelete(final File dir) {
+		return recursiveDelete(dir, false, getClass().getName() + "." + getName());
 	}
 
 	protected static boolean recursiveDelete(final File dir, boolean silent,
@@ -161,6 +161,12 @@ public void run() {
 			};
 			Runtime.getRuntime().addShutdownHook(shutdownhook);
 		}
+		Runtime.getRuntime().addShutdownHook(new Thread() {
+			@Override
+			public void run() {
+				recursiveDelete(trash);
+			}
+		});
 		db = new Repository(trash_git);
 		db.create();
 
@@ -197,12 +203,18 @@ protected void tearDown() throws Exception {
 	 * @throws IOException
 	 */
 	protected Repository createNewEmptyRepo() throws IOException {
-		File newTestRepo = new File(trashParent, "new"+System.currentTimeMillis()+"/.git");
+		final File newTestRepo = new File(trashParent, "new"+System.currentTimeMillis()+"/.git");
 		assertFalse(newTestRepo.exists());
 		File unusedDir = new File(trashParent, "tmp"+System.currentTimeMillis());
 		assertTrue(unusedDir.mkdirs());
 		final Repository newRepo = new Repository(newTestRepo);
 		newRepo.create();
+		Runtime.getRuntime().addShutdownHook(new Thread() {
+			@Override
+			public void run() {
+				recursiveDelete(newTestRepo);
+			}
+		});
 		return newRepo;
 	}
 
-- 
1.6.0.3.640.g6331a

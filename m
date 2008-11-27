From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [JGIT PATCH 1/4] Make the cleanup less verbose when it fails to delete temporary stuff.
Date: Thu, 27 Nov 2008 22:15:32 +0100
Message-ID: <1227820535-9785-2-git-send-email-robin.rosenberg@dewire.com>
References: <1227820535-9785-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, fonseca@diku.dk,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Thu Nov 27 22:16:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5oEI-00069M-MP
	for gcvg-git-2@gmane.org; Thu, 27 Nov 2008 22:16:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752909AbYK0VPk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Nov 2008 16:15:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752848AbYK0VPk
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Nov 2008 16:15:40 -0500
Received: from mail.dewire.com ([83.140.172.130]:6567 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752719AbYK0VPi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Nov 2008 16:15:38 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id C4904147D53E;
	Thu, 27 Nov 2008 22:15:36 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OAb+TItMiyGY; Thu, 27 Nov 2008 22:15:35 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id BD8C0147D53A;
	Thu, 27 Nov 2008 22:15:35 +0100 (CET)
X-Mailer: git-send-email 1.6.0.3.640.g6331a
In-Reply-To: <1227820535-9785-1-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101831>

Pass the test case name for easier tracking of the test case that
causes problems.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../org/spearce/jgit/lib/RepositoryTestCase.java   |   59 ++++++++++++++-----
 1 files changed, 43 insertions(+), 16 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
index 9d7d133..9c272f6 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
@@ -66,22 +66,43 @@
 		jcommitter = new PersonIdent("J. Committer", "jcommitter@example.com");
 	}
 
-	protected static void recursiveDelete(final File dir) {
+	protected static boolean recursiveDelete(final File dir) {
+		return recursiveDelete(dir, false, null);
+	}
+
+	protected static boolean recursiveDelete(final File dir, boolean silent,
+			final String name) {
+		if (!dir.exists())
+			return silent;
 		final File[] ls = dir.listFiles();
 		if (ls != null) {
 			for (int k = 0; k < ls.length; k++) {
 				final File e = ls[k];
 				if (e.isDirectory()) {
-					recursiveDelete(e);
+					silent = recursiveDelete(e, silent, name);
 				} else {
-					e.delete();
+					if (!e.delete()) {
+						if (!silent) {
+							String msg = "Warning: Failed to delete " + e;
+							if (name != null)
+								msg += " in " + name;
+							System.out.println(msg);
+						}
+						silent = true;
+					}
 				}
 			}
 		}
-		dir.delete();
-		if (dir.exists()) {
-			System.out.println("Warning: Failed to delete " + dir);
+		if (!dir.delete()) {
+			if (!silent) {
+				String msg = "Warning: Failed to delete " + dir;
+				if (name != null)
+					msg += " in " + name;
+				System.out.println(msg);
+			}
+			silent = true;
 		}
+		return silent;
 	}
 
 	protected static void copyFile(final File src, final File dst)
@@ -121,19 +142,25 @@ protected static void checkFile(File f, final String checkData)
 
 	protected Repository db;
 
+	private static int testcount;
+	private static Thread shutdownhook;
+
 	public void setUp() throws Exception {
 		super.setUp();
-		recursiveDelete(trashParent);
-		trash = new File(trashParent,"trash"+System.currentTimeMillis());
+		System.gc();
+		trash = new File(trashParent,"trash"+System.currentTimeMillis()+"."+(testcount++));
+		final String name = getClass().getName() + "." + getName();
+		recursiveDelete(trashParent, true, name);
 		trash_git = new File(trash, ".git");
-
-		Runtime.getRuntime().addShutdownHook(new Thread() {
-			@Override
-			public void run() {
-				recursiveDelete(trashParent);
-			}
-		});
-
+		if (shutdownhook == null) {
+			shutdownhook = new Thread() {
+				@Override
+				public void run() {
+					recursiveDelete(trashParent, false, name);
+				}
+			};
+			Runtime.getRuntime().addShutdownHook(shutdownhook);
+		}
 		db = new Repository(trash_git);
 		db.create();
 
-- 
1.6.0.3.640.g6331a

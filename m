From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [JGIT PATCH 5/8] Make the cleanup less verbose when it fails to delete temporary stuff.
Date: Mon,  1 Dec 2008 00:40:32 +0100
Message-ID: <1228088435-23722-6-git-send-email-robin.rosenberg@dewire.com>
References: <20081127214916.GD23984@spearce.org>
 <1228088435-23722-1-git-send-email-robin.rosenberg@dewire.com>
 <1228088435-23722-2-git-send-email-robin.rosenberg@dewire.com>
 <1228088435-23722-3-git-send-email-robin.rosenberg@dewire.com>
 <1228088435-23722-4-git-send-email-robin.rosenberg@dewire.com>
 <1228088435-23722-5-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, fonseca@diku.dk,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Mon Dec 01 00:42:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6vvj-0001xS-Et
	for gcvg-git-2@gmane.org; Mon, 01 Dec 2008 00:42:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754108AbYK3XlA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Nov 2008 18:41:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753882AbYK3Xkx
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Nov 2008 18:40:53 -0500
Received: from mail.dewire.com ([83.140.172.130]:25208 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753937AbYK3Xkq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2008 18:40:46 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id BE4E7147CE86;
	Mon,  1 Dec 2008 00:40:44 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gxdqeBojPm1H; Mon,  1 Dec 2008 00:40:43 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id D84F7147D541;
	Mon,  1 Dec 2008 00:40:37 +0100 (CET)
X-Mailer: git-send-email 1.6.0.3.640.g6331a
In-Reply-To: <1228088435-23722-5-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101993>

Pass the test case name for easier tracking of the test case that
causes problems.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../org/spearce/jgit/lib/RepositoryTestCase.java   |   36 ++++++++++++++++----
 1 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
index 6ea9b45..8e23bc1 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
@@ -96,21 +96,42 @@ protected void configure() {
 	 * @param dir
 	 */
 	protected static void recursiveDelete(final File dir) {
+		recursiveDelete(dir, false, null);
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
@@ -155,14 +176,15 @@ protected static void checkFile(File f, final String checkData)
 	public void setUp() throws Exception {
 		super.setUp();
 		configure();
-		recursiveDelete(trashParent);
+		final String name = getClass().getName() + "." + getName();
+		recursiveDelete(trashParent, true, name);
 		trash = new File(trashParent,"trash"+System.currentTimeMillis()+"."+(testcount++));
 		trash_git = new File(trash, ".git");
 
 		Runtime.getRuntime().addShutdownHook(new Thread() {
 			@Override
 			public void run() {
-				recursiveDelete(trashParent);
+				recursiveDelete(trashParent, false, name);
 			}
 		});
 
-- 
1.6.0.3.640.g6331a

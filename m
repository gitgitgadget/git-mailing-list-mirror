From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [JGIT PATCH 2/2] Improve closing of files in error situations.
Date: Tue,  2 Dec 2008 22:20:16 +0100
Message-ID: <1228252816-5987-2-git-send-email-robin.rosenberg@dewire.com>
References: <y>
 <1228252816-5987-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Tue Dec 02 22:21:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7cgj-0008DH-W0
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 22:21:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751638AbYLBVUW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2008 16:20:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450AbYLBVUW
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 16:20:22 -0500
Received: from mail.dewire.com ([83.140.172.130]:21129 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751213AbYLBVUU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2008 16:20:20 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id E18048006BF;
	Tue,  2 Dec 2008 22:20:18 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T1lNFFcsI4Mw; Tue,  2 Dec 2008 22:20:17 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id 7CBC580267A;
	Tue,  2 Dec 2008 22:20:17 +0100 (CET)
X-Mailer: git-send-email 1.6.0.3.640.g6331a
In-Reply-To: <1228252816-5987-1-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102176>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../exttst/org/spearce/jgit/lib/SpeedTestBase.java |   12 +++++--
 .../src/org/spearce/jgit/lib/Repository.java       |   31 +++++++++++++-------
 2 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/org.spearce.jgit.test/exttst/org/spearce/jgit/lib/SpeedTestBase.java b/org.spearce.jgit.test/exttst/org/spearce/jgit/lib/SpeedTestBase.java
index 11f7439..36a5e0e 100644
--- a/org.spearce.jgit.test/exttst/org/spearce/jgit/lib/SpeedTestBase.java
+++ b/org.spearce.jgit.test/exttst/org/spearce/jgit/lib/SpeedTestBase.java
@@ -72,10 +72,14 @@
 	protected void prepare(String[] refcmd) throws Exception {
 		try {
 			BufferedReader bufferedReader = new BufferedReader(new FileReader("kernel.ref"));
-			kernelrepo = bufferedReader.readLine();
-			bufferedReader.close();
-			timeNativeGit(kernelrepo, refcmd);
-			nativeTime = timeNativeGit(kernelrepo, refcmd);
+			try {
+				kernelrepo = bufferedReader.readLine();
+				bufferedReader.close();
+				timeNativeGit(kernelrepo, refcmd);
+				nativeTime = timeNativeGit(kernelrepo, refcmd);
+			} finally {
+				bufferedReader.close();
+			}
 		} catch (Exception e) {
 			System.out.println("Create a file named kernel.ref and put the path to the Linux kernels repository there");
 			throw e;
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index b54afd5..da1494f 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -144,10 +144,13 @@ public Repository(final File d) throws IOException {
 		final File altFile = FS.resolve(objectsDir, "info/alternates");
 		if (altFile.exists()) {
 			BufferedReader ar = new BufferedReader(new FileReader(altFile));
-			for (String alt=ar.readLine(); alt!=null; alt=ar.readLine()) {
-				readObjectsDirs(FS.resolve(objectsDir, alt), ret);
+			try {
+				for (String alt=ar.readLine(); alt!=null; alt=ar.readLine()) {
+					readObjectsDirs(FS.resolve(objectsDir, alt), ret);
+				}
+			} catch (Exception e) {
+				ar.close();
 			}
-			ar.close();
 		}
 		return ret;
 	}
@@ -1027,15 +1030,21 @@ public boolean isStGitMode() {
 		if (isStGitMode()) {
 			File patchDir = new File(new File(getDirectory(),"patches"),getBranch());
 			BufferedReader apr = new BufferedReader(new FileReader(new File(patchDir,"applied")));
-			for (String patchName=apr.readLine(); patchName!=null; patchName=apr.readLine()) {
-				File topFile = new File(new File(new File(patchDir,"patches"), patchName), "top");
-				BufferedReader tfr = new BufferedReader(new FileReader(topFile));
-				String objectId = tfr.readLine();
-				ObjectId id = ObjectId.fromString(objectId);
-				ret.put(id, new StGitPatch(patchName, id));
-				tfr.close();
+			try {
+				for (String patchName=apr.readLine(); patchName!=null; patchName=apr.readLine()) {
+					File topFile = new File(new File(new File(patchDir,"patches"), patchName), "top");
+					BufferedReader tfr = new BufferedReader(new FileReader(topFile));
+					try {
+						String objectId = tfr.readLine();
+						ObjectId id = ObjectId.fromString(objectId);
+						ret.put(id, new StGitPatch(patchName, id));
+					} finally {
+						tfr.close();
+					}
+				}
+			} finally {
+				apr.close();
 			}
-			apr.close();
 		}
 		return ret;
 	}
-- 
1.6.0.3.640.g6331a

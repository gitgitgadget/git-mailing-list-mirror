From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [JGIT PATCH 2/2 v2] Improve closing of files in error situations.
Date: Tue,  2 Dec 2008 22:41:28 +0100
Message-ID: <1228254088-8490-1-git-send-email-robin.rosenberg@dewire.com>
References: <1228252816-5987-2-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Tue Dec 02 22:42:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7d16-0007Ys-JY
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 22:42:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751993AbYLBVlb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2008 16:41:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751848AbYLBVlb
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 16:41:31 -0500
Received: from mail.dewire.com ([83.140.172.130]:21356 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751944AbYLBVla (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2008 16:41:30 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 498C280267A;
	Tue,  2 Dec 2008 22:41:29 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4CZ8rJME-Pfc; Tue,  2 Dec 2008 22:41:28 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id 57C438006BF;
	Tue,  2 Dec 2008 22:41:28 +0100 (CET)
X-Mailer: git-send-email 1.6.0.3.640.g6331a
In-Reply-To: <1228252816-5987-2-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102180>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../exttst/org/spearce/jgit/lib/SpeedTestBase.java |   12 +++++--
 .../dircache/DirCacheCGitCompatabilityTest.java    |   24 ++++++++++-----
 .../org/spearce/jgit/lib/RepositoryTestCase.java   |   27 +++++++++++------
 .../src/org/spearce/jgit/lib/GitIndex.java         |    2 +-
 .../src/org/spearce/jgit/lib/Repository.java       |   31 +++++++++++++-------
 5 files changed, 63 insertions(+), 33 deletions(-)

I was a bit quick there. This is an extended version of patch 2/2.

-- robin

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
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheCGitCompatabilityTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheCGitCompatabilityTest.java
index b052686..42832fe 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheCGitCompatabilityTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheCGitCompatabilityTest.java
@@ -146,10 +146,14 @@ private File pathOf(final String name) {
 		final LinkedHashMap<String, CGitIndexRecord> r = new LinkedHashMap<String, CGitIndexRecord>();
 		final BufferedReader br = new BufferedReader(new InputStreamReader(
 				new FileInputStream(pathOf("gitgit.lsfiles")), "UTF-8"));
-		String line;
-		while ((line = br.readLine()) != null) {
-			final CGitIndexRecord cr = new CGitIndexRecord(line);
-			r.put(cr.path, cr);
+		try {
+			String line;
+			while ((line = br.readLine()) != null) {
+				final CGitIndexRecord cr = new CGitIndexRecord(line);
+				r.put(cr.path, cr);
+			}
+		} finally {
+			br.close();
 		}
 		return r;
 	}
@@ -158,10 +162,14 @@ private File pathOf(final String name) {
 		final LinkedHashMap<String, CGitLsTreeRecord> r = new LinkedHashMap<String, CGitLsTreeRecord>();
 		final BufferedReader br = new BufferedReader(new InputStreamReader(
 				new FileInputStream(pathOf("gitgit.lstree")), "UTF-8"));
-		String line;
-		while ((line = br.readLine()) != null) {
-			final CGitLsTreeRecord cr = new CGitLsTreeRecord(line);
-			r.put(cr.path, cr);
+		try {
+			String line;
+			while ((line = br.readLine()) != null) {
+				final CGitLsTreeRecord cr = new CGitLsTreeRecord(line);
+				r.put(cr.path, cr);
+			}
+		} finally {
+			br.close();
 		}
 		return r;
 	}
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
index 22bf395..8937145 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
@@ -152,14 +152,20 @@ private static void reportDeleteFailure(final String name,
 	protected static void copyFile(final File src, final File dst)
 			throws IOException {
 		final FileInputStream fis = new FileInputStream(src);
-		final FileOutputStream fos = new FileOutputStream(dst);
-		final byte[] buf = new byte[4096];
-		int r;
-		while ((r = fis.read(buf)) > 0) {
-			fos.write(buf, 0, r);
+		try {
+			final FileOutputStream fos = new FileOutputStream(dst);
+			try {
+				final byte[] buf = new byte[4096];
+				int r;
+				while ((r = fis.read(buf)) > 0) {
+					fos.write(buf, 0, r);
+				}
+			} finally {
+				fos.close();
+			}
+		} finally {
+			fis.close();
 		}
-		fis.close();
-		fos.close();
 	}
 
 	protected File writeTrashFile(final String name, final String data)
@@ -170,8 +176,11 @@ protected File writeTrashFile(final String name, final String data)
 			throw new Error("Could not create directory " + tf.getParentFile());
 		final OutputStreamWriter fw = new OutputStreamWriter(
 				new FileOutputStream(tf), "UTF-8");
-		fw.write(data);
-		fw.close();
+		try {
+			fw.write(data);
+		} finally {
+			fw.close();
+		}
 		return tf;
 	}
 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/GitIndex.java b/org.spearce.jgit/src/org/spearce/jgit/lib/GitIndex.java
index bafddef..7ff6754 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/GitIndex.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/GitIndex.java
@@ -547,8 +547,8 @@ public boolean isModified(File wd, boolean forceContentCheck) {
 
 				try {
 					InputStream is = new FileInputStream(file);
-					ObjectWriter objectWriter = new ObjectWriter(db);
 					try {
+						ObjectWriter objectWriter = new ObjectWriter(db);
 						ObjectId newId = objectWriter.computeBlobSha1(file
 								.length(), is);
 						boolean ret = !newId.equals(sha1);
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

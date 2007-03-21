From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH] Use the alternates links for finding objects
Date: Thu, 22 Mar 2007 00:59:32 +0100
Message-ID: <20070321235931.23981.41286.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Thu Mar 22 00:57:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUAgh-0007VA-0j
	for gcvg-git@gmane.org; Thu, 22 Mar 2007 00:57:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934095AbXCUX51 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Mar 2007 19:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934101AbXCUX51
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Mar 2007 19:57:27 -0400
Received: from [83.140.172.130] ([83.140.172.130]:3054 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S934095AbXCUX5Z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2007 19:57:25 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 033AB802860;
	Thu, 22 Mar 2007 00:52:01 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 27725-10; Thu, 22 Mar 2007 00:52:00 +0100 (CET)
Received: from lathund.dewire.com (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 7DEB3802657;
	Thu, 22 Mar 2007 00:51:58 +0100 (CET)
Received: from localhost (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id C6589296C8;
	Thu, 22 Mar 2007 00:59:44 +0100 (CET)
X-Virus-Scanned: amavisd-new at localhost.localdomain
Received: from lathund.dewire.com ([127.0.0.1])
	by localhost (lathund.dewire.com [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id BIzwSRmQCiU2; Thu, 22 Mar 2007 00:59:33 +0100 (CET)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id B5840291BB;
	Thu, 22 Mar 2007 00:59:32 +0100 (CET)
User-Agent: StGIT/0.12
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42826>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---

 .../src/org/spearce/jgit/lib/Repository.java       |   58 +++++++++++++++++------
 1 files changed, 44 insertions(+), 14 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index f1999d1..d74da7c 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -39,7 +39,7 @@ public class Repository {
 
 	private final File gitDir;
 
-	private final File objectsDir;
+	private final File[] objectsDirs;
 
 	private final File refsDir;
 
@@ -54,11 +54,17 @@ public class Repository {
 
 	public Repository(final File d) throws IOException {
 		gitDir = d.getAbsoluteFile();
-		objectsDir = new File(gitDir, "objects");
+		try {
+			objectsDirs = (File[])readObjectsDirs(new File(gitDir, "objects"), new ArrayList()).toArray(new File[0]);
+		} catch (IOException e) {
+			IOException ex = new IOException("Cannot find all object dirs for " + gitDir);
+			ex.initCause(e);
+			throw ex;
+		}
 		refsDir = new File(gitDir, "refs");
 		packs = new PackFile[0];
 		config = new RepositoryConfig(this);
-		if (objectsDir.exists()) {
+		if (objectsDirs[0].exists()) {
 			getConfig().load();
 			final String repositoryFormatVersion = getConfig().getString(
 					"core", "repositoryFormatVersion");
@@ -71,6 +77,19 @@ public class Repository {
 		}
 	}
 
+	private Collection readObjectsDirs(File objectsDir, Collection ret) throws IOException {
+		ret.add(objectsDir);
+		File alternatesFile = new File(objectsDir,"info/alternates");
+		if (alternatesFile.exists()) {
+			BufferedReader ar = new BufferedReader(new FileReader(alternatesFile));
+			for (String alt=ar.readLine(); alt!=null; alt=ar.readLine()) {
+				readObjectsDirs(new File(alt), ret);
+			}
+			ar.close();
+		}
+		return ret;
+	}
+
 	public void create() throws IOException {
 		if (gitDir.exists()) {
 			throw new IllegalStateException("Repository already exists: "
@@ -79,9 +98,9 @@ public class Repository {
 
 		gitDir.mkdirs();
 
-		objectsDir.mkdirs();
-		new File(objectsDir, "pack").mkdir();
-		new File(objectsDir, "info").mkdir();
+		objectsDirs[0].mkdirs();
+		new File(objectsDirs[0], "pack").mkdir();
+		new File(objectsDirs[0], "info").mkdir();
 
 		refsDir.mkdir();
 		new File(refsDir, "heads").mkdir();
@@ -106,7 +125,7 @@ public class Repository {
 	}
 
 	public File getObjectsDirectory() {
-		return objectsDir;
+		return objectsDirs[0];
 	}
 
 	public RepositoryConfig getConfig() {
@@ -119,7 +138,14 @@ public class Repository {
 
 	public File toFile(final ObjectId objectId) {
 		final String n = objectId.toString();
-		return new File(new File(objectsDir, n.substring(0, 2)), n.substring(2));
+		String d=n.substring(0, 2);
+		String f=n.substring(2);
+		for (int i=0; i<objectsDirs.length; ++i) {
+			File ret = new File(new File(objectsDirs[i], d), f);
+			if (ret.exists())
+				return ret;
+		}
+		return new File(new File(objectsDirs[0], d), f);
 	}
 
 	public boolean hasObject(final ObjectId objectId) {
@@ -291,7 +317,15 @@ public class Repository {
 	}
 
 	public void scanForPacks() {
-		final File packDir = new File(objectsDir, "pack");
+		final ArrayList p = new ArrayList();
+		for (int i=0; i<objectsDirs.length; ++i)
+			scanForPacks(new File(objectsDirs[i], "pack"), p);
+		final PackFile[] arr = new PackFile[p.size()];
+		p.toArray(arr);
+		packs = arr;
+	}
+
+	public void scanForPacks(final File packDir, Collection packList) {
 		final File[] list = packDir.listFiles(new FileFilter() {
 			public boolean accept(final File f) {
 				final String n = f.getName();
@@ -304,18 +338,14 @@ public class Repository {
 						&& idx.canRead();
 			}
 		});
-		final ArrayList p = new ArrayList(list.length);
 		for (int k = 0; k < list.length; k++) {
 			try {
-				p.add(new PackFile(this, list[k]));
+				packList.add(new PackFile(this, list[k]));
 			} catch (IOException ioe) {
 				// Whoops. That's not a pack!
 				//
 			}
 		}
-		final PackFile[] arr = new PackFile[p.size()];
-		p.toArray(arr);
-		packs = arr;
 	}
 
 	private void writeSymref(final String name, final String target)

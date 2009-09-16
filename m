From: mr.gaffo@gmail.com
Subject: [PATCH JGit 3/5] Implemented directory based info cache for objects/info/packs.
Date: Tue, 15 Sep 2009 19:48:34 -0500
Message-ID: <1253062116-13830-4-git-send-email-mr.gaffo@gmail.com>
References: <1253062116-13830-1-git-send-email-mr.gaffo@gmail.com>
 <1253062116-13830-2-git-send-email-mr.gaffo@gmail.com>
 <1253062116-13830-3-git-send-email-mr.gaffo@gmail.com>
Cc: Mike Gaffney <mr.gaffo@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 16 02:56:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mniok-0002BD-CG
	for gcvg-git-2@lo.gmane.org; Wed, 16 Sep 2009 02:56:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752381AbZIPA4J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2009 20:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752321AbZIPA4I
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Sep 2009 20:56:08 -0400
Received: from mail-qy0-f181.google.com ([209.85.221.181]:36165 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751181AbZIPA4G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2009 20:56:06 -0400
Received: by qyk11 with SMTP id 11so3780439qyk.1
        for <git@vger.kernel.org>; Tue, 15 Sep 2009 17:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Tq2r65uW7RUlOtyv97OUu8J4hmY5QJIGpO67OvzKvVg=;
        b=GpV7TpRLWfIx834q66hmjZYL9QlZGbvoVW873flwjd8ACrqGRKZVKSYJj48bq84nUh
         CZTNlQOwTeMr4+o8JaBeP8pWmLEEHaHUJfp7btmfQAZ/SmOmugaeoxFEI1PVhYMVELEy
         +gsAlCw/7LmLFPqfMiMsRUW27jEPZNpu6m6zY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=BRfh1xssDIshLASxrKfOmHwHzPKuNvgtlwLA09NsznO7Y45NoV5nMbMRi9eEJTVMaP
         T3eme1vCBC/+PzBNouigqGcPAAb38DbnKKtS1vF8/sUapOjvpri+riqR3m2TOhEvI5mA
         9it7ZvcB84iTv1xSzgQNxB7Ijs1j1IAmQnrY8=
Received: by 10.224.78.10 with SMTP id i10mr569707qak.238.1253062127791;
        Tue, 15 Sep 2009 17:48:47 -0700 (PDT)
Received: from localhost.localdomain (nat.asynchrony.com [66.236.120.131])
        by mx.google.com with ESMTPS id 4sm173278qwe.5.2009.09.15.17.48.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 15 Sep 2009 17:48:47 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.2
In-Reply-To: <1253062116-13830-3-git-send-email-mr.gaffo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128599>

From: Mike Gaffney <mr.gaffo@gmail.com>

Details:

Add abstract method for updating the object db's info cache to directory.

Implemented passthrough on Alternate for the update of infocache.

Added utility that generates the contents of the objects/info/packs
file as a string from a list of PackFiles.

Added implementation from ObjectDirectory on down
for creating the info cache.

Added test for creating the info cache

Signed-off-by: Mike Gaffney <mr.gaffo@gmail.com>
---
 .../CachedPacksInfoFileContentsGeneratorTest.java  |   74 ++++++++++++++++++++
 .../org/spearce/jgit/lib/ObjectDirectoryTest.java  |   36 +++++++---
 .../tst/org/spearce/jgit/util/JGitTestUtil.java    |   26 ++++++-
 .../jgit/lib/AlternateRepositoryDatabase.java      |    5 ++
 .../lib/CachedPacksInfoFileContentsGenerator.java  |   63 +++++++++++++++++
 .../src/org/spearce/jgit/lib/Constants.java        |    3 +
 .../src/org/spearce/jgit/lib/ObjectDatabase.java   |    8 ++
 .../src/org/spearce/jgit/lib/ObjectDirectory.java  |    5 ++
 .../lib/UpdateDirectoryBasedPacksInfoCache.java    |   62 ++++++++++++++++
 .../spearce/jgit/lib/UpdateDirectoryInfoCache.java |   26 +++++++
 .../org/spearce/jgit/transport/ReceivePack.java    |   10 +++
 11 files changed, 307 insertions(+), 11 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/lib/CachedPacksInfoFileContentsGeneratorTest.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/CachedPacksInfoFileContentsGenerator.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/UpdateDirectoryBasedPacksInfoCache.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/UpdateDirectoryInfoCache.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/CachedPacksInfoFileContentsGeneratorTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/CachedPacksInfoFileContentsGeneratorTest.java
new file mode 100644
index 0000000..bea0b70
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/CachedPacksInfoFileContentsGeneratorTest.java
@@ -0,0 +1,74 @@
+/*
+ * Copyright (C) 2009, Mike Gaffney.
+ *
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or
+ * without modification, are permitted provided that the following
+ * conditions are met:
+ *
+ * - Redistributions of source code must retain the above copyright
+ *   notice, this list of conditions and the following disclaimer.
+ *
+ * - Redistributions in binary form must reproduce the above
+ *   copyright notice, this list of conditions and the following
+ *   disclaimer in the documentation and/or other materials provided
+ *   with the distribution.
+ *
+ * - Neither the name of the Git Development Community nor the
+ *   names of its contributors may be used to endorse or promote
+ *   products derived from this software without specific prior
+ *   written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
+ * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
+ * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+package org.spearce.jgit.lib;
+
+import java.io.File;
+import java.util.ArrayList;
+import java.util.List;
+
+import org.spearce.jgit.util.JGitTestUtil;
+
+import junit.framework.TestCase;
+
+public class CachedPacksInfoFileContentsGeneratorTest extends TestCase {
+	private static final String PACK_NAME = "pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f";
+	private static final File TEST_PACK = JGitTestUtil.getTestResourceFile(PACK_NAME + ".pack");
+	private static final File TEST_IDX = JGitTestUtil.getTestResourceFile(PACK_NAME + ".idx");
+
+	public void testGettingPacksContentsSinglePack() throws Exception {
+		List<PackFile> packs = new ArrayList<PackFile>();
+		packs.add(new PackFile(TEST_IDX, TEST_PACK));
+		
+		assertEquals("P " + TEST_PACK.getName() + "\n\n", new CachedPacksInfoFileContentsGenerator(packs).generateContents());
+	}
+	
+	public void testGettingPacksContentsMultiplePacks() throws Exception {
+		List<PackFile> packs = new ArrayList<PackFile>();
+		packs.add(new PackFile(TEST_IDX, TEST_PACK));
+		packs.add(new PackFile(TEST_IDX, TEST_PACK));
+		packs.add(new PackFile(TEST_IDX, TEST_PACK));
+		
+		StringBuilder expected = new StringBuilder();
+		expected.append("P ").append(TEST_PACK.getName()).append("\n");
+		expected.append("P ").append(TEST_PACK.getName()).append("\n");
+		expected.append("P ").append(TEST_PACK.getName()).append("\n");
+		expected.append("\n");
+		
+		assertEquals(expected.toString(), new CachedPacksInfoFileContentsGenerator(packs).generateContents());
+	}
+	
+}
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ObjectDirectoryTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ObjectDirectoryTest.java
index c27580f..204fb7c 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ObjectDirectoryTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ObjectDirectoryTest.java
@@ -38,8 +38,8 @@
 
 import java.io.File;
 import java.io.IOException;
+import java.util.ArrayList;
 import java.util.List;
-import java.util.UUID;
 
 import org.spearce.jgit.util.JGitTestUtil;
 
@@ -54,9 +54,9 @@
 
 	@Override
 	protected void setUp() throws Exception {
-		testDir = new File(new File(System.getProperty("java.io.tmpdir")), UUID.randomUUID().toString());
+		testDir = JGitTestUtil.generateTempDirectoryFileObject();
 	}
-	
+
 	@Override
 	protected void tearDown() throws Exception {
 		if (testDir.exists()){
@@ -106,23 +106,41 @@ public void testListLocalPacksNotCreated() throws Exception {
 	}
 	
 	public void testListLocalPacksWhenThereIsAPack() throws Exception {
-		createTestDir();
-		File packsDir = new File(testDir, "pack");
-		packsDir.mkdirs();
-		
-		JGitTestUtil.copyFile(TEST_PACK, new File(packsDir, TEST_PACK.getName()));
-		JGitTestUtil.copyFile(TEST_IDX, new File(packsDir, TEST_IDX.getName()));
+		createSamplePacksDir();
 
 		ObjectDirectory od = new ObjectDirectory(testDir);
 		List<PackFile> localPacks = od.listLocalPacks();
 		assertEquals(1, localPacks.size());
 		assertEquals(TEST_PACK.getName(), localPacks.get(0).getPackFile().getName());
 	}
+	
+	public void testUpdateInfoCacheCreatesPacksAndRefsFile() throws Exception {
+		createSamplePacksDir();
+
+		ObjectDirectory od = new ObjectDirectory(testDir);
+		od.create();
+		od.updateInfoCache();
+		
+		String expectedContents = new CachedPacksInfoFileContentsGenerator(od.listLocalPacks()).generateContents();
+		File packsFile = new File(od.getDirectory(), Constants.CACHED_PACKS_FILE);
+
+		assertTrue(packsFile.exists());
+		assertEquals(expectedContents, JGitTestUtil.readFileAsString(packsFile));
+	}
 
 	private void createTestDir(){
 		if (!testDir.mkdir()){
 			fail("unable to create test directory");
 		}
 	}
+
+	private void createSamplePacksDir() throws IOException {
+		createTestDir();
+		File packsDir = new File(testDir, "pack");
+		packsDir.mkdirs();
+		
+		JGitTestUtil.copyFile(TEST_PACK, new File(packsDir, TEST_PACK.getName()));
+		JGitTestUtil.copyFile(TEST_IDX, new File(packsDir, TEST_IDX.getName()));
+	}
 	
 }
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/util/JGitTestUtil.java b/org.spearce.jgit.test/tst/org/spearce/jgit/util/JGitTestUtil.java
index 785922a..44630fd 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/util/JGitTestUtil.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/util/JGitTestUtil.java
@@ -37,15 +37,17 @@
 
 package org.spearce.jgit.util;
 
+import java.io.BufferedReader;
 import java.io.File;
 import java.io.FileInputStream;
-import java.io.FileNotFoundException;
 import java.io.FileOutputStream;
+import java.io.FileReader;
 import java.io.IOException;
 import java.io.InputStream;
 import java.io.OutputStream;
 import java.net.URISyntaxException;
 import java.net.URL;
+import java.util.UUID;
 
 import junit.framework.AssertionFailedError;
 
@@ -74,7 +76,8 @@ public static File getTestResourceFile(final String fileName) {
 		}
 	}
 
-	public static void copyFile(final File fromFile, final File toFile) throws IOException {
+	public static void copyFile(final File fromFile, final File toFile)
+			throws IOException {
 		InputStream in = new FileInputStream(fromFile);
 		OutputStream out = new FileOutputStream(toFile);
 
@@ -87,6 +90,21 @@ public static void copyFile(final File fromFile, final File toFile) throws IOExc
 		out.close();
 	}
 
+	public static String readFileAsString(final File file)
+			throws java.io.IOException {
+		StringBuilder fileData = new StringBuilder(1000);
+		BufferedReader reader = new BufferedReader(new FileReader(file));
+		char[] buf = new char[1024];
+		int numRead = 0;
+		while ((numRead = reader.read(buf)) != -1) {
+			String readData = String.valueOf(buf, 0, numRead);
+			fileData.append(readData);
+			buf = new char[1024];
+		}
+		reader.close();
+		return fileData.toString();
+	}
+
 	private static ClassLoader cl() {
 		return JGitTestUtil.class.getClassLoader();
 	}
@@ -136,4 +154,8 @@ private static void reportDeleteFailure(final String name,
 		else
 			System.out.println(msg);
 	}
+
+	public static File generateTempDirectoryFileObject() {
+		return new File(new File(System.getProperty("java.io.tmpdir")), UUID.randomUUID().toString());
+	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/AlternateRepositoryDatabase.java b/org.spearce.jgit/src/org/spearce/jgit/lib/AlternateRepositoryDatabase.java
index 68ad488..70ce505 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/AlternateRepositoryDatabase.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/AlternateRepositoryDatabase.java
@@ -130,4 +130,9 @@ protected void closeAlternates(final ObjectDatabase[] alt) {
 	public List<PackFile> listLocalPacks() {
 		return odb.listLocalPacks();
 	}
+
+	@Override
+	public void updateInfoCache() throws IOException {
+		odb.updateInfoCache();
+	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/CachedPacksInfoFileContentsGenerator.java b/org.spearce.jgit/src/org/spearce/jgit/lib/CachedPacksInfoFileContentsGenerator.java
new file mode 100644
index 0000000..6046c94
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/CachedPacksInfoFileContentsGenerator.java
@@ -0,0 +1,63 @@
+/*
+ * Copyright (C) 2009, Mike Gaffney.
+ *
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or
+ * without modification, are permitted provided that the following
+ * conditions are met:
+ *
+ * - Redistributions of source code must retain the above copyright
+ *   notice, this list of conditions and the following disclaimer.
+ *
+ * - Redistributions in binary form must reproduce the above
+ *   copyright notice, this list of conditions and the following
+ *   disclaimer in the documentation and/or other materials provided
+ *   with the distribution.
+ *
+ * - Neither the name of the Git Development Community nor the
+ *   names of its contributors may be used to endorse or promote
+ *   products derived from this software without specific prior
+ *   written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
+ * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
+ * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+package org.spearce.jgit.lib;
+
+import java.util.List;
+
+/**
+ * This file is used to generate the contents of the file system
+ * based pack file cache used by the dumb git-http client protocol.
+ * @author mike
+ */
+public class CachedPacksInfoFileContentsGenerator {
+
+	private List<PackFile> packs;
+
+	public CachedPacksInfoFileContentsGenerator(List<PackFile> packs) {
+		this.packs = packs;
+	}
+	
+	public String generateContents(){
+		StringBuilder builder = new StringBuilder();
+		for (PackFile packFile : packs) {
+			builder.append("P ").append(packFile.getPackFile().getName()).append('\n');
+		}
+		builder.append('\n');
+		return builder.toString();
+	}
+	
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java
index 9afea67..2d78dda 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java
@@ -224,6 +224,9 @@
 
 	/** Info refs folder */
 	public static final String INFO_REFS = "info/refs";
+	
+	/** cached packs file */
+	public static final String CACHED_PACKS_FILE = "info/packs"; 
 
 	/** Packed refs file */
 	public static final String PACKED_REFS = "packed-refs";
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDatabase.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDatabase.java
index 722c802..5ded7bb 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDatabase.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDatabase.java
@@ -75,6 +75,14 @@ protected ObjectDatabase() {
 	public abstract List<PackFile> listLocalPacks();
 	
 	/**
+	 * Creates the caches that are typically done by 
+	 * update-server-info, namely objects/info/packs and 
+	 * info/refs
+	 * @throws IOException 
+	 */
+	public abstract void updateInfoCache() throws IOException;
+	
+	/**
 	 * Does this database exist yet?
 	 *
 	 * @return true if this database is already created; false if the caller
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDirectory.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDirectory.java
index cbe132d..f4251c1 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDirectory.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDirectory.java
@@ -514,4 +514,9 @@ boolean tryAgain(final long currLastModified) {
 		tryAgain1();
 		return new ArrayList<PackFile>(Arrays.asList(packList.get().packs));
 	}
+
+	@Override
+	public void updateInfoCache() throws IOException {
+		new UpdateDirectoryBasedPacksInfoCache(this.listLocalPacks(), new File(this.getDirectory(), Constants.CACHED_PACKS_FILE)).execute();
+	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/UpdateDirectoryBasedPacksInfoCache.java b/org.spearce.jgit/src/org/spearce/jgit/lib/UpdateDirectoryBasedPacksInfoCache.java
new file mode 100644
index 0000000..327bb34
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/UpdateDirectoryBasedPacksInfoCache.java
@@ -0,0 +1,62 @@
+/*
+ * Copyright (C) 2009, Mike Gaffney.
+ *
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or
+ * without modification, are permitted provided that the following
+ * conditions are met:
+ *
+ * - Redistributions of source code must retain the above copyright
+ *   notice, this list of conditions and the following disclaimer.
+ *
+ * - Redistributions in binary form must reproduce the above
+ *   copyright notice, this list of conditions and the following
+ *   disclaimer in the documentation and/or other materials provided
+ *   with the distribution.
+ *
+ * - Neither the name of the Git Development Community nor the
+ *   names of its contributors may be used to endorse or promote
+ *   products derived from this software without specific prior
+ *   written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
+ * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
+ * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+package org.spearce.jgit.lib;
+
+import java.io.File;
+import java.io.FileOutputStream;
+import java.io.IOException;
+import java.util.List;
+
+public class UpdateDirectoryBasedPacksInfoCache {
+
+	private List<PackFile> packsList;
+	private File infoPacksFile;
+
+	public UpdateDirectoryBasedPacksInfoCache(List<PackFile> packsList,
+									File infoPacksFile) {
+		this.packsList = packsList;
+		this.infoPacksFile = infoPacksFile;
+	}
+
+	public void execute() throws IOException {
+		String packsContents = new CachedPacksInfoFileContentsGenerator(packsList).generateContents();
+		FileOutputStream fos = new FileOutputStream(infoPacksFile);
+		fos.write(packsContents.getBytes());
+		fos.close();
+	}
+
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/UpdateDirectoryInfoCache.java b/org.spearce.jgit/src/org/spearce/jgit/lib/UpdateDirectoryInfoCache.java
new file mode 100644
index 0000000..b6947ce
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/UpdateDirectoryInfoCache.java
@@ -0,0 +1,26 @@
+package org.spearce.jgit.lib;
+
+import java.io.File;
+import java.io.FileOutputStream;
+import java.io.IOException;
+import java.util.List;
+
+public class UpdateDirectoryInfoCache {
+
+	private List<PackFile> packsList;
+	private File infoPacksFile;
+
+	public UpdateDirectoryInfoCache(List<PackFile> packsList,
+									File infoPacksFile) {
+		this.packsList = packsList;
+		this.infoPacksFile = infoPacksFile;
+	}
+
+	public void execute() throws IOException {
+		String packsContents = new CachedPacksInfoFileContentsGenerator(packsList).generateContents();
+		FileOutputStream fos = new FileOutputStream(infoPacksFile);
+		fos.write(packsContents.getBytes());
+		fos.close();
+	}
+
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/ReceivePack.java b/org.spearce.jgit/src/org/spearce/jgit/transport/ReceivePack.java
index eb21254..5865736 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/ReceivePack.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/ReceivePack.java
@@ -521,6 +521,16 @@ void sendString(final String s) throws IOException {
 			}
 
 			postReceive.onPostReceive(this, filterCommands(Result.OK));
+			updateObjectInfoCache();
+		}
+	}
+
+	private void updateObjectInfoCache() {
+		try{
+			getRepository().getObjectDatabase().updateInfoCache();
+		} 
+		catch (IOException e){
+			sendMessage("error updating server info: " + e.getMessage());
 		}
 	}
 
-- 
1.6.4.2

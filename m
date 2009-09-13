From: mr.gaffo@gmail.com
Subject: [PATCH JGit 07/19] implemented the packs file update functionality
Date: Sun, 13 Sep 2009 13:44:23 -0500
Message-ID: <1252867475-858-8-git-send-email-mr.gaffo@gmail.com>
References: <1252867475-858-1-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-2-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-3-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-4-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-5-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-6-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-7-git-send-email-mr.gaffo@gmail.com>
Cc: "mike.gaffney" <mike.gaffney@asolutions.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 13 20:45:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mmu4k-0003Gw-Cx
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 20:45:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753405AbZIMSoz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 14:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753350AbZIMSoy
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 14:44:54 -0400
Received: from an-out-0708.google.com ([209.85.132.249]:20766 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752931AbZIMSor (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 14:44:47 -0400
Received: by an-out-0708.google.com with SMTP id d40so7549088and.1
        for <git@vger.kernel.org>; Sun, 13 Sep 2009 11:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=VbrVQSzQINVSwhBOsa/LyRBrdEeUQqEeRHd4vwmKbYw=;
        b=JjI4UVKwm4LfvjGYkoWv6p9o38ImfVtcWEVlViNPyQi5ehi9Ss8QiaA300QzcttwU/
         KB5CCV6TE1yOlSSkjKYbMq+Co1cWiG7QyPDdvc9zoQcuSbUEhYOj6lWoPgVm6VeKXQI2
         /jMeXxaiJo+MWIQQ8/LZX95KRMAySWiPO8Jk8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=URWoQ1ND9Wg5wn5adW1Z89X0/z69rVlPfBvJLK33MHJKGbUEnfLXm03/t7hqTv5SYl
         IBIXMmEFmp13qo27TqmPmK+9zJKAJh9syY4z7NPbLaAUHm2mu97+9rGpqWoIOa1R3r5n
         I+J91T1hKiZQV5iW0nvRRNNpY4o9eDIFGmLWs=
Received: by 10.101.162.10 with SMTP id p10mr5518976ano.92.1252867490704;
        Sun, 13 Sep 2009 11:44:50 -0700 (PDT)
Received: from localhost.localdomain ([70.230.157.86])
        by mx.google.com with ESMTPS id 23sm1238736yxe.0.2009.09.13.11.44.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 13 Sep 2009 11:44:50 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.2
In-Reply-To: <1252867475-858-7-git-send-email-mr.gaffo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128389>

From: mike.gaffney <mike.gaffney@asolutions.com>

---
 .../jgit/lib/UpdateDirectoryInfoCacheTest.java     |   23 ++++++++++++++++++-
 .../spearce/jgit/lib/UpdateDirectoryInfoCache.java |   17 +++++++++-----
 2 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/UpdateDirectoryInfoCacheTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/UpdateDirectoryInfoCacheTest.java
index 11d183e..25b78c5 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/UpdateDirectoryInfoCacheTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/UpdateDirectoryInfoCacheTest.java
@@ -1,11 +1,30 @@
 package org.spearce.jgit.lib;
 
+import java.io.File;
+import java.util.ArrayList;
+import java.util.List;
+
 import junit.framework.TestCase;
 
+import org.spearce.jgit.util.JGitTestUtil;
+
 public class UpdateDirectoryInfoCacheTest extends TestCase {
+	private static final String PACK_NAME = "pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f";
+	private static final File TEST_PACK = JGitTestUtil.getTestResourceFile(PACK_NAME + ".pack");
+	private static final File TEST_IDX = JGitTestUtil.getTestResourceFile(PACK_NAME + ".idx");
 	
-	public void testBase() throws Exception {
-		fail("nyi");
+	public void testCreatesTheFileAndPutsTheContentsIn() throws Exception {
+		List<PackFile> packs = new ArrayList<PackFile>();
+		packs.add(new PackFile(TEST_IDX, TEST_PACK));
+		
+		File packsFile = File.createTempFile(UpdateDirectoryInfoCacheTest.class.getSimpleName(), "tstdata");
+		packsFile.deleteOnExit();
+		
+		String expectedContents = new PacksFileContentsCreator(packs).toString();
+		
+		new UpdateDirectoryInfoCache(packs, packsFile).execute();
+		
+		assertEquals(expectedContents, JGitTestUtil.readFileAsString(packsFile));
 	}
 
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/UpdateDirectoryInfoCache.java b/org.spearce.jgit/src/org/spearce/jgit/lib/UpdateDirectoryInfoCache.java
index 2bceb9e..72a315a 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/UpdateDirectoryInfoCache.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/UpdateDirectoryInfoCache.java
@@ -1,22 +1,27 @@
 package org.spearce.jgit.lib;
 
+import java.io.BufferedWriter;
 import java.io.File;
+import java.io.FileOutputStream;
+import java.io.IOException;
 import java.util.List;
 
 public class UpdateDirectoryInfoCache {
 
 	private List<PackFile> packsList;
-	private File infoDirectory;
+	private File infoPacksFile;
 
 	public UpdateDirectoryInfoCache(List<PackFile> packsList,
-			File infoDirectory) {
+									File infoPacksFile) {
 		this.packsList = packsList;
-		this.infoDirectory = infoDirectory;
+		this.infoPacksFile = infoPacksFile;
 	}
 
-	public void execute() {
-//		File objectFile = objectDatabase.
-//		String packsContents = new PacksFileContentsCreator(this.objectDatabase.listLocalPacks()).toString();
+	public void execute() throws IOException {
+		String packsContents = new PacksFileContentsCreator(packsList).toString();
+		FileOutputStream fos = new FileOutputStream(infoPacksFile);
+		fos.write(packsContents.getBytes());
+		fos.close();
 	}
 
 }
-- 
1.6.4.2

From: mr.gaffo@gmail.com
Subject: [PATCH JGit 04/19] added utility that generates the contents of the objects/info/packs file as a string from a list of PackFiles
Date: Sun, 13 Sep 2009 13:44:20 -0500
Message-ID: <1252867475-858-5-git-send-email-mr.gaffo@gmail.com>
References: <1252867475-858-1-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-2-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-3-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-4-git-send-email-mr.gaffo@gmail.com>
Cc: "mike.gaffney" <mike.gaffney@asolutions.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 13 20:45:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mmu4K-00038i-KD
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 20:45:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752936AbZIMSor (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 14:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752885AbZIMSoq
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 14:44:46 -0400
Received: from an-out-0708.google.com ([209.85.132.251]:19834 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752809AbZIMSoo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 14:44:44 -0400
Received: by an-out-0708.google.com with SMTP id d40so7549191and.1
        for <git@vger.kernel.org>; Sun, 13 Sep 2009 11:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=1mgvXvVpyx04HHz6hzE68j/gpmthQGIVX3k61l8v5VM=;
        b=Nd0jLAH7+nIDPuNvm3sUyAsCM7UnVodDPVH3xLOQZdNdhXVzRGjHwIhyIoiBZioSXS
         jIT24KNazyARLWKLhtl5g4WQtvXf5lZmWdjejYLIeWixj6OOwH00DcESUss1litKwn87
         qpygUc1jhE35jE6gPPkim8DTTM9uBk7zJcJDo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=EcP77JfoLMW2Dc+6EB7D8Lb6eLZFn4kRRdwCGWKqm8wcnMRwbIN+e6d042uIzk6rsX
         rHvvql/FtvYSvfxYgxWx/g2/ucTE1mf2JXA7DRUwzjmUls1tuaihDowVWE+M/gy+s25M
         aQRn4EKl+tcCJx6TdA2qv5hAXhM+SS7PPjipE=
Received: by 10.101.10.13 with SMTP id n13mr5512049ani.88.1252867487331;
        Sun, 13 Sep 2009 11:44:47 -0700 (PDT)
Received: from localhost.localdomain ([70.230.157.86])
        by mx.google.com with ESMTPS id 23sm1238736yxe.0.2009.09.13.11.44.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 13 Sep 2009 11:44:47 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.2
In-Reply-To: <1252867475-858-4-git-send-email-mr.gaffo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128385>

From: mike.gaffney <mike.gaffney@asolutions.com>

---
 .../jgit/lib/PacksFileContentsCreatorTest.java     |   37 ++++++++++++++++++++
 .../spearce/jgit/lib/PacksFileContentsCreator.java |   21 +++++++++++
 2 files changed, 58 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/lib/PacksFileContentsCreatorTest.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/PacksFileContentsCreator.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PacksFileContentsCreatorTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PacksFileContentsCreatorTest.java
new file mode 100644
index 0000000..ef28a26
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PacksFileContentsCreatorTest.java
@@ -0,0 +1,37 @@
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
+public class PacksFileContentsCreatorTest extends TestCase {
+	private static final String PACK_NAME = "pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f";
+	private static final File TEST_PACK = JGitTestUtil.getTestResourceFile(PACK_NAME + ".pack");
+	private static final File TEST_IDX = JGitTestUtil.getTestResourceFile(PACK_NAME + ".idx");
+
+	public void testGettingPacksContentsSinglePack() throws Exception {
+		List<PackFile> packs = new ArrayList<PackFile>();
+		packs.add(new PackFile(TEST_IDX, TEST_PACK));
+		
+		assertEquals("P " + TEST_PACK.getName() + '\r', new PacksFileContentsCreator(packs).toString());
+	}
+	
+	public void testGettingPacksContentsMultiplePacks() throws Exception {
+		List<PackFile> packs = new ArrayList<PackFile>();
+		packs.add(new PackFile(TEST_IDX, TEST_PACK));
+		packs.add(new PackFile(TEST_IDX, TEST_PACK));
+		packs.add(new PackFile(TEST_IDX, TEST_PACK));
+		
+		StringBuilder expected = new StringBuilder();
+		expected.append("P ").append(TEST_PACK.getName()).append("\r");
+		expected.append("P ").append(TEST_PACK.getName()).append("\r");
+		expected.append("P ").append(TEST_PACK.getName()).append("\r");
+		
+		assertEquals(expected.toString(), new PacksFileContentsCreator(packs).toString());
+	}
+	
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PacksFileContentsCreator.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PacksFileContentsCreator.java
new file mode 100644
index 0000000..3dd0418
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PacksFileContentsCreator.java
@@ -0,0 +1,21 @@
+package org.spearce.jgit.lib;
+
+import java.util.List;
+
+public class PacksFileContentsCreator {
+
+	private List<PackFile> packs;
+
+	public PacksFileContentsCreator(List<PackFile> packs) {
+		this.packs = packs;
+	}
+	
+	public String toString(){
+		StringBuilder builder = new StringBuilder();
+		for (PackFile packFile : packs) {
+			builder.append("P ").append(packFile.getPackFile().getName()).append('\r');
+		}
+		return builder.toString();
+	}
+
+}
-- 
1.6.4.2

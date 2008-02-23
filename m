From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 01/10] Tighten IndexDiffTest to make it test better what it claims to test
Date: Sun, 24 Feb 2008 00:50:34 +0100
Message-ID: <1203810643-28819-2-git-send-email-robin.rosenberg@dewire.com>
References: <1203810643-28819-1-git-send-email-robin.rosenberg@dewire.com>
Cc: David Watson <dwatson@mimvista.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 24 00:51:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JT49m-00013x-1D
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 00:51:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754703AbYBWXvQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2008 18:51:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753123AbYBWXuz
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 18:50:55 -0500
Received: from [83.140.172.130] ([83.140.172.130]:11195 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752706AbYBWXux (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2008 18:50:53 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 800768027FE;
	Sun, 24 Feb 2008 00:50:52 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8HV1x7Jha+vh; Sun, 24 Feb 2008 00:50:50 +0100 (CET)
Received: from lathund.dewire.com (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 4621380069D;
	Sun, 24 Feb 2008 00:50:50 +0100 (CET)
Received: by lathund.dewire.com (Postfix, from userid 500)
	id 98D40291D8; Sun, 24 Feb 2008 00:50:43 +0100 (CET)
X-Mailer: git-send-email 1.5.4.2
In-Reply-To: <1203810643-28819-1-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74886>

I.e. test more of the expected state

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../tst/org/spearce/jgit/lib/IndexDiffTest.java    |   22 ++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/IndexDiffTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/IndexDiffTest.java
index ba5d8d7..629c06c 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/IndexDiffTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/IndexDiffTest.java
@@ -31,8 +31,12 @@ public class IndexDiffTest extends RepositoryTestCase {
 		index.add(trash, new File(trash, "dir/subfile"));
 		IndexDiff diff = new IndexDiff(tree, index);
 		diff.diff();
+		assertEquals(2, diff.getAdded().size());
 		assertTrue(diff.getAdded().contains("file1"));
 		assertTrue(diff.getAdded().contains("dir/subfile"));
+		assertEquals(0, diff.getChanged().size());
+		assertEquals(0, diff.getModified().size());
+		assertEquals(0, diff.getRemoved().size());
 	}
 
 	public void testRemoved() throws IOException {
@@ -44,11 +48,20 @@ public class IndexDiffTest extends RepositoryTestCase {
 		tree.addFile("file2");
 		tree.addFile("dir/file3");
 		assertEquals(2, tree.memberCount());
+		tree.findBlobMember("file2").setId(new ObjectId("30d67d4672d5c05833b7192cc77a79eaafb5c7ad"));
+		Tree tree2 = (Tree) tree.findTreeMember("dir");
+		tree2.findBlobMember("file3").setId(new ObjectId("873fb8d667d05436d728c52b1d7a09528e6eb59b"));
+		tree2.setId(new ObjectWriter(db).writeTree(tree2));
+		tree.setId(new ObjectWriter(db).writeTree(tree));
 
 		IndexDiff diff = new IndexDiff(tree, index);
 		diff.diff();
+		assertEquals(2, diff.getRemoved().size());
 		assertTrue(diff.getRemoved().contains("file2"));
 		assertTrue(diff.getRemoved().contains("dir/file3"));
+		assertEquals(0, diff.getChanged().size());
+		assertEquals(0, diff.getModified().size());
+		assertEquals(0, diff.getAdded().size());
 	}
 
 	public void testModified() throws IOException {
@@ -65,10 +78,19 @@ public class IndexDiffTest extends RepositoryTestCase {
 		tree.addFile("dir/file3").setId(new ObjectId("0123456789012345678901234567890123456789"));
 		assertEquals(2, tree.memberCount());
 
+		Tree tree2 = (Tree) tree.findTreeMember("dir");
+		tree2.setId(new ObjectWriter(db).writeTree(tree2));
+		tree.setId(new ObjectWriter(db).writeTree(tree));
 		IndexDiff diff = new IndexDiff(tree, index);
 		diff.diff();
+		assertEquals(2, diff.getChanged().size());
 		assertTrue(diff.getChanged().contains("file2"));
 		assertTrue(diff.getChanged().contains("dir/file3"));
+		assertEquals(1, diff.getModified().size());
 		assertTrue(diff.getModified().contains("dir/file3"));
+		assertEquals(0, diff.getAdded().size());
+		assertEquals(0, diff.getRemoved().size());
+		assertEquals(0, diff.getMissing().size());
 	}
+
 }
-- 
1.5.4.2

From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 02/10] Extend IndexDiffTest with more tests
Date: Sun, 24 Feb 2008 00:50:35 +0100
Message-ID: <1203810643-28819-3-git-send-email-robin.rosenberg@dewire.com>
References: <1203810643-28819-1-git-send-email-robin.rosenberg@dewire.com>
 <1203810643-28819-2-git-send-email-robin.rosenberg@dewire.com>
Cc: David Watson <dwatson@mimvista.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 24 00:52:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JT4AP-0001IU-V3
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 00:52:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753850AbYBWXvV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2008 18:51:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753123AbYBWXvU
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 18:51:20 -0500
Received: from [83.140.172.130] ([83.140.172.130]:11211 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753709AbYBWXu4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2008 18:50:56 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 7940980069D;
	Sun, 24 Feb 2008 00:50:55 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KV1nULlnt1jU; Sun, 24 Feb 2008 00:50:54 +0100 (CET)
Received: from lathund.dewire.com (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 522F180280B;
	Sun, 24 Feb 2008 00:50:50 +0100 (CET)
Received: by lathund.dewire.com (Postfix, from userid 500)
	id E2439292FA; Sun, 24 Feb 2008 00:50:43 +0100 (CET)
X-Mailer: git-send-email 1.5.4.2
In-Reply-To: <1203810643-28819-2-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74892>

This adds tests for some nasty cases. These can be summarized
by declaring that this is the correct order:

	a.b
	a/b
	a=b

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../tst/org/spearce/jgit/lib/IndexDiffTest.java    |   67 ++++++++++++++++++++
 1 files changed, 67 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/IndexDiffTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/IndexDiffTest.java
index 629c06c..4692fa2 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/IndexDiffTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/IndexDiffTest.java
@@ -93,4 +93,71 @@ public class IndexDiffTest extends RepositoryTestCase {
 		assertEquals(0, diff.getMissing().size());
 	}
 
+	public void testUnchangedSimple() throws IOException {
+		GitIndex index = new GitIndex(db);
+
+		index.add(trash, writeTrashFile("a.b", "a.b"));
+		index.add(trash, writeTrashFile("a.c", "a.c"));
+		index.add(trash, writeTrashFile("a=c", "a=c"));
+		index.add(trash, writeTrashFile("a=d", "a=d"));
+
+		Tree tree = new Tree(db);
+		// got the hash id'd from the data using echo -n a.b|git hash-object -t blob --stdin
+		tree.addFile("a.b").setId(new ObjectId("f6f28df96c2b40c951164286e08be7c38ec74851"));
+		tree.addFile("a.c").setId(new ObjectId("6bc0e647512d2a0bef4f26111e484dc87df7f5ca"));
+		tree.addFile("a=c").setId(new ObjectId("06022365ddbd7fb126761319633bf73517770714"));
+		tree.addFile("a=d").setId(new ObjectId("fa6414df3da87840700e9eeb7fc261dd77ccd5c2"));
+
+		tree.setId(new ObjectWriter(db).writeTree(tree));
+
+		IndexDiff diff = new IndexDiff(tree, index);
+		diff.diff();
+		assertEquals(0, diff.getChanged().size());
+		assertEquals(0, diff.getAdded().size());
+		assertEquals(0, diff.getRemoved().size());
+		assertEquals(0, diff.getMissing().size());
+		assertEquals(0, diff.getModified().size());
+	}
+
+	/**
+	 * This test has both files and directories that involve
+	 * the tricky ordering used by Git.
+	 *
+	 * @throws IOException
+	 */
+	public void testUnchangedComplex() throws IOException {
+		GitIndex index = new GitIndex(db);
+
+		index.add(trash, writeTrashFile("a.b", "a.b"));
+		index.add(trash, writeTrashFile("a.c", "a.c"));
+		index.add(trash, writeTrashFile("a/b.b/b", "a/b.b/b"));
+		index.add(trash, writeTrashFile("a/b", "a/b"));
+		index.add(trash, writeTrashFile("a/c", "a/c"));
+		index.add(trash, writeTrashFile("a=c", "a=c"));
+		index.add(trash, writeTrashFile("a=d", "a=d"));
+
+		Tree tree = new Tree(db);
+		// got the hash id'd from the data using echo -n a.b|git hash-object -t blob --stdin
+		tree.addFile("a.b").setId(new ObjectId("f6f28df96c2b40c951164286e08be7c38ec74851"));
+		tree.addFile("a.c").setId(new ObjectId("6bc0e647512d2a0bef4f26111e484dc87df7f5ca"));
+		tree.addFile("a/b.b/b").setId(new ObjectId("8d840bd4e2f3a48ff417c8e927d94996849933fd"));
+		tree.addFile("a/b").setId(new ObjectId("db89c972fc57862eae378f45b74aca228037d415"));
+		tree.addFile("a/c").setId(new ObjectId("52ad142a008aeb39694bafff8e8f1be75ed7f007"));
+		tree.addFile("a=c").setId(new ObjectId("06022365ddbd7fb126761319633bf73517770714"));
+		tree.addFile("a=d").setId(new ObjectId("fa6414df3da87840700e9eeb7fc261dd77ccd5c2"));
+
+		Tree tree3 = (Tree) tree.findTreeMember("a/b.b");
+		tree3.setId(new ObjectWriter(db).writeTree(tree3));
+		Tree tree2 = (Tree) tree.findTreeMember("a");
+		tree2.setId(new ObjectWriter(db).writeTree(tree2));
+		tree.setId(new ObjectWriter(db).writeTree(tree));
+
+		IndexDiff diff = new IndexDiff(tree, index);
+		diff.diff();
+		assertEquals(0, diff.getChanged().size());
+		assertEquals(0, diff.getAdded().size());
+		assertEquals(0, diff.getRemoved().size());
+		assertEquals(0, diff.getMissing().size());
+		assertEquals(0, diff.getModified().size());
+	}
 }
-- 
1.5.4.2

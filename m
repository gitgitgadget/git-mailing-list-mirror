From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [EGIT PATCH 2/2] Resort entries in "normal" order before looking for conflicts
Date: Sun, 10 Feb 2008 21:13:49 +0100
Message-ID: <200802102113.50578.robin.rosenberg.lists@dewire.com>
References: <1202255166-4581-1-git-send-email-robin.rosenberg@dewire.com> <1202255166-4581-3-git-send-email-robin.rosenberg@dewire.com> <200802060150.37222.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Cc: "Roger C. Soares" <rogersoares@intelinet.com.br>,
	Dave Watson <dwatson@mimvista.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 10 21:14:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOIZK-0004AZ-JG
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 21:14:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753268AbYBJUN4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 15:13:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753293AbYBJUN4
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 15:13:56 -0500
Received: from [83.140.172.130] ([83.140.172.130]:14625 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752692AbYBJUNz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Feb 2008 15:13:55 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 1D8F38006AB;
	Sun, 10 Feb 2008 21:13:54 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gu7iHfdBPUuA; Sun, 10 Feb 2008 21:13:53 +0100 (CET)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 0D47E800686;
	Sun, 10 Feb 2008 21:13:53 +0100 (CET)
User-Agent: KMail/1.9.6 (enterprise 0.20071123.740460)
In-Reply-To: <200802060150.37222.robin.rosenberg@dewire.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73397>

>From 39d5e19cd2e16f476501fda71d6551e51225ed2d Mon Sep 17 00:00:00 2001
From: Robin Rosenberg <robin.rosenberg@dewire.com>
Date: Sun, 10 Feb 2008 20:03:06 +0100
Subject: [PATCH] Extend IndexDiffTest with more tests

In order to fix a bug where everything is marked as modified, or in some cases
not modified the unit tests. The fixes here continue to work, but I want to
emphasize the tests. Comments?

---
 .../tst/org/spearce/jgit/lib/IndexDiffTest.java    |   67 ++++++++++++++++++++
 1 files changed, 67 insertions(+), 0 deletions(-)

One more to come (that fails).

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/IndexDiffTest.java 
b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/IndexDiffTest.java
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
1.5.4.rc4.25.g81cc

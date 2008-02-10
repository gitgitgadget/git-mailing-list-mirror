From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [EGIT PATCH 2/2] Resort entries in "normal" order before looking for conflicts
Date: Sun, 10 Feb 2008 21:18:29 +0100
Message-ID: <200802102118.29647.robin.rosenberg.lists@dewire.com>
References: <1202255166-4581-1-git-send-email-robin.rosenberg@dewire.com> <200802060150.37222.robin.rosenberg@dewire.com> <200802102113.50578.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Roger C. Soares" <rogersoares@intelinet.com.br>,
	Dave Watson <dwatson@mimvista.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 10 21:19:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOIdo-0005gK-8i
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 21:19:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753436AbYBJUSf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Feb 2008 15:18:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753351AbYBJUSe
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 15:18:34 -0500
Received: from [83.140.172.130] ([83.140.172.130]:14654 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753203AbYBJUSe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Feb 2008 15:18:34 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id A55808006AB;
	Sun, 10 Feb 2008 21:18:32 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BMQsOui5Y2yX; Sun, 10 Feb 2008 21:18:32 +0100 (CET)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id D70AA800686;
	Sun, 10 Feb 2008 21:18:31 +0100 (CET)
User-Agent: KMail/1.9.6 (enterprise 0.20071123.740460)
In-Reply-To: <200802102113.50578.robin.rosenberg.lists@dewire.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73399>

s=C3=B6ndagen den 10 februari 2008 skrev Robin Rosenberg:
> In order to fix a bug where everything is marked as modified, or in s=
ome cases
> not modified the unit tests. The fixes here continue to work, but I w=
ant to
> emphasize the tests. Comments?

Actually the reverse. This the extension that works, the previous mail =
contains
the test that fails, i.e. testUnchangedComplex().

You need this patch first though.=20

-- robin

=46rom 6d169c4e682359d8832047662591e341e91d186d Mon Sep 17 00:00:00 200=
1
=46rom: Robin Rosenberg <robin.rosenberg@dewire.com>
Date: Sun, 10 Feb 2008 20:01:53 +0100
Subject: [PATCH] Tighten IndexDiffTest to make it test better what it c=
laims to test

---
 .../tst/org/spearce/jgit/lib/IndexDiffTest.java    |   22 ++++++++++++=
++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/IndexDiffTe=
st.java=20
b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/IndexDiffTest.java
index ba5d8d7..629c06c 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/IndexDiffTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/IndexDiffTest.java
@@ -31,8 +31,12 @@ public class IndexDiffTest extends RepositoryTestCas=
e {
 		index.add(trash, new File(trash, "dir/subfile"));
 		IndexDiff diff =3D new IndexDiff(tree, index);
 		diff.diff();
+		assertEquals(2, diff.getAdded().size());
 		assertTrue(diff.getAdded().contains("file1"));
 		assertTrue(diff.getAdded().contains("dir/subfile"));
+		assertEquals(0, diff.getChanged().size());
+		assertEquals(0, diff.getModified().size());
+		assertEquals(0, diff.getRemoved().size());
 	}
=20
 	public void testRemoved() throws IOException {
@@ -44,11 +48,20 @@ public class IndexDiffTest extends RepositoryTestCa=
se {
 		tree.addFile("file2");
 		tree.addFile("dir/file3");
 		assertEquals(2, tree.memberCount());
+		tree.findBlobMember("file2").setId(new ObjectId("30d67d4672d5c05833b=
7192cc77a79eaafb5c7ad"));
+		Tree tree2 =3D (Tree) tree.findTreeMember("dir");
+		tree2.findBlobMember("file3").setId(new ObjectId("873fb8d667d05436d7=
28c52b1d7a09528e6eb59b"));
+		tree2.setId(new ObjectWriter(db).writeTree(tree2));
+		tree.setId(new ObjectWriter(db).writeTree(tree));
=20
 		IndexDiff diff =3D new IndexDiff(tree, index);
 		diff.diff();
+		assertEquals(2, diff.getRemoved().size());
 		assertTrue(diff.getRemoved().contains("file2"));
 		assertTrue(diff.getRemoved().contains("dir/file3"));
+		assertEquals(0, diff.getChanged().size());
+		assertEquals(0, diff.getModified().size());
+		assertEquals(0, diff.getAdded().size());
 	}
=20
 	public void testModified() throws IOException {
@@ -65,10 +78,19 @@ public class IndexDiffTest extends RepositoryTestCa=
se {
 		tree.addFile("dir/file3").setId(new ObjectId("0123456789012345678901=
234567890123456789"));
 		assertEquals(2, tree.memberCount());
=20
+		Tree tree2 =3D (Tree) tree.findTreeMember("dir");
+		tree2.setId(new ObjectWriter(db).writeTree(tree2));
+		tree.setId(new ObjectWriter(db).writeTree(tree));
 		IndexDiff diff =3D new IndexDiff(tree, index);
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
--=20
1.5.4.rc4.25.g81cc

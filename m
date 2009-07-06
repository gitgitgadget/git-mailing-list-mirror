From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH] Add more tests for AbstractTreeIterator
Date: Mon,  6 Jul 2009 09:52:08 -0700
Message-ID: <1246899128-8201-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org,
	Constantine Plotnikov <constantine.plotnikov@gmail.com>
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon Jul 06 18:52:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MNrQY-00028Y-6G
	for gcvg-git-2@gmane.org; Mon, 06 Jul 2009 18:52:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753165AbZGFQwK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2009 12:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752964AbZGFQwI
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Jul 2009 12:52:08 -0400
Received: from george.spearce.org ([209.20.77.23]:44984 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752924AbZGFQwH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2009 12:52:07 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 04926381FE; Mon,  6 Jul 2009 16:52:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 543D23816F;
	Mon,  6 Jul 2009 16:52:09 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.3.507.gc6b5a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122792>

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
CC: Constantine Plotnikov <constantine.plotnikov@gmail.com>
---
 .../jgit/treewalk/AbstractTreeIteratorTest.java    |   91 +++++++++++++++++++-
 1 files changed, 88 insertions(+), 3 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/AbstractTreeIteratorTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/AbstractTreeIteratorTest.java
index 562053e..ed4936b 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/AbstractTreeIteratorTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/AbstractTreeIteratorTest.java
@@ -42,16 +42,27 @@
 import junit.framework.TestCase;
 
 import org.spearce.jgit.errors.IncorrectObjectTypeException;
+import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.FileMode;
 import org.spearce.jgit.lib.Repository;
 
 
 public class AbstractTreeIteratorTest extends TestCase {
+	private static String prefix(String path) {
+		final int s = path.lastIndexOf('/');
+		return s > 0 ? path.substring(0, s) : "";
+	}
+
 	public class FakeTreeIterator extends WorkingTreeIterator {
-		public FakeTreeIterator(String path, FileMode fileMode) {
-			super(path);
+		public FakeTreeIterator(String pathName, FileMode fileMode) {
+			super(prefix(pathName));
 			mode = fileMode.getBits();
-			pathLen -= 1; // Get rid of extra '/'
+
+			final int s = pathName.lastIndexOf('/');
+			final byte[] name = Constants.encode(pathName.substring(s + 1));
+			ensurePathCapacity(pathOffset + name.length, pathOffset);
+			System.arraycopy(name, 0, path, pathOffset, name.length);
+			pathLen = pathOffset + name.length;
 		}
 
 		@Override
@@ -74,4 +85,78 @@ public void testPathCompare() throws Exception {
 		assertTrue(new FakeTreeIterator("a", FileMode.TREE).pathCompare(
 				new FakeTreeIterator("a", FileMode.TREE)) == 0);
 	}
+
+	public void testGrowPath() throws Exception {
+		final FakeTreeIterator i = new FakeTreeIterator("ab", FileMode.TREE);
+		final byte[] origpath = i.path;
+		assertEquals(i.path[0], 'a');
+		assertEquals(i.path[1], 'b');
+
+		i.growPath(2);
+
+		assertNotSame(origpath, i.path);
+		assertEquals(origpath.length * 2, i.path.length);
+		assertEquals(i.path[0], 'a');
+		assertEquals(i.path[1], 'b');
+	}
+
+	public void testEnsurePathCapacityFastCase() throws Exception {
+		final FakeTreeIterator i = new FakeTreeIterator("ab", FileMode.TREE);
+		final int want = 50;
+		final byte[] origpath = i.path;
+		assertEquals(i.path[0], 'a');
+		assertEquals(i.path[1], 'b');
+		assertTrue(want < i.path.length);
+
+		i.ensurePathCapacity(want, 2);
+
+		assertSame(origpath, i.path);
+		assertEquals(i.path[0], 'a');
+		assertEquals(i.path[1], 'b');
+	}
+
+	public void testEnsurePathCapacityGrows() throws Exception {
+		final FakeTreeIterator i = new FakeTreeIterator("ab", FileMode.TREE);
+		final int want = 384;
+		final byte[] origpath = i.path;
+		assertEquals(i.path[0], 'a');
+		assertEquals(i.path[1], 'b');
+		assertTrue(i.path.length < want);
+
+		i.ensurePathCapacity(want, 2);
+
+		assertNotSame(origpath, i.path);
+		assertEquals(512, i.path.length);
+		assertEquals(i.path[0], 'a');
+		assertEquals(i.path[1], 'b');
+	}
+
+	public void testEntryFileMode() {
+		for (FileMode m : new FileMode[] { FileMode.TREE,
+				FileMode.REGULAR_FILE, FileMode.EXECUTABLE_FILE,
+				FileMode.GITLINK, FileMode.SYMLINK }) {
+			final FakeTreeIterator i = new FakeTreeIterator("a", m);
+			assertEquals(m.getBits(), i.getEntryRawMode());
+			assertSame(m, i.getEntryFileMode());
+		}
+	}
+
+	public void testEntryPath() {
+		FakeTreeIterator i = new FakeTreeIterator("a/b/cd", FileMode.TREE);
+		assertEquals("a/b/cd", i.getEntryPathString());
+		assertEquals(2, i.getNameLength());
+		byte[] b = new byte[3];
+		b[0] = 0x0a;
+		i.getName(b, 1);
+		assertEquals(0x0a, b[0]);
+		assertEquals('c', b[1]);
+		assertEquals('d', b[2]);
+	}
+
+	public void testCreateEmptyTreeIterator() {
+		FakeTreeIterator i = new FakeTreeIterator("a/b/cd", FileMode.TREE);
+		EmptyTreeIterator e = i.createEmptyTreeIterator();
+		assertNotNull(e);
+		assertEquals(i.getEntryPathString() + "/", e.getEntryPathString());
+	}
 }
-- 
1.6.3.3.507.gc6b5a

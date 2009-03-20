From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH] Ensure RawParseUtils.lineMap last element is the buffer end
Date: Fri, 20 Mar 2009 09:38:08 -0700
Message-ID: <1237567088-31828-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Mar 20 17:39:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lkhl0-0006Up-T7
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 17:39:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755205AbZCTQiM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 12:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754330AbZCTQiM
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 12:38:12 -0400
Received: from george.spearce.org ([209.20.77.23]:35604 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753190AbZCTQiL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2009 12:38:11 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 0DFA838222; Fri, 20 Mar 2009 16:38:09 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 68E07381D3;
	Fri, 20 Mar 2009 16:38:08 +0000 (UTC)
X-Mailer: git-send-email 1.6.2.1.352.gae594
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113976>

Application code is easier to write when we can assume that for
any given source line the last element of the IntList returned
by lineMap contains the value of the end parameter.  This makes
it easy to extract any line by saying:

  RawParseUtils.decodeNoFallback(
    Constants.CHARSET,
    buf,
	lineMap.get(lineNbr),
    lineMap.get(lineNbr + 1));

without needing to worry about bound checks, assuming of course
that lineNbr is already bound-checked within the range of the file.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../jgit/util/RawParseUtils_LineMapTest.java       |   16 ++++++++++------
 .../src/org/spearce/jgit/util/RawParseUtils.java   |    4 ++++
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/util/RawParseUtils_LineMapTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/util/RawParseUtils_LineMapTest.java
index 3f562a4..312e3d8 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/util/RawParseUtils_LineMapTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/util/RawParseUtils_LineMapTest.java
@@ -45,44 +45,48 @@
 	public void testEmpty() {
 		final IntList map = RawParseUtils.lineMap(new byte[] {}, 0, 0);
 		assertNotNull(map);
-		assertEquals(1, map.size());
+		assertEquals(2, map.size());
 		assertEquals(Integer.MIN_VALUE, map.get(0));
+		assertEquals(0, map.get(1));
 	}
 
 	public void testOneBlankLine() {
 		final IntList map = RawParseUtils.lineMap(new byte[] { '\n' }, 0, 1);
-		assertEquals(2, map.size());
+		assertEquals(3, map.size());
 		assertEquals(Integer.MIN_VALUE, map.get(0));
 		assertEquals(0, map.get(1));
+		assertEquals(1, map.get(2));
 	}
 
 	public void testTwoLineFooBar() throws UnsupportedEncodingException {
 		final byte[] buf = "foo\nbar\n".getBytes("ISO-8859-1");
 		final IntList map = RawParseUtils.lineMap(buf, 0, buf.length);
-		assertEquals(3, map.size());
+		assertEquals(4, map.size());
 		assertEquals(Integer.MIN_VALUE, map.get(0));
 		assertEquals(0, map.get(1));
 		assertEquals(4, map.get(2));
+		assertEquals(buf.length, map.get(3));
 	}
 
 	public void testTwoLineNoLF() throws UnsupportedEncodingException {
 		final byte[] buf = "foo\nbar".getBytes("ISO-8859-1");
 		final IntList map = RawParseUtils.lineMap(buf, 0, buf.length);
-		assertEquals(3, map.size());
+		assertEquals(4, map.size());
 		assertEquals(Integer.MIN_VALUE, map.get(0));
 		assertEquals(0, map.get(1));
 		assertEquals(4, map.get(2));
+		assertEquals(buf.length, map.get(3));
 	}
 
 	public void testFourLineBlanks() throws UnsupportedEncodingException {
 		final byte[] buf = "foo\n\n\nbar\n".getBytes("ISO-8859-1");
 		final IntList map = RawParseUtils.lineMap(buf, 0, buf.length);
-		assertEquals(5, map.size());
+		assertEquals(6, map.size());
 		assertEquals(Integer.MIN_VALUE, map.get(0));
 		assertEquals(0, map.get(1));
 		assertEquals(4, map.get(2));
 		assertEquals(5, map.get(3));
 		assertEquals(6, map.get(4));
+		assertEquals(buf.length, map.get(5));
 	}
-
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java b/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java
index 0735ce6..79ebe41 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java
@@ -329,6 +329,9 @@ public static final int nextLF(final byte[] b, int ptr, final char chrA) {
 	 * Using a 1 indexed list means that line numbers can be directly accessed
 	 * from the list, so <code>list.get(1)</code> (aka get line 1) returns
 	 * <code>ptr</code>.
+	 * <p>
+	 * The last element (index <code>map.size()-1</code>) always contains
+	 * <code>end</code>.
 	 *
 	 * @param buf
 	 *            buffer to scan.
@@ -348,6 +351,7 @@ public static final IntList lineMap(final byte[] buf, int ptr, int end) {
 		map.fillTo(1, Integer.MIN_VALUE);
 		for (; ptr < end; ptr = nextLF(buf, ptr))
 			map.add(ptr);
+		map.add(end);
 		return map;
 	}
 
-- 
1.6.2.1.352.gae594

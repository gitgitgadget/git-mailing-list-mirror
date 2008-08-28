From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 4/5] Increase JUnit coverage on CanonicalTreeParser
Date: Thu, 28 Aug 2008 08:27:45 -0700
Message-ID: <1219937266-24903-4-git-send-email-spearce@spearce.org>
References: <1219937266-24903-1-git-send-email-spearce@spearce.org>
 <1219937266-24903-2-git-send-email-spearce@spearce.org>
 <1219937266-24903-3-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 17:29:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYjQt-0003Pm-Sf
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 17:29:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752789AbYH1P14 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 11:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753436AbYH1P1y
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 11:27:54 -0400
Received: from george.spearce.org ([209.20.77.23]:51103 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753199AbYH1P1u (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 11:27:50 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id BAB3938376; Thu, 28 Aug 2008 15:27:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id CBA4938360;
	Thu, 28 Aug 2008 15:27:47 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.174.gd789c
In-Reply-To: <1219937266-24903-3-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94074>

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../jgit/treewalk/CanonicalTreeParserTest.java     |   18 ++++++++++++++++++
 .../jgit/treewalk/AbstractTreeIterator.java        |    2 +-
 2 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/CanonicalTreeParserTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/CanonicalTreeParserTest.java
index fd92844..ed3478c 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/CanonicalTreeParserTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/CanonicalTreeParserTest.java
@@ -108,18 +108,21 @@ public void testEmptyTree_AtEOF() throws Exception {
 	public void testOneEntry_Forward() throws Exception {
 		ctp.reset(tree1);
 
+		assertTrue(ctp.first());
 		assertFalse(ctp.eof());
 		assertEquals(m644.getBits(), ctp.mode);
 		assertEquals("a", path());
 		assertEquals(hash_a, ctp.getEntryObjectId());
 
 		ctp.next(1);
+		assertFalse(ctp.first());
 		assertTrue(ctp.eof());
 	}
 
 	public void testTwoEntries_ForwardOneAtATime() throws Exception {
 		ctp.reset(tree2);
 
+		assertTrue(ctp.first());
 		assertFalse(ctp.eof());
 		assertEquals(m644.getBits(), ctp.mode);
 		assertEquals("a", path());
@@ -132,6 +135,7 @@ public void testTwoEntries_ForwardOneAtATime() throws Exception {
 		assertEquals(hash_foo, ctp.getEntryObjectId());
 
 		ctp.next(1);
+		assertFalse(ctp.first());
 		assertTrue(ctp.eof());
 	}
 
@@ -170,9 +174,11 @@ public void testThreeEntries_Seek2() throws Exception {
 	public void testOneEntry_Backwards() throws Exception {
 		ctp.reset(tree1);
 		ctp.next(1);
+		assertFalse(ctp.first());
 		assertTrue(ctp.eof());
 
 		ctp.back(1);
+		assertTrue(ctp.first());
 		assertFalse(ctp.eof());
 		assertEquals(m644.getBits(), ctp.mode);
 		assertEquals("a", path());
@@ -258,4 +264,16 @@ public void testBackwards_ConfusingPathName() throws Exception {
 		assertEquals("a", path());
 		assertEquals(hash_a, ctp.getEntryObjectId());
 	}
+
+	public void testFreakingHugePathName() throws Exception {
+		final int n = AbstractTreeIterator.DEFAULT_PATH_SIZE * 4;
+		final StringBuilder b = new StringBuilder(n);
+		for (int i = 0; i < n; i++)
+			b.append('q');
+		final String name = b.toString();
+		ctp.reset(entry(m644, name, hash_a));
+		assertFalse(ctp.eof());
+		assertEquals(name, RawParseUtils.decode(Constants.CHARSET, ctp.path,
+				ctp.pathOffset, ctp.pathLen));
+	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/AbstractTreeIterator.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/AbstractTreeIterator.java
index 3227fab..5226ab6 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/treewalk/AbstractTreeIterator.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/AbstractTreeIterator.java
@@ -71,7 +71,7 @@
  * @see CanonicalTreeParser
  */
 public abstract class AbstractTreeIterator {
-	private static final int DEFAULT_PATH_SIZE = 128;
+	static final int DEFAULT_PATH_SIZE = 128;
 
 	/** A dummy object id buffer that matches the zero ObjectId. */
 	protected static final byte[] zeroid = new byte[Constants.OBJECT_ID_LENGTH];
-- 
1.6.0.174.gd789c

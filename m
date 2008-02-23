From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 05/10] Fix git sort order compare bug
Date: Sun, 24 Feb 2008 00:50:38 +0100
Message-ID: <1203810643-28819-6-git-send-email-robin.rosenberg@dewire.com>
References: <1203810643-28819-1-git-send-email-robin.rosenberg@dewire.com>
 <1203810643-28819-2-git-send-email-robin.rosenberg@dewire.com>
 <1203810643-28819-3-git-send-email-robin.rosenberg@dewire.com>
 <1203810643-28819-4-git-send-email-robin.rosenberg@dewire.com>
 <1203810643-28819-5-git-send-email-robin.rosenberg@dewire.com>
Cc: David Watson <dwatson@mimvista.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 24 00:52:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JT4AQ-0001IU-JO
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 00:52:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754753AbYBWXvX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2008 18:51:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754726AbYBWXvX
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 18:51:23 -0500
Received: from [83.140.172.130] ([83.140.172.130]:11214 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754555AbYBWXu5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2008 18:50:57 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 814058027FE;
	Sun, 24 Feb 2008 00:50:56 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mcJ6e5zW0vcV; Sun, 24 Feb 2008 00:50:55 +0100 (CET)
Received: from lathund.dewire.com (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id A7F80802816;
	Sun, 24 Feb 2008 00:50:50 +0100 (CET)
Received: by lathund.dewire.com (Postfix, from userid 500)
	id 01800293DE; Sun, 24 Feb 2008 00:50:43 +0100 (CET)
X-Mailer: git-send-email 1.5.4.2
In-Reply-To: <1203810643-28819-5-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74890>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../tst/org/spearce/jgit/lib/T0002_Tree.java       |   44 ++++++++++++++++++++
 .../src/org/spearce/jgit/lib/Tree.java             |   10 ++++-
 2 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0002_Tree.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0002_Tree.java
index 24b368f..7c7f6c0 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0002_Tree.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0002_Tree.java
@@ -17,6 +17,7 @@
 package org.spearce.jgit.lib;
 
 import java.io.IOException;
+import java.io.UnsupportedEncodingException;
 import java.util.ArrayList;
 import java.util.List;
 
@@ -24,6 +25,49 @@ public class T0002_Tree extends RepositoryTestCase {
 	private static final ObjectId SOME_FAKE_ID = new ObjectId(
 			"0123456789abcdef0123456789abcdef01234567");
 
+	private int compareNamesUsingSpecialCompare(String a,String b) throws UnsupportedEncodingException {
+		char lasta = '\0';
+		byte[] abytes;
+		if (a.length() > 0 && a.charAt(a.length()-1) == '/') {
+			lasta = '/';
+			a = a.substring(0, a.length() - 1);
+		}
+		abytes = a.getBytes("ISO-8859-1");
+		char lastb = '\0';
+		byte[] bbytes;
+		if (b.length() > 0 && b.charAt(b.length()-1) == '/') {
+			lastb = '/';
+			b = b.substring(0, b.length() - 1);
+		}
+		bbytes = b.getBytes("ISO-8859-1");
+		return Tree.compareNames(abytes, bbytes, lasta, lastb);
+	}
+
+	public void test000_sort_01() throws UnsupportedEncodingException {
+		assertEquals(0, compareNamesUsingSpecialCompare("a","a"));
+	}
+	public void test000_sort_02() throws UnsupportedEncodingException {
+		assertEquals(-1, compareNamesUsingSpecialCompare("a","b"));
+		assertEquals(1, compareNamesUsingSpecialCompare("b","a"));
+	}
+	public void test000_sort_03() throws UnsupportedEncodingException {
+		assertEquals(1, compareNamesUsingSpecialCompare("a:","a"));
+		assertEquals(1, compareNamesUsingSpecialCompare("a/","a"));
+		assertEquals(-1, compareNamesUsingSpecialCompare("a","a/"));
+		assertEquals(-1, compareNamesUsingSpecialCompare("a","a:"));
+		assertEquals(1, compareNamesUsingSpecialCompare("a:","a/"));
+		assertEquals(-1, compareNamesUsingSpecialCompare("a/","a:"));
+	}
+	public void test000_sort_04() throws UnsupportedEncodingException {
+		assertEquals(-1, compareNamesUsingSpecialCompare("a.a","a/a"));
+		assertEquals(1, compareNamesUsingSpecialCompare("a/a","a.a"));
+	}
+	public void test000_sort_05() throws UnsupportedEncodingException {
+		assertEquals(-1, compareNamesUsingSpecialCompare("a.","a/"));
+		assertEquals(1, compareNamesUsingSpecialCompare("a/","a."));
+
+	}
+
 	public void test001_createEmpty() throws IOException {
 		final Tree t = new Tree(db);
 		assertTrue("isLoaded", t.isLoaded());
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Tree.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Tree.java
index ab83917..5d8e0e0 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Tree.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Tree.java
@@ -65,7 +65,10 @@ public class Tree extends TreeEntry implements Treeish {
 			else if (aj > lastb)
 				return 1;
 			else
-				return 0;
+				if (j == a.length - 1)
+					return 0;
+				else
+					return -1;
 		}
 		if (k < nameEnd) {
 			int bk = nameUTF8[k] & 0xff;
@@ -74,7 +77,10 @@ public class Tree extends TreeEntry implements Treeish {
 			else if (lasta > bk)
 				return 1;
 			else
-				return 0;
+				if (k == nameEnd - 1)
+					return 0;
+				else
+					return 1;
 		}
 		if (lasta < lastb)
 			return -1;
-- 
1.5.4.2

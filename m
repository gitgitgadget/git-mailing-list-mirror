From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 1/2] Fix git sort order compare bug
Date: Wed,  6 Feb 2008 00:46:05 +0100
Message-ID: <1202255166-4581-2-git-send-email-robin.rosenberg@dewire.com>
References: <1202255166-4581-1-git-send-email-robin.rosenberg@dewire.com>
Cc: "Roger C. Soares" <rogersoares@intelinet.com.br>,
	Dave Watson <dwatson@mimvista.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 06 00:46:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMXV0-0004GL-75
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 00:46:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760492AbYBEXqP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 18:46:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760602AbYBEXqN
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 18:46:13 -0500
Received: from [83.140.172.130] ([83.140.172.130]:29926 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1760423AbYBEXqL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 18:46:11 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 27E3E800686;
	Wed,  6 Feb 2008 00:46:10 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V8+90X+xTVoH; Wed,  6 Feb 2008 00:46:08 +0100 (CET)
Received: from lathund.dewire.com (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 364E180068A;
	Wed,  6 Feb 2008 00:46:08 +0100 (CET)
Received: by lathund.dewire.com (Postfix, from userid 500)
	id 2C4C128023; Wed,  6 Feb 2008 00:46:05 +0100 (CET)
X-Mailer: git-send-email 1.5.4.rc4.25.g81cc
In-Reply-To: <1202255166-4581-1-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72725>

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
1.5.4.rc4.25.g81cc

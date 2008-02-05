From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 2/2] Resort entries in "normal" order before looking for conflicts
Date: Wed,  6 Feb 2008 00:46:06 +0100
Message-ID: <1202255166-4581-3-git-send-email-robin.rosenberg@dewire.com>
References: <1202255166-4581-1-git-send-email-robin.rosenberg@dewire.com>
 <1202255166-4581-2-git-send-email-robin.rosenberg@dewire.com>
Cc: "Roger C. Soares" <rogersoares@intelinet.com.br>,
	Dave Watson <dwatson@mimvista.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 06 00:46:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMXV0-0004GL-Rl
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 00:46:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760733AbYBEXqQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 18:46:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760634AbYBEXqP
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 18:46:15 -0500
Received: from [83.140.172.130] ([83.140.172.130]:29932 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1760553AbYBEXqM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 18:46:12 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 0AEAE80068A;
	Wed,  6 Feb 2008 00:46:11 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WXiGwhN2VcEY; Wed,  6 Feb 2008 00:46:09 +0100 (CET)
Received: from lathund.dewire.com (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 44B3480068C;
	Wed,  6 Feb 2008 00:46:08 +0100 (CET)
Received: by lathund.dewire.com (Postfix, from userid 500)
	id 2EE532803E; Wed,  6 Feb 2008 00:46:05 +0100 (CET)
X-Mailer: git-send-email 1.5.4.rc4.25.g81cc
In-Reply-To: <1202255166-4581-2-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72724>

When checking out another branch we get a problem if our version contains
a tree name that is longer, but has another tree as a prefix.

        Our tree
          a/a
          a.a/b

        Other tree
          a/a

The conflict comes from names not being compared properly in git
order.

Directory/File conflicts are not easy to handle. This solution
is cheating, but solved a real user's problem.

This commit adds test cases for the particular problem plus one
similar test that didn't fail before either.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../tst/org/spearce/jgit/lib/ReadTreeTest.java     |   16 ++++++++-
 .../src/org/spearce/jgit/lib/IndexTreeWalker.java  |   35 ++++++++++++--------
 2 files changed, 36 insertions(+), 15 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ReadTreeTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ReadTreeTest.java
index 7ac48c9..6faedc7 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ReadTreeTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ReadTreeTest.java
@@ -477,7 +477,21 @@ public class ReadTreeTest extends RepositoryTestCase {
 		
 		assertNoConflicts();
 	}
-	
+
+	public void testCloseNameConflictsX0() throws IOException {
+		setupCase(mkmap("a/a", "a/a-c"), mkmap("a/a","a/a", "b.b/b.b","b.b/b.bs"), mkmap("a/a", "a/a-c") );
+		checkout();
+		go();
+		assertNoConflicts();
+	}
+
+	public void testCloseNameConflicts1() throws IOException {
+		setupCase(mkmap("a/a", "a/a-c"), mkmap("a/a","a/a", "a.a/a.a","a.a/a.a"), mkmap("a/a", "a/a-c") );
+		checkout();
+		go();
+		assertNoConflicts();
+	}
+
 	private void checkout() throws IOException {
 		readTree = new WorkDirCheckout(db, trash, head, index, merge);
 		readTree.checkout();
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/IndexTreeWalker.java b/org.spearce.jgit/src/org/spearce/jgit/lib/IndexTreeWalker.java
index 93d5bb2..bc2fb23 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/IndexTreeWalker.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/IndexTreeWalker.java
@@ -19,6 +19,8 @@ package org.spearce.jgit.lib;
 
 import java.io.File;
 import java.io.IOException;
+import java.util.Arrays;
+import java.util.Comparator;
 
 import org.spearce.jgit.lib.GitIndex.Entry;
 
@@ -85,9 +87,28 @@ public class IndexTreeWalker {
 		walk(mainTree, newTree, "/");
 	}
 
+	static Comparator<TreeEntry> treeEntryPlainComparator() {
+		return new Comparator<TreeEntry>() {
+			public int compare(TreeEntry o1, TreeEntry o2) {
+				return o1.getName().compareTo(o2.getName());
+			}
+		};
+	}
+
+	static Comparator<Entry> indexEntryPlainComparator() {
+		return new Comparator<Entry>() {
+			public int compare(Entry o1, Entry o2) {
+				return o1.getName().compareTo(o2.getName());
+			}
+		};
+	}
+
 	private void walk(Tree tree, Tree auxTree, String curDir) throws IOException {
 		TreeEntry[] treeMembers = tree == null ? new TreeEntry[0] : tree.members();
 		TreeEntry[] auxTreeMembers = auxTree == null ? new TreeEntry[0] : auxTree.members();
+		Arrays.sort(treeMembers, treeEntryPlainComparator());
+		Arrays.sort(auxTreeMembers, treeEntryPlainComparator());
+		Arrays.sort(indexMembers, indexEntryPlainComparator());
 		int treeCounter = 0;
 		int auxTreeCounter = 0;
 		
@@ -308,18 +329,4 @@ public class IndexTreeWalker {
 		}
 		return t1.getName().compareTo(t2.getName());
 	}
-	
-	static int compare(byte[] name1, byte[] name2) {
-		for (int i = 0; i < name1.length && i < name2.length; i++) {
-			if (name1[i] < name2[i])
-				return -1;
-			if (name1[i] > name2[i])
-				return 1;
-		}
-		if (name1.length < name2.length)
-			return -1;
-		if (name2.length < name1.length)
-			return 1;
-		return 0;
-	}
 }
-- 
1.5.4.rc4.25.g81cc

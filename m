From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [PATCH 2/4] Rework tree/commit cache
Date: Sun, 18 Mar 2007 23:16:01 +0100
Message-ID: <20070318221601.24742.14256.stgit@lathund.dewire.com>
References: <20070318220711.24742.90943.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: spearce@spearce.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 18 23:14:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HT3dm-0000W6-SF
	for gcvg-git@gmane.org; Sun, 18 Mar 2007 23:14:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933338AbXCRWOJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 18:14:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933344AbXCRWOJ
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 18:14:09 -0400
Received: from [83.140.172.130] ([83.140.172.130]:7607 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S933338AbXCRWOH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 18:14:07 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id C6547802857;
	Sun, 18 Mar 2007 23:08:45 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 18488-07; Sun, 18 Mar 2007 23:08:45 +0100 (CET)
Received: from lathund.dewire.com (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 56C84802664;
	Sun, 18 Mar 2007 23:08:45 +0100 (CET)
Received: from localhost (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 63CC328D37;
	Sun, 18 Mar 2007 23:16:21 +0100 (CET)
X-Virus-Scanned: amavisd-new at localhost.localdomain
Received: from lathund.dewire.com ([127.0.0.1])
	by localhost (lathund.dewire.com [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id ifxrLdL-1OVw; Sun, 18 Mar 2007 23:16:07 +0100 (CET)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 6818028E1C;
	Sun, 18 Mar 2007 23:16:01 +0100 (CET)
In-Reply-To: <20070318220711.24742.90943.stgit@lathund.dewire.com>
User-Agent: StGIT/0.12
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42534>

We now use SoftRefernces to hold the value objects and reuse
the object id's as cache keys. Seems to work much better, i.e.
the gc only throws out stuff from the cache when memory is
tight, rather than at the first opportunity.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---

 .../src/org/spearce/jgit/lib/Repository.java       |   30 +++++++++++++++--------
 1 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index d3b2178..c7c47ae 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -23,6 +23,8 @@ import java.io.FileNotFoundException;
 import java.io.FileReader;
 import java.io.FileWriter;
 import java.io.IOException;
+import java.lang.ref.Reference;
+import java.lang.ref.SoftReference;
 import java.util.ArrayList;
 import java.util.Collection;
 import java.util.Map;
@@ -190,19 +192,24 @@ public class Repository {
 	}
 
 	public Commit mapCommit(final ObjectId id) throws IOException {
-		Commit ret = (Commit)commitCache.get(id);
-		if (ret != null)
-			return ret;
+//		System.out.println("commitcache.size="+commitCache.size());
+		Reference retr = (Reference)commitCache.get(id);
+		if (retr != null) {
+			Commit ret = (Commit)retr.get();
+			if (ret != null)
+				return ret;
+			System.out.println("Found a null id, size was "+commitCache.size());
+		}
 
 		final ObjectLoader or = openObject(id);
 		if (or == null)
 			return null;
 		final byte[] raw = or.getBytes();
 		if (Constants.TYPE_COMMIT.equals(or.getType())) {
-			ret = new Commit(this, id, raw);
+			Commit ret = new Commit(this, id, raw);
 			// The key must not be the referenced strongly
 			// by the value in WeakHashMaps
-			commitCache.put(new ObjectId(id.getBytes()), ret);
+			commitCache.put(id, new SoftReference(ret));
 			return ret;
 		}
 		throw new IncorrectObjectTypeException(id, Constants.TYPE_COMMIT);
@@ -214,17 +221,20 @@ public class Repository {
 	}
 
 	public Tree mapTree(final ObjectId id) throws IOException {
-		Tree ret = (Tree)treeCache.get(id);
-		if (ret != null)
-			return ret;
+		Reference wret = (Reference)treeCache.get(id);
+		if (wret != null) {
+			Tree ret = (Tree)wret.get();
+			if (ret != null)
+				return ret;
+		}
 
 		final ObjectLoader or = openObject(id);
 		if (or == null)
 			return null;
 		final byte[] raw = or.getBytes();
 		if (Constants.TYPE_TREE.equals(or.getType())) {
-			ret = new Tree(this, id, raw);
-			treeCache.put(new ObjectId(id.getBytes()), ret);
+			Tree ret = new Tree(this, id, raw);
+			treeCache.put(id, new SoftReference(ret));
 			return ret;
 		}
 		if (Constants.TYPE_COMMIT.equals(or.getType()))

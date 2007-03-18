From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [PATCH 1/4] Cache tree ObjectId's too
Date: Sun, 18 Mar 2007 23:15:55 +0100
Message-ID: <20070318221555.24742.93993.stgit@lathund.dewire.com>
References: <20070318220711.24742.90943.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: spearce@spearce.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 18 23:14:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HT3dd-0000PT-EO
	for gcvg-git@gmane.org; Sun, 18 Mar 2007 23:14:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933331AbXCRWN7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 18:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933332AbXCRWN6
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 18:13:58 -0400
Received: from [83.140.172.130] ([83.140.172.130]:7590 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S933331AbXCRWN5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 18:13:57 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id EC5EB802664;
	Sun, 18 Mar 2007 23:08:34 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 18505-04; Sun, 18 Mar 2007 23:08:34 +0100 (CET)
Received: from lathund.dewire.com (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 5F665802855;
	Sun, 18 Mar 2007 23:08:32 +0100 (CET)
Received: from localhost (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id E2E7B28CDB;
	Sun, 18 Mar 2007 23:16:07 +0100 (CET)
X-Virus-Scanned: amavisd-new at localhost.localdomain
Received: from lathund.dewire.com ([127.0.0.1])
	by localhost (lathund.dewire.com [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id IqCr20tLo2Pk; Sun, 18 Mar 2007 23:15:56 +0100 (CET)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id F0F1A28D23;
	Sun, 18 Mar 2007 23:15:55 +0100 (CET)
In-Reply-To: <20070318220711.24742.90943.stgit@lathund.dewire.com>
User-Agent: StGIT/0.12
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42532>

The caching part is experimental. We explicitly leave it up to
the garbage collector when to recycle git objects. After trying
this practically we will se what is best. The upside is that
rescanning the history for a certain resource is very quick when
data is still in the cache (tens of milliseconds), which is very
good for interactivity. When memory is tight we go to disk and
fetch the data, which could take a couple of seconds on a large
repo.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---

 .../src/org/spearce/jgit/lib/Repository.java       |   18 +++++++++++++-----
 1 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index 8b1f42c..d3b2178 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -47,7 +47,8 @@ public class Repository {
 
 	private WindowCache windows;
 
-	private Map cache = new WeakHashMap(30000); 
+	private Map treeCache = new WeakHashMap(30000); 
+	private Map commitCache = new WeakHashMap(30000); 
 
 	public Repository(final File d) throws IOException {
 		gitDir = d.getAbsoluteFile();
@@ -189,7 +190,7 @@ public class Repository {
 	}
 
 	public Commit mapCommit(final ObjectId id) throws IOException {
-		Commit ret = (Commit)cache.get(id);
+		Commit ret = (Commit)commitCache.get(id);
 		if (ret != null)
 			return ret;
 
@@ -201,7 +202,7 @@ public class Repository {
 			ret = new Commit(this, id, raw);
 			// The key must not be the referenced strongly
 			// by the value in WeakHashMaps
-			cache.put(new ObjectId(id.getBytes()), ret);
+			commitCache.put(new ObjectId(id.getBytes()), ret);
 			return ret;
 		}
 		throw new IncorrectObjectTypeException(id, Constants.TYPE_COMMIT);
@@ -213,12 +214,19 @@ public class Repository {
 	}
 
 	public Tree mapTree(final ObjectId id) throws IOException {
+		Tree ret = (Tree)treeCache.get(id);
+		if (ret != null)
+			return ret;
+
 		final ObjectLoader or = openObject(id);
 		if (or == null)
 			return null;
 		final byte[] raw = or.getBytes();
-		if (Constants.TYPE_TREE.equals(or.getType()))
-			return new Tree(this, id, raw);
+		if (Constants.TYPE_TREE.equals(or.getType())) {
+			ret = new Tree(this, id, raw);
+			treeCache.put(new ObjectId(id.getBytes()), ret);
+			return ret;
+		}
 		if (Constants.TYPE_COMMIT.equals(or.getType()))
 			return mapTree(ObjectId.fromString(raw, 5));
 		throw new IncorrectObjectTypeException(id, Constants.TYPE_TREE);

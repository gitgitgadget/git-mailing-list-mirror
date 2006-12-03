X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH] Convert author and comment on demand.
Date: Sun, 3 Dec 2006 01:45:09 +0100
Message-ID: <200612030145.09576.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 3 Dec 2006 00:43:16 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33069>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqfRn-0004z5-7x for gcvg-git@gmane.org; Sun, 03 Dec
 2006 01:43:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424890AbWLCAm4 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 19:42:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424898AbWLCAm4
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 19:42:56 -0500
Received: from [83.140.172.130] ([83.140.172.130]:20845 "EHLO
 torino.dewire.com") by vger.kernel.org with ESMTP id S1424890AbWLCAmz (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 19:42:55 -0500
Received: from localhost (localhost [127.0.0.1]) by torino.dewire.com
 (Postfix) with ESMTP id 7663A800782; Sun,  3 Dec 2006 01:39:08 +0100 (CET)
Received: from torino.dewire.com ([127.0.0.1]) by localhost (torino
 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id 08060-10; Sun,  3 Dec
 2006 01:39:07 +0100 (CET)
Received: from [10.9.0.2] (unknown [10.9.0.2]) by torino.dewire.com (Postfix)
 with ESMTP id CB46480019B; Sun,  3 Dec 2006 01:39:05 +0100 (CET)
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

This sppeds up reading commits a lot by only store the byte
array data when reading commits. For the eclipse plugin I only
need the tree to filter out which commits to display and I can
take the cost of converting the comments to string for the
very few commits to display. Only the displayed commits are actually
converted so this results in convertig author and comment information
for about five commits rather than 20,000 (in my repo).

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../src/org/spearce/jgit/lib/Commit.java           |   73 +++++++++++++------
 1 files changed, 50 insertions(+), 23 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Commit.java 
b/org.spearce.jgit/src/org/spearce/jgit/lib/Commit.java
index 4e03a5a..14fa602 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Commit.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Commit.java
@@ -16,10 +16,16 @@
  */
 package org.spearce.jgit.lib;
 
+import java.io.BufferedReader;
+import java.io.ByteArrayInputStream;
 import java.io.IOException;
+import java.io.InputStreamReader;
+import java.nio.charset.Charset;
 import java.util.ArrayList;
+import java.util.Arrays;
 import java.util.List;
 
+import org.spearce.jgit.errors.CorruptObjectException;
 import org.spearce.jgit.errors.MissingObjectException;
 
 public class Commit implements Treeish {
@@ -39,6 +45,8 @@ public class Commit implements Treeish {
 
     private Tree treeObj;
 
+    private byte[] raw;
+
     public Commit(final Repository db) {
 	objdb = db;
 	parentIds = new ArrayList(2);
@@ -58,29 +66,7 @@ public class Commit implements Treeish {
 	    rawPtr += 48;
 	}
 
-	//
-	// if (n == null || !n.startsWith("author ")) {
-	// throw new CorruptObjectException(commitId, "no author");
-	// }
-	// author = new PersonIdent(n.substring("author ".length()));
-	//
-	// n = br.readLine();
-	// if (n == null || !n.startsWith("committer ")) {
-	// throw new CorruptObjectException(commitId, "no committer");
-	// }
-	// committer = new PersonIdent(n.substring("committer ".length()));
-	//
-	// n = br.readLine();
-	// if (n == null || !n.equals("")) {
-	// throw new CorruptObjectException(commitId, "malformed header");
-	// }
-	//
-	// tempMessage = new StringBuffer();
-	// readBuf = new char[128];
-	// while ((readLen = br.read(readBuf)) > 0) {
-	// tempMessage.append(readBuf, 0, readLen);
-	// }
-	// message = tempMessage.toString();
+	this.raw = raw;
     }
 
     public ObjectId getCommitId() {
@@ -119,6 +105,7 @@ public class Commit implements Treeish {
     }
 
     public PersonIdent getAuthor() {
+	decode();
 	return author;
     }
 
@@ -127,6 +114,7 @@ public class Commit implements Treeish {
     }
 
     public PersonIdent getCommitter() {
+	decode();
 	return committer;
     }
 
@@ -139,9 +127,48 @@ public class Commit implements Treeish {
     }
 
     public String getMessage() {
+	decode();
 	return message;
     }
 
+    private void decode() {
+	if (raw!=null) {
+	    try {
+        	BufferedReader br=new BufferedReader(new InputStreamReader(new 
ByteArrayInputStream(raw)));
+        	String n=br.readLine();
+                if (n == null || !n.startsWith("tree ")) {
+                    throw new CorruptObjectException(commitId, "no tree");
+                }
+                while ((n = br.readLine())!=null && n.startsWith("parent "))
+            	;
+                if (n == null || !n.startsWith("author ")) {
+                    throw new CorruptObjectException(commitId, "no author");
+                }
+                author = new PersonIdent(n.substring("author ".length()));
+                n = br.readLine();
+                if (n == null || !n.startsWith("committer ")) {
+                    throw new CorruptObjectException(commitId, "no 
committer");
+                }
+                committer = new 
PersonIdent(n.substring("committer ".length()));
+                n = br.readLine();
+                if (n == null || !n.equals("")) {
+                    throw new CorruptObjectException(commitId, "malformed 
header");
+                }
+                StringBuffer tempMessage = new StringBuffer();
+                char[] readBuf = new char[2048];
+                int readLen;
+		while ((readLen = br.read(readBuf)) > 0) {
+                    tempMessage.append(readBuf, 0, readLen);
+                }
+                message = tempMessage.toString();
+	    } catch (IOException e) {
+		e.printStackTrace();
+	    } finally {
+		raw = null;
+	    }
+	}
+    }
+
     public void setMessage(final String m) {
 	message = m;
     }
-- 
1.4.4.gf05d


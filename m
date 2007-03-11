From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 02/10] Support commit encoding header
Date: Sun, 11 Mar 2007 19:15:26 +0100
Message-ID: <20070311181526.18012.28361.stgit@lathund.dewire.com>
References: <20070311180608.18012.13767.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Mar 11 19:14:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQSYT-0006DB-OC
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 19:14:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933944AbXCKSNv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 14:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933942AbXCKSNv
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 14:13:51 -0400
Received: from [83.140.172.130] ([83.140.172.130]:1606 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S933943AbXCKSNt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 14:13:49 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 6033C8033A7;
	Sun, 11 Mar 2007 19:08:34 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 26264-01; Sun, 11 Mar 2007 19:08:33 +0100 (CET)
Received: from lathund.dewire.com (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 9EEFE802841;
	Sun, 11 Mar 2007 19:08:33 +0100 (CET)
Received: from localhost (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id B888C291D8;
	Sun, 11 Mar 2007 19:15:47 +0100 (CET)
X-Virus-Scanned: amavisd-new at localhost.localdomain
Received: from lathund.dewire.com ([127.0.0.1])
	by localhost (lathund.dewire.com [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id mOFynHo+VzJt; Sun, 11 Mar 2007 19:15:36 +0100 (CET)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id B7342291D6;
	Sun, 11 Mar 2007 19:15:26 +0100 (CET)
In-Reply-To: <20070311180608.18012.13767.stgit@lathund.dewire.com>
User-Agent: StGIT/0.12
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41953>

Commit objects may contain an encoding, supposedly meant to
indicated the encoding used for that particular commt.

This is the last header line before the comment as far as I know.

Unfortunately the encoding header only reflects a setting in the
config file, so it is most likely to be wrong by default unless
you are on a UTF-8 platform (in which case the header isn't really
needed). Later on we'll have to decode that more intelligently. For
now we make an attempt to decode according to the setting if present,
otherwise we use the platform default.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---

 .../src/org/spearce/jgit/lib/Commit.java           |   55 +++++++++++++++++------
 .../src/org/spearce/jgit/lib/ObjectWriter.java     |   11 ++++-
 .../tst/org/spearce/jgit/lib/T0003_Basic.java      |   32 +++++++++++++
 3 files changed, 82 insertions(+), 16 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Commit.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Commit.java
index d1ef5de..1b644dd 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Commit.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Commit.java
@@ -16,10 +16,10 @@
  */
 package org.spearce.jgit.lib;
 
-import java.io.BufferedReader;
 import java.io.ByteArrayInputStream;
+import java.io.DataInputStream;
 import java.io.IOException;
-import java.io.InputStreamReader;
+import java.nio.charset.Charset;
 import java.util.ArrayList;
 import java.util.List;
 
@@ -45,6 +45,8 @@ public class Commit implements Treeish {
 
 	private byte[] raw;
 
+	private Charset encoding;
+
 	public Commit(final Repository db) {
 		objdb = db;
 		parentIds = new ArrayList(2);
@@ -132,8 +134,7 @@ public class Commit implements Treeish {
 		// FIXME: handle I/O errors
 		if (raw != null) {
 			try {
-				BufferedReader br = new BufferedReader(new InputStreamReader(
-						new ByteArrayInputStream(raw)));
+				DataInputStream br = new DataInputStream(new ByteArrayInputStream(raw));
 				String n = br.readLine();
 				if (n == null || !n.startsWith("tree ")) {
 					throw new CorruptObjectException(commitId, "no tree");
@@ -144,24 +145,33 @@ public class Commit implements Treeish {
 				if (n == null || !n.startsWith("author ")) {
 					throw new CorruptObjectException(commitId, "no author");
 				}
-				author = new PersonIdent(n.substring("author ".length()));
+				String rawAuthor = n.substring("author ".length());
 				n = br.readLine();
 				if (n == null || !n.startsWith("committer ")) {
 					throw new CorruptObjectException(commitId, "no committer");
 				}
-				committer = new PersonIdent(n.substring("committer ".length()));
+				String rawCommitter = n.substring("committer ".length());
 				n = br.readLine();
-				if (n == null || !n.equals("")) {
-					throw new CorruptObjectException(commitId,
-							"malformed header");
+				if (n != null && n.startsWith(	"encoding"))
+					encoding = Charset.forName(n.substring("encoding ".length()));
+				else
+					if (n == null || !n.equals("")) {
+						throw new CorruptObjectException(commitId,
+								"malformed header:"+n);
 				}
-				StringBuffer tempMessage = new StringBuffer();
-				char[] readBuf = new char[2048];
-				int readLen;
-				while ((readLen = br.read(readBuf)) > 0) {
-					tempMessage.append(readBuf, 0, readLen);
+				byte[] readBuf = new byte[br.available()]; // in-memory stream so this is all bytes left
+				br.read(readBuf);
+				if (encoding != null) {
+					// TODO: this isn't reliable so we need to guess the encoding from the actual content
+					author = new PersonIdent(new String(rawAuthor.getBytes(),encoding));
+					committer = new PersonIdent(new String(rawCommitter.getBytes(),encoding));
+					message = new String(readBuf,encoding);
+				} else {
+					// TODO: use config setting / platform / ascii / iso-latin
+					author = new PersonIdent(new String(rawAuthor.getBytes()));
+					committer = new PersonIdent(new String(rawCommitter.getBytes()));
+					message = new String(readBuf);
 				}
-				message = tempMessage.toString();
 			} catch (IOException e) {
 				e.printStackTrace();
 			} finally {
@@ -183,4 +193,19 @@ public class Commit implements Treeish {
 	public String toString() {
 		return "Commit[" + getCommitId() + " " + getAuthor() + "]";
 	}
+
+	public void setEncoding(String e) {
+		encoding = Charset.forName(e);
+	}
+
+	public void setEncoding(Charset e) {
+		encoding = e;
+	}
+
+	public String getEncoding() {
+		if (encoding != null)
+			return encoding.name();
+		else
+			return null;
+	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectWriter.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectWriter.java
index 667b569..a88fd95 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectWriter.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectWriter.java
@@ -108,8 +108,11 @@ public class ObjectWriter {
 
 	public ObjectId writeCommit(final Commit c) throws IOException {
 		final ByteArrayOutputStream os = new ByteArrayOutputStream();
+		String encoding = c.getEncoding();
+		if (encoding == null)
+			encoding = Constants.CHARACTER_ENCODING;
 		final OutputStreamWriter w = new OutputStreamWriter(os,
-				Constants.CHARACTER_ENCODING);
+				encoding);
 
 		w.write("tree ");
 		c.getTreeId().copyTo(w);
@@ -130,6 +133,12 @@ public class ObjectWriter {
 		w.write(c.getCommitter().toExternalString());
 		w.write('\n');
 
+		if (!encoding.equals("UTF-8")) {
+			w.write("encoding ");
+			w.write(encoding);
+			w.write('\n');
+		}
+		
 		w.write('\n');
 		w.write(c.getMessage());
 		w.close();
diff --git a/org.spearce.jgit/tst/org/spearce/jgit/lib/T0003_Basic.java b/org.spearce.jgit/tst/org/spearce/jgit/lib/T0003_Basic.java
index 9e6f805..9c807f9 100644
--- a/org.spearce.jgit/tst/org/spearce/jgit/lib/T0003_Basic.java
+++ b/org.spearce.jgit/tst/org/spearce/jgit/lib/T0003_Basic.java
@@ -21,6 +21,8 @@ import java.io.FileInputStream;
 import java.io.FileReader;
 import java.io.FileWriter;
 import java.io.IOException;
+import java.util.Date;
+import java.util.TimeZone;
 
 public class T0003_Basic extends RepositoryTestCase {
 	public void test001_Initalize() {
@@ -385,4 +387,34 @@ public class T0003_Basic extends RepositoryTestCase {
 		assertEquals(new PersonIdent(jauthor, 1154236443000L, -4 * 60), mapTag.getAuthor());
 		assertEquals("b5d3b45a96b340441f5abb9080411705c51cc86c", mapTag.getObjId().toString());
 	}
+	
+	public void test023_createCommitNonAscii() throws IOException {
+		final ObjectId emptyId = new ObjectWriter(db).writeBlob(new byte[0]);
+		final Tree almostEmptyTree = new Tree(db);
+		almostEmptyTree.addEntry(new FileTreeEntry(almostEmptyTree, emptyId, "empty".getBytes(), false));
+		final ObjectId almostEmptyTreeId = new ObjectWriter(db).writeTree(almostEmptyTree);
+		Commit commit = new Commit(db);
+		commit.setTreeId(almostEmptyTreeId);
+		commit.setAuthor(new PersonIdent("Joe H\u00e4cker","joe@example.com",new Date(1900,0,1), TimeZone.getTimeZone("CET")));
+		commit.setCommitter(new PersonIdent("Joe Hacker","joe2@example.com",new Date(1900,0,1), TimeZone.getTimeZone("CET")));
+		commit.setEncoding("UTF-8");
+		commit.setMessage("\u00dcbergeeks");
+		ObjectId cid = new ObjectWriter(db).writeCommit(commit);
+		assertEquals("ed63583834b8a627474ee9f9330434ef37a04825", cid.toString());
+	}
+
+	public void test024_createCommitNonAscii() throws IOException {
+		final ObjectId emptyId = new ObjectWriter(db).writeBlob(new byte[0]);
+		final Tree almostEmptyTree = new Tree(db);
+		almostEmptyTree.addEntry(new FileTreeEntry(almostEmptyTree, emptyId, "empty".getBytes(), false));
+		final ObjectId almostEmptyTreeId = new ObjectWriter(db).writeTree(almostEmptyTree);
+		Commit commit = new Commit(db);
+		commit.setTreeId(almostEmptyTreeId);
+		commit.setAuthor(new PersonIdent("Joe H\u00e4cker","joe@example.com",new Date(1900,0,1), TimeZone.getTimeZone("CET")));
+		commit.setCommitter(new PersonIdent("Joe Hacker","joe2@example.com",new Date(1900,0,1), TimeZone.getTimeZone("CET")));
+		commit.setEncoding("ISO-8859-1");
+		commit.setMessage("\u00dcbergeeks");
+		ObjectId cid = new ObjectWriter(db).writeCommit(commit);
+		assertEquals("afc8532038e7220179127b7e96acf534486798ce", cid.toString());
+	}
 }

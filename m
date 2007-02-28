From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 7/9] Support tag objects
Date: Wed, 28 Feb 2007 23:26:42 +0100
Message-ID: <20070228222642.12021.43184.stgit@lathund.dewire.com>
References: <20070228222355.12021.13029.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 28 23:32:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMXLe-0002xY-Bh
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 23:32:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750940AbXB1WcW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 17:32:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932601AbXB1WcW
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 17:32:22 -0500
Received: from [83.140.172.130] ([83.140.172.130]:1427 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S932572AbXB1WcK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 17:32:10 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id C252F80339F
	for <git@vger.kernel.org>; Wed, 28 Feb 2007 23:27:03 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 18351-04 for <git@vger.kernel.org>; Wed, 28 Feb 2007 23:27:02 +0100 (CET)
Received: from lathund.dewire.com (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id 5BDCA8033A3
	for <git@vger.kernel.org>; Wed, 28 Feb 2007 23:26:58 +0100 (CET)
Received: from localhost (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 6FA2629879
	for <git@vger.kernel.org>; Wed, 28 Feb 2007 23:26:43 +0100 (CET)
X-Virus-Scanned: amavisd-new at localhost.localdomain
Received: from lathund.dewire.com ([127.0.0.1])
	by localhost (lathund.dewire.com [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id OYlhMoqDLi2Y for <git@vger.kernel.org>;
	Wed, 28 Feb 2007 23:26:42 +0100 (CET)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id D11E829877
	for <git@vger.kernel.org>; Wed, 28 Feb 2007 23:26:42 +0100 (CET)
In-Reply-To: <20070228222355.12021.13029.stgit@lathund.dewire.com>
User-Agent: StGIT/0.11
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41017>

A tag refers to another object and can carry information about
who created the tag and when.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---

 .../src/org/spearce/jgit/lib/Commit.java           |    2 
 .../src/org/spearce/jgit/lib/ObjectWriter.java     |   37 +++++
 .../src/org/spearce/jgit/lib/Repository.java       |   15 ++
 org.spearce.jgit/src/org/spearce/jgit/lib/Tag.java |  172 ++++++++++++++++++++
 .../tst/org/spearce/jgit/lib/T0003_Basic.java      |   66 +++++++++
 5 files changed, 291 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Commit.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Commit.java
index 498f983..d1ef5de 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Commit.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Commit.java
@@ -79,7 +79,7 @@ public class Commit implements Treeish {
 	}
 
 	public void setTreeId(final ObjectId id) {
-		if (!treeId.equals(id)) {
+		if (treeId==null || !treeId.equals(id)) {
 			treeObj = null;
 		}
 		treeId = id;
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectWriter.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectWriter.java
index 620f1cd..0ff092c 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectWriter.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectWriter.java
@@ -137,6 +137,38 @@ public class ObjectWriter {
 		return writeCommit(os.toByteArray());
 	}
 
+	public ObjectId writeTag(final byte[] b) throws IOException {
+		return writeTag(b.length, new ByteArrayInputStream(b));
+	}
+
+	public ObjectId writeTag(final Tag c) throws IOException {
+		final ByteArrayOutputStream os = new ByteArrayOutputStream();
+		final OutputStreamWriter w = new OutputStreamWriter(os,
+				Constants.CHARACTER_ENCODING);
+
+		w.write("object ");
+		c.getObjId().copyTo(w);
+		w.write('\n');
+
+		w.write("type ");
+		w.write(c.getType());
+		w.write("\n");
+		
+		w.write("tag ");
+		w.write(c.getTag());
+		w.write("\n");
+		
+		w.write("tagger ");
+		w.write(c.getAuthor().toExternalString());
+		w.write('\n');
+
+		w.write('\n');
+		w.write(c.getMessage());
+		w.close();
+
+		return writeTag(os.toByteArray());
+	}
+	
 	public ObjectId writeCommit(final byte[] b) throws IOException {
 		return writeCommit(b.length, new ByteArrayInputStream(b));
 	}
@@ -146,6 +178,11 @@ public class ObjectWriter {
 		return writeObject(Constants.OBJ_COMMIT, Constants.TYPE_COMMIT, len, is);
 	}
 
+	public ObjectId writeTag(final long len, final InputStream is)
+		throws IOException {
+		return writeObject(Constants.OBJ_TAG, Constants.TYPE_TAG, len, is);
+	}
+	
 	public ObjectId writeObject(final int typeCode, final String type,
 			long len, final InputStream is) throws IOException {
 		final File t;
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index d2943c3..069c650 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -211,6 +211,21 @@ public class Repository {
 		throw new IncorrectObjectTypeException(id, Constants.TYPE_TREE);
 	}
 
+	public Tag mapTag(String revstr) throws IOException {
+		final ObjectId id = resolve(revstr);
+		return id != null ? mapTag(id) : null;
+	}
+	
+	public Tag mapTag(final ObjectId id) throws IOException {
+		final ObjectLoader or = openObject(id);
+		if (or == null)
+			return null;
+		final byte[] raw = or.getBytes();
+		if (Constants.TYPE_TAG.equals(or.getType()))
+			return new Tag(this, id, raw);
+		throw new IncorrectObjectTypeException(id, Constants.TYPE_TAG);
+	}
+
 	public RefLock lockRef(final String ref) throws IOException {
 		final RefLock l = new RefLock(readRef(ref, true));
 		return l.lock() ? l : null;
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Tag.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Tag.java
new file mode 100644
index 0000000..d9e6990
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Tag.java
@@ -0,0 +1,172 @@
+/*
+ *  Copyright (C) 20067  Robin Rosenberg <robin.rosenberg@dewire.com>
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public
+ *  License, version 2, as published by the Free Software Foundation.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301
+ */
+package org.spearce.jgit.lib;
+
+import java.io.BufferedReader;
+import java.io.ByteArrayInputStream;
+import java.io.IOException;
+import java.io.InputStreamReader;
+
+import org.spearce.jgit.errors.CorruptObjectException;
+
+public class Tag {
+	private final Repository objdb;
+
+	private ObjectId tagId;
+
+	private PersonIdent tagger;
+
+	private String message;
+
+	private byte[] raw;
+
+	private String type;
+
+	private String tag;
+
+	private ObjectId objId;
+
+	public Tag(final Repository db) {
+		objdb = db;
+	}
+
+	public Tag(final Repository db, final ObjectId id, final byte[] raw) {
+		objdb = db;
+		tagId = id;
+		objId = ObjectId.fromString(raw, 7);
+		this.raw = raw;
+	}
+
+	public PersonIdent getAuthor() {
+		decode();
+		return tagger;
+	}
+
+	public void setAuthor(final PersonIdent a) {
+		tagger = a;
+	}
+
+	public String getMessage() {
+		decode();
+		return message;
+	}
+
+	private void decode() {
+		// FIXME: handle I/O errors
+		if (raw != null) {
+			try {
+				BufferedReader br = new BufferedReader(new InputStreamReader(
+						new ByteArrayInputStream(raw)));
+				String n = br.readLine();
+				if (n == null || !n.startsWith("object ")) {
+					throw new CorruptObjectException(tagId, "no object");
+				}
+				objId = new ObjectId(n.substring(7));
+				n = br.readLine();
+				if (n == null || !n.startsWith("type ")) {
+					throw new CorruptObjectException(tagId, "no type");
+				}
+				type = n.substring("type ".length());
+				n = br.readLine();
+
+				if (n == null || !n.startsWith("tag ")) {
+					throw new CorruptObjectException(tagId, "no tag name");
+				}
+				tag = n.substring("tag ".length());
+				n = br.readLine();
+
+				if (n == null || !n.startsWith("tagger ")) {
+					throw new CorruptObjectException(tagId, "no tagger");
+				}
+				tagger = new PersonIdent(n.substring("tagger ".length()));
+
+				n = br.readLine();
+				if (n == null || !n.equals("")) {
+					throw new CorruptObjectException(tagId,
+							"malformed header");
+				}
+				StringBuffer tempMessage = new StringBuffer();
+				char[] readBuf = new char[2048];
+				int readLen;
+				while ((readLen = br.read(readBuf)) > 0) {
+					tempMessage.append(readBuf, 0, readLen);
+				}
+				message = tempMessage.toString();
+			} catch (IOException e) {
+				e.printStackTrace();
+			} finally {
+				raw = null;
+			}
+		}
+	}
+
+	public void setMessage(final String m) {
+		message = m;
+	}
+
+	public void tag() throws IOException {
+		if (getTagId() != null)
+			throw new IllegalStateException("exists " + getTagId());
+		setTagId(new ObjectWriter(objdb).writeTag(this));
+	}
+
+	public String toString() {
+		return "tag[" + getTag() + getType() + getObjId() + " " + getAuthor() + "]";
+	}
+
+	public ObjectId getTagId() {
+		return tagId;
+	}
+
+	public void setTagId(ObjectId tagId) {
+		this.tagId = tagId;
+	}
+
+	public PersonIdent getTagger() {
+		decode();
+		return tagger;
+	}
+
+	public void setTagger(PersonIdent tagger) {
+		this.tagger = tagger;
+	}
+
+	public String getType() {
+		decode();
+		return type;
+	}
+
+	public void setType(String type) {
+		this.type = type;
+	}
+	
+	public String getTag() {
+		return tag;
+	}
+
+	public void setTag(String tag) {
+		this.tag = tag;
+	}
+
+	public ObjectId getObjId() {
+		return objId;
+	}
+
+	public void setObjId(ObjectId objId) {
+		this.objId = objId;
+	}
+}
diff --git a/org.spearce.jgit/tst/org/spearce/jgit/lib/T0003_Basic.java b/org.spearce.jgit/tst/org/spearce/jgit/lib/T0003_Basic.java
index a1bf803..0b135b1 100644
--- a/org.spearce.jgit/tst/org/spearce/jgit/lib/T0003_Basic.java
+++ b/org.spearce.jgit/tst/org/spearce/jgit/lib/T0003_Basic.java
@@ -319,4 +319,70 @@ public class T0003_Basic extends RepositoryTestCase {
 		assertEquals(new ObjectId("b47a8f0a4190f7572e11212769090523e23eb1ea"),
 				t.getId());
 	}
+	
+	public void test020_createBlobTag() throws IOException {
+		final ObjectId emptyId = new ObjectWriter(db).writeBlob(new byte[0]);
+		final Tag t = new Tag(db);
+		t.setObjId(emptyId);
+		t.setType("blob");
+		t.setTag("test020");
+		t.setAuthor(new PersonIdent(jauthor, 1154236443000L, -4 * 60));
+		t.setMessage("test020 tagged\n");
+		t.tag();
+		assertEquals("6759556b09fbb4fd8ae5e315134481cc25d46954", t.getTagId().toString());
+
+		Tag mapTag = db.mapTag("6759556b09fbb4fd8ae5e315134481cc25d46954");
+		assertEquals("blob", mapTag.getType());
+		assertEquals("test020 tagged\n", mapTag.getMessage());
+		assertEquals(new PersonIdent(jauthor, 1154236443000L, -4 * 60), mapTag.getAuthor());
+		assertEquals("e69de29bb2d1d6434b8b29ae775ad8c2e48c5391", mapTag.getObjId().toString());
+	}
+
+	public void test021_createTreeTag() throws IOException {
+		final ObjectId emptyId = new ObjectWriter(db).writeBlob(new byte[0]);
+		final Tree almostEmptyTree = new Tree(db);
+		almostEmptyTree.addEntry(new FileTreeEntry(almostEmptyTree, emptyId, "empty".getBytes(), false));
+		final ObjectId almostEmptyTreeId = new ObjectWriter(db).writeTree(almostEmptyTree);
+		final Tag t = new Tag(db);
+		t.setObjId(almostEmptyTreeId);
+		t.setType("tree");
+		t.setTag("test021");
+		t.setAuthor(new PersonIdent(jauthor, 1154236443000L, -4 * 60));
+		t.setMessage("test021 tagged\n");
+		t.tag();
+		assertEquals("b0517bc8dbe2096b419d42424cd7030733f4abe5", t.getTagId().toString());
+
+		Tag mapTag = db.mapTag("b0517bc8dbe2096b419d42424cd7030733f4abe5");
+		assertEquals("tree", mapTag.getType());
+		assertEquals("test021 tagged\n", mapTag.getMessage());
+		assertEquals(new PersonIdent(jauthor, 1154236443000L, -4 * 60), mapTag.getAuthor());
+		assertEquals("417c01c8795a35b8e835113a85a5c0c1c77f67fb", mapTag.getObjId().toString());
+	}
+
+	public void test022_createCommitTag() throws IOException {
+		final ObjectId emptyId = new ObjectWriter(db).writeBlob(new byte[0]);
+		final Tree almostEmptyTree = new Tree(db);
+		almostEmptyTree.addEntry(new FileTreeEntry(almostEmptyTree, emptyId, "empty".getBytes(), false));
+		final ObjectId almostEmptyTreeId = new ObjectWriter(db).writeTree(almostEmptyTree);
+		final Commit almostEmptyCommit = new Commit(db);
+		almostEmptyCommit.setAuthor(new PersonIdent(jauthor, 1154236443000L, -2 * 60)); // not exactly the same
+		almostEmptyCommit.setCommitter(new PersonIdent(jauthor, 1154236443000L, -2 * 60));
+		almostEmptyCommit.setMessage("test022\n");
+		almostEmptyCommit.setTreeId(almostEmptyTreeId);
+		ObjectId almostEmptyCommitId = new ObjectWriter(db).writeCommit(almostEmptyCommit);
+		final Tag t = new Tag(db);
+		t.setObjId(almostEmptyCommitId);
+		t.setType("commit");
+		t.setTag("test022");
+		t.setAuthor(new PersonIdent(jauthor, 1154236443000L, -4 * 60));
+		t.setMessage("test022 tagged\n");
+		t.tag();
+		assertEquals("0ce2ebdb36076ef0b38adbe077a07d43b43e3807", t.getTagId().toString());
+
+		Tag mapTag = db.mapTag("0ce2ebdb36076ef0b38adbe077a07d43b43e3807");
+		assertEquals("commit", mapTag.getType());
+		assertEquals("test022 tagged\n", mapTag.getMessage());
+		assertEquals(new PersonIdent(jauthor, 1154236443000L, -4 * 60), mapTag.getAuthor());
+		assertEquals("b5d3b45a96b340441f5abb9080411705c51cc86c", mapTag.getObjId().toString());
+	}
 }

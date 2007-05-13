From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [PATCH] Implement simple tags
Date: Mon, 14 May 2007 01:39:14 +0200
Message-ID: <11790995571082-git-send-email-robin.rosenberg@dewire.com>
References: <11790995572233-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Mon May 14 01:59:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnNyH-00061r-RJ
	for gcvg-git@gmane.org; Mon, 14 May 2007 01:59:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758388AbXEMX7V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 May 2007 19:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757666AbXEMX7V
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 19:59:21 -0400
Received: from [83.140.172.130] ([83.140.172.130]:23501 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1758576AbXEMX7Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 May 2007 19:59:16 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 9B8D48030A9;
	Mon, 14 May 2007 01:32:59 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 06019-06; Mon, 14 May 2007 01:32:58 +0200 (CEST)
Received: from lathund.dewire.com (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id C991A8027ED;
	Mon, 14 May 2007 01:32:58 +0200 (CEST)
Received: by lathund.dewire.com (Postfix, from userid 500)
	id 9DCC02815D; Mon, 14 May 2007 01:39:17 +0200 (CEST)
X-Mailer: git-send-email 1.5.1.1
In-Reply-To: <11790995572233-git-send-email-robin.rosenberg@dewire.com>
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47199>

This is just a reference in <gitdir>/refs/tags with the SHA-1
of the tagged object.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../src/org/spearce/jgit/lib/Repository.java       |   14 +++++++-------
 org.spearce.jgit/src/org/spearce/jgit/lib/Tag.java |   20 ++++++++++++++++----
 .../tst/org/spearce/jgit/lib/T0003_Basic.java      |   13 +++++++++++++
 3 files changed, 36 insertions(+), 11 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index 482f41d..76191be 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -262,17 +262,17 @@ public class Repository {
 
 	public Tag mapTag(String revstr) throws IOException {
 		final ObjectId id = resolve(revstr);
-		return id != null ? mapTag(id) : null;
+		return id != null ? mapTag(revstr, id) : null;
 	}
 
-	public Tag mapTag(final ObjectId id) throws IOException {
+	public Tag mapTag(final String refName, final ObjectId id) throws IOException {
 		final ObjectLoader or = openObject(id);
 		if (or == null)
 			return null;
 		final byte[] raw = or.getBytes();
 		if (Constants.TYPE_TAG.equals(or.getType()))
-			return new Tag(this, id, raw);
-		throw new IncorrectObjectTypeException(id, Constants.TYPE_TAG);
+			return new Tag(this, id, refName, raw);
+		return new Tag(this, id, refName, null);
 	}
 
 	public RefLock lockRef(final String ref) throws IOException {
@@ -469,7 +469,7 @@ public class Repository {
 		return listFilesRecursively(new File(refsDir, "heads"), null);
 	}
 
-	public Collection getTags() {
+	public Collection<String> getTags() {
 		return listFilesRecursively(new File(refsDir, "tags"), null);
 	}
 
@@ -535,10 +535,10 @@ public class Repository {
 		return ret;
 	}
 
-	private Collection listFilesRecursively(File root, File start) {
+	private Collection<String> listFilesRecursively(File root, File start) {
 		if (start == null)
 			start = root;
-		Collection ret = new ArrayList();
+		Collection<String> ret = new ArrayList();
 		File[] files = start.listFiles();
 		for (int i = 0; i < files.length; ++i) {
 			if (files[i].isDirectory())
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Tag.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Tag.java
index 877c440..d5c6b54 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Tag.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Tag.java
@@ -44,10 +44,16 @@ public class Tag {
 		objdb = db;
 	}
 
-	public Tag(final Repository db, final ObjectId id, final byte[] raw) {
+	public Tag(final Repository db, final ObjectId id, String refName, final byte[] raw) {
 		objdb = db;
-		tagId = id;
-		objId = ObjectId.fromString(raw, 7);
+		if (raw != null) {
+			tagId = id;
+			objId = ObjectId.fromString(raw, 7);
+		} else
+			objId = id;
+		if (refName.startsWith("refs/tags/"))
+			refName = refName.substring(10);
+		tag = refName;
 		this.raw = raw;
 	}
 
@@ -119,7 +125,13 @@ public class Tag {
 	public void tag() throws IOException {
 		if (getTagId() != null)
 			throw new IllegalStateException("exists " + getTagId());
-		setTagId(new ObjectWriter(objdb).writeTag(this));
+		if (tagger!=null || message!=null || type!=null) {
+			ObjectId tagid = new ObjectWriter(objdb).writeTag(this);
+			setTagId(tagid);
+			objdb.writeRef("refs/heads/"+getTag(),tagid);
+		} else {
+			objdb.writeRef("refs/heads/"+getTag(),objId);
+		}
 	}
 
 	public String toString() {
diff --git a/org.spearce.jgit/tst/org/spearce/jgit/lib/T0003_Basic.java b/org.spearce.jgit/tst/org/spearce/jgit/lib/T0003_Basic.java
index 0302a45..115e391 100644
--- a/org.spearce.jgit/tst/org/spearce/jgit/lib/T0003_Basic.java
+++ b/org.spearce.jgit/tst/org/spearce/jgit/lib/T0003_Basic.java
@@ -338,6 +338,19 @@ public class T0003_Basic extends RepositoryTestCase {
 		assertEquals("e69de29bb2d1d6434b8b29ae775ad8c2e48c5391", mapTag.getObjId().toString());
 	}
 
+	public void test020b_createBlobPlainTag() throws IOException {
+		test020_createBlobTag();
+		Tag t = new Tag(db);
+		t.setTag("test020b");
+		t.setObjId(new ObjectId("e69de29bb2d1d6434b8b29ae775ad8c2e48c5391"));
+		t.tag();
+		
+		Tag mapTag = db.mapTag("test020b");
+		assertEquals("e69de29bb2d1d6434b8b29ae775ad8c2e48c5391", mapTag.getObjId().toString());
+		
+		// We do not repeat the plain tag test for other object types
+	}
+
 	public void test021_createTreeTag() throws IOException {
 		final ObjectId emptyId = new ObjectWriter(db).writeBlob(new byte[0]);
 		final Tree almostEmptyTree = new Tree(db);
-- 
1.5.1.1

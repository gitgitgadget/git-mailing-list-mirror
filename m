From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [PATCH] Implement packed refs
Date: Mon, 14 May 2007 01:39:16 +0200
Message-ID: <11790995571637-git-send-email-robin.rosenberg@dewire.com>
References: <11790995572233-git-send-email-robin.rosenberg@dewire.com>
 <11790995571082-git-send-email-robin.rosenberg@dewire.com>
 <11790995573817-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Mon May 14 01:59:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnNyI-00061r-BK
	for gcvg-git@gmane.org; Mon, 14 May 2007 01:59:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757971AbXEMX7W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 May 2007 19:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758576AbXEMX7W
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 19:59:22 -0400
Received: from [83.140.172.130] ([83.140.172.130]:23504 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1758590AbXEMX7Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 May 2007 19:59:16 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id E9ABB802E1B;
	Mon, 14 May 2007 01:33:01 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 06005-07; Mon, 14 May 2007 01:32:59 +0200 (CEST)
Received: from lathund.dewire.com (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id D2B228028BD;
	Mon, 14 May 2007 01:32:58 +0200 (CEST)
Received: by lathund.dewire.com (Postfix, from userid 500)
	id BBA2528BBB; Mon, 14 May 2007 01:39:17 +0200 (CEST)
X-Mailer: git-send-email 1.5.1.1
In-Reply-To: <11790995573817-git-send-email-robin.rosenberg@dewire.com>
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47200>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../src/org/spearce/jgit/lib/Repository.java       |   48 +++++++++++++++++++-
 .../tst/org/spearce/jgit/lib/T0003_Basic.java      |   44 ++++++++++++++++++
 2 files changed, 91 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index 76191be..3b2a82c 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -399,6 +399,7 @@ public class Repository {
 
 	private Ref readRef(final String revstr, final boolean missingOk)
 			throws IOException {
+		refreshPackredRefsCache();
 		for (int k = 0; k < refSearchPaths.length; k++) {
 			final Ref r = readRefBasic(refSearchPaths[k] + revstr);
 			if (missingOk || r.getObjectId() != null) {
@@ -411,6 +412,10 @@ public class Repository {
 	private Ref readRefBasic(String name) throws IOException {
 		int depth = 0;
 		REF_READING: do {
+			ObjectId id = packedRefs.get(name);
+			if (id != null)
+				return new Ref(null, id);
+
 			final File f = new File(getDirectory(), name);
 			if (!f.isFile()) {
 				return new Ref(f, null);
@@ -470,7 +475,43 @@ public class Repository {
 	}
 
 	public Collection<String> getTags() {
-		return listFilesRecursively(new File(refsDir, "tags"), null);
+		Collection<String> tags = listFilesRecursively(new File(refsDir, "tags"), null);
+		refreshPackredRefsCache();
+		tags.addAll(packedRefs.keySet());
+		return tags;
+	}
+
+	private Map<String,ObjectId> packedRefs = new HashMap<String,ObjectId>();
+	private long packedrefstime = 0;
+
+	private void refreshPackredRefsCache() {
+		File file = new File(gitDir, "packed-refs");
+		if (!file.exists()) {
+			if (packedRefs.size() > 0)
+				packedRefs = new HashMap();
+			return;
+		}
+		if (file.lastModified() == packedrefstime)
+			return;
+		Map newPackedRefs = new HashMap();
+		try {
+			BufferedReader b=new BufferedReader(new FileReader(file));
+			String p;
+			while ((p = b.readLine()) != null) {
+				if (p.charAt(0) == '#')
+					continue;
+				if (p.charAt(0) == '^') {
+					continue;
+				}
+				int spos = p.indexOf(' ');
+				ObjectId id = new ObjectId(p.substring(0,spos));
+				String name = p.substring(spos+1);
+				newPackedRefs.put(name, id);
+			}
+		} catch (IOException e) {
+			e.printStackTrace();
+		}
+		packedRefs = newPackedRefs;
 	}
 
 	/**
@@ -551,4 +592,9 @@ public class Repository {
 		}
 		return ret;
 	}
+	
+	/** Clean up stale caches */
+	public void refreshFromDisk() {
+		packedRefs = null;
+	}
 }
diff --git a/org.spearce.jgit/tst/org/spearce/jgit/lib/T0003_Basic.java b/org.spearce.jgit/tst/org/spearce/jgit/lib/T0003_Basic.java
index 2f76907..02ecabf 100644
--- a/org.spearce.jgit/tst/org/spearce/jgit/lib/T0003_Basic.java
+++ b/org.spearce.jgit/tst/org/spearce/jgit/lib/T0003_Basic.java
@@ -21,6 +21,7 @@ import java.io.FileInputStream;
 import java.io.FileReader;
 import java.io.FileWriter;
 import java.io.IOException;
+import java.io.PrintWriter;
 
 public class T0003_Basic extends RepositoryTestCase {
 	public void test001_Initalize() {
@@ -428,4 +429,47 @@ public class T0003_Basic extends RepositoryTestCase {
 		ObjectId cid = new ObjectWriter(db).writeCommit(commit);
 		assertEquals("2979b39d385014b33287054b87f77bcb3ecb5ebf", cid.toString());
 	}
+	
+	public void test025_packedRefs() throws IOException {
+		test020_createBlobTag();
+		test021_createTreeTag();
+		test022_createCommitTag();
+
+		if (!new File(db.getDirectory(),"refs/tags/test020").delete()) throw new Error("Cannot delete unpacked tag");
+		if (!new File(db.getDirectory(),"refs/tags/test021").delete()) throw new Error("Cannot delete unpacked tag");
+		if (!new File(db.getDirectory(),"refs/tags/test022").delete()) throw new Error("Cannot delete unpacked tag");
+
+		// We cannot resolve it now, since we have no ref
+		Tag mapTag20missing = db.mapTag("test020");
+		assertNull(mapTag20missing);
+
+		// Construct packed refs file
+		PrintWriter w = new PrintWriter(new FileWriter(new File(db.getDirectory(), "packed-refs")));
+		w.println("# packed-refs with: peeled");
+		w.println("6759556b09fbb4fd8ae5e315134481cc25d46954 refs/tags/test020");
+		w.println("^e69de29bb2d1d6434b8b29ae775ad8c2e48c5391");
+		w.println("b0517bc8dbe2096b419d42424cd7030733f4abe5 refs/tags/test021");
+		w.println("^417c01c8795a35b8e835113a85a5c0c1c77f67fb");
+		w.println("0ce2ebdb36076ef0b38adbe077a07d43b43e3807 refs/tags/test022");
+		w.println("^b5d3b45a96b340441f5abb9080411705c51cc86c");
+		w.close();
+
+		Tag mapTag20 = db.mapTag("test020");
+		assertEquals("blob", mapTag20.getType());
+		assertEquals("test020 tagged\n", mapTag20.getMessage());
+		assertEquals(new PersonIdent(jauthor, 1154236443000L, -4 * 60), mapTag20.getAuthor());
+		assertEquals("e69de29bb2d1d6434b8b29ae775ad8c2e48c5391", mapTag20.getObjId().toString());
+
+		Tag mapTag21 = db.mapTag("test021");
+		assertEquals("tree", mapTag21.getType());
+		assertEquals("test021 tagged\n", mapTag21.getMessage());
+		assertEquals(new PersonIdent(jauthor, 1154236443000L, -4 * 60), mapTag21.getAuthor());
+		assertEquals("417c01c8795a35b8e835113a85a5c0c1c77f67fb", mapTag21.getObjId().toString());
+
+		Tag mapTag22 = db.mapTag("test022");
+		assertEquals("commit", mapTag22.getType());
+		assertEquals("test022 tagged\n", mapTag22.getMessage());
+		assertEquals(new PersonIdent(jauthor, 1154236443000L, -4 * 60), mapTag22.getAuthor());
+		assertEquals("b5d3b45a96b340441f5abb9080411705c51cc86c", mapTag22.getObjId().toString());
+	}
 }
-- 
1.5.1.1

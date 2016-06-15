From: Nigel Magnay <nigel.magnay@gmail.com>
Subject: [JGIT PATCH] 2/2: Tests for externalizable items
Date: Mon, 16 Feb 2009 16:46:52 +0000
Message-ID: <320075ff0902160846o4c9782eax1513943cd1af8c2d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 16 17:49:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZ6eS-0005hX-WE
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 17:49:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753240AbZBPQrS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 11:47:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752841AbZBPQrS
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 11:47:18 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:39535 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753074AbZBPQrP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 11:47:15 -0500
Received: by fxm13 with SMTP id 13so6103566fxm.13
        for <git@vger.kernel.org>; Mon, 16 Feb 2009 08:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=q764hUEvbEsLVV7XfzH+704hhxOnW3Rxtt0QYeGgugY=;
        b=QRRAVf2/2EFE+UhZ2jgZeovwub0x7Kjz83NurWRz5Dbaq3JI5vacuiK6NtdOyFsIg4
         y3C35BwcUQ4FSo+njoR6ruwFdaPr9OuXq3/KWYdZ29APCZYVZetYXGAjQm2ilV8jNG/7
         QodWBkbezIv/7qoHN6psnS4/cidcfUx8Q+6v4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=FVqIATa/gXDd8QmOj3xkgs3NQFlB4LuLBVj64M1v9y7rd+njqNZOkNykc23s0ISAlr
         P1drgHJoRi0Y19b7FF5V/6aZq9XdcjwlJPC9iMnKg8CosDww4RmtEnenAidMtk6t35Hl
         Ni1hQiFTtqoh8aC9m+iR7K/KHZcDcqQonIvns=
Received: by 10.102.247.4 with SMTP id u4mr1652185muh.104.1234802812737; Mon, 
	16 Feb 2009 08:46:52 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110208>

Extend unit tests for Externalizable items so that each test checks,
by round-tripping, the
representation that it remains the same.

Signed-off-by: Nigel Magnay <nigel.magnay@gmail.com>
---
 .../tst/org/spearce/jgit/lib/T0001_ObjectId.java   |   23 +++++++
 .../spearce/jgit/transport/RefSpecTestCase.java    |   68 ++++++++++++++++----
 .../spearce/jgit/transport/RemoteConfigTest.java   |   57 ++++++++++++++++
 .../tst/org/spearce/jgit/transport/URIishTest.java |   36 ++++++++++
 4 files changed, 172 insertions(+), 12 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0001_ObjectId.java
b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0001_ObjectId.java
index 4c03667..be70b65 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0001_ObjectId.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0001_ObjectId.java
@@ -37,6 +37,12 @@

 package org.spearce.jgit.lib;

+import java.io.ByteArrayInputStream;
+import java.io.ByteArrayOutputStream;
+import java.io.IOException;
+import java.io.ObjectInputStream;
+import java.io.ObjectOutputStream;
+
 import junit.framework.TestCase;

 public class T0001_ObjectId extends TestCase {
@@ -94,4 +100,21 @@ public void test010_toString() {
 		final String x = "0000000000000000000000000000000000000000";
 		assertEquals(x, ObjectId.toString(null));
 	}
+	
+	public void test011_roundTrip() throws IOException, ClassNotFoundException {
+		final String x = "0123456789abcdeffedcba987654321011223344";
+		final ObjectId oid = ObjectId.fromString(x);
+		
+		ByteArrayOutputStream stream = new ByteArrayOutputStream();
+		ObjectOutputStream out = new ObjectOutputStream(stream);
+		out.writeObject(oid);
+		out.close();
+
+		ObjectInputStream in = new ObjectInputStream(new ByteArrayInputStream(
+				stream.toByteArray()));
+		ObjectId oid2 = (ObjectId) in.readObject();
+		in.close();
+		
+		assert(oid2.equals(oid));
+	}
 }
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/transport/RefSpecTestCase.java
b/org.spearce.jgit.test/tst/org/spearce/jgit/transport/RefSpecTestCase.java
index 341b4a4..ad100a7 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/transport/RefSpecTestCase.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/transport/RefSpecTestCase.java
@@ -38,12 +38,17 @@

 package org.spearce.jgit.transport;

+import java.io.ByteArrayInputStream;
+import java.io.ByteArrayOutputStream;
+import java.io.ObjectInputStream;
+import java.io.ObjectOutputStream;
+
 import junit.framework.TestCase;

 import org.spearce.jgit.lib.Ref;

 public class RefSpecTestCase extends TestCase {
-	public void testMasterMaster() {
+	public void testMasterMaster() throws Exception {
 		final String sn = "refs/heads/master";
 		final RefSpec rs = new RefSpec(sn + ":" + sn);
 		assertFalse(rs.isForceUpdate());
@@ -61,9 +66,11 @@ public void testMasterMaster() {
 		r = new Ref(Ref.Storage.LOOSE, sn + "-and-more", null);
 		assertFalse(rs.matchSource(r));
 		assertFalse(rs.matchDestination(r));
+		
+		assertRoundTrip(rs);
 	}

-	public void testForceMasterMaster() {
+	public void testForceMasterMaster() throws Exception {
 		final String sn = "refs/heads/master";
 		final RefSpec rs = new RefSpec("+" + sn + ":" + sn);
 		assertTrue(rs.isForceUpdate());
@@ -81,9 +88,11 @@ public void testForceMasterMaster() {
 		r = new Ref(Ref.Storage.LOOSE, sn + "-and-more", null);
 		assertFalse(rs.matchSource(r));
 		assertFalse(rs.matchDestination(r));
+		
+		assertRoundTrip(rs);
 	}

-	public void testMaster() {
+	public void testMaster() throws Exception {
 		final String sn = "refs/heads/master";
 		final RefSpec rs = new RefSpec(sn);
 		assertFalse(rs.isForceUpdate());
@@ -101,9 +110,11 @@ public void testMaster() {
 		r = new Ref(Ref.Storage.LOOSE, sn + "-and-more", null);
 		assertFalse(rs.matchSource(r));
 		assertFalse(rs.matchDestination(r));
+		
+		assertRoundTrip(rs);
 	}

-	public void testForceMaster() {
+	public void testForceMaster() throws Exception {
 		final String sn = "refs/heads/master";
 		final RefSpec rs = new RefSpec("+" + sn);
 		assertTrue(rs.isForceUpdate());
@@ -121,9 +132,11 @@ public void testForceMaster() {
 		r = new Ref(Ref.Storage.LOOSE, sn + "-and-more", null);
 		assertFalse(rs.matchSource(r));
 		assertFalse(rs.matchDestination(r));
+		
+		assertRoundTrip(rs);
 	}

-	public void testDeleteMaster() {
+	public void testDeleteMaster() throws Exception {
 		final String sn = "refs/heads/master";
 		final RefSpec rs = new RefSpec(":" + sn);
 		assertFalse(rs.isForceUpdate());
@@ -141,9 +154,11 @@ public void testDeleteMaster() {
 		r = new Ref(Ref.Storage.LOOSE, sn + "-and-more", null);
 		assertFalse(rs.matchSource(r));
 		assertFalse(rs.matchDestination(r));
+		
+		assertRoundTrip(rs);
 	}

-	public void testForceRemotesOrigin() {
+	public void testForceRemotesOrigin() throws Exception {
 		final String srcn = "refs/heads/*";
 		final String dstn = "refs/remotes/origin/*";
 		final RefSpec rs = new RefSpec("+" + srcn + ":" + dstn);
@@ -174,18 +189,22 @@ public void testForceRemotesOrigin() {
 		r = new Ref(Ref.Storage.LOOSE, "refs/tags/v1.0", null);
 		assertFalse(rs.matchSource(r));
 		assertFalse(rs.matchDestination(r));
+		
+		assertRoundTrip(rs);
 	}

-	public void testCreateEmpty() {
+	public void testCreateEmpty() throws Exception {
 		final RefSpec rs = new RefSpec();
 		assertFalse(rs.isForceUpdate());
 		assertFalse(rs.isWildcard());
 		assertEquals("HEAD", rs.getSource());
 		assertNull(rs.getDestination());
 		assertEquals("HEAD", rs.toString());
+		assertRoundTrip(rs);
+		
 	}

-	public void testSetForceUpdate() {
+	public void testSetForceUpdate() throws Exception {
 		final String s = "refs/heads/*:refs/remotes/origin/*";
 		final RefSpec a = new RefSpec(s);
 		assertFalse(a.isForceUpdate());
@@ -195,25 +214,31 @@ public void testSetForceUpdate() {
 		assertTrue(b.isForceUpdate());
 		assertEquals(s, a.toString());
 		assertEquals("+" + s, b.toString());
+		assertRoundTrip(a);
+		assertRoundTrip(b);
 	}

-	public void testSetSource() {
+	public void testSetSource() throws Exception {
 		final RefSpec a = new RefSpec();
 		final RefSpec b = a.setSource("refs/heads/master");
 		assertNotSame(a, b);
 		assertEquals("HEAD", a.toString());
 		assertEquals("refs/heads/master", b.toString());
+		assertRoundTrip(a);
+		assertRoundTrip(b);
 	}

-	public void testSetDestination() {
+	public void testSetDestination() throws Exception {
 		final RefSpec a = new RefSpec();
 		final RefSpec b = a.setDestination("refs/heads/master");
 		assertNotSame(a, b);
 		assertEquals("HEAD", a.toString());
 		assertEquals("HEAD:refs/heads/master", b.toString());
+		assertRoundTrip(a);
+		assertRoundTrip(b);
 	}

-	public void testSetDestination_SourceNull() {
+	public void testSetDestination_SourceNull() throws Exception {
 		final RefSpec a = new RefSpec();
 		RefSpec b;

@@ -222,14 +247,33 @@ public void testSetDestination_SourceNull() {
 		assertNotSame(a, b);
 		assertEquals("HEAD", a.toString());
 		assertEquals(":refs/heads/master", b.toString());
+		assertRoundTrip(a);
+		assertRoundTrip(b);
 	}

-	public void testSetSourceDestination() {
+	public void testSetSourceDestination() throws Exception {
 		final RefSpec a = new RefSpec();
 		final RefSpec b;
 		b = a.setSourceDestination("refs/heads/*", "refs/remotes/origin/*");
 		assertNotSame(a, b);
 		assertEquals("HEAD", a.toString());
 		assertEquals("refs/heads/*:refs/remotes/origin/*", b.toString());
+		assertRoundTrip(a);
+		assertRoundTrip(b);
+		
+	}
+	
+	protected void assertRoundTrip(RefSpec refspec) throws Exception {
+		ByteArrayOutputStream stream = new ByteArrayOutputStream();
+		ObjectOutputStream out = new ObjectOutputStream(stream);
+		out.writeObject(refspec);
+		out.close();
+
+		ObjectInputStream in = new ObjectInputStream(new ByteArrayInputStream(
+				stream.toByteArray()));
+		RefSpec refspec2 = (RefSpec) in.readObject();
+		in.close();
+		
+		assertEquals(refspec, refspec2);
 	}
 }
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/transport/RemoteConfigTest.java
b/org.spearce.jgit.test/tst/org/spearce/jgit/transport/RemoteConfigTest.java
index 6b72b64..f1deb86 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/transport/RemoteConfigTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/transport/RemoteConfigTest.java
@@ -38,10 +38,14 @@

 package org.spearce.jgit.transport;

+import java.io.ByteArrayInputStream;
+import java.io.ByteArrayOutputStream;
 import java.io.File;
 import java.io.FileNotFoundException;
 import java.io.FileOutputStream;
 import java.io.IOException;
+import java.io.ObjectInputStream;
+import java.io.ObjectOutputStream;
 import java.io.UnsupportedEncodingException;
 import java.util.List;

@@ -91,6 +95,8 @@ writeConfig("[remote \"spearce\"]\n"
 		assertEquals("refs/remotes/spearce/*", spec.getDestination());

 		assertEquals(0, rc.getPushRefSpecs().size());
+		
+		checkRoundTrip(rc);
 	}

 	public void testSimpleNoTags() throws Exception {
@@ -100,6 +106,7 @@ writeConfig("[remote \"spearce\"]\n"
 				+ "tagopt = --no-tags\n");
 		final RemoteConfig rc = new RemoteConfig(db.getConfig(), "spearce");
 		assertSame(TagOpt.NO_TAGS, rc.getTagOpt());
+		checkRoundTrip(rc);
 	}

 	public void testSimpleAlwaysTags() throws Exception {
@@ -109,6 +116,7 @@ writeConfig("[remote \"spearce\"]\n"
 				+ "tagopt = --tags\n");
 		final RemoteConfig rc = new RemoteConfig(db.getConfig(), "spearce");
 		assertSame(TagOpt.FETCH_TAGS, rc.getTagOpt());
+		checkRoundTrip(rc);
 	}

 	public void testMirror() throws Exception {
@@ -144,6 +152,7 @@ writeConfig("[remote \"spearce\"]\n"
 		assertEquals("refs/tags/*", spec.getDestination());

 		assertEquals(0, rc.getPushRefSpecs().size());
+		checkRoundTrip(rc);
 	}

 	public void testBackup() throws Exception {
@@ -180,6 +189,7 @@ writeConfig("[remote \"backup\"]\n"
 		assertTrue(spec.isWildcard());
 		assertEquals("refs/tags/*", spec.getSource());
 		assertEquals("refs/tags/*", spec.getDestination());
+		checkRoundTrip(rc);
 	}

 	public void testUploadPack() throws Exception {
@@ -212,6 +222,7 @@ writeConfig("[remote \"example\"]\n"

 		assertEquals("/path/to/git/git-upload-pack", rc.getUploadPack());
 		assertEquals("/path/to/git/git-receive-pack", rc.getReceivePack());
+		checkRoundTrip(rc);
 	}

 	public void testUnknown() throws Exception {
@@ -223,6 +234,7 @@ public void testUnknown() throws Exception {
 		assertEquals(0, rc.getPushRefSpecs().size());
 		assertEquals("git-upload-pack", rc.getUploadPack());
 		assertEquals("git-receive-pack", rc.getReceivePack());
+		checkRoundTrip(rc);
 	}

 	public void testAddURI() throws Exception {
@@ -238,6 +250,7 @@ public void testAddURI() throws Exception {

 		assertFalse(rc.addURI(new URIish(uri.toString())));
 		assertEquals(1, rc.getURIs().size());
+		checkRoundTrip(rc);
 	}

 	public void testRemoveFirstURI() throws Exception {
@@ -260,6 +273,7 @@ public void testRemoveFirstURI() throws Exception {
 		assertEquals(2, rc.getURIs().size());
 		assertSame(b, rc.getURIs().get(0));
 		assertSame(c, rc.getURIs().get(1));
+		checkRoundTrip(rc);
 	}

 	public void testRemoveMiddleURI() throws Exception {
@@ -282,6 +296,7 @@ public void testRemoveMiddleURI() throws Exception {
 		assertEquals(2, rc.getURIs().size());
 		assertSame(a, rc.getURIs().get(0));
 		assertSame(c, rc.getURIs().get(1));
+		checkRoundTrip(rc);
 	}

 	public void testRemoveLastURI() throws Exception {
@@ -304,6 +319,7 @@ public void testRemoveLastURI() throws Exception {
 		assertEquals(2, rc.getURIs().size());
 		assertSame(a, rc.getURIs().get(0));
 		assertSame(b, rc.getURIs().get(1));
+		checkRoundTrip(rc);
 	}

 	public void testRemoveOnlyURI() throws Exception {
@@ -318,6 +334,7 @@ public void testRemoveOnlyURI() throws Exception {

 		assertTrue(rc.removeURI(a));
 		assertEquals(0, rc.getURIs().size());
+		checkRoundTrip(rc);
 	}

 	public void testCreateOrigin() throws Exception {
@@ -332,6 +349,7 @@ checkFile(new File(db.getDirectory(), "config"), "[core]\n"
 				+ "\trepositoryformatversion = 0\n" + "\tfilemode = true\n"
 				+ "[remote \"origin\"]\n" + "\turl = /some/dir\n"
 				+ "\tfetch = +refs/heads/*:refs/remotes/origin/*\n");
+		checkRoundTrip(rc);
 	}

 	public void testSaveAddURI() throws Exception {
@@ -351,6 +369,7 @@ checkFile(new File(db.getDirectory(), "config"), "[core]\n"
 				+ "\turl = http://www.spearce.org/egit.git\n"
 				+ "\turl = /some/dir\n"
 				+ "\tfetch = +refs/heads/*:refs/remotes/spearce/*\n");
+		checkRoundTrip(rc);
 	}

 	public void testSaveRemoveLastURI() throws Exception {
@@ -371,6 +390,7 @@ checkFile(new File(db.getDirectory(), "config"), "[core]\n"
 				+ "[remote \"spearce\"]\n"
 				+ "\turl = http://www.spearce.org/egit.git\n"
 				+ "\tfetch = +refs/heads/*:refs/remotes/spearce/*\n");
+		checkRoundTrip(rc);
 	}

 	public void testSaveRemoveFirstURI() throws Exception {
@@ -390,6 +410,7 @@ checkFile(new File(db.getDirectory(), "config"), "[core]\n"
 				+ "\trepositoryformatversion = 0\n" + "\tfilemode = true\n"
 				+ "[remote \"spearce\"]\n" + "\turl = /some/dir\n"
 				+ "\tfetch = +refs/heads/*:refs/remotes/spearce/*\n");
+		checkRoundTrip(rc);
 	}

 	public void testSaveNoTags() throws Exception {
@@ -406,6 +427,7 @@ checkFile(new File(db.getDirectory(), "config"), "[core]\n"
 				+ "[remote \"origin\"]\n" + "\turl = /some/dir\n"
 				+ "\tfetch = +refs/heads/*:refs/remotes/origin/*\n"
 				+ "\ttagopt = --no-tags\n");
+		checkRoundTrip(rc);
 	}

 	public void testSaveAllTags() throws Exception {
@@ -422,5 +444,40 @@ checkFile(new File(db.getDirectory(), "config"), "[core]\n"
 				+ "[remote \"origin\"]\n" + "\turl = /some/dir\n"
 				+ "\tfetch = +refs/heads/*:refs/remotes/origin/*\n"
 				+ "\ttagopt = --tags\n");
+		checkRoundTrip(rc);
+	}
+	
+	protected void checkRoundTrip(RemoteConfig rc) throws IOException,
ClassNotFoundException {
+		ByteArrayOutputStream stream = new ByteArrayOutputStream();
+		ObjectOutputStream out = new ObjectOutputStream(stream);
+		out.writeObject(rc);
+		out.close();
+
+		ObjectInputStream in = new ObjectInputStream(new ByteArrayInputStream(
+				stream.toByteArray()));
+		RemoteConfig rc2 = (RemoteConfig) in.readObject();
+		in.close();
+
+		assertEquals(rc.getName(), rc2.getName());
+		assertEquals(rc.getUploadPack(), rc2.getUploadPack());
+		assertEquals(rc.getTagOpt(), rc2.getTagOpt());
+
+		assertEquals(rc.getURIs().size(), rc2.getURIs().size());
+		assertEquals(rc.getFetchRefSpecs().size(), rc2.getFetchRefSpecs()
+				.size());
+		assertEquals(rc.getPushRefSpecs().size(), rc2.getPushRefSpecs().size());
+
+		for (URIish uri : rc.getURIs()) {
+			assertTrue (rc2.getURIs().contains(uri));
+		}
+
+		for (RefSpec refspec : rc.getFetchRefSpecs()) {
+		    assertTrue (rc2.getFetchRefSpecs().contains(refspec));
+		}
+
+		for (RefSpec refspec : rc.getPushRefSpecs()) {
+		    assertTrue (rc2.getPushRefSpecs().contains(refspec));
+		}
+
 	}
 }
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/transport/URIishTest.java
b/org.spearce.jgit.test/tst/org/spearce/jgit/transport/URIishTest.java
index 2ea9d60..beb2e88 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/transport/URIishTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/transport/URIishTest.java
@@ -38,6 +38,11 @@

 package org.spearce.jgit.transport;

+import java.io.ByteArrayInputStream;
+import java.io.ByteArrayOutputStream;
+import java.io.ObjectInputStream;
+import java.io.ObjectOutputStream;
+
 import junit.framework.TestCase;

 public class URIishTest extends TestCase {
@@ -50,6 +55,7 @@ public void testUnixFile() throws Exception {
 		assertEquals(str, u.getPath());
 		assertEquals(str, u.toString());
 		assertEquals(u, new URIish(str));
+		assertRoundTrip(u);
 	}

 	public void testWindowsFile() throws Exception {
@@ -60,6 +66,7 @@ public void testWindowsFile() throws Exception {
 		assertEquals(str, u.getPath());
 		assertEquals(str, u.toString());
 		assertEquals(u, new URIish(str));
+		assertRoundTrip(u);
 	}

 	public void testWindowsFile2() throws Exception {
@@ -70,6 +77,7 @@ public void testWindowsFile2() throws Exception {
 		assertEquals("D:/m y", u.getPath());
 		assertEquals("D:/m y", u.toString());
 		assertEquals(u, new URIish(str));
+		assertRoundTrip(u);
 	}

 	public void testUNC() throws Exception {
@@ -80,6 +88,7 @@ public void testUNC() throws Exception {
 		assertEquals("//some/place", u.getPath());
 		assertEquals("//some/place", u.toString());
 		assertEquals(u, new URIish(str));
+		assertRoundTrip(u);
 	}

 	public void testFileProtoUnix() throws Exception {
@@ -90,6 +99,7 @@ public void testFileProtoUnix() throws Exception {
 		assertEquals("/home/m y", u.getPath());
 		assertEquals(str, u.toString());
 		assertEquals(u, new URIish(str));
+		assertRoundTrip(u);
 	}

 	public void testFileProtoWindows() throws Exception {
@@ -100,6 +110,7 @@ public void testFileProtoWindows() throws Exception {
 		assertEquals("D:/m y", u.getPath());
 		assertEquals(str, u.toString());
 		assertEquals(u, new URIish(str));
+		assertRoundTrip(u);
 	}

 	public void testGitProtoUnix() throws Exception {
@@ -111,6 +122,7 @@ public void testGitProtoUnix() throws Exception {
 		assertEquals("/home/m y", u.getPath());
 		assertEquals(str, u.toString());
 		assertEquals(u, new URIish(str));
+		assertRoundTrip(u);
 	}

 	public void testGitProtoUnixPort() throws Exception {
@@ -123,6 +135,7 @@ public void testGitProtoUnixPort() throws Exception {
 		assertEquals(333, u.getPort());
 		assertEquals(str, u.toString());
 		assertEquals(u, new URIish(str));
+		assertRoundTrip(u);
 	}

 	public void testGitProtoWindowsPort() throws Exception {
@@ -135,6 +148,7 @@ public void testGitProtoWindowsPort() throws Exception {
 		assertEquals("example.com", u.getHost());
 		assertEquals(str, u.toString());
 		assertEquals(u, new URIish(str));
+		assertRoundTrip(u);
 	}

 	public void testGitProtoWindows() throws Exception {
@@ -147,6 +161,7 @@ public void testGitProtoWindows() throws Exception {
 		assertEquals(-1, u.getPort());
 		assertEquals(str, u.toString());
 		assertEquals(u, new URIish(str));
+		assertRoundTrip(u);
 	}

 	public void testScpStyleWithoutUser() throws Exception {
@@ -159,6 +174,7 @@ public void testScpStyleWithoutUser() throws Exception {
 		assertEquals(-1, u.getPort());
 		assertEquals(str, u.toString());
 		assertEquals(u, new URIish(str));
+		assertRoundTrip(u);
 	}

 	public void testScpStyleWithUser() throws Exception {
@@ -172,6 +188,7 @@ public void testScpStyleWithUser() throws Exception {
 		assertEquals(-1, u.getPort());
 		assertEquals(str, u.toString());
 		assertEquals(u, new URIish(str));
+		assertRoundTrip(u);
 	}

 	public void testGitSshProto() throws Exception {
@@ -184,6 +201,7 @@ public void testGitSshProto() throws Exception {
 		assertEquals(-1, u.getPort());
 		assertEquals(str, u.toString());
 		assertEquals(u, new URIish(str));
+		assertRoundTrip(u);
 	}

 	public void testSshGitProto() throws Exception {
@@ -196,6 +214,7 @@ public void testSshGitProto() throws Exception {
 		assertEquals(-1, u.getPort());
 		assertEquals(str, u.toString());
 		assertEquals(u, new URIish(str));
+		assertRoundTrip(u);
 	}

 	public void testSshProto() throws Exception {
@@ -208,6 +227,7 @@ public void testSshProto() throws Exception {
 		assertEquals(-1, u.getPort());
 		assertEquals(str, u.toString());
 		assertEquals(u, new URIish(str));
+		assertRoundTrip(u);
 	}

 	public void testSshProtoWithUserAndPort() throws Exception {
@@ -222,6 +242,7 @@ public void testSshProtoWithUserAndPort() throws Exception {
 		assertEquals(33, u.getPort());
 		assertEquals(str, u.toString());
 		assertEquals(u, new URIish(str));
+		assertRoundTrip(u);
 	}

 	public void testSshProtoWithUserPassAndPort() throws Exception {
@@ -237,5 +258,20 @@ public void testSshProtoWithUserPassAndPort()
throws Exception {
 		assertEquals(str, u.toPrivateString());
 		assertEquals(u.setPass(null).toPrivateString(), u.toString());
 		assertEquals(u, new URIish(str));
+		assertRoundTrip(u);
+	}
+	
+	protected void assertRoundTrip(URIish uri) throws Exception {
+		ByteArrayOutputStream stream = new ByteArrayOutputStream();
+		ObjectOutputStream out = new ObjectOutputStream(stream);
+		out.writeObject(uri);
+		out.close();
+
+		ObjectInputStream in = new ObjectInputStream(new ByteArrayInputStream(
+				stream.toByteArray()));
+		URIish uri2 = (URIish) in.readObject();
+		in.close();
+		
+		assert(uri2.equals(uri));
 	}
 }
-- 
1.6.0.2

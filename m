From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: JGit cache bug
Date: Sat, 18 Apr 2009 19:05:54 +0200
Message-ID: <200904181905.55119.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_zhg6JX0ctQqtTxy"
To: spearce@spearce.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 18 19:07:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvE13-0007Ca-Nb
	for gcvg-git-2@gmane.org; Sat, 18 Apr 2009 19:07:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756954AbZDRRGK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Apr 2009 13:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756129AbZDRRGJ
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Apr 2009 13:06:09 -0400
Received: from mail.dewire.com ([83.140.172.130]:15571 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753951AbZDRRGG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Apr 2009 13:06:06 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id B1BC3802E06;
	Sat, 18 Apr 2009 19:05:58 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yfr6f-mmViyN; Sat, 18 Apr 2009 19:05:57 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id C62438026F8;
	Sat, 18 Apr 2009 19:05:56 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.27-14-generic; KDE/4.2.2; i686; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116851>

--Boundary-00=_zhg6JX0ctQqtTxy
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This is fun... ~

I cannot figure why things don't work with Patch #4? We are not
even multithreaded.

This is related to trying to fix http://code.google.com/p/egit/issues/detail?id=79 which is related to all
sorts of NPE problems that may occur in Eclipse when working with
EGit and C/msysgit in parallell.

Platform info:

# java version
java version "1.6.0_0"
IcedTea6 1.3.1 (6b12-0ubuntu6.4) Runtime Environment (build 1.6.0_0-b12)
OpenJDK Server VM (build 1.6.0_0-b12, mixed mode)

# uname -a
Linux sleipner 2.6.27-14-generic #1 SMP Wed Apr 15 18:59:16 UTC 2009 i686 GNU/Linux

I've tried to insert GC and sleep calls.

-- robin

--Boundary-00=_zhg6JX0ctQqtTxy
Content-Type: text/x-patch;
  charset="UTF-8";
  name="0001-Rescan-for-packs-once-when-failing-to-lookup-an-id.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-Rescan-for-packs-once-when-failing-to-lookup-an-id.patch"

=46rom c557d6900d4952f5bee0d8dcab82a1730ba549eb Mon Sep 17 00:00:00 2001
=46rom: Robin Rosenberg <robin.rosenberg@dewire.com>
Date: Fri, 17 Apr 2009 09:34:39 +0200
Subject: [EGIT PATCH 1/4] Rescan for packs once when failing to lookup an i=
d.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
=2D--
 .../src/org/spearce/jgit/lib/Repository.java       |   31 ++++++++++++++--=
=2D--
 1 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/or=
g.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index cfd92b8..8ff3b63 100644
=2D-- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -291,6 +291,21 @@ public ObjectLoader openObject(final AnyObjectId id)
 	 */
 	public ObjectLoader openObject(final WindowCursor curs, final AnyObjectId=
 id)
 			throws IOException {
+		ObjectLoader loader =3D openObjectInPacks(curs, id);
+		if (loader !=3D null)
+			return loader;
+		try {
+			return new UnpackedObjectLoader(this, id);
+		} catch (FileNotFoundException fnfe) {
+			System.out.println(new java.util.Date().toString() + ": failed to load =
" + id + ", rescanning for new packs");
+			if (scanForPacks())
+				return openObjectInPacks(curs, id);
+			return null;
+		}
+	}
+
+	private ObjectLoader openObjectInPacks(final WindowCursor curs, final Any=
ObjectId id)
+			throws IOException {
 		final PackFile[] packs =3D packs();
 		int k =3D packs.length;
 		while (k > 0) {
@@ -298,11 +313,7 @@ public ObjectLoader openObject(final WindowCursor curs=
, final AnyObjectId id)
 			if (ol !=3D null)
 				return ol;
 		}
=2D		try {
=2D			return new UnpackedObjectLoader(this, id);
=2D		} catch (FileNotFoundException fnfe) {
=2D			return null;
=2D		}
+		return null;
 	}
=20
 	/**
@@ -813,10 +824,11 @@ synchronized (this) {
 	}
=20
 	/**
=2D	 * Scan the object dirs, including alternates for packs
=2D	 * to use.
+	 * Scan the object dirs, including alternates for packs to use.
+	 *=20
+	 * @return true if new packs were found
 	 */
=2D	public void scanForPacks() {
+	public boolean scanForPacks() {
 		final ArrayList<PackFile> p =3D new ArrayList<PackFile>();
 		p.addAll(Arrays.asList(packs()));
 		for (final File d : objectsDirs())
@@ -824,9 +836,11 @@ public void scanForPacks() {
 		final PackFile[] arr =3D new PackFile[p.size()];
 		p.toArray(arr);
 		Arrays.sort(arr, PackFile.SORT);
+		boolean ret =3D packFileList.length !=3D arr.length;
 		synchronized (this) {
 			packFileList =3D arr;
 		}
+		return ret;
 	}
=20
 	private void scanForPacks(final File packDir, Collection<PackFile> packLi=
st) {
@@ -1200,5 +1214,6 @@ synchronized (allListeners) {
 	public void scanForRepoChanges() throws IOException {
 		getAllRefs(); // This will look for changes to refs
 		getIndex(); // This will detect changes in the index
+		scanForPacks(); // This will detect new packs
 	}
 }
=2D-=20
1.6.2.2.446.gfbdc0


--Boundary-00=_zhg6JX0ctQqtTxy
Content-Type: text/x-patch;
  charset="UTF-8";
  name="0002-Add-test-cases-dedicated-to-the-WindowCache.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0002-Add-test-cases-dedicated-to-the-WindowCache.patch"

=46rom 92d37694970963ad6d0d5fbf4ec811630a58df90 Mon Sep 17 00:00:00 2001
=46rom: Robin Rosenberg <robin.rosenberg@dewire.com>
Date: Sat, 18 Apr 2009 16:15:28 +0200
Subject: [EGIT PATCH 2/4] Add test cases dedicated to the WindowCache

=2D--
 .../tst/org/spearce/jgit/lib/WindowCacheTest.java  |   72 ++++++++++++++++=
++++
 1 files changed, 72 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/lib/WindowCa=
cheTest.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/WindowCacheTest=
=2Ejava b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/WindowCacheTest.ja=
va
new file mode 100644
index 0000000..a438d46
=2D-- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/WindowCacheTest.java
@@ -0,0 +1,72 @@
+package org.spearce.jgit.lib;
+
+import java.io.ByteArrayInputStream;
+import java.io.File;
+import java.io.FileOutputStream;
+import java.io.IOException;
+
+import org.spearce.jgit.errors.IncorrectObjectTypeException;
+import org.spearce.jgit.errors.MissingObjectException;
+import org.spearce.jgit.revwalk.RevObject;
+import org.spearce.jgit.revwalk.RevWalk;
+
+public class WindowCacheTest extends RepositoryTestCase {
+
+	public void setUp() throws Exception {
+		WindowCacheConfig windowCacheConfig =3D new WindowCacheConfig();
+		windowCacheConfig.setPackedGitOpenFiles(1);
+		WindowCache.reconfigure(windowCacheConfig);
+		super.setUp();
+	}
+
+	protected void tearDown() throws Exception {
+		super.tearDown();
+		WindowCacheConfig windowCacheConfig =3D new WindowCacheConfig();
+		WindowCache.reconfigure(windowCacheConfig);
+	}
+
+	/*
+	 * Add pack, find objects in new pack Replace packs, find objects in anot=
her
+	 * pack than original, don't choke on lost pack
+	 */
+	public void testObjectInNewPack() throws IncorrectObjectTypeException,
+			IOException {
+		Repository extra =3D createNewEmptyRepo();
+		RevObject o1 =3D writeBlob(extra, db,
+				"nihuioijoisuoiudyosyudoiuyusyuoiyewData");
+		PackWriter packWriter =3D new PackWriter(extra, new TextProgressMonitor(=
));
+		packWriter.addObject(o1);
+		ObjectId name =3D packWriter.computeName();
+		File packFileName =3D fullPackFileName(db, name, ".pack");
+		FileOutputStream pos =3D new FileOutputStream(packFileName);
+		packWriter.writePack(pos);
+		pos.close();
+		File idxfname =3D fullPackFileName(db, name, ".idx");
+		FileOutputStream ios =3D new FileOutputStream(idxfname);
+		packWriter.writeIndex(ios);
+		ios.close();
+		assertEquals(o1.name(), new RevWalk(db).parseAny(o1).name());
+	}
+
+	private File fullPackFileName(Repository repository, ObjectId hash,
+			String suffix) {
+		return new File(new File(repository.getObjectsDirectory(), "pack"),
+				"pack-" + hash.name() + suffix);
+	}
+
+	private RevObject writeBlob(final Repository repo, final Repository notIn,
+			final String data) throws IOException {
+		RevWalk revWalk =3D new RevWalk(repo);
+		byte[] bytes =3D data.getBytes(Constants.CHARACTER_ENCODING);
+		ObjectId id =3D new ObjectWriter(repo).writeBlob(bytes.length,
+				new ByteArrayInputStream(bytes));
+		try {
+			assertNull(
+					"Oops, We want new objects that we do not have yet, for this test!",
+					new RevWalk(notIn).parseAny(id));
+		} catch (MissingObjectException e) {
+			// Ok
+		}
+		return revWalk.lookupBlob(id);
+	}
+}
=2D-=20
1.6.2.2.446.gfbdc0


--Boundary-00=_zhg6JX0ctQqtTxy
Content-Type: text/x-patch;
  charset="UTF-8";
  name="0003-Fails-like-this-in-the-debugger-expected-but-runs-ok.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0003-Fails-like-this-in-the-debugger-expected-but-runs-ok.patch"

=46rom 81f9174ebf605030ea95d18bb81dc1ece98bf290 Mon Sep 17 00:00:00 2001
=46rom: Robin Rosenberg <robin.rosenberg@dewire.com>
Date: Sat, 18 Apr 2009 18:29:23 +0200
Subject: [EGIT PATCH 3/4] Fails like this in the debugger (expected), but r=
uns ok outside the debugger.

Breakpoints in the following places. Wait a second or two everytime it stops

WindowCacheTest [line: 101] - testObjectMovedToNewPack()
WindowedFile [line: 283] - cacheOpen()
WindowedFile [line: 301] - cacheClose()

java.io.FileNotFoundException: /home/me/SW/EGIT/org.spearce.jgit.test/trash=
/trash1240071609317.0/.git/objects/pack/pack-fc4dadd6673a2740f43468f868ba5d=
d39fdeba69.pack (Filen eller katalogen finns inte)
	at java.io.RandomAccessFile.open(Native Method)
	at java.io.RandomAccessFile.<init>(RandomAccessFile.java:212)
	at org.spearce.jgit.lib.WindowedFile.cacheOpen(WindowedFile.java:283)
	at org.spearce.jgit.lib.WindowCache.getImpl(WindowCache.java:249)
	at org.spearce.jgit.lib.WindowCache.get(WindowCache.java:222)
	at org.spearce.jgit.lib.WindowCursor.pin(WindowCursor.java:148)
	at org.spearce.jgit.lib.WindowCursor.copy(WindowCursor.java:82)
	at org.spearce.jgit.lib.WindowedFile.read(WindowedFile.java:176)
	at org.spearce.jgit.lib.WindowedFile.readFully(WindowedFile.java:203)
	at org.spearce.jgit.lib.PackFile.reader(PackFile.java:311)
	at org.spearce.jgit.lib.PackFile.get(PackFile.java:147)
	at org.spearce.jgit.lib.Repository.openObjectInPacks(Repository.java:312)
	at org.spearce.jgit.lib.Repository.openObject(Repository.java:294)
	at org.spearce.jgit.revwalk.RevWalk.parseAny(RevWalk.java:702)
	at org.spearce.jgit.lib.WindowCacheTest.testObjectMovedToNewPack(WindowCac=
heTest.java:115)
	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.ja=
va:39)
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccesso=
rImpl.java:25)
	at java.lang.reflect.Method.invoke(Method.java:597)
	at junit.framework.TestCase.runTest(TestCase.java:164)
	at junit.framework.TestCase.runBare(TestCase.java:130)
	at junit.framework.TestResult$1.protect(TestResult.java:106)
	at junit.framework.TestResult.runProtected(TestResult.java:124)
	at junit.framework.TestResult.run(TestResult.java:109)
	at junit.framework.TestCase.run(TestCase.java:120)
	at org.eclipse.jdt.internal.junit.runner.junit3.JUnit3TestReference.run(JU=
nit3TestReference.java:130)
	at org.eclipse.jdt.internal.junit.runner.TestExecution.run(TestExecution.j=
ava:38)
	at org.eclipse.jdt.internal.junit.runner.RemoteTestRunner.runTests(RemoteT=
estRunner.java:460)
	at org.eclipse.jdt.internal.junit.runner.RemoteTestRunner.runTests(RemoteT=
estRunner.java:673)
	at org.eclipse.jdt.internal.junit.runner.RemoteTestRunner.run(RemoteTestRu=
nner.java:386)
	at org.eclipse.jdt.internal.junit.runner.RemoteTestRunner.main(RemoteTestR=
unner.java:196)
=2D--
 .../tst/org/spearce/jgit/lib/WindowCacheTest.java  |   53 ++++++++++++++++=
++++
 1 files changed, 53 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/WindowCacheTest=
=2Ejava b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/WindowCacheTest.ja=
va
index a438d46..0cd55c9 100644
=2D-- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/WindowCacheTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/WindowCacheTest.java
@@ -48,6 +48,59 @@ public void testObjectInNewPack() throws IncorrectObject=
TypeException,
 		assertEquals(o1.name(), new RevWalk(db).parseAny(o1).name());
 	}
=20
+	/*
+	 * Add pack, find objects in new pack Replace packs, find objects in anot=
her
+	 * pack than original, don't choke on lost pack
+	 */
+	public void testObjectMovedToNewPack() throws IncorrectObjectTypeExceptio=
n,
+			IOException {
+		Repository extra =3D createNewEmptyRepo();
+		RevObject o1 =3D writeBlob(extra, db,
+				"nihuioijoisuoiudyosyudoiuyusyuoiyewData1");
+		PackWriter packWriter1 =3D new PackWriter(extra,
+				new TextProgressMonitor());
+		packWriter1.addObject(o1);
+		ObjectId name1 =3D packWriter1.computeName();
+		File packFileName1 =3D fullPackFileName(db, name1, ".pack");
+		FileOutputStream pos1 =3D new FileOutputStream(packFileName1);
+		packWriter1.writePack(pos1);
+		pos1.close();
+		File idxfname1 =3D fullPackFileName(db, name1, ".idx");
+		FileOutputStream ios1 =3D new FileOutputStream(idxfname1);
+		packWriter1.writeIndex(ios1);
+		ios1.close();
+		assertEquals(o1.name(), new RevWalk(db).parseAny(o1).name());
+
+		// Ok, lets repack this repo
+		// create an additional object
+		RevObject o2 =3D writeBlob(extra, db,
+				"nihuioijoisuoiudyosyudoiuyusyuoiyewData2");
+		PackWriter packWriter2 =3D new PackWriter(extra,
+				new TextProgressMonitor());
+		packWriter2.addObject(o1);
+		packWriter2.addObject(o2);
+		ObjectId name2 =3D packWriter2.computeName();
+		File packFileName2 =3D fullPackFileName(db, name2, ".pack");
+		FileOutputStream pos2 =3D new FileOutputStream(packFileName2);
+		packWriter2.writePack(pos2);
+		pos2.close();
+		File idxfname2 =3D fullPackFileName(db, name2, ".idx");
+		FileOutputStream ios2 =3D new FileOutputStream(idxfname2);
+		packWriter2.writeIndex(ios2);
+		ios2.close();
+		assertEquals(o2.name(), new RevWalk(db).parseAny(o2).name());
+
+		WindowCacheConfig windowCacheConfig =3D new WindowCacheConfig();
+		windowCacheConfig.setPackedGitOpenFiles(1);
+		WindowCache.reconfigure(windowCacheConfig);
+		packFileName1.delete();
+		idxfname1.delete();
+
+		// Now here is the interesting thing. Will git figure the new
+		// object exists in the new pack, and not the old one.
+		assertEquals(o1.name(), new RevWalk(db).parseAny(o1).name());
+	}
+
 	private File fullPackFileName(Repository repository, ObjectId hash,
 			String suffix) {
 		return new File(new File(repository.getObjectsDirectory(), "pack"),
=2D-=20
1.6.2.2.446.gfbdc0


--Boundary-00=_zhg6JX0ctQqtTxy
Content-Type: text/x-patch;
  charset="UTF-8";
  name="0004-Simulate-breakpoints.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0004-Simulate-breakpoints.patch"

=46rom 44638f9060d845a208638ac75d392a168b87c0df Mon Sep 17 00:00:00 2001
=46rom: Robin Rosenberg <robin.rosenberg@dewire.com>
Date: Sat, 18 Apr 2009 19:00:32 +0200
Subject: [EGIT PATCH 4/4] Simulate breakpoints

=2D--
 .../tst/org/spearce/jgit/lib/WindowCacheTest.java  |    7 +++++++
 .../src/org/spearce/jgit/lib/WindowedFile.java     |    7 +++++++
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/WindowCacheTest=
=2Ejava b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/WindowCacheTest.ja=
va
index 0cd55c9..eba1aed 100644
=2D-- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/WindowCacheTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/WindowCacheTest.java
@@ -98,6 +98,13 @@ public void testObjectMovedToNewPack() throws IncorrectO=
bjectTypeException,
=20
 		// Now here is the interesting thing. Will git figure the new
 		// object exists in the new pack, and not the old one.
+		try {
+			Thread.sleep(2000);
+		} catch (InterruptedException e) {
+			// TODO Auto-generated catch block
+			e.printStackTrace();
+		}
+		System.gc();
 		assertEquals(o1.name(), new RevWalk(db).parseAny(o1).name());
 	}
=20
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowedFile.java b/=
org.spearce.jgit/src/org/spearce/jgit/lib/WindowedFile.java
index 938f44c..f7377d1 100644
=2D-- a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowedFile.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowedFile.java
@@ -280,6 +280,13 @@ public void close() {
 	}
=20
 	void cacheOpen() throws IOException {
+		try {
+			Thread.sleep(2000);
+		} catch (InterruptedException e) {
+			// TODO Auto-generated catch block
+			e.printStackTrace();
+		}
+		System.gc();
 		fd =3D new RandomAccessFile(fPath, "r");
 		length =3D fd.length();
 		try {
=2D-=20
1.6.2.2.446.gfbdc0


--Boundary-00=_zhg6JX0ctQqtTxy--

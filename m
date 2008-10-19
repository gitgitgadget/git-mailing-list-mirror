From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH v2] Encode/decode index and tree entries using UTF-8
Date: Sun, 19 Oct 2008 20:24:24 +0200
Message-ID: <200810192024.24466.robin.rosenberg.lists@dewire.com>
References: <200810191529.43439.robin.rosenberg.lists@dewire.com> <20081019171456.GC14786@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Oct 20 13:02:18 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrczK-0005QB-Qs
	for gcvg-git-2@gmane.org; Sun, 19 Oct 2008 20:26:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751585AbYJSSYe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 Oct 2008 14:24:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751535AbYJSSYe
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Oct 2008 14:24:34 -0400
Received: from av12-1-sn2.hy.skanova.net ([81.228.8.185]:54552 "EHLO
	av12-1-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751518AbYJSSYd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Oct 2008 14:24:33 -0400
Received: by av12-1-sn2.hy.skanova.net (Postfix, from userid 502)
	id 90D4D37FA4; Sun, 19 Oct 2008 20:24:30 +0200 (CEST)
Received: from smtp4-2-sn2.hy.skanova.net (smtp4-2-sn2.hy.skanova.net [81.228.8.93])
	by av12-1-sn2.hy.skanova.net (Postfix) with ESMTP
	id 79EE037F75; Sun, 19 Oct 2008 20:24:30 +0200 (CEST)
Received: from sleipner.dewire.com (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp4-2-sn2.hy.skanova.net (Postfix) with ESMTP id 4579737E4C;
	Sun, 19 Oct 2008 20:24:30 +0200 (CEST)
Received: from dewire.com (unknown [10.9.0.1])
	by sleipner.dewire.com (Postfix) with ESMTP id BD546B08;
	Sun, 19 Oct 2008 20:24:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id D9CF5147EAC3;
	Sun, 19 Oct 2008 20:24:29 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mOcCiL90FYTG; Sun, 19 Oct 2008 20:24:28 +0200 (CEST)
Received: from [10.9.0.4] (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 3A042800250;
	Sun, 19 Oct 2008 20:24:28 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <20081019171456.GC14786@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98652>

Decoding uses the same strategy as for commit messages and other string
entities. Encoding is always done in UTF-8. This is incompatible with
Git for non-unicode unices, but it leads to the expected behavior on
Windows and cross-locale sharing of repositories.

Signed-off-by: Robin Rosenberg <robin.rosnberg@dewire.com>
---

s=F6ndagen den 19 oktober 2008 19.14.56 skrev Shawn O. Pearce:
> Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> > Decoding uses the same strategy as for commit messages and other st=
ring
> > entities. Encoding is always done in UTF-8. This is incompatible wi=
th
> > Git for non-unicode unices, but it leads to the expected behavior o=
n
> > Windows and cross-locale sharing of repositories.
>=20
> FWIW I think this is a good idea.

Ok, so here's the update.  We might want to move the encode out of Cons=
tants
too as it is no longer a utility for constants.

-- robin

 .../src/org/spearce/jgit/lib/GitIndex.java         |   27 ++++++++----=
----
 .../src/org/spearce/jgit/lib/Tree.java             |   16 ++++-----
 .../src/org/spearce/jgit/lib/TreeEntry.java        |   14 +++-----
 .../src/org/spearce/jgit/util/RawParseUtils.java   |   32 ++++++++++++=
++++++++
 4 files changed, 58 insertions(+), 31 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/GitIndex.java b/=
org.spearce.jgit/src/org/spearce/jgit/lib/GitIndex.java
index 22935ab..bafddef 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/GitIndex.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/GitIndex.java
@@ -63,6 +63,7 @@
 import org.spearce.jgit.errors.CorruptObjectException;
 import org.spearce.jgit.errors.NotSupportedException;
 import org.spearce.jgit.util.FS;
+import org.spearce.jgit.util.RawParseUtils;
=20
 /**
  * A representation of the Git index.
@@ -178,8 +179,9 @@ public Entry add(File wd, File f) throws IOExceptio=
n {
 	 * @param f
 	 *            the file whose path shall be removed.
 	 * @return true if such a path was found (and thus removed)
+	 * @throws IOException=20
 	 */
-	public boolean remove(File wd, File f) {
+	public boolean remove(File wd, File f) throws IOException {
 		byte[] key =3D makeKey(wd, f);
 		return entries.remove(key) !=3D null;
 	}
@@ -300,11 +302,11 @@ static boolean File_hasExecute() {
 		return FS.INSTANCE.supportsExecute();
 	}
=20
-	static byte[] makeKey(File wd, File f) {
+	static byte[] makeKey(File wd, File f) throws IOException {
 		if (!f.getPath().startsWith(wd.getPath()))
 			throw new Error("Path is not in working dir");
 		String relName =3D Repository.stripWorkDir(wd, f);
-		return relName.getBytes();
+		return Constants.encode(relName);
 	}
=20
 	Boolean filemode;
@@ -376,7 +378,7 @@ Entry(TreeEntry f, int stage)
 				size =3D -1;
 			}
 			sha1 =3D f.getId();
-			name =3D f.getFullName().getBytes("UTF-8");
+			name =3D Constants.encode(f.getFullName());
 			flags =3D (short) ((stage << 12) | name.length); // TODO: fix flags
 		}
=20
@@ -580,7 +582,7 @@ private File getFile(File wd) {
 		}
=20
 		public String toString() {
-			return new String(name) + "/SHA-1(" + sha1.name() + ")/M:"
+			return getName() + "/SHA-1(" + sha1.name() + ")/M:"
 					+ new Date(ctime / 1000000L) + "/C:"
 					+ new Date(mtime / 1000000L) + "/d" + dev + "/i" + ino
 					+ "/m" + Integer.toString(mode, 8) + "/u" + uid + "/g"
@@ -591,7 +593,7 @@ public String toString() {
 		 * @return path name for this entry
 		 */
 		public String getName() {
-			return new String(name);
+			return RawParseUtils.decode(name);
 		}
=20
 		/**
@@ -731,7 +733,7 @@ void readTree(String prefix, Tree t) throws IOExcep=
tion {
 				readTree(name, (Tree) te);
 			} else {
 				Entry e =3D new Entry(te, 0);
-				entries.put(name.getBytes("UTF-8"), e);
+				entries.put(Constants.encode(name), e);
 			}
 		}
 	}
@@ -743,7 +745,7 @@ void readTree(String prefix, Tree t) throws IOExcep=
tion {
 	 * @throws IOException
 	 */
 	public Entry addEntry(TreeEntry te) throws IOException {
-		byte[] key =3D te.getFullName().getBytes("UTF-8");
+		byte[] key =3D Constants.encode(te.getFullName());
 		Entry e =3D new Entry(te, 0);
 		entries.put(key, e);
 		return e;
@@ -824,8 +826,7 @@ public ObjectId writeTree() throws IOException {
 			}
 			while (trees.size() < newName.length) {
 				if (!current.existsTree(newName[trees.size() - 1])) {
-					current =3D new Tree(current, newName[trees.size() - 1]
-							.getBytes());
+					current =3D new Tree(current, Constants.encode(newName[trees.size=
() - 1]));
 					current.getParent().addEntry(current);
 					trees.push(current);
 				} else {
@@ -835,7 +836,7 @@ public ObjectId writeTree() throws IOException {
 				}
 			}
 			FileTreeEntry ne =3D new FileTreeEntry(current, e.sha1,
-					newName[newName.length - 1].getBytes(),
+					Constants.encode(newName[newName.length - 1]),
 					(e.mode & FileMode.EXECUTABLE_FILE.getBits()) =3D=3D FileMode.EXE=
CUTABLE_FILE.getBits());
 			current.addEntry(ne);
 		}
@@ -880,7 +881,7 @@ int longestCommonPath(String[] a, String[] b) {
 	 * Small beware: Unaccounted for are unmerged entries. You may want
 	 * to abort if members with stage !=3D 0 are found if you are doing
 	 * any updating operations. All stages will be found after one anothe=
r
-	 * here later. Currently only one stage per name is returned.
+	 * here later. Currently only one stage per name is returned.=09
 	 *
 	 * @return The index entries sorted
 	 */
@@ -896,7 +897,7 @@ int longestCommonPath(String[] a, String[] b) {
 	 * @throws UnsupportedEncodingException
 	 */
 	public Entry getEntry(String path) throws UnsupportedEncodingExceptio=
n {
-		return (Entry) entries.get(Repository.gitInternalSlash(path.getBytes=
("ISO-8859-1")));
+		return (Entry) entries.get(Repository.gitInternalSlash(Constants.enc=
ode(path)));
 	}
=20
 	/**
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Tree.java b/org.=
spearce.jgit/src/org/spearce/jgit/lib/Tree.java
index 25a9a71..0ecd04d 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Tree.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Tree.java
@@ -44,6 +44,7 @@
 import org.spearce.jgit.errors.CorruptObjectException;
 import org.spearce.jgit.errors.EntryExistsException;
 import org.spearce.jgit.errors.MissingObjectException;
+import org.spearce.jgit.util.RawParseUtils;
=20
 /**
  * A representation of a Git tree entry. A Tree is a directory in Git.
@@ -251,7 +252,7 @@ public void unload() {
 	 * @throws IOException
 	 */
 	public FileTreeEntry addFile(final String name) throws IOException {
-		return addFile(Repository.gitInternalSlash(name.getBytes(Constants.C=
HARACTER_ENCODING)), 0);
+		return addFile(Repository.gitInternalSlash(Constants.encode(name)), =
0);
 	}
=20
 	/**
@@ -281,8 +282,7 @@ public FileTreeEntry addFile(final byte[] s, final =
int offset)
=20
 		final byte[] newName =3D substring(s, offset, slash);
 		if (p >=3D 0)
-			throw new EntryExistsException(new String(newName,
-					Constants.CHARACTER_ENCODING));
+			throw new EntryExistsException(RawParseUtils.decode(newName));
 		else if (slash < s.length) {
 			final Tree t =3D new Tree(this, newName);
 			insertEntry(p, t);
@@ -304,7 +304,7 @@ else if (slash < s.length) {
 	 * @throws IOException
 	 */
 	public Tree addTree(final String name) throws IOException {
-		return addTree(Repository.gitInternalSlash(name.getBytes(Constants.C=
HARACTER_ENCODING)), 0);
+		return addTree(Repository.gitInternalSlash(Constants.encode(name)), =
0);
 	}
=20
 	/**
@@ -332,8 +332,7 @@ public Tree addTree(final byte[] s, final int offse=
t) throws IOException {
=20
 		final byte[] newName =3D substring(s, offset, slash);
 		if (p >=3D 0)
-			throw new EntryExistsException(new String(newName,
-					Constants.CHARACTER_ENCODING));
+			throw new EntryExistsException(RawParseUtils.decode(newName));
=20
 		final Tree t =3D new Tree(this, newName);
 		insertEntry(p, t);
@@ -355,8 +354,7 @@ public void addEntry(final TreeEntry e) throws IOEx=
ception {
 			e.attachParent(this);
 			insertEntry(p, e);
 		} else {
-			throw new EntryExistsException(new String(e.getNameUTF8(),
-					Constants.CHARACTER_ENCODING));
+			throw new EntryExistsException(e.getName());
 		}
 	}
=20
@@ -450,7 +448,7 @@ public boolean existsBlob(String path) throws IOExc=
eption {
 	}
=20
 	private TreeEntry findMember(final String s, byte slast) throws IOExc=
eption {
-		return findMember(Repository.gitInternalSlash(s.getBytes(Constants.C=
HARACTER_ENCODING)), slast, 0);
+		return findMember(Repository.gitInternalSlash(Constants.encode(s)), =
slast, 0);
 	}
=20
 	private TreeEntry findMember(final byte[] s, final byte slast, final =
int offset)
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/TreeEntry.java b=
/org.spearce.jgit/src/org/spearce/jgit/lib/TreeEntry.java
index 85dda1d..c95863c 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/TreeEntry.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/TreeEntry.java
@@ -39,9 +39,9 @@
 package org.spearce.jgit.lib;
=20
 import java.io.IOException;
-import java.io.UnsupportedEncodingException;
=20
 import org.spearce.jgit.lib.GitIndex.Entry;
+import org.spearce.jgit.util.RawParseUtils;
=20
 /**
  * This class represents an entry in a tree, like a blob or another tr=
ee.
@@ -126,13 +126,9 @@ public Repository getRepository() {
 	 * @return the name of this entry.
 	 */
 	public String getName() {
-		try {
-			return nameUTF8 !=3D null ? new String(nameUTF8,
-					Constants.CHARACTER_ENCODING) : null;
-		} catch (UnsupportedEncodingException uee) {
-			throw new RuntimeException("JVM doesn't support "
-					+ Constants.CHARACTER_ENCODING, uee);
-		}
+		if (nameUTF8 !=3D null)
+			return RawParseUtils.decode(nameUTF8);
+		return null;
 	}
=20
 	/**
@@ -142,7 +138,7 @@ public String getName() {
 	 * @throws IOException
 	 */
 	public void rename(final String n) throws IOException {
-		rename(n.getBytes(Constants.CHARACTER_ENCODING));
+		rename(Constants.encode(n));
 	}
=20
 	/**
diff --git a/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.j=
ava b/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java
index 6c0e339..4b96439 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java
@@ -379,6 +379,38 @@ public static PersonIdent parsePersonIdent(final b=
yte[] raw, final int nameB) {
 	}
=20
 	/**
+	 * Decode a buffer under UTF-8, if possible.
+	 *
+	 * If the byte stream cannot be decoded that way, the platform defaul=
t is tried
+	 * and if that too fails, the fail-safe ISO-8859-1 encoding is tried.
+	 *=20
+	 * @param buffer
+	 *            buffer to pull raw bytes from.
+	 * @return a string representation of the range <code>[start,end)</co=
de>,
+	 *         after decoding the region through the specified character =
set.
+	 */
+	public static String decode(final byte[] buffer) {
+		return decode(Constants.CHARSET, buffer, 0, buffer.length);
+	}
+
+	/**
+	 * Decode a buffer under the specified character set if possible.
+	 *
+	 * If the byte stream cannot be decoded that way, the platform defaul=
t is tried
+	 * and if that too fails, the fail-safe ISO-8859-1 encoding is tried.
+	 *=20
+	 * @param cs
+	 *            character set to use when decoding the buffer.
+	 * @param buffer
+	 *            buffer to pull raw bytes from.
+	 * @return a string representation of the range <code>[start,end)</co=
de>,
+	 *         after decoding the region through the specified character =
set.
+	 */
+	public static String decode(final Charset cs, final byte[] buffer) {
+		return decode(cs, buffer, 0, buffer.length);
+	}
+
+	/**
 	 * Decode a region of the buffer under the specified character set if=
 possible.
 	 *
 	 * If the byte stream cannot be decoded that way, the platform defaul=
t is tried
--=20
1.6.0.2.308.gef4a

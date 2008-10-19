From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: [JGIT PATCH] Encode/decode index and tree entries using UTF-8
Date: Sun, 19 Oct 2008 15:29:43 +0200
Message-ID: <200810191529.43439.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Mon Oct 20 06:54:57 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrYP3-0004D8-U9
	for gcvg-git-2@gmane.org; Sun, 19 Oct 2008 15:33:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbYJSN3w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Oct 2008 09:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751273AbYJSN3w
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Oct 2008 09:29:52 -0400
Received: from av10-2-sn2.hy.skanova.net ([81.228.8.182]:55913 "EHLO
	av10-2-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751281AbYJSN3u (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Oct 2008 09:29:50 -0400
Received: by av10-2-sn2.hy.skanova.net (Postfix, from userid 502)
	id 29ADD37F6E; Sun, 19 Oct 2008 15:29:48 +0200 (CEST)
Received: from smtp4-1-sn2.hy.skanova.net (smtp4-1-sn2.hy.skanova.net [81.228.8.92])
	by av10-2-sn2.hy.skanova.net (Postfix) with ESMTP
	id 093AF37F6E; Sun, 19 Oct 2008 15:29:48 +0200 (CEST)
Received: from sleipner.dewire.com (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp4-1-sn2.hy.skanova.net (Postfix) with ESMTP id CD39F37E45;
	Sun, 19 Oct 2008 15:29:47 +0200 (CEST)
Received: from dewire.com (unknown [10.9.0.1])
	by sleipner.dewire.com (Postfix) with ESMTP id 687F15AC;
	Sun, 19 Oct 2008 15:29:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 51F58147EAC6;
	Sun, 19 Oct 2008 15:29:47 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XfjaF18IZevn; Sun, 19 Oct 2008 15:29:46 +0200 (CEST)
Received: from [10.9.0.4] (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 11AD8147EAC5;
	Sun, 19 Oct 2008 15:29:46 +0200 (CEST)
User-Agent: KMail/1.9.10
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98611>

Decoding uses the same strategy as for commit messages and other string
entities. Encoding is always done in UTF-8. This is incompatible with
Git for non-unicode unices, but it leads to the expected behavior on
Windows and cross-locale sharing of repositories.

Signed-off-by: Robin Rosenberg <robin.rosnberg@dewire.com>
---

Inpired by the recent thread on the gitml, I decideed to clean up jgit a little. I
know the GitIndex is soon to be obsoleted, but it it still the class that does
the dirty work when committing in Egit and the changes are fairly simple
anyway.

- Unicode paths will work on all platforms that support unicode, i.e. Windows
and any unix using a UTF-8 locale, with one small exception. Accented characters
on OS-X probably do not work well.
- Combined use of unicode on one platform is compatible with non-unicode locales
on other platforms as long as the characters in use are available in the local character
set.

A side note, invalid byte sequences in unix, e.g. ISO-latin-1 encoded file names cannot
work in Java. Such files are inaccessible. Jgit will allow you to rename them in the index,
but that is all.

-- robin

 .../src/org/spearce/jgit/lib/GitIndex.java         |   27 +++++++++++---------
 .../src/org/spearce/jgit/lib/Tree.java             |   11 +++----
 .../src/org/spearce/jgit/lib/TreeEntry.java        |   13 +++------
 3 files changed, 25 insertions(+), 26 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/GitIndex.java b/org.spearce.jgit/src/org/spearce/jgit/lib/GitIndex.java
index 22935ab..3d37033 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/GitIndex.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/GitIndex.java
@@ -63,6 +63,7 @@
 import org.spearce.jgit.errors.CorruptObjectException;
 import org.spearce.jgit.errors.NotSupportedException;
 import org.spearce.jgit.util.FS;
+import org.spearce.jgit.util.RawParseUtils;
 
 /**
  * A representation of the Git index.
@@ -178,8 +179,9 @@ public Entry add(File wd, File f) throws IOException {
 	 * @param f
 	 *            the file whose path shall be removed.
 	 * @return true if such a path was found (and thus removed)
+	 * @throws IOException 
 	 */
-	public boolean remove(File wd, File f) {
+	public boolean remove(File wd, File f) throws IOException {
 		byte[] key = makeKey(wd, f);
 		return entries.remove(key) != null;
 	}
@@ -300,11 +302,11 @@ static boolean File_hasExecute() {
 		return FS.INSTANCE.supportsExecute();
 	}
 
-	static byte[] makeKey(File wd, File f) {
+	static byte[] makeKey(File wd, File f) throws IOException {
 		if (!f.getPath().startsWith(wd.getPath()))
 			throw new Error("Path is not in working dir");
 		String relName = Repository.stripWorkDir(wd, f);
-		return relName.getBytes();
+		return relName.getBytes(Constants.CHARACTER_ENCODING);
 	}
 
 	Boolean filemode;
@@ -376,7 +378,7 @@ Entry(TreeEntry f, int stage)
 				size = -1;
 			}
 			sha1 = f.getId();
-			name = f.getFullName().getBytes("UTF-8");
+			name = f.getFullName().getBytes(Constants.CHARACTER_ENCODING);
 			flags = (short) ((stage << 12) | name.length); // TODO: fix flags
 		}
 
@@ -580,7 +582,7 @@ private File getFile(File wd) {
 		}
 
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
+			return RawParseUtils.decode(Constants.CHARSET, name, 0, name.length);
 		}
 
 		/**
@@ -731,7 +733,7 @@ void readTree(String prefix, Tree t) throws IOException {
 				readTree(name, (Tree) te);
 			} else {
 				Entry e = new Entry(te, 0);
-				entries.put(name.getBytes("UTF-8"), e);
+				entries.put(name.getBytes(Constants.CHARACTER_ENCODING), e);
 			}
 		}
 	}
@@ -743,7 +745,7 @@ void readTree(String prefix, Tree t) throws IOException {
 	 * @throws IOException
 	 */
 	public Entry addEntry(TreeEntry te) throws IOException {
-		byte[] key = te.getFullName().getBytes("UTF-8");
+		byte[] key = te.getFullName().getBytes(Constants.CHARACTER_ENCODING);
 		Entry e = new Entry(te, 0);
 		entries.put(key, e);
 		return e;
@@ -825,7 +827,7 @@ public ObjectId writeTree() throws IOException {
 			while (trees.size() < newName.length) {
 				if (!current.existsTree(newName[trees.size() - 1])) {
 					current = new Tree(current, newName[trees.size() - 1]
-							.getBytes());
+							.getBytes(Constants.CHARACTER_ENCODING));
 					current.getParent().addEntry(current);
 					trees.push(current);
 				} else {
@@ -835,7 +837,7 @@ public ObjectId writeTree() throws IOException {
 				}
 			}
 			FileTreeEntry ne = new FileTreeEntry(current, e.sha1,
-					newName[newName.length - 1].getBytes(),
+					newName[newName.length - 1].getBytes(Constants.CHARACTER_ENCODING),
 					(e.mode & FileMode.EXECUTABLE_FILE.getBits()) == FileMode.EXECUTABLE_FILE.getBits());
 			current.addEntry(ne);
 		}
@@ -880,7 +882,7 @@ int longestCommonPath(String[] a, String[] b) {
 	 * Small beware: Unaccounted for are unmerged entries. You may want
 	 * to abort if members with stage != 0 are found if you are doing
 	 * any updating operations. All stages will be found after one another
-	 * here later. Currently only one stage per name is returned.
+	 * here later. Currently only one stage per name is returned.	
 	 *
 	 * @return The index entries sorted
 	 */
@@ -896,7 +898,8 @@ int longestCommonPath(String[] a, String[] b) {
 	 * @throws UnsupportedEncodingException
 	 */
 	public Entry getEntry(String path) throws UnsupportedEncodingException {
-		return (Entry) entries.get(Repository.gitInternalSlash(path.getBytes("ISO-8859-1")));
+		return (Entry) entries.get(Repository.gitInternalSlash(path
+				.getBytes(Constants.CHARACTER_ENCODING)));
 	}
 
 	/**
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Tree.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Tree.java
index 25a9a71..3fd3d30 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Tree.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Tree.java
@@ -44,6 +44,7 @@
 import org.spearce.jgit.errors.CorruptObjectException;
 import org.spearce.jgit.errors.EntryExistsException;
 import org.spearce.jgit.errors.MissingObjectException;
+import org.spearce.jgit.util.RawParseUtils;
 
 /**
  * A representation of a Git tree entry. A Tree is a directory in Git.
@@ -281,8 +282,7 @@ public FileTreeEntry addFile(final byte[] s, final int offset)
 
 		final byte[] newName = substring(s, offset, slash);
 		if (p >= 0)
-			throw new EntryExistsException(new String(newName,
-					Constants.CHARACTER_ENCODING));
+			throw new EntryExistsException(RawParseUtils.decode(Constants.CHARSET, newName, 0, newName.length));
 		else if (slash < s.length) {
 			final Tree t = new Tree(this, newName);
 			insertEntry(p, t);
@@ -332,8 +332,8 @@ public Tree addTree(final byte[] s, final int offset) throws IOException {
 
 		final byte[] newName = substring(s, offset, slash);
 		if (p >= 0)
-			throw new EntryExistsException(new String(newName,
-					Constants.CHARACTER_ENCODING));
+			throw new EntryExistsException(RawParseUtils.decode(
+					Constants.CHARSET, newName, 0, newName.length));
 
 		final Tree t = new Tree(this, newName);
 		insertEntry(p, t);
@@ -355,8 +355,7 @@ public void addEntry(final TreeEntry e) throws IOException {
 			e.attachParent(this);
 			insertEntry(p, e);
 		} else {
-			throw new EntryExistsException(new String(e.getNameUTF8(),
-					Constants.CHARACTER_ENCODING));
+			throw new EntryExistsException(e.getName());
 		}
 	}
 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/TreeEntry.java b/org.spearce.jgit/src/org/spearce/jgit/lib/TreeEntry.java
index 85dda1d..7f58056 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/TreeEntry.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/TreeEntry.java
@@ -39,9 +39,9 @@
 package org.spearce.jgit.lib;
 
 import java.io.IOException;
-import java.io.UnsupportedEncodingException;
 
 import org.spearce.jgit.lib.GitIndex.Entry;
+import org.spearce.jgit.util.RawParseUtils;
 
 /**
  * This class represents an entry in a tree, like a blob or another tree.
@@ -126,13 +126,10 @@ public Repository getRepository() {
 	 * @return the name of this entry.
 	 */
 	public String getName() {
-		try {
-			return nameUTF8 != null ? new String(nameUTF8,
-					Constants.CHARACTER_ENCODING) : null;
-		} catch (UnsupportedEncodingException uee) {
-			throw new RuntimeException("JVM doesn't support "
-					+ Constants.CHARACTER_ENCODING, uee);
-		}
+		if (nameUTF8 != null)
+			return RawParseUtils.decode(Constants.CHARSET, nameUTF8, 0,
+					nameUTF8.length);
+		return null;
 	}
 
 	/**
-- 
1.6.0.2.308.gef4a

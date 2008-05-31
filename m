From: Florian Koeberle <florianskarten@web.de>
Subject: [JGIT PATCH v3.1 16/23] Added the class LightFileTreeIterator and a test for it.
Date: Sat, 31 May 2008 12:03:56 +0200
Message-ID: <1212228236-8572-1-git-send-email-florianskarten@web.de>
References: <1211574872-23676-17-git-send-email-florianskarten@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Florian Koeberle <florianskarten@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 31 12:05:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2Ny9-0001WY-Nc
	for gcvg-git-2@gmane.org; Sat, 31 May 2008 12:05:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751652AbYEaKEj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 May 2008 06:04:39 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751597AbYEaKEi
	(ORCPT <rfc822;git-outgoing>); Sat, 31 May 2008 06:04:38 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:59527 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751165AbYEaKEh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 May 2008 06:04:37 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate03.web.de (Postfix) with ESMTP id 26EA1DD899D4
	for <git@vger.kernel.org>; Sat, 31 May 2008 12:03:57 +0200 (CEST)
Received: from [84.150.122.201] (helo=localhost.localdomain)
	by smtp08.web.de with esmtp (WEB.DE 4.109 #226)
	id 1K2NwK-0002oO-00; Sat, 31 May 2008 12:03:56 +0200
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <1211574872-23676-17-git-send-email-florianskarten@web.de>
X-Sender: florianskarten@web.de
X-Provags-ID: V01U2FsdGVkX18QKXan0Wu1UKIyrXx6HhpCSfrLW/KQbGlQjrnw
	G0FVKtssTyvak14Kv/taX0N3Zzdag/+Nw9sAAq+aRKCrhPxFNw
	gv15O+YRc3rjdUUfU51g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83370>

Signed-off-by: Florian Koeberle <florianskarten@web.de>
---
 .../jgit/treewalk/LightFileTreeIteratorTest.java   |  114 ++++++++++++=
++++++++
 .../jgit/treewalk/LightFileTreeIterator.java       |  112 ++++++++++++=
+++++++
 2 files changed, 226 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/treewalk=
/LightFileTreeIteratorTest.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/treewalk/Ligh=
tFileTreeIterator.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/LightF=
ileTreeIteratorTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/t=
reewalk/LightFileTreeIteratorTest.java
new file mode 100644
index 0000000..6febbdc
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/LightFileTree=
IteratorTest.java
@@ -0,0 +1,114 @@
+/*
+ *  Copyright (C) 2008 Florian K=C3=B6berle
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
+ *  License along with this library; if not, write to the Free Softwar=
e
+ *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  021=
10-1301
+ */
+package org.spearce.jgit.treewalk;
+
+import java.io.File;
+import java.util.HashSet;
+import java.util.Iterator;
+import java.util.Set;
+
+import org.spearce.jgit.treewalk.rules.Rules;
+
+import junit.framework.TestCase;
+
+public class LightFileTreeIteratorTest extends TestCase {
+	private String DIRECTORY_A_NAME =3D "a";
+
+	private String DIRECTORY_AB_NAME =3D "b";
+
+	private File projectDirectory;
+
+	private File fileB;
+
+	private File directoryA;
+
+	private File directoryAB;
+
+	private File fileABA;
+
+	private File directoryAC;
+
+	private File fileACA;
+
+	private File fileACB;
+
+	@Override
+	protected void setUp() throws Exception {
+		this.projectDirectory =3D File.createTempFile("FileTreeIteratorTest"=
, "");
+		projectDirectory.delete();
+		projectDirectory.mkdir();
+		projectDirectory.deleteOnExit();
+
+		this.directoryA =3D new File(projectDirectory, DIRECTORY_A_NAME);
+		directoryA.mkdir();
+
+		this.directoryAB =3D new File(directoryA, DIRECTORY_AB_NAME);
+		directoryAB.mkdir();
+
+		this.fileABA =3D new File(directoryAB, "a.y");
+		fileABA.createNewFile();
+
+		this.directoryAC =3D new File(directoryA, "c");
+		this.directoryAC.mkdir();
+
+		this.fileACA =3D new File(directoryAC, "a.x");
+		fileACA.createNewFile();
+
+		this.fileACB =3D new File(directoryAC, "b.y");
+		fileACB.createNewFile();
+
+		this.fileB =3D new File(projectDirectory, "b.x");
+		fileB.createNewFile();
+	}
+
+	public void testFileTreeIterator() {
+		final Iterator<File> iterator =3D new LightFileTreeIterator(
+				projectDirectory, Rules.IGNORE_NOTHING, false);
+		final Set<File> actualPaths =3D new HashSet<File>();
+		while (iterator.hasNext()) {
+			final File next =3D iterator.next();
+			assertFalse(actualPaths.contains(next));
+			actualPaths.add(next);
+		}
+
+		final Set<File> expectedPaths =3D new HashSet<File>();
+		expectedPaths.add(directoryA);
+		expectedPaths.add(fileB);
+		expectedPaths.add(directoryAB);
+		expectedPaths.add(fileABA);
+		expectedPaths.add(directoryAC);
+		expectedPaths.add(fileACA);
+		expectedPaths.add(fileACB);
+		assertEquals(expectedPaths, actualPaths);
+
+	}
+
+	public void testFileTreeIteratorWithIgnoreAllRules() {
+		final Iterator<File> iterator =3D new LightFileTreeIterator(
+				projectDirectory, Rules.IGNORE_ALL, false);
+		final Set<File> actualPaths =3D new HashSet<File>();
+		while (iterator.hasNext()) {
+			final File next =3D iterator.next();
+			assertFalse(actualPaths.contains(next));
+			actualPaths.add(next);
+		}
+
+		assertEquals(0, actualPaths.size());
+
+	}
+
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/LightFileTr=
eeIterator.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/LightF=
ileTreeIterator.java
new file mode 100644
index 0000000..a3822cd
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/LightFileTreeItera=
tor.java
@@ -0,0 +1,112 @@
+/*
+ *  Copyright (C) 2008 Florian K=C3=B6berle
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
+ *  License along with this library; if not, write to the Free Softwar=
e
+ *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  021=
10-1301
+ */
+package org.spearce.jgit.treewalk;
+
+import java.io.File;
+import java.util.EmptyStackException;
+import java.util.Iterator;
+import java.util.NoSuchElementException;
+import java.util.Stack;
+
+import org.spearce.jgit.treewalk.rules.Rules;
+
+class LightFileTreeIterator implements Iterator<File> {
+	private final Stack<File> remainingPaths;
+
+	private final Stack<Directory> remainingDirectories;
+
+	/**
+	 * Creates a new Iterator which allows to iterate over the content of=
 the
+	 * specified rootDirectory. The rootDirectory itself is never include=
d.
+	 *=20
+	 * @param rootDirectory
+	 *            the directory tree to iterate over.
+	 * @param ignoreRules
+	 *            defines which paths are included and which aren't.
+	 * @param includeRootDirectory
+	 *            the iterator will return the rootDirectory if this is f=
lag is
+	 *            true.
+	 */
+	LightFileTreeIterator(File rootDirectory, Rules ignoreRules,
+			boolean includeRootDirectory) {
+		remainingPaths =3D new Stack<File>();
+		if (includeRootDirectory) {
+			remainingPaths.add(rootDirectory);
+		}
+		remainingDirectories =3D new Stack<Directory>();
+		remainingDirectories.add(new Directory(rootDirectory, ignoreRules));
+	}
+
+	public boolean hasNext() {
+		findMorePathsIfNessesary();
+		return !remainingPaths.empty();
+	}
+
+	void findMorePathsIfNessesary() {
+		if (remainingPaths.isEmpty()) {
+			findMorePaths();
+		}
+	}
+
+	void findMorePaths() {
+		while (!remainingDirectories.isEmpty() && remainingPaths.isEmpty()) =
{
+			final Directory directory =3D remainingDirectories.pop();
+			final File[] paths =3D directory.path.listFiles();
+			for (File path : paths) {
+				final boolean fileIsDirectory =3D path.isDirectory();
+				if (fileIsDirectory) {
+					final Rules subDirectoryIgnoreRules =3D directory.ignoreRules
+							.getRulesForSubDirectory(path.getName());
+					if (subDirectoryIgnoreRules !=3D Rules.IGNORE_ALL) {
+						final Directory subDirectory =3D new Directory(path,
+								subDirectoryIgnoreRules);
+						remainingDirectories.add(subDirectory);
+					}
+				}
+				if (!directory.ignoreRules.toIgnore(path.getName(),
+						fileIsDirectory)) {
+					remainingPaths.add(path);
+				}
+			}
+		}
+	}
+
+	public File next() {
+		findMorePathsIfNessesary();
+		try {
+			return remainingPaths.pop();
+		} catch (EmptyStackException e) {
+			throw new NoSuchElementException();
+		}
+	}
+
+	public void remove() {
+		throw new UnsupportedOperationException();
+	}
+
+	private class Directory {
+		final File path;
+
+		final Rules ignoreRules;
+
+		Directory(File path, Rules ignoreRules) {
+			this.path =3D path;
+			this.ignoreRules =3D ignoreRules;
+		}
+	}
+
+}
--=20
1.5.4.3

From: Florian Koeberle <florianskarten@web.de>
Subject: [JGIT PATCH v3 16/23] Added the class LightFileTreeIterator and a test for it.
Date: Fri, 23 May 2008 22:34:25 +0200
Message-ID: <1211574872-23676-17-git-send-email-florianskarten@web.de>
References: <1211574872-23676-1-git-send-email-florianskarten@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Florian Koeberle <florianskarten@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 23 22:36:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jze02-0006CA-GV
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 22:36:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757054AbYEWUfC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 16:35:02 -0400
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756088AbYEWUfB
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 16:35:01 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:39664 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757067AbYEWUem (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 16:34:42 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate02.web.de (Postfix) with ESMTP id 6B8C7DE1A7D9
	for <git@vger.kernel.org>; Fri, 23 May 2008 22:34:41 +0200 (CEST)
Received: from [84.150.81.80] (helo=localhost.localdomain)
	by smtp06.web.de with asmtp (WEB.DE 4.109 #226)
	id 1JzdyK-0005iq-02; Fri, 23 May 2008 22:34:40 +0200
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1211574872-23676-1-git-send-email-florianskarten@web.de>
X-Sender: florianskarten@web.de
X-Provags-ID: V01U2FsdGVkX1/B12JafS6J+OTBANizC55ODctpMF4FmMYjDTc5
	jK6PreolltgD4MxeaZOVTIgzj/SeEDYYl1qZDu9zga29YZ06qN
	+H5R2iv1bIWcpI/z62+Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82745>

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
index 0000000..f937182
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
+		final Set<File> actualPathes =3D new HashSet<File>();
+		while (iterator.hasNext()) {
+			final File next =3D iterator.next();
+			assertFalse(actualPathes.contains(next));
+			actualPathes.add(next);
+		}
+
+		final Set<File> expectedPathes =3D new HashSet<File>();
+		expectedPathes.add(directoryA);
+		expectedPathes.add(fileB);
+		expectedPathes.add(directoryAB);
+		expectedPathes.add(fileABA);
+		expectedPathes.add(directoryAC);
+		expectedPathes.add(fileACA);
+		expectedPathes.add(fileACB);
+		assertEquals(expectedPathes, actualPathes);
+
+	}
+
+	public void testFileTreeIteratorWithIgnoreAllRules() {
+		final Iterator<File> iterator =3D new LightFileTreeIterator(
+				projectDirectory, Rules.IGNORE_ALL, false);
+		final Set<File> actualPathes =3D new HashSet<File>();
+		while (iterator.hasNext()) {
+			final File next =3D iterator.next();
+			assertFalse(actualPathes.contains(next));
+			actualPathes.add(next);
+		}
+
+		assertEquals(0, actualPathes.size());
+
+	}
+
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/LightFileTr=
eeIterator.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/LightF=
ileTreeIterator.java
new file mode 100644
index 0000000..45fb167
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
+	private final Stack<File> remainingPathes;
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
+		remainingPathes =3D new Stack<File>();
+		if (includeRootDirectory) {
+			remainingPathes.add(rootDirectory);
+		}
+		remainingDirectories =3D new Stack<Directory>();
+		remainingDirectories.add(new Directory(rootDirectory, ignoreRules));
+	}
+
+	public boolean hasNext() {
+		findMorePathesIfNessesary();
+		return !remainingPathes.empty();
+	}
+
+	void findMorePathesIfNessesary() {
+		if (remainingPathes.isEmpty()) {
+			findMorePathes();
+		}
+	}
+
+	void findMorePathes() {
+		while (!remainingDirectories.isEmpty() && remainingPathes.isEmpty())=
 {
+			final Directory directory =3D remainingDirectories.pop();
+			final File[] pathes =3D directory.path.listFiles();
+			for (File path : pathes) {
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
+					remainingPathes.add(path);
+				}
+			}
+		}
+	}
+
+	public File next() {
+		findMorePathesIfNessesary();
+		try {
+			return remainingPathes.pop();
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

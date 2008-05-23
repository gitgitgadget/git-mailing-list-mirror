From: Florian Koeberle <florianskarten@web.de>
Subject: [JGIT PATCH v3 23/23] Added the test class AddCommandIterationTest.
Date: Fri, 23 May 2008 22:34:32 +0200
Message-ID: <1211574872-23676-24-git-send-email-florianskarten@web.de>
References: <1211574872-23676-1-git-send-email-florianskarten@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Florian Koeberle <florianskarten@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 23 22:36:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jze06-0006CA-Fl
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 22:36:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759197AbYEWUfT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 16:35:19 -0400
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759189AbYEWUfS
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 16:35:18 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:45448 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757607AbYEWUeq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 16:34:46 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate03.web.de (Postfix) with ESMTP id 16FD9DC4A1E4
	for <git@vger.kernel.org>; Fri, 23 May 2008 22:34:45 +0200 (CEST)
Received: from [84.150.81.80] (helo=localhost.localdomain)
	by smtp06.web.de with asmtp (WEB.DE 4.109 #226)
	id 1JzdyO-0005iq-00; Fri, 23 May 2008 22:34:44 +0200
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1211574872-23676-1-git-send-email-florianskarten@web.de>
X-Sender: florianskarten@web.de
X-Provags-ID: V01U2FsdGVkX1/XkLlXrF7lqG5jB3SGVwtHa+Gbptx8XsOo9fZH
	OT4qYCQXTNGjqpLvvT8mbeAdQrxEI5DiFRFX3ILyhu/XBveOiQ
	ucKwBy/XLqomUttTz3xA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82751>

Signed-off-by: Florian Koeberle <florianskarten@web.de>
---
 .../treewalk/rules/AddCommandIterationTest.java    |  321 ++++++++++++=
++++++++
 1 files changed, 321 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/treewalk=
/rules/AddCommandIterationTest.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/rules/=
AddCommandIterationTest.java b/org.spearce.jgit.test/tst/org/spearce/jg=
it/treewalk/rules/AddCommandIterationTest.java
new file mode 100644
index 0000000..a96c880
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/rules/AddComm=
andIterationTest.java
@@ -0,0 +1,321 @@
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
+package org.spearce.jgit.treewalk.rules;
+
+import java.io.File;
+import java.io.IOException;
+import java.io.PrintWriter;
+import java.util.ArrayList;
+import java.util.Arrays;
+import java.util.Collections;
+import java.util.HashSet;
+import java.util.Iterator;
+import java.util.List;
+import java.util.NoSuchElementException;
+import java.util.Set;
+
+import junit.framework.TestCase;
+
+import org.spearce.jgit.errors.InvalidPatternException;
+import org.spearce.jgit.errors.PathNotInProjectDirectoryException;
+import org.spearce.jgit.lib.Repository;
+import org.spearce.jgit.lib.WorkTree;
+import org.spearce.jgit.treewalk.LightFileTreeIterable;
+
+public class AddCommandIterationTest extends TestCase {
+
+	private WorkTree workTree;
+
+	private AddRulesFactory factory;
+
+	private Iterable<File> createIterable(File workingDirectory,
+			List<String> filePatternsOfAddCommand)
+			throws PathNotInProjectDirectoryException, InvalidPatternException,
+			IOException {
+		final Rules rules =3D factory.createRules(workTree.getDirectory(),
+				workingDirectory, filePatternsOfAddCommand);
+		return new LightFileTreeIterable(workTree.getDirectory(), rules, fal=
se);
+	}
+
+	@Override
+	protected void setUp() throws Exception {
+		final File projectDirectory =3D File.createTempFile("test", "");
+		projectDirectory.delete();
+		projectDirectory.mkdir();
+		projectDirectory.deleteOnExit();
+		this.workTree =3D Repository.createWorkTree(projectDirectory);
+		this.factory =3D new AddRulesFactory();
+	}
+
+	public void testNoPattern() throws Exception {
+		createFile("a.txt");
+		final Iterable<File> iterable =3D createIterable(workTree.getDirecto=
ry(),
+				Collections.<String> emptyList());
+		final Set<File> expectedPathes =3D Collections.emptySet();
+		assertIsValidIterable(iterable);
+		assertIterableReturnsSet(expectedPathes, iterable);
+	}
+
+	public void testTreePattern1() throws Exception {
+		final Set<File> expectedFiles =3D new HashSet<File>();
+		createFile("a.txt");
+		expectedFiles.add(createFile("a", "a.txt"));
+		expectedFiles.add(createFile("a", "a", "a.txt"));
+		expectedFiles.add(createFile("a", "b", "a.txt"));
+		createFile("a", "b", "a.c");
+
+		final File directoryA =3D new File(workTree.getDirectory(), "a");
+
+		final Iterable<File> iterable =3D createIterable(directoryA, Arrays
+				.asList("*.txt"));
+		assertIsValidIterable(iterable);
+		assertIterableReturnsSet(expectedFiles, iterable);
+	}
+
+	public void testTreePattern2() throws Exception {
+		final Set<File> expectedFiles =3D new HashSet<File>();
+		createFile("a.txt");
+		expectedFiles.add(createFile("a", "a.txt"));
+		expectedFiles.add(createFile("a", "a", "a.txt"));
+		expectedFiles.add(createFile("a", "b", "a.txt"));
+		createFile("a", "b", "a.c");
+
+		final Iterable<File> iterable =3D createIterable(workTree.getDirecto=
ry(),
+				Arrays.asList("a" + File.separator + "*.txt"));
+		assertIsValidIterable(iterable);
+		assertIterableReturnsSet(expectedFiles, iterable);
+	}
+
+	public void testSelectCompleteSubdirectory() throws Exception {
+		final Set<File> expectedPathes =3D new HashSet<File>();
+		final File directoryA =3D new File(workTree.getDirectory(), "a");
+		final File directoryAA =3D new File(directoryA, "a");
+		final File directoryAB =3D new File(directoryA, "b");
+		createFile("a.txt");
+		expectedPathes.add(directoryA);
+		expectedPathes.add(directoryAA);
+		expectedPathes.add(createFile("a", "a.txt"));
+		expectedPathes.add(createFile("a", "a", "a.txt"));
+		expectedPathes.add(directoryAB);
+		expectedPathes.add(createFile("a", "b", "a.txt"));
+		expectedPathes.add(createFile("a", "b", "a.c"));
+
+		final Iterable<File> iterable =3D createIterable(workTree.getDirecto=
ry(),
+				Arrays.asList("a"));
+
+		assertIsValidIterable(iterable);
+		assertIterableReturnsSet(expectedPathes, iterable);
+	}
+
+	public void testSelectTwoSubdirectories() throws Exception {
+		final Set<File> expectedPathes =3D new HashSet<File>();
+		final File directoryA =3D new File(workTree.getDirectory(), "a");
+		final File directoryAA =3D new File(directoryA, "a");
+		final File directoryAB =3D new File(directoryA, "b");
+		createFile("a.txt");
+		createFile("a", "a.txt");
+		expectedPathes.add(directoryAA);
+		expectedPathes.add(createFile("a", "a", "a.txt"));
+		expectedPathes.add(directoryAB);
+		expectedPathes.add(createFile("a", "b", "a.txt"));
+		expectedPathes.add(createFile("a", "b", "a.c"));
+
+		final List<String> patternList =3D new ArrayList<String>(2);
+		patternList.add("a" + File.separator + "a");
+		patternList.add("a" + File.separator + "b");
+		final Iterable<File> iterable =3D createIterable(workTree.getDirecto=
ry(),
+				patternList);
+
+		assertIsValidIterable(iterable);
+		assertIterableReturnsSet(expectedPathes, iterable);
+	}
+
+	public void testTwoDifferentSelects() throws Exception {
+		final Set<File> expectedPathes =3D new HashSet<File>();
+		final File directoryA =3D new File(workTree.getDirectory(), "a");
+		final File directoryAA =3D new File(directoryA, "a");
+		createFile("a.txt");
+		createFile("a", "a.txt");
+		expectedPathes.add(directoryAA);
+		expectedPathes.add(createFile("a", "a", "a.txt"));
+		expectedPathes.add(createFile("a", "b", "a.txt"));
+		expectedPathes.add(createFile("a", "b", "c", "a.txt"));
+		createFile("a", "b", "a.c");
+
+		final List<String> patternList =3D new ArrayList<String>(2);
+		patternList.add("a" + File.separator + "a");
+		patternList.add("a" + File.separator + "b" + File.separator + "*.txt=
");
+
+		final Iterable<File> iterable =3D createIterable(workTree.getDirecto=
ry(),
+				patternList);
+
+		assertIsValidIterable(iterable);
+		assertIterableReturnsSet(expectedPathes, iterable);
+	}
+
+	public void testRealisticExample() throws Exception {
+		final Set<File> expectedPathes =3D new HashSet<File>();
+
+		// write the .gitignore file
+		final File dotGitIgnoreFile =3D createFile(".gitignore");
+		final PrintWriter dotGitIgnoreFilePrinter =3D new PrintWriter(
+				dotGitIgnoreFile);
+		try {
+			dotGitIgnoreFilePrinter.println("/alpha/config.xml");
+			dotGitIgnoreFilePrinter.println("*.class");
+			dotGitIgnoreFilePrinter.println("!/alpha/test/ressources/");
+			dotGitIgnoreFilePrinter.println("*~");
+		} finally {
+			dotGitIgnoreFilePrinter.close();
+		}
+
+		// write the .git/info/exclude file
+		final File repositoryDirectory =3D workTree.getRepository()
+				.getDirectory();
+		final File infoDirectory =3D new File(repositoryDirectory, "info");
+		infoDirectory.mkdir();
+		final File infoExcludeFile =3D new File(infoDirectory, "exclude");
+		final PrintWriter infoExcludeFilePrinter =3D new PrintWriter(
+				infoExcludeFile);
+		try {
+			infoExcludeFilePrinter.println("/alpha/test/ressources/mytest.txt")=
;
+		} finally {
+			infoExcludeFilePrinter.close();
+		}
+
+		createFile("alpha", "config.xml");
+		expectedPathes.add(createFile("alpha", "src", "Main.java"));
+		createFile("alpha", "src", "Main.class");
+		expectedPathes.add(createFile("alpha", "test", "ressources",
+				"Example.class"));
+		expectedPathes.add(createFile("alpha", "test", "ressources",
+				"input.txt"));
+		createFile("alpha", "test", "ressources", "input.txt~");
+		createFile("alpha", "test", "ressources", "mytest.txt");
+
+		final File alphaDirectory =3D new File(workTree.getDirectory(), "alp=
ha");
+		final File srcDirectory =3D new File(alphaDirectory, "src");
+		final File testDirectory =3D new File(alphaDirectory, "test");
+		final File ressources =3D new File(testDirectory, "ressources");
+
+		expectedPathes.add(alphaDirectory);
+		expectedPathes.add(srcDirectory);
+		expectedPathes.add(testDirectory);
+		expectedPathes.add(ressources);
+
+		final List<String> patternList =3D new ArrayList<String>(2);
+		patternList.add("alpha");
+
+		final Iterable<File> iterable =3D createIterable(workTree.getDirecto=
ry(),
+				patternList);
+
+		assertIsValidIterable(iterable);
+		assertIterableReturnsSet(expectedPathes, iterable);
+	}
+
+	public void testSingleFile() throws Exception {
+		createFile("a.txt");
+		createFile("a", "a.txt");
+		createFile("a", "a", "a.txt");
+		final File expectedFile =3D createFile("a", "b", "a.txt");
+		createFile("a", "b", "a.c");
+
+		final String pattern =3D "a" + File.separator + "b" + File.separator
+				+ "a.txt";
+		final Iterable<File> iterable =3D createIterable(workTree.getDirecto=
ry(),
+				Arrays.asList(pattern));
+		final Set<File> expectedPathes =3D Collections.singleton(expectedFil=
e);
+		assertIsValidIterable(iterable);
+		assertIterableReturnsSet(expectedPathes, iterable);
+	}
+
+	/**
+	 * Tests if the specified {@link Iterable} returns the specified set =
of
+	 * {@link File}s. The assertion will fail if the {@link Iterable} ret=
urns
+	 * to much, to less files. It will also fail if the {@link Iterable} =
returns
+	 * a file twice.
+	 *=20
+	 * @param expectedContent
+	 *            the expected set of files.
+	 * @param iterable
+	 *            the {@link Iterable} to test.
+	 */
+	private void assertIterableReturnsSet(Set<File> expectedContent,
+			Iterable<File> iterable) {
+		final Set<File> returnedFiles =3D new HashSet<File>();
+		final List<File> doubleReturnedFiles =3D new ArrayList<File>();
+
+		final Iterator<File> iterator =3D iterable.iterator();
+		while (iterator.hasNext()) {
+			final File file =3D iterator.next();
+			if (!returnedFiles.add(file)) {
+				doubleReturnedFiles.add(file);
+			}
+		}
+		final Set<File> missingFiles =3D new HashSet<File>();
+		for (File file : expectedContent) {
+			if (!returnedFiles.contains(file)) {
+				missingFiles.add(file);
+			}
+		}
+		if (!missingFiles.isEmpty()) {
+			fail(String.format("missing pathes: %s", missingFiles));
+		}
+
+		final Set<File> unexpectedFiles =3D new HashSet<File>();
+		for (File file : returnedFiles) {
+			if (!expectedContent.contains(file)) {
+				unexpectedFiles.add(file);
+			}
+		}
+		if (!unexpectedFiles.isEmpty()) {
+			fail(String.format("unexpected pathes: %s", unexpectedFiles));
+		}
+
+		if (!doubleReturnedFiles.isEmpty()) {
+			fail(String.format("multiple times returned pathes: %s",
+					doubleReturnedFiles));
+		}
+
+	}
+
+	private static void assertIsValidIterable(Iterable<File> iterable) {
+		final Iterator<File> iterator =3D iterable.iterator();
+		while (iterator.hasNext()) {
+			iterator.next();
+		}
+		try {
+			iterator.next();
+			fail();
+		} catch (NoSuchElementException e) {
+			// expected
+		}
+	}
+
+	private File createFile(String... path) throws IOException {
+		File file =3D workTree.getDirectory();
+		for (int i =3D 0; i < path.length; i++) {
+			file =3D new File(file, path[i]);
+			if (i =3D=3D path.length - 1) {
+				file.getParentFile().mkdirs();
+				file.createNewFile();
+				break;
+			}
+		}
+		return file;
+	}
+}
--=20
1.5.4.3

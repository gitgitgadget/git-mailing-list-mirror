From: Florian Koeberle <florianskarten@web.de>
Subject: [JGIT PATCH v4 15/24] Added the class LightFileTreeIterator and a test for it.
Date: Fri, 13 Jun 2008 20:35:12 +0200
Message-ID: <1213382121-19786-15-git-send-email-florianskarten@web.de>
References: <4852BCCA.4030404@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Florian Koeberle <florianskarten@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 13 20:38:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7EAS-0005zA-AD
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 20:38:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753117AbYFMSgH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 14:36:07 -0400
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753080AbYFMSgG
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 14:36:06 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:43456 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752749AbYFMSfc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 14:35:32 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate02.web.de (Postfix) with ESMTP id 243F4E184F24
	for <git@vger.kernel.org>; Fri, 13 Jun 2008 20:35:31 +0200 (CEST)
Received: from [84.150.79.9] (helo=localhost.localdomain)
	by smtp08.web.de with asmtp (WEB.DE 4.109 #226)
	id 1K7E7W-0000eI-01; Fri, 13 Jun 2008 20:35:30 +0200
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <4852BCCA.4030404@web.de>
In-Reply-To: <4852BCCA.4030404@web.de>
References: <4852BCCA.4030404@web.de>
X-Sender: florianskarten@web.de
X-Provags-ID: V01U2FsdGVkX18qfjz4CK5dT2CNMxP05a917vPFAOKaEJBGxLMg
	5dTTgNOhdwO1LPSew30TOVuYKJJgIliru3sptk2PpdNSu4DOOg
	W9sTSSDOpsDOZRilTn/g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84926>

Signed-off-by: Florian Koeberle <florianskarten@web.de>
---
 .../jgit/treewalk/LightFileTreeIteratorTest.java   |  135 ++++++++++++=
++++++++
 .../jgit/treewalk/LightFileTreeIterator.java       |  133 ++++++++++++=
+++++++
 2 files changed, 268 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/treewalk=
/LightFileTreeIteratorTest.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/treewalk/Ligh=
tFileTreeIterator.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/LightF=
ileTreeIteratorTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/t=
reewalk/LightFileTreeIteratorTest.java
new file mode 100644
index 0000000..d1d8f48
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/LightFileTree=
IteratorTest.java
@@ -0,0 +1,135 @@
+/*
+ * Copyright (C) 2008, Florian K=C3=B6berle <florianskarten@web.de>
+ *
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or
+ * without modification, are permitted provided that the following
+ * conditions are met:
+ *
+ * - Redistributions of source code must retain the above copyright
+ *   notice, this list of conditions and the following disclaimer.
+ *
+ * - Redistributions in binary form must reproduce the above
+ *   copyright notice, this list of conditions and the following
+ *   disclaimer in the documentation and/or other materials provided
+ *   with the distribution.
+ *
+ * - Neither the name of the Git Development Community nor the
+ *   names of its contributors may be used to endorse or promote
+ *   products derived from this software without specific prior
+ *   written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
+ * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
+ * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
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
index 0000000..ae80393
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/LightFileTreeItera=
tor.java
@@ -0,0 +1,133 @@
+/*
+ * Copyright (C) 2008, Florian K=C3=B6berle <florianskarten@web.de>
+ *
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or
+ * without modification, are permitted provided that the following
+ * conditions are met:
+ *
+ * - Redistributions of source code must retain the above copyright
+ *   notice, this list of conditions and the following disclaimer.
+ *
+ * - Redistributions in binary form must reproduce the above
+ *   copyright notice, this list of conditions and the following
+ *   disclaimer in the documentation and/or other materials provided
+ *   with the distribution.
+ *
+ * - Neither the name of the Git Development Community nor the
+ *   names of its contributors may be used to endorse or promote
+ *   products derived from this software without specific prior
+ *   written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
+ * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
+ * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
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
+				if (!directory.ignoreRules.shouldIgnore(path.getName(),
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

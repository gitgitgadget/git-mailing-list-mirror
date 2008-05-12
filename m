From: Florian Koeberle <florianskarten@web.de>
Subject: [JGIT PATCH v2 19/24] Added the class AddRuleListFactory.
Date: Mon, 12 May 2008 22:13:37 +0200
Message-ID: <1210623222-24908-20-git-send-email-florianskarten@web.de>
References: <1210623222-24908-1-git-send-email-florianskarten@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Florian Koeberle <florianskarten@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 12 22:23:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JveSg-00086f-O1
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 22:17:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755230AbYELUOZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 16:14:25 -0400
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757409AbYELUOY
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 16:14:24 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:36598 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757807AbYELUNz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 16:13:55 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate02.web.de (Postfix) with ESMTP id 6D45DDC4D252
	for <git@vger.kernel.org>; Mon, 12 May 2008 22:13:54 +0200 (CEST)
Received: from [84.150.98.143] (helo=localhost.localdomain)
	by smtp05.web.de with asmtp (WEB.DE 4.109 #226)
	id 1JvePB-00016x-01; Mon, 12 May 2008 22:13:53 +0200
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1210623222-24908-1-git-send-email-florianskarten@web.de>
X-Sender: florianskarten@web.de
X-Provags-ID: V01U2FsdGVkX1+3el8i/2GnWHk/ZYcNo+LM8uU2p8FiE5qGqNqi
	eSkBX1VDTXtlIjFyj6dJFgxIlUmMWD6wIRNvgLMjfNq0yfDU+Y
	wkKHF4kSgugwNXItVNVg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81936>

Signed-off-by: Florian Koeberle <florianskarten@web.de>
---
 .../jgit/treewalk/rules/AddRuleListFactory.java    |  128 ++++++++++++=
++++++++
 1 files changed, 128 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/treewalk/rule=
s/AddRuleListFactory.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/rules/AddRu=
leListFactory.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/rul=
es/AddRuleListFactory.java
new file mode 100644
index 0000000..0cb700f
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/rules/AddRuleListF=
actory.java
@@ -0,0 +1,128 @@
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
+import java.util.ArrayList;
+import java.util.Arrays;
+import java.util.LinkedList;
+import java.util.List;
+
+import org.spearce.jgit.errors.InvalidPatternException;
+import org.spearce.jgit.errors.PathNotInProjectDirectoryException;
+
+class AddRuleListFactory {
+	/*
+	 * The add command of git 1.5.2.5 behaves a little bit stange: "git a=
dd
+	 * a/\*z" adds the file "a/b/xyz" but "git add a/x\*" does not.
+	 *=20
+	 * The first is parsed as pattern "*z" for whole directory tree "a". =
The
+	 * second is parsed as an path.
+	 *=20
+	 */
+
+	private static List<String> getRelativePath(File projectDirectory, Fi=
le file)
+			throws PathNotInProjectDirectoryException, IOException {
+		File currentFile =3D file.getCanonicalFile();
+		final LinkedList<String> relativePath =3D new LinkedList<String>();
+		while (!currentFile.equals(projectDirectory)) {
+			relativePath.addFirst(currentFile.getName());
+			currentFile =3D currentFile.getParentFile();
+			if (currentFile =3D=3D null) {
+				throw new PathNotInProjectDirectoryException();
+			}
+		}
+		return relativePath;
+	}
+
+	List<Rule> createRuleList(File projectDirectory, File workingDirector=
y,
+			List<String> filePatternsOfAddCommand)
+			throws InvalidPatternException, PathNotInProjectDirectoryException,
+			IOException {
+
+		final List<String> pathPrefix =3D getRelativePath(projectDirectory,
+				workingDirectory);
+
+		final List<Rule> ruleList =3D new ArrayList<Rule>(
+				filePatternsOfAddCommand.size());
+		for (String pattern : filePatternsOfAddCommand) {
+			final boolean matchDirectoriesOnly;
+			if (pattern.endsWith(File.separator)) {
+				pattern =3D pattern.substring(0, pattern.length() - 1);
+				matchDirectoriesOnly =3D true;
+			} else {
+				matchDirectoriesOnly =3D false;
+			}
+
+			final String[] relativePath =3D pattern.split("[" + File.separator
+					+ "]");
+			final List<String> path =3D new ArrayList<String>();
+			path.addAll(pathPrefix);
+			path.addAll(Arrays.asList(relativePath));
+			assert (!path.isEmpty());
+
+			final FilePattern filePattern =3D createFilePattern(pattern,
+					matchDirectoriesOnly, path);
+			final Rule rule =3D new Rule(false, filePattern);
+			ruleList.add(rule);
+
+		}
+		return ruleList;
+	}
+
+	private static FilePattern createFilePattern(String pattern,
+			boolean matchDirectoriesOnly, List<String> path)
+			throws InvalidPatternException {
+		/*
+		 * I did several tests with the git-add command, and it seems that i=
t
+		 * handles a pattern as a fileGlob, if it has only one star at the
+		 * beginning of the latest part of the path. Otherwise it handle it =
as
+		 * file pattern.
+		 */
+
+		final String lastPathElement =3D path.get(path.size() - 1);
+		final boolean isFileGlob =3D lastPathElement.startsWith("*");
+		final FilePattern filePattern;
+		if (isFileGlob) {
+			filePattern =3D createGlobalOrTreeFilePattern(matchDirectoriesOnly,
+					path, lastPathElement);
+		} else {
+			for (String pathElement : path) {
+				if (pathElement.contains("*")) {
+					throw new InvalidPatternException(
+							"Stars are not allowed here", pattern);
+				}
+			}
+			filePattern =3D new ComplexFilePattern(path, matchDirectoriesOnly);
+		}
+		return filePattern;
+	}
+
+	private static FilePattern createGlobalOrTreeFilePattern(
+			final boolean matchDirectoriesOnly, final List<String> path,
+			final String lastPathElement) {
+		final GlobalFilePattern globalFilePatternForTree =3D new GlobalFileP=
attern(
+				lastPathElement, matchDirectoriesOnly);
+		final List<String> targetTree =3D path.subList(0, path.size() - 1);
+		if (targetTree.isEmpty()) {
+			return globalFilePatternForTree;
+		} else {
+			return new TreeFilePattern(targetTree, globalFilePatternForTree);
+		}
+	}
+}
--=20
1.5.4.3

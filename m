From: Florian Koeberle <florianskarten@web.de>
Subject: [JGIT PATCH 20/22] Added class FileIterableFactoryForAddCommand.
Date: Sat, 10 May 2008 15:00:38 +0200
Message-ID: <1210424440-13886-21-git-send-email-florianskarten@web.de>
References: <1210424440-13886-1-git-send-email-florianskarten@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Florian Koeberle <florianskarten@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 10 15:03:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Juojm-0008FZ-9l
	for gcvg-git-2@gmane.org; Sat, 10 May 2008 15:03:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755648AbYEJNBh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 May 2008 09:01:37 -0400
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755557AbYEJNBf
	(ORCPT <rfc822;git-outgoing>); Sat, 10 May 2008 09:01:35 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:49490 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755648AbYEJNAx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 May 2008 09:00:53 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate03.web.de (Postfix) with ESMTP id 2CEC6DA5016A
	for <git@vger.kernel.org>; Sat, 10 May 2008 15:00:52 +0200 (CEST)
Received: from [84.150.90.150] (helo=localhost.localdomain)
	by smtp06.web.de with asmtp (WEB.DE 4.109 #226)
	id 1Juoh1-000860-01; Sat, 10 May 2008 15:00:51 +0200
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1210424440-13886-1-git-send-email-florianskarten@web.de>
X-Sender: florianskarten@web.de
X-Provags-ID: V01U2FsdGVkX18dd6agAFrgwlpOeworbYjt7pfutVNCVTrweJG3
	UFd5iEtn4tCgzmI7jPqPqEeLW0aUV2qkFsmhUo+rO6MsX0KOas
	uyR3oZYGZwtaPq4kgg8g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81677>

Signed-off-by: Florian Koeberle <florianskarten@web.de>
---
 .../FileIterableFactoryForAddCommand.java          |  118 ++++++++++++=
++++++++
 1 files changed, 118 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/fileitera=
tion/FileIterableFactoryForAddCommand.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/fileiteration/Fi=
leIterableFactoryForAddCommand.java b/org.spearce.jgit/src/org/spearce/=
jgit/lib/fileiteration/FileIterableFactoryForAddCommand.java
new file mode 100644
index 0000000..4674a87
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/fileiteration/FileItera=
bleFactoryForAddCommand.java
@@ -0,0 +1,118 @@
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
+package org.spearce.jgit.lib.fileiteration;
+
+import java.io.File;
+import java.io.FileNotFoundException;
+import java.io.IOException;
+import java.util.ArrayList;
+import java.util.Arrays;
+import java.util.List;
+
+import org.spearce.jgit.errors.InvalidPatternException;
+import org.spearce.jgit.errors.PathNotInProjectDirectoryException;
+import org.spearce.jgit.lib.GitPathConstants;
+import org.spearce.jgit.lib.Project;
+
+/**
+ * This class is designed to serve the needs of someone who want to im=
plement a
+ * git-add command and needs to determine the files to add.
+ *=20
+ * @author Florian K=C3=B6berle
+ *=20
+ */
+public class FileIterableFactoryForAddCommand {
+	private final RuleListToObjectConverter converter =3D new RuleListToO=
bjectConverter();
+
+	private final IgnoreRuleListFactory ignoreRuleListFactory =3D new Ign=
oreRuleListFactory();
+
+	private final AddRuleListFactory addRuleListFactory =3D new AddRuleLi=
stFactory();
+
+	/**
+	 * @param project
+	 *            a git project.
+	 * @param projectSubDirectory
+	 *            a directory in the projectDirectory.
+	 * @param filePatternsOfAddCommand
+	 *            determines the files to iterate over.
+	 * @return an {@link Iterable} which can be used to iterate over all
+	 *         matching files in the project directory which are not igno=
red by
+	 *         some ignore rules.
+	 * @throws InvalidPatternException
+	 * @throws IOException
+	 *             for some reasons.
+	 * @throws PathNotInProjectDirectoryException
+	 *             if projectSubDirectory isn't a subdirectory of the pro=
ject
+	 *             directory.
+	 */
+	public Iterable<File> createFileTreeIterable(Project project,
+			File projectSubDirectory, List<String> filePatternsOfAddCommand)
+			throws InvalidPatternException, PathNotInProjectDirectoryException,
+			IOException {
+		final File gitDirectory =3D project.getRepository().getDirectory();
+		final Rules rules =3D createRules(project.getDirectory(), gitDirecto=
ry,
+				projectSubDirectory, filePatternsOfAddCommand);
+		return new FileTreeIterable(project.getDirectory(), rules, false);
+	}
+
+	private Rules createRules(File projectDirectory, File gitDirectory,
+			File workingDirectory, List<String> filePatternsOfAddCommand)
+			throws InvalidPatternException, PathNotInProjectDirectoryException,
+			IOException {
+		final Rule gitDirectoryIgnoreRule =3D createGitDirectoryIgnoreRule()=
;
+		final List<Rule> ignoreRuleListFromFiles =3D createExcludeRules(
+				projectDirectory, gitDirectory);
+		final List<Rule> includeRules =3D addRuleListFactory.createRuleList(
+				projectDirectory, workingDirectory, filePatternsOfAddCommand);
+		final List<Rule> ruleList =3D new ArrayList<Rule>();
+
+		ruleList.add(gitDirectoryIgnoreRule);
+		ruleList.addAll(ignoreRuleListFromFiles);
+		ruleList.addAll(includeRules);
+		ruleList.add(new Rule(true, FilePattern.MATCH_ALWAYS));
+
+		return converter.createIgnoreRules(ruleList.iterator());
+	}
+
+	private List<Rule> createExcludeRules(File projectDirectory,
+			File gitDirectory) {
+		final List<File> possibleIgnoreFiles =3D new ArrayList<File>(2);
+		possibleIgnoreFiles.add(new File(projectDirectory, ".gitignore"));
+		possibleIgnoreFiles.add(new File(new File(gitDirectory, "info"),
+				"exclude"));
+
+		final List<File> ignoreFiles =3D new ArrayList<File>();
+		for (File possibleIgnoreFile : possibleIgnoreFiles) {
+			if (possibleIgnoreFile.isFile()) {
+				ignoreFiles.add(possibleIgnoreFile);
+			}
+		}
+
+		try {
+			return ignoreRuleListFactory.createIgnoreRuleList(ignoreFiles);
+		} catch (FileNotFoundException e) {
+			throw new RuntimeException("unexpected removal of ignore files", e)=
;
+		}
+	}
+
+	private Rule createGitDirectoryIgnoreRule() {
+		final FilePattern gitDirectoryPattern =3D new ComplexFilePattern(Arr=
ays
+				.asList(GitPathConstants.REPOSITORY_DIRECTORY_NAME), true);
+		final Rule gitDirectoryIgnoreRule =3D new Rule(true, gitDirectoryPat=
tern);
+		return gitDirectoryIgnoreRule;
+	}
+}
--=20
1.5.2.5

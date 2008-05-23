From: Florian Koeberle <florianskarten@web.de>
Subject: [JGIT PATCH v3 15/23] Added class AddRulesFactory.
Date: Fri, 23 May 2008 22:34:24 +0200
Message-ID: <1211574872-23676-16-git-send-email-florianskarten@web.de>
References: <1211574872-23676-1-git-send-email-florianskarten@web.de>
Cc: Florian Koeberle <florianskarten@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 23 22:36:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jze07-0006CA-Ug
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 22:36:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759016AbYEWUfY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 16:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759298AbYEWUfV
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 16:35:21 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:35513 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758927AbYEWUet (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 16:34:49 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id D7722E085D5A
	for <git@vger.kernel.org>; Fri, 23 May 2008 22:34:40 +0200 (CEST)
Received: from [84.150.81.80] (helo=localhost.localdomain)
	by smtp06.web.de with asmtp (WEB.DE 4.109 #226)
	id 1JzdyK-0005iq-01; Fri, 23 May 2008 22:34:40 +0200
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1211574872-23676-1-git-send-email-florianskarten@web.de>
X-Sender: florianskarten@web.de
X-Provags-ID: V01U2FsdGVkX18kH1Vq8Shp17tSzjNvBC2YNXl4PdR9hGqaSADv
	9Jq7LDbtKREhd5i/9VHJ2HF7RZAJJ4z3V9Eu699suxp1pxPkAw
	XPhq9bULF6gLtN6wHuIw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82743>

Signed-off-by: Florian Koeberle <florianskarten@web.de>
---
 .../jgit/treewalk/rules/AddRulesFactory.java       |   90 ++++++++++++++++++++
 1 files changed, 90 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/treewalk/rules/AddRulesFactory.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/rules/AddRulesFactory.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/rules/AddRulesFactory.java
new file mode 100644
index 0000000..3daa928
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/rules/AddRulesFactory.java
@@ -0,0 +1,90 @@
+package org.spearce.jgit.treewalk.rules;
+
+import java.io.File;
+import java.io.FileNotFoundException;
+import java.io.IOException;
+import java.util.ArrayList;
+import java.util.List;
+
+import org.spearce.jgit.errors.InvalidPatternException;
+import org.spearce.jgit.errors.PathNotInProjectDirectoryException;
+import static org.spearce.jgit.lib.Constants.REPOSITORY_DIRECTORY_NAME;
+
+/**
+ * This class is designed to serve the needs of someone who want to implement a
+ * git-add command and needs to determine the files to add.
+ * 
+ */
+public class AddRulesFactory {
+	private final RuleListToObjectConverter converter = new RuleListToObjectConverter();
+
+	private final IgnoreRuleListFactory ignoreRuleListFactory = new IgnoreRuleListFactory();
+
+	private final AddRuleListFactory addRuleListFactory = new AddRuleListFactory();
+
+	/**
+	 * @param workTreeDirectory
+	 *            The directory with the files of the project under version
+	 *            control.
+	 * @param workingDirectory
+	 *            a directory within the workTreeDirectory.
+	 * @param filePatternsOfAddCommand
+	 *            the file patterns passed to the add command.
+	 * @return a {@link Rules} containing the specified rules, the .gitignore
+	 *         and the .git/info/exclude rules.
+	 * @throws InvalidPatternException
+	 *             if a pattern is invalid.
+	 * @throws PathNotInProjectDirectoryException
+	 *             if the directory workingDirectory is not in workTreeDirectory
+	 * @throws IOException
+	 *             for some reasons.
+	 */
+	public Rules createRules(File workTreeDirectory, File workingDirectory,
+			List<String> filePatternsOfAddCommand)
+			throws InvalidPatternException, PathNotInProjectDirectoryException,
+			IOException {
+		final Rule gitDirectoryIgnoreRule = createGitDirectoryIgnoreRule();
+		final File gitDirectory = new File(workTreeDirectory,
+				REPOSITORY_DIRECTORY_NAME);
+		final List<Rule> ignoreRuleListFromFiles = createExcludeRules(
+				workTreeDirectory, gitDirectory);
+		final List<Rule> includeRules = addRuleListFactory.createRuleList(
+				workTreeDirectory, workingDirectory, filePatternsOfAddCommand);
+		final List<Rule> ruleList = new ArrayList<Rule>();
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
+			File gitDirectory) throws InvalidPatternException {
+		final List<File> possibleIgnoreFiles = new ArrayList<File>(2);
+		possibleIgnoreFiles.add(new File(projectDirectory, ".gitignore"));
+		possibleIgnoreFiles.add(new File(new File(gitDirectory, "info"),
+				"exclude"));
+
+		final List<File> ignoreFiles = new ArrayList<File>();
+		for (File possibleIgnoreFile : possibleIgnoreFiles) {
+			if (possibleIgnoreFile.isFile()) {
+				ignoreFiles.add(possibleIgnoreFile);
+			}
+		}
+
+		try {
+			return ignoreRuleListFactory.createIgnoreRuleList(ignoreFiles);
+		} catch (FileNotFoundException e) {
+			throw new RuntimeException("unexpected removal of ignore files", e);
+		}
+	}
+
+	private Rule createGitDirectoryIgnoreRule() throws InvalidPatternException {
+		final FilePattern gitDirectoryPattern = new FilePathPattern(
+				REPOSITORY_DIRECTORY_NAME, true, true);
+		final Rule gitDirectoryIgnoreRule = new Rule(true, gitDirectoryPattern);
+		return gitDirectoryIgnoreRule;
+	}
+}
-- 
1.5.4.3

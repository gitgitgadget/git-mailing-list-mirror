From: Florian Koeberle <florianskarten@web.de>
Subject: [JGIT PATCH v2 20/24] Added class AddRulesFactory.
Date: Mon, 12 May 2008 22:13:38 +0200
Message-ID: <1210623222-24908-21-git-send-email-florianskarten@web.de>
References: <1210623222-24908-1-git-send-email-florianskarten@web.de>
Cc: Florian Koeberle <florianskarten@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 12 22:23:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JveSg-00086f-3v
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 22:17:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757111AbYELUOV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 16:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758283AbYELUOU
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 16:14:20 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:40227 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757810AbYELUNz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 16:13:55 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate01.web.de (Postfix) with ESMTP id DAF25DECFD09
	for <git@vger.kernel.org>; Mon, 12 May 2008 22:13:54 +0200 (CEST)
Received: from [84.150.98.143] (helo=localhost.localdomain)
	by smtp05.web.de with asmtp (WEB.DE 4.109 #226)
	id 1JvePC-00016x-00; Mon, 12 May 2008 22:13:54 +0200
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1210623222-24908-1-git-send-email-florianskarten@web.de>
X-Sender: florianskarten@web.de
X-Provags-ID: V01U2FsdGVkX19r97BQWihKnO7jAE1EtW065fwKPu0MSUMeJGHZ
	ax9wJNG0jerC0vWfO6pUjgvdNPZcRVOxx6ZoXK3pc4lxXpNLbq
	h6iv8awvkPKyHLAcDktg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81932>

Signed-off-by: Florian Koeberle <florianskarten@web.de>
---
 .../jgit/treewalk/rules/AddRulesFactory.java       |   91 ++++++++++++++++++++
 1 files changed, 91 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/treewalk/rules/AddRulesFactory.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/rules/AddRulesFactory.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/rules/AddRulesFactory.java
new file mode 100644
index 0000000..c1f9a6f
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/rules/AddRulesFactory.java
@@ -0,0 +1,91 @@
+package org.spearce.jgit.treewalk.rules;
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
+			File gitDirectory) {
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
+	private Rule createGitDirectoryIgnoreRule() {
+		final FilePattern gitDirectoryPattern = new ComplexFilePattern(Arrays
+				.asList(REPOSITORY_DIRECTORY_NAME), true);
+		final Rule gitDirectoryIgnoreRule = new Rule(true, gitDirectoryPattern);
+		return gitDirectoryIgnoreRule;
+	}
+}
-- 
1.5.4.3

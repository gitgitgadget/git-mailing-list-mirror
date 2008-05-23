From: Florian Koeberle <florianskarten@web.de>
Subject: [JGIT PATCH v3 12/23] Added the class AddRuleListFactory.
Date: Fri, 23 May 2008 22:34:21 +0200
Message-ID: <1211574872-23676-13-git-send-email-florianskarten@web.de>
References: <1211574872-23676-1-git-send-email-florianskarten@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Florian Koeberle <florianskarten@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 23 22:36:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jze07-0006CA-AZ
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 22:36:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758818AbYEWUfV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 16:35:21 -0400
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759016AbYEWUfT
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 16:35:19 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:35507 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758818AbYEWUet (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 16:34:49 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id A2741E08523E
	for <git@vger.kernel.org>; Fri, 23 May 2008 22:34:39 +0200 (CEST)
Received: from [84.150.81.80] (helo=localhost.localdomain)
	by smtp06.web.de with asmtp (WEB.DE 4.109 #226)
	id 1JzdyJ-0005iq-00; Fri, 23 May 2008 22:34:39 +0200
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1211574872-23676-1-git-send-email-florianskarten@web.de>
X-Sender: florianskarten@web.de
X-Provags-ID: V01U2FsdGVkX1+F4XStK06WBhmUiZPk8gU3ef2ei75+XP0XJYvl
	PFKHa7bK/AJH1pivyDBGmj12UwpvWUAIZBJm7BU/NUeZgvlypO
	zSL/49F4tiVKWkkWx9GA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82750>

Signed-off-by: Florian Koeberle <florianskarten@web.de>
---
 .../jgit/treewalk/rules/AddRuleListFactory.java    |   75 ++++++++++++=
++++++++
 1 files changed, 75 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/treewalk/rule=
s/AddRuleListFactory.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/rules/AddRu=
leListFactory.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/rul=
es/AddRuleListFactory.java
new file mode 100644
index 0000000..5c385c1
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/rules/AddRuleListF=
actory.java
@@ -0,0 +1,75 @@
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
+import java.util.List;
+
+import org.spearce.jgit.errors.InvalidPatternException;
+import org.spearce.jgit.errors.PathNotInProjectDirectoryException;
+
+class AddRuleListFactory {
+
+	private static String getRelativeUnixPath(File projectDirectory, File=
 file)
+			throws PathNotInProjectDirectoryException, IOException {
+		final StringBuilder resultBuilder =3D new StringBuilder();
+		File currentFile =3D file.getCanonicalFile();
+		while (!currentFile.equals(projectDirectory)) {
+			if (resultBuilder.length() > 0) {
+				resultBuilder.insert(0, '/');
+			}
+			resultBuilder.insert(0, currentFile.getName());
+			currentFile =3D currentFile.getParentFile();
+			if (currentFile =3D=3D null) {
+				throw new PathNotInProjectDirectoryException();
+			}
+		}
+		return resultBuilder.toString();
+	}
+
+	List<Rule> createRuleList(File projectDirectory, File workingDirector=
y,
+			List<String> filePatternsOfAddCommand)
+			throws PathNotInProjectDirectoryException, IOException,
+			InvalidPatternException {
+
+		final String workingDirectoryPath =3D getRelativeUnixPath(
+				projectDirectory, workingDirectory);
+
+		final List<Rule> ruleList =3D new ArrayList<Rule>(
+				filePatternsOfAddCommand.size());
+		for (String pattern : filePatternsOfAddCommand) {
+			boolean matchDirectoriesOnly =3D false;
+			if (pattern.endsWith(File.separator)) {
+				pattern =3D pattern.substring(0, pattern.length() - 1);
+				matchDirectoriesOnly =3D true;
+			}
+			pattern =3D pattern.replace(File.separatorChar, '/');
+			if (!"".equals(workingDirectoryPath)) {
+				pattern =3D workingDirectoryPath + "/" + pattern;
+
+			}
+			final FilePattern filePattern =3D new FilePathPattern(pattern, true=
,
+					matchDirectoriesOnly);
+			final Rule rule =3D new Rule(false, filePattern);
+			ruleList.add(rule);
+
+		}
+		return ruleList;
+	}
+}
--=20
1.5.4.3

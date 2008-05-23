From: Florian Koeberle <florianskarten@web.de>
Subject: [JGIT PATCH v3 08/23] Added the class IgnoreRuleListFactory.
Date: Fri, 23 May 2008 22:34:17 +0200
Message-ID: <1211574872-23676-9-git-send-email-florianskarten@web.de>
References: <1211574872-23676-1-git-send-email-florianskarten@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Florian Koeberle <florianskarten@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 23 22:36:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jze00-0006CA-Kv
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 22:36:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759123AbYEWUe5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 16:34:57 -0400
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758963AbYEWUez
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 16:34:55 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:45452 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757054AbYEWUej (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 16:34:39 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate03.web.de (Postfix) with ESMTP id 7AD9FDC4A1E4
	for <git@vger.kernel.org>; Fri, 23 May 2008 22:34:37 +0200 (CEST)
Received: from [84.150.81.80] (helo=localhost.localdomain)
	by smtp06.web.de with asmtp (WEB.DE 4.109 #226)
	id 1JzdyH-0005iq-00; Fri, 23 May 2008 22:34:37 +0200
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1211574872-23676-1-git-send-email-florianskarten@web.de>
X-Sender: florianskarten@web.de
X-Provags-ID: V01U2FsdGVkX1+Mqycx24bsoxhJvSszCZHQTN1sgTm+uS7Swi7+
	yTSi0GXy9t7178S6qeCtHcIiBh2moGiFDd7bS8UtRH/ImylhWu
	fuIcqBUv+HMoJHlydI0g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82748>

Signed-off-by: Florian Koeberle <florianskarten@web.de>
---
 .../jgit/treewalk/rules/IgnoreRuleListFactory.java |   94 ++++++++++++=
++++++++
 1 files changed, 94 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/treewalk/rule=
s/IgnoreRuleListFactory.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/rules/Ignor=
eRuleListFactory.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/=
rules/IgnoreRuleListFactory.java
new file mode 100644
index 0000000..98f1169
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/rules/IgnoreRuleLi=
stFactory.java
@@ -0,0 +1,94 @@
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
+import java.io.FileNotFoundException;
+import java.util.ArrayList;
+import java.util.LinkedList;
+import java.util.List;
+import java.util.Scanner;
+
+import org.spearce.jgit.errors.InvalidPatternException;
+
+/**
+ * This class can be used to create lists of {@link Rule} objects from=
 lines of
+ * .gitignore like files.
+ *=20
+ */
+class IgnoreRuleListFactory {
+
+	List<Rule> createIgnoreRuleList(final Iterable<String> lineIterable)
+			throws InvalidPatternException {
+		LinkedList<Rule> rules =3D new LinkedList<Rule>();
+		for (String line : lineIterable) {
+			final String trimmedLine =3D line.trim();
+			if (trimmedLine.startsWith("#")) {
+				continue;
+			}
+			if (trimmedLine.length() =3D=3D 0) {
+				continue;
+			}
+			rules.add(0, createRule(trimmedLine));
+		}
+		return rules;
+	}
+
+	List<Rule> createIgnoreRuleList(final List<File> files)
+			throws FileNotFoundException, InvalidPatternException {
+		final List<String> lines =3D new ArrayList<String>();
+		for (File file : files) {
+			Scanner scanner =3D new Scanner(file);
+			try {
+				while (scanner.hasNextLine()) {
+					lines.add(scanner.nextLine());
+				}
+			} finally {
+				scanner.close();
+			}
+		}
+		return createIgnoreRuleList(lines);
+	}
+
+	private Rule createRule(String patternString)
+			throws InvalidPatternException {
+		final boolean inverse =3D patternString.startsWith("!");
+		if (inverse)
+			patternString =3D patternString.substring(1);
+
+		final FilePattern pattern =3D createFilePattern(patternString);
+		return new Rule(!inverse, pattern);
+	}
+
+	private FilePattern createFilePattern(String patternString)
+			throws InvalidPatternException {
+		final boolean matchDirectoriesOnly =3D patternString.endsWith("/");
+		if (matchDirectoriesOnly)
+			patternString =3D patternString.substring(0,
+					patternString.length() - 1);
+		if (patternString.contains("/")) {
+			if (patternString.startsWith("/"))
+				patternString =3D patternString.substring(1);
+
+			return new FilePathPattern(patternString, false,
+					matchDirectoriesOnly);
+		} else {
+			return new FileNamePattern(patternString, matchDirectoriesOnly);
+		}
+	}
+
+}
--=20
1.5.4.3

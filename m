From: Florian Koeberle <florianskarten@web.de>
Subject: [JGIT PATCH v2 14/24] Added the class IgnoreRuleListFactory.
Date: Mon, 12 May 2008 22:13:32 +0200
Message-ID: <1210623222-24908-15-git-send-email-florianskarten@web.de>
References: <1210623222-24908-1-git-send-email-florianskarten@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Florian Koeberle <florianskarten@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 12 22:21:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JveQF-0006mx-P5
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 22:15:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758243AbYELUOE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 16:14:04 -0400
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758099AbYELUN7
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 16:13:59 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:40261 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755926AbYELUNw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 16:13:52 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate01.web.de (Postfix) with ESMTP id 20797DECFC2A
	for <git@vger.kernel.org>; Mon, 12 May 2008 22:13:48 +0200 (CEST)
Received: from [84.150.98.143] (helo=localhost.localdomain)
	by smtp05.web.de with asmtp (WEB.DE 4.109 #226)
	id 1JveP5-00016x-01; Mon, 12 May 2008 22:13:47 +0200
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1210623222-24908-1-git-send-email-florianskarten@web.de>
X-Sender: florianskarten@web.de
X-Provags-ID: V01U2FsdGVkX1+JmXdLKtt2WX9D05BE/wVe48ElrOGxb3heXk+0
	5AQQT2Twr80zbq5eLqoipIUI3Mefb7PBBIzhFLUc1YsciDx+en
	MtDg9S73oVMhhlATLDUg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81919>

Signed-off-by: Florian Koeberle <florianskarten@web.de>
---
 .../jgit/treewalk/rules/IgnoreRuleListFactory.java |  104 ++++++++++++=
++++++++
 1 files changed, 104 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/treewalk/rule=
s/IgnoreRuleListFactory.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/rules/Ignor=
eRuleListFactory.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/=
rules/IgnoreRuleListFactory.java
new file mode 100644
index 0000000..6634098
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/rules/IgnoreRuleLi=
stFactory.java
@@ -0,0 +1,104 @@
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
+import java.util.StringTokenizer;
+
+/**
+ * This class can be used to create lists of {@link Rule} objects from=
 lines of
+ * .gitignore like files.
+ *=20
+ */
+class IgnoreRuleListFactory {
+
+	List<Rule> createIgnoreRuleList(Iterable<String> lineIterable) {
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
+	List<Rule> createIgnoreRuleList(List<File> files)
+			throws FileNotFoundException {
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
+	private Rule createRule(String trimmedLine) {
+		final boolean exclude;
+		String patternString;
+		if (trimmedLine.startsWith("!")) {
+			exclude =3D false;
+			patternString =3D trimmedLine.substring(1);
+		} else {
+			exclude =3D true;
+			patternString =3D trimmedLine;
+		}
+
+		final boolean matchDirectoriesOnly;
+		if (patternString.endsWith("/")) {
+			matchDirectoriesOnly =3D true;
+			patternString =3D patternString.substring(0,
+					patternString.length() - 1);
+		} else {
+			matchDirectoriesOnly =3D false;
+		}
+
+		final FilePattern pattern;
+		if (patternString.contains("/")) {
+			if (patternString.startsWith("/")) {
+				patternString =3D patternString.substring(1);
+			}
+			final StringTokenizer stringTokenizer =3D new StringTokenizer(
+					patternString, "/");
+			final List<String> patternList =3D new ArrayList<String>();
+			while (stringTokenizer.hasMoreTokens()) {
+				final String token =3D stringTokenizer.nextToken();
+				patternList.add(token);
+			}
+			pattern =3D new ComplexFilePattern(patternList, matchDirectoriesOnl=
y);
+		} else {
+			pattern =3D new GlobalFilePattern(patternString, matchDirectoriesOn=
ly);
+		}
+		return new Rule(exclude, pattern);
+	}
+
+}
--=20
1.5.4.3

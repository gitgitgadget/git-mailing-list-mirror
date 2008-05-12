From: Florian Koeberle <florianskarten@web.de>
Subject: [JGIT PATCH v2 13/24] Added the class ComplexFilePattern.
Date: Mon, 12 May 2008 22:13:31 +0200
Message-ID: <1210623222-24908-14-git-send-email-florianskarten@web.de>
References: <1210623222-24908-1-git-send-email-florianskarten@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Florian Koeberle <florianskarten@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 12 22:21:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JveQE-0006mx-GV
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 22:14:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758097AbYELUN7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 16:13:59 -0400
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758063AbYELUN6
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 16:13:58 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:40260 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755974AbYELUNw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 16:13:52 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate01.web.de (Postfix) with ESMTP id 9C015DECFD1D
	for <git@vger.kernel.org>; Mon, 12 May 2008 22:13:47 +0200 (CEST)
Received: from [84.150.98.143] (helo=localhost.localdomain)
	by smtp05.web.de with asmtp (WEB.DE 4.109 #226)
	id 1JveP5-00016x-00; Mon, 12 May 2008 22:13:47 +0200
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1210623222-24908-1-git-send-email-florianskarten@web.de>
X-Sender: florianskarten@web.de
X-Provags-ID: V01U2FsdGVkX19TFUYgrx5eFJmgDdoG7ZNXMNGffmfnFmClXQLC
	1hncCukx6dkwMkzesVlCyswf/lzwJgsip9iFhIy/ThGHPzaNx7
	OoY00LLMoODH1k3u6OJA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81922>

Signed-off-by: Florian Koeberle <florianskarten@web.de>
---
 .../jgit/treewalk/rules/ComplexFilePattern.java    |   97 ++++++++++++=
++++++++
 1 files changed, 97 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/treewalk/rule=
s/ComplexFilePattern.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/rules/Compl=
exFilePattern.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/rul=
es/ComplexFilePattern.java
new file mode 100644
index 0000000..7c2aba0
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/rules/ComplexFileP=
attern.java
@@ -0,0 +1,97 @@
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
+import java.util.List;
+import java.util.ArrayList;
+
+import org.spearce.jgit.lib.FNMatchPattern;
+
+/**
+ * A {@link ComplexFilePattern} defines for some components of a file =
path
+ * fnmatch like patterns. For example could such a pattern be that the=
 first
+ * directory must start with an a and that the second directory must e=
nd with
+ * and b. In the example the pathes axx/xxb/hello.txt and ayy/yyb woul=
d match,
+ * but axx would not match.
+ *=20
+ */
+class ComplexFilePattern implements FilePattern {
+	private final List<FNMatchPattern> usedPatternList;
+
+	private final boolean matchDirectoriesOnly;
+
+	private final int offset;
+
+	private ComplexFilePattern(List<FNMatchPattern> List,
+			boolean matchDirectoriesOnly, int offset) {
+		this.usedPatternList =3D List;
+		this.matchDirectoriesOnly =3D matchDirectoriesOnly;
+		this.offset =3D offset;
+	}
+
+	ComplexFilePattern(List<String> patternStrings, boolean matchDirector=
iesOnly) {
+		this.usedPatternList =3D new ArrayList<FNMatchPattern>(patternString=
s
+				.size());
+		for (String patternString : patternStrings) {
+			this.usedPatternList.add(new FNMatchPattern(patternString));
+		}
+		this.offset =3D 0;
+		this.matchDirectoriesOnly =3D matchDirectoriesOnly;
+	}
+
+	int getActualPathSize() {
+		return usedPatternList.size() - offset;
+	}
+
+	private FNMatchPattern getPatternOfCurrentLevel() {
+		return usedPatternList.get(offset);
+	}
+
+	public boolean canMatchAtThisDirectoryLevel() {
+		return getActualPathSize() =3D=3D 1;
+	}
+
+	public FilePattern getPatternForSubDirectory(String directoryName) {
+
+		if (getActualPathSize() > 1) {
+			if (getPatternOfCurrentLevel().matches(directoryName)) {
+				return new ComplexFilePattern(usedPatternList,
+						matchDirectoriesOnly, offset + 1);
+			} else {
+				return FilePattern.MATCH_NEVER;
+			}
+		}
+		assert (getActualPathSize() =3D=3D 1);
+		if (match(directoryName, true)) {
+			return FilePattern.MATCH_ALWAYS;
+		} else {
+			return FilePattern.MATCH_NEVER;
+		}
+	}
+
+	public boolean match(String fileName, boolean fileIsDirectory) {
+		if (!fileIsDirectory && matchDirectoriesOnly) {
+			return false;
+		}
+		return getPatternOfCurrentLevel().matches(fileName);
+	}
+
+	public boolean isSameForSubDirectories() {
+		return false;
+	}
+
+}
--=20
1.5.4.3

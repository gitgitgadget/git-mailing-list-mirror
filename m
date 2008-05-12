From: Florian Koeberle <florianskarten@web.de>
Subject: [JGIT PATCH v2 11/24] Added the class FNMatchPattern.
Date: Mon, 12 May 2008 22:13:29 +0200
Message-ID: <1210623222-24908-12-git-send-email-florianskarten@web.de>
References: <1210623222-24908-1-git-send-email-florianskarten@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Florian Koeberle <florianskarten@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 12 22:23:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JveSj-00086f-EQ
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 22:17:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755386AbYELUOf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 16:14:35 -0400
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757610AbYELUOd
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 16:14:33 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:40227 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754311AbYELUNt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 16:13:49 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate01.web.de (Postfix) with ESMTP id B6947DECFD14
	for <git@vger.kernel.org>; Mon, 12 May 2008 22:13:46 +0200 (CEST)
Received: from [84.150.98.143] (helo=localhost.localdomain)
	by smtp05.web.de with asmtp (WEB.DE 4.109 #226)
	id 1JveP4-00016x-00; Mon, 12 May 2008 22:13:46 +0200
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1210623222-24908-1-git-send-email-florianskarten@web.de>
X-Sender: florianskarten@web.de
X-Provags-ID: V01U2FsdGVkX18KRJJ02Z7JPkyrBQVo7F5ZTooG/YAjaUXMkK0S
	K7ZHt0LBaptSR0PL0JkYume3yTea6ZNKG9E79Xb+OHcz2gHcLh
	g0f3iWJx370HB+JMMg4g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81930>

Signed-off-by: Florian Koeberle <florianskarten@web.de>
---
 .../src/org/spearce/jgit/lib/FNMatchPattern.java   |   81 ++++++++++++=
++++++++
 1 files changed, 81 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/FNMatchPa=
ttern.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/FNMatchPattern.j=
ava b/org.spearce.jgit/src/org/spearce/jgit/lib/FNMatchPattern.java
new file mode 100644
index 0000000..005659e
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/FNMatchPattern.java
@@ -0,0 +1,81 @@
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
+package org.spearce.jgit.lib;
+
+import java.util.regex.Pattern;
+
+/**
+ * This class represents a pattern which should work like the fnmatch =
method.
+ * <code>new FNMatchPattern(exp).matches(input)</code> should do the s=
ame like
+ * <code>fnmatch(exp, input, 0) =3D=3D 0</code>
+ *=20
+ * As this isn't a one to one code port, but written based on the docu=
mentation
+ * of fnmatch it can be that the behavior of this class differ in some=
 corner
+ * cases from the behavior of the fnmatch function.
+ */
+public class FNMatchPattern {
+
+	private final Pattern regexPattern;
+
+	private static String toRegexString(String fnmatchPattern) {
+		final StringBuilder regexStringBuilder =3D new StringBuilder();
+		char perviosCharacter =3D 0;
+		for (int i =3D 0; i < fnmatchPattern.length(); i++) {
+			final char c =3D fnmatchPattern.charAt(i);
+			switch (c) {
+			case '^':
+				if (perviosCharacter =3D=3D '[') {
+					regexStringBuilder.append('!');
+				} else {
+					regexStringBuilder.append("\\x5E");
+				}
+				break;
+			case '.':
+				regexStringBuilder.append("\\x2E");
+				break;
+			case '*':
+				regexStringBuilder.append(".*");
+				break;
+			default:
+				regexStringBuilder.append(c);
+			}
+			perviosCharacter =3D c;
+		}
+		return regexStringBuilder.toString();
+	}
+
+	/**
+	 *=20
+	 * @param fnmatchPattern
+	 *            must be a valid fnmatch pattern string.
+	 */
+	public FNMatchPattern(String fnmatchPattern) {
+		final String regularExpression =3D toRegexString(fnmatchPattern);
+		this.regexPattern =3D Pattern.compile(regularExpression);
+	}
+
+	/**
+	 *=20
+	 * @param stringToMatch
+	 *            the string to match.
+	 * @return true when this pattern matches.
+	 */
+	public boolean matches(String stringToMatch) {
+		return regexPattern.matcher(stringToMatch).matches();
+	}
+
+}
--=20
1.5.4.3

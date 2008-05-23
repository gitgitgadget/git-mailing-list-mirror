From: Florian Koeberle <florianskarten@web.de>
Subject: [JGIT PATCH v3 17/23] Added class LightFileTreeIterable.
Date: Fri, 23 May 2008 22:34:26 +0200
Message-ID: <1211574872-23676-18-git-send-email-florianskarten@web.de>
References: <1211574872-23676-1-git-send-email-florianskarten@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Florian Koeberle <florianskarten@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 23 22:36:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jze03-0006CA-BL
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 22:36:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759158AbYEWUfH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 16:35:07 -0400
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759154AbYEWUfG
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 16:35:06 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:39667 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757438AbYEWUem (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 16:34:42 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate02.web.de (Postfix) with ESMTP id D89B3DE1A86D
	for <git@vger.kernel.org>; Fri, 23 May 2008 22:34:41 +0200 (CEST)
Received: from [84.150.81.80] (helo=localhost.localdomain)
	by smtp06.web.de with asmtp (WEB.DE 4.109 #226)
	id 1JzdyL-0005iq-00; Fri, 23 May 2008 22:34:41 +0200
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1211574872-23676-1-git-send-email-florianskarten@web.de>
X-Sender: florianskarten@web.de
X-Provags-ID: V01U2FsdGVkX18R2OfG72/AohI//Aqd3wcyeauOq+wQoPFfwC02
	YPOtaGvIAM+A/b7/KkMIllav3VaT905mRPM10RBKsPiFh79HLM
	vBlKuo2KZuCH87jj2g6g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82753>

Signed-off-by: Florian Koeberle <florianskarten@web.de>
---
 .../jgit/treewalk/LightFileTreeIterable.java       |   59 ++++++++++++=
++++++++
 1 files changed, 59 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/treewalk/Ligh=
tFileTreeIterable.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/LightFileTr=
eeIterable.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/LightF=
ileTreeIterable.java
new file mode 100644
index 0000000..5768f78
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/LightFileTreeItera=
ble.java
@@ -0,0 +1,59 @@
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
+package org.spearce.jgit.treewalk;
+
+import java.io.File;
+import java.util.Iterator;
+
+import org.spearce.jgit.treewalk.rules.Rules;
+
+/**
+ * Use this class to iterate over some by rules determined files in a =
project
+ * directory.
+ *=20
+ */
+public class LightFileTreeIterable implements Iterable<File> {
+	private final File projectDirectory;
+
+	private final Rules ignoreRules;
+
+	private final boolean includeRootDirectory;
+
+	/**
+	 *=20
+	 * @param workTreeDirectory
+	 *            directory with the files which are under version contro=
l.
+	 * @param rules
+	 *            a {@link Rules} instance which is used to determine whi=
ch file
+	 *            are included and which not.
+	 * @param includeWorkTreeDirectory
+	 *            determines if the iterators should return the
+	 *            workTreeDirectory
+	 */
+	public LightFileTreeIterable(File workTreeDirectory, Rules rules,
+			boolean includeWorkTreeDirectory) {
+		this.projectDirectory =3D workTreeDirectory;
+		this.ignoreRules =3D rules;
+		this.includeRootDirectory =3D includeWorkTreeDirectory;
+	}
+
+	public Iterator<File> iterator() {
+		return new LightFileTreeIterator(projectDirectory, ignoreRules,
+				includeRootDirectory);
+	}
+
+}
--=20
1.5.4.3

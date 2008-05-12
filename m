From: Florian Koeberle <florianskarten@web.de>
Subject: [JGIT PATCH v2 05/24] Added WorkTree class which can be constructed over Repository.
Date: Mon, 12 May 2008 22:13:23 +0200
Message-ID: <1210623222-24908-6-git-send-email-florianskarten@web.de>
References: <1210623222-24908-1-git-send-email-florianskarten@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Florian Koeberle <florianskarten@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 12 22:23:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JveSn-00086f-Qa
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 22:17:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755184AbYELUOv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 16:14:51 -0400
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753224AbYELUOt
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 16:14:49 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:40152 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754125AbYELUNo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 16:13:44 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate01.web.de (Postfix) with ESMTP id C6E33DECFCC7
	for <git@vger.kernel.org>; Mon, 12 May 2008 22:13:43 +0200 (CEST)
Received: from [84.150.98.143] (helo=localhost.localdomain)
	by smtp05.web.de with asmtp (WEB.DE 4.109 #226)
	id 1JveP1-00016x-00; Mon, 12 May 2008 22:13:43 +0200
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1210623222-24908-1-git-send-email-florianskarten@web.de>
X-Sender: florianskarten@web.de
X-Provags-ID: V01U2FsdGVkX1/CkWKYQvQfCDQ2W5LdlTvCDS26Pz1TUEjaxNNQ
	aGg7mvYY93+rl5wNY+WJVcF/llURSQyb1CFN+xiEmQPkF88bcK
	xs1SRUjH0DwccTLlGC8g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81927>

---
 .../src/org/spearce/jgit/lib/Repository.java       |   30 +++++++++
 .../src/org/spearce/jgit/lib/WorkTree.java         |   67 ++++++++++++=
++++++++
 2 files changed, 97 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/WorkTree.=
java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java =
b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index 44fd81b..3186fe2 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -1212,4 +1212,34 @@ public class Repository {
 		return mapCommit;
 	}
=20
+	/**
+	 * Creates a new {@link WorkTree} and initialize a repository for it.
+	 *=20
+	 * @param workTreeDirectory
+	 *            the directory with the project files.
+	 * @return a new {@link WorkTree} with a new and open {@link Reposito=
ry}.
+	 * @throws IOException
+	 *             thrown by {@link Repository#create()}
+	 */
+	public static WorkTree createWorkTree(File workTreeDirectory)
+			throws IOException {
+		final File gitDirectory =3D new File(workTreeDirectory,
+				Constants.REPOSITORY_DIRECTORY_NAME);
+		if (gitDirectory.exists()) {
+			throw new IllegalArgumentException(
+					"Repository exists in given project directory.");
+		}
+		final Repository repository =3D new Repository(gitDirectory);
+		try {
+			repository.create();
+			return new WorkTree(workTreeDirectory, repository);
+		} catch (RuntimeException e) {
+			repository.close();
+			throw e;
+		} catch (IOException e) {
+			repository.close();
+			throw e;
+		}
+	}
+
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/WorkTree.java b/=
org.spearce.jgit/src/org/spearce/jgit/lib/WorkTree.java
new file mode 100644
index 0000000..14bdda0
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/WorkTree.java
@@ -0,0 +1,67 @@
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
+import java.io.File;
+
+/**
+ * Represents a work tree controlled by git. Use {@link Repository} in=
 order to
+ * create an object of this class.
+ *=20
+ */
+public class WorkTree {
+	private final File directory;
+
+	private final Repository repository;
+
+	/**
+	 * This constructor should be only used by the class {@link Repositor=
y}.
+	 *=20
+	 * @param directory
+	 *            defines the value of the directory field.
+	 * @param repository
+	 *            defines the value of the repository field.
+	 */
+	WorkTree(File directory, Repository repository) {
+		this.directory =3D directory;
+		this.repository =3D repository;
+	}
+
+	/**
+	 *=20
+	 * @return the directory which contains the files of the project. Usu=
ally
+	 *         this directory contain a .git directory with the repositor=
y.
+	 */
+	public File getDirectory() {
+		return directory;
+	}
+
+	/**
+	 * @return the {@link Repository} object of the project.
+	 */
+	public Repository getRepository() {
+		return repository;
+	}
+
+	/**
+	 * Closes the git repository of this project.
+	 */
+	public void closeRepository() {
+		repository.close();
+	}
+
+}
--=20
1.5.4.3

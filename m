From: Florian Koeberle <florianskarten@web.de>
Subject: [JGIT PATCH v3 19/23] Added WorkTree class which can be constructed over Repository.
Date: Fri, 23 May 2008 22:34:28 +0200
Message-ID: <1211574872-23676-20-git-send-email-florianskarten@web.de>
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
	id 1Jze05-0006CA-7X
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 22:36:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758839AbYEWUfO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 16:35:14 -0400
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759167AbYEWUfM
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 16:35:12 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:45447 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756737AbYEWUeo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 16:34:44 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate03.web.de (Postfix) with ESMTP id B2AA1DC4A297
	for <git@vger.kernel.org>; Fri, 23 May 2008 22:34:42 +0200 (CEST)
Received: from [84.150.81.80] (helo=localhost.localdomain)
	by smtp06.web.de with asmtp (WEB.DE 4.109 #226)
	id 1JzdyM-0005iq-00; Fri, 23 May 2008 22:34:42 +0200
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1211574872-23676-1-git-send-email-florianskarten@web.de>
X-Sender: florianskarten@web.de
X-Provags-ID: V01U2FsdGVkX1/jui8I5fLvETvttACbHG404/LbraCd/Sq5uzTL
	9HtCa+4wmGZfOZ80B2wQMiTEJ3Ph/7CEPWyfNXru3LcNfqIN2z
	XrfJ94Z07MdT5PW9lqLg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82746>

---
 .../src/org/spearce/jgit/lib/Repository.java       |   57 ++++++++++++=
+++++
 .../src/org/spearce/jgit/lib/WorkTree.java         |   67 ++++++++++++=
++++++++
 2 files changed, 124 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/WorkTree.=
java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java =
b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index 54edc8a..86817c9 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -1157,4 +1157,61 @@ public class Repository {
 	public File getWorkDir() {
 		return getDirectory().getParentFile();
 	}
+
+	/**
+	 * Setup HEAD and "master" refs for a new repository.
+	 *=20
+	 * @param remoteBranch
+	 *            The remote branch to start with
+	 * @param branch
+	 *            The local branch to configure, initially starting at
+	 *            remoteBranch
+	 * @return the commit references by the new HEAD
+	 * @throws IOException
+	 */
+	public Commit setupHEADRef(final String remoteBranch, final String br=
anch)
+			throws IOException {
+		Commit mapCommit =3D mapCommit(remoteBranch);
+		String refName =3D Constants.HEADS_PREFIX + "/" + branch;
+		LockFile masterRef =3D lockRef(refName);
+		try {
+			masterRef.write(mapCommit.getCommitId());
+			masterRef.commit();
+		} finally {
+			masterRef.unlock();
+		}
+		writeSymref(Constants.HEAD, refName);
+		return mapCommit;
+	}
+
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

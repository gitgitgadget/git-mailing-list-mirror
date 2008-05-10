From: Florian Koeberle <florianskarten@web.de>
Subject: [JGIT PATCH 22/22] Added a "add" command to the git like command line tool.
Date: Sat, 10 May 2008 15:00:40 +0200
Message-ID: <1210424440-13886-23-git-send-email-florianskarten@web.de>
References: <1210424440-13886-1-git-send-email-florianskarten@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Florian Koeberle <florianskarten@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 10 15:03:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Juojn-0008FZ-Oa
	for gcvg-git-2@gmane.org; Sat, 10 May 2008 15:03:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755683AbYEJNBl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 May 2008 09:01:41 -0400
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755557AbYEJNBj
	(ORCPT <rfc822;git-outgoing>); Sat, 10 May 2008 09:01:39 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:44637 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755692AbYEJNAy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 May 2008 09:00:54 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id 38C0ADE986E4
	for <git@vger.kernel.org>; Sat, 10 May 2008 15:00:53 +0200 (CEST)
Received: from [84.150.90.150] (helo=localhost.localdomain)
	by smtp06.web.de with asmtp (WEB.DE 4.109 #226)
	id 1Juoh2-000860-01; Sat, 10 May 2008 15:00:52 +0200
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1210424440-13886-1-git-send-email-florianskarten@web.de>
X-Sender: florianskarten@web.de
X-Provags-ID: V01U2FsdGVkX18OeOyhAYVDCXWwoHCwI1cKWwysK4TDPIzdYFyo
	7P+IR7f4NUVNxOLGGnlpYXMJf54NmsxVChgcEuojZsT/VUrlqG
	ojLvc2eMLATlCY94Tjkg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81676>

---
 .../src/org/spearce/jgit/pgm/AddCommand.java       |   96 ++++++++++++=
++++++++
 .../src/org/spearce/jgit/pgm/MainProgram.java      |    1 +
 2 files changed, 97 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/pgm/AddComman=
d.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/pgm/AddCommand.java =
b/org.spearce.jgit/src/org/spearce/jgit/pgm/AddCommand.java
new file mode 100644
index 0000000..f8d86b1
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/pgm/AddCommand.java
@@ -0,0 +1,96 @@
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
+package org.spearce.jgit.pgm;
+
+import java.io.File;
+import java.io.IOException;
+import java.util.Arrays;
+
+import org.spearce.jgit.errors.InvalidPatternException;
+import org.spearce.jgit.lib.GitIndex;
+import org.spearce.jgit.lib.Project;
+import org.spearce.jgit.lib.ProjectSeeker;
+import org.spearce.jgit.lib.Repository;
+import org.spearce.jgit.lib.GitIndex.Entry;
+import org.spearce.jgit.lib.fileiteration.FileIterableFactoryForAddCom=
mand;
+
+/**
+ * This class is immutable. It's {@link #execute} method is used to ad=
d files to
+ * the index.
+ *=20
+ * @author Florian K=C3=B6berle
+ *=20
+ */
+public class AddCommand implements Command {
+	/**
+	 * Use this instance instead of creating a new ${link AddCommand}. Yo=
u don't
+	 * need to create an instance of this class as it is immutable and no=
t
+	 * configurable.
+	 */
+	public static AddCommand INSTANCE =3D new AddCommand();
+
+	/**
+	 * Adds the specified files to the index.
+	 *=20
+	 * @param args
+	 *            can contain "*.Suffix" patterns, files and directories.
+	 */
+	public void execute(String... args) throws IOException {
+		final ProjectSeeker projectFactory =3D new ProjectSeeker();
+		final Project project =3D projectFactory.findProject();
+		final Repository repository =3D project.getRepository();
+		try {
+			final GitIndex gitIndex =3D repository.getIndex();
+			final File projectDirectory =3D project.getDirectory();
+			final String workingDirectoryString =3D System
+					.getProperty("user.dir");
+			if (workingDirectoryString =3D=3D null) {
+				throw new UnableToDetermineWorkingDirectory();
+			}
+			final File workingDirectory =3D new File(workingDirectoryString);
+			final FileIterableFactoryForAddCommand iterableFactory =3D new File=
IterableFactoryForAddCommand();
+			final Iterable<File> fileIterable =3D iterableFactory
+					.createFileTreeIterable(project, workingDirectory, Arrays
+							.asList(args));
+			for (File path : fileIterable) {
+				if (path.isFile()) {
+					Entry entry =3D gitIndex.add(projectDirectory, path);
+					entry.setAssumeValid(false);
+
+				}
+			}
+			gitIndex.write();
+		} catch (UnableToDetermineWorkingDirectory e) {
+			System.err.println("Unable to determine working directory");
+			System.exit(1);
+		} catch (InvalidPatternException e) {
+			System.err.printf("The pattern '%s' is invalid: %s",
+					e.getMessage(), e.getPattern());
+			System.exit(1);
+		} finally {
+			repository.close();
+		}
+	}
+
+	public String getShortDescription() {
+		return "Adds one or more files to the index.";
+	}
+
+	private static class UnableToDetermineWorkingDirectory extends Except=
ion {
+		private static final long serialVersionUID =3D -4229647819515644868L=
;
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/pgm/MainProgram.java=
 b/org.spearce.jgit/src/org/spearce/jgit/pgm/MainProgram.java
index 7601f31..78aaccd 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/pgm/MainProgram.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/pgm/MainProgram.java
@@ -35,6 +35,7 @@ public class MainProgram {
=20
 	static {
 		final Map<String, Command> commands =3D new HashMap<String, Command>=
();
+		commands.put("add", AddCommand.INSTANCE);
 		commands.put("init", InitCommand.INSTANCE);
 		commands.put("help", HelpCommand.INSTANCE);
 		commandNameToObjectMap =3D Collections.unmodifiableMap(commands);
--=20
1.5.2.5

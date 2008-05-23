From: Florian Koeberle <florianskarten@web.de>
Subject: [JGIT PATCH v3 22/23] Added findWorkTree method to Repository class.
Date: Fri, 23 May 2008 22:34:31 +0200
Message-ID: <1211574872-23676-23-git-send-email-florianskarten@web.de>
References: <1211574872-23676-1-git-send-email-florianskarten@web.de>
Cc: Florian Koeberle <florianskarten@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 23 22:36:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jze05-0006CA-Rk
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 22:36:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754528AbYEWUfR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 16:35:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759167AbYEWUfO
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 16:35:14 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:45516 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758296AbYEWUep (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 16:34:45 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate03.web.de (Postfix) with ESMTP id 70801DC4A263
	for <git@vger.kernel.org>; Fri, 23 May 2008 22:34:44 +0200 (CEST)
Received: from [84.150.81.80] (helo=localhost.localdomain)
	by smtp06.web.de with asmtp (WEB.DE 4.109 #226)
	id 1JzdyN-0005iq-01; Fri, 23 May 2008 22:34:44 +0200
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1211574872-23676-1-git-send-email-florianskarten@web.de>
X-Sender: florianskarten@web.de
X-Provags-ID: V01U2FsdGVkX1+9FLd+3AIzRYtw370LgawbioeAH4uealkbbBN7
	+FwJM4JI+BFf3RlTWy2hNURq/xr9x1180sOhs3hcpzke5Tdsnc
	H4p4ivYDC+JapmMm8Ilw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82741>

Signed-off-by: Florian Koeberle <florianskarten@web.de>
---
 .../src/org/spearce/jgit/lib/Repository.java       |   80 ++++++++++++++++++++
 1 files changed, 80 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index 06e686f..71e0e04 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -16,6 +16,11 @@
  */
 package org.spearce.jgit.lib;
 
+import static org.spearce.jgit.lib.Constants.HEAD;
+import static org.spearce.jgit.lib.Constants.OBJECTS_DIRECTORY_NAME;
+import static org.spearce.jgit.lib.Constants.REFS_DIRECTORY_NAME;
+import static org.spearce.jgit.lib.Constants.REPOSITORY_DIRECTORY_NAME;
+
 import java.io.BufferedReader;
 import java.io.File;
 import java.io.FileNotFoundException;
@@ -29,6 +34,7 @@ import java.util.Map;
 import java.util.Set;
 
 import org.spearce.jgit.errors.IncorrectObjectTypeException;
+import org.spearce.jgit.errors.NoGitRepositoryFoundException;
 import org.spearce.jgit.errors.ObjectWritingException;
 import org.spearce.jgit.errors.RevisionSyntaxException;
 import org.spearce.jgit.stgit.StGitPatch;
@@ -1253,4 +1259,78 @@ public class Repository {
 		}
 	}
 
+	/**
+	 * Find the git repository for the current working directory.
+	 * 
+	 * @return a {@link Repository}.
+	 * @throws NoGitRepositoryFoundException
+	 *             if no git repository could be found for the current
+	 *             directory.
+	 * @throws IOException
+	 *             if not able to determine the absolute path of the current
+	 *             working directory.
+	 */
+	public static WorkTree findWorkTree() throws NoGitRepositoryFoundException,
+			IOException {
+		return findWorkTree(new File("."));
+	}
+
+	/**
+	 * Checks if a path is a valid git repository. Works similar like the method
+	 * is_git_directory from the original setup.c file.
+	 * 
+	 * @param directory
+	 *            the path which should be checked.
+	 * @return true if the path is a valid git repository.
+	 */
+	private static boolean isRepository(File directory) {
+		if (!directory.isDirectory()) {
+			return false;
+		}
+
+		final File objectDirectory = new File(directory, OBJECTS_DIRECTORY_NAME);
+		if (!objectDirectory.isDirectory()) {
+			return false;
+		}
+
+		final File refsDirectory = new File(directory, REFS_DIRECTORY_NAME);
+		if (!refsDirectory.isDirectory()) {
+			return false;
+		}
+
+		final File head = new File(directory, HEAD);
+		if (!hasValidateHeadRef(head)) {
+			return false;
+		}
+
+		return true;
+	}
+
+	/**
+	 * Checks for example if a path is a valid HEAD file.
+	 * 
+	 * @param path
+	 *            is the path of the HEAD file.
+	 * @return true if it has a valid head reference.
+	 */
+	private static final boolean hasValidateHeadRef(File path) {
+		return true; // TODO implement this method
+	}
+
+	private static WorkTree findWorkTree(final File directory)
+			throws IOException, NoGitRepositoryFoundException {
+		File currentDirectory = directory.getAbsoluteFile();
+		while (currentDirectory != null) {
+			final File commonGitDirectory = new File(directory,
+					REPOSITORY_DIRECTORY_NAME);
+			if (isRepository(commonGitDirectory))
+				return new WorkTree(currentDirectory, new Repository(
+						commonGitDirectory));
+			if (isRepository(currentDirectory))
+				return new WorkTree(null, new Repository(currentDirectory));
+			currentDirectory = currentDirectory.getParentFile();
+		}
+		throw new NoGitRepositoryFoundException(directory);
+	}
+
 }
-- 
1.5.4.3

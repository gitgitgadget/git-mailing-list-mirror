From: Florian Koeberle <florianskarten@web.de>
Subject: [JGIT PATCH v4 21/24] Added findWorkTree method to Repository class.
Date: Fri, 13 Jun 2008 20:35:18 +0200
Message-ID: <1213382121-19786-21-git-send-email-florianskarten@web.de>
References: <4852BCCA.4030404@web.de>
Cc: Florian Koeberle <florianskarten@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 13 20:38:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7EAU-0005zA-TA
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 20:38:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753333AbYFMSgR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 14:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754358AbYFMSgP
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 14:36:15 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:41995 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754066AbYFMSff (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 14:35:35 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate03.web.de (Postfix) with ESMTP id 4BC6ADFAF6EA
	for <git@vger.kernel.org>; Fri, 13 Jun 2008 20:35:34 +0200 (CEST)
Received: from [84.150.79.9] (helo=localhost.localdomain)
	by smtp08.web.de with asmtp (WEB.DE 4.109 #226)
	id 1K7E7Z-0000eI-00; Fri, 13 Jun 2008 20:35:33 +0200
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <4852BCCA.4030404@web.de>
In-Reply-To: <4852BCCA.4030404@web.de>
References: <4852BCCA.4030404@web.de>
X-Sender: florianskarten@web.de
X-Provags-ID: V01U2FsdGVkX1+iqd8RHGn+NXW1B8DUF1uoR1mE4utrfg/4jKHB
	XZofWzgYY0CgfTK6+2nqhkXIFJq349MQSb7PaIX+RaQlgKvna4
	O71pWn7DVhZmkAqmQm1g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84927>

Signed-off-by: Florian Koeberle <florianskarten@web.de>
---
 .../src/org/spearce/jgit/lib/Repository.java       |   80 ++++++++++++++++++++
 1 files changed, 80 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index d7c3b13..ee7bbe4 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -39,6 +39,11 @@
 
 package org.spearce.jgit.lib;
 
+import static org.spearce.jgit.lib.Constants.HEAD;
+import static org.spearce.jgit.lib.Constants.OBJECTS_DIRECTORY_NAME;
+import static org.spearce.jgit.lib.Constants.REFS_DIRECTORY_NAME;
+import static org.spearce.jgit.lib.Constants.REPOSITORY_DIRECTORY_NAME;
+
 import java.io.BufferedReader;
 import java.io.File;
 import java.io.FileNotFoundException;
@@ -51,6 +56,7 @@ import java.util.HashMap;
 import java.util.Map;
 
 import org.spearce.jgit.errors.IncorrectObjectTypeException;
+import org.spearce.jgit.errors.NoGitRepositoryFoundException;
 import org.spearce.jgit.errors.RevisionSyntaxException;
 import org.spearce.jgit.stgit.StGitPatch;
 import org.spearce.jgit.util.FS;
@@ -1052,4 +1058,78 @@ public class Repository {
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

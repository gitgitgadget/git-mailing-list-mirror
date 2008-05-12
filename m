From: Florian Koeberle <florianskarten@web.de>
Subject: [JGIT PATCH v2 07/24] Added findWorkTree method to Repository class.
Date: Mon, 12 May 2008 22:13:25 +0200
Message-ID: <1210623222-24908-8-git-send-email-florianskarten@web.de>
References: <1210623222-24908-1-git-send-email-florianskarten@web.de>
Cc: Florian Koeberle <florianskarten@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 12 22:23:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JveSm-00086f-IT
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 22:17:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755830AbYELUOr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 16:14:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755184AbYELUOq
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 16:14:46 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:40174 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754198AbYELUNq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 16:13:46 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate01.web.de (Postfix) with ESMTP id BF24EDECFCE7
	for <git@vger.kernel.org>; Mon, 12 May 2008 22:13:44 +0200 (CEST)
Received: from [84.150.98.143] (helo=localhost.localdomain)
	by smtp05.web.de with asmtp (WEB.DE 4.109 #226)
	id 1JveP2-00016x-00; Mon, 12 May 2008 22:13:44 +0200
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1210623222-24908-1-git-send-email-florianskarten@web.de>
X-Sender: florianskarten@web.de
X-Provags-ID: V01U2FsdGVkX18mEHMlMg8JQJgEmEEiQzJzUtxS/JT96rH9zD0p
	AN5Hm0/4GLg0Hwg6Qwp0jmWr8FSUBHiYwq0m5wy/sR2AfeCi5L
	7E1LAQkj4ZC4AmRVOBiw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81929>

Signed-off-by: Florian Koeberle <florianskarten@web.de>
---
 .../src/org/spearce/jgit/lib/Repository.java       |   90 ++++++++++++++++++++
 1 files changed, 90 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index 3186fe2..ed5bd89 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -16,6 +16,11 @@
  */
 package org.spearce.jgit.lib;
 
+import static org.spearce.jgit.lib.Constants.HEAD_FILE_NAME;
+import static org.spearce.jgit.lib.Constants.OBJECTS_DIRECTORY_NAME;
+import static org.spearce.jgit.lib.Constants.REFS_DIRECTORY_NAME;
+import static org.spearce.jgit.lib.Constants.REPOSITORY_DIRECTORY_NAME;
+
 import java.io.BufferedReader;
 import java.io.File;
 import java.io.FileNotFoundException;
@@ -1242,4 +1247,89 @@ public class Repository {
 		}
 	}
 
+	/**
+	 * Find the git repository for the current working directory.
+	 * 
+	 * @return a {@link Repository}.
+	 * @throws IOException
+	 *             if the system property user.dir isn't set or if it is
+	 *             invalid.
+	 */
+	public static WorkTree findWorkTree() throws IOException {
+		final String workingDirectoryPath = System.getProperty("user.dir");
+		if (workingDirectoryPath == null) {
+			throw new IOException("unable to get working directory");
+		}
+		final File workingDirectoryFile = new File(workingDirectoryPath);
+		if (!workingDirectoryFile.exists()) {
+			throw new IOException("Working directory path is invalid");
+		}
+		return findWorkTree(workingDirectoryFile);
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
+		final File head = new File(directory, HEAD_FILE_NAME);
+		if (!hasValidateHeadRef(head)) {
+			return false;
+		}
+
+		return true;
+	}
+
+	/**
+	 * Checks for example if a path is a valid HEAD file. Should do the same
+	 * like validate_headref from path.c.
+	 * 
+	 * @param path
+	 *            is the path of the HEAD file.
+	 * @return true if it has a valid head reference.
+	 */
+	private static final boolean hasValidateHeadRef(File path) {
+		return true; // TODO stub. view int validate_headref(const char
+		// *path) at path.c
+	}
+
+	private static WorkTree findWorkTree(File directory) throws IOException {
+		File currentDirectory = directory.getAbsoluteFile();
+		while (true) {
+			final File commonGitDirectory = new File(directory,
+					REPOSITORY_DIRECTORY_NAME);
+			if (isRepository(commonGitDirectory)) {
+				return new WorkTree(currentDirectory, new Repository(
+						commonGitDirectory));
+			}
+
+			if (isRepository(currentDirectory)) {
+				return new WorkTree(null, new Repository(currentDirectory));
+			}
+			currentDirectory = currentDirectory.getParentFile();
+			if (currentDirectory == null) {
+				throw new IOException("Can't find git repository");
+			}
+		}
+
+	}
+
 }
-- 
1.5.4.3

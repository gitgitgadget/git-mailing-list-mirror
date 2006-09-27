From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] runstatus: do not recurse into subdirectories if not needed
Date: Wed, 27 Sep 2006 13:16:45 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0609271315470.14200@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Sep 27 13:20:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSXPH-0000G9-OF
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 13:16:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965476AbWI0LQs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 07:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965567AbWI0LQs
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 07:16:48 -0400
Received: from mail.gmx.de ([213.165.64.20]:54166 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S965476AbWI0LQs (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Sep 2006 07:16:48 -0400
Received: (qmail invoked by alias); 27 Sep 2006 11:16:46 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp038) with SMTP; 27 Sep 2006 13:16:46 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27898>


This speeds up the case when you run git-status, having an untracked
subdirectory containing huge amounts of files.

It also clarifies the handling of hide_empty_directories; the old version
worked, but was hard to understand.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 dir.c |   24 +++++++++++++++---------
 1 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/dir.c b/dir.c
index e2f472b..e69663c 100644
--- a/dir.c
+++ b/dir.c
@@ -274,6 +274,15 @@ static int dir_exists(const char *dirnam
 	return !strncmp(active_cache[pos]->name, dirname, len);
 }
 
+static int dir_is_empty(const char *dirname)
+{
+	DIR *fdir = opendir(dirname);
+	int result = (readdir(fdir) == NULL);
+
+	closedir(fdir);
+	return result;
+}
+
 /*
  * Read a directory tree. We currently ignore anything but
  * directories, regular files and symlinks. That's because git
@@ -314,7 +323,6 @@ static int read_directory_recursive(stru
 
 			switch (DTYPE(de)) {
 			struct stat st;
-			int subdir, rewind_base;
 			default:
 				continue;
 			case DT_UNKNOWN:
@@ -328,18 +336,16 @@ static int read_directory_recursive(stru
 			case DT_DIR:
 				memcpy(fullname + baselen + len, "/", 2);
 				len++;
-				rewind_base = dir->nr;
-				subdir = read_directory_recursive(dir, fullname, fullname,
-				                        baselen + len);
 				if (dir->show_other_directories &&
-				    (subdir || !dir->hide_empty_directories) &&
 				    !dir_exists(fullname, baselen + len)) {
-					/* Rewind the read subdirectory */
-					while (dir->nr > rewind_base)
-						free(dir->entries[--dir->nr]);
+					if (dir->hide_empty_directories &&
+					    dir_is_empty(fullname))
+						continue;
 					break;
 				}
-				contents += subdir;
+
+				contents += read_directory_recursive(dir,
+					fullname, fullname, baselen + len);
 				continue;
 			case DT_REG:
 			case DT_LNK:
-- 
1.4.2.1.g78cd-dirty

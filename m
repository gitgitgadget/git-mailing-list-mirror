From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 4/5] read_directory: show_both option.
Date: Mon, 25 Dec 2006 03:11:34 -0800
Message-ID: <7vvek0kz6h.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Dec 25 12:11:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gynk2-0003aU-Oz
	for gcvg-git@gmane.org; Mon, 25 Dec 2006 12:11:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754432AbWLYLLg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Dec 2006 06:11:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754434AbWLYLLg
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Dec 2006 06:11:36 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:48058 "EHLO
	fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754431AbWLYLLf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Dec 2006 06:11:35 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061225111134.FWWS25875.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>;
          Mon, 25 Dec 2006 06:11:34 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 2zBn1W00g1kojtg0000000; Mon, 25 Dec 2006 06:11:48 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35385>

This teaches the internal read_directory() routine to return
both interesting and ignored pathnames.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 dir.c |   19 ++++++++++++-------
 dir.h |    6 ++++--
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/dir.c b/dir.c
index 8477472..dd188a8 100644
--- a/dir.c
+++ b/dir.c
@@ -260,7 +260,8 @@ int excluded(struct dir_struct *dir, const char *pathname)
 	return 0;
 }
 
-static void add_name(struct dir_struct *dir, const char *pathname, int len)
+static void add_name(struct dir_struct *dir, const char *pathname, int len,
+		     int ignored_entry)
 {
 	struct dir_entry *ent;
 
@@ -273,6 +274,7 @@ static void add_name(struct dir_struct *dir, const char *pathname, int len)
 		dir->entries = xrealloc(dir->entries, alloc*sizeof(ent));
 	}
 	ent = xmalloc(sizeof(*ent) + len + 1);
+	ent->ignored_entry = ignored_entry;
 	ent->len = len;
 	memcpy(ent->name, pathname, len);
 	ent->name[len] = 0;
@@ -314,6 +316,7 @@ static int read_directory_recursive(struct dir_struct *dir, const char *path, co
 
 		while ((de = readdir(fdir)) != NULL) {
 			int len;
+			int ignored_entry;
 
 			if ((de->d_name[0] == '.') &&
 			    (de->d_name[1] == 0 ||
@@ -322,11 +325,12 @@ static int read_directory_recursive(struct dir_struct *dir, const char *path, co
 				continue;
 			len = strlen(de->d_name);
 			memcpy(fullname + baselen, de->d_name, len+1);
-			if (excluded(dir, fullname) != dir->show_ignored) {
-				if (!dir->show_ignored || DTYPE(de) != DT_DIR) {
-					continue;
-				}
-			}
+			ignored_entry = excluded(dir, fullname);
+
+			if (!dir->show_both &&
+			    (ignored_entry != dir->show_ignored) &&
+			    (!dir->show_ignored || DTYPE(de) != DT_DIR))
+				continue;
 
 			switch (DTYPE(de)) {
 			struct stat st;
@@ -364,7 +368,8 @@ static int read_directory_recursive(struct dir_struct *dir, const char *path, co
 			if (check_only)
 				goto exit_early;
 			else
-				add_name(dir, fullname, baselen + len);
+				add_name(dir, fullname, baselen + len,
+					 ignored_entry);
 		}
 exit_early:
 		closedir(fdir);
diff --git a/dir.h b/dir.h
index c919727..08c6345 100644
--- a/dir.h
+++ b/dir.h
@@ -13,7 +13,8 @@
 
 
 struct dir_entry {
-	int len;
+	unsigned ignored_entry : 1;
+	unsigned int len : 15;
 	char name[FLEX_ARRAY]; /* more */
 };
 
@@ -29,7 +30,8 @@ struct exclude_list {
 
 struct dir_struct {
 	int nr, alloc;
-	unsigned int show_ignored:1,
+	unsigned int show_both: 1,
+		     show_ignored:1,
 		     show_other_directories:1,
 		     hide_empty_directories:1;
 	struct dir_entry **entries;
-- 
1.4.4.3.g50da

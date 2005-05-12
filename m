From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] checkout-cache fix
Date: Wed, 11 May 2005 17:02:45 -0700
Message-ID: <7voebhnwey.fsf_-_@assigned-by-dhcp.cox.net>
References: <118833cc05050911255e601fc@mail.gmail.com>
	<7vr7gewuxt.fsf@assigned-by-dhcp.cox.net>
	<20050510230357.GF26384@pasky.ji.cz>
	<7vsm0us5p5.fsf@assigned-by-dhcp.cox.net>
	<118833cc050511113122e2d17d@mail.gmail.com>
	<7vpsvxqwab.fsf@assigned-by-dhcp.cox.net>
	<7vd5rxquo5.fsf@assigned-by-dhcp.cox.net>
	<20050511224044.GI22686@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 01:56:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DW13L-0004Vb-6a
	for gcvg-git@gmane.org; Thu, 12 May 2005 01:55:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261264AbVELADM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 May 2005 20:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261222AbVELADM
	(ORCPT <rfc822;git-outgoing>); Wed, 11 May 2005 20:03:12 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:1969 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S261264AbVELACr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2005 20:02:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050512000245.VHZW23392.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 11 May 2005 20:02:45 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050511224044.GI22686@pasky.ji.cz> (Petr Baudis's message of
 "Thu, 12 May 2005 00:40:44 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Commit    cc01b05f0a3dfdf5ed114e429a7bec1ad549ab1c
Author    Junio C Hamano <junkio@cox.net>, Wed May 11 17:00:16 2005 -0700
Committer Junio C Hamano <junkio@cox.net>, Wed May 11 17:00:16 2005 -0700

Fix checkout-cache when existing work tree interferes with the checkout.

This is essentially the same one as the last one I sent to the
GIT list, except that the patch is rebased to the current tip of
the git-pb tree, and an unnecessary call to create_directories()
removed.

The checkout-cache command gets confused when checking out a
file in a subdirectory and the work tree has a symlink to the
subdirectory.  Also it fails to check things out when there is a
non-directory in the work tree when cache expects a directory
there, and vice versa.  This patch fixes the first problem by
making sure all the leading paths in the file being checked out
are indeed directories, and also fixes directory vs
non-directory conflicts when '-f' is specified by removing the
offending paths.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

--- a/checkout-cache.c
+++ b/checkout-cache.c
@@ -32,6 +32,8 @@
  * of "-a" causing problems (not possible in the above example,
  * but get used to it in scripting!).
  */
+#include <sys/types.h>
+#include <dirent.h>
 #include "cache.h"
 
 static int force = 0, quiet = 0, not_new = 0;
@@ -46,20 +48,61 @@ static void create_directories(const cha
 		len = slash - path;
 		memcpy(buf, path, len);
 		buf[len] = 0;
-		mkdir(buf, 0755);
+		if (mkdir(buf, 0755)) {
+			if (errno == EEXIST) {
+				struct stat st;
+				if (!lstat(buf, &st) && S_ISDIR(st.st_mode))
+					continue; /* ok */
+				if (force && !unlink(buf) && !mkdir(buf, 0755))
+					continue;
+			}
+			die("cannot create directory at %s", buf);
+		}
 	}
 	free(buf);
 }
 
+static void remove_subtree(const char *path)
+{
+	DIR *dir = opendir(path);
+	struct dirent *de;
+	char pathbuf[PATH_MAX];
+	char *name;
+	
+	if (!dir)
+		die("cannot opendir %s", path);
+	strcpy(pathbuf, path);
+	name = pathbuf + strlen(path);
+	*name++ = '/';
+	while ((de = readdir(dir)) != NULL) {
+		struct stat st;
+		if ((de->d_name[0] == '.') &&
+		    ((de->d_name[1] == 0) ||
+		     ((de->d_name[1] == '.') && de->d_name[2] == 0)))
+			continue;
+		strcpy(name, de->d_name);
+		if (lstat(pathbuf, &st))
+			die("cannot lstat %s", pathbuf);
+		if (S_ISDIR(st.st_mode))
+			remove_subtree(pathbuf);
+		else if (unlink(pathbuf))
+			die("cannot unlink %s", pathbuf);
+	}
+	closedir(dir);
+	if (rmdir(path))
+		die("cannot rmdir %s", path);
+}
+
 static int create_file(const char *path, unsigned int mode)
 {
 	int fd;
 
 	mode = (mode & 0100) ? 0777 : 0666;
+	create_directories(path);
 	fd = open(path, O_WRONLY | O_TRUNC | O_CREAT, mode);
 	if (fd < 0) {
-		if (errno == ENOENT) {
-			create_directories(path);
+		if (errno == EISDIR && force) {
+			remove_subtree(path);
 			fd = open(path, O_WRONLY | O_TRUNC | O_CREAT, mode);
 		}
 	}
------------------------------------------------


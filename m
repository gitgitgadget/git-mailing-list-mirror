From: Junio C Hamano <junkio@cox.net>
Subject: Re: "git-checkout-cache -f -a" failure
Date: Tue, 10 May 2005 15:57:34 -0700
Message-ID: <7vr7gewuxt.fsf@assigned-by-dhcp.cox.net>
References: <118833cc05050911255e601fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed May 11 00:50:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVdYO-0000wR-B0
	for gcvg-git@gmane.org; Wed, 11 May 2005 00:50:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261816AbVEJW5n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 May 2005 18:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbVEJW5n
	(ORCPT <rfc822;git-outgoing>); Tue, 10 May 2005 18:57:43 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:7098 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S261816AbVEJW5h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2005 18:57:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050510225734.IYET19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 10 May 2005 18:57:34 -0400
To: Morten Welinder <mwelinder@gmail.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "MW" == Morten Welinder <mwelinder@gmail.com> writes:

MW> git-checkout-cache is having problems when files change from directories to
MW> plain files or vice versa.  cg-seek seems to be similarly affected.

Could you give this patch a try?  It lets checkout-cache remove
a file where you want to have a directory (because you want to
create something underneath) or remove a whole subdirectory
where you want to have a non-directory, when '-f' parameter is
specified.

If things test well, I'll put this in the git-jc repository and
ask Linus to pull from it alongside with other accumulated
patches when he returns.

Thanks.


Signed-off-by: Junio C Hamano <junkio@cox.net>
------------
# - HEAD: Adjust quoting styles for some environment variables in the documentation.
# + 7: Let checkout-cache stomp on existing file/directory with -f.
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
@@ -46,11 +48,51 @@ static void create_directories(const cha
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
+		if (de->d_name[0] == '.')
+			continue; /* we mean . and .. but verify_path would
+				   * have rejected any dotfiles earlier.
+				   */
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
@@ -62,6 +104,14 @@ static int create_file(const char *path,
 			create_directories(path);
 			fd = open(path, O_WRONLY | O_TRUNC | O_CREAT, mode);
 		}
+		else if (errno == EISDIR && force) {
+			remove_subtree(path);
+			fd = open(path, O_WRONLY | O_TRUNC | O_CREAT, mode);
+		}
+		else if (errno == ENOTDIR && force) {
+			create_directories(path);
+			fd = open(path, O_WRONLY | O_TRUNC | O_CREAT, mode);
+		}
 	}
 	return fd;
 }




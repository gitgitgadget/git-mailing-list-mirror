From: Junio C Hamano <junkio@cox.net>
Subject: Re: "git-checkout-cache -f -a" failure
Date: Tue, 10 May 2005 19:53:10 -0700
Message-ID: <7vpsvyv5gp.fsf@assigned-by-dhcp.cox.net>
References: <118833cc05050911255e601fc@mail.gmail.com>
	<7vr7gewuxt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed May 11 04:46:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVhEV-0004VP-LF
	for gcvg-git@gmane.org; Wed, 11 May 2005 04:45:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261885AbVEKCxY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 May 2005 22:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261886AbVEKCxY
	(ORCPT <rfc822;git-outgoing>); Tue, 10 May 2005 22:53:24 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:36996 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S261885AbVEKCxN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2005 22:53:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050511025312.YMAL1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 10 May 2005 22:53:12 -0400
To: Morten Welinder <mwelinder@gmail.com>
In-Reply-To: <7vr7gewuxt.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Tue, 10 May 2005 15:57:34 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Please forget about the previous one which was buggy when you
had ".something" file under the directory being replaced.

Could you give this patch a try?

---

Running git-checkout-cache -f -a to check out a file in a
directory fails when the work tree has a non-directory with the
same name as the directory being checked out.  Similarly it
fails to check out a file when the work tree has a directory
with the same name as the file being checked out.

When '-f' is specified, the user is telling us that "I really
want to match the work tree with what is in the cache."  So
removing the offending file or directory from the work tree to
make room when necessary and possible in order to make the
checkout succeed is the right thing to do.

Signed-off-by: Junio C Hamano <junkio@cox.net>

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
+		if ((de->d_name[0] == '.') &&
+		    ((de->d_name[1] == 0) ||
+		     (de->d_name[1] == '.') && de->d_name[2] == 0))
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
@@ -58,10 +100,14 @@ static int create_file(const char *path,
 	mode = (mode & 0100) ? 0777 : 0666;
 	fd = open(path, O_WRONLY | O_TRUNC | O_CREAT, mode);
 	if (fd < 0) {
-		if (errno == ENOENT) {
+		if ((errno == ENOENT) || (errno == ENOTDIR && force)) {
 			create_directories(path);
 			fd = open(path, O_WRONLY | O_TRUNC | O_CREAT, mode);
 		}
+		else if (errno == EISDIR && force) {
+			remove_subtree(path);
+			fd = open(path, O_WRONLY | O_TRUNC | O_CREAT, mode);
+		}
 	}
 	return fd;
 }
------------------------------------------------


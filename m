From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] read-tree -m -u: avoid getting confused by intermediate symlinks.
Date: Fri, 11 May 2007 00:13:56 -0700
Message-ID: <7vveezde8b.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 11 09:14:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmPKF-0006Gq-0C
	for gcvg-git@gmane.org; Fri, 11 May 2007 09:14:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754835AbXEKHN6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 May 2007 03:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754998AbXEKHN6
	(ORCPT <rfc822;git-outgoing>); Fri, 11 May 2007 03:13:58 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:57476 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754835AbXEKHN5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2007 03:13:57 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070511071358.SSHM24310.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Fri, 11 May 2007 03:13:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id xjDw1W00S1kojtg0000000; Fri, 11 May 2007 03:13:57 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46941>

When switching from a branch with both x86_64/boot/Makefile and
i386/boot/Makefile to another branch that has x86_64/boot as a
symlink pointing at ../i386/boot, the code incorrectly removed
i386/boot/Makefile.

This was because we first removed everything under x86_64/boot
to make room to create a symbolic link x86_64/boot, then removed
x86_64/boot/Makefile which no longer exists but now is pointing
at i386/boot/Makefile, thanks to the symlink we just created.

This fixes it by using the has_symlink_leading_path() function
introduced previously for git-apply in the checkout codepath.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * This comes on top of the previous git-apply patch.

 Makefile                        |    2 +-
 builtin-apply.c                 |   36 +-----------------------------------
 cache.h                         |    1 +
 symlinks.c                      |   35 +++++++++++++++++++++++++++++++++++
 t/t4122-apply-symlink-inside.sh |    1 -
 unpack-trees.c                  |    2 ++
 6 files changed, 40 insertions(+), 37 deletions(-)
 create mode 100644 symlinks.c

diff --git a/Makefile b/Makefile
index 7cf146b..29243c6 100644
--- a/Makefile
+++ b/Makefile
@@ -318,7 +318,7 @@ LIB_OBJS = \
 	write_or_die.o trace.o list-objects.o grep.o match-trees.o \
 	alloc.o merge-file.o path-list.o help.o unpack-trees.o $(DIFF_OBJS) \
 	color.o wt-status.o archive-zip.o archive-tar.o shallow.o utf8.o \
-	convert.o attr.o decorate.o progress.o mailmap.o
+	convert.o attr.o decorate.o progress.o mailmap.o symlinks.o
 
 BUILTIN_OBJS = \
 	builtin-add.o \
diff --git a/builtin-apply.c b/builtin-apply.c
index 38d20ef..01acba8 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -2009,40 +2009,6 @@ static int apply_data(struct patch *patch, struct stat *st, struct cache_entry *
 	return 0;
 }
 
-static int has_symlink_component(const char *new_name)
-{
-	char path[PATH_MAX];
-	const char *sp, *ep;
-	char *dp;
-
-	sp = new_name;
-	dp = path;
-
-	while (1) {
-		size_t len;
-		struct stat st;
-
-		ep = strchr(sp, '/');
-		if (!ep)
-			break;
-		len = ep - sp;
-		if (PATH_MAX <= dp + len - path + 2)
-			return 0; /* new name is longer than that??? */
-		memcpy(dp, sp, len);
-		dp[len] = 0;
-
-		if (lstat(path, &st))
-			return 0; /* why? we already lstat() new_name successfully. */
-		if (S_ISLNK(st.st_mode))
-			return 1;
-
-		dp[len++] = '/';
-		dp = dp + len;
-		sp = ep + 1;
-	}
-	return 0;
-}
-
 static int check_to_create_blob(const char *new_name, int ok_if_exists)
 {
 	struct stat nst;
@@ -2056,7 +2022,7 @@ static int check_to_create_blob(const char *new_name, int ok_if_exists)
 		 * In such a case, path "new_name" does not exist as
 		 * far as git is concerned.
 		 */
-		if (has_symlink_component(new_name))
+		if (has_symlink_leading_path(new_name))
 			return 0;
 
 		return error("%s: already exists in working directory", new_name);
diff --git a/cache.h b/cache.h
index 8e76152..ab66263 100644
--- a/cache.h
+++ b/cache.h
@@ -410,6 +410,7 @@ struct checkout {
 };
 
 extern int checkout_entry(struct cache_entry *ce, const struct checkout *state, char *topath);
+extern int has_symlink_leading_path(const char *name);
 
 extern struct alternate_object_database {
 	struct alternate_object_database *next;
diff --git a/symlinks.c b/symlinks.c
new file mode 100644
index 0000000..cfecfcf
--- /dev/null
+++ b/symlinks.c
@@ -0,0 +1,35 @@
+#include "cache.h"
+
+int has_symlink_leading_path(const char *name)
+{
+	char path[PATH_MAX];
+	const char *sp, *ep;
+	char *dp;
+
+	sp = name;
+	dp = path;
+
+	while (1) {
+		size_t len;
+		struct stat st;
+
+		ep = strchr(sp, '/');
+		if (!ep)
+			break;
+		len = ep - sp;
+		if (PATH_MAX <= dp + len - path + 2)
+			return 0; /* new name is longer than that??? */
+		memcpy(dp, sp, len);
+		dp[len] = 0;
+
+		if (lstat(path, &st))
+			return 0;
+		if (S_ISLNK(st.st_mode))
+			return 1;
+
+		dp[len++] = '/';
+		dp = dp + len;
+		sp = ep + 1;
+	}
+	return 0;
+}
diff --git a/t/t4122-apply-symlink-inside.sh b/t/t4122-apply-symlink-inside.sh
index 37c9a9f..3ddfe64 100755
--- a/t/t4122-apply-symlink-inside.sh
+++ b/t/t4122-apply-symlink-inside.sh
@@ -34,7 +34,6 @@ test_expect_success setup '
 test_expect_success apply '
 
 	git checkout test &&
-	git reset --hard && #### checkout seems to be buggy
 	git diff --exit-code test &&
 	git diff --exit-code --cached test &&
 	git apply --index test.patch
diff --git a/unpack-trees.c b/unpack-trees.c
index 675a999..a6fa32f 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -268,6 +268,8 @@ static void unlink_entry(char *name)
 {
 	char *cp, *prev;
 
+	if (has_symlink_leading_path(name))
+		return;
 	if (unlink(name))
 		return;
 	prev = NULL;
-- 
1.5.2.rc3.706.g498a

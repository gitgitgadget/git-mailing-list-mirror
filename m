From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Implement git-checkout-cache -u to update stat information
 in the cache.
Date: Sun, 15 May 2005 01:36:59 -0700
Message-ID: <7vis1kvqac.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, torvalds@osdl.org
X-From: git-owner@vger.kernel.org Sun May 15 10:38:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXEdO-00011x-Qi
	for gcvg-git@gmane.org; Sun, 15 May 2005 10:38:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261551AbVEOIhz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 May 2005 04:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261560AbVEOIhz
	(ORCPT <rfc822;git-outgoing>); Sun, 15 May 2005 04:37:55 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:1711 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S261551AbVEOIhB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2005 04:37:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050515083700.XZAQ22430.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 15 May 2005 04:37:00 -0400
To: pasky@ucw.cz
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

With -u flag, git-checkout-cache picks up the stat information
from newly created files and updates the cache.  This removes the
need to run git-update-cache --refresh immediately after running
git-checkout-cache.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

Documentation/git-checkout-cache.txt |    6 +++
Makefile                             |    2 -
cache.h                              |    9 +++++
checkout-cache.c                     |   35 ++++++++++++++++++++-
index.c                              |   58 +++++++++++++++++++++++++++++++++++
read-cache.c                         |   20 ++++++++++++
t/t2002-checkout-cache-u.sh          |   35 +++++++++++++++++++++
update-cache.c                       |   48 ++--------------------------
8 files changed, 166 insertions(+), 47 deletions(-)
index.c (. --> 100644)
t/t0110-environment-names-old.sh (100644 --> 100755)
t/t1000-read-tree-m-3way.sh (100644 --> 100755)
t/t2002-checkout-cache-u.sh (. --> 100755)
t/t4000-diff-format.sh (100644 --> 100755)

--- a/Documentation/git-checkout-cache.txt
+++ b/Documentation/git-checkout-cache.txt
@@ -9,7 +9,7 @@
 
 SYNOPSIS
 --------
-'git-checkout-cache' [-q] [-a] [-f] [-n] [--prefix=<string>]
+'git-checkout-cache' [-u] [-q] [-a] [-f] [-n] [--prefix=<string>]
 	           [--] <file>...
 
 DESCRIPTION
@@ -19,6 +19,10 @@
 
 OPTIONS
 -------
+-u::
+	update stat information for the checked out entries in
+	the cache file.
+
 -q::
 	be quiet if files exist or are not in the cache
 
--- a/Makefile
+++ b/Makefile
@@ -36,7 +36,7 @@
 	$(INSTALL) $(PROG) $(SCRIPTS) $(dest)$(bin)
 
 LIB_OBJS=read-cache.o sha1_file.o usage.o object.o commit.o tree.o blob.o \
-	 tag.o date.o
+	 tag.o date.o index.o
 LIB_FILE=libgit.a
 LIB_H=cache.h object.h blob.h tree.h commit.h tag.h
 
--- a/cache.h
+++ b/cache.h
@@ -131,6 +131,15 @@
 extern int same_name(struct cache_entry *a, struct cache_entry *b);
 extern int cache_match_stat(struct cache_entry *ce, struct stat *st);
 extern int index_fd(unsigned char *sha1, int fd, struct stat *st);
+extern void fill_stat_cache_info(struct cache_entry *ce, struct stat *st);
+
+struct cache_file {
+	struct cache_file *next;
+	char lockfile[PATH_MAX];
+};
+extern int hold_index_file_for_update(struct cache_file *, const char *path);
+extern int commit_index_file(struct cache_file *);
+extern void rollback_index_file(struct cache_file *);
 
 #define MTIME_CHANGED	0x0001
 #define CTIME_CHANGED	0x0002
--- a/checkout-cache.c
+++ b/checkout-cache.c
@@ -36,7 +36,7 @@
 #include <dirent.h>
 #include "cache.h"
 
-static int force = 0, quiet = 0, not_new = 0;
+static int force = 0, quiet = 0, not_new = 0, refresh_cache = 0;
 
 static void create_directories(const char *path)
 {
@@ -154,6 +154,12 @@
 		free(new);
 		return error("checkout-cache: unknown file mode for %s", path);
 	}
+
+	if (refresh_cache) {
+		struct stat st;
+		lstat(ce->name, &st);
+		fill_stat_cache_info(ce, &st);
+	}
 	return 0;
 }
 
@@ -224,6 +230,8 @@
 {
 	int i, force_filename = 0;
 	const char *base_dir = "";
+	struct cache_file cache_file;
+	int newfd = -1;
 
 	if (read_cache() < 0) {
 		die("invalid cache");
@@ -252,12 +260,37 @@
 				not_new = 1;
 				continue;
 			}
+			if (!strcmp(arg, "-u")) {
+				refresh_cache = 1;
+				if (newfd < 0)
+					newfd = hold_index_file_for_update
+						(&cache_file,
+						 get_index_file());
+				if (newfd < 0)
+					die("cannot open index.lock file.");
+				continue;
+			}
 			if (!memcmp(arg, "--prefix=", 9)) {
 				base_dir = arg+9;
 				continue;
 			}
 		}
+		if (base_dir[0]) {
+			/* when --prefix is specified we do not
+			 * want to update cache.
+			 */
+			if (refresh_cache) {
+				close(newfd); newfd = -1;
+				rollback_index_file(&cache_file);
+			}
+			refresh_cache = 0;
+		}
 		checkout_file(arg, base_dir);
 	}
+
+	if (0 <= newfd &&
+	    (write_cache(newfd, active_cache, active_nr) ||
+	     commit_index_file(&cache_file)))
+		die("Unable to write new cachefile");
 	return 0;
 }
--- a/index.c
+++ b/index.c
@@ -0,0 +1,58 @@
+/*
+ * GIT - The information manager from hell
+ * Cache-file locking management.
+ *
+ * Copyright (c) 2005 Junio C Hamano.
+ */
+#include <signal.h>
+#include "cache.h"
+
+static struct cache_file *cache_file_list = NULL;
+
+static void remove_lock_file(void)
+{
+	while (cache_file_list) {
+		if (cache_file_list->lockfile[0])
+			unlink(cache_file_list->lockfile);
+		cache_file_list = cache_file_list->next;
+	}
+}
+
+static void remove_lock_file_on_signal(int signo)
+{
+	remove_lock_file();
+}
+
+int commit_index_file(struct cache_file *cf)
+{
+	int i;
+	char indexfile[PATH_MAX];
+
+	strcpy(indexfile, cf->lockfile);
+	i = strlen(indexfile);
+	indexfile[i - 5] = 0; /* .lock */
+	i = rename(cf->lockfile, indexfile);
+	cf->lockfile[0] = 0;
+	return i;
+}
+
+void rollback_index_file(struct cache_file *cf)
+{
+	unlink(cf->lockfile);
+	cf->lockfile[0] = 0;
+}
+
+int hold_index_file_for_update(struct cache_file *cf, const char *path)
+{
+	int newfd;
+
+	sprintf(cf->lockfile, "%s.lock", path);
+	cf->next = cache_file_list;
+	cache_file_list = cf;
+	newfd = open(cf->lockfile, O_RDWR | O_CREAT | O_EXCL, 0600);
+	if (!cf->next) {
+		signal(SIGINT, remove_lock_file_on_signal);
+		atexit(remove_lock_file);
+	}
+	return newfd;
+}
--- a/read-cache.c
+++ b/read-cache.c
@@ -9,6 +9,26 @@
 struct cache_entry **active_cache = NULL;
 unsigned int active_nr = 0, active_alloc = 0, active_cache_changed = 0;
 
+/*
+ * This only updates the "non-critical" parts of the directory
+ * cache, ie the parts that aren't tracked by GIT, and only used
+ * to validate the cache.
+ */
+void fill_stat_cache_info(struct cache_entry *ce, struct stat *st)
+{
+	ce->ce_ctime.sec = htonl(st->st_ctime);
+	ce->ce_mtime.sec = htonl(st->st_mtime);
+#ifdef NSEC
+	ce->ce_ctime.nsec = htonl(st->st_ctim.tv_nsec);
+	ce->ce_mtime.nsec = htonl(st->st_mtim.tv_nsec);
+#endif
+	ce->ce_dev = htonl(st->st_dev);
+	ce->ce_ino = htonl(st->st_ino);
+	ce->ce_uid = htonl(st->st_uid);
+	ce->ce_gid = htonl(st->st_gid);
+	ce->ce_size = htonl(st->st_size);
+}
+
 int cache_match_stat(struct cache_entry *ce, struct stat *st)
 {
 	unsigned int changed = 0;
--- a/t/t2002-checkout-cache-u.sh
+++ b/t/t2002-checkout-cache-u.sh
@@ -0,0 +1,35 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Junio C Hamano
+#
+
+test_description='git-checkout-cache -u test.
+
+With -u flag, git-checkout-cache internally runs the equivalent of
+git-update-cache --refresh on the checked out entry.'
+
+. ./test-lib.sh
+
+test_expect_success \
+'preparation' '
+echo frotz >path0 &&
+git-update-cache --add path0 &&
+t=$(git-write-tree)'
+
+test_expect_failure \
+'without -u, git-checkout-cache smudges stat information.' '
+rm -f path0 &&
+git-read-tree $t &&
+git-checkout-cache -f -a &&
+git-diff-files | diff - /dev/null'
+
+test_expect_success \
+'with -u, git-checkout-cache picks up stat information from new files.' '
+rm -f path0 &&
+git-read-tree $t &&
+git-checkout-cache -u -f -a &&
+git-diff-files | diff - /dev/null'
+
+
+
+
--- a/update-cache.c
+++ b/update-cache.c
@@ -3,7 +3,6 @@
  *
  * Copyright (C) Linus Torvalds, 2005
  */
-#include <signal.h>
 #include "cache.h"
 
 /*
@@ -31,26 +30,6 @@
 	return (unsigned long)ptr > (unsigned long)-1000L;
 }
 
-/*
- * This only updates the "non-critical" parts of the directory
- * cache, ie the parts that aren't tracked by GIT, and only used
- * to validate the cache.
- */
-static void fill_stat_cache_info(struct cache_entry *ce, struct stat *st)
-{
-	ce->ce_ctime.sec = htonl(st->st_ctime);
-	ce->ce_mtime.sec = htonl(st->st_mtime);
-#ifdef NSEC
-	ce->ce_ctime.nsec = htonl(st->st_ctim.tv_nsec);
-	ce->ce_mtime.nsec = htonl(st->st_mtim.tv_nsec);
-#endif
-	ce->ce_dev = htonl(st->st_dev);
-	ce->ce_ino = htonl(st->st_ino);
-	ce->ce_uid = htonl(st->st_uid);
-	ce->ce_gid = htonl(st->st_gid);
-	ce->ce_size = htonl(st->st_size);
-}
-
 static int add_file_to_cache(char *path)
 {
 	int size, namelen, option, status;
@@ -313,36 +292,17 @@
 	return add_cache_entry(ce, option);
 }
 
-static const char *lockfile_name = NULL;
-
-static void remove_lock_file(void)
-{
-	if (lockfile_name)
-		unlink(lockfile_name);
-}
-
-static void remove_lock_file_on_signal(int signo)
-{
-	remove_lock_file();
-}
+struct cache_file cache_file;
 
 int main(int argc, char **argv)
 {
 	int i, newfd, entries, has_errors = 0;
 	int allow_options = 1;
-	static char lockfile[MAXPATHLEN+1];
-	const char *indexfile = get_index_file();
-
-	snprintf(lockfile, sizeof(lockfile), "%s.lock", indexfile);
 
-	newfd = open(lockfile, O_RDWR | O_CREAT | O_EXCL, 0600);
+	newfd = hold_index_file_for_update(&cache_file, get_index_file());
 	if (newfd < 0)
 		die("unable to create new cachefile");
 
-	signal(SIGINT, remove_lock_file_on_signal);
-	atexit(remove_lock_file);
-	lockfile_name = lockfile;
-
 	entries = read_cache();
 	if (entries < 0)
 		die("cache corrupted");
@@ -401,9 +361,9 @@
 		if (add_file_to_cache(path))
 			die("Unable to add %s to database", path);
 	}
-	if (write_cache(newfd, active_cache, active_nr) || rename(lockfile, indexfile))
+	if (write_cache(newfd, active_cache, active_nr) ||
+	    commit_index_file(&cache_file))
 		die("Unable to write new cachefile");
 
-	lockfile_name = NULL;
 	return has_errors ? 1 : 0;
 }
------------------------------------------------


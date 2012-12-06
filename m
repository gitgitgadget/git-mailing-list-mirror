From: Zoltan Klinger <zoltan.klinger@gmail.com>
Subject: [PATCH] git-clean: Display more accurate delete messages
Date: Thu,  6 Dec 2012 21:15:38 +1100
Message-ID: <1354788938-26804-1-git-send-email-zoltan.klinger@gmail.com>
Cc: Zoltan Klinger <zoltan.klinger@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 06 11:15:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TgYUV-00017d-Ns
	for gcvg-git-2@plane.gmane.org; Thu, 06 Dec 2012 11:15:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422686Ab2LFKPX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2012 05:15:23 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:59971 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752361Ab2LFKPV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2012 05:15:21 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so4332271pad.19
        for <git@vger.kernel.org>; Thu, 06 Dec 2012 02:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=w7NoeHUhVeUO2YfX0u6JJHJC+y1JU228CKCB7aiziCA=;
        b=pDJ5CHmOVpJRER/X1d9yR1MXpN/tUkaHmD0P6NUdDkVvmPmoDQtwMp5stfAUcfQSIS
         ueeZihXZTW2Zw3pFoJ2TpQj1RC2GKkxiUqwQbc0Ln3qKnaBJxnIT0ZIZSpGoD1seWa0K
         EjBj4MltdbcSu3onwxtQXEQVtTZK00MhgMp/D1QGOFA3WvdK2+ThcGbH7J/kJpyUyTG1
         pft1CCPPrdI1ssPX+wB/5ndzP5jURwQDdRfGfhBFS7TiKPC32uP2Q/tmuzfKDvfVCD/P
         hpgBUgIuxFD0qxh2ZBqILNtS1Ns+TiGO7mub1MgIvZz8OIOaHi7vgvArStcNgCC4ogNo
         kYgw==
Received: by 10.68.135.133 with SMTP id ps5mr4536275pbb.132.1354788921314;
        Thu, 06 Dec 2012 02:15:21 -0800 (PST)
Received: from localhost.localdomain (ppp121-45-182-5.lns20.syd7.internode.on.net. [121.45.182.5])
        by mx.google.com with ESMTPS id vs3sm4552437pbc.61.2012.12.06.02.15.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 06 Dec 2012 02:15:20 -0800 (PST)
X-Mailer: git-send-email 1.7.9.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211161>

Only print out the names of the files and directories that got actually
deleted.

Consider the following repo layout:
  |-- test.git/
        |-- foo/
             |-- bar/
                  |-- bar.txt
             |-- frotz.git/
                  |-- frotz.txt
        |-- tracked_file1
        |-- untracked_file1

Suppose the user issues 'git clean -fd' from the test.git directory.

When -d option is used and untracked directory 'foo' contains a
subdirectory 'frotz.git' that is managed by a different git repository
therefore it will not be removed.

  $ git clean -fd
  Removing foo/
  Removing untracked_file1

The message displayed to the user is slightly misleading. The foo/
directory has not been removed because of foo/frotz.git still exists.
On the other hand the subdirectory bar has been deleted but it's not
mentioned anywhere.

This behaviour is the result of the way the deletion of untracked
directories are reported. In the current implementation they are
deleted recursively but only the name of the top most directory is
printed out. The calling function does not know about any
subdirectories that could not be removed during the recursion.

Improve the way the deleted directories are reported back to
the user:
  (1) Modify the recursive delete function to run in both dry_run and
      delete modes.
  (2) During the recursion collect the name of the files and
      directories that will be or have been removed. Also collect the
      names of files and directories that could not be removed.
  (3) After finishing the deletes print out the names of all deleted
      files and any files or directories that failed to delete.

Consider the output of the improved version:

  $ git clean -fd
  Removed foo/bar/bar.txt
  Removed foo/bar
  Removed untracked_file1

Now it displays only the file and directory names that got actually
deleted.

Signed-off-by: Zoltan Klinger <zoltan.klinger@gmail.com>
---
Hi there,

My first patch. Hope you find it useful.

Looking forward to your feedback.

Cheers,
Zoltan

 builtin/clean.c |   64 +++++++++++++++++++++++++++++++------------------------
 dir.c           |   58 ++++++++++++++++++++++++++++++++++++++++---------
 dir.h           |    3 +++
 3 files changed, 87 insertions(+), 38 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 69c1cda..9b056b9 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -34,22 +34,31 @@ static int exclude_cb(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
+static void print_result(const char *msg, struct string_list *lst)
+{
+  int i;
+  for (i = 0; i < lst->nr; i++)
+		printf("%s %s\n", msg, lst->items[i].string);
+}
+
 int cmd_clean(int argc, const char **argv, const char *prefix)
 {
 	int i;
-	int show_only = 0, remove_directories = 0, quiet = 0, ignored = 0;
+	int dry_run = 0, remove_directories = 0, quiet = 0, ignored = 0;
 	int ignored_only = 0, config_set = 0, errors = 0;
 	int rm_flags = REMOVE_DIR_KEEP_NESTED_GIT;
 	struct strbuf directory = STRBUF_INIT;
 	struct dir_struct dir;
 	static const char **pathspec;
 	struct strbuf buf = STRBUF_INIT;
+	struct string_list dels = STRING_LIST_INIT_DUP;
+	struct string_list errs = STRING_LIST_INIT_DUP;
 	struct string_list exclude_list = STRING_LIST_INIT_NODUP;
 	const char *qname;
 	char *seen = NULL;
 	struct option options[] = {
 		OPT__QUIET(&quiet, N_("do not print names of files removed")),
-		OPT__DRY_RUN(&show_only, N_("dry run")),
+		OPT__DRY_RUN(&dry_run, N_("dry run")),
 		OPT__FORCE(&force, N_("force")),
 		OPT_BOOLEAN('d', NULL, &remove_directories,
 				N_("remove whole directories")),
@@ -77,7 +86,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	if (ignored && ignored_only)
 		die(_("-x and -X cannot be used together"));
 
-	if (!show_only && !force) {
+	if (!dry_run && !force) {
 		if (config_set)
 			die(_("clean.requireForce set to true and neither -n nor -f given; "
 				  "refusing to clean"));
@@ -150,43 +159,42 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 		if (S_ISDIR(st.st_mode)) {
 			strbuf_addstr(&directory, ent->name);
 			qname = quote_path_relative(directory.buf, directory.len, &buf, prefix);
-			if (show_only && (remove_directories ||
-			    (matches == MATCHED_EXACTLY))) {
-				printf(_("Would remove %s\n"), qname);
-			} else if (remove_directories ||
-				   (matches == MATCHED_EXACTLY)) {
-				if (!quiet)
-					printf(_("Removing %s\n"), qname);
-				if (remove_dir_recursively(&directory,
-							   rm_flags) != 0) {
-					warning(_("failed to remove %s"), qname);
-					errors++;
-				}
-			} else if (show_only) {
-				printf(_("Would not remove %s\n"), qname);
-			} else {
-				printf(_("Not removing %s\n"), qname);
+			if (remove_directories || (matches == MATCHED_EXACTLY)) {
+				remove_dir_recursively_with_dryrun(&directory, rm_flags, dry_run,
+						&dels, &errs, prefix);
 			}
 			strbuf_reset(&directory);
 		} else {
 			if (pathspec && !matches)
 				continue;
 			qname = quote_path_relative(ent->name, -1, &buf, prefix);
-			if (show_only) {
-				printf(_("Would remove %s\n"), qname);
-				continue;
-			} else if (!quiet) {
-				printf(_("Removing %s\n"), qname);
-			}
-			if (unlink(ent->name) != 0) {
-				warning(_("failed to remove %s"), qname);
-				errors++;
+			if (dry_run)
+				string_list_append(&dels, qname);
+			else {
+				if (unlink(ent->name) != 0)
+					string_list_append(&errs, qname);
+				else
+					string_list_append(&dels, qname);
 			}
 		}
 	}
+
+	if (!quiet) {
+		if (dry_run)
+			print_result("Would remove", &dels);
+		else
+			print_result("Removed", &dels);
+	}
+
+	errors = errs.nr;
+	if (errors)
+		print_result("Failed to remove", &errs);
+
 	free(seen);
 
 	strbuf_release(&directory);
+	string_list_clear(&dels, 0);
+	string_list_clear(&errs, 0);
 	string_list_clear(&exclude_list, 0);
 	return (errors != 0);
 }
diff --git a/dir.c b/dir.c
index 5a83aa7..f580c51 100644
--- a/dir.c
+++ b/dir.c
@@ -7,7 +7,9 @@
  */
 #include "cache.h"
 #include "dir.h"
+#include "quote.h"
 #include "refs.h"
+#include "string-list.h"
 
 struct path_simplify {
 	int len;
@@ -1294,11 +1296,25 @@ int is_empty_dir(const char *path)
 	return ret;
 }
 
-static int remove_dir_recurse(struct strbuf *path, int flag, int *kept_up)
+static void append_dir_name(struct string_list *dels, struct string_list *errs,
+    char *name, const char * prefix, int failed)
+{
+	struct strbuf buf = STRBUF_INIT;
+	const char *qname;
+	qname = quote_path_relative(name, strlen(name), &buf, prefix);
+	if (!failed && dels)
+		string_list_append(dels, qname);
+	else if (errs)
+		string_list_append(errs, qname);
+}
+
+static int remove_dir_recurse(struct strbuf *path, int flag, int *kept_up,
+	int dry_run, struct string_list *dels, struct string_list *errs,
+  const char *prefix)
 {
 	DIR *dir;
 	struct dirent *e;
-	int ret = 0, original_len = path->len, len, kept_down = 0;
+	int ret = 0, original_len = path->len, len, kept_down = 0, res = 0;
 	int only_empty = (flag & REMOVE_DIR_EMPTY_ONLY);
 	int keep_toplevel = (flag & REMOVE_DIR_KEEP_TOPLEVEL);
 	unsigned char submodule_head[20];
@@ -1315,8 +1331,13 @@ static int remove_dir_recurse(struct strbuf *path, int flag, int *kept_up)
 	dir = opendir(path->buf);
 	if (!dir) {
 		/* an empty dir could be removed even if it is unreadble */
-		if (!keep_toplevel)
-			return rmdir(path->buf);
+		if (!keep_toplevel) {
+			res = 0;
+			if (!dry_run)
+				res = rmdir(path->buf);
+			append_dir_name(dels, errs, path->buf, prefix, res);
+			return res;
+		}
 		else
 			return -1;
 	}
@@ -1334,10 +1355,16 @@ static int remove_dir_recurse(struct strbuf *path, int flag, int *kept_up)
 		if (lstat(path->buf, &st))
 			; /* fall thru */
 		else if (S_ISDIR(st.st_mode)) {
-			if (!remove_dir_recurse(path, flag, &kept_down))
+			if (!remove_dir_recurse(path, flag, &kept_down, dry_run, dels, errs, prefix))
 				continue; /* happy */
-		} else if (!only_empty && !unlink(path->buf))
-			continue; /* happy, too */
+		} else if (!only_empty) {
+			res = 0;
+			if (!dry_run)
+				res = unlink(path->buf);
+			append_dir_name(dels, errs, path->buf, prefix, res);
+			if (!res)
+				continue; /* happy, too */
+		}
 
 		/* path too long, stat fails, or non-directory still exists */
 		ret = -1;
@@ -1346,8 +1373,12 @@ static int remove_dir_recurse(struct strbuf *path, int flag, int *kept_up)
 	closedir(dir);
 
 	strbuf_setlen(path, original_len);
-	if (!ret && !keep_toplevel && !kept_down)
-		ret = rmdir(path->buf);
+	if (!ret && !keep_toplevel && !kept_down) {
+		ret = 0;
+		if (!dry_run)
+			ret = rmdir(path->buf);
+		append_dir_name(dels, errs, path->buf, prefix, res);
+	}
 	else if (kept_up)
 		/*
 		 * report the uplevel that it is not an error that we
@@ -1359,7 +1390,14 @@ static int remove_dir_recurse(struct strbuf *path, int flag, int *kept_up)
 
 int remove_dir_recursively(struct strbuf *path, int flag)
 {
-	return remove_dir_recurse(path, flag, NULL);
+	return remove_dir_recurse(path, flag, NULL, 0, NULL, NULL, NULL);
+}
+
+int remove_dir_recursively_with_dryrun(struct strbuf *path, int flag,
+		int dry_run, struct string_list *dels, struct string_list *errs,
+		const char *prefix)
+{
+	return remove_dir_recurse(path, flag, NULL, dry_run, dels, errs, prefix);
 }
 
 void setup_standard_excludes(struct dir_struct *dir)
diff --git a/dir.h b/dir.h
index f5c89e3..828bd49 100644
--- a/dir.h
+++ b/dir.h
@@ -131,6 +131,9 @@ extern void setup_standard_excludes(struct dir_struct *dir);
 #define REMOVE_DIR_KEEP_NESTED_GIT 02
 #define REMOVE_DIR_KEEP_TOPLEVEL 04
 extern int remove_dir_recursively(struct strbuf *path, int flag);
+extern int remove_dir_recursively_with_dryrun(struct strbuf *path,
+			int flag, int dryrun, struct string_list *dels,
+			struct string_list *errs, const char *prefix);
 
 /* tries to remove the path with empty directories along it, ignores ENOENT */
 extern int remove_path(const char *path);
-- 
1.7.9.5

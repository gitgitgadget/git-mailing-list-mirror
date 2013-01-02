From: Zoltan Klinger <zoltan.klinger@gmail.com>
Subject: [PATCH v3] git-clean: Display more accurate delete messages
Date: Wed,  2 Jan 2013 12:45:59 +1100
Message-ID: <1357091159-22080-1-git-send-email-zoltan.klinger@gmail.com>
Cc: Zoltan Klinger <zoltan.klinger@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 02 02:45:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqDOj-0000qk-87
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jan 2013 02:45:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752233Ab3ABBpS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jan 2013 20:45:18 -0500
Received: from mail-da0-f47.google.com ([209.85.210.47]:57668 "EHLO
	mail-da0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051Ab3ABBpQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jan 2013 20:45:16 -0500
Received: by mail-da0-f47.google.com with SMTP id s35so6225418dak.6
        for <git@vger.kernel.org>; Tue, 01 Jan 2013 17:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=InSaMyesj2ZQYXJA9pCDPLqoA/HSeqCbT+DyZF0nu5o=;
        b=T1v3ajNBR8F1bam/ofGrpAPlxCOrAzt3yOg0jQW9yGnZq4fLXD18M3GcAbfKJJSULR
         rIB0VPuwdtZu/XvAUI0jMrHR+YCySFx/C+pPfFuWJZ35cBtyeI6laIn3PQyQeZuRA+ZV
         uit4QAOslpMU2uE+p1g90BTquVPi7QbWssrOUurPx97mFGiH/bbYEG0XtdQ2StqWNkLR
         Kl/NqFXzg5c3c5Ko/euCvwHlMQXc6f31oUuKiX6rNgdW3r3cBjjiQlWuM7rWFqen2joV
         +G6j6SI5T/MEcBP5WIKW2tF6I2ceqnrzqBCp01Sy++qMUc55JsiPwnD7phaPIzlgLZ6e
         O/WQ==
X-Received: by 10.66.80.70 with SMTP id p6mr133022659pax.23.1357091114663;
        Tue, 01 Jan 2013 17:45:14 -0800 (PST)
Received: from localhost.localdomain (082.016.dsl.syd.iprimus.net.au. [210.50.54.82])
        by mx.google.com with ESMTPS id vs3sm27459564pbc.61.2013.01.01.17.45.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 01 Jan 2013 17:45:14 -0800 (PST)
X-Mailer: git-send-email 1.7.9.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212484>

(1) Only print out the names of the files and directories that got
    actually deleted.
(2) Show warning message for ignored untracked git repositories

Consider the following repo layout:

  test.git/
    |-- tracked_dir/
    |     |-- some_tracked_file
    |     |-- some_untracked_file
    |-- tracked_file
    |-- untracked_file
    |-- untracked_foo/
    |     |-- bar/
    |     |     |-- bar.txt
    |     |-- emptydir/
    |     |-- frotz.git/
    |           |-- frotz.tx
    |-- untracked_some.git/
          |-- some.txt

Suppose the user issues 'git clean -fd' from the test.git directory.

When -d option is used and untracked directory 'foo' contains a
subdirectory 'frotz.git' that is managed by a different git repository
therefore it will not be removed.

  $ git clean -fd
  Removing tracked_dir/some_untracked_file
  Removing untracked_file
  Removing untracked_foo/
  Removing untracked_some.git/

The message displayed to the user is slightly misleading. The foo/
directory has not been removed because of foo/frotz.git still exists.
On the other hand the subdirectories 'bar' and 'emptydir' have been
deleted but they're not mentioned anywhere. Also, untracked_some.git
has not been removed either.

This behaviour is the result of the way the deletion of untracked
directories are reported. In the current implementation they are
deleted recursively but only the name of the top most directory is
printed out. The calling function does not know about any
subdirectories that could not be removed during the recursion.

Improve the way the deleted directories are reported back to
the user:
  (1) Create a recursive delete function 'remove_dirs' in builtin/clean.c
      to run in both dry_run and delete modes with the delete logic as
      follows:
        (a) Check if the current directory to be deleted is an untracked
            git repository. If it is and --force --force option is not set
            do not touch this directory, print ignore message, set dir_gone
            flag to false for the caller and return.
        (b) Otherwise for each item in current directory:
              (i)   If current directory cannot be accessed, print warning,
                    set dir_gone flag to false and return.
              (ii)  If the item is a subdirectory recurse into it,
                    check for the returned value of the dir_gone flag.
                    If the subdirectory is gone, add the name of the deleted
                    directory to a list of successfully removed items 'dels'.
                    Else set the dir_gone flag as the current directory
                    cannot be removed because we have at least one subdirectory
                    hanging around.
              (iii) If it is a file try to remove it. If success add the
                    file name to the 'dels' list, else print error and set
                    dir_gone flag to false.
        (c) After we finished deleting all items in the current directory and
            the dir_gone flag is still true, remove the directory itself.
            If failed set the dir_gone flag to false.

        (d) If the current directory cannot be deleted because the dir_gone flag
            has been set to false, print out all the successfully deleted items
            for this directory from the 'dels' list.
        (e) We're done with the current directory, return.

  (2) Modify the cmd_clean() function to:
        (a) call the recursive delete function 'remove_dirs()' for each
            topmost directory it wants to remove
        (b) check for the returned value of dir_gone flag. If it's true
            print the name of the directory as being removed.

Consider the output of the improved version:

  $ git clean -fd
  Removing tracked_dir/some_untracked_file
  Removing untracked_file
  warning: ignoring untracked git repository untracked_foo/frotz.git
  Removing untracked_foo/bar
  Removing untracked_foo/emptydir
  warning: ignoring untracked git repository untracked_some.git/

Now it displays only the file and directory names that got actually
deleted and shows warnings about ignored untracked git repositories.

Reported-by: Soren Brinkmann <soren.brinkmann@xilinx.com>

Signed-off-by: Zoltan Klinger <zoltan.klinger@gmail.com>
---
 builtin/clean.c |  149 ++++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 120 insertions(+), 29 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 69c1cda..37e403a 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -10,6 +10,7 @@
 #include "cache.h"
 #include "dir.h"
 #include "parse-options.h"
+#include "refs.h"
 #include "string-list.h"
 #include "quote.h"
 
@@ -20,6 +21,13 @@ static const char *const builtin_clean_usage[] = {
 	NULL
 };
 
+static const char* MSG_REMOVE = "Removing %s\n";
+static const char* MSG_WOULD_REMOVE = "Would remove %s\n";
+static const char* MSG_WOULD_NOT_REMOVE = "Would not remove %s\n";
+static const char* MSG_WOULD_IGNORE_GIT_DIR = "Would ignore untracked git repository %s\n";
+static const char* MSG_WARN_GIT_DIR_IGNORE = "ignoring untracked git repository %s";
+static const char* MSG_WARN_REMOVE_FAILED = "failed to remove %s";
+
 static int git_clean_config(const char *var, const char *value, void *cb)
 {
 	if (!strcmp(var, "clean.requireforce"))
@@ -34,11 +42,109 @@ static int exclude_cb(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
+static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
+		int dry_run, int quiet, int *dir_gone)
+{
+	DIR *dir;
+	struct strbuf quoted = STRBUF_INIT;
+	struct dirent *e;
+	int res = 0, ret = 0, gone = 1, original_len = path->len, len, i;
+	unsigned char submodule_head[20];
+	struct string_list dels = STRING_LIST_INIT_DUP;
+
+	*dir_gone = 1;
+
+	quote_path_relative(path->buf, strlen(path->buf), &quoted, prefix);
+	if ((force_flag & REMOVE_DIR_KEEP_NESTED_GIT) &&
+	    !resolve_gitlink_ref(path->buf, "HEAD", submodule_head)) {
+		if (dry_run && !quiet)
+			printf(_(MSG_WOULD_IGNORE_GIT_DIR), quoted.buf);
+		else if (!dry_run)
+			warning(_(MSG_WARN_GIT_DIR_IGNORE), quoted.buf);
+
+		*dir_gone = 0;
+		return 0;
+	}
+
+	dir = opendir(path->buf);
+	if (!dir) {
+		/* an empty dir could be removed even if it is unreadble */
+		res = dry_run ? 0 : rmdir(path->buf);
+		if (res) {
+			warning(_(MSG_WARN_REMOVE_FAILED), quoted.buf);
+			*dir_gone = 0;
+		}
+		return res;
+	}
+
+	if (path->buf[original_len - 1] != '/')
+		strbuf_addch(path, '/');
+
+	len = path->len;
+	while ((e = readdir(dir)) != NULL) {
+		struct stat st;
+		if (is_dot_or_dotdot(e->d_name))
+			continue;
+
+		strbuf_setlen(path, len);
+		strbuf_addstr(path, e->d_name);
+		quote_path_relative(path->buf, strlen(path->buf), &quoted, prefix);
+		if (lstat(path->buf, &st))
+			; /* fall thru */
+		else if (S_ISDIR(st.st_mode)) {
+			if (remove_dirs(path, prefix, force_flag, dry_run, quiet, &gone))
+				ret = 1;
+			if (gone)
+				string_list_append(&dels, quoted.buf);
+			else
+				*dir_gone = 0;
+			continue;
+		} else {
+			res = dry_run ? 0 : unlink(path->buf);
+			if (!res)
+				string_list_append(&dels, quoted.buf);
+			else {
+				warning(_(MSG_WARN_REMOVE_FAILED), quoted.buf);
+				*dir_gone = 0;
+				ret = 1;
+			}
+			continue;
+		}
+
+		/* path too long, stat fails, or non-directory still exists */
+		*dir_gone = 0;
+		ret = 1;
+		break;
+	}
+	closedir(dir);
+
+	strbuf_setlen(path, original_len);
+	quote_path_relative(path->buf, strlen(path->buf), &quoted, prefix);
+
+	if (*dir_gone) {
+		res = dry_run ? 0 : rmdir(path->buf);
+		if (!res)
+			*dir_gone = 1;
+		else {
+			warning(_(MSG_WARN_REMOVE_FAILED), quoted.buf);
+			*dir_gone = 0;
+			ret = 1;
+		}
+	}
+
+	if (!*dir_gone && !quiet) {
+		for (i = 0; i < dels.nr; i++)
+			printf(dry_run ?  _(MSG_WOULD_REMOVE) : _(MSG_REMOVE), dels.items[i].string);
+	}
+	string_list_clear(&dels, 0);
+	return ret;
+}
+
 int cmd_clean(int argc, const char **argv, const char *prefix)
 {
-	int i;
-	int show_only = 0, remove_directories = 0, quiet = 0, ignored = 0;
-	int ignored_only = 0, config_set = 0, errors = 0;
+	int i, res;
+	int dry_run = 0, remove_directories = 0, quiet = 0, ignored = 0;
+	int ignored_only = 0, config_set = 0, errors = 0, gone = 1;
 	int rm_flags = REMOVE_DIR_KEEP_NESTED_GIT;
 	struct strbuf directory = STRBUF_INIT;
 	struct dir_struct dir;
@@ -49,7 +155,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	char *seen = NULL;
 	struct option options[] = {
 		OPT__QUIET(&quiet, N_("do not print names of files removed")),
-		OPT__DRY_RUN(&show_only, N_("dry run")),
+		OPT__DRY_RUN(&dry_run, N_("dry run")),
 		OPT__FORCE(&force, N_("force")),
 		OPT_BOOLEAN('d', NULL, &remove_directories,
 				N_("remove whole directories")),
@@ -77,7 +183,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	if (ignored && ignored_only)
 		die(_("-x and -X cannot be used together"));
 
-	if (!show_only && !force) {
+	if (!dry_run && !force) {
 		if (config_set)
 			die(_("clean.requireForce set to true and neither -n nor -f given; "
 				  "refusing to clean"));
@@ -150,38 +256,23 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
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
+			if (remove_directories || (matches == MATCHED_EXACTLY)) {
+				if (remove_dirs(&directory, prefix, rm_flags, dry_run, quiet, &gone))
 					errors++;
-				}
-			} else if (show_only) {
-				printf(_("Would not remove %s\n"), qname);
-			} else {
-				printf(_("Not removing %s\n"), qname);
+				if (gone && !quiet)
+					printf(dry_run ? _(MSG_WOULD_REMOVE) : _(MSG_REMOVE), qname);
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
+			res = dry_run ? 0 : unlink(ent->name);
+			if (res) {
+				warning(_(MSG_WARN_REMOVE_FAILED), qname);
 				errors++;
-			}
+			} else if (!quiet)
+				printf(dry_run ? _(MSG_WOULD_REMOVE) :_(MSG_REMOVE), qname);
 		}
 	}
 	free(seen);
-- 
1.7.9.5

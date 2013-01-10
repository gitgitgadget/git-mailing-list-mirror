From: Zoltan Klinger <zoltan.klinger@gmail.com>
Subject: [PATCH v5] git-clean: Display more accurate delete messages
Date: Fri, 11 Jan 2013 09:53:46 +1100
Message-ID: <1357858426-21564-1-git-send-email-zoltan.klinger@gmail.com>
Cc: Zoltan Klinger <zoltan.klinger@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 11 00:02:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtR8M-000675-0h
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jan 2013 00:02:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754223Ab3AJXBl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2013 18:01:41 -0500
Received: from mail-pa0-f44.google.com ([209.85.220.44]:46538 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753594Ab3AJXBj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2013 18:01:39 -0500
Received: by mail-pa0-f44.google.com with SMTP id hz11so632541pad.3
        for <git@vger.kernel.org>; Thu, 10 Jan 2013 15:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=EGkQkO8Blfbzc5q7O+3jKF4xK+bvV+P78cmYcn4avSg=;
        b=r8HAvLGWkzoRGCcIRHGjTZ0FPlFobyWJRLleZUk0veDm5Mog5I7UmeIVy7tP+Uo5uC
         CSasGgnmjiasUdca6V1+flFZN8mDWVm0bKg0aH0N53KXsz6a+iBoBQ8lxTbDE34Ef0Bu
         tABrS9YJtPNWc2Yz0H2OHgCBTEVquZw/9NT38q7MWVC6+n5MqIvFang+wqfmYnILYo4e
         duZe7nO2TnGPbuhQ+ZVRK47Eu8G9T0CrXFauHB2gEjAZ36MEKI6MCMsIrUPIMbqymkBV
         37sKQdjvyI+G/0ep1NIhKVFxiCrDJ9BhfHp/ze8tHu3dx803MvsqdBp/u0ESgcURB6be
         AcaA==
X-Received: by 10.68.136.132 with SMTP id qa4mr54449042pbb.166.1357858899066;
        Thu, 10 Jan 2013 15:01:39 -0800 (PST)
Received: from localhost.localdomain (082.016.dsl.syd.iprimus.net.au. [210.50.54.82])
        by mx.google.com with ESMTPS id kl5sm1524386pbc.74.2013.01.10.15.01.37
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 10 Jan 2013 15:01:38 -0800 (PST)
X-Mailer: git-send-email 1.7.9.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213158>

(1) Only print out the names of the files and directories that got
    actually deleted. Also do not mention that we are not removing
    directories when the user did not ask us to do so with '-d'.
(2) Show ignore message for skipped untracked git repositories.

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
  Skipping repository untracked_foo/frotz.git
  Removing untracked_foo/bar
  Removing untracked_foo/emptydir
  Skipping repository untracked_some.git/

Now it displays only the file and directory names that got actually
deleted and shows the name of the untracked git repositories it ignored.

Reported-by: Soren Brinkmann <soren.brinkmann@xilinx.com>

Signed-off-by: Zoltan Klinger <zoltan.klinger@gmail.com>
---
 builtin/clean.c |  156 ++++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 127 insertions(+), 29 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 69c1cda..943845d 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -10,6 +10,7 @@
 #include "cache.h"
 #include "dir.h"
 #include "parse-options.h"
+#include "refs.h"
 #include "string-list.h"
 #include "quote.h"
 
@@ -20,6 +21,12 @@ static const char *const builtin_clean_usage[] = {
 	NULL
 };
 
+static const char *msg_remove = N_("Removing %s\n");
+static const char *msg_would_remove = N_("Would remove %s\n");
+static const char *msg_skip_git_dir = N_("Skipping repository %s\n");
+static const char *msg_would_skip_git_dir = N_("Would skip repository %s\n");
+static const char *msg_warn_remove_failed = N_("failed to remove %s");
+
 static int git_clean_config(const char *var, const char *value, void *cb)
 {
 	if (!strcmp(var, "clean.requireforce"))
@@ -34,11 +41,114 @@ static int exclude_cb(const struct option *opt, const char *arg, int unset)
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
+	if ((force_flag & REMOVE_DIR_KEEP_NESTED_GIT) &&
+			!resolve_gitlink_ref(path->buf, "HEAD", submodule_head)) {
+		if (!quiet) {
+			quote_path_relative(path->buf, strlen(path->buf), &quoted, prefix);
+			printf(dry_run ?  _(msg_would_skip_git_dir) : _(msg_skip_git_dir),
+					quoted.buf);
+		}
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
+			quote_path_relative(path->buf, strlen(path->buf), &quoted, prefix);
+			warning(_(msg_warn_remove_failed), quoted.buf);
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
+		if (lstat(path->buf, &st))
+			; /* fall thru */
+		else if (S_ISDIR(st.st_mode)) {
+			if (remove_dirs(path, prefix, force_flag, dry_run, quiet, &gone))
+				ret = 1;
+			if (gone) {
+				quote_path_relative(path->buf, strlen(path->buf), &quoted, prefix);
+				string_list_append(&dels, quoted.buf);
+			}
+			else
+				*dir_gone = 0;
+			continue;
+		} else {
+			res = dry_run ? 0 : unlink(path->buf);
+			if (!res) {
+				quote_path_relative(path->buf, strlen(path->buf), &quoted, prefix);
+				string_list_append(&dels, quoted.buf);
+			}
+			else {
+				quote_path_relative(path->buf, strlen(path->buf), &quoted, prefix);
+				warning(_(msg_warn_remove_failed), quoted.buf);
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
+
+	if (*dir_gone) {
+		res = dry_run ? 0 : rmdir(path->buf);
+		if (!res)
+			*dir_gone = 1;
+		else {
+			quote_path_relative(path->buf, strlen(path->buf), &quoted, prefix);
+			warning(_(msg_warn_remove_failed), quoted.buf);
+			*dir_gone = 0;
+			ret = 1;
+		}
+	}
+
+	if (!*dir_gone && !quiet) {
+		for (i = 0; i < dels.nr; i++)
+			printf(dry_run ?  _(msg_would_remove) : _(msg_remove), dels.items[i].string);
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
@@ -49,7 +159,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	char *seen = NULL;
 	struct option options[] = {
 		OPT__QUIET(&quiet, N_("do not print names of files removed")),
-		OPT__DRY_RUN(&show_only, N_("dry run")),
+		OPT__DRY_RUN(&dry_run, N_("dry run")),
 		OPT__FORCE(&force, N_("force")),
 		OPT_BOOLEAN('d', NULL, &remove_directories,
 				N_("remove whole directories")),
@@ -77,7 +187,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	if (ignored && ignored_only)
 		die(_("-x and -X cannot be used together"));
 
-	if (!show_only && !force) {
+	if (!dry_run && !force) {
 		if (config_set)
 			die(_("clean.requireForce set to true and neither -n nor -f given; "
 				  "refusing to clean"));
@@ -149,38 +259,26 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 
 		if (S_ISDIR(st.st_mode)) {
 			strbuf_addstr(&directory, ent->name);
-			qname = quote_path_relative(directory.buf, directory.len, &buf, prefix);
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
+				if (gone && !quiet) {
+					qname = quote_path_relative(directory.buf, directory.len, &buf, prefix);
+					printf(dry_run ? _(msg_would_remove) : _(msg_remove), qname);
 				}
-			} else if (show_only) {
-				printf(_("Would not remove %s\n"), qname);
-			} else {
-				printf(_("Not removing %s\n"), qname);
 			}
 			strbuf_reset(&directory);
 		} else {
 			if (pathspec && !matches)
 				continue;
-			qname = quote_path_relative(ent->name, -1, &buf, prefix);
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
+				qname = quote_path_relative(ent->name, -1, &buf, prefix);
+				warning(_(msg_warn_remove_failed), qname);
 				errors++;
+			} else if (!quiet) {
+				qname = quote_path_relative(ent->name, -1, &buf, prefix);
+				printf(dry_run ? _(msg_would_remove) : _(msg_remove), qname);
 			}
 		}
 	}
-- 
1.7.9.5

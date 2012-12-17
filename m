From: Zoltan Klinger <zoltan.klinger@gmail.com>
Subject: [PATCH v2] git-clean: Display more accurate delete messages
Date: Mon, 17 Dec 2012 22:29:25 +1100
Message-ID: <1355743765-17549-1-git-send-email-zoltan.klinger@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Zoltan Klinger <zoltan.klinger@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 17 12:30:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkYta-0004Pq-SF
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 12:30:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752263Ab2LQL3s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Dec 2012 06:29:48 -0500
Received: from mail-pb0-f46.google.com ([209.85.160.46]:42269 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752125Ab2LQL3r (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 06:29:47 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so3934381pbc.19
        for <git@vger.kernel.org>; Mon, 17 Dec 2012 03:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=T5erKtChX25Iw8aOrwLuGJxqDp9aAH1TUQEEXKd1mAc=;
        b=TtkRSCsnlP7YDqYJWX4evWhxfE/TP2A0+z98PhSGUJEYoL9DybMT1L1EkK/RYfTwvV
         ArBwTJkepuqaD7Fucz1BGyOUT7uziZy0fi13JDoGOLNjJboiCuAqnTZW6eoFto8Xodro
         G7UqYpSQIVExb9wLs18nAGpG31akG2vn1gu+VDeVuTuVSdLgOiHD+0pbaC11FyoxOAbf
         Bha0FspXsdnlKk04WzXssVMhWxu+o08CRk2bSniYjRIEyQBAFFfvNKiNTbyK3kz6aD/e
         fdB+xt+CawWqHWNKkwvKY06DsHhdAN0hxjiuLMt3gLTiY5xVAEfjKyOUYGSnY1XzxngR
         sy7w==
Received: by 10.69.1.73 with SMTP id be9mr43108597pbd.116.1355743787327;
        Mon, 17 Dec 2012 03:29:47 -0800 (PST)
Received: from localhost.localdomain (ppp121-44-17-235.lns20.syd6.internode.on.net. [121.44.17.235])
        by mx.google.com with ESMTPS id ue7sm8048743pbc.53.2012.12.17.03.29.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 17 Dec 2012 03:29:46 -0800 (PST)
X-Mailer: git-send-email 1.7.9.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211674>

(1) Only print out the names of the files and directories that got
    actually deleted.
(2) Show warning message for ignored untracked git repositories

Consider the following repo layout:

  test.git/
    |-- tracked_file
    |-- tracked_dir/
    |=C2=A0=C2=A0   |-- some_tracked_file
    |=C2=A0=C2=A0   |-- some_untracked_file
    |-- untracked_file
    |-- untracked_foo/
    |=C2=A0=C2=A0   |-- bar/
    |=C2=A0=C2=A0   |=C2=A0=C2=A0   |-- bar.txt
    |=C2=A0=C2=A0   |-- emptydir/
    |=C2=A0=C2=A0   |-- frotz.git/
    |=C2=A0=C2=A0         |-- frotz.tx
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
  (1) Modify the recursive delete function to run in both dry_run and
      delete modes.
  (2) During the recursion collect the name of the files and
      directories that:
        (a) will be or have been removed.
        (b) could not be removed due to file system permissions, etc.
        (c) will be or have been ignored because they are untracked
            git repositories that are not removed by default unless
            the --force --force option is used.
  (3) After finishing the delete process print out:
        (a) the names of all deleted topmost directories and nothing
            about their (recursive) contents if all content was removed
            successfully
        (b) the names of all files that have been deleted but their par=
ent
            directory still exists
        (c) warning for all untracked git repositories that have been
            ignored
        (d) warning about files and directories that failed to delete.

Consider the output of the improved version:

  $ git clean -fd
  Removing tracked_dir/some_untracked_file
  Removing untracked_file
  Removing untracked_foo/bar/
  Removing untracked_foo/emptydir/
  warning: ignoring untracked git repository untracked_foo/frotz.git/
  warning: ignoring untracked git repository untracked_some.git/

Now it displays only the file and directory names that got actually
deleted and shows warnings about ignored untracked git repositories.

Signed-off-by: Zoltan Klinger <zoltan.klinger@gmail.com>
Reported-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---

 Have updated patch with feedback received from Junio and Soren Brinkma=
nn

 builtin/clean.c |   78 +++++++++++++++++++++++++++++++++++------------=
--------
 dir.c           |   65 +++++++++++++++++++++++++++++++++++++++-------
 dir.h           |    4 +++
 3 files changed, 109 insertions(+), 38 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 69c1cda..4824bac 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -34,22 +34,42 @@ static int exclude_cb(const struct option *opt, con=
st char *arg, int unset)
 	return 0;
 }
=20
+static void print_filtered(const char *msg, struct string_list *lst)
+{
+	int i;
+	char *name;
+	char *dir =3D 0;
+
+	sort_string_list(lst);
+
+	for (i =3D 0; i < lst->nr; i++) {
+		name =3D lst->items[i].string;
+		if (dir =3D=3D 0 || strncmp(name, dir, strlen(dir)) !=3D 0)
+			printf("%s %s\n", msg, name);
+		if (name[strlen(name) - 1] =3D=3D '/')
+			dir =3D name;
+	}
+}
+
 int cmd_clean(int argc, const char **argv, const char *prefix)
 {
 	int i;
-	int show_only =3D 0, remove_directories =3D 0, quiet =3D 0, ignored =3D=
 0;
+	int dry_run =3D 0, remove_directories =3D 0, quiet =3D 0, ignored =3D=
 0;
 	int ignored_only =3D 0, config_set =3D 0, errors =3D 0;
 	int rm_flags =3D REMOVE_DIR_KEEP_NESTED_GIT;
 	struct strbuf directory =3D STRBUF_INIT;
 	struct dir_struct dir;
 	static const char **pathspec;
 	struct strbuf buf =3D STRBUF_INIT;
+	struct string_list dels =3D STRING_LIST_INIT_DUP;
+	struct string_list skips =3D STRING_LIST_INIT_DUP;
+	struct string_list errs =3D STRING_LIST_INIT_DUP;
 	struct string_list exclude_list =3D STRING_LIST_INIT_NODUP;
 	const char *qname;
 	char *seen =3D NULL;
 	struct option options[] =3D {
 		OPT__QUIET(&quiet, N_("do not print names of files removed")),
-		OPT__DRY_RUN(&show_only, N_("dry run")),
+		OPT__DRY_RUN(&dry_run, N_("dry run")),
 		OPT__FORCE(&force, N_("force")),
 		OPT_BOOLEAN('d', NULL, &remove_directories,
 				N_("remove whole directories")),
@@ -77,7 +97,7 @@ int cmd_clean(int argc, const char **argv, const char=
 *prefix)
 	if (ignored && ignored_only)
 		die(_("-x and -X cannot be used together"));
=20
-	if (!show_only && !force) {
+	if (!dry_run && !force) {
 		if (config_set)
 			die(_("clean.requireForce set to true and neither -n nor -f given; =
"
 				  "refusing to clean"));
@@ -150,43 +170,45 @@ int cmd_clean(int argc, const char **argv, const =
char *prefix)
 		if (S_ISDIR(st.st_mode)) {
 			strbuf_addstr(&directory, ent->name);
 			qname =3D quote_path_relative(directory.buf, directory.len, &buf, p=
refix);
-			if (show_only && (remove_directories ||
-			    (matches =3D=3D MATCHED_EXACTLY))) {
-				printf(_("Would remove %s\n"), qname);
-			} else if (remove_directories ||
-				   (matches =3D=3D MATCHED_EXACTLY)) {
-				if (!quiet)
-					printf(_("Removing %s\n"), qname);
-				if (remove_dir_recursively(&directory,
-							   rm_flags) !=3D 0) {
-					warning(_("failed to remove %s"), qname);
-					errors++;
-				}
-			} else if (show_only) {
-				printf(_("Would not remove %s\n"), qname);
-			} else {
-				printf(_("Not removing %s\n"), qname);
+			if (remove_directories || (matches =3D=3D MATCHED_EXACTLY)) {
+				remove_dir_recursively_with_dryrun(&directory, rm_flags, dry_run,
+						&dels, &skips, &errs, prefix);
 			}
 			strbuf_reset(&directory);
 		} else {
 			if (pathspec && !matches)
 				continue;
 			qname =3D quote_path_relative(ent->name, -1, &buf, prefix);
-			if (show_only) {
-				printf(_("Would remove %s\n"), qname);
-				continue;
-			} else if (!quiet) {
-				printf(_("Removing %s\n"), qname);
-			}
-			if (unlink(ent->name) !=3D 0) {
-				warning(_("failed to remove %s"), qname);
-				errors++;
+			if (dry_run)
+				string_list_append(&dels, qname);
+			else {
+				if (unlink(ent->name) !=3D 0)
+					string_list_append(&errs, qname);
+				else
+					string_list_append(&dels, qname);
 			}
 		}
 	}
+
+	if (!quiet) {
+		if (dry_run) {
+			print_filtered("Would remove", &dels);
+			print_filtered("Would ignore untracked git repository", &skips);
+		} else {
+			print_filtered("Removing", &dels);
+			print_filtered("warning: ignoring untracked git repository", &skips=
);
+		}
+	}
+
+	errors =3D errs.nr;
+	if (errors)
+		print_filtered("warning: failed to remove", &errs);
+
 	free(seen);
=20
 	strbuf_release(&directory);
+	string_list_clear(&dels, 0);
+	string_list_clear(&errs, 0);
 	string_list_clear(&exclude_list, 0);
 	return (errors !=3D 0);
 }
diff --git a/dir.c b/dir.c
index 5a83aa7..fd38d5d 100644
--- a/dir.c
+++ b/dir.c
@@ -7,7 +7,9 @@
  */
 #include "cache.h"
 #include "dir.h"
+#include "quote.h"
 #include "refs.h"
+#include "string-list.h"
=20
 struct path_simplify {
 	int len;
@@ -1294,11 +1296,30 @@ int is_empty_dir(const char *path)
 	return ret;
 }
=20
-static int remove_dir_recurse(struct strbuf *path, int flag, int *kept=
_up)
+static void append_dir_name(struct string_list *dels, struct string_li=
st *skips,
+		struct string_list *errs, char *name, const char * prefix, int faile=
d, int isdir)
+{
+	struct strbuf quoted =3D STRBUF_INIT;
+
+	quote_path_relative(name, strlen(name), &quoted, prefix);
+	if (isdir && quoted.buf[strlen(quoted.buf) -1] !=3D '/')
+		strbuf_addch(&quoted, '/');
+
+	if (skips)
+		string_list_append(skips, quoted.buf);
+	else if (!failed && dels)
+		string_list_append(dels, quoted.buf);
+	else if (errs)
+		string_list_append(errs, quoted.buf);
+}
+
+static int remove_dir_recurse(struct strbuf *path, int flag, int *kept=
_up,
+	int dry_run, struct string_list *dels, struct string_list *skips,
+	struct string_list *errs, const char *prefix)
 {
 	DIR *dir;
 	struct dirent *e;
-	int ret =3D 0, original_len =3D path->len, len, kept_down =3D 0;
+	int ret =3D 0, original_len =3D path->len, len, kept_down =3D 0, res =
=3D 0;
 	int only_empty =3D (flag & REMOVE_DIR_EMPTY_ONLY);
 	int keep_toplevel =3D (flag & REMOVE_DIR_KEEP_TOPLEVEL);
 	unsigned char submodule_head[20];
@@ -1306,6 +1327,7 @@ static int remove_dir_recurse(struct strbuf *path=
, int flag, int *kept_up)
 	if ((flag & REMOVE_DIR_KEEP_NESTED_GIT) &&
 	    !resolve_gitlink_ref(path->buf, "HEAD", submodule_head)) {
 		/* Do not descend and nuke a nested git work tree. */
+		append_dir_name(NULL, skips, NULL, path->buf, prefix, 0, 1);
 		if (kept_up)
 			*kept_up =3D 1;
 		return 0;
@@ -1315,8 +1337,13 @@ static int remove_dir_recurse(struct strbuf *pat=
h, int flag, int *kept_up)
 	dir =3D opendir(path->buf);
 	if (!dir) {
 		/* an empty dir could be removed even if it is unreadble */
-		if (!keep_toplevel)
-			return rmdir(path->buf);
+		if (!keep_toplevel) {
+			res =3D 0;
+			if (!dry_run)
+				res =3D rmdir(path->buf);
+			append_dir_name(dels, NULL, errs, path->buf, prefix, res, 1);
+			return res;
+		}
 		else
 			return -1;
 	}
@@ -1334,10 +1361,17 @@ static int remove_dir_recurse(struct strbuf *pa=
th, int flag, int *kept_up)
 		if (lstat(path->buf, &st))
 			; /* fall thru */
 		else if (S_ISDIR(st.st_mode)) {
-			if (!remove_dir_recurse(path, flag, &kept_down))
+			if (!remove_dir_recurse(path, flag, &kept_down, dry_run, dels,
+						skips, errs, prefix))
 				continue; /* happy */
-		} else if (!only_empty && !unlink(path->buf))
-			continue; /* happy, too */
+		} else if (!only_empty) {
+			res =3D 0;
+			if (!dry_run)
+				res =3D unlink(path->buf);
+			append_dir_name(dels, NULL, errs, path->buf, prefix, res, 0);
+			if (!res)
+				continue; /* happy, too */
+		}
=20
 		/* path too long, stat fails, or non-directory still exists */
 		ret =3D -1;
@@ -1346,8 +1380,12 @@ static int remove_dir_recurse(struct strbuf *pat=
h, int flag, int *kept_up)
 	closedir(dir);
=20
 	strbuf_setlen(path, original_len);
-	if (!ret && !keep_toplevel && !kept_down)
-		ret =3D rmdir(path->buf);
+	if (!ret && !keep_toplevel && !kept_down) {
+		ret =3D 0;
+		if (!dry_run)
+			ret =3D rmdir(path->buf);
+		append_dir_name(dels, NULL, errs, path->buf, prefix, res, 1);
+	}
 	else if (kept_up)
 		/*
 		 * report the uplevel that it is not an error that we
@@ -1359,7 +1397,14 @@ static int remove_dir_recurse(struct strbuf *pat=
h, int flag, int *kept_up)
=20
 int remove_dir_recursively(struct strbuf *path, int flag)
 {
-	return remove_dir_recurse(path, flag, NULL);
+	return remove_dir_recurse(path, flag, NULL, 0, NULL, NULL, NULL, NULL=
);
+}
+
+int remove_dir_recursively_with_dryrun(struct strbuf *path, int flag,
+		int dry_run, struct string_list *dels, struct string_list *skips,
+		struct string_list *errs, const char *prefix)
+{
+	return remove_dir_recurse(path, flag, NULL, dry_run, dels, skips, err=
s, prefix);
 }
=20
 void setup_standard_excludes(struct dir_struct *dir)
diff --git a/dir.h b/dir.h
index f5c89e3..780885a 100644
--- a/dir.h
+++ b/dir.h
@@ -131,6 +131,10 @@ extern void setup_standard_excludes(struct dir_str=
uct *dir);
 #define REMOVE_DIR_KEEP_NESTED_GIT 02
 #define REMOVE_DIR_KEEP_TOPLEVEL 04
 extern int remove_dir_recursively(struct strbuf *path, int flag);
+extern int remove_dir_recursively_with_dryrun(struct strbuf *path,
+			int flag, int dryrun, struct string_list *dels,
+			struct string_list *skips, struct string_list *errs,
+			const char *prefix);
=20
 /* tries to remove the path with empty directories along it, ignores E=
NOENT */
 extern int remove_path(const char *path);
--=20
1.7.9.5

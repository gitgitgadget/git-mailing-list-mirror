From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v5 02/28] path.c: make get_pathname() call sites return const char *
Date: Sat,  8 Mar 2014 09:47:54 +0700
Message-ID: <1394246900-31535-3-git-send-email-pclouds@gmail.com>
References: <1393675983-3232-1-git-send-email-pclouds@gmail.com>
 <1394246900-31535-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 08 03:48:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WM7Jh-0004zH-42
	for gcvg-git-2@plane.gmane.org; Sat, 08 Mar 2014 03:48:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752771AbaCHCsa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Mar 2014 21:48:30 -0500
Received: from mail-pd0-f171.google.com ([209.85.192.171]:33725 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752366AbaCHCsG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2014 21:48:06 -0500
Received: by mail-pd0-f171.google.com with SMTP id r10so4772193pdi.16
        for <git@vger.kernel.org>; Fri, 07 Mar 2014 18:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=yzOnCTaz+glO6SyEr/rDEVfDfNpkj4by7TqF4/A8YDo=;
        b=Rm+nuOZcyOdUTfOCtI+XAo0GPZbDcKBXvSofF4J+0TUuJGMS7VoLiBD8AoF6LAKPjq
         O+CKbMKuIVCBCC4cw+FNBHZPrwNcVdtI2PNnlqqu4HhXfcL/n9owb/l/oXs20IrZ6zmG
         BzuqlI6ohe8hsUe2yeHnTzLjagWO/V6ZTavvZsnWK9fwH0OjeuRuAXx5v7k6C4VhOZCG
         nMmsy96MG/SOGGuE+F2AZLZ/fAIVEW2ZbL+wJkEcDLl35sj2BLO65n5dql7sujStCVTr
         S1+2Y6bblCAOKUql0bWBqZ9RZk2AT0RqF7QQ/cbP+1N/mxYxscI8W12+2YdSq+iXYvge
         gQUg==
X-Received: by 10.66.156.137 with SMTP id we9mr26410338pab.30.1394246886015;
        Fri, 07 Mar 2014 18:48:06 -0800 (PST)
Received: from lanh ([115.73.205.153])
        by mx.google.com with ESMTPSA id pp5sm42344070pbb.33.2014.03.07.18.48.02
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 07 Mar 2014 18:48:05 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 08 Mar 2014 09:48:38 +0700
X-Mailer: git-send-email 1.9.0.40.gaa8c3ea
In-Reply-To: <1394246900-31535-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243647>

Before the previous commit, get_pathname returns an array of PATH_MAX
length. Even if git_path() and similar functions does not use the
whole array, git_path() caller can, in theory.

After the commit, get_pathname() may return a buffer that has just
enough room for the returned string and git_path() caller should never
write beyond that.

Make git_path(), mkpath() and git_path_submodule() return a const
buffer to make sure callers do not write in it at all.

This could have been part of the previous commit, but the "const"
conversion is too much distraction from the core changes in path.c.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/checkout.c     | 2 +-
 builtin/clone.c        | 9 +++++----
 builtin/fetch.c        | 5 +++--
 builtin/fsck.c         | 4 ++--
 builtin/receive-pack.c | 2 +-
 builtin/remote.c       | 2 +-
 builtin/repack.c       | 8 +++++---
 cache.h                | 6 +++---
 fast-import.c          | 2 +-
 notes-merge.c          | 6 +++---
 path.c                 | 6 +++---
 refs.c                 | 8 ++++----
 run-command.c          | 4 ++--
 run-command.h          | 2 +-
 sha1_file.c            | 2 +-
 15 files changed, 36 insertions(+), 32 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 5df3837..64c2aca 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -586,7 +586,7 @@ static void update_refs_for_switch(const struct che=
ckout_opts *opts,
 			if (opts->new_branch_log && !log_all_ref_updates) {
 				int temp;
 				char log_file[PATH_MAX];
-				char *ref_name =3D mkpath("refs/heads/%s", opts->new_orphan_branch=
);
+				const char *ref_name =3D mkpath("refs/heads/%s", opts->new_orphan_=
branch);
=20
 				temp =3D log_all_ref_updates;
 				log_all_ref_updates =3D 1;
diff --git a/builtin/clone.c b/builtin/clone.c
index 43e772c..9339371 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -289,16 +289,17 @@ static void copy_alternates(struct strbuf *src, s=
truct strbuf *dst,
 	struct strbuf line =3D STRBUF_INIT;
=20
 	while (strbuf_getline(&line, in, '\n') !=3D EOF) {
-		char *abs_path, abs_buf[PATH_MAX];
+		char *abs_path;
 		if (!line.len || line.buf[0] =3D=3D '#')
 			continue;
 		if (is_absolute_path(line.buf)) {
 			add_to_alternates_file(line.buf);
 			continue;
 		}
-		abs_path =3D mkpath("%s/objects/%s", src_repo, line.buf);
-		normalize_path_copy(abs_buf, abs_path);
-		add_to_alternates_file(abs_buf);
+		abs_path =3D mkpathdup("%s/objects/%s", src_repo, line.buf);
+		normalize_path_copy(abs_path, abs_path);
+		add_to_alternates_file(abs_path);
+		free(abs_path);
 	}
 	strbuf_release(&line);
 	fclose(in);
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 025bc3e..04b51ca 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -544,7 +544,8 @@ static int store_updated_refs(const char *raw_url, =
const char *remote_name,
 	struct strbuf note =3D STRBUF_INIT;
 	const char *what, *kind;
 	struct ref *rm;
-	char *url, *filename =3D dry_run ? "/dev/null" : git_path("FETCH_HEAD=
");
+	char *url;
+	const char *filename =3D dry_run ? "/dev/null" : git_path("FETCH_HEAD=
");
 	int want_status;
=20
 	fp =3D fopen(filename, "a");
@@ -778,7 +779,7 @@ static void check_not_current_branch(struct ref *re=
f_map)
=20
 static int truncate_fetch_head(void)
 {
-	char *filename =3D git_path("FETCH_HEAD");
+	const char *filename =3D git_path("FETCH_HEAD");
 	FILE *fp =3D fopen(filename, "w");
=20
 	if (!fp)
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 1affdd5..643c980 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -225,12 +225,12 @@ static void check_unreachable_object(struct objec=
t *obj)
 			printf("dangling %s %s\n", typename(obj->type),
 			       sha1_to_hex(obj->sha1));
 		if (write_lost_and_found) {
-			char *filename =3D git_path("lost-found/%s/%s",
+			const char *filename =3D git_path("lost-found/%s/%s",
 				obj->type =3D=3D OBJ_COMMIT ? "commit" : "other",
 				sha1_to_hex(obj->sha1));
 			FILE *f;
=20
-			if (safe_create_leading_directories(filename)) {
+			if (safe_create_leading_directories_const(filename)) {
 				error("Could not create lost-found");
 				return;
 			}
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 85bba35..4d27acb 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -599,7 +599,7 @@ static void run_update_post_hook(struct command *co=
mmands)
 	int argc;
 	const char **argv;
 	struct child_process proc;
-	char *hook;
+	const char *hook;
=20
 	hook =3D find_hook("post-update");
 	for (argc =3D 0, cmd =3D commands; cmd; cmd =3D cmd->next) {
diff --git a/builtin/remote.c b/builtin/remote.c
index b3ab4cf..ca3cb3b 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -582,7 +582,7 @@ static int migrate_file(struct remote *remote)
 {
 	struct strbuf buf =3D STRBUF_INIT;
 	int i;
-	char *path =3D NULL;
+	const char *path =3D NULL;
=20
 	strbuf_addf(&buf, "remote.%s.url", remote->name);
 	for (i =3D 0; i < remote->url_nr; i++)
diff --git a/builtin/repack.c b/builtin/repack.c
index bb2314c..4d35349 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -257,7 +257,8 @@ int cmd_repack(int argc, const char **argv, const c=
har *prefix)
 	failed =3D 0;
 	for_each_string_list_item(item, &names) {
 		for (ext =3D 0; ext < 2; ext++) {
-			char *fname, *fname_old;
+			const char *fname_old;
+			char *fname;
 			fname =3D mkpathdup("%s/pack-%s%s", packdir,
 						item->string, exts[ext]);
 			if (!file_exists(fname)) {
@@ -285,7 +286,8 @@ int cmd_repack(int argc, const char **argv, const c=
har *prefix)
 	if (failed) {
 		struct string_list rollback_failure =3D STRING_LIST_INIT_DUP;
 		for_each_string_list_item(item, &rollback) {
-			char *fname, *fname_old;
+			const char *fname_old;
+			char *fname;
 			fname =3D mkpathdup("%s/%s", packdir, item->string);
 			fname_old =3D mkpath("%s/old-%s", packdir, item->string);
 			if (rename(fname_old, fname))
@@ -334,7 +336,7 @@ int cmd_repack(int argc, const char **argv, const c=
har *prefix)
 	/* Remove the "old-" files */
 	for_each_string_list_item(item, &names) {
 		for (ext =3D 0; ext < 2; ext++) {
-			char *fname;
+			const char *fname;
 			fname =3D mkpath("%s/old-%s%s",
 					packdir,
 					item->string,
diff --git a/cache.h b/cache.h
index dc040fb..a344a5f 100644
--- a/cache.h
+++ b/cache.h
@@ -654,9 +654,9 @@ extern char *mkpathdup(const char *fmt, ...)
 	__attribute__((format (printf, 1, 2)));
=20
 /* Return a statically allocated filename matching the sha1 signature =
*/
-extern char *mkpath(const char *fmt, ...) __attribute__((format (print=
f, 1, 2)));
-extern char *git_path(const char *fmt, ...) __attribute__((format (pri=
ntf, 1, 2)));
-extern char *git_path_submodule(const char *path, const char *fmt, ...=
)
+extern const char *mkpath(const char *fmt, ...) __attribute__((format =
(printf, 1, 2)));
+extern const char *git_path(const char *fmt, ...) __attribute__((forma=
t (printf, 1, 2)));
+extern const char *git_path_submodule(const char *path, const char *fm=
t, ...)
 	__attribute__((format (printf, 2, 3)));
=20
 extern char *sha1_file_name(const unsigned char *sha1);
diff --git a/fast-import.c b/fast-import.c
index 4fd18a3..a9f328d 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -403,7 +403,7 @@ static void dump_marks_helper(FILE *, uintmax_t, st=
ruct mark_set *);
=20
 static void write_crash_report(const char *err)
 {
-	char *loc =3D git_path("fast_import_crash_%"PRIuMAX, (uintmax_t) getp=
id());
+	const char *loc =3D git_path("fast_import_crash_%"PRIuMAX, (uintmax_t=
) getpid());
 	FILE *rpt =3D fopen(loc, "w");
 	struct branch *b;
 	unsigned long lu;
diff --git a/notes-merge.c b/notes-merge.c
index 94a1a8a..d59bcc2 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -280,7 +280,7 @@ static void check_notes_merge_worktree(struct notes=
_merge_options *o)
 				    "(%s exists).", git_path("NOTES_MERGE_*"));
 		}
=20
-		if (safe_create_leading_directories(git_path(
+		if (safe_create_leading_directories_const(git_path(
 				NOTES_MERGE_WORKTREE "/.test")))
 			die_errno("unable to create directory %s",
 				  git_path(NOTES_MERGE_WORKTREE));
@@ -295,8 +295,8 @@ static void write_buf_to_worktree(const unsigned ch=
ar *obj,
 				  const char *buf, unsigned long size)
 {
 	int fd;
-	char *path =3D git_path(NOTES_MERGE_WORKTREE "/%s", sha1_to_hex(obj))=
;
-	if (safe_create_leading_directories(path))
+	const char *path =3D git_path(NOTES_MERGE_WORKTREE "/%s", sha1_to_hex=
(obj));
+	if (safe_create_leading_directories_const(path))
 		die_errno("unable to create directory for '%s'", path);
 	if (file_exists(path))
 		die("found existing file at '%s'", path);
diff --git a/path.c b/path.c
index 5346700..36d461e 100644
--- a/path.c
+++ b/path.c
@@ -106,7 +106,7 @@ char *mkpathdup(const char *fmt, ...)
 	return strbuf_detach(&sb, NULL);
 }
=20
-char *mkpath(const char *fmt, ...)
+const char *mkpath(const char *fmt, ...)
 {
 	va_list args;
 	struct strbuf *pathname =3D get_pathname();
@@ -116,7 +116,7 @@ char *mkpath(const char *fmt, ...)
 	return cleanup_path(pathname->buf);
 }
=20
-char *git_path(const char *fmt, ...)
+const char *git_path(const char *fmt, ...)
 {
 	struct strbuf *pathname =3D get_pathname();
 	va_list args;
@@ -152,7 +152,7 @@ void home_config_paths(char **global, char **xdg, c=
har *file)
 	free(to_free);
 }
=20
-char *git_path_submodule(const char *path, const char *fmt, ...)
+const char *git_path_submodule(const char *path, const char *fmt, ...)
 {
 	struct strbuf *buf =3D get_pathname();
 	const char *git_dir;
diff --git a/refs.c b/refs.c
index 89228e2..f846f2f 100644
--- a/refs.c
+++ b/refs.c
@@ -1232,7 +1232,7 @@ static int resolve_gitlink_ref_recursive(struct r=
ef_cache *refs,
 {
 	int fd, len;
 	char buffer[128], *p;
-	char *path;
+	const char *path;
=20
 	if (recursion > MAXDEPTH || strlen(refname) > MAXREFLEN)
 		return -1;
@@ -2032,7 +2032,7 @@ static struct ref_lock *lock_ref_sha1_basic(const=
 char *refname,
 					    const unsigned char *old_sha1,
 					    int flags, int *type_p)
 {
-	char *ref_file;
+	const char *ref_file;
 	const char *orig_refname =3D refname;
 	struct ref_lock *lock;
 	int last_errno =3D 0;
@@ -2095,7 +2095,7 @@ static struct ref_lock *lock_ref_sha1_basic(const=
 char *refname,
 		lock->force_write =3D 1;
=20
  retry:
-	switch (safe_create_leading_directories(ref_file)) {
+	switch (safe_create_leading_directories_const(ref_file)) {
 	case SCLD_OK:
 		break; /* success */
 	case SCLD_VANISHED:
@@ -2533,7 +2533,7 @@ static int rename_tmp_log(const char *newrefname)
 	int attempts_remaining =3D 4;
=20
  retry:
-	switch (safe_create_leading_directories(git_path("logs/%s", newrefnam=
e))) {
+	switch (safe_create_leading_directories_const(git_path("logs/%s", new=
refname))) {
 	case SCLD_OK:
 		break; /* success */
 	case SCLD_VANISHED:
diff --git a/run-command.c b/run-command.c
index 3914d9c..a94a612 100644
--- a/run-command.c
+++ b/run-command.c
@@ -751,9 +751,9 @@ int finish_async(struct async *async)
 #endif
 }
=20
-char *find_hook(const char *name)
+const char *find_hook(const char *name)
 {
-	char *path =3D git_path("hooks/%s", name);
+	const char *path =3D git_path("hooks/%s", name);
 	if (access(path, X_OK) < 0)
 		path =3D NULL;
=20
diff --git a/run-command.h b/run-command.h
index 6b985af..da01954 100644
--- a/run-command.h
+++ b/run-command.h
@@ -45,7 +45,7 @@ int start_command(struct child_process *);
 int finish_command(struct child_process *);
 int run_command(struct child_process *);
=20
-extern char *find_hook(const char *name);
+extern const char *find_hook(const char *name);
 LAST_ARG_MUST_BE_NULL
 extern int run_hook(const char *index_file, const char *name, ...);
=20
diff --git a/sha1_file.c b/sha1_file.c
index 6e8c05d..8af0e18 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -402,7 +402,7 @@ void add_to_alternates_file(const char *reference)
 {
 	struct lock_file *lock =3D xcalloc(1, sizeof(struct lock_file));
 	int fd =3D hold_lock_file_for_append(lock, git_path("objects/info/alt=
ernates"), LOCK_DIE_ON_ERROR);
-	char *alt =3D mkpath("%s\n", reference);
+	const char *alt =3D mkpath("%s\n", reference);
 	write_or_die(fd, alt, strlen(alt));
 	if (commit_lock_file(lock))
 		die("could not close alternates file");
--=20
1.9.0.40.gaa8c3ea

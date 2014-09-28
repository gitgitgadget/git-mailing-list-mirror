From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 02/32] path.c: make get_pathname() call sites return const char *
Date: Sun, 28 Sep 2014 08:22:16 +0700
Message-ID: <1411867366-3821-3-git-send-email-pclouds@gmail.com>
References: <xmqqk34r9z3r.fsf@gitster.dls.corp.google.com>
 <1411867366-3821-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 28 03:23:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XY3Ce-00026L-EF
	for gcvg-git-2@plane.gmane.org; Sun, 28 Sep 2014 03:23:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752651AbaI1BXD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Sep 2014 21:23:03 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:61327 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751267AbaI1BXC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Sep 2014 21:23:02 -0400
Received: by mail-pa0-f41.google.com with SMTP id fa1so7119669pad.28
        for <git@vger.kernel.org>; Sat, 27 Sep 2014 18:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=TdMPREAmOgLAFQD8iBjrGHhaUWSzBFIJfRdNaFGDSoE=;
        b=BI4KJWBUR9hFhotR08qI7QntFcCuqFW86z4nKWcZHK3T9KylJD1lOKm9jNobij4/fJ
         qjatZ9ILZzOS4Hrjsf8WHjeTAZt0uMdFKuwndGUcQfMtvAKtXCjjYU0ZcHjBzkOok7uC
         J5RXTe4gI9G/BLKdYfF+l3cnVO+N0ioE8WUEizzggEyw9PcCBDVBPM4hH7p8rI0Tfu2U
         a3oO4X61TZlw8EC0ZfVtjUQBpsV1YEBk786CtU+FIQzTTHJJSFo5Qx+FsUstLQtqyENy
         GZQ9X1zVEh7NvvFsgYuc+l/rDekgZbO07kgRksbSlod/d3pI/qdtsY+hoYf/gniKxjPb
         T6xw==
X-Received: by 10.70.102.17 with SMTP id fk17mr1038950pdb.2.1411867380941;
        Sat, 27 Sep 2014 18:23:00 -0700 (PDT)
Received: from lanh ([115.73.212.224])
        by mx.google.com with ESMTPSA id tu10sm8614407pab.14.2014.09.27.18.22.57
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Sep 2014 18:23:00 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 28 Sep 2014 08:23:03 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1411867366-3821-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257561>

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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
index 8afdf2b..d402d7a 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -589,7 +589,7 @@ static void update_refs_for_switch(const struct che=
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
index 3927edf..180bc89 100644
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
index 159fb7e..3f8c8f5 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -573,7 +573,8 @@ static int store_updated_refs(const char *raw_url, =
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
@@ -807,7 +808,7 @@ static void check_not_current_branch(struct ref *re=
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
index e9ba576..0082a0e 100644
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
index daf0600..3a49d1a 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -610,7 +610,7 @@ static void run_update_post_hook(struct command *co=
mmands)
 	int argc;
 	const char **argv;
 	struct child_process proc =3D CHILD_PROCESS_INIT;
-	char *hook;
+	const char *hook;
=20
 	hook =3D find_hook("post-update");
 	for (argc =3D 0, cmd =3D commands; cmd; cmd =3D cmd->next) {
diff --git a/builtin/remote.c b/builtin/remote.c
index 9a4640d..d5324ed 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -581,7 +581,7 @@ static int migrate_file(struct remote *remote)
 {
 	struct strbuf buf =3D STRBUF_INIT;
 	int i;
-	char *path =3D NULL;
+	const char *path =3D NULL;
=20
 	strbuf_addf(&buf, "remote.%s.url", remote->name);
 	for (i =3D 0; i < remote->url_nr; i++)
diff --git a/builtin/repack.c b/builtin/repack.c
index 2aae05d..614851b 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -283,7 +283,8 @@ int cmd_repack(int argc, const char **argv, const c=
har *prefix)
 	failed =3D 0;
 	for_each_string_list_item(item, &names) {
 		for (ext =3D 0; ext < ARRAY_SIZE(exts); ext++) {
-			char *fname, *fname_old;
+			const char *fname_old;
+			char *fname;
 			fname =3D mkpathdup("%s/pack-%s%s", packdir,
 						item->string, exts[ext].name);
 			if (!file_exists(fname)) {
@@ -311,7 +312,8 @@ int cmd_repack(int argc, const char **argv, const c=
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
@@ -364,7 +366,7 @@ int cmd_repack(int argc, const char **argv, const c=
har *prefix)
 	/* Remove the "old-" files */
 	for_each_string_list_item(item, &names) {
 		for (ext =3D 0; ext < ARRAY_SIZE(exts); ext++) {
-			char *fname;
+			const char *fname;
 			fname =3D mkpath("%s/old-%s%s",
 					packdir,
 					item->string,
diff --git a/cache.h b/cache.h
index 8206039..2e4d88f 100644
--- a/cache.h
+++ b/cache.h
@@ -705,9 +705,9 @@ extern char *mkpathdup(const char *fmt, ...)
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
 /*
diff --git a/fast-import.c b/fast-import.c
index 96b0f42..9ddcd3b 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -404,7 +404,7 @@ static void dump_marks_helper(FILE *, uintmax_t, st=
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
index fd5fae2..a9e6b15 100644
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
index 015c0e4..a7ceea2 100644
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
@@ -154,7 +154,7 @@ void home_config_paths(char **global, char **xdg, c=
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
index 311a6b5..f616adc 100644
--- a/refs.c
+++ b/refs.c
@@ -1306,7 +1306,7 @@ static int resolve_gitlink_ref_recursive(struct r=
ef_cache *refs,
 {
 	int fd, len;
 	char buffer[128], *p;
-	char *path;
+	const char *path;
=20
 	if (recursion > MAXDEPTH || strlen(refname) > MAXREFLEN)
 		return -1;
@@ -2139,7 +2139,7 @@ static struct ref_lock *lock_ref_sha1_basic(const=
 char *refname,
 					    const unsigned char *old_sha1,
 					    int flags, int *type_p)
 {
-	char *ref_file;
+	const char *ref_file;
 	const char *orig_refname =3D refname;
 	struct ref_lock *lock;
 	int last_errno =3D 0;
@@ -2202,7 +2202,7 @@ static struct ref_lock *lock_ref_sha1_basic(const=
 char *refname,
 		lock->force_write =3D 1;
=20
  retry:
-	switch (safe_create_leading_directories(ref_file)) {
+	switch (safe_create_leading_directories_const(ref_file)) {
 	case SCLD_OK:
 		break; /* success */
 	case SCLD_VANISHED:
@@ -2647,7 +2647,7 @@ static int rename_tmp_log(const char *newrefname)
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
index 761f0fd..1591534 100644
--- a/run-command.c
+++ b/run-command.c
@@ -748,9 +748,9 @@ int finish_async(struct async *async)
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
index 1b135d1..ad938ec 100644
--- a/run-command.h
+++ b/run-command.h
@@ -51,7 +51,7 @@ int start_command(struct child_process *);
 int finish_command(struct child_process *);
 int run_command(struct child_process *);
=20
-extern char *find_hook(const char *name);
+extern const char *find_hook(const char *name);
 LAST_ARG_MUST_BE_NULL
 extern int run_hook_le(const char *const *env, const char *name, ...);
 extern int run_hook_ve(const char *const *env, const char *name, va_li=
st args);
diff --git a/sha1_file.c b/sha1_file.c
index c08c0cb..50c9600 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -404,7 +404,7 @@ void add_to_alternates_file(const char *reference)
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
2.1.0.rc0.78.gc0d8480

From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v5 00/28] Support multiple checkouts
Date: Sat,  8 Mar 2014 09:47:52 +0700
Message-ID: <1394246900-31535-1-git-send-email-pclouds@gmail.com>
References: <1393675983-3232-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 08 03:48:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WM7JP-0004nV-GV
	for gcvg-git-2@plane.gmane.org; Sat, 08 Mar 2014 03:48:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752133AbaCHCr5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2014 21:47:57 -0500
Received: from mail-pa0-f51.google.com ([209.85.220.51]:34337 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751880AbaCHCry (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2014 21:47:54 -0500
Received: by mail-pa0-f51.google.com with SMTP id kq14so4986181pab.10
        for <git@vger.kernel.org>; Fri, 07 Mar 2014 18:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=fNKgnNmAFTSWafK9cK5E5+egoFrws/npriNdy84EGGU=;
        b=kv9lpMZ+nImSlGsP7FtpCPIJqHiTRo7CzJtLk/AlYJCEbKwkKhaywJZJUqfHaoCCJY
         jxYXrgSecOhu7+FhQNbRNrnK8mWHo4iRdn3xTwoUiGZ+swdNDgzYvo9w3CxgLBDhutxp
         MAPbTlx3Fpl2ASfjCQ3HezW1oADbsM4YqvvL7FSwaoz/UtN0BHIWsEuDYdzDk7mga7Kx
         TDP0cJHtUE0dOElSNEDZYyrDQj4OBdiQ21IonrFGEmKfm4y+f2mk2qwiGz1ktjTVWPcR
         pAiWUvS0vuxay33da2PUh9y2ydWT98csr457jeAn00AAHgJlAoJdIj1xpuiqI92Et96D
         f8qQ==
X-Received: by 10.66.240.130 with SMTP id wa2mr25860723pac.73.1394246873974;
        Fri, 07 Mar 2014 18:47:53 -0800 (PST)
Received: from lanh ([115.73.205.153])
        by mx.google.com with ESMTPSA id ce15sm18635907pac.0.2014.03.07.18.47.49
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 07 Mar 2014 18:47:53 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 08 Mar 2014 09:48:26 +0700
X-Mailer: git-send-email 1.9.0.40.gaa8c3ea
In-Reply-To: <1393675983-3232-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243641>

The diff against v4 is kinda big but it's mostly about converting
`...` to $(...) and making git_path() and friends return a const
string.

Another notable change is I no longer attempt to support checkouts on
portable devices. Torsten pointed out (privately) that my dealing with
Windows drives was insufficient. And Junio was not so happy with how
link() was handled either. We can revisit it later.

Many thanks to Eric, who was very patient to go through the series
carefully and pointed out problems that I overlooked.

v4..v5 diff below for convenience
-- 8< --
diff --git a/Documentation/config.txt b/Documentation/config.txt
index 438b213..c635b8d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1184,9 +1184,10 @@ gc.pruneexpire::
 	unreachable objects immediately.
 
 gc.prunereposexpire::
-	When 'git gc' is run, it will call 'prune --repos --expire 3.months.ago'.
-	Override the grace period with this config variable.  The value
-	"now" may be used to disable this  grace period and always prune
+	When 'git gc' is run, it will call
+	'prune --repos --expire 3.months.ago'.
+	Override the grace period with this config variable. The value
+	"now" may be used to disable the grace period and always prune
 	$GIT_DIR/repos immediately.
 
 gc.reflogexpire::
diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 8e6ad32..8a9cac8 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -238,7 +238,9 @@ print a message to stderr and exit with nonzero status.
 --git-path <path>::
 	Resolve "$GIT_DIR/<path>" and takes other path relocation
 	variables such as $GIT_OBJECT_DIRECTORY,
-	$GIT_INDEX_FILE... into account.
+	$GIT_INDEX_FILE... into account. For example, if
+	$GIT_OBJECT_DIRECTORY is set to /foo/bar then "git rev-parse
+	--git-path objects/abc" returns /tmp/bar/abc.
 
 --show-cdup::
 	When the command is invoked from a subdirectory, show the
diff --git a/Documentation/gitrepository-layout.txt b/Documentation/gitrepository-layout.txt
index 2dc6901..dff6c47 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -47,7 +47,7 @@ use with dumb transports but otherwise is OK as long as
 `objects/info/alternates` points at the object stores it
 borrows from.
 +
-This directory is ignored $GIT_COMMON_DIR is set and
+This directory is ignored if $GIT_COMMON_DIR is set and
 "$GIT_COMMON_DIR/objects" will be used instead.
 
 objects/[0-9a-f][0-9a-f]::
@@ -95,7 +95,7 @@ refs::
 	References are stored in subdirectories of this
 	directory.  The 'git prune' command knows to preserve
 	objects reachable from refs found in this directory and
-	its subdirectories. This directory is ignored $GIT_COMMON_DIR
+	its subdirectories. This directory is ignored if $GIT_COMMON_DIR
 	is set and "$GIT_COMMON_DIR/refs" will be used instead.
 
 refs/heads/`name`::
@@ -118,7 +118,7 @@ refs/replace/`<obj-sha1>`::
 packed-refs::
 	records the same information as refs/heads/, refs/tags/,
 	and friends record in a more efficient way.  See
-	linkgit:git-pack-refs[1]. This file is ignored $GIT_COMMON_DIR
+	linkgit:git-pack-refs[1]. This file is ignored if $GIT_COMMON_DIR
 	is set and "$GIT_COMMON_DIR/packed-refs" will be used instead.
 
 HEAD::
@@ -151,7 +151,7 @@ branches::
 	'repository' argument.  See the REMOTES section in
 	linkgit:git-fetch[1] for details.  This mechanism is legacy
 	and not likely to be found in modern repositories. This
-	directory is ignored $GIT_COMMON_DIR is set and
+	directory is ignored if $GIT_COMMON_DIR is set and
 	"$GIT_COMMON_DIR/branches" will be used instead.
 
 
@@ -162,7 +162,7 @@ hooks::
 	default.  To enable, the `.sample` suffix has to be
 	removed from the filename by renaming.
 	Read linkgit:githooks[5] for more details about
-	each hook. This directory is ignored $GIT_COMMON_DIR is set
+	each hook. This directory is ignored if $GIT_COMMON_DIR is set
 	and "$GIT_COMMON_DIR/hooks" will be used instead.
 
 
@@ -172,7 +172,7 @@ index::
 
 info::
 	Additional information about the repository is recorded
-	in this directory. This directory is ignored $GIT_COMMON_DIR
+	in this directory. This directory is ignored if $GIT_COMMON_DIR
 	is set and "$GIT_COMMON_DIR/index" will be used instead.
 
 info/refs::
@@ -210,7 +210,7 @@ remotes::
 	'git pull' and 'git push' commands.  See the REMOTES section
 	in linkgit:git-fetch[1] for details.  This mechanism is legacy
 	and not likely to be found in modern repositories. This
-	directory is ignored $GIT_COMMON_DIR is set and
+	directory is ignored if $GIT_COMMON_DIR is set and
 	"$GIT_COMMON_DIR/remotes" will be used instead.
 
 logs::
@@ -230,7 +230,7 @@ shallow::
 	This is similar to `info/grafts` but is internally used
 	and maintained by shallow clone mechanism.  See `--depth`
 	option to linkgit:git-clone[1] and linkgit:git-fetch[1]. This
-	file is ignored $GIT_COMMON_DIR is set and
+	file is ignored if $GIT_COMMON_DIR is set and
 	"$GIT_COMMON_DIR/shallow" will be used instead.
 
 commondir::
@@ -242,7 +242,7 @@ commondir::
 
 modules::
 	Contains the git-repositories of the submodules. This
-	directory is ignored $GIT_COMMON_DIR is set and
+	directory is ignored if $GIT_COMMON_DIR is set and
 	"$GIT_COMMON_DIR/modules" will be used instead.
 
 repos::
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 24b7f36..9dc80f1 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -599,9 +599,10 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 			if (opts->new_branch_log && !log_all_ref_updates) {
 				int temp;
 				struct strbuf log_file = STRBUF_INIT;
-				char *ref_name = mkpath("refs/heads/%s", opts->new_orphan_branch);
 				int ret;
+				const char *ref_name;
 
+				ref_name = mkpath("refs/heads/%s", opts->new_orphan_branch);
 				temp = log_all_ref_updates;
 				log_all_ref_updates = 1;
 				ret = log_ref_setup(ref_name, &log_file);
@@ -843,8 +844,8 @@ static void remove_junk(void)
 	if (junk_work_tree) {
 		strbuf_addstr(&sb, junk_work_tree);
 		remove_dir_recursively(&sb, 0);
-		strbuf_reset(&sb);
 	}
+	strbuf_release(&sb);
 }
 
 static void remove_junk_on_signal(int signo)
@@ -854,17 +855,6 @@ static void remove_junk_on_signal(int signo)
 	raise(signo);
 }
 
-static dev_t get_device_or_die(const char *path)
-{
-	struct stat buf;
-	if (stat(path, &buf))
-		die_errno("failed to stat '%s'", path);
-	/* Ah Windows! Make different drives different "partitions" */
-	if (is_windows())
-		buf.st_dev = toupper(real_path(path)[0]);
-	return buf.st_dev;
-}
-
 static int prepare_linked_checkout(const struct checkout_opts *opts,
 				   struct branch_info *new)
 {
@@ -873,7 +863,7 @@ static int prepare_linked_checkout(const struct checkout_opts *opts,
 	const char *path = opts->new_worktree, *name;
 	struct stat st;
 	struct child_process cp;
-	int counter = 0, len, keep_locked = 0, ret;
+	int counter = 0, len, ret;
 
 	if (!new->commit)
 		die(_("no branch specified"));
@@ -909,6 +899,10 @@ static int prepare_linked_checkout(const struct checkout_opts *opts,
 	junk_git_dir = sb_repo.buf;
 	is_junk = 1;
 
+	/*
+	 * lock the incomplete repo so prunt won't delete it, unlock
+	 * after the preparation is over.
+	 */
 	strbuf_addf(&sb, "%s/locked", sb_repo.buf);
 	write_file(sb.buf, 1, "initializing\n");
 
@@ -936,18 +930,6 @@ static int prepare_linked_checkout(const struct checkout_opts *opts,
 	strbuf_addf(&sb, "%s/commondir", sb_repo.buf);
 	write_file(sb.buf, 1, "../..\n");
 
-	if (get_device_or_die(path) != get_device_or_die(get_git_dir())) {
-		strbuf_reset(&sb);
-		strbuf_addf(&sb, "%s/locked", sb_repo.buf);
-		write_file(sb.buf, 1, "located on a different file system\n");
-		keep_locked = 1;
-	} else {
-		strbuf_reset(&sb);
-		strbuf_addf(&sb, "%s/link", sb_repo.buf);
-		if (link(sb_git.buf, sb.buf))
-			; /* ignore silently, without a clear reason */
-	}
-
 	if (!opts->quiet)
 		fprintf_ln(stderr, _("Enter %s (identifier %s)"), path, name);
 
@@ -960,11 +942,9 @@ static int prepare_linked_checkout(const struct checkout_opts *opts,
 	ret = run_command(&cp);
 	if (!ret)
 		is_junk = 0;
-	if (!keep_locked) {
-		strbuf_reset(&sb);
-		strbuf_addf(&sb, "%s/locked", sb_repo.buf);
-		unlink_or_warn(sb.buf);
-	}
+	strbuf_reset(&sb);
+	strbuf_addf(&sb, "%s/locked", sb_repo.buf);
+	unlink_or_warn(sb.buf);
 	strbuf_release(&sb);
 	strbuf_release(&sb_repo);
 	strbuf_release(&sb_git);
diff --git a/builtin/clone.c b/builtin/clone.c
index 43e772c..9339371 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -289,16 +289,17 @@ static void copy_alternates(struct strbuf *src, struct strbuf *dst,
 	struct strbuf line = STRBUF_INIT;
 
 	while (strbuf_getline(&line, in, '\n') != EOF) {
-		char *abs_path, abs_buf[PATH_MAX];
+		char *abs_path;
 		if (!line.len || line.buf[0] == '#')
 			continue;
 		if (is_absolute_path(line.buf)) {
 			add_to_alternates_file(line.buf);
 			continue;
 		}
-		abs_path = mkpath("%s/objects/%s", src_repo, line.buf);
-		normalize_path_copy(abs_buf, abs_path);
-		add_to_alternates_file(abs_buf);
+		abs_path = mkpathdup("%s/objects/%s", src_repo, line.buf);
+		normalize_path_copy(abs_path, abs_path);
+		add_to_alternates_file(abs_path);
+		free(abs_path);
 	}
 	strbuf_release(&line);
 	fclose(in);
diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index 725cd5f..d3a1620 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -78,39 +78,6 @@ static void count_objects(DIR *d, char *path, int len, int verbose,
 	}
 }
 
-static void report_linked_checkout_garbage(void)
-{
-	/*
-	 * must be more or less in sync with * path.c:update_common_dir().
-	 *
-	 * "logs" is let slip because logs/HEAD is in $GIT_DIR but the
-	 * remaining in $GIT_COMMON_DIR. Probably not worth traversing
-	 * the entire "logs" directory for that.
-	 *
-	 * The same "gc.pid" for because it's a temporary file.
-	 */
-	const char *list[] = {
-		"branches", "hooks", "info", "lost-found", "modules",
-		"objects", "refs", "remotes", "rr-cache", "svn",
-		"config", "packed-refs", "shallow", NULL
-	};
-	struct strbuf sb = STRBUF_INIT;
-	const char **p;
-	int len;
-
-	if (!file_exists(git_path("commondir")))
-		return;
-	strbuf_addf(&sb, "%s/", get_git_dir());
-	len = sb.len;
-	for (p = list; *p; p++) {
-		strbuf_setlen(&sb, len);
-		strbuf_addstr(&sb, *p);
-		if (file_exists(sb.buf))
-			report_garbage("unused in linked checkout", sb.buf);
-	}
-	strbuf_release(&sb);
-}
-
 static char const * const count_objects_usage[] = {
 	N_("git count-objects [-v] [-H | --human-readable]"),
 	NULL
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 025bc3e..04b51ca 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -544,7 +544,8 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 	struct strbuf note = STRBUF_INIT;
 	const char *what, *kind;
 	struct ref *rm;
-	char *url, *filename = dry_run ? "/dev/null" : git_path("FETCH_HEAD");
+	char *url;
+	const char *filename = dry_run ? "/dev/null" : git_path("FETCH_HEAD");
 	int want_status;
 
 	fp = fopen(filename, "a");
@@ -778,7 +779,7 @@ static void check_not_current_branch(struct ref *ref_map)
 
 static int truncate_fetch_head(void)
 {
-	char *filename = git_path("FETCH_HEAD");
+	const char *filename = git_path("FETCH_HEAD");
 	FILE *fp = fopen(filename, "w");
 
 	if (!fp)
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 1affdd5..643c980 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -225,12 +225,12 @@ static void check_unreachable_object(struct object *obj)
 			printf("dangling %s %s\n", typename(obj->type),
 			       sha1_to_hex(obj->sha1));
 		if (write_lost_and_found) {
-			char *filename = git_path("lost-found/%s/%s",
+			const char *filename = git_path("lost-found/%s/%s",
 				obj->type == OBJ_COMMIT ? "commit" : "other",
 				sha1_to_hex(obj->sha1));
 			FILE *f;
 
-			if (safe_create_leading_directories(filename)) {
+			if (safe_create_leading_directories_const(filename)) {
 				error("Could not create lost-found");
 				return;
 			}
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 85bba35..4d27acb 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -599,7 +599,7 @@ static void run_update_post_hook(struct command *commands)
 	int argc;
 	const char **argv;
 	struct child_process proc;
-	char *hook;
+	const char *hook;
 
 	hook = find_hook("post-update");
 	for (argc = 0, cmd = commands; cmd; cmd = cmd->next) {
diff --git a/builtin/remote.c b/builtin/remote.c
index b3ab4cf..ca3cb3b 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -582,7 +582,7 @@ static int migrate_file(struct remote *remote)
 {
 	struct strbuf buf = STRBUF_INIT;
 	int i;
-	char *path = NULL;
+	const char *path = NULL;
 
 	strbuf_addf(&buf, "remote.%s.url", remote->name);
 	for (i = 0; i < remote->url_nr; i++)
diff --git a/builtin/repack.c b/builtin/repack.c
index bb2314c..4d35349 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -257,7 +257,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	failed = 0;
 	for_each_string_list_item(item, &names) {
 		for (ext = 0; ext < 2; ext++) {
-			char *fname, *fname_old;
+			const char *fname_old;
+			char *fname;
 			fname = mkpathdup("%s/pack-%s%s", packdir,
 						item->string, exts[ext]);
 			if (!file_exists(fname)) {
@@ -285,7 +286,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	if (failed) {
 		struct string_list rollback_failure = STRING_LIST_INIT_DUP;
 		for_each_string_list_item(item, &rollback) {
-			char *fname, *fname_old;
+			const char *fname_old;
+			char *fname;
 			fname = mkpathdup("%s/%s", packdir, item->string);
 			fname_old = mkpath("%s/old-%s", packdir, item->string);
 			if (rename(fname_old, fname))
@@ -334,7 +336,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	/* Remove the "old-" files */
 	for_each_string_list_item(item, &names) {
 		for (ext = 0; ext < 2; ext++) {
-			char *fname;
+			const char *fname;
 			fname = mkpath("%s/old-%s%s",
 					packdir,
 					item->string,
diff --git a/cache.h b/cache.h
index 99b86d9..a0ff430 100644
--- a/cache.h
+++ b/cache.h
@@ -658,10 +658,11 @@ extern char *mkpathdup(const char *fmt, ...)
 	__attribute__((format (printf, 1, 2)));
 
 /* Return a statically allocated filename matching the sha1 signature */
-extern char *mkpath(const char *fmt, ...) __attribute__((format (printf, 1, 2)));
-extern char *git_path(const char *fmt, ...) __attribute__((format (printf, 1, 2)));
-extern char *git_path_submodule(const char *path, const char *fmt, ...)
+extern const char *mkpath(const char *fmt, ...) __attribute__((format (printf, 1, 2)));
+extern const char *git_path(const char *fmt, ...) __attribute__((format (printf, 1, 2)));
+extern const char *git_path_submodule(const char *path, const char *fmt, ...)
 	__attribute__((format (printf, 2, 3)));
+extern void report_linked_checkout_garbage(void);
 
 extern char *sha1_file_name(const unsigned char *sha1);
 extern char *sha1_pack_name(const unsigned char *sha1);
diff --git a/compat/mingw.h b/compat/mingw.h
index 18323c1..e033e72 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -328,7 +328,6 @@ int winansi_fprintf(FILE *stream, const char *format, ...) __attribute__((format
  * git specific compatibility
  */
 
-#define is_windows() 1
 #define has_dos_drive_prefix(path) (isalpha(*(path)) && (path)[1] == ':')
 #define is_dir_sep(c) ((c) == '/' || (c) == '\\')
 static inline char *mingw_find_last_dir_sep(const char *path)
diff --git a/fast-import.c b/fast-import.c
index 08a1e78..28e7a63 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -403,7 +403,7 @@ static void dump_marks_helper(FILE *, uintmax_t, struct mark_set *);
 
 static void write_crash_report(const char *err)
 {
-	char *loc = git_path("fast_import_crash_%"PRIuMAX, (uintmax_t) getpid());
+	const char *loc = git_path("fast_import_crash_%"PRIuMAX, (uintmax_t) getpid());
 	FILE *rpt = fopen(loc, "w");
 	struct branch *b;
 	unsigned long lu;
diff --git a/git-am.sh b/git-am.sh
index dfa0618..10babd2 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -803,7 +803,7 @@ To restore the original branch and stop patching run \"\$cmdline --abort\"."
 		continue
 	fi
 
-	hook="`git rev-parse --git-path hooks/applypatch-msg`"
+	hook="$(git rev-parse --git-path hooks/applypatch-msg)"
 	if test -x "$hook"
 	then
 		"$hook" "$dotest/final-commit" || stop_here $this
@@ -880,7 +880,7 @@ did you forget to use 'git add'?"
 		stop_here_user_resolve $this
 	fi
 
-	hook="`git rev-parse --git-path hooks/pre-applypatch`"
+	hook="$(git rev-parse --git-path hooks/pre-applypatch)"
 	if test -x "$hook"
 	then
 		"$hook" || stop_here $this
@@ -909,7 +909,7 @@ did you forget to use 'git add'?"
 		echo "$(cat "$dotest/original-commit") $commit" >> "$dotest/rewritten"
 	fi
 
-	hook="`git rev-parse --git-path hooks/post-applypatch`"
+	hook="$(git rev-parse --git-path hooks/post-applypatch)"
 	test -x "$hook" && "$hook"
 
 	go_next
@@ -917,7 +917,7 @@ done
 
 if test -s "$dotest"/rewritten; then
     git notes copy --for-rewrite=rebase < "$dotest"/rewritten
-    hook="`git rev-parse --git-path hooks/post-rewrite`"
+    hook="$(git rev-parse --git-path hooks/post-rewrite)"
     if test -x "$hook"; then
 	"$hook" rebase < "$dotest"/rewritten
     fi
diff --git a/git-compat-util.h b/git-compat-util.h
index 41f1b74..cbd86c3 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -266,10 +266,6 @@ extern char *gitbasename(char *);
 #define STRIP_EXTENSION ""
 #endif
 
-#ifndef is_windows
-#define is_windows() 0
-#endif
-
 #ifndef has_dos_drive_prefix
 #define has_dos_drive_prefix(path) 0
 #endif
diff --git a/git-pull.sh b/git-pull.sh
index c9dc9ba..2a90262 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -218,7 +218,7 @@ test true = "$rebase" && {
 	if ! git rev-parse -q --verify HEAD >/dev/null
 	then
 		# On an unborn branch
-		if test -f "`git rev-parse --git-path index`"
+		if test -f "$(git rev-parse --git-path index)"
 		then
 			die "$(gettext "updating an unborn branch with changes added to the index")"
 		fi
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index d741b04..dd84f9d 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -632,7 +632,7 @@ do_next () {
 		git notes copy --for-rewrite=rebase < "$rewritten_list" ||
 		true # we don't care if this copying failed
 	} &&
-	hook="`git rev-parse --git-path hooks/post-rewrite`"
+	hook="$(git rev-parse --git-path hooks/post-rewrite)"
 	if test -x "$hook" && test -s "$rewritten_list"; then
 		"$hook" rebase < "$rewritten_list"
 		true # we don't care if this hook failed
diff --git a/git-rebase--merge.sh b/git-rebase--merge.sh
index 68f5d09..93d7bcf 100644
--- a/git-rebase--merge.sh
+++ b/git-rebase--merge.sh
@@ -93,7 +93,7 @@ finish_rb_merge () {
 	if test -s "$state_dir"/rewritten
 	then
 		git notes copy --for-rewrite=rebase <"$state_dir"/rewritten
-		hook="`git rev-parse --git-path hooks/post-rewrite`"
+		hook="$(git rev-parse --git-path hooks/post-rewrite)"
 		test -x "$hook" && "$hook" rebase <"$state_dir"/rewritten
 	fi
 	say All done.
diff --git a/git-rebase.sh b/git-rebase.sh
index 1cf8dba..b90a6d9 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -195,9 +195,9 @@ run_specific_rebase () {
 
 run_pre_rebase_hook () {
 	if test -z "$ok_to_skip_pre_rebase" &&
-	   test -x "`git rev-parse --git-path hooks/pre-rebase`"
+	   test -x "$(git rev-parse --git-path hooks/pre-rebase)"
 	then
-		"`git rev-parse --git-path hooks/pre-rebase`" ${1+"$@"} ||
+		"$(git rev-parse --git-path hooks/pre-rebase)" ${1+"$@"} ||
 		die "$(gettext "The pre-rebase hook refused to rebase.")"
 	fi
 }
diff --git a/git-stash.sh b/git-stash.sh
index 12d9b37..8093326 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -20,7 +20,7 @@ require_work_tree
 cd_to_toplevel
 
 TMP="$GIT_DIR/.git-stash.$$"
-TMPindex=${GIT_INDEX_FILE-"`git rev-parse --git-path index`"}.stash.$$
+TMPindex=${GIT_INDEX_FILE-"$(git rev-parse --git-path index)"}.stash.$$
 trap 'rm -f "$TMP-"* "$TMPindex"' 0
 
 ref_stash=refs/stash
@@ -183,7 +183,7 @@ store_stash () {
 	fi
 
 	# Make sure the reflog for stash is kept.
-	: >>"`git rev-parse --git-path logs/$ref_stash`"
+	: >>"$(git rev-parse --git-path logs/$ref_stash)"
 	git update-ref -m "$stash_msg" $ref_stash $w_commit
 	ret=$?
 	test $ret != 0 && test -z $quiet &&
@@ -258,7 +258,7 @@ save_stash () {
 		say "$(gettext "No local changes to save")"
 		exit 0
 	fi
-	test -f "`git rev-parse --git-path logs/$ref_stash`" ||
+	test -f "$(git rev-parse --git-path logs/$ref_stash)" ||
 		clear_stash || die "$(gettext "Cannot initialize stash")"
 
 	create_stash "$stash_msg" $untracked
diff --git a/notes-merge.c b/notes-merge.c
index 94a1a8a..d59bcc2 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -280,7 +280,7 @@ static void check_notes_merge_worktree(struct notes_merge_options *o)
 				    "(%s exists).", git_path("NOTES_MERGE_*"));
 		}
 
-		if (safe_create_leading_directories(git_path(
+		if (safe_create_leading_directories_const(git_path(
 				NOTES_MERGE_WORKTREE "/.test")))
 			die_errno("unable to create directory %s",
 				  git_path(NOTES_MERGE_WORKTREE));
@@ -295,8 +295,8 @@ static void write_buf_to_worktree(const unsigned char *obj,
 				  const char *buf, unsigned long size)
 {
 	int fd;
-	char *path = git_path(NOTES_MERGE_WORKTREE "/%s", sha1_to_hex(obj));
-	if (safe_create_leading_directories(path))
+	const char *path = git_path(NOTES_MERGE_WORKTREE "/%s", sha1_to_hex(obj));
+	if (safe_create_leading_directories_const(path))
 		die_errno("unable to create directory for '%s'", path);
 	if (file_exists(path))
 		die("found existing file at '%s'", path);
diff --git a/path.c b/path.c
index 2e6035d..5a7dc45 100644
--- a/path.c
+++ b/path.c
@@ -4,6 +4,7 @@
 #include "cache.h"
 #include "strbuf.h"
 #include "string-list.h"
+#include "dir.h"
 
 static int get_st_mode_bits(const char *path, int *mode)
 {
@@ -90,35 +91,60 @@ static void replace_dir(struct strbuf *buf, int len, const char *newdir)
 		buf->buf[newlen] = '/';
 }
 
+static const char *common_list[] = {
+	"/branches", "/hooks", "/info", "!/logs", "/lost-found", "/modules",
+	"/objects", "/refs", "/remotes", "/repos", "/rr-cache", "/svn",
+	"config", "!gc.pid", "packed-refs", "shallow",
+	NULL
+};
+
 static void update_common_dir(struct strbuf *buf, int git_dir_len)
 {
-	/*
-	 * Remember to report_linked_checkout_garbage()
-	 * builtin/count-objects.c
-	 */
-	const char *common_dir_list[] = {
-		"branches", "hooks", "info", "logs", "lost-found", "modules",
-		"objects", "refs", "remotes", "repos", "rr-cache", "svn",
-		NULL
-	};
-	const char *common_top_file_list[] = {
-		"config", "gc.pid", "packed-refs", "shallow", NULL
-	};
 	char *base = buf->buf + git_dir_len;
 	const char **p;
 
 	if (is_dir_file(base, "logs", "HEAD"))
 		return;	/* keep this in $GIT_DIR */
-	for (p = common_dir_list; *p; p++)
-		if (dir_prefix(base, *p)) {
+	for (p = common_list; *p; p++) {
+		const char *path = *p;
+		int is_dir = 0;
+		if (*path == '!')
+			path++;
+		if (*path == '/') {
+			path++;
+			is_dir = 1;
+		}
+		if (is_dir && dir_prefix(base, path)) {
 			replace_dir(buf, git_dir_len, get_git_common_dir());
 			return;
 		}
-	for (p = common_top_file_list; *p; p++)
-		if (!strcmp(base, *p)) {
+		if (!is_dir && !strcmp(base, path)) {
 			replace_dir(buf, git_dir_len, get_git_common_dir());
 			return;
 		}
+	}
+}
+
+void report_linked_checkout_garbage(void)
+{
+	struct strbuf sb = STRBUF_INIT;
+	const char **p;
+	int len;
+
+	if (!git_common_dir_env)
+		return;
+	strbuf_addf(&sb, "%s/", get_git_dir());
+	len = sb.len;
+	for (p = common_list; *p; p++) {
+		const char *path = *p;
+		if (*path == '!')
+			continue;
+		strbuf_setlen(&sb, len);
+		strbuf_addstr(&sb, path);
+		if (file_exists(sb.buf))
+			report_garbage("unused in linked checkout", sb.buf);
+	}
+	strbuf_release(&sb);
 }
 
 static void adjust_git_path(struct strbuf *buf, int git_dir_len)
@@ -138,9 +164,8 @@ static void adjust_git_path(struct strbuf *buf, int git_dir_len)
 
 static void do_git_path(struct strbuf *buf, const char *fmt, va_list args)
 {
-	const char *git_dir = get_git_dir();
 	int gitdir_len;
-	strbuf_addstr(buf, git_dir);
+	strbuf_addstr(buf, get_git_dir());
 	if (buf->len && !is_dir_sep(buf->buf[buf->len - 1]))
 		strbuf_addch(buf, '/');
 	gitdir_len = buf->len;
@@ -157,7 +182,7 @@ void strbuf_git_path(struct strbuf *sb, const char *fmt, ...)
 	va_end(args);
 }
 
-char *git_path(const char *fmt, ...)
+const char *git_path(const char *fmt, ...)
 {
 	struct strbuf *pathname = get_pathname();
 	va_list args;
@@ -188,7 +213,7 @@ char *mkpathdup(const char *fmt, ...)
 	return strbuf_detach(&sb, NULL);
 }
 
-char *mkpath(const char *fmt, ...)
+const char *mkpath(const char *fmt, ...)
 {
 	va_list args;
 	struct strbuf *pathname = get_pathname();
@@ -224,7 +249,7 @@ void home_config_paths(char **global, char **xdg, char *file)
 	free(to_free);
 }
 
-char *git_path_submodule(const char *path, const char *fmt, ...)
+const char *git_path_submodule(const char *path, const char *fmt, ...)
 {
 	struct strbuf *buf = get_pathname();
 	const char *git_dir;
diff --git a/refs.c b/refs.c
index 434bd5e..c5613b0 100644
--- a/refs.c
+++ b/refs.c
@@ -1232,7 +1232,7 @@ static int resolve_gitlink_ref_recursive(struct ref_cache *refs,
 {
 	int fd, len;
 	char buffer[128], *p;
-	char *path;
+	const char *path;
 
 	if (recursion > MAXDEPTH || strlen(refname) > MAXREFLEN)
 		return -1;
@@ -2044,7 +2044,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 					    const unsigned char *old_sha1,
 					    int flags, int *type_p)
 {
-	char *ref_file;
+	const char *ref_file;
 	const char *orig_refname = refname;
 	struct ref_lock *lock;
 	int last_errno = 0;
@@ -2107,7 +2107,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 		lock->force_write = 1;
 
  retry:
-	switch (safe_create_leading_directories(ref_file)) {
+	switch (safe_create_leading_directories_const(ref_file)) {
 	case SCLD_OK:
 		break; /* success */
 	case SCLD_VANISHED:
@@ -2545,7 +2545,7 @@ static int rename_tmp_log(const char *newrefname)
 	int attempts_remaining = 4;
 
  retry:
-	switch (safe_create_leading_directories(git_path("logs/%s", newrefname))) {
+	switch (safe_create_leading_directories_const(git_path("logs/%s", newrefname))) {
 	case SCLD_OK:
 		break; /* success */
 	case SCLD_VANISHED:
@@ -2729,43 +2729,41 @@ static int copy_msg(char *buf, const char *msg)
 	return cp - buf;
 }
 
-int log_ref_setup(const char *refname, struct strbuf *sb_logfile)
+int log_ref_setup(const char *refname, struct strbuf *logfile)
 {
 	int logfd, oflags = O_APPEND | O_WRONLY;
-	const char *logfile;
 
-	strbuf_git_path(sb_logfile, "logs/%s", refname);
-	logfile = sb_logfile->buf;
+	strbuf_git_path(logfile, "logs/%s", refname);
 	if (log_all_ref_updates &&
 	    (starts_with(refname, "refs/heads/") ||
 	     starts_with(refname, "refs/remotes/") ||
 	     starts_with(refname, "refs/notes/") ||
 	     !strcmp(refname, "HEAD"))) {
-		if (safe_create_leading_directories(sb_logfile->buf) < 0)
+		if (safe_create_leading_directories(logfile->buf) < 0)
 			return error("unable to create directory for %s",
-				     logfile);
+				     logfile->buf);
 		oflags |= O_CREAT;
 	}
 
-	logfd = open(logfile, oflags, 0666);
+	logfd = open(logfile->buf, oflags, 0666);
 	if (logfd < 0) {
 		if (!(oflags & O_CREAT) && errno == ENOENT)
 			return 0;
 
 		if ((oflags & O_CREAT) && errno == EISDIR) {
-			if (remove_empty_directories(logfile)) {
+			if (remove_empty_directories(logfile->buf)) {
 				return error("There are still logs under '%s'",
-					     logfile);
+					     logfile->buf);
 			}
-			logfd = open(logfile, oflags, 0666);
+			logfd = open(logfile->buf, oflags, 0666);
 		}
 
 		if (logfd < 0)
 			return error("Unable to append to %s: %s",
-				     logfile, strerror(errno));
+				     logfile->buf, strerror(errno));
 	}
 
-	adjust_shared_perm(logfile);
+	adjust_shared_perm(logfile->buf);
 	close(logfd);
 	return 0;
 }
diff --git a/run-command.c b/run-command.c
index 3914d9c..a94a612 100644
--- a/run-command.c
+++ b/run-command.c
@@ -751,9 +751,9 @@ int finish_async(struct async *async)
 #endif
 }
 
-char *find_hook(const char *name)
+const char *find_hook(const char *name)
 {
-	char *path = git_path("hooks/%s", name);
+	const char *path = git_path("hooks/%s", name);
 	if (access(path, X_OK) < 0)
 		path = NULL;
 
diff --git a/run-command.h b/run-command.h
index 6b985af..da01954 100644
--- a/run-command.h
+++ b/run-command.h
@@ -45,7 +45,7 @@ int start_command(struct child_process *);
 int finish_command(struct child_process *);
 int run_command(struct child_process *);
 
-extern char *find_hook(const char *name);
+extern const char *find_hook(const char *name);
 LAST_ARG_MUST_BE_NULL
 extern int run_hook(const char *index_file, const char *name, ...);
 
diff --git a/sha1_file.c b/sha1_file.c
index 6e8c05d..8af0e18 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -402,7 +402,7 @@ void add_to_alternates_file(const char *reference)
 {
 	struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
 	int fd = hold_lock_file_for_append(lock, git_path("objects/info/alternates"), LOCK_DIE_ON_ERROR);
-	char *alt = mkpath("%s\n", reference);
+	const char *alt = mkpath("%s\n", reference);
 	write_or_die(fd, alt, strlen(alt));
 	if (commit_lock_file(lock))
 		die("could not close alternates file");
diff --git a/templates/hooks--applypatch-msg.sample b/templates/hooks--applypatch-msg.sample
index 28b843b..a5d7b84 100755
--- a/templates/hooks--applypatch-msg.sample
+++ b/templates/hooks--applypatch-msg.sample
@@ -10,6 +10,6 @@
 # To enable this hook, rename this file to "applypatch-msg".
 
 . git-sh-setup
-commitmsg="`git rev-parse --git-path hooks/commit-msg`"
+commitmsg="$(git rev-parse --git-path hooks/commit-msg)"
 test -x "$commitmsg" && exec "$commitmsg" ${1+"$@"}
 :
diff --git a/templates/hooks--pre-applypatch.sample b/templates/hooks--pre-applypatch.sample
index 51aa244..4142082 100755
--- a/templates/hooks--pre-applypatch.sample
+++ b/templates/hooks--pre-applypatch.sample
@@ -9,6 +9,6 @@
 # To enable this hook, rename this file to "pre-applypatch".
 
 . git-sh-setup
-precommit="`git rev-parse --git-path hooks/pre-commit`"
+precommit="$(git rev-parse --git-path hooks/pre-commit)"
 test -x "$precommit" && exec "$precommit" ${1+"$@"}
 :
diff --git a/wrapper.c b/wrapper.c
index 5ced50d..5ad628c 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -459,8 +459,8 @@ struct passwd *xgetpwuid_self(void)
 int write_file(const char *path, int fatal, const char *fmt, ...)
 {
 	struct strbuf sb = STRBUF_INIT;
-	int fd = open(path, O_RDWR | O_CREAT | O_TRUNC, 0666);
 	va_list params;
+	int fd = open(path, O_RDWR | O_CREAT | O_TRUNC, 0666);
 	if (fd < 0) {
 		if (fatal)
 			die_errno(_("could not open %s for writing"), path);
@@ -472,8 +472,8 @@ int write_file(const char *path, int fatal, const char *fmt, ...)
 	if (write_in_full(fd, sb.buf, sb.len) != sb.len) {
 		int err = errno;
 		close(fd);
-		errno = err;
 		strbuf_release(&sb);
+		errno = err;
 		if (fatal)
 			die_errno(_("could not write to %s"), path);
 		return -1;
-- 8< --
-- 
1.9.0.40.gaa8c3ea

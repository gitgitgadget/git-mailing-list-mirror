From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [RFC PATCHv3] repack: rewrite the shell script in C.
Date: Sun, 18 Aug 2013 16:36:27 +0200
Message-ID: <1376836587-25248-1-git-send-email-stefanbeller@googlemail.com>
References: <5210DB77.3090004@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org, l.s.r@web.de, mfick@codeaurora.org,
	apelisse@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	pclouds@gmail.com, iveqy@iveqy.com, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Aug 18 16:36:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VB45p-0001LP-PO
	for gcvg-git-2@plane.gmane.org; Sun, 18 Aug 2013 16:36:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755482Ab3HROga (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Aug 2013 10:36:30 -0400
Received: from mail-ea0-f180.google.com ([209.85.215.180]:47688 "EHLO
	mail-ea0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755228Ab3HROg2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Aug 2013 10:36:28 -0400
Received: by mail-ea0-f180.google.com with SMTP id h10so1848106eaj.11
        for <git@vger.kernel.org>; Sun, 18 Aug 2013 07:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=L76gyZS2zZEHwNWeMtOR7wdR0Y5I4fuqU/6qRFqY43Y=;
        b=oVkSjobyW1R8r/sakwjIhjsQcLkYVrTxgZhMLrz73UthD3KFHsfh7xhijPUkMpymIx
         MhRIGxLCUb4NM4jCzZ9HfDI1wcRtT3I4kJH1VXF6F+5OG1WFZcdyUTN5WukqpPCnnLBd
         bfYA6gTvaZ/FHHGCI+5bNKhaigMsLH8OCa3pPtPHsbwQV4RH/Du98k77MNfKVe+bGtIj
         CJ4oFBUahNHRkrqKgWpZ1CC5PNugGc+XAy9J7fyW5mDGZ8waw0jf/aQYXUNcWLqCbXeK
         anvUrTBnzQgjkU5Y9ibs/Y+tmagaGEbsg1VxAQJn8yHhpvWTsjFjidSxUhJ0GCOXdoOp
         MF1w==
X-Received: by 10.14.88.65 with SMTP id z41mr14653895eee.38.1376836587369;
        Sun, 18 Aug 2013 07:36:27 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id r48sm10650942eev.14.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 18 Aug 2013 07:36:26 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc3.2.g2c2b664
In-Reply-To: <5210DB77.3090004@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232478>

This is the beginning of the rewrite of the repacking.

 * replace all plain string handling functions
   by git helper functions, most often mkpathdup
 * use argv-array structs to pass arguments to
   other git invocations.

Only test t7701 (2nd) fails now  with this patch.

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
---
 Makefile                                        |   2 +-
 builtin.h                                       |   1 +
 builtin/repack.c                                | 385 ++++++++++++++++++++++++
 git-repack.sh => contrib/examples/git-repack.sh |   0
 git.c                                           |   1 +
 5 files changed, 388 insertions(+), 1 deletion(-)
 create mode 100644 builtin/repack.c
 rename git-repack.sh => contrib/examples/git-repack.sh (100%)

diff --git a/Makefile b/Makefile
index ef442eb..4ec5bbe 100644
--- a/Makefile
+++ b/Makefile
@@ -464,7 +464,6 @@ SCRIPT_SH += git-pull.sh
 SCRIPT_SH += git-quiltimport.sh
 SCRIPT_SH += git-rebase.sh
 SCRIPT_SH += git-remote-testgit.sh
-SCRIPT_SH += git-repack.sh
 SCRIPT_SH += git-request-pull.sh
 SCRIPT_SH += git-stash.sh
 SCRIPT_SH += git-submodule.sh
@@ -972,6 +971,7 @@ BUILTIN_OBJS += builtin/reflog.o
 BUILTIN_OBJS += builtin/remote.o
 BUILTIN_OBJS += builtin/remote-ext.o
 BUILTIN_OBJS += builtin/remote-fd.o
+BUILTIN_OBJS += builtin/repack.o
 BUILTIN_OBJS += builtin/replace.o
 BUILTIN_OBJS += builtin/rerere.o
 BUILTIN_OBJS += builtin/reset.o
diff --git a/builtin.h b/builtin.h
index 8afa2de..b56cf07 100644
--- a/builtin.h
+++ b/builtin.h
@@ -102,6 +102,7 @@ extern int cmd_reflog(int argc, const char **argv, const char *prefix);
 extern int cmd_remote(int argc, const char **argv, const char *prefix);
 extern int cmd_remote_ext(int argc, const char **argv, const char *prefix);
 extern int cmd_remote_fd(int argc, const char **argv, const char *prefix);
+extern int cmd_repack(int argc, const char **argv, const char *prefix);
 extern int cmd_repo_config(int argc, const char **argv, const char *prefix);
 extern int cmd_rerere(int argc, const char **argv, const char *prefix);
 extern int cmd_reset(int argc, const char **argv, const char *prefix);
diff --git a/builtin/repack.c b/builtin/repack.c
new file mode 100644
index 0000000..190eb5f
--- /dev/null
+++ b/builtin/repack.c
@@ -0,0 +1,385 @@
+/*
+ * The shell version was written by Linus Torvalds (2005) and many others.
+ * This is a translation into C by Stefan Beller (2013)
+ */
+
+#include "builtin.h"
+#include "cache.h"
+#include "dir.h"
+#include "parse-options.h"
+#include "run-command.h"
+#include "sigchain.h"
+#include "strbuf.h"
+#include "string-list.h"
+
+#include "argv-array.h"
+
+static const char *const git_repack_usage[] = {
+	N_("git repack [options]"),
+	NULL
+};
+
+/* enabled by default since 22c79eab (2008-06-25) */
+static int delta_base_offset = 1;
+
+static int repack_config(const char *var, const char *value, void *cb)
+{
+	if (!strcmp(var, "repack.usedeltabaseoffset")) {
+		delta_base_offset = git_config_bool(var, value);
+		return 0;
+	}
+	return git_default_config(var, value, cb);
+}
+
+static void remove_temporary_files() {
+	DIR *dir;
+	struct dirent *e;
+	char *prefix, *path;
+
+	prefix = mkpathdup(".tmp-%d-pack", getpid());
+	path = mkpathdup("%s/pack", get_object_directory());
+
+	dir = opendir(path);
+	while ((e = readdir(dir)) != NULL) {
+		if (!prefixcmp(e->d_name, prefix)) {
+			struct strbuf fname = STRBUF_INIT;
+			strbuf_addf(&fname, "%s/%s", path, e->d_name);
+			unlink(strbuf_detach(&fname, NULL));
+		}
+	}
+	free(prefix);
+	free(path);
+	closedir(dir);
+}
+
+static void remove_pack_on_signal(int signo)
+{
+	remove_temporary_files();
+	sigchain_pop(signo);
+	raise(signo);
+}
+
+void get_pack_sha1_list(char *packdir, struct string_list *sha1_list)
+{
+	DIR *dir;
+	struct dirent *e;
+	char *path, *suffix;
+
+	path = mkpathdup("%s/pack", get_object_directory());
+	suffix = ".pack";
+
+	dir = opendir(path);
+	while ((e = readdir(dir)) != NULL) {
+		if (!suffixcmp(e->d_name, suffix)) {
+			char *buf, *sha1;
+			buf = xmemdupz(e->d_name, strlen(e->d_name));
+			buf[strlen(e->d_name) - strlen(suffix)] = '\0';
+			if (strlen(e->d_name) - strlen(suffix) > 40) {
+				sha1 = &buf[strlen(e->d_name) - strlen(suffix) - 40];
+				string_list_append_nodup(sha1_list, sha1);
+			} else {
+				/*TODO: what should happen to pack files having no 40 char sha1 specifier?*/
+			}
+		}
+	}
+	free(path);
+	closedir(dir);
+}
+
+/*
+ * remove_pack will remove any files following the pattern *${SHA1}.{EXT}
+ * where EXT is one of {pack, idx, keep}. The SHA1 consists of 40 chars and
+ * is specified by the sha1 parameter.
+ * path is specifying the directory in which all found files will be deleted.
+ */
+void remove_pack(char *path, char* sha1)
+{
+	DIR *dir;
+	struct dirent *e;
+
+	dir = opendir(path);
+	while ((e = readdir(dir)) != NULL) {
+		char *sha_begin, *sha_end;
+		sha_end = e->d_name + strlen(e->d_name);
+		while (sha_end > e->d_name && *sha_end != '.')
+			sha_end--;
+
+		/* do not touch files not ending in .pack, .idx or .keep */
+		if (strcmp(sha_end, ".pack") &&
+			strcmp(sha_end, ".idx") &&
+			strcmp(sha_end, ".keep"))
+			continue;
+
+		sha_begin = sha_end - 40;
+
+		if (sha_begin >= e->d_name && !strncmp(sha_begin, sha1, 40)) {
+			char *fname;
+			fname = mkpathdup("%s/%s", path, e->d_name);
+			unlink(fname);
+			free(fname);
+		}
+	}
+	closedir(dir);
+}
+
+int cmd_repack(int argc, const char **argv, const char *prefix) {
+
+	int pack_everything = 0;
+	int pack_everything_but_loose = 0;
+	int delete_redundant = 0;
+	char *unpack_unreachable = NULL;
+	int window = 0, window_memory = 0;
+	int depth = 0;
+	int max_pack_size = 0;
+	int no_reuse_delta = 0, no_reuse_object = 0;
+	int no_update_server_info = 0;
+	int quiet = 0;
+	int local = 0;
+	char *packdir, *packtmp;
+	struct child_process cmd;
+	struct string_list_item *item;
+	struct string_list existing_packs = STRING_LIST_INIT_DUP;
+	struct stat statbuffer;
+
+	struct option builtin_repack_options[] = {
+		OPT_BOOL('a', "all", &pack_everything,
+				N_("pack everything in a single pack")),
+		OPT_BOOL('A', "all-but-loose", &pack_everything_but_loose,
+				N_("same as -a, and turn unreachable objects loose")),
+		OPT_BOOL('d', "delete-redundant", &delete_redundant,
+				N_("remove redundant packs, and run git-prune-packed")),
+		OPT_BOOL('f', "no-reuse-delta", &no_reuse_delta,
+				N_("pass --no-reuse-delta to git-pack-objects")),
+		OPT_BOOL('F', "no-reuse-object", &no_reuse_object,
+				N_("pass --no-reuse-object to git-pack-objects")),
+		OPT_BOOL('n', NULL, &no_update_server_info,
+				N_("do not run git-update-server-info")),
+		OPT__QUIET(&quiet, N_("be quiet")),
+		OPT_BOOL('l', "local", &local,
+				N_("pass --local to git-pack-objects")),
+		OPT_STRING(0, "unpack-unreachable", &unpack_unreachable, N_("approxidate"),
+				N_("with -A, do not loosen objects older than this Packing constraints")),
+		OPT_INTEGER(0, "window", &window,
+				N_("size of the window used for delta compression")),
+		OPT_INTEGER(0, "window-memory", &window_memory,
+				N_("same as the above, but limit memory size instead of entries count")),
+		OPT_INTEGER(0, "depth", &depth,
+				N_("limits the maximum delta depth")),
+		OPT_INTEGER(0, "max-pack-size", &max_pack_size,
+				N_("maximum size of each packfile")),
+		OPT_END()
+	};
+
+	git_config(repack_config, NULL);
+
+	argc = parse_options(argc, argv, prefix, builtin_repack_options,
+				git_repack_usage, 0);
+
+	sigchain_push_common(remove_pack_on_signal);
+
+	packdir = mkpathdup("%s/pack", get_object_directory());
+	packtmp = mkpathdup("%s/.tmp-%d-pack", packdir, getpid());
+
+	remove_temporary_files();
+
+	struct argv_array cmd_args = ARGV_ARRAY_INIT;
+	argv_array_push(&cmd_args, "pack-objects");
+	argv_array_push(&cmd_args, "--keep-true-parents");
+	argv_array_push(&cmd_args, "--honor-pack-keep");
+	argv_array_push(&cmd_args, "--non-empty");
+	argv_array_push(&cmd_args, "--all");
+	argv_array_push(&cmd_args, "--reflog");
+
+	if (window)
+		argv_array_pushf(&cmd_args, "--window=%u", window);
+
+	if (window_memory)
+		argv_array_pushf(&cmd_args, "--window-memory=%u", window_memory);
+
+	if (depth)
+		argv_array_pushf(&cmd_args, "--depth=%u", depth);
+
+	if (max_pack_size)
+		argv_array_pushf(&cmd_args, "--max_pack_size=%u", max_pack_size);
+
+	if (pack_everything + pack_everything_but_loose == 0) {
+		argv_array_push(&cmd_args, "--unpacked");
+		argv_array_push(&cmd_args, "--incremental");
+	} else {
+		if (pack_everything_but_loose)
+			argv_array_push(&cmd_args, "--unpack-unreachable");
+
+		struct string_list sha1_list = STRING_LIST_INIT_DUP;
+		get_pack_sha1_list(packdir, &sha1_list);
+		for_each_string_list_item(item, &sha1_list) {
+			char *fname;
+			fname = mkpathdup("%s/%s.keep", packdir, item->string);
+			if (stat(fname, &statbuffer) && S_ISREG(statbuffer.st_mode)) {
+				/* when the keep file is there, we're ignoring that pack */
+			} else {
+				string_list_append(&existing_packs, item->string);
+			}
+			free(fname);
+		}
+
+		if (existing_packs.nr && unpack_unreachable && delete_redundant) {
+			argv_array_pushf(&cmd_args, "--unpack-unreachable=%s", unpack_unreachable);
+		}
+	}
+
+	if (local)
+		argv_array_push(&cmd_args,  "--local");
+
+	if (delta_base_offset)
+		argv_array_push(&cmd_args,  "--delta-base-offset");
+
+	argv_array_push(&cmd_args, packtmp);
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.argv = argv_array_detach(&cmd_args, NULL);
+	cmd.git_cmd = 1;
+	cmd.out = -1;
+	cmd.no_stdin = 1;
+
+	if (run_command(&cmd))
+		return 1;
+
+	struct string_list names = STRING_LIST_INIT_DUP;
+	struct string_list rollback = STRING_LIST_INIT_DUP;
+
+	char line[1024];
+	int counter = 0;
+	FILE *out = xfdopen(cmd.out, "r");
+	while (fgets(line, sizeof(line), out)) {
+		/* a line consists of 40 hex chars + '\n' */
+		assert(strlen(line) == 41);
+		line[40] = '\0';
+		string_list_append(&names, line);
+		counter++;
+	}
+	if (!counter)
+		printf("Nothing new to pack.\n");
+	fclose(out);
+
+	char *exts[2] = {".idx", ".pack"};
+	int failed = 0;
+	for_each_string_list_item(item, &names) {
+		int ext;
+		for (ext = 0; ext < 1; ext++) {
+			char *fname, *fname_old;
+			fname = mkpathdup("%s/%s%s", packdir, item->string, exts[ext]);
+			if (!file_exists(fname)) {
+				free(fname);
+				continue;
+			}
+
+			fname_old = mkpathdup("%s/old-%s%s", packdir, item->string, exts[ext]);
+			if (file_exists(fname_old))
+				unlink(fname_old);
+
+			if (rename(fname, fname_old)) {
+				failed = 1;
+				break;
+			}
+			string_list_append_nodup(&rollback, fname);
+		}
+		if (failed)
+			/* set to last element to break for_each loop */
+			item = names.items + names.nr;
+	}
+	if (failed) {
+		struct string_list rollback_failure;
+		for_each_string_list_item(item, &rollback) {
+			char *fname, *fname_old;
+			fname = mkpathdup("%s/%s", packdir, item->string);
+			fname_old = mkpathdup("%s/old-%s", packdir, item->string);
+			if (rename(fname_old, fname))
+				string_list_append(&rollback_failure, fname);
+			free(fname);
+			free(fname_old);
+		}
+
+		if (rollback.nr) {
+			int i;
+			fprintf(stderr,
+				"WARNING: Some packs in use have been renamed by\n"
+				"WARNING: prefixing old- to their name, in order to\n"
+				"WARNING: replace them with the new version of the\n"
+				"WARNING: file.  But the operation failed, and\n"
+				"WARNING: attempt to rename them back to their\n"
+				"WARNING: original names also failed.\n"
+				"WARNING: Please rename them in $PACKDIR manually:\n");
+			for (i = 0; i < rollback.nr; i++)
+				fprintf(stderr, "WARNING:   old-%s -> %s\n",
+					rollback.items[i].string,
+					rollback.items[i].string);
+		}
+		exit(1);
+	}
+
+	/* Now the ones with the same name are out of the way... */
+	for_each_string_list_item(item, &names) {
+		char *fname, *fname_old;
+		fname = mkpathdup("%s/pack-%s.pack", packdir, item->string);
+		fname_old = mkpathdup("%s-%s.pack", packtmp, item->string);
+		stat(fname_old, &statbuffer);
+		statbuffer.st_mode &= ~S_IWOTH;
+		chmod(fname_old, statbuffer.st_mode);
+		if (rename(fname_old, fname))
+			die("Could not rename packfile: %s -> %s", fname_old, fname);
+		free(fname);
+		free(fname_old);
+
+		fname = mkpathdup("%s/pack-%s.idx", packdir, item->string);
+		fname_old = mkpathdup("%s-%s.idx", packtmp, item->string);
+		stat(fname_old, &statbuffer);
+		statbuffer.st_mode &= ~S_IWOTH;
+		chmod(fname_old, statbuffer.st_mode);
+		if (rename(fname_old, fname))
+			die("Could not rename packfile: %s -> %s", fname_old, fname);
+		free(fname);
+		free(fname_old);
+	}
+
+	/* Remove the "old-" files */
+	for_each_string_list_item(item, &names) {
+		char *fname;
+		fname = mkpathdup("%s/old-pack-%s.idx", packdir, item->string);
+		if (remove_path(fname))
+			die("Could not remove file: %s", fname);
+		free(fname);
+
+		fname = mkpathdup("%s/old-pack-%s.pack", packdir, item->string);
+		if (remove_path(fname))
+			die("Could not remove file: %s", fname);
+		free(fname);
+	}
+
+	/* End of pack replacement. */
+	if (delete_redundant) {
+		sort_string_list(&names);
+		for_each_string_list_item(item, &existing_packs) {
+			if (!string_list_has_string(&names, item->string))
+				remove_pack(packdir, item->string);
+		}
+		argv_array_clear(&cmd_args);
+		argv_array_push(&cmd_args, "prune-packed");
+		/* TODO: pass argument: ${GIT_QUIET:+-q} */
+		memset(&cmd, 0, sizeof(cmd));
+		cmd.argv = argv_array_detach(&cmd_args, NULL);
+		cmd.git_cmd = 1;
+		run_command(&cmd);
+	}
+
+	if (!no_update_server_info) {
+		argv_array_clear(&cmd_args);
+		argv_array_push(&cmd_args, "update-server-info");
+
+		memset(&cmd, 0, sizeof(cmd));
+		cmd.argv = argv_array_detach(&cmd_args, NULL);
+		cmd.git_cmd = 1;
+		run_command(&cmd);
+	}
+	return 0;
+}
+
diff --git a/git-repack.sh b/contrib/examples/git-repack.sh
similarity index 100%
rename from git-repack.sh
rename to contrib/examples/git-repack.sh
diff --git a/git.c b/git.c
index 2025f77..03510be 100644
--- a/git.c
+++ b/git.c
@@ -396,6 +396,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "remote", cmd_remote, RUN_SETUP },
 		{ "remote-ext", cmd_remote_ext },
 		{ "remote-fd", cmd_remote_fd },
+		{ "repack", cmd_repack, RUN_SETUP },
 		{ "replace", cmd_replace, RUN_SETUP },
 		{ "repo-config", cmd_repo_config, RUN_SETUP_GENTLY },
 		{ "rerere", cmd_rerere, RUN_SETUP },
-- 
1.8.4.rc3.2.g2c2b664

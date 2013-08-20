From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH] repack: rewrite the shell script in C.
Date: Wed, 21 Aug 2013 00:38:54 +0200
Message-ID: <1377038334-15799-1-git-send-email-stefanbeller@googlemail.com>
References: <5213EF74.7020408@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org, mfick@codeaurora.org, apelisse@gmail.com,
	Matthieu.Moy@grenoble-inp.fr, pclouds@gmail.com, iveqy@iveqy.com,
	gitster@pobox.com, mackyle@gmail.com, j6t@kdbg.org
X-From: git-owner@vger.kernel.org Wed Aug 21 00:39:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBuZp-0001po-Hb
	for gcvg-git-2@plane.gmane.org; Wed, 21 Aug 2013 00:39:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385Ab3HTWi5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 18:38:57 -0400
Received: from mail-ea0-f171.google.com ([209.85.215.171]:36349 "EHLO
	mail-ea0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751322Ab3HTWi4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 18:38:56 -0400
Received: by mail-ea0-f171.google.com with SMTP id n15so477890ead.16
        for <git@vger.kernel.org>; Tue, 20 Aug 2013 15:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=p2Qr2sLYfzLMs5BOaFtcORvUUM5MkfjqY7UJc384rB4=;
        b=XzudOFkRs9db+d1kOAbBMgX1PW6HO1T9dSkvaPxaAsUcI0iklv21i/AOHtCXlrdIEN
         DIGuo1UU1H2Hlu9iJEumo7PKGzszvRR67bdsWkJCtzd+p4WzZM3ylLNbZ1FBEEop3IY1
         +TmbvxqV8IphZPNKWQC6z5XtUgV7cbxG81SutJirSJO5QG3DwuMElU0kXIn5JT7j/hjU
         o1LftrPyRr4upJLFdMiO25tqUzElgdV7zBlhxjNdaug4xGR4dBr4ImD2Gjl4AJ+XWwDn
         UcCa1XD8+ispWlDvR3k7XMts0jZ3z+RKklCodCkCxsWmh7KOTNmCdaOZzLh2bW6Wrwj/
         dLpQ==
X-Received: by 10.14.210.8 with SMTP id t8mr4880634eeo.39.1377038335123;
        Tue, 20 Aug 2013 15:38:55 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id a43sm5241503eep.9.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 20 Aug 2013 15:38:54 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc3.1.gc1ebd90
In-Reply-To: <5213EF74.7020408@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232658>

This is the beginning of the rewrite of the repacking.
All tests are constantly positive now.

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
---
 Makefile                                        |   2 +-
 builtin.h                                       |   1 +
 builtin/repack.c                                | 361 ++++++++++++++++++++++++
 git-repack.sh => contrib/examples/git-repack.sh |   0
 git.c                                           |   1 +
 5 files changed, 364 insertions(+), 1 deletion(-)
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
index 0000000..9fbe636
--- /dev/null
+++ b/builtin/repack.c
@@ -0,0 +1,361 @@
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
+#include "argv-array.h"
+
+static int delta_base_offset = 0;
+
+static const char *const git_repack_usage[] = {
+	N_("git repack [options]"),
+	NULL
+};
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
+/*
+ * Fills the filename list with all the files found in the pack directory
+ * ending with .pack, without that extension.
+ */
+void get_pack_filenames(char *packdir, struct string_list *fname_list)
+{
+	DIR *dir;
+	struct dirent *e;
+	char *path, *suffix, *fname;
+
+	path = mkpath("%s/pack", get_object_directory());
+	suffix = ".pack";
+
+	dir = opendir(path);
+	while ((e = readdir(dir)) != NULL) {
+		if (!suffixcmp(e->d_name, suffix)) {
+			size_t len = strlen(e->d_name) - strlen(suffix);
+			fname = xmemdupz(e->d_name, len);
+			string_list_append_nodup(fname_list, fname);
+		}
+	}
+	closedir(dir);
+}
+
+void remove_pack(char *path, char* sha1)
+{
+	char *exts[] = {".pack", ".idx", ".keep"};
+	int ext = 0;
+	for (ext = 0; ext < 3; ext++) {
+		char *fname;
+		fname = mkpath("%s/%s%s", path, sha1, exts[ext]);
+		unlink(fname);
+	}
+}
+
+int cmd_repack(int argc, const char **argv, const char *prefix) {
+
+	char *exts[2] = {".idx", ".pack"};
+	char *packdir, *packtmp, line[1024];
+	struct child_process cmd;
+	struct string_list_item *item;
+	struct argv_array cmd_args = ARGV_ARRAY_INIT;
+	struct string_list names = STRING_LIST_INIT_DUP;
+	struct string_list rollback = STRING_LIST_INIT_DUP;
+	struct string_list existing_packs = STRING_LIST_INIT_DUP;
+	int count_packs, ext;
+	FILE *out;
+
+	/* variables to be filled by option parsing */
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
+
+	struct option builtin_repack_options[] = {
+		OPT_BOOL('a', NULL, &pack_everything,
+				N_("pack everything in a single pack")),
+		OPT_BOOL('A', NULL, &pack_everything_but_loose,
+				N_("same as -a, and turn unreachable objects loose")),
+		OPT_BOOL('d', NULL, &delete_redundant,
+				N_("remove redundant packs, and run git-prune-packed")),
+		OPT_BOOL('f', NULL, &no_reuse_delta,
+				N_("pass --no-reuse-delta to git-pack-objects")),
+		OPT_BOOL('F', NULL, &no_reuse_object,
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
+	if (no_reuse_delta)
+		argv_array_pushf(&cmd_args, "--no-reuse-delta");
+
+	if (no_reuse_object)
+		argv_array_pushf(&cmd_args, "--no-reuse-object");
+
+	if (pack_everything + pack_everything_but_loose == 0) {
+		argv_array_push(&cmd_args, "--unpacked");
+		argv_array_push(&cmd_args, "--incremental");
+	} else {
+		struct string_list fname_list = STRING_LIST_INIT_DUP;
+		get_pack_filenames(packdir, &fname_list);
+		for_each_string_list_item(item, &fname_list) {
+			char *fname;
+			fname = mkpathdup("%s/%s.keep", packdir, item->string);
+			if (file_exists(fname)) {
+				/* when the keep file is there, we're ignoring that pack */
+			} else {
+				string_list_append(&existing_packs, item->string);
+			}
+			free(fname);
+		}
+
+		if (existing_packs.nr && delete_redundant) {
+			if (unpack_unreachable)
+				argv_array_pushf(&cmd_args, "--unpack-unreachable=%s", unpack_unreachable);
+			else if (pack_everything_but_loose)
+				argv_array_push(&cmd_args, "--unpack-unreachable");
+		}
+	}
+
+	if (local)
+		argv_array_push(&cmd_args,  "--local");
+	if (quiet)
+		argv_array_push(&cmd_args,  "--quiet");
+	if (delta_base_offset)
+		argv_array_push(&cmd_args,  "--delta-base-offset");
+
+	argv_array_push(&cmd_args, packtmp);
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.argv = cmd_args.argv;
+	cmd.git_cmd = 1;
+	cmd.out = -1;
+	cmd.no_stdin = 1;
+
+	if (start_command(&cmd))
+		return 1;
+
+	count_packs = 0;
+	out = xfdopen(cmd.out, "r");
+	while (fgets(line, sizeof(line), out)) {
+		/* a line consists of 40 hex chars + '\n' */
+		if (strlen(line) != 41)
+			die("repack: Expecting 40 character sha1 lines only from pack-objects.");
+		line[40] = '\0';
+		string_list_append(&names, line);
+		count_packs++;
+	}
+	if (finish_command(&cmd))
+		return 1;
+	fclose(out);
+
+	if (!count_packs && !quiet)
+		printf("Nothing new to pack.\n");
+
+	int failed = 0;
+	for_each_string_list_item(item, &names) {
+		for (ext = 0; ext < 2; ext++) {
+			char *fname, *fname_old;
+			fname = mkpathdup("%s/%s%s", packdir, item->string, exts[ext]);
+			if (!file_exists(fname)) {
+				free(fname);
+				continue;
+			}
+
+			fname_old = mkpath("%s/old-%s%s", packdir, item->string, exts[ext]);
+			if (file_exists(fname_old))
+				unlink(fname_old);
+
+			if (rename(fname, fname_old)) {
+				failed = 1;
+				break;
+			}
+			string_list_append_nodup(&rollback, fname);
+			free(fname);
+		}
+		if (failed)
+			break;
+	}
+	if (failed) {
+		struct string_list rollback_failure;
+		for_each_string_list_item(item, &rollback) {
+			char *fname, *fname_old;
+			fname = mkpathdup("%s/%s", packdir, item->string);
+			fname_old = mkpath("%s/old-%s", packdir, item->string);
+			if (rename(fname_old, fname))
+				string_list_append(&rollback_failure, fname);
+			free(fname);
+		}
+
+		if (rollback.nr) {
+			int i;
+			fprintf(stderr,
+				"WARNING: Some packs in use have been renamed by\n"
+				"WARNING: prefixing old- to their name, in order to\n"
+				"WARNING: replace them with the new version of the\n"
+				"WARNING: file.  But the operation failed, and the\n"
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
+		for (ext = 0; ext < 2; ext++) {
+			char *fname, *fname_old;
+			struct stat statbuffer;
+			fname = mkpathdup("%s/pack-%s%s", packdir, item->string, exts[ext]);
+			fname_old = mkpath("%s-%s%s", packtmp, item->string, exts[ext]);
+			if (!stat(fname_old, &statbuffer)) {
+				statbuffer.st_mode &= ~S_IWUSR | ~S_IWGRP | ~S_IWOTH;
+				chmod(fname_old, statbuffer.st_mode);
+			}
+			if (rename(fname_old, fname))
+				die_errno(_("renaming '%s' failed"), fname_old);
+			free(fname);
+		}
+	}
+
+	/* Remove the "old-" files */
+	for_each_string_list_item(item, &names) {
+		char *fname;
+		fname = mkpath("%s/old-pack-%s.idx", packdir, item->string);
+		if (remove_path(fname))
+			die_errno(_("removing '%s' failed"), fname);
+
+		fname = mkpath("%s/old-pack-%s.pack", packdir, item->string);
+		if (remove_path(fname))
+			die_errno(_("removing '%s' failed"), fname);
+	}
+
+	/* End of pack replacement. */
+
+	if (delete_redundant) {
+		sort_string_list(&names);
+		for_each_string_list_item(item, &existing_packs) {
+			char *sha1;
+			size_t len = strlen(item->string);
+			if (len < 40)
+				continue;
+			sha1 = item->string + len - 40;
+			if (!string_list_has_string(&names, sha1))
+				remove_pack(packdir, item->string);
+		}
+		argv_array_clear(&cmd_args);
+		argv_array_push(&cmd_args, "prune-packed");
+		if (quiet)
+			argv_array_push(&cmd_args, "--quiet");
+
+		memset(&cmd, 0, sizeof(cmd));
+		cmd.argv = cmd_args.argv;
+		cmd.git_cmd = 1;
+		run_command(&cmd);
+	}
+
+	if (!no_update_server_info) {
+		argv_array_clear(&cmd_args);
+		argv_array_push(&cmd_args, "update-server-info");
+
+		memset(&cmd, 0, sizeof(cmd));
+		cmd.argv = cmd_args.argv;
+		cmd.git_cmd = 1;
+		run_command(&cmd);
+	}
+	return 0;
+}
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
1.8.4.rc3.1.gc1ebd90

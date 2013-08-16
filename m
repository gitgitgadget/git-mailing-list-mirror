From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [RFC PATCHv2] repack: rewrite the shell script in C.
Date: Fri, 16 Aug 2013 02:12:58 +0200
Message-ID: <1376611978-13189-1-git-send-email-stefanbeller@googlemail.com>
References: <7v8v02swnc.fsf@alter.siamese.dyndns.org>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org, mfick@codeaurora.org, apelisse@gmail.com,
	Matthieu.Moy@grenoble-inp.fr, pclouds@gmail.com, iveqy@iveqy.com,
	gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 16 02:13:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VA7fI-0003CH-7y
	for gcvg-git-2@plane.gmane.org; Fri, 16 Aug 2013 02:13:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752391Ab3HPAMx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Aug 2013 20:12:53 -0400
Received: from mail-ea0-f175.google.com ([209.85.215.175]:59966 "EHLO
	mail-ea0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752063Ab3HPAMw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Aug 2013 20:12:52 -0400
Received: by mail-ea0-f175.google.com with SMTP id m14so675569eaj.6
        for <git@vger.kernel.org>; Thu, 15 Aug 2013 17:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gpbPqrYYS9aLg3LN4WyAnGoTzY9WT7uDHDu1Ykxq4i4=;
        b=NI2ajv9o2RYlcvy52COX8SbtQiG89uHNUMLPcavlr1vhlHcCWI3guynPd2vUGM7CHo
         dT+8QYMgjLiIZZr7hJsOJ4xErXuU8ldM+e77NbLge8FzZJzYzCOmU6iNEunextcLZjhS
         qBUDGmnVfzvAmC2wn07EDCtYv2a+KqPruc/2hsw9Yeq+CtaE/C9/jCMPJblmMn9TfUuT
         JvebRMT1MO2GVm4dL+kCycqsLi10Y/WsI4ndRz+ETwUpZNhlA1yczRldilhFjTHdDIxn
         8fxTvnwoe8FcGWFc5+gVqypFjdSHyT9gz6huIUKootudDQAHrxoLUdVBeVxkywFRxpgK
         4xaw==
X-Received: by 10.15.36.9 with SMTP id h9mr26122242eev.30.1376611971095;
        Thu, 15 Aug 2013 17:12:51 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id k3sm2920665een.16.2013.08.15.17.12.49
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 15 Aug 2013 17:12:50 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc3.1.gc1ebd90
In-Reply-To: <7v8v02swnc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232389>

This is the beginning of the rewrite of the repacking.

 * Removed unneeded system header files
 * corrected remove_pack to really remove any pack files with the given
   sha1
 * fail if pack-objects fails
 * Only test t7701 (2nd) fails now  with this patch.

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
---
 Makefile                                        |   2 +-
 builtin.h                                       |   1 +
 builtin/repack.c                                | 411 ++++++++++++++++++++++++
 git-repack.sh => contrib/examples/git-repack.sh |   0
 git.c                                           |   1 +
 5 files changed, 414 insertions(+), 1 deletion(-)
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
index 0000000..f72911d
--- /dev/null
+++ b/builtin/repack.c
@@ -0,0 +1,411 @@
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
+	char *prefix, *path, *fname;
+
+	prefix = xmalloc(strlen(".tmp-10000-pack") + 1);
+	sprintf(prefix, ".tmp-%d-pack", getpid());
+
+	path = xmalloc(strlen(get_object_directory()) + strlen("/pack") + 1);
+	sprintf(path, "%s/pack", get_object_directory());
+
+	fname = xmalloc(strlen(path) + strlen("/")
+		+ strlen(prefix) + strlen("/")
+		+ 40 + strlen(".pack") + 1);
+
+	dir = opendir(path);
+	while ((e = readdir(dir)) != NULL) {
+		if (!prefixcmp(e->d_name, prefix)) {
+			sprintf(fname, "%s/%s", path, e->d_name);
+			unlink(fname);
+		}
+	}
+	free(fname);
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
+	path = xmalloc(strlen(get_object_directory()) + strlen("/pack") + 1);
+	sprintf(path, "%s/pack", get_object_directory());
+
+	suffix = ".pack";
+
+	dir = opendir(path);
+	while ((e = readdir(dir)) != NULL) {
+		if (!suffixcmp(e->d_name, suffix)) {
+			char buf[255], *sha1;
+			strcpy(buf, e->d_name);
+			buf[strlen(e->d_name) - strlen(suffix)] = '\0';
+			sha1 = &buf[strlen(e->d_name) - strlen(suffix) - 40];
+			string_list_append(sha1_list, sha1);
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
+
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
+			fname = xmalloc(strlen(path) + 1 + strlen(e->d_name));
+			sprintf(fname, "%s/%s", path, e->d_name);
+			unlink(fname);
+			/*TODO: free(fname); fails here sometimes, needs investigation*/
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
+	unsigned long unpack_unreachable = 0;
+	int window = 0, window_memory = 0;
+	int depth = 0;
+	int max_pack_size = 0;
+	int no_reuse_delta = 0, no_reuse_object = 0;
+	int no_update_server_info = 0;
+	int quiet = 0;
+	int local = 0;
+	char *packdir, *packtmp;
+	const char *cmd_args[20];
+	int cmd_i = 0;
+	struct child_process cmd;
+	struct string_list_item *item;
+	struct string_list existing_packs = STRING_LIST_INIT_DUP;
+	struct stat statbuffer;
+	char window_str[64], window_mem_str[64], depth_str[64], max_pack_size_str[64];
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
+		OPT_DATE(0, "unpack-unreachable", &unpack_unreachable,
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
+	packdir = mkpath("%s/pack", get_object_directory());
+	packtmp = xmalloc(strlen(packdir) + strlen("/.tmp-10000-pack") + 1);
+	sprintf(packtmp, "%s/.tmp-%d-pack", packdir, getpid());
+
+	remove_temporary_files();
+
+	cmd_args[cmd_i++] = "pack-objects";
+	cmd_args[cmd_i++] = "--keep-true-parents";
+	cmd_args[cmd_i++] = "--honor-pack-keep";
+	cmd_args[cmd_i++] = "--non-empty";
+	cmd_args[cmd_i++] = "--all";
+	cmd_args[cmd_i++] = "--reflog";
+
+	if (window) {
+		sprintf(window_str, "--window=%u", window);
+		cmd_args[cmd_i++] = window_str;
+	}
+	if (window_memory) {
+		sprintf(window_mem_str, "--window-memory=%u", window_memory);
+		cmd_args[cmd_i++] = window_str;
+	}
+	if (depth) {
+		sprintf(depth_str, "--depth=%u", depth);
+		cmd_args[cmd_i++] = depth_str;
+	}
+	if (max_pack_size) {
+		sprintf(max_pack_size_str, "--max_pack_size=%u", max_pack_size);
+		cmd_args[cmd_i++] = max_pack_size_str;
+	}
+
+	if (pack_everything + pack_everything_but_loose == 0) {
+		cmd_args[cmd_i++] = "--unpacked";
+		cmd_args[cmd_i++] = "--incremental";
+	} else {
+		if (pack_everything_but_loose)
+			cmd_args[cmd_i++] = "--unpack-unreachable";
+
+		struct string_list sha1_list = STRING_LIST_INIT_DUP;
+		get_pack_sha1_list(packdir, &sha1_list);
+		for_each_string_list_item(item, &sha1_list) {
+			char *fname;
+			fname = xmalloc(strlen(packdir) + strlen("/") + 40 + strlen(".keep"));
+			sprintf(fname, "%s/%s.keep", packdir, item->string);
+			if (stat(fname, &statbuffer) && S_ISREG(statbuffer.st_mode)) {
+				/* when the keep file is there, we're ignoring that pack */
+			} else {
+				string_list_append(&existing_packs, item->string);
+			}
+		}
+
+		if (existing_packs.nr && unpack_unreachable && delete_redundant) {
+			/*
+			 * TODO: convert unpack_unreachable (being time since epoch)
+			 * to an aproxidate again
+			 */
+			cmd_args[cmd_i++] = "--unpack-unreachable=$DATE";
+		}
+	}
+
+	if (local)
+		cmd_args[cmd_i++] = "--local";
+
+	if (delta_base_offset)
+		cmd_args[cmd_i++] = "--delta-base-offset";
+
+	cmd_args[cmd_i++] = packtmp;
+	cmd_args[cmd_i] = NULL;
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.argv = cmd_args;
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
+	char *fname, *fname_old;
+	fname = xmalloc(strlen(packdir) + strlen("/old-pack-") + 40 + strlen(".pack") + 1);
+	strcpy(fname, packdir);
+	strcpy(fname + strlen(packdir), "/");
+
+	fname_old = xmalloc(strlen(packdir) + strlen("/old-pack-") + 40 + strlen(".pack") + 1);
+	strcpy(fname_old, packdir);
+	strcpy(fname_old + strlen(packdir), "/");
+	char *exts[2] = {".idx", ".pack"};
+
+	int failed = 0;
+
+	for_each_string_list_item(item, &names) {
+		int ext;
+		for (ext = 0; ext < 1; ext++) {
+			strcpy(fname + strlen(packdir) + 1, item->string);
+			strcpy(fname + strlen(packdir) + 41, exts[ext]);
+			if (!file_exists(fname))
+				continue;
+
+			strcpy(fname_old, packdir);
+			strcpy(fname_old + strlen(packdir), "/old-");
+			strcpy(fname_old + strlen(packdir) + 5, item->string);
+			strcpy(fname_old + strlen(packdir) + 45, exts[ext]);
+			if (file_exists(fname_old))
+				unlink(fname_old);
+
+			if (rename(fname, fname_old)) {
+				failed = 1;
+				break;
+			}
+			string_list_append(&rollback, fname);
+		}
+		if (failed)
+			/* set to last element to break while loop */
+			item = names.items + names.nr;
+	}
+	if (failed) {
+		struct string_list rollback_failure;
+
+		for_each_string_list_item(item, &rollback) {
+			sprintf(fname, "%s/%s", packdir, item->string);
+			sprintf(fname_old, "%s/old-%s", packdir, item->string);
+			if (rename(fname_old, fname))
+				string_list_append(&rollback_failure, fname);
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
+	struct string_list fullbases = STRING_LIST_INIT_DUP;
+	for_each_string_list_item(item, &names) {
+		string_list_append(&fullbases, item->string);
+
+		sprintf(fname, "%s/pack-%s.pack", packdir, item->string);
+		sprintf(fname_old, "%s-%s.pack", packtmp, item->string);
+		stat(fname_old, &statbuffer);
+		statbuffer.st_mode &= ~S_IWOTH;
+		chmod(fname_old, statbuffer.st_mode);
+		if (rename(fname_old, fname))
+			die("Could not rename packfile: %s -> %s", fname_old, fname);
+
+		sprintf(fname, "%s/pack-%s.idx", packdir, item->string);
+		sprintf(fname_old, "%s-%s.idx", packtmp, item->string);
+		stat(fname_old, &statbuffer);
+		statbuffer.st_mode &= ~S_IWOTH;
+		chmod(fname_old, statbuffer.st_mode);
+		if (rename(fname_old, fname))
+			die("Could not rename packfile: %s -> %s", fname_old, fname);
+	}
+
+	/* Remove the "old-" files */
+	for_each_string_list_item(item, &names) {
+		sprintf(fname, "%s/old-pack-%s.idx", packdir, item->string);
+		if (remove_path(fname))
+			die("Could not remove file: %s", fname);
+
+		sprintf(fname, "%s/old-pack-%s.pack", packdir, item->string);
+		if (remove_path(fname))
+			die("Could not remove file: %s", fname);
+	}
+
+	/* End of pack replacement. */
+	if (delete_redundant) {
+		sort_string_list(&fullbases);
+		fname = xmalloc(strlen(packtmp) + strlen("/") + 40 + strlen(".pack") + 1);
+		for_each_string_list_item(item, &existing_packs) {
+			if (!string_list_has_string(&fullbases, item->string))
+				remove_pack(packdir, item->string);
+		}
+		free(fname);
+		cmd_i = 0;
+		cmd_args[cmd_i++] = "prune-packed";
+		cmd_args[cmd_i++] = NULL;
+		/* TODO: pass argument: ${GIT_QUIET:+-q} */
+		memset(&cmd, 0, sizeof(cmd));
+		cmd.argv = cmd_args;
+		cmd.git_cmd = 1;
+		run_command(&cmd);
+	}
+
+	if (!no_update_server_info) {
+		cmd_i = 0;
+		cmd_args[cmd_i++] = "update-server-info";
+		cmd_args[cmd_i++] = NULL;
+
+		memset(&cmd, 0, sizeof(cmd));
+		cmd.argv = cmd_args;
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
1.8.4.rc3.1.gc1ebd90

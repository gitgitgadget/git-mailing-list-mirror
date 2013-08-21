From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [RFC PATCHv6 1/2] repack: rewrite the shell script in C
Date: Wed, 21 Aug 2013 19:28:15 +0200
Message-ID: <1377106096-28195-1-git-send-email-stefanbeller@googlemail.com>
References: <5214F816.3010303@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org, mfick@codeaurora.org, apelisse@gmail.com,
	Matthieu.Moy@grenoble-inp.fr, pclouds@gmail.com, iveqy@iveqy.com,
	gitster@pobox.com, mackyle@gmail.com, j6t@kdbg.org
X-From: git-owner@vger.kernel.org Wed Aug 21 19:28:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCCCj-00055k-Ss
	for gcvg-git-2@plane.gmane.org; Wed, 21 Aug 2013 19:28:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752149Ab3HUR2R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Aug 2013 13:28:17 -0400
Received: from mail-ea0-f171.google.com ([209.85.215.171]:34697 "EHLO
	mail-ea0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751726Ab3HUR2Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Aug 2013 13:28:16 -0400
Received: by mail-ea0-f171.google.com with SMTP id n15so420777ead.30
        for <git@vger.kernel.org>; Wed, 21 Aug 2013 10:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EDYykPktlR8bk2yjc7LUySfEIpEKtX0c6cxk6wcLob4=;
        b=LNSFjnjyC32HwEVP6xaNpQW35R+X2B8aO0KRUZjq7L4y7RQdB3wTCwV3LafPLFTz9a
         mqJlPqKhOcLt2WQREd/cgdjs9/L8jkE9xwBgJQ/8uZniecvnpA8o23kThKvzFki3VmNe
         HsDwFoD/VV6L/z+7NeG7+3bE+ZmzxIRmRkmA5Qv6KmNpb8Unr3fE1sWtwxyjqIYARU2v
         GohW1YWZ7xvEMMpYHM383F4v15SBHn82CrTmnIUqExjY3zAhOsHVAhD0yeu62wXAwgBU
         lYOCQgQh9nfCzsJKDITdg44rdgVsWRCt0p3aHlfmqHhNaQ/mbSxUythnyBJMGtMhX4xZ
         qPrw==
X-Received: by 10.14.37.4 with SMTP id x4mr12120453eea.16.1377106095155;
        Wed, 21 Aug 2013 10:28:15 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id z12sm11330960eev.6.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 21 Aug 2013 10:28:14 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc3.1.gc1ebd90
In-Reply-To: <5214F816.3010303@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232708>

The motivation of this patch is to get closer to a goal of being
able to have a core subset of git functionality built in to git.
That would mean

 * people on Windows could get a copy of at least the core parts
   of Git without having to install a Unix-style shell

 * people deploying to servers don't have to rewrite the #! line
   or worry about the PATH and quality of installed POSIX
   utilities, if they are only using the built-in part written
   in C

This patch is meant to be mostly a literal translation of the
git-repack script; the intent is that later patches would start using
more library facilities, but this patch is meant to be as close to a
no-op as possible so it doesn't do that kind of thing.

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
---
 Makefile                                        |   2 +-
 builtin.h                                       |   1 +
 builtin/repack.c                                | 376 ++++++++++++++++++++++++
 git-repack.sh => contrib/examples/git-repack.sh |   0
 git.c                                           |   1 +
 5 files changed, 379 insertions(+), 1 deletion(-)
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
index 0000000..fb050c0
--- /dev/null
+++ b/builtin/repack.c
@@ -0,0 +1,376 @@
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
+/* enabled by default since 22c79eab (2008-06-25) */
+static int delta_base_offset = 1;
+char *packdir;
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
+/*
+ * Remove temporary $GIT_OBJECT_DIRECTORY/pack/.tmp-$$-pack-* files.
+ */
+static void remove_temporary_files(void)
+{
+	struct strbuf buf = STRBUF_INIT;
+	size_t dirlen, prefixlen;
+	DIR *dir;
+	struct dirent *e;
+
+	/* .git/objects/pack */
+	strbuf_addstr(&buf, get_object_directory());
+	strbuf_addstr(&buf, "/pack");
+	dir = opendir(buf.buf);
+	if (!dir) {
+		strbuf_release(&buf);
+		return;
+	}
+
+	/* .git/objects/pack/.tmp-$$-pack-* */
+	dirlen = buf.len + 1;
+	strbuf_addf(&buf, "/.tmp-%d-pack-", (int)getpid());
+	prefixlen = buf.len - dirlen;
+
+	while ((e = readdir(dir))) {
+		if (strncmp(e->d_name, buf.buf + dirlen, prefixlen))
+			continue;
+		strbuf_setlen(&buf, dirlen);
+		strbuf_addstr(&buf, e->d_name);
+		unlink(buf.buf);
+	}
+	closedir(dir);
+	strbuf_release(&buf);
+}
+
+static void remove_pack_on_signal(int signo)
+{
+	remove_temporary_files();
+	sigchain_pop(signo);
+	raise(signo);
+}
+
+static void get_pack_filenames(struct string_list *fname_list)
+{
+	DIR *dir;
+	struct dirent *e;
+	char *fname;
+
+	if (!(dir = opendir(packdir)))
+		return;
+
+	while ((e = readdir(dir)) != NULL) {
+		if (suffixcmp(e->d_name, ".pack"))
+			continue;
+
+		size_t len = strlen(e->d_name) - strlen(".pack");
+		fname = xmemdupz(e->d_name, len);
+
+		if (!file_exists(mkpath("%s/%s.keep", packdir, fname)))
+			string_list_append_nodup(fname_list, fname);
+	}
+	closedir(dir);
+}
+
+static void remove_redundant_pack(const char *path, const char *sha1)
+{
+	const char *exts[] = {".pack", ".idx", ".keep"};
+	int i;
+	struct strbuf buf = STRBUF_INIT;
+	size_t plen;
+
+	strbuf_addf(&buf, "%s/%s", path, sha1);
+	plen = buf.len;
+
+	for (i = 0; i < ARRAY_SIZE(exts); i++) {
+		strbuf_setlen(&buf, plen);
+		strbuf_addstr(&buf, exts[i]);
+		unlink(buf.buf);
+	}
+}
+
+int cmd_repack(int argc, const char **argv, const char *prefix)
+{
+	const char *exts[2] = {".idx", ".pack"};
+	char *packtmp;
+	struct child_process cmd;
+	struct string_list_item *item;
+	struct argv_array cmd_args = ARGV_ARRAY_INIT;
+	struct string_list names = STRING_LIST_INIT_DUP;
+	struct string_list rollback = STRING_LIST_INIT_DUP;
+	struct string_list existing_packs = STRING_LIST_INIT_DUP;
+	struct strbuf line = STRBUF_INIT;
+	int count_packs, ext, ret;
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
+				N_("with -A, do not loosen objects older than this")),
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
+	packtmp = mkpathdup("%s/.tmp-%d-pack", packdir, (int)getpid());
+
+	argv_array_push(&cmd_args, "pack-objects");
+	argv_array_push(&cmd_args, "--keep-true-parents");
+	argv_array_push(&cmd_args, "--honor-pack-keep");
+	argv_array_push(&cmd_args, "--non-empty");
+	argv_array_push(&cmd_args, "--all");
+	argv_array_push(&cmd_args, "--reflog");
+	if (window)
+		argv_array_pushf(&cmd_args, "--window=%u", window);
+	if (window_memory)
+		argv_array_pushf(&cmd_args, "--window-memory=%u", window_memory);
+	if (depth)
+		argv_array_pushf(&cmd_args, "--depth=%u", depth);
+	if (max_pack_size)
+		argv_array_pushf(&cmd_args, "--max_pack_size=%u", max_pack_size);
+	if (no_reuse_delta)
+		argv_array_pushf(&cmd_args, "--no-reuse-delta");
+	if (no_reuse_object)
+		argv_array_pushf(&cmd_args, "--no-reuse-object");
+
+	if (!pack_everything && !pack_everything_but_loose) {
+		argv_array_push(&cmd_args, "--unpacked");
+		argv_array_push(&cmd_args, "--incremental");
+	} else {
+		get_pack_filenames(&existing_packs);
+
+		if (existing_packs.nr && delete_redundant) {
+			if (unpack_unreachable)
+				argv_array_pushf(&cmd_args,
+						"--unpack-unreachable=%s",
+						unpack_unreachable);
+			else if (pack_everything_but_loose)
+				argv_array_push(&cmd_args,
+						"--unpack-unreachable");
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
+	ret = start_command(&cmd);
+	if (ret)
+		return 1;
+
+	count_packs = 0;
+	out = xfdopen(cmd.out, "r");
+	while (strbuf_getline(&line, out, '\n') != EOF) {
+		if (line.len != 40)
+			die("repack: Expecting 40 character sha1 lines only from pack-objects.");
+		strbuf_addstr(&line, "");
+		string_list_append(&names, line.buf);
+		count_packs++;
+	}
+	fclose(out);
+	ret = finish_command(&cmd);
+	if (ret)
+		return 1;
+	argv_array_clear(&cmd_args);
+
+	if (!count_packs && !quiet)
+		printf("Nothing new to pack.\n");
+
+	int failed = 0;
+	for_each_string_list_item(item, &names) {
+		for (ext = 0; ext < 2; ext++) {
+			char *fname, *fname_old;
+			fname = mkpathdup("%s/%s%s", packdir,
+						item->string, exts[ext]);
+			if (!file_exists(fname)) {
+				free(fname);
+				continue;
+			}
+
+			fname_old = mkpathdup("%s/old-%s%s", packdir,
+						item->string, exts[ext]);
+			if (file_exists(fname_old))
+				unlink(fname_old);
+
+			if (rename(fname, fname_old)) {
+				failed = 1;
+				break;
+			}
+			string_list_append_nodup(&rollback, fname);
+			free(fname);
+			free(fname_old);
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
+				"WARNING: Please rename them in %s manually:\n", packdir);
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
+			fname = mkpathdup("%s/pack-%s%s",
+					packdir, item->string, exts[ext]);
+			fname_old = mkpathdup("%s-%s%s",
+					packtmp, item->string, exts[ext]);
+			if (!stat(fname_old, &statbuffer)) {
+				statbuffer.st_mode &= ~(S_IWUSR | S_IWGRP | S_IWOTH);
+				chmod(fname_old, statbuffer.st_mode);
+			}
+			if (rename(fname_old, fname))
+				die_errno(_("renaming '%s' failed"), fname_old);
+			free(fname);
+			free(fname_old);
+		}
+	}
+
+	/* Remove the "old-" files */
+	for_each_string_list_item(item, &names) {
+		for (ext = 0; ext < 2; ext++) {
+			char *fname;
+			fname = mkpath("%s/old-pack-%s%s",
+					packdir,
+					item->string,
+					exts[ext]);
+			if (remove_path(fname))
+				warning(_("removing '%s' failed"), fname);
+		}
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
+				remove_redundant_pack(packdir, item->string);
+		}
+		argv_array_push(&cmd_args, "prune-packed");
+		if (quiet)
+			argv_array_push(&cmd_args, "--quiet");
+
+		memset(&cmd, 0, sizeof(cmd));
+		cmd.argv = cmd_args.argv;
+		cmd.git_cmd = 1;
+		run_command(&cmd);
+		argv_array_clear(&cmd_args);
+	}
+
+	if (!no_update_server_info) {
+		argv_array_push(&cmd_args, "update-server-info");
+		memset(&cmd, 0, sizeof(cmd));
+		cmd.argv = cmd_args.argv;
+		cmd.git_cmd = 1;
+		run_command(&cmd);
+		argv_array_clear(&cmd_args);
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

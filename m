From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH 1/3] repack: rewrite the shell script in C
Date: Sun, 15 Sep 2013 17:33:20 +0200
Message-ID: <1379259202-5042-1-git-send-email-stefanbeller@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 15 17:33:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VLEK5-0006NR-Lm
	for gcvg-git-2@plane.gmane.org; Sun, 15 Sep 2013 17:33:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757034Ab3IOPdN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Sep 2013 11:33:13 -0400
Received: from mail-ea0-f182.google.com ([209.85.215.182]:36299 "EHLO
	mail-ea0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756997Ab3IOPdM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Sep 2013 11:33:12 -0400
Received: by mail-ea0-f182.google.com with SMTP id o10so1516093eaj.41
        for <git@vger.kernel.org>; Sun, 15 Sep 2013 08:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=t8OahOh7c2VCQ9u5j+Bq6uIVidc4k/LVCNzSZUg1H5w=;
        b=XV1GtkGc9PabM2L42G9Etu2yXPjjxLg/qi07F1qD0SMODy6BpzhSjISuKZAdwKFY1L
         A+byqw7lTMy6FsuY3pD3qgdOpoYs4VoFVF9YnYEOjL+UCXa62czF4h9Dn3ndEvQgDHuM
         df0qM6CF3BGyQYosUWN5KnNzNtgZRcyK8wzKJFP9r0ZJl95YjieDOupvTpzQKqfbbAm5
         9/B10dscqjyn/J+OofIGaVibKM13sETzdyg3BSJKGMGLC/hpWWUP0hKykVliKU0Hj7IX
         XBNbYpDjU5lUtxSzkp8P80zZXtHoQM1010dH1et00JGnguGmMPzxE7wGZomspMEypf5A
         uFiA==
X-Received: by 10.14.45.70 with SMTP id o46mr35823392eeb.19.1379259190978;
        Sun, 15 Sep 2013 08:33:10 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id d8sm33730481eeh.8.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 15 Sep 2013 08:33:10 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.273.ga194ead
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234819>

The motivation of this patch is to get closer to a goal of being
able to have a core subset of git functionality built in to git.
That would mean

 * people on Windows could get a copy of at least the core parts
   of Git without having to install a Unix-style shell

 * people using git in on servers with chrooted environments
   do not need to worry about standard tools lacking for shell
   scripts.

This patch is meant to be mostly a literal translation of the
git-repack script; the intent is that later patches would start using
more library facilities, but this patch is meant to be as close to a
no-op as possible so it doesn't do that kind of thing.

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile                       |   2 +-
 builtin.h                      |   1 +
 builtin/repack.c               | 387 +++++++++++++++++++++++++++++++++++++++++
 contrib/examples/git-repack.sh | 194 +++++++++++++++++++++
 git-repack.sh                  | 194 ---------------------
 git.c                          |   1 +
 6 files changed, 584 insertions(+), 195 deletions(-)
 create mode 100644 builtin/repack.c
 create mode 100755 contrib/examples/git-repack.sh
 delete mode 100755 git-repack.sh

diff --git a/Makefile b/Makefile
index 3588ca1..69e5267 100644
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
@@ -971,6 +970,7 @@ BUILTIN_OBJS += builtin/reflog.o
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
index 0000000..a15bd9b
--- /dev/null
+++ b/builtin/repack.c
@@ -0,0 +1,387 @@
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
+static int delta_base_offset = 1;
+static char *packdir, *packtmp;
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
+	dir = opendir(packdir);
+	if (!dir)
+		return;
+
+	/* Point at the slash at the end of ".../objects/pack/" */
+	dirlen = strlen(packdir) + 1;
+	strbuf_addstr(&buf, packtmp);
+	/* Hold the length of  ".tmp-%d-pack-" */
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
+/*
+ * Adds all packs hex strings to the fname list, which do not
+ * have a corresponding .keep file.
+ */
+static void get_non_kept_pack_filenames(struct string_list *fname_list)
+{
+	DIR *dir;
+	struct dirent *e;
+	char *fname;
+	size_t len;
+
+	if (!(dir = opendir(packdir)))
+		return;
+
+	while ((e = readdir(dir)) != NULL) {
+		if (suffixcmp(e->d_name, ".pack"))
+			continue;
+
+		len = strlen(e->d_name) - strlen(".pack");
+		fname = xmemdupz(e->d_name, len);
+
+		if (!file_exists(mkpath("%s/%s.keep", packdir, fname)))
+			string_list_append_nodup(fname_list, fname);
+		else
+			free(fname);
+	}
+	closedir(dir);
+}
+
+static void remove_redundant_pack(const char *path_prefix, const char *hex)
+{
+	const char *exts[] = {".pack", ".idx", ".keep"};
+	int i;
+	struct strbuf buf = STRBUF_INIT;
+	size_t plen;
+
+	strbuf_addf(&buf, "%s/%s", path_prefix, hex);
+	plen = buf.len;
+
+	for (i = 0; i < ARRAY_SIZE(exts); i++) {
+		strbuf_setlen(&buf, plen);
+		strbuf_addstr(&buf, exts[i]);
+		unlink(buf.buf);
+	}
+	strbuf_release(&buf);
+}
+
+#define ALL_INTO_ONE 1
+#define LOOSEN_UNREACHABLE 2
+
+int cmd_repack(int argc, const char **argv, const char *prefix)
+{
+	const char *exts[2] = {".pack", ".idx"};
+	struct child_process cmd;
+	struct string_list_item *item;
+	struct argv_array cmd_args = ARGV_ARRAY_INIT;
+	struct string_list names = STRING_LIST_INIT_DUP;
+	struct string_list rollback = STRING_LIST_INIT_NODUP;
+	struct string_list existing_packs = STRING_LIST_INIT_DUP;
+	struct strbuf line = STRBUF_INIT;
+	int nr_packs, ext, ret, failed;
+	FILE *out;
+
+	/* variables to be filled by option parsing */
+	int pack_everything = 0;
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
+		OPT_BIT('a', NULL, &pack_everything,
+				N_("pack everything in a single pack"), ALL_INTO_ONE),
+		OPT_BIT('A', NULL, &pack_everything,
+				N_("same as -a, and turn unreachable objects loose"),
+				   LOOSEN_UNREACHABLE),
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
+	packdir = mkpathdup("%s/pack", get_object_directory());
+	packtmp = mkpathdup("%s/.tmp-%d-pack", packdir, (int)getpid());
+
+	sigchain_push_common(remove_pack_on_signal);
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
+	if (!pack_everything) {
+		argv_array_push(&cmd_args, "--unpacked");
+		argv_array_push(&cmd_args, "--incremental");
+	} else {
+		get_non_kept_pack_filenames(&existing_packs);
+
+		if (existing_packs.nr && delete_redundant) {
+			if (unpack_unreachable)
+				argv_array_pushf(&cmd_args,
+						"--unpack-unreachable=%s",
+						unpack_unreachable);
+			else if (pack_everything & LOOSEN_UNREACHABLE)
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
+	nr_packs = 0;
+	out = xfdopen(cmd.out, "r");
+	while (strbuf_getline(&line, out, '\n') != EOF) {
+		if (line.len != 40)
+			die("repack: Expecting 40 character sha1 lines only from pack-objects.");
+		string_list_append(&names, line.buf);
+		nr_packs++;
+	}
+	fclose(out);
+	ret = finish_command(&cmd);
+	if (ret)
+		return 1;
+	argv_array_clear(&cmd_args);
+
+	if (!nr_packs && !quiet)
+		printf("Nothing new to pack.\n");
+
+	/*
+	 * Ok we have prepared all new packfiles.
+	 * First see if there are packs of the same name and if so
+	 * if we can move them out of the way (this can happen if we
+	 * repacked immediately after packing fully.
+	 */
+	failed = 0;
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
+			fname_old = mkpath("%s/old-%s%s", packdir,
+						item->string, exts[ext]);
+			if (file_exists(fname_old))
+				if (unlink(fname_old))
+					failed = 1;
+
+			if (!failed && rename(fname, fname_old)) {
+				free(fname);
+				failed = 1;
+				break;
+			} else {
+				string_list_append(&rollback, fname);
+			}
+		}
+		if (failed)
+			break;
+	}
+	if (failed) {
+		struct string_list rollback_failure = STRING_LIST_INIT_DUP;
+		for_each_string_list_item(item, &rollback) {
+			char *fname, *fname_old;
+			fname = mkpathdup("%s/%s", packdir, item->string);
+			fname_old = mkpath("%s/old-%s", packdir, item->string);
+			if (rename(fname_old, fname))
+				string_list_append(&rollback_failure, fname);
+			free(fname);
+		}
+
+		if (rollback_failure.nr) {
+			int i;
+			fprintf(stderr,
+				"WARNING: Some packs in use have been renamed by\n"
+				"WARNING: prefixing old- to their name, in order to\n"
+				"WARNING: replace them with the new version of the\n"
+				"WARNING: file.  But the operation failed, and the\n"
+				"WARNING: attempt to rename them back to their\n"
+				"WARNING: original names also failed.\n"
+				"WARNING: Please rename them in %s manually:\n", packdir);
+			for (i = 0; i < rollback_failure.nr; i++)
+				fprintf(stderr, "WARNING:   old-%s -> %s\n",
+					rollback_failure.items[i].string,
+					rollback_failure.items[i].string);
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
+				exit(errno);
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
+			remove_path(fname);
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
+	remove_temporary_files();
+	string_list_clear(&names, 0);
+	string_list_clear(&rollback, 0);
+	string_list_clear(&existing_packs, 0);
+	strbuf_release(&line);
+
+	return 0;
+}
diff --git a/contrib/examples/git-repack.sh b/contrib/examples/git-repack.sh
new file mode 100755
index 0000000..7579331
--- /dev/null
+++ b/contrib/examples/git-repack.sh
@@ -0,0 +1,194 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Linus Torvalds
+#
+
+OPTIONS_KEEPDASHDASH=
+OPTIONS_SPEC="\
+git repack [options]
+--
+a               pack everything in a single pack
+A               same as -a, and turn unreachable objects loose
+d               remove redundant packs, and run git-prune-packed
+f               pass --no-reuse-delta to git-pack-objects
+F               pass --no-reuse-object to git-pack-objects
+n               do not run git-update-server-info
+q,quiet         be quiet
+l               pass --local to git-pack-objects
+unpack-unreachable=  with -A, do not loosen objects older than this
+ Packing constraints
+window=         size of the window used for delta compression
+window-memory=  same as the above, but limit memory size instead of entries count
+depth=          limits the maximum delta depth
+max-pack-size=  maximum size of each packfile
+"
+SUBDIRECTORY_OK='Yes'
+. git-sh-setup
+
+no_update_info= all_into_one= remove_redundant= unpack_unreachable=
+local= no_reuse= extra=
+while test $# != 0
+do
+	case "$1" in
+	-n)	no_update_info=t ;;
+	-a)	all_into_one=t ;;
+	-A)	all_into_one=t
+		unpack_unreachable=--unpack-unreachable ;;
+	--unpack-unreachable)
+		unpack_unreachable="--unpack-unreachable=$2"; shift ;;
+	-d)	remove_redundant=t ;;
+	-q)	GIT_QUIET=t ;;
+	-f)	no_reuse=--no-reuse-delta ;;
+	-F)	no_reuse=--no-reuse-object ;;
+	-l)	local=--local ;;
+	--max-pack-size|--window|--window-memory|--depth)
+		extra="$extra $1=$2"; shift ;;
+	--) shift; break;;
+	*)	usage ;;
+	esac
+	shift
+done
+
+case "`git config --bool repack.usedeltabaseoffset || echo true`" in
+true)
+	extra="$extra --delta-base-offset" ;;
+esac
+
+PACKDIR="$GIT_OBJECT_DIRECTORY/pack"
+PACKTMP="$PACKDIR/.tmp-$$-pack"
+rm -f "$PACKTMP"-*
+trap 'rm -f "$PACKTMP"-*' 0 1 2 3 15
+
+# There will be more repacking strategies to come...
+case ",$all_into_one," in
+,,)
+	args='--unpacked --incremental'
+	;;
+,t,)
+	args= existing=
+	if [ -d "$PACKDIR" ]; then
+		for e in `cd "$PACKDIR" && find . -type f -name '*.pack' \
+			| sed -e 's/^\.\///' -e 's/\.pack$//'`
+		do
+			if [ -e "$PACKDIR/$e.keep" ]; then
+				: keep
+			else
+				existing="$existing $e"
+			fi
+		done
+		if test -n "$existing" -a -n "$unpack_unreachable" -a \
+			-n "$remove_redundant"
+		then
+			# This may have arbitrary user arguments, so we
+			# have to protect it against whitespace splitting
+			# when it gets run as "pack-objects $args" later.
+			# Fortunately, we know it's an approxidate, so we
+			# can just use dots instead.
+			args="$args $(echo "$unpack_unreachable" | tr ' ' .)"
+		fi
+	fi
+	;;
+esac
+
+mkdir -p "$PACKDIR" || exit
+
+args="$args $local ${GIT_QUIET:+-q} $no_reuse$extra"
+names=$(git pack-objects --keep-true-parents --honor-pack-keep --non-empty --all --reflog $args </dev/null "$PACKTMP") ||
+	exit 1
+if [ -z "$names" ]; then
+	say Nothing new to pack.
+fi
+
+# Ok we have prepared all new packfiles.
+
+# First see if there are packs of the same name and if so
+# if we can move them out of the way (this can happen if we
+# repacked immediately after packing fully.
+rollback=
+failed=
+for name in $names
+do
+	for sfx in pack idx
+	do
+		file=pack-$name.$sfx
+		test -f "$PACKDIR/$file" || continue
+		rm -f "$PACKDIR/old-$file" &&
+		mv "$PACKDIR/$file" "$PACKDIR/old-$file" || {
+			failed=t
+			break
+		}
+		rollback="$rollback $file"
+	done
+	test -z "$failed" || break
+done
+
+# If renaming failed for any of them, roll the ones we have
+# already renamed back to their original names.
+if test -n "$failed"
+then
+	rollback_failure=
+	for file in $rollback
+	do
+		mv "$PACKDIR/old-$file" "$PACKDIR/$file" ||
+		rollback_failure="$rollback_failure $file"
+	done
+	if test -n "$rollback_failure"
+	then
+		echo >&2 "WARNING: Some packs in use have been renamed by"
+		echo >&2 "WARNING: prefixing old- to their name, in order to"
+		echo >&2 "WARNING: replace them with the new version of the"
+		echo >&2 "WARNING: file.  But the operation failed, and"
+		echo >&2 "WARNING: attempt to rename them back to their"
+		echo >&2 "WARNING: original names also failed."
+		echo >&2 "WARNING: Please rename them in $PACKDIR manually:"
+		for file in $rollback_failure
+		do
+			echo >&2 "WARNING:   old-$file -> $file"
+		done
+	fi
+	exit 1
+fi
+
+# Now the ones with the same name are out of the way...
+fullbases=
+for name in $names
+do
+	fullbases="$fullbases pack-$name"
+	chmod a-w "$PACKTMP-$name.pack"
+	chmod a-w "$PACKTMP-$name.idx"
+	mv -f "$PACKTMP-$name.pack" "$PACKDIR/pack-$name.pack" &&
+	mv -f "$PACKTMP-$name.idx"  "$PACKDIR/pack-$name.idx" ||
+	exit
+done
+
+# Remove the "old-" files
+for name in $names
+do
+	rm -f "$PACKDIR/old-pack-$name.idx"
+	rm -f "$PACKDIR/old-pack-$name.pack"
+done
+
+# End of pack replacement.
+
+if test "$remove_redundant" = t
+then
+	# We know $existing are all redundant.
+	if [ -n "$existing" ]
+	then
+		( cd "$PACKDIR" &&
+		  for e in $existing
+		  do
+			case " $fullbases " in
+			*" $e "*) ;;
+			*)	rm -f "$e.pack" "$e.idx" "$e.keep" ;;
+			esac
+		  done
+		)
+	fi
+	git prune-packed ${GIT_QUIET:+-q}
+fi
+
+case "$no_update_info" in
+t) : ;;
+*) git update-server-info ;;
+esac
diff --git a/git-repack.sh b/git-repack.sh
deleted file mode 100755
index 7579331..0000000
--- a/git-repack.sh
+++ /dev/null
@@ -1,194 +0,0 @@
-#!/bin/sh
-#
-# Copyright (c) 2005 Linus Torvalds
-#
-
-OPTIONS_KEEPDASHDASH=
-OPTIONS_SPEC="\
-git repack [options]
---
-a               pack everything in a single pack
-A               same as -a, and turn unreachable objects loose
-d               remove redundant packs, and run git-prune-packed
-f               pass --no-reuse-delta to git-pack-objects
-F               pass --no-reuse-object to git-pack-objects
-n               do not run git-update-server-info
-q,quiet         be quiet
-l               pass --local to git-pack-objects
-unpack-unreachable=  with -A, do not loosen objects older than this
- Packing constraints
-window=         size of the window used for delta compression
-window-memory=  same as the above, but limit memory size instead of entries count
-depth=          limits the maximum delta depth
-max-pack-size=  maximum size of each packfile
-"
-SUBDIRECTORY_OK='Yes'
-. git-sh-setup
-
-no_update_info= all_into_one= remove_redundant= unpack_unreachable=
-local= no_reuse= extra=
-while test $# != 0
-do
-	case "$1" in
-	-n)	no_update_info=t ;;
-	-a)	all_into_one=t ;;
-	-A)	all_into_one=t
-		unpack_unreachable=--unpack-unreachable ;;
-	--unpack-unreachable)
-		unpack_unreachable="--unpack-unreachable=$2"; shift ;;
-	-d)	remove_redundant=t ;;
-	-q)	GIT_QUIET=t ;;
-	-f)	no_reuse=--no-reuse-delta ;;
-	-F)	no_reuse=--no-reuse-object ;;
-	-l)	local=--local ;;
-	--max-pack-size|--window|--window-memory|--depth)
-		extra="$extra $1=$2"; shift ;;
-	--) shift; break;;
-	*)	usage ;;
-	esac
-	shift
-done
-
-case "`git config --bool repack.usedeltabaseoffset || echo true`" in
-true)
-	extra="$extra --delta-base-offset" ;;
-esac
-
-PACKDIR="$GIT_OBJECT_DIRECTORY/pack"
-PACKTMP="$PACKDIR/.tmp-$$-pack"
-rm -f "$PACKTMP"-*
-trap 'rm -f "$PACKTMP"-*' 0 1 2 3 15
-
-# There will be more repacking strategies to come...
-case ",$all_into_one," in
-,,)
-	args='--unpacked --incremental'
-	;;
-,t,)
-	args= existing=
-	if [ -d "$PACKDIR" ]; then
-		for e in `cd "$PACKDIR" && find . -type f -name '*.pack' \
-			| sed -e 's/^\.\///' -e 's/\.pack$//'`
-		do
-			if [ -e "$PACKDIR/$e.keep" ]; then
-				: keep
-			else
-				existing="$existing $e"
-			fi
-		done
-		if test -n "$existing" -a -n "$unpack_unreachable" -a \
-			-n "$remove_redundant"
-		then
-			# This may have arbitrary user arguments, so we
-			# have to protect it against whitespace splitting
-			# when it gets run as "pack-objects $args" later.
-			# Fortunately, we know it's an approxidate, so we
-			# can just use dots instead.
-			args="$args $(echo "$unpack_unreachable" | tr ' ' .)"
-		fi
-	fi
-	;;
-esac
-
-mkdir -p "$PACKDIR" || exit
-
-args="$args $local ${GIT_QUIET:+-q} $no_reuse$extra"
-names=$(git pack-objects --keep-true-parents --honor-pack-keep --non-empty --all --reflog $args </dev/null "$PACKTMP") ||
-	exit 1
-if [ -z "$names" ]; then
-	say Nothing new to pack.
-fi
-
-# Ok we have prepared all new packfiles.
-
-# First see if there are packs of the same name and if so
-# if we can move them out of the way (this can happen if we
-# repacked immediately after packing fully.
-rollback=
-failed=
-for name in $names
-do
-	for sfx in pack idx
-	do
-		file=pack-$name.$sfx
-		test -f "$PACKDIR/$file" || continue
-		rm -f "$PACKDIR/old-$file" &&
-		mv "$PACKDIR/$file" "$PACKDIR/old-$file" || {
-			failed=t
-			break
-		}
-		rollback="$rollback $file"
-	done
-	test -z "$failed" || break
-done
-
-# If renaming failed for any of them, roll the ones we have
-# already renamed back to their original names.
-if test -n "$failed"
-then
-	rollback_failure=
-	for file in $rollback
-	do
-		mv "$PACKDIR/old-$file" "$PACKDIR/$file" ||
-		rollback_failure="$rollback_failure $file"
-	done
-	if test -n "$rollback_failure"
-	then
-		echo >&2 "WARNING: Some packs in use have been renamed by"
-		echo >&2 "WARNING: prefixing old- to their name, in order to"
-		echo >&2 "WARNING: replace them with the new version of the"
-		echo >&2 "WARNING: file.  But the operation failed, and"
-		echo >&2 "WARNING: attempt to rename them back to their"
-		echo >&2 "WARNING: original names also failed."
-		echo >&2 "WARNING: Please rename them in $PACKDIR manually:"
-		for file in $rollback_failure
-		do
-			echo >&2 "WARNING:   old-$file -> $file"
-		done
-	fi
-	exit 1
-fi
-
-# Now the ones with the same name are out of the way...
-fullbases=
-for name in $names
-do
-	fullbases="$fullbases pack-$name"
-	chmod a-w "$PACKTMP-$name.pack"
-	chmod a-w "$PACKTMP-$name.idx"
-	mv -f "$PACKTMP-$name.pack" "$PACKDIR/pack-$name.pack" &&
-	mv -f "$PACKTMP-$name.idx"  "$PACKDIR/pack-$name.idx" ||
-	exit
-done
-
-# Remove the "old-" files
-for name in $names
-do
-	rm -f "$PACKDIR/old-pack-$name.idx"
-	rm -f "$PACKDIR/old-pack-$name.pack"
-done
-
-# End of pack replacement.
-
-if test "$remove_redundant" = t
-then
-	# We know $existing are all redundant.
-	if [ -n "$existing" ]
-	then
-		( cd "$PACKDIR" &&
-		  for e in $existing
-		  do
-			case " $fullbases " in
-			*" $e "*) ;;
-			*)	rm -f "$e.pack" "$e.idx" "$e.keep" ;;
-			esac
-		  done
-		)
-	fi
-	git prune-packed ${GIT_QUIET:+-q}
-fi
-
-case "$no_update_info" in
-t) : ;;
-*) git update-server-info ;;
-esac
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
1.8.4.273.ga194ead

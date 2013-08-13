From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH] repack: rewrite the shell script in C.
Date: Tue, 13 Aug 2013 21:23:17 +0200
Message-ID: <1376421797-26443-2-git-send-email-stefanbeller@googlemail.com>
References: <1376421797-26443-1-git-send-email-stefanbeller@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org, Matthieu.Moy@grenoble-inp.fr,
	pclouds@gmail.com, iveqy@iveqy.com, gitster@pobox.com,
	apelisse@gmail.com
X-From: git-owner@vger.kernel.org Tue Aug 13 21:23:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9KBt-0008VI-OB
	for gcvg-git-2@plane.gmane.org; Tue, 13 Aug 2013 21:23:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758363Ab3HMTXb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Aug 2013 15:23:31 -0400
Received: from mail-ee0-f52.google.com ([74.125.83.52]:54650 "EHLO
	mail-ee0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757554Ab3HMTX3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Aug 2013 15:23:29 -0400
Received: by mail-ee0-f52.google.com with SMTP id c41so4423931eek.25
        for <git@vger.kernel.org>; Tue, 13 Aug 2013 12:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6Q0992ZphSrtMIdVMZ31I9K9/f6cZSNrIhI8wl/yehg=;
        b=hCKAQ2FtseOTS49njWF4E+sC9KEewakHHQhrElKPqp6mdR2L+XTB8cJypRppLpnWkF
         j3LfedaqvjrhmO4VuEiyBY3sfP70YpjKTyTTSj8cC2REEPuQAMC48SXEN/MTwENmmUNG
         TE8j4W04yuP9qyQCV4lq/rUCrFj5JJAcRRwTWyV22mj70qgZiFQD/bhGbXjEw/d1K8Fh
         82mcl82meSVdkBhJJHS5XFxOpMUpSdyTk2GFatL6VOJqk+aqNDiZAxAusiLJeuvvdmkV
         bT9mx4j/sy4nssjWwmI4ycyPUcRuf2mVXYwD4BSuk3VRfIoUtTgj+4X59j3fN1MPE1wd
         Fo7A==
X-Received: by 10.15.109.135 with SMTP id cf7mr8598385eeb.0.1376421807290;
        Tue, 13 Aug 2013 12:23:27 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id bn13sm68708322eeb.11.2013.08.13.12.23.24
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 13 Aug 2013 12:23:26 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc2
In-Reply-To: <1376421797-26443-1-git-send-email-stefanbeller@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232247>

This is the beginning of the rewrite of the repacking.

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
---
 Makefile                       |   2 +-
 builtin.h                      |   1 +
 builtin/repack.c               | 313 +++++++++++++++++++++++++++++++++++++++++
 contrib/examples/git-repack.sh | 194 +++++++++++++++++++++++++
 git-repack.sh                  | 194 -------------------------
 git.c                          |   1 +
 6 files changed, 510 insertions(+), 195 deletions(-)
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
index 0000000..bfec56d
--- /dev/null
+++ b/builtin/repack.c
@@ -0,0 +1,313 @@
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
+#include <sys/types.h>
+#include <unistd.h>
+#include <stdio.h>
+#include <dirent.h>
+
+static const char * const git_repack_usage[] = {
+	N_("git repack [options]"),
+	NULL
+};
+
+static int delta_base_offset = 1; // enabled by default since 22c79eab (2008-06-25)
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
+static void remove_pack_on_signal(int signo)
+{
+	struct strbuf packtmpbuf = STRBUF_INIT;
+	/* todo: the files are not in a subdirectory, but only a subset in %s/pack, see disscussion */
+	strbuf_addf(&packtmpbuf, "%s/pack/.tmp-%d-pack", get_object_directory(), getpid());
+	remove_dir_recursively(&packtmpbuf, 0);
+	sigchain_pop(signo);
+	raise(signo);
+}
+
+int cmd_repack(int argc, const char **argv, const char *prefix) {
+
+	int pack_everything = 0;
+	int pack_everything_but_loose = 0;
+	int delete_redundant = 0;
+	int unpack_unreachable = 0;
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
+	packtmp = mkpath("%s/.tmp-%d-pack", packdir, getpid());
+
+	struct strbuf packtmpbuf = STRBUF_INIT;
+	strbuf_addf(&packtmpbuf, "%s", packtmp);
+	remove_dir_recursively(&packtmpbuf, 0);
+
+	cmd_args[cmd_i++] = "pack-objects";
+	cmd_args[cmd_i++] = "--keep-true-parents";
+	cmd_args[cmd_i++] = "--honor-pack-keep";
+	cmd_args[cmd_i++] = "--non-empty";
+	cmd_args[cmd_i++] = "--all";
+	cmd_args[cmd_i++] = "--reflog";
+
+	if (pack_everything + pack_everything_but_loose == 0) {
+		cmd_args[cmd_i++] = "--unpacked";
+		cmd_args[cmd_i++] = "--incremental";
+	} else {
+		// todo:
+		// handle -a and -A option here.
+		// find all *.pack in pack dir:
+
+/*
+	if [ -d "$PACKDIR" ]; then
+		# cd into packdir and find all packs, sed will remove beginning ./ and ending .pack
+		for e in `cd "$PACKDIR" && find . -type f -name '*.pack' \
+			| sed -e 's/^\.\///' -e 's/\.pack$//'`
+		do
+			if [ -e "$PACKDIR/$e.keep" ]; then
+				: keep
+				# do nothing
+			else
+				# add the pack to the existing list
+				existing="$existing $e"
+			fi
+		done
+		# -n string     True if the length of string is nonzero.
+		# -a and
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
+*/
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
+	run_command(&cmd);
+
+	struct string_list names = STRING_LIST_INIT_DUP;
+	struct string_list rollback = STRING_LIST_INIT_DUP;
+
+	char line[1024];
+	int counter = 0;
+	FILE *out = xfdopen(cmd.out, "r");
+	while (fgets(line, sizeof(line), out)) {
+		assert(strlen(line) == 41); // 40 chars for sha1 + '\n'
+		line[40] = '\0'; // remove '\n'
+		string_list_append(&names, line);
+		counter++;
+	}
+	if (!counter)
+		printf("Nothing new to pack.\n");
+	fclose(out);
+
+	char *fname, *fname_old;
+	fname = xmalloc(strlen(packdir) + 47); // 40 chars for the sha1
+	strcpy(fname, packdir);
+	strcpy(fname + strlen(packdir), "/");
+
+	fname_old = xmalloc(strlen(packdir) + 52); // 40 chars for the sha1
+	strcpy(fname_old, packdir);
+	strcpy(fname_old + strlen(packdir), "/");
+	char *exts[2] = {".idx", ".pack"};
+
+	int failed = 0;
+
+	struct string_list_item *item;
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
+	// Now the ones with the same name are out of the way...
+	struct string_list fullbases = STRING_LIST_INIT_DUP;
+	for_each_string_list_item(item, &names) {
+		string_list_append(&fullbases, item->string);
+
+		sprintf(fname, "%s/pack-%s.pack", packdir, item->string);
+		sprintf(fname_old, "%s-%s.pack", packtmp, item->string);
+		chmod(fname_old, 0660);
+		if (rename(fname_old, fname))
+			die("Could not rename packfile: %s -> %s", fname_old, fname);
+
+		sprintf(fname, "%s/pack-%s.idx", packdir, item->string);
+		sprintf(fname_old, "%s-%s.idx", packtmp, item->string);
+		chmod(fname_old, 0660); // todo, in shell there was "chmod a-w ..."
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
+		// todo
+		/*
+			# We know $existing are all redundant.
+			if [ -n "$existing" ]
+			then
+				( cd "$PACKDIR" &&
+				  for e in $existing
+				  do
+					case " $fullbases " in
+					*" $e "*) ;;
+					*)	rm -f "$e.pack" "$e.idx" "$e.keep" ;;
+					esac
+				  done
+				)
+			fi
+			git prune-packed ${GIT_QUIET:+-q}
+		*/
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
1.8.4.rc2

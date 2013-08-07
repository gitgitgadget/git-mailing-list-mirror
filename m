From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH 1/4] Build in git-repack
Date: Wed,  7 Aug 2013 16:00:46 +0200
Message-ID: <1375884049-14961-2-git-send-email-stefanbeller@googlemail.com>
References: <CACsJy8A-xo97MC-vBmqCrvvSDMWKd_MxnRrTBSeSqcQ1HifzJA@mail.gmail.com>
 <1375884049-14961-1-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: pclouds@gmail.com, iveqy@iveqy.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 07 16:01:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V74Ic-0003Yq-J2
	for gcvg-git-2@plane.gmane.org; Wed, 07 Aug 2013 16:01:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757470Ab3HGOBG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Aug 2013 10:01:06 -0400
Received: from mail-ea0-f182.google.com ([209.85.215.182]:47985 "EHLO
	mail-ea0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752893Ab3HGOBC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Aug 2013 10:01:02 -0400
Received: by mail-ea0-f182.google.com with SMTP id o10so864340eaj.41
        for <git@vger.kernel.org>; Wed, 07 Aug 2013 07:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=7N9C3pAeKtkgGK6LNWAQFEs5LvO9gbMegqLNGjZLGxw=;
        b=eLXhcvtkxSnsBqeQoxKpNDuWTSjE4vy3Bpbuiqc3vPN6RK9TV1tt7ODFyRZEJX/1HR
         cFXKYSatVEnVo0k19sIXsW8p1L/alWbNr5ngFxDcoi0IyEFFWX5iimgLd4x44fDTifOs
         HHZ0M2L/vt6SXm/JDkJbnPpRyt8QwvP28K1R03dO1ofO/WL4ukOwgldWOAe/r/5ICMHD
         kmgcS4soZEY9epH8AkfCevQoUawzkwB+PS7M/tDpo1vxMXx7h25Z8bKwRBS9CvORXr7X
         448uOh5pZ0hmd+Etw8N214d609gmZG/+XfaUA4BgoG8OTD66k8Ac2bNRlY6yh/lMm49u
         8g+Q==
X-Received: by 10.14.53.75 with SMTP id f51mr3321952eec.30.1375884055873;
        Wed, 07 Aug 2013 07:00:55 -0700 (PDT)
Received: from localhost (eduroam-69-67.uni-paderborn.de. [131.234.69.67])
        by mx.google.com with ESMTPSA id a4sm9937141eez.0.2013.08.07.07.00.54
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 07 Aug 2013 07:00:55 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc1.25.g2793d0a
In-Reply-To: <1375884049-14961-1-git-send-email-stefanbeller@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231824>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

pack-objects learns a few more options to take over what's been done
by git-repack.sh. cmd_repack() becomes a wrapper around
cmd_pack_objects().
---
 Makefile                       |   2 +-
 builtin.h                      |   1 +
 builtin/pack-objects.c         | 279 +++++++++++++++++++++++++++++++++=
+++++++-
 bulk-checkin.c                 |   2 +-
 contrib/examples/git-repack.sh | 194 ++++++++++++++++++++++++++++
 git-repack.sh                  | 194 ----------------------------
 git.c                          |   1 +
 pack-write.c                   |  13 +-
 pack.h                         |   4 +-
 9 files changed, 488 insertions(+), 202 deletions(-)
 create mode 100755 contrib/examples/git-repack.sh
 delete mode 100755 git-repack.sh

diff --git a/Makefile b/Makefile
index 3588ca1..8bd122b 100644
--- a/Makefile
+++ b/Makefile
@@ -464,7 +464,6 @@ SCRIPT_SH +=3D git-pull.sh
 SCRIPT_SH +=3D git-quiltimport.sh
 SCRIPT_SH +=3D git-rebase.sh
 SCRIPT_SH +=3D git-remote-testgit.sh
-SCRIPT_SH +=3D git-repack.sh
 SCRIPT_SH +=3D git-request-pull.sh
 SCRIPT_SH +=3D git-stash.sh
 SCRIPT_SH +=3D git-submodule.sh
@@ -596,6 +595,7 @@ BUILT_INS +=3D git-get-tar-commit-id$X
 BUILT_INS +=3D git-init$X
 BUILT_INS +=3D git-merge-subtree$X
 BUILT_INS +=3D git-peek-remote$X
+BUILT_INS +=3D git-repack$X
 BUILT_INS +=3D git-repo-config$X
 BUILT_INS +=3D git-show$X
 BUILT_INS +=3D git-stage$X
diff --git a/builtin.h b/builtin.h
index 8afa2de..b56cf07 100644
--- a/builtin.h
+++ b/builtin.h
@@ -102,6 +102,7 @@ extern int cmd_reflog(int argc, const char **argv, =
const char *prefix);
 extern int cmd_remote(int argc, const char **argv, const char *prefix)=
;
 extern int cmd_remote_ext(int argc, const char **argv, const char *pre=
fix);
 extern int cmd_remote_fd(int argc, const char **argv, const char *pref=
ix);
+extern int cmd_repack(int argc, const char **argv, const char *prefix)=
;
 extern int cmd_repo_config(int argc, const char **argv, const char *pr=
efix);
 extern int cmd_rerere(int argc, const char **argv, const char *prefix)=
;
 extern int cmd_reset(int argc, const char **argv, const char *prefix);
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index f069462..1742ea1 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -18,10 +18,17 @@
 #include "refs.h"
 #include "streaming.h"
 #include "thread-utils.h"
+#include "sigchain.h"
=20
 static const char *pack_usage[] =3D {
 	N_("git pack-objects --stdout [options...] [< ref-list | < object-lis=
t]"),
 	N_("git pack-objects [options...] base-name [< ref-list | < object-li=
st]"),
+	N_("git pack-objects --repack [options...]"),
+	NULL
+};
+
+static char const * const repack_usage[] =3D {
+	N_("git repack [options]"),
 	NULL
 };
=20
@@ -103,6 +110,15 @@ static struct object_entry *locate_object_entry(co=
nst unsigned char *sha1);
 static uint32_t written, written_delta;
 static uint32_t reused, reused_delta;
=20
+#define REPACK_IN_PROGRESS		(1 << 0)
+#define REPACK_UPDATE_INFO		(1 << 1)
+#define REPACK_ALL_INTO_ONE		(1 << 2)
+#define REPACK_REMOVE_REDUNDANT		(1 << 3)
+
+static int repack_flags, nr_written_packs;
+static int repack_usedeltabaseoffset;
+static struct string_list written_packs;
+static struct string_list backup_files;
=20
 static void *get_delta(struct object_entry *entry)
 {
@@ -792,9 +808,19 @@ static void write_pack_file(void)
 			snprintf(tmpname, sizeof(tmpname), "%s-", base_name);
 			finish_tmp_packfile(tmpname, pack_tmp_name,
 					    written_list, nr_written,
-					    &pack_idx_opts, sha1);
+					    &pack_idx_opts, sha1,
+					    repack_flags & REPACK_IN_PROGRESS ?
+					    &backup_files : NULL);
 			free(pack_tmp_name);
-			puts(sha1_to_hex(sha1));
+			if (repack_flags & REPACK_IN_PROGRESS) {
+				int len =3D strlen(tmpname);
+				char *s =3D xmalloc(len + 2);
+				memcpy(s, tmpname, len - 4);
+				memcpy(s + len - 4, ".pack", 6);
+				string_list_append(&written_packs, s);
+				nr_written_packs++;
+			} else
+				puts(sha1_to_hex(sha1));
 		}
=20
 		/* mark written objects as written to previous pack */
@@ -2359,7 +2385,8 @@ static void get_object_list(int ac, const char **=
av)
 	save_commit_buffer =3D 0;
 	setup_revisions(ac, av, &revs, NULL);
=20
-	while (fgets(line, sizeof(line), stdin) !=3D NULL) {
+	while (!(repack_flags & REPACK_IN_PROGRESS) &&
+	       fgets(line, sizeof(line), stdin) !=3D NULL) {
 		int len =3D strlen(line);
 		if (len && line[len - 1] =3D=3D '\n')
 			line[--len] =3D 0;
@@ -2387,6 +2414,30 @@ static void get_object_list(int ac, const char *=
*av)
 		loosen_unused_packed_objects(&revs);
 }
=20
+static void rollback_repack(void)
+{
+	struct strbuf dst =3D STRBUF_INIT;
+	int i, ret;
+	for (i =3D 0; i < backup_files.nr; i++) {
+		const char *src =3D backup_files.items[i].string;
+		strbuf_addstr(&dst, src);
+		strbuf_setlen(&dst, dst.len - 4); /* remove .old */
+		ret =3D rename(src, dst.buf);
+		if (ret)
+			warning("failed to restore %s: %s", src, strerror(errno));
+		strbuf_setlen(&dst, 0);
+	}
+	strbuf_release(&dst);
+	string_list_clear(&backup_files, 0);
+}
+
+static void rollback_repack_on_signal(int signo)
+{
+	rollback_repack();
+	sigchain_pop(signo);
+	raise(signo);
+}
+
 static int option_parse_index_version(const struct option *opt,
 				      const char *arg, int unset)
 {
@@ -2436,11 +2487,12 @@ static int option_parse_ulong(const struct opti=
on *opt,
=20
 int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 {
+	struct strbuf repack_base_name =3D STRBUF_INIT;
 	int use_internal_rev_list =3D 0;
 	int thin =3D 0;
 	int all_progress_implied =3D 0;
 	const char *rp_av[6];
-	int rp_ac =3D 0;
+	int i, rp_ac =3D 0;
 	int rev_list_unpacked =3D 0, rev_list_all =3D 0, rev_list_reflog =3D =
0;
 	struct option pack_objects_options[] =3D {
 		OPT_SET_INT('q', "quiet", &progress,
@@ -2505,6 +2557,16 @@ int cmd_pack_objects(int argc, const char **argv=
, const char *prefix)
 			    N_("pack compression level")),
 		OPT_SET_INT(0, "keep-true-parents", &grafts_replace_parents,
 			    N_("do not hide commits by grafts"), 0),
+
+		OPT_BIT(0, "repack", &repack_flags,
+			N_("repack mode"), REPACK_IN_PROGRESS),
+		OPT_BIT(0, "repack-all", &repack_flags,
+			N_("repack everything into one pack"), REPACK_ALL_INTO_ONE),
+		OPT_BIT(0, "remove-redundant", &repack_flags,
+			N_("remove redundant objects after repack"), REPACK_REMOVE_REDUNDAN=
T),
+		OPT_BIT(0, "update-info", &repack_flags,
+			N_("run git-update-server-info after repack"), REPACK_UPDATE_INFO),
+
 		OPT_END(),
 	};
=20
@@ -2556,6 +2618,36 @@ int cmd_pack_objects(int argc, const char **argv=
, const char *prefix)
 	if (delta_search_threads !=3D 1)
 		warning("no threads support, ignoring --threads");
 #endif
+	if ((repack_flags & REPACK_IN_PROGRESS) =3D=3D 0 &&
+	    (repack_flags & ~REPACK_IN_PROGRESS))
+		die("--repack must be given for any repack related options");
+	if (repack_flags & REPACK_IN_PROGRESS) {
+		if (pack_to_stdout)
+			die("--stdout cannot be used with --repack");
+		if (argc)
+			die("base name cannot be used with --repack");
+
+		rp_av[rp_ac++] =3D "--all";
+		rp_av[rp_ac++] =3D "--reflog";
+		use_internal_rev_list =3D 1;
+
+		grafts_replace_parents =3D 0; /* --keep-true-parents */
+		ignore_packed_keep =3D 1;	    /* --honor-pack-keep */
+		non_empty =3D 1;		    /* --non-empty */
+
+		if (!(repack_flags & REPACK_ALL_INTO_ONE)) {
+			incremental =3D 1; /* --incremental */
+			rp_av[rp_ac++] =3D "--unpacked";
+		}
+
+		strbuf_addf(&repack_base_name,
+			    "%s/pack/pack", get_object_directory());
+		base_name =3D repack_base_name.buf;
+
+		sigchain_push_common(rollback_repack_on_signal);
+		atexit(rollback_repack);
+	}
+
 	if (!pack_to_stdout && !pack_size_limit)
 		pack_size_limit =3D pack_size_limit_cfg;
 	if (pack_to_stdout && pack_size_limit)
@@ -2598,5 +2690,184 @@ int cmd_pack_objects(int argc, const char **arg=
v, const char *prefix)
 		fprintf(stderr, "Total %"PRIu32" (delta %"PRIu32"),"
 			" reused %"PRIu32" (delta %"PRIu32")\n",
 			written, written_delta, reused, reused_delta);
+
+	if (!(repack_flags & REPACK_IN_PROGRESS))
+		return 0;
+
+	if (!nr_written_packs) {
+		printf(_("Nothing new to pack.\n"));
+		return 0;
+	}
+
+	/* At this point all new packs should be in place. We can
+	   safely remove old ones */
+	for (i =3D 0; i < backup_files.nr; i++) {
+		const char *s =3D backup_files.items[i].string;
+		int ret =3D unlink(s);
+		if (ret)
+			warning("failed to remove %s: %s", s, strerror(errno));
+	}
+	string_list_clear(&backup_files, 0);
+
+	if (repack_flags & REPACK_REMOVE_REDUNDANT) {
+		struct packed_git *p;
+		struct string_list to_be_removed =3D STRING_LIST_INIT_DUP;
+
+		/* free_pack_by_name() may have freed a few packs in
+		   write_pack_file() */
+		reprepare_packed_git();
+		for (p =3D packed_git; p; p =3D p->next) {
+			if (!p->pack_local || p->pack_keep)
+				continue;
+
+			for (i =3D 0; i < written_packs.nr; i++) {
+				char *s =3D written_packs.items[i].string;
+				if (!strcmp(s, p->pack_name))
+					break;
+			}
+			if (i < written_packs.nr)
+				continue;
+
+			string_list_append(&to_be_removed, p->pack_name);
+		}
+		written_packs.strdup_strings =3D 1;
+		string_list_clear(&written_packs, 0);
+
+		for (i =3D 0; i < to_be_removed.nr; i++) {
+			char *path =3D to_be_removed.items[i].string;
+
+			/* Windows limitation on unlink().
+			   See c74faea19e39ca933492f697596310397175c329 */
+			free_pack_by_name(path);
+
+			if (unlink(path))
+				warning("failed to remove %s: %s", path, strerror(errno));
+			strcpy(path + strlen(path)-5, ".idx");
+			if (unlink(path))
+				warning("failed to remove %s: %s", path, strerror(errno));
+		}
+		string_list_clear(&to_be_removed, 0);
+
+		reprepare_packed_git();
+		prune_packed_objects(progress ? PRUNE_PACKED_VERBOSE : 0);
+	}
+
+	if (repack_flags & REPACK_UPDATE_INFO)
+		update_server_info(0);
+
 	return 0;
 }
+
+static int repack_config(const char *k, const char *v, void *cb)
+{
+	if (!strcasecmp(k, "repack.usedeltabaseoffset")) {
+		repack_usedeltabaseoffset =3D git_config_bool(k, v);
+		return 0;
+	}
+	return git_default_config(k, v, cb);
+}
+
+int cmd_repack(int argc, const char **argv, const char *prefix)
+{
+	int all_in_one =3D 0;
+	int all_in_one_and_unreachable =3D 0;
+	int unpack_unreachable =3D 0;
+	int remove_redundant =3D 0;
+	int no_reuse_delta =3D 0;
+	int no_reuse_object =3D 0;
+	int no_update =3D 0;
+	int quiet =3D 0;
+	int local =3D 0;
+
+	struct option opts[] =3D {
+		OPT_BOOL('a', NULL, &all_in_one,
+			 "pack everything in a single pack"),
+		OPT_BOOL('A', NULL, &all_in_one_and_unreachable,
+			 "same as -a, and turn unreachable objects loose"),
+		OPT_BOOL('d', NULL, &remove_redundant,
+			 "remove redundant packs, and run git-prune-packed"),
+		OPT_BOOL('f', NULL, &no_reuse_delta,
+			 "pass --no-reuse-delta to git-pack-objects"),
+		OPT_BOOL('F', NULL, &no_reuse_object,
+			 "pass --no-reuse-object to git-pack-objects"),
+		OPT_BOOL('n', NULL, &no_update,
+			 "do not run git-update-server-info"),
+		OPT_BOOL('q', NULL, &quiet, "be quiet"),
+		OPT_BOOL('l', NULL, &local,
+			 "pass --local to git-pack-objects"),
+		{ OPTION_ARGUMENT, 0, "window", NULL, "n",
+		 "size of the window used for delta compression", 0 },
+		{ OPTION_ARGUMENT, 0, "window-memory", NULL, "n",
+		  "same as the above, but limit memory size instead of entries count=
", 0 },
+		{ OPTION_ARGUMENT, 0, "depth", NULL, "n",
+		  "limits the maximum delta depth", 0 },
+		{ OPTION_ARGUMENT, 0, "max-pack-size", NULL, "n",
+		  "maximum size of each packfile", 0},
+		OPT_END(),
+	};
+
+	const char *av[] =3D { "pack-objects", "--repack",
+			     NULL, /* --[no-]update-info */
+			     NULL, /* --delta-base-offset */
+			     NULL, /* --repack-all */
+			     NULL, /* --remove-redundant */
+			     NULL, /* --no-reuse-delta */
+			     NULL, /* --no-reuse-object */
+			     NULL, /* --local */
+			     NULL, /* -q */
+			     NULL, /* --unpack-unreachable */
+			     NULL, /* --window */
+			     NULL, /* --window-memory */
+			     NULL, /* --depth */
+			     NULL, /* --max-pack-size */
+			     NULL
+	};
+	int ac =3D 2;
+
+	git_config(repack_config, NULL);
+
+	argc =3D parse_options(argc, argv, prefix, opts, repack_usage, 0);
+
+	if (no_update)
+		av[ac++] =3D "--no-update-info";
+	else
+		av[ac++] =3D "--update-info";
+	if (repack_usedeltabaseoffset)
+		av[ac++] =3D "--delta-base-offset";
+	if (all_in_one_and_unreachable) {
+		av[ac++] =3D "--repack-all";
+		all_in_one =3D 1;
+		unpack_unreachable =3D 1;
+	}
+	if (all_in_one)
+		av[ac++] =3D "--repack-all";
+	if (remove_redundant)
+		av[ac++] =3D "--remove-redundant";
+	if (no_reuse_delta)
+		av[ac++] =3D "--no-reuse-delta";
+	if (no_reuse_object)
+		av[ac++] =3D "--no-reuse-object";
+	if (local)
+		av[ac++] =3D "--local";
+	if (quiet)
+		av[ac++] =3D "-q";
+	if ((ac + argc) * sizeof(*av) > sizeof(av))
+		die("Too many options");
+	memcpy(av + ac, argv, argc * sizeof(*argv));
+	ac +=3D argc;
+
+	if (all_in_one && remove_redundant) {
+		struct packed_git *p;
+
+		prepare_packed_git();
+		for (p =3D packed_git; p; p =3D p->next) {
+			if (!p->pack_keep &&
+			    unpack_unreachable && remove_redundant) {
+				av[ac++] =3D "--unpack-unreachable";
+				break;
+			}
+		}
+	}
+
+	return cmd_pack_objects(ac, av, prefix);
+}
diff --git a/bulk-checkin.c b/bulk-checkin.c
index 6b0b6d4..3ca3c55 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -46,7 +46,7 @@ static void finish_bulk_checkin(struct bulk_checkin_s=
tate *state)
 	sprintf(packname, "%s/pack/pack-", get_object_directory());
 	finish_tmp_packfile(packname, state->pack_tmp_name,
 			    state->written, state->nr_written,
-			    &state->pack_idx_opts, sha1);
+			    &state->pack_idx_opts, sha1, NULL);
 	for (i =3D 0; i < state->nr_written; i++)
 		free(state->written[i]);
=20
diff --git a/contrib/examples/git-repack.sh b/contrib/examples/git-repa=
ck.sh
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
+OPTIONS_KEEPDASHDASH=3D
+OPTIONS_SPEC=3D"\
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
+unpack-unreachable=3D  with -A, do not loosen objects older than this
+ Packing constraints
+window=3D         size of the window used for delta compression
+window-memory=3D  same as the above, but limit memory size instead of =
entries count
+depth=3D          limits the maximum delta depth
+max-pack-size=3D  maximum size of each packfile
+"
+SUBDIRECTORY_OK=3D'Yes'
+. git-sh-setup
+
+no_update_info=3D all_into_one=3D remove_redundant=3D unpack_unreachab=
le=3D
+local=3D no_reuse=3D extra=3D
+while test $# !=3D 0
+do
+	case "$1" in
+	-n)	no_update_info=3Dt ;;
+	-a)	all_into_one=3Dt ;;
+	-A)	all_into_one=3Dt
+		unpack_unreachable=3D--unpack-unreachable ;;
+	--unpack-unreachable)
+		unpack_unreachable=3D"--unpack-unreachable=3D$2"; shift ;;
+	-d)	remove_redundant=3Dt ;;
+	-q)	GIT_QUIET=3Dt ;;
+	-f)	no_reuse=3D--no-reuse-delta ;;
+	-F)	no_reuse=3D--no-reuse-object ;;
+	-l)	local=3D--local ;;
+	--max-pack-size|--window|--window-memory|--depth)
+		extra=3D"$extra $1=3D$2"; shift ;;
+	--) shift; break;;
+	*)	usage ;;
+	esac
+	shift
+done
+
+case "`git config --bool repack.usedeltabaseoffset || echo true`" in
+true)
+	extra=3D"$extra --delta-base-offset" ;;
+esac
+
+PACKDIR=3D"$GIT_OBJECT_DIRECTORY/pack"
+PACKTMP=3D"$PACKDIR/.tmp-$$-pack"
+rm -f "$PACKTMP"-*
+trap 'rm -f "$PACKTMP"-*' 0 1 2 3 15
+
+# There will be more repacking strategies to come...
+case ",$all_into_one," in
+,,)
+	args=3D'--unpacked --incremental'
+	;;
+,t,)
+	args=3D existing=3D
+	if [ -d "$PACKDIR" ]; then
+		for e in `cd "$PACKDIR" && find . -type f -name '*.pack' \
+			| sed -e 's/^\.\///' -e 's/\.pack$//'`
+		do
+			if [ -e "$PACKDIR/$e.keep" ]; then
+				: keep
+			else
+				existing=3D"$existing $e"
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
+			args=3D"$args $(echo "$unpack_unreachable" | tr ' ' .)"
+		fi
+	fi
+	;;
+esac
+
+mkdir -p "$PACKDIR" || exit
+
+args=3D"$args $local ${GIT_QUIET:+-q} $no_reuse$extra"
+names=3D$(git pack-objects --keep-true-parents --honor-pack-keep --non=
-empty --all --reflog $args </dev/null "$PACKTMP") ||
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
+rollback=3D
+failed=3D
+for name in $names
+do
+	for sfx in pack idx
+	do
+		file=3Dpack-$name.$sfx
+		test -f "$PACKDIR/$file" || continue
+		rm -f "$PACKDIR/old-$file" &&
+		mv "$PACKDIR/$file" "$PACKDIR/old-$file" || {
+			failed=3Dt
+			break
+		}
+		rollback=3D"$rollback $file"
+	done
+	test -z "$failed" || break
+done
+
+# If renaming failed for any of them, roll the ones we have
+# already renamed back to their original names.
+if test -n "$failed"
+then
+	rollback_failure=3D
+	for file in $rollback
+	do
+		mv "$PACKDIR/old-$file" "$PACKDIR/$file" ||
+		rollback_failure=3D"$rollback_failure $file"
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
+fullbases=3D
+for name in $names
+do
+	fullbases=3D"$fullbases pack-$name"
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
+if test "$remove_redundant" =3D t
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
-OPTIONS_KEEPDASHDASH=3D
-OPTIONS_SPEC=3D"\
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
-unpack-unreachable=3D  with -A, do not loosen objects older than this
- Packing constraints
-window=3D         size of the window used for delta compression
-window-memory=3D  same as the above, but limit memory size instead of =
entries count
-depth=3D          limits the maximum delta depth
-max-pack-size=3D  maximum size of each packfile
-"
-SUBDIRECTORY_OK=3D'Yes'
-. git-sh-setup
-
-no_update_info=3D all_into_one=3D remove_redundant=3D unpack_unreachab=
le=3D
-local=3D no_reuse=3D extra=3D
-while test $# !=3D 0
-do
-	case "$1" in
-	-n)	no_update_info=3Dt ;;
-	-a)	all_into_one=3Dt ;;
-	-A)	all_into_one=3Dt
-		unpack_unreachable=3D--unpack-unreachable ;;
-	--unpack-unreachable)
-		unpack_unreachable=3D"--unpack-unreachable=3D$2"; shift ;;
-	-d)	remove_redundant=3Dt ;;
-	-q)	GIT_QUIET=3Dt ;;
-	-f)	no_reuse=3D--no-reuse-delta ;;
-	-F)	no_reuse=3D--no-reuse-object ;;
-	-l)	local=3D--local ;;
-	--max-pack-size|--window|--window-memory|--depth)
-		extra=3D"$extra $1=3D$2"; shift ;;
-	--) shift; break;;
-	*)	usage ;;
-	esac
-	shift
-done
-
-case "`git config --bool repack.usedeltabaseoffset || echo true`" in
-true)
-	extra=3D"$extra --delta-base-offset" ;;
-esac
-
-PACKDIR=3D"$GIT_OBJECT_DIRECTORY/pack"
-PACKTMP=3D"$PACKDIR/.tmp-$$-pack"
-rm -f "$PACKTMP"-*
-trap 'rm -f "$PACKTMP"-*' 0 1 2 3 15
-
-# There will be more repacking strategies to come...
-case ",$all_into_one," in
-,,)
-	args=3D'--unpacked --incremental'
-	;;
-,t,)
-	args=3D existing=3D
-	if [ -d "$PACKDIR" ]; then
-		for e in `cd "$PACKDIR" && find . -type f -name '*.pack' \
-			| sed -e 's/^\.\///' -e 's/\.pack$//'`
-		do
-			if [ -e "$PACKDIR/$e.keep" ]; then
-				: keep
-			else
-				existing=3D"$existing $e"
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
-			args=3D"$args $(echo "$unpack_unreachable" | tr ' ' .)"
-		fi
-	fi
-	;;
-esac
-
-mkdir -p "$PACKDIR" || exit
-
-args=3D"$args $local ${GIT_QUIET:+-q} $no_reuse$extra"
-names=3D$(git pack-objects --keep-true-parents --honor-pack-keep --non=
-empty --all --reflog $args </dev/null "$PACKTMP") ||
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
-rollback=3D
-failed=3D
-for name in $names
-do
-	for sfx in pack idx
-	do
-		file=3Dpack-$name.$sfx
-		test -f "$PACKDIR/$file" || continue
-		rm -f "$PACKDIR/old-$file" &&
-		mv "$PACKDIR/$file" "$PACKDIR/old-$file" || {
-			failed=3Dt
-			break
-		}
-		rollback=3D"$rollback $file"
-	done
-	test -z "$failed" || break
-done
-
-# If renaming failed for any of them, roll the ones we have
-# already renamed back to their original names.
-if test -n "$failed"
-then
-	rollback_failure=3D
-	for file in $rollback
-	do
-		mv "$PACKDIR/old-$file" "$PACKDIR/$file" ||
-		rollback_failure=3D"$rollback_failure $file"
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
-fullbases=3D
-for name in $names
-do
-	fullbases=3D"$fullbases pack-$name"
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
-if test "$remove_redundant" =3D t
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
index 2025f77..72d1dc9 100644
--- a/git.c
+++ b/git.c
@@ -397,6 +397,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "remote-ext", cmd_remote_ext },
 		{ "remote-fd", cmd_remote_fd },
 		{ "replace", cmd_replace, RUN_SETUP },
+		{ "repack", cmd_repack, RUN_SETUP },
 		{ "repo-config", cmd_repo_config, RUN_SETUP_GENTLY },
 		{ "rerere", cmd_rerere, RUN_SETUP },
 		{ "reset", cmd_reset, RUN_SETUP },
diff --git a/pack-write.c b/pack-write.c
index ca9e63b..e6aa7e3 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "pack.h"
 #include "csum-file.h"
+#include "string-list.h"
=20
 void reset_pack_idx_option(struct pack_idx_option *opts)
 {
@@ -348,10 +349,12 @@ void finish_tmp_packfile(char *name_buffer,
 			 struct pack_idx_entry **written_list,
 			 uint32_t nr_written,
 			 struct pack_idx_option *pack_idx_opts,
-			 unsigned char sha1[])
+			 unsigned char sha1[],
+			 struct string_list *backup_files)
 {
 	const char *idx_tmp_name;
 	char *end_of_name_prefix =3D strrchr(name_buffer, 0);
+	struct stat st;
=20
 	if (adjust_shared_perm(pack_tmp_name))
 		die_errno("unable to make temporary pack file readable");
@@ -368,6 +371,14 @@ void finish_tmp_packfile(char *name_buffer,
 		die_errno("unable to rename temporary pack file");
=20
 	sprintf(end_of_name_prefix, "%s.idx", sha1_to_hex(sha1));
+	if (backup_files && !stat(name_buffer, &st)) {
+		struct strbuf old =3D STRBUF_INIT;
+		strbuf_addf(&old, "%s.old", name_buffer);
+		if (rename(name_buffer, old.buf))
+			die_errno("unable to rename pack %s", name_buffer);
+		string_list_append(backup_files, strbuf_detach(&old, NULL));
+	}
+	backup_file(name_buffer);
 	if (rename(idx_tmp_name, name_buffer))
 		die_errno("unable to rename temporary index file");
=20
diff --git a/pack.h b/pack.h
index aa6ee7d..d3f92ad 100644
--- a/pack.h
+++ b/pack.h
@@ -90,7 +90,9 @@ extern int encode_in_pack_object_header(enum object_t=
ype, uintmax_t, unsigned ch
 #define PH_ERROR_PROTOCOL	(-3)
 extern int read_pack_header(int fd, struct pack_header *);
=20
+struct string_list;
+
 extern struct sha1file *create_tmp_packfile(char **pack_tmp_name);
-extern void finish_tmp_packfile(char *name_buffer, const char *pack_tm=
p_name, struct pack_idx_entry **written_list, uint32_t nr_written, stru=
ct pack_idx_option *pack_idx_opts, unsigned char sha1[]);
+extern void finish_tmp_packfile(char *name_buffer, const char *pack_tm=
p_name, struct pack_idx_entry **written_list, uint32_t nr_written, stru=
ct pack_idx_option *pack_idx_opts, unsigned char sha1[], struct string_=
list *backup_files);
=20
 #endif
--=20
1.8.4.rc1.25.g2793d0a

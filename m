From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 6/6] Build in git-repack
Date: Thu, 10 Nov 2011 14:12:35 +0700
Message-ID: <1320909155-4575-6-git-send-email-pclouds@gmail.com>
References: <1320909155-4575-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 08:12:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROOoM-0003zG-La
	for gcvg-git-2@lo.gmane.org; Thu, 10 Nov 2011 08:12:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757420Ab1KJHM2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Nov 2011 02:12:28 -0500
Received: from mail-pz0-f42.google.com ([209.85.210.42]:60943 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757378Ab1KJHM1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2011 02:12:27 -0500
Received: by pzk36 with SMTP id 36so389964pzk.1
        for <git@vger.kernel.org>; Wed, 09 Nov 2011 23:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=o0w3vq7j4z2tQqa6hVsNAGddZSZ/RSSvxcEzgWWjlkU=;
        b=xDeec9EO3T2Nm6X3Kk7aa8BA9X3ph2+SVs70qRyZKhfojl3gS7rwiqaBRPY+dyAQVj
         xhDrykGnDqJOlnVCJeGnJUt/GvOCIObt9v5+U2PL5/5aZUbpVoyGx/kecz7bdyKlEIYC
         6KyAN4PwvXH8B7MICCqSwzTfHkongbAeqcPdc=
Received: by 10.68.13.198 with SMTP id j6mr12046791pbc.48.1320909146108;
        Wed, 09 Nov 2011 23:12:26 -0800 (PST)
Received: from tre ([115.73.226.96])
        by mx.google.com with ESMTPS id d8sm19294476pbb.6.2011.11.09.23.12.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 09 Nov 2011 23:12:25 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Thu, 10 Nov 2011 14:13:08 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
In-Reply-To: <1320909155-4575-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185195>

pack-objects learns a few more options to take over what's been done
by git-repack.sh. cmd_repack() becomes a wrapper around
cmd_pack_objects().

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Makefile                       |    2 +-
 builtin.h                      |    1 +
 builtin/pack-objects.c         |  297 ++++++++++++++++++++++++++++++++=
+++++++-
 contrib/examples/git-repack.sh |  186 +++++++++++++++++++++++++
 git-repack.sh                  |  186 -------------------------
 git.c                          |    1 +
 6 files changed, 483 insertions(+), 190 deletions(-)
 create mode 100755 contrib/examples/git-repack.sh
 delete mode 100755 git-repack.sh

diff --git a/Makefile b/Makefile
index 17404c4..164052d 100644
--- a/Makefile
+++ b/Makefile
@@ -374,7 +374,6 @@ SCRIPT_SH +=3D git-mergetool.sh
 SCRIPT_SH +=3D git-pull.sh
 SCRIPT_SH +=3D git-quiltimport.sh
 SCRIPT_SH +=3D git-rebase.sh
-SCRIPT_SH +=3D git-repack.sh
 SCRIPT_SH +=3D git-request-pull.sh
 SCRIPT_SH +=3D git-stash.sh
 SCRIPT_SH +=3D git-submodule.sh
@@ -460,6 +459,7 @@ BUILT_INS +=3D git-init$X
 BUILT_INS +=3D git-merge-subtree$X
 BUILT_INS +=3D git-peek-remote$X
 BUILT_INS +=3D git-repo-config$X
+BUILT_INS +=3D git-repack$X
 BUILT_INS +=3D git-show$X
 BUILT_INS +=3D git-stage$X
 BUILT_INS +=3D git-status$X
diff --git a/builtin.h b/builtin.h
index 0a5b511..2a890ce 100644
--- a/builtin.h
+++ b/builtin.h
@@ -115,6 +115,7 @@ extern int cmd_reflog(int argc, const char **argv, =
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
index c1ca748..7acec4c 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -17,10 +17,17 @@
 #include "progress.h"
 #include "refs.h"
 #include "thread-utils.h"
+#include "sigchain.h"
=20
 static const char *pack_usage[] =3D {
 	"git pack-objects --stdout [options...] [< ref-list | < object-list]"=
,
 	"git pack-objects [options...] base-name [< ref-list | < object-list]=
",
+	"git pack-objects --repack [options...]",
+	NULL
+};
+
+static char const * const repack_usage[] =3D {
+	"git repack [options]",
 	NULL
 };
=20
@@ -101,6 +108,15 @@ static struct object_entry *locate_object_entry(co=
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
@@ -561,6 +577,19 @@ static struct object_entry **compute_write_order(v=
oid)
 	return wo;
 }
=20
+static void backup_file(const char *path)
+{
+	struct stat st;
+	if (repack_flags & REPACK_IN_PROGRESS &&
+	    !stat(path, &st)) {
+		struct strbuf old =3D STRBUF_INIT;
+		strbuf_addf(&old, "%s.old", path);
+		if (rename(path, old.buf))
+			die_errno("unable to rename pack %s", path);
+		string_list_append(&backup_files, strbuf_detach(&old, NULL));
+	}
+}
+
 static void write_pack_file(void)
 {
 	uint32_t i =3D 0, j;
@@ -632,6 +661,7 @@ static void write_pack_file(void)
 			free_pack_by_name(tmpname);
 			if (adjust_shared_perm(pack_tmp_name))
 				die_errno("unable to make temporary pack file readable");
+			backup_file(tmpname);
 			if (rename(pack_tmp_name, tmpname))
 				die_errno("unable to rename temporary pack file");
=20
@@ -660,12 +690,22 @@ static void write_pack_file(void)
 				 base_name, sha1_to_hex(sha1));
 			if (adjust_shared_perm(idx_tmp_name))
 				die_errno("unable to make temporary index file readable");
+			backup_file(tmpname);
 			if (rename(idx_tmp_name, tmpname))
 				die_errno("unable to rename temporary index file");
=20
 			free((void *) idx_tmp_name);
 			free(pack_tmp_name);
-			puts(sha1_to_hex(sha1));
+			if (repack_flags & REPACK_IN_PROGRESS) {
+				int len =3D strlen(tmpname);
+				char *s =3D xmalloc(len + 2);
+				memcpy(s, tmpname, len - 4);
+				memcpy(s + len - 4, ".pack", 6);
+				string_list_append(&written_packs, s);
+				nr_written_packs++;
+			}
+			else
+				puts(sha1_to_hex(sha1));
 		}
=20
 		/* mark written objects as written to previous pack */
@@ -2222,7 +2262,8 @@ static void get_object_list(int ac, const char **=
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
@@ -2250,6 +2291,31 @@ static void get_object_list(int ac, const char *=
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
+
 static int option_parse_index_version(const struct option *opt,
 				      const char *arg, int unset)
 {
@@ -2267,12 +2333,14 @@ static int option_parse_index_version(const str=
uct option *opt,
=20
 int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 {
+	struct strbuf repack_base_name =3D STRBUF_INIT;
 	int use_internal_rev_list =3D 0;
 	int thin =3D 0;
 	int all_progress_implied =3D 0;
 	const char **rp_av;
 	int rp_ac_alloc =3D 64;
 	int rp_ac;
+	int i;
 	struct option pack_objects_options[] =3D {
 		OPT_SET_INT('q', NULL, &progress,
 			    "do not show progress meter", 0),
@@ -2328,6 +2396,16 @@ int cmd_pack_objects(int argc, const char **argv=
, const char *prefix)
 			    "pack compression level"),
 		OPT_SET_INT(0, "keep-true-parents", &grafts_replace_parents,
 			    "do not hide commits by grafts", 0),
+
+		OPT_BIT(0, "repack", &repack_flags,
+			"repack mode", REPACK_IN_PROGRESS),
+		OPT_BIT(0, "repack-all", &repack_flags,
+			"repack everything into one pack", REPACK_ALL_INTO_ONE),
+		OPT_BIT(0, "remove-redundant", &repack_flags,
+			"remove redundant objects after repack", REPACK_REMOVE_REDUNDANT),
+		OPT_BIT(0, "update-info", &repack_flags,
+			"run git-update-server-info after repack", REPACK_UPDATE_INFO),
+
 		OPT_END(),
 	};
=20
@@ -2374,6 +2452,39 @@ int cmd_pack_objects(int argc, const char **argv=
, const char *prefix)
 	if (delta_search_threads !=3D 1)
 		warning("no threads support, ignoring %s", arg);
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
+		if (rp_ac + 2 >=3D rp_ac_alloc) {
+			rp_ac_alloc =3D alloc_nr(rp_ac_alloc);
+			rp_av =3D xrealloc(rp_av, rp_ac_alloc * sizeof(*rp_av));
+		}
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
=20
 	/* Traditionally "pack-objects [options] base extra" failed;
 	 * we would however want to take refs parameter that would
@@ -2388,7 +2499,7 @@ int cmd_pack_objects(int argc, const char **argv,=
 const char *prefix)
 	 * walker.
 	 */
=20
-	if (!pack_to_stdout) {
+	else if (!pack_to_stdout) {
 		if (!argc)
 			die("base name required if --stdout is not given");
 		base_name =3D argv[0];
@@ -2439,5 +2550,185 @@ int cmd_pack_objects(int argc, const char **arg=
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
+		prune_packed_objects(0);
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
+	trace_argv_printf(av, "trace: built-in: git");
+	return cmd_pack_objects(ac, av, prefix);
+}
diff --git a/contrib/examples/git-repack.sh b/contrib/examples/git-repa=
ck.sh
new file mode 100755
index 0000000..624feec
--- /dev/null
+++ b/contrib/examples/git-repack.sh
@@ -0,0 +1,186 @@
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
+			args=3D"$args $unpack_unreachable"
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
index 624feec..0000000
--- a/git-repack.sh
+++ /dev/null
@@ -1,186 +0,0 @@
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
-			args=3D"$args $unpack_unreachable"
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
index 8e34903..05235ca 100644
--- a/git.c
+++ b/git.c
@@ -410,6 +410,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "remote-ext", cmd_remote_ext },
 		{ "remote-fd", cmd_remote_fd },
 		{ "replace", cmd_replace, RUN_SETUP },
+		{ "repack", cmd_repack, RUN_SETUP },
 		{ "repo-config", cmd_repo_config, RUN_SETUP_GENTLY },
 		{ "rerere", cmd_rerere, RUN_SETUP },
 		{ "reset", cmd_reset, RUN_SETUP },
--=20
1.7.4.74.g639db

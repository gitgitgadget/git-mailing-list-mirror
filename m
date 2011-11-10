From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/6] pack-objects: use parse_options()
Date: Thu, 10 Nov 2011 14:12:33 +0700
Message-ID: <1320909155-4575-4-git-send-email-pclouds@gmail.com>
References: <1320909155-4575-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 08:12:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROOo9-0003ru-Hm
	for gcvg-git-2@lo.gmane.org; Thu, 10 Nov 2011 08:12:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757404Ab1KJHMP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Nov 2011 02:12:15 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:49192 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757378Ab1KJHMN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2011 02:12:13 -0500
Received: by yenr9 with SMTP id r9so1577597yen.19
        for <git@vger.kernel.org>; Wed, 09 Nov 2011 23:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=P3AjaKtyAem+5mh4BFiuVvqIm8X4xwQiJ7X+WdKNoDc=;
        b=lWLyalmMn9SsaCEw1xuEsXCloApStQZKUbCensVQULA7ywesQaEHrJKdagKk9FQPsX
         oK/vWFZVU910JBNZ1jYIX1d97+1Jytls1zJ4MvgzwyJj2DVxj2aJBiK3hxysappAtWdl
         OnA2CwIdx6JuX2pgmWKBboRdFVt00nvGwalVk=
Received: by 10.68.199.167 with SMTP id jl7mr12121386pbc.70.1320909132523;
        Wed, 09 Nov 2011 23:12:12 -0800 (PST)
Received: from tre ([115.73.226.96])
        by mx.google.com with ESMTPS id g8sm979010pbe.11.2011.11.09.23.12.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 09 Nov 2011 23:12:11 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Thu, 10 Nov 2011 14:12:55 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
In-Reply-To: <1320909155-4575-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185193>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 There is a side effect of this conversion: --window and --depth now
 can take units because git_parse_ulong() is always used by
 OPTION_ULONG

 builtin/pack-objects.c |  276 +++++++++++++++++++---------------------=
--------
 1 files changed, 110 insertions(+), 166 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 2b18de5..c1ca748 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -18,16 +18,11 @@
 #include "refs.h"
 #include "thread-utils.h"
=20
-static const char pack_usage[] =3D
-  "git pack-objects [ -q | --progress | --all-progress ]\n"
-  "        [--all-progress-implied]\n"
-  "        [--max-pack-size=3D<n>] [--local] [--incremental]\n"
-  "        [--window=3D<n>] [--window-memory=3D<n>] [--depth=3D<n>]\n"
-  "        [--no-reuse-delta] [--no-reuse-object] [--delta-base-offset=
]\n"
-  "        [--threads=3D<n>] [--non-empty] [--revs [--unpacked | --all=
]]\n"
-  "        [--reflog] [--stdout | base-name] [--include-tag]\n"
-  "        [--keep-unreachable | --unpack-unreachable]\n"
-  "        [< ref-list | < object-list]";
+static const char *pack_usage[] =3D {
+	"git pack-objects --stdout [options...] [< ref-list | < object-list]"=
,
+	"git pack-objects [options...] base-name [< ref-list | < object-list]=
",
+	NULL
+};
=20
 struct object_entry {
 	struct pack_idx_entry idx;
@@ -2255,15 +2250,86 @@ static void get_object_list(int ac, const char =
**av)
 		loosen_unused_packed_objects(&revs);
 }
=20
+static int option_parse_index_version(const struct option *opt,
+				      const char *arg, int unset)
+{
+	char *c;
+	const char *val =3D arg;
+	pack_idx_opts.version =3D strtoul(val, &c, 10);
+	if (pack_idx_opts.version > 2)
+		die("bad %s", val);
+	if (*c =3D=3D ',')
+		pack_idx_opts.off32_limit =3D strtoul(c+1, &c, 0);
+	if (*c || pack_idx_opts.off32_limit & 0x80000000)
+		die("bad %s", val);
+	return 0;
+}
+
 int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 {
 	int use_internal_rev_list =3D 0;
 	int thin =3D 0;
 	int all_progress_implied =3D 0;
-	uint32_t i;
 	const char **rp_av;
 	int rp_ac_alloc =3D 64;
 	int rp_ac;
+	struct option pack_objects_options[] =3D {
+		OPT_SET_INT('q', NULL, &progress,
+			    "do not show progress meter", 0),
+		OPT_SET_INT(0, "progress", &progress,
+			    "show progress meter", 1),
+		OPT_SET_INT(0, "all-progress", &progress,
+			    "show progress meter during object writing phase", 2),
+		OPT_BOOL(0, "all-progress-implied",
+			 &all_progress_implied,
+			 "similar to --all-progress when progress meter is shown"),
+		{ OPTION_CALLBACK, 0, "index-version", NULL, "version",
+		  "force generating pack index at a particular version",
+		  0, option_parse_index_version },
+		OPT_ULONG(0, "max-pack-size", &pack_size_limit,
+			  "maximum size of each output pack file"),
+		OPT_BOOL(0, "local", &local,
+			 "ignore borrowed objects from alternate object store"),
+		OPT_BOOL(0, "incremental", &incremental,
+			 "ignore packed objects"),
+		OPT_ULONG(0, "window", &window, "limit pack window by objects"),
+		OPT_ULONG(0, "window-memory", &window_memory_limit,
+			  "limit pack window by memory"),
+		OPT_INTEGER(0, "depth", &depth,
+			    "limit pack window by maximum delta depth"),
+		OPT_BOOL(0, "reuse-delta", &reuse_delta,
+			 "reusing existing deltas"),
+		OPT_BOOL(0, "reuse-object", &reuse_object,
+			 "reusing existing objects"),
+		OPT_BOOL(0, "delta-base-offset", &allow_ofs_delta,
+			 "use OFS_DELTA objects"),
+		OPT_INTEGER(0, "threads", &delta_search_threads,
+			    "use threads when searching for best delta matches"),
+		OPT_BOOL(0, "non-empty", &non_empty,
+			 "only create if it would contain at least one object"),
+		OPT_BOOL(0, "revs", &use_internal_rev_list,
+			 "read revision arguments from standard output"),
+		OPT_ARGUMENT("unpacked", "limit the objects to those that are not al=
ready packed"),
+		OPT_ARGUMENT("all", "include all refs under $GIT_DIR/refs directory"=
),
+		OPT_ARGUMENT("reflog", "include objects referred by reflog entries")=
,
+		OPT_BOOL(0, "stdout", &pack_to_stdout,
+			 "output pack to stdout"),
+		OPT_BOOL(0, "include-tag", &include_tag,
+			 "include unasked-for annotated tags"),
+		OPT_BOOL(0, "keep-unreachable", &keep_unreachable,
+			 "keep unreachable objects"),
+		OPT_BOOL(0, "unpack-unreachable", &unpack_unreachable,
+			 "unpack unreachable objects"),
+		OPT_BOOL(0, "thin", &thin,
+			 "create thin packs"),
+		OPT_BOOL(0, "honor-pack-keep", &ignore_packed_keep,
+			 "ignore packs that have companion .keep file"),
+		OPT_INTEGER(0, "compression", &pack_compression_level,
+			    "pack compression level"),
+		OPT_SET_INT(0, "keep-true-parents", &grafts_replace_parents,
+			    "do not hide commits by grafts", 0),
+		OPT_END(),
+	};
=20
 	read_replace_refs =3D 0;
=20
@@ -2279,160 +2345,35 @@ int cmd_pack_objects(int argc, const char **ar=
gv, const char *prefix)
 		pack_compression_level =3D core_compression_level;
=20
 	progress =3D isatty(2);
-	for (i =3D 1; i < argc; i++) {
-		const char *arg =3D argv[i];
-
-		if (*arg !=3D '-')
-			break;
+	argc =3D parse_options(argc, argv, prefix, pack_objects_options,
+			     pack_usage, 0);
=20
-		if (!strcmp("--non-empty", arg)) {
-			non_empty =3D 1;
-			continue;
-		}
-		if (!strcmp("--local", arg)) {
-			local =3D 1;
-			continue;
-		}
-		if (!strcmp("--incremental", arg)) {
-			incremental =3D 1;
-			continue;
-		}
-		if (!strcmp("--honor-pack-keep", arg)) {
-			ignore_packed_keep =3D 1;
-			continue;
-		}
-		if (!prefixcmp(arg, "--compression=3D")) {
-			char *end;
-			int level =3D strtoul(arg+14, &end, 0);
-			if (!arg[14] || *end)
-				usage(pack_usage);
-			if (level =3D=3D -1)
-				level =3D Z_DEFAULT_COMPRESSION;
-			else if (level < 0 || level > Z_BEST_COMPRESSION)
-				die("bad pack compression level %d", level);
-			pack_compression_level =3D level;
-			continue;
+	while (argc && argv[0][0] =3D=3D '-') {
+		use_internal_rev_list =3D 1;
+		if (rp_ac >=3D rp_ac_alloc - 1) {
+			rp_ac_alloc =3D alloc_nr(rp_ac_alloc);
+			rp_av =3D xrealloc(rp_av,
+					 rp_ac_alloc * sizeof(*rp_av));
 		}
-		if (!prefixcmp(arg, "--max-pack-size=3D")) {
-			pack_size_limit_cfg =3D 0;
-			if (!git_parse_ulong(arg+16, &pack_size_limit))
-				usage(pack_usage);
-			continue;
-		}
-		if (!prefixcmp(arg, "--window=3D")) {
-			char *end;
-			window =3D strtoul(arg+9, &end, 0);
-			if (!arg[9] || *end)
-				usage(pack_usage);
-			continue;
-		}
-		if (!prefixcmp(arg, "--window-memory=3D")) {
-			if (!git_parse_ulong(arg+16, &window_memory_limit))
-				usage(pack_usage);
-			continue;
-		}
-		if (!prefixcmp(arg, "--threads=3D")) {
-			char *end;
-			delta_search_threads =3D strtoul(arg+10, &end, 0);
-			if (!arg[10] || *end || delta_search_threads < 0)
-				usage(pack_usage);
+		rp_av[rp_ac++] =3D *argv;
+		argv++;
+		argc--;
+	}
+
+	if (!reuse_object)
+		reuse_delta =3D 0;
+	if (thin) {
+		use_internal_rev_list =3D 1;
+		rp_av[1] =3D "--objects-edge";
+	}
+	if (pack_compression_level =3D=3D -1)
+		pack_compression_level =3D Z_DEFAULT_COMPRESSION;
+	else if (pack_compression_level < 0 || pack_compression_level > Z_BES=
T_COMPRESSION)
+		die("bad pack compression level %d", pack_compression_level);
 #ifdef NO_PTHREADS
-			if (delta_search_threads !=3D 1)
-				warning("no threads support, "
-					"ignoring %s", arg);
+	if (delta_search_threads !=3D 1)
+		warning("no threads support, ignoring %s", arg);
 #endif
-			continue;
-		}
-		if (!prefixcmp(arg, "--depth=3D")) {
-			char *end;
-			depth =3D strtoul(arg+8, &end, 0);
-			if (!arg[8] || *end)
-				usage(pack_usage);
-			continue;
-		}
-		if (!strcmp("--progress", arg)) {
-			progress =3D 1;
-			continue;
-		}
-		if (!strcmp("--all-progress", arg)) {
-			progress =3D 2;
-			continue;
-		}
-		if (!strcmp("--all-progress-implied", arg)) {
-			all_progress_implied =3D 1;
-			continue;
-		}
-		if (!strcmp("-q", arg)) {
-			progress =3D 0;
-			continue;
-		}
-		if (!strcmp("--no-reuse-delta", arg)) {
-			reuse_delta =3D 0;
-			continue;
-		}
-		if (!strcmp("--no-reuse-object", arg)) {
-			reuse_object =3D reuse_delta =3D 0;
-			continue;
-		}
-		if (!strcmp("--delta-base-offset", arg)) {
-			allow_ofs_delta =3D 1;
-			continue;
-		}
-		if (!strcmp("--stdout", arg)) {
-			pack_to_stdout =3D 1;
-			continue;
-		}
-		if (!strcmp("--revs", arg)) {
-			use_internal_rev_list =3D 1;
-			continue;
-		}
-		if (!strcmp("--keep-unreachable", arg)) {
-			keep_unreachable =3D 1;
-			continue;
-		}
-		if (!strcmp("--unpack-unreachable", arg)) {
-			unpack_unreachable =3D 1;
-			continue;
-		}
-		if (!strcmp("--include-tag", arg)) {
-			include_tag =3D 1;
-			continue;
-		}
-		if (!strcmp("--unpacked", arg) ||
-		    !strcmp("--reflog", arg) ||
-		    !strcmp("--all", arg)) {
-			use_internal_rev_list =3D 1;
-			if (rp_ac >=3D rp_ac_alloc - 1) {
-				rp_ac_alloc =3D alloc_nr(rp_ac_alloc);
-				rp_av =3D xrealloc(rp_av,
-						 rp_ac_alloc * sizeof(*rp_av));
-			}
-			rp_av[rp_ac++] =3D arg;
-			continue;
-		}
-		if (!strcmp("--thin", arg)) {
-			use_internal_rev_list =3D 1;
-			thin =3D 1;
-			rp_av[1] =3D "--objects-edge";
-			continue;
-		}
-		if (!prefixcmp(arg, "--index-version=3D")) {
-			char *c;
-			pack_idx_opts.version =3D strtoul(arg + 16, &c, 10);
-			if (pack_idx_opts.version > 2)
-				die("bad %s", arg);
-			if (*c =3D=3D ',')
-				pack_idx_opts.off32_limit =3D strtoul(c+1, &c, 0);
-			if (*c || pack_idx_opts.off32_limit & 0x80000000)
-				die("bad %s", arg);
-			continue;
-		}
-		if (!strcmp(arg, "--keep-true-parents")) {
-			grafts_replace_parents =3D 0;
-			continue;
-		}
-		usage(pack_usage);
-	}
=20
 	/* Traditionally "pack-objects [options] base extra" failed;
 	 * we would however want to take refs parameter that would
@@ -2447,11 +2388,14 @@ int cmd_pack_objects(int argc, const char **arg=
v, const char *prefix)
 	 * walker.
 	 */
=20
-	if (!pack_to_stdout)
-		base_name =3D argv[i++];
-
-	if (pack_to_stdout !=3D !base_name)
-		usage(pack_usage);
+	if (!pack_to_stdout) {
+		if (!argc)
+			die("base name required if --stdout is not given");
+		base_name =3D argv[0];
+		argc--;
+	}
+	if (argc)
+		die("base name or --stdout are mutually exclusive");
=20
 	if (!pack_to_stdout && !pack_size_limit)
 		pack_size_limit =3D pack_size_limit_cfg;
--=20
1.7.4.74.g639db

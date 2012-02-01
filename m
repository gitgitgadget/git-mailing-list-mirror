From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 3/3] pack-objects: convert to use parse_options()
Date: Wed,  1 Feb 2012 22:17:20 +0700
Message-ID: <1328109440-9510-3-git-send-email-pclouds@gmail.com>
References: <1328017702-14489-1-git-send-email-pclouds@gmail.com>
 <1328109440-9510-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 01 16:14:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rsbt4-0006qu-6c
	for gcvg-git-2@plane.gmane.org; Wed, 01 Feb 2012 16:14:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123Ab2BAPOM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Feb 2012 10:14:12 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:63338 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932095Ab2BAPOL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2012 10:14:11 -0500
Received: by mail-pw0-f46.google.com with SMTP id u11so1154333pbd.19
        for <git@vger.kernel.org>; Wed, 01 Feb 2012 07:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=I3GnSBGOnBnc6D5xFB/G0IeIfperOWQDkMhu54knur0=;
        b=sSkaYeHoSBsXDdi8J7sPxFqLONp2CLDOubD7tF3CgRiLt9NQYuEOCDRapMyq7+QgxA
         3e/uQuZemW9MyAKK606usM0Es3vcAOegZKzCnAwd+t8J4Fgl5KvdJirZiflLKWS/FVkB
         XMDt9gU6MCkjeWButCF8EbLASrkee7IqEc858=
Received: by 10.68.193.167 with SMTP id hp7mr60253673pbc.3.1328109250674;
        Wed, 01 Feb 2012 07:14:10 -0800 (PST)
Received: from tre ([115.74.57.120])
        by mx.google.com with ESMTPS id x6sm35457660pbf.7.2012.02.01.07.14.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 01 Feb 2012 07:14:08 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Wed, 01 Feb 2012 22:17:47 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1328109440-9510-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189516>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Regarding die() vs error() in option_parse_*, nope, using error()
 makes parse_options() print command usage, which is long and distracts
 users from the real error message. I'm going to stick with die().

 builtin/pack-objects.c |  315 +++++++++++++++++++++-------------------=
--------
 1 files changed, 139 insertions(+), 176 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 80e3114..e21e5af 100644
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
@@ -2305,191 +2300,159 @@ static void get_object_list(int ac, const cha=
r **av)
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
+		die(_("unsupported index version %s"), val);
+	if (*c =3D=3D ',' && c[1])
+		pack_idx_opts.off32_limit =3D strtoul(c+1, &c, 0);
+	if (*c || pack_idx_opts.off32_limit & 0x80000000)
+		die(_("bad index version '%s'"), val);
+	return 0;
+}
+
+static int option_parse_ulong(const struct option *opt,
+			      const char *arg, int unset)
+{
+	if (unset)
+		die(_("option %s does not accept negative form"),
+		    opt->long_name);
+
+	if (!git_parse_ulong(arg, opt->value))
+		die(_("unable to parse value '%s' for option %s"),
+		    arg, opt->long_name);
+	return 0;
+}
+
+#define OPT_ULONG(s, l, v, h) \
+	{ OPTION_CALLBACK, (s), (l), (v), "n", (h),	\
+	  PARSE_OPT_NONEG, option_parse_ulong }
+
 int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 {
 	int use_internal_rev_list =3D 0;
 	int thin =3D 0;
 	int all_progress_implied =3D 0;
-	uint32_t i;
-	const char **rp_av;
-	int rp_ac_alloc =3D 64;
-	int rp_ac;
+	const char *rp_av[6];
+	int rp_ac =3D 0;
+	int rev_list_unpacked =3D 0, rev_list_all =3D 0, rev_list_reflog =3D =
0;
+	struct option pack_objects_options[] =3D {
+		OPT_SET_INT('q', "quiet", &progress,
+			    "do not show progress meter", 0),
+		OPT_SET_INT(0, "progress", &progress,
+			    "show progress meter", 1),
+		OPT_SET_INT(0, "all-progress", &progress,
+			    "show progress meter during object writing phase", 2),
+		OPT_BOOL(0, "all-progress-implied",
+			 &all_progress_implied,
+			 "similar to --all-progress when progress meter is shown"),
+		{ OPTION_CALLBACK, 0, "index-version", NULL, "version[,offset]",
+		  "write the pack index file in the specified idx format version",
+		  0, option_parse_index_version },
+		OPT_ULONG(0, "max-pack-size", &pack_size_limit,
+			  "maximum size of each output pack file"),
+		OPT_BOOL(0, "local", &local,
+			 "ignore borrowed objects from alternate object store"),
+		OPT_BOOL(0, "incremental", &incremental,
+			 "ignore packed objects"),
+		OPT_INTEGER(0, "window", &window,
+			    "limit pack window by objects"),
+		OPT_ULONG(0, "window-memory", &window_memory_limit,
+			  "limit pack window by memory in addition to object limit"),
+		OPT_INTEGER(0, "depth", &depth,
+			    "maximum length of delta chain allowed in the resulting pack"),
+		OPT_BOOL(0, "reuse-delta", &reuse_delta,
+			 "reuse existing deltas"),
+		OPT_BOOL(0, "reuse-object", &reuse_object,
+			 "reuse existing objects"),
+		OPT_BOOL(0, "delta-base-offset", &allow_ofs_delta,
+			 "use OFS_DELTA objects"),
+		OPT_INTEGER(0, "threads", &delta_search_threads,
+			    "use threads when searching for best delta matches"),
+		OPT_BOOL(0, "non-empty", &non_empty,
+			 "do not create an empty pack output"),
+		OPT_BOOL(0, "revs", &use_internal_rev_list,
+			 "read revision arguments from standard input"),
+		{ OPTION_SET_INT, 0, "unpacked", &rev_list_unpacked, NULL,
+		  "limit the objects to those that are not yet packed",
+		  PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, 1 },
+		{ OPTION_SET_INT, 0, "all", &rev_list_all, NULL,
+		  "include objects reachable from any reference",
+		  PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, 1 },
+		{ OPTION_SET_INT, 0, "reflog", &rev_list_reflog, NULL,
+		  "include objects referred by reflog entries",
+		  PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, 1 },
+		OPT_BOOL(0, "stdout", &pack_to_stdout,
+			 "output pack to stdout"),
+		OPT_BOOL(0, "include-tag", &include_tag,
+			 "include tag objects that refer to objects to be packed"),
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
-	rp_av =3D xcalloc(rp_ac_alloc, sizeof(*rp_av));
-
-	rp_av[0] =3D "pack-objects";
-	rp_av[1] =3D "--objects"; /* --thin will make it --objects-edge */
-	rp_ac =3D 2;
-
 	reset_pack_idx_option(&pack_idx_opts);
 	git_config(git_pack_config, NULL);
 	if (!pack_compression_seen && core_compression_seen)
 		pack_compression_level =3D core_compression_level;
=20
 	progress =3D isatty(2);
-	for (i =3D 1; i < argc; i++) {
-		const char *arg =3D argv[i];
+	argc =3D parse_options(argc, argv, prefix, pack_objects_options,
+			     pack_usage, 0);
=20
-		if (*arg !=3D '-')
-			break;
-
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
-		}
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
-#ifdef NO_PTHREADS
-			if (delta_search_threads !=3D 1)
-				warning("no threads support, "
-					"ignoring %s", arg);
-#endif
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
-			if (*c =3D=3D ',' && c[1])
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
+	if (argc) {
+		base_name =3D argv[0];
+		argc--;
 	}
+	if (pack_to_stdout !=3D !base_name || argc)
+		usage_with_options(pack_usage, pack_objects_options);
=20
-	if (!pack_to_stdout)
-		base_name =3D argv[i++];
+	rp_av[rp_ac++] =3D "pack-objects";
+	if (thin) {
+		use_internal_rev_list =3D 1;
+		rp_av[rp_ac++] =3D "--objects-edge";
+	} else
+		rp_av[rp_ac++] =3D "--objects";
=20
-	if (pack_to_stdout !=3D !base_name || argv[i])
-		usage(pack_usage);
+	if (rev_list_all) {
+		use_internal_rev_list =3D 1;
+		rp_av[rp_ac++] =3D "--all";
+	}
+	if (rev_list_reflog) {
+		use_internal_rev_list =3D 1;
+		rp_av[rp_ac++] =3D "--reflog";
+	}
+	if (rev_list_unpacked) {
+		use_internal_rev_list =3D 1;
+		rp_av[rp_ac++] =3D "--unpacked";
+	}
=20
+	if (!reuse_object)
+		reuse_delta =3D 0;
+	if (pack_compression_level =3D=3D -1)
+		pack_compression_level =3D Z_DEFAULT_COMPRESSION;
+	else if (pack_compression_level < 0 || pack_compression_level > Z_BES=
T_COMPRESSION)
+		die("bad pack compression level %d", pack_compression_level);
+#ifdef NO_PTHREADS
+	if (delta_search_threads !=3D 1)
+		warning("no threads support, ignoring %s", arg);
+#endif
 	if (!pack_to_stdout && !pack_size_limit)
 		pack_size_limit =3D pack_size_limit_cfg;
 	if (pack_to_stdout && pack_size_limit)
--=20
1.7.8.36.g69ee2

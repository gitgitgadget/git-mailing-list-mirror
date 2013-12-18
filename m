From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 02/12] Convert starts_with() to skip_prefix() for option parsing
Date: Wed, 18 Dec 2013 21:53:47 +0700
Message-ID: <1387378437-20646-3-git-send-email-pclouds@gmail.com>
References: <1387378437-20646-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 18 15:54:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtIW1-0003Hl-A9
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 15:54:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754966Ab3LROyS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Dec 2013 09:54:18 -0500
Received: from mail-pd0-f174.google.com ([209.85.192.174]:62422 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754703Ab3LROyQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Dec 2013 09:54:16 -0500
Received: by mail-pd0-f174.google.com with SMTP id x10so151435pdj.5
        for <git@vger.kernel.org>; Wed, 18 Dec 2013 06:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=EWIdZ/IHoUcKfqVyIPZ1FRupSv3QVR9mR8DRls9yubE=;
        b=uH9qBm6WEhXgZAtx7sl11vHXhPSK2q0NfT3+5gPUHAKgURLFUPNPDuqaErKXLJmCkT
         FQRcAvnJ2ciDGaZyFIcjqjW1zcaK6I2KnyQY18faOfysk1qypqqLdNcT4oSOUrBWzfZI
         ndC9YxlIpzgMYN/n9byeSV9B4d13LEjInM/W7wP0+a2xY308O9TdX6aCAiCCgbBY5J+n
         +EvQ6w75QJIuSvjaeij770jLQ+6TJfYfkcA2zA35N8pWQI4bAHfPrU1WMO1FfEUmZzZW
         PBkvmXs+qeT2uCzaGDrLSPdnXqb/0s/g2yx6EPWU//7/Hq3PRiNe6yEipIBAAhQSi012
         /npw==
X-Received: by 10.68.191.106 with SMTP id gx10mr34728129pbc.47.1387378455761;
        Wed, 18 Dec 2013 06:54:15 -0800 (PST)
Received: from lanh ([115.73.220.136])
        by mx.google.com with ESMTPSA id ki1sm584598pbd.1.2013.12.18.06.54.12
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 18 Dec 2013 06:54:15 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 18 Dec 2013 21:54:11 +0700
X-Mailer: git-send-email 1.8.5.1.208.g019362e
In-Reply-To: <1387378437-20646-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239440>

The code that's not converted to use parse_options() often does

  if (!starts_with(arg, "foo=3D")) {
     value =3D atoi(arg + 4);
  }

This patch removes those magic numbers with skip_prefix()

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/fetch-pack.c     | 13 +++++----
 builtin/index-pack.c     | 17 +++++------
 builtin/ls-remote.c      |  9 +++---
 builtin/mailinfo.c       |  5 ++--
 builtin/reflog.c         |  9 +++---
 builtin/rev-parse.c      | 41 +++++++++++++-------------
 builtin/send-pack.c      | 18 ++++++------
 builtin/unpack-objects.c |  5 ++--
 builtin/update-ref.c     | 21 +++++++-------
 daemon.c                 | 75 ++++++++++++++++++++++++----------------=
--------
 diff.c                   | 49 +++++++++++++++----------------
 git.c                    | 13 +++++----
 merge-recursive.c        | 13 +++++----
 revision.c               | 60 +++++++++++++++++++-------------------
 upload-pack.c            |  5 ++--
 15 files changed, 182 insertions(+), 171 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 8b8978a2..2df1423 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -47,13 +47,14 @@ int cmd_fetch_pack(int argc, const char **argv, con=
st char *prefix)
=20
 	for (i =3D 1; i < argc && *argv[i] =3D=3D '-'; i++) {
 		const char *arg =3D argv[i];
+		const char *optarg;
=20
-		if (starts_with(arg, "--upload-pack=3D")) {
-			args.uploadpack =3D arg + 14;
+		if ((optarg =3D skip_prefix(arg, "--upload-pack=3D")) !=3D NULL) {
+			args.uploadpack =3D optarg;
 			continue;
 		}
-		if (starts_with(arg, "--exec=3D")) {
-			args.uploadpack =3D arg + 7;
+		if ((optarg =3D skip_prefix(arg, "--exec=3D")) !=3D NULL) {
+			args.uploadpack =3D optarg;
 			continue;
 		}
 		if (!strcmp("--quiet", arg) || !strcmp("-q", arg)) {
@@ -89,8 +90,8 @@ int cmd_fetch_pack(int argc, const char **argv, const=
 char *prefix)
 			args.verbose =3D 1;
 			continue;
 		}
-		if (starts_with(arg, "--depth=3D")) {
-			args.depth =3D strtol(arg + 8, NULL, 0);
+		if ((optarg =3D skip_prefix(arg, "--depth=3D")) !=3D NULL) {
+			args.depth =3D strtol(optarg, NULL, 0);
 			continue;
 		}
 		if (!strcmp("--no-progress", arg)) {
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 2f37a38..67eff7a 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1511,6 +1511,7 @@ int cmd_index_pack(int argc, const char **argv, c=
onst char *prefix)
=20
 	for (i =3D 1; i < argc; i++) {
 		const char *arg =3D argv[i];
+		const char *optarg;
=20
 		if (*arg =3D=3D '-') {
 			if (!strcmp(arg, "--stdin")) {
@@ -1534,11 +1535,11 @@ int cmd_index_pack(int argc, const char **argv,=
 const char *prefix)
 				stat_only =3D 1;
 			} else if (!strcmp(arg, "--keep")) {
 				keep_msg =3D "";
-			} else if (starts_with(arg, "--keep=3D")) {
-				keep_msg =3D arg + 7;
-			} else if (starts_with(arg, "--threads=3D")) {
+			} else if ((optarg =3D skip_prefix(arg, "--keep=3D")) !=3D NULL) {
+				keep_msg =3D optarg;
+			} else if ((optarg =3D skip_prefix(arg, "--threads=3D")) !=3D NULL)=
 {
 				char *end;
-				nr_threads =3D strtoul(arg+10, &end, 0);
+				nr_threads =3D strtoul(optarg, &end, 0);
 				if (!arg[10] || *end || nr_threads < 0)
 					usage(index_pack_usage);
 #ifdef NO_PTHREADS
@@ -1547,13 +1548,13 @@ int cmd_index_pack(int argc, const char **argv,=
 const char *prefix)
 						  "ignoring %s"), arg);
 				nr_threads =3D 1;
 #endif
-			} else if (starts_with(arg, "--pack_header=3D")) {
+			} else if ((optarg =3D skip_prefix(arg, "--pack_header=3D")) !=3D N=
ULL) {
 				struct pack_header *hdr;
 				char *c;
=20
 				hdr =3D (struct pack_header *)input_buffer;
 				hdr->hdr_signature =3D htonl(PACK_SIGNATURE);
-				hdr->hdr_version =3D htonl(strtoul(arg + 14, &c, 10));
+				hdr->hdr_version =3D htonl(strtoul(optarg, &c, 10));
 				if (*c !=3D ',')
 					die(_("bad %s"), arg);
 				hdr->hdr_entries =3D htonl(strtoul(c + 1, &c, 10));
@@ -1566,9 +1567,9 @@ int cmd_index_pack(int argc, const char **argv, c=
onst char *prefix)
 				if (index_name || (i+1) >=3D argc)
 					usage(index_pack_usage);
 				index_name =3D argv[++i];
-			} else if (starts_with(arg, "--index-version=3D")) {
+			} else if ((optarg =3D skip_prefix(arg, "--index-version=3D")) !=3D=
 NULL) {
 				char *c;
-				opts.version =3D strtoul(arg + 16, &c, 10);
+				opts.version =3D strtoul(optarg, &c, 10);
 				if (opts.version > 2)
 					die(_("bad %s"), arg);
 				if (*c =3D=3D ',')
diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index 39e5144..15c9fb3 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -48,14 +48,15 @@ int cmd_ls_remote(int argc, const char **argv, cons=
t char *prefix)
=20
 	for (i =3D 1; i < argc; i++) {
 		const char *arg =3D argv[i];
+		const char *optarg;
=20
 		if (*arg =3D=3D '-') {
-			if (starts_with(arg, "--upload-pack=3D")) {
-				uploadpack =3D arg + 14;
+			if ((optarg =3D skip_prefix(arg, "--upload-pack=3D")) !=3D NULL) {
+				uploadpack =3D optarg;
 				continue;
 			}
-			if (starts_with(arg, "--exec=3D")) {
-				uploadpack =3D arg + 7;
+			if ((optarg =3D skip_prefix(arg, "--exec=3D")) !=3D NULL) {
+				uploadpack =3D optarg;
 				continue;
 			}
 			if (!strcmp("--tags", arg) || !strcmp("-t", arg)) {
diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 2c3cd8e..2100e23 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -1002,6 +1002,7 @@ static const char mailinfo_usage[] =3D
 int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 {
 	const char *def_charset;
+	const char *optarg;
=20
 	/* NEEDSWORK: might want to do the optional .git/ directory
 	 * discovery
@@ -1020,8 +1021,8 @@ int cmd_mailinfo(int argc, const char **argv, con=
st char *prefix)
 			metainfo_charset =3D def_charset;
 		else if (!strcmp(argv[1], "-n"))
 			metainfo_charset =3D NULL;
-		else if (starts_with(argv[1], "--encoding=3D"))
-			metainfo_charset =3D argv[1] + 11;
+		else if ((optarg =3D skip_prefix(argv[1], "--encoding=3D")) !=3D NUL=
L)
+			metainfo_charset =3D optarg;
 		else if (!strcmp(argv[1], "--scissors"))
 			use_scissors =3D 1;
 		else if (!strcmp(argv[1], "--no-scissors"))
diff --git a/builtin/reflog.c b/builtin/reflog.c
index 852cff6..84a8bd9 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -608,15 +608,16 @@ static int cmd_reflog_expire(int argc, const char=
 **argv, const char *prefix)
=20
 	for (i =3D 1; i < argc; i++) {
 		const char *arg =3D argv[i];
+		const char *optarg;
 		if (!strcmp(arg, "--dry-run") || !strcmp(arg, "-n"))
 			cb.dry_run =3D 1;
-		else if (starts_with(arg, "--expire=3D")) {
-			if (parse_expiry_date(arg + 9, &cb.expire_total))
+		else if ((optarg =3D skip_prefix(arg, "--expire=3D")) !=3D NULL) {
+			if (parse_expiry_date(optarg, &cb.expire_total))
 				die(_("'%s' is not a valid timestamp"), arg);
 			explicit_expiry |=3D EXPIRE_TOTAL;
 		}
-		else if (starts_with(arg, "--expire-unreachable=3D")) {
-			if (parse_expiry_date(arg + 21, &cb.expire_unreachable))
+		else if ((optarg =3D skip_prefix(arg, "--expire-unreachable=3D")) !=3D=
 NULL) {
+			if (parse_expiry_date(optarg, &cb.expire_unreachable))
 				die(_("'%s' is not a valid timestamp"), arg);
 			explicit_expiry |=3D EXPIRE_UNREACH;
 		}
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 6e802fd..1a0bd12 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -505,6 +505,7 @@ int cmd_rev_parse(int argc, const char **argv, cons=
t char *prefix)
 	git_config(git_default_config, NULL);
 	for (i =3D 1; i < argc; i++) {
 		const char *arg =3D argv[i];
+		const char *optarg;
=20
 		if (as_is) {
 			if (show_file(arg, output_prefix) && as_is < 2)
@@ -618,8 +619,8 @@ int cmd_rev_parse(int argc, const char **argv, cons=
t char *prefix)
 				for_each_ref(show_reference, NULL);
 				continue;
 			}
-			if (starts_with(arg, "--disambiguate=3D")) {
-				for_each_abbrev(arg + 15, show_abbrev, NULL);
+			if ((optarg =3D skip_prefix(arg, "--disambiguate=3D")) !=3D NULL) {
+				for_each_abbrev(optarg, show_abbrev, NULL);
 				continue;
 			}
 			if (!strcmp(arg, "--bisect")) {
@@ -627,8 +628,8 @@ int cmd_rev_parse(int argc, const char **argv, cons=
t char *prefix)
 				for_each_ref_in("refs/bisect/good", anti_reference, NULL);
 				continue;
 			}
-			if (starts_with(arg, "--branches=3D")) {
-				for_each_glob_ref_in(show_reference, arg + 11,
+			if ((optarg =3D skip_prefix(arg, "--branches=3D")) !=3D NULL) {
+				for_each_glob_ref_in(show_reference, optarg,
 					"refs/heads/", NULL);
 				clear_ref_exclusion(&ref_excludes);
 				continue;
@@ -638,8 +639,8 @@ int cmd_rev_parse(int argc, const char **argv, cons=
t char *prefix)
 				clear_ref_exclusion(&ref_excludes);
 				continue;
 			}
-			if (starts_with(arg, "--tags=3D")) {
-				for_each_glob_ref_in(show_reference, arg + 7,
+			if ((optarg =3D skip_prefix(arg, "--tags=3D")) !=3D NULL) {
+				for_each_glob_ref_in(show_reference, optarg,
 					"refs/tags/", NULL);
 				clear_ref_exclusion(&ref_excludes);
 				continue;
@@ -649,13 +650,13 @@ int cmd_rev_parse(int argc, const char **argv, co=
nst char *prefix)
 				clear_ref_exclusion(&ref_excludes);
 				continue;
 			}
-			if (starts_with(arg, "--glob=3D")) {
-				for_each_glob_ref(show_reference, arg + 7, NULL);
+			if ((optarg =3D skip_prefix(arg, "--glob=3D")) !=3D NULL) {
+				for_each_glob_ref(show_reference, optarg, NULL);
 				clear_ref_exclusion(&ref_excludes);
 				continue;
 			}
-			if (starts_with(arg, "--remotes=3D")) {
-				for_each_glob_ref_in(show_reference, arg + 10,
+			if ((optarg =3D skip_prefix(arg, "--remotes=3D")) !=3D NULL) {
+				for_each_glob_ref_in(show_reference, optarg,
 					"refs/remotes/", NULL);
 				clear_ref_exclusion(&ref_excludes);
 				continue;
@@ -665,8 +666,8 @@ int cmd_rev_parse(int argc, const char **argv, cons=
t char *prefix)
 				clear_ref_exclusion(&ref_excludes);
 				continue;
 			}
-			if (starts_with(arg, "--exclude=3D")) {
-				add_ref_exclusion(&ref_excludes, arg + 10);
+			if ((optarg =3D skip_prefix(arg, "--exclude=3D")) !=3D NULL) {
+				add_ref_exclusion(&ref_excludes, optarg);
 				continue;
 			}
 			if (!strcmp(arg, "--local-env-vars")) {
@@ -747,20 +748,20 @@ int cmd_rev_parse(int argc, const char **argv, co=
nst char *prefix)
 						: "false");
 				continue;
 			}
-			if (starts_with(arg, "--since=3D")) {
-				show_datestring("--max-age=3D", arg+8);
+			if ((optarg =3D skip_prefix(arg, "--since=3D")) !=3D NULL) {
+				show_datestring("--max-age=3D", optarg);
 				continue;
 			}
-			if (starts_with(arg, "--after=3D")) {
-				show_datestring("--max-age=3D", arg+8);
+			if ((optarg =3D skip_prefix(arg, "--after=3D")) !=3D NULL) {
+				show_datestring("--max-age=3D", optarg);
 				continue;
 			}
-			if (starts_with(arg, "--before=3D")) {
-				show_datestring("--min-age=3D", arg+9);
+			if ((optarg =3D skip_prefix(arg, "--before=3D")) !=3D NULL) {
+				show_datestring("--min-age=3D", optarg);
 				continue;
 			}
-			if (starts_with(arg, "--until=3D")) {
-				show_datestring("--min-age=3D", arg+8);
+			if ((optarg =3D skip_prefix(arg, "--until=3D")) !=3D NULL) {
+				show_datestring("--min-age=3D", optarg);
 				continue;
 			}
 			if (show_flag(arg) && verify)
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index e7f0b97..9efc422 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -113,18 +113,19 @@ int cmd_send_pack(int argc, const char **argv, co=
nst char *prefix)
 	argv++;
 	for (i =3D 1; i < argc; i++, argv++) {
 		const char *arg =3D *argv;
+		const char *optarg;
=20
 		if (*arg =3D=3D '-') {
-			if (starts_with(arg, "--receive-pack=3D")) {
-				receivepack =3D arg + 15;
+			if ((optarg =3D skip_prefix(arg, "--receive-pack=3D")) !=3D NULL) {
+				receivepack =3D optarg;
 				continue;
 			}
-			if (starts_with(arg, "--exec=3D")) {
-				receivepack =3D arg + 7;
+			if ((optarg =3D skip_prefix(arg, "--exec=3D")) !=3D NULL) {
+				receivepack =3D optarg;
 				continue;
 			}
-			if (starts_with(arg, "--remote=3D")) {
-				remote_name =3D arg + 9;
+			if ((optarg =3D skip_prefix(arg, "--remote=3D")) !=3D NULL) {
+				remote_name =3D optarg;
 				continue;
 			}
 			if (!strcmp(arg, "--all")) {
@@ -181,9 +182,8 @@ int cmd_send_pack(int argc, const char **argv, cons=
t char *prefix)
 					exit(1);
 				continue;
 			}
-			if (starts_with(arg, "--" CAS_OPT_NAME "=3D")) {
-				if (parse_push_cas_option(&cas,
-							  strchr(arg, '=3D') + 1, 0) < 0)
+			if ((optarg =3D skip_prefix(arg, "--" CAS_OPT_NAME "=3D")) !=3D NUL=
L) {
+				if (parse_push_cas_option(&cas, optarg, 0) < 0)
 					exit(1);
 				continue;
 			}
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 62ff673..a7cd823 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -505,6 +505,7 @@ int cmd_unpack_objects(int argc, const char **argv,=
 const char *prefix)
=20
 	for (i =3D 1 ; i < argc; i++) {
 		const char *arg =3D argv[i];
+		const char *optarg;
=20
 		if (*arg =3D=3D '-') {
 			if (!strcmp(arg, "-n")) {
@@ -523,13 +524,13 @@ int cmd_unpack_objects(int argc, const char **arg=
v, const char *prefix)
 				strict =3D 1;
 				continue;
 			}
-			if (starts_with(arg, "--pack_header=3D")) {
+			if ((optarg =3D skip_prefix(arg, "--pack_header=3D")) !=3D NULL) {
 				struct pack_header *hdr;
 				char *c;
=20
 				hdr =3D (struct pack_header *)buffer;
 				hdr->hdr_signature =3D htonl(PACK_SIGNATURE);
-				hdr->hdr_version =3D htonl(strtoul(arg + 14, &c, 10));
+				hdr->hdr_version =3D htonl(strtoul(optarg, &c, 10));
 				if (*c !=3D ',')
 					die("bad %s", arg);
 				hdr->hdr_entries =3D htonl(strtoul(c + 1, &c, 10));
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 1292cfe..09c921a 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -222,6 +222,7 @@ static void parse_cmd_option(const char *next)
 static void update_refs_stdin(void)
 {
 	struct strbuf cmd =3D STRBUF_INIT;
+	const char *optarg;
=20
 	/* Read each line dispatch its command */
 	while (strbuf_getline(&cmd, stdin, line_termination) !=3D EOF)
@@ -229,16 +230,16 @@ static void update_refs_stdin(void)
 			die("empty command in input");
 		else if (isspace(*cmd.buf))
 			die("whitespace before command: %s", cmd.buf);
-		else if (starts_with(cmd.buf, "update "))
-			parse_cmd_update(cmd.buf + 7);
-		else if (starts_with(cmd.buf, "create "))
-			parse_cmd_create(cmd.buf + 7);
-		else if (starts_with(cmd.buf, "delete "))
-			parse_cmd_delete(cmd.buf + 7);
-		else if (starts_with(cmd.buf, "verify "))
-			parse_cmd_verify(cmd.buf + 7);
-		else if (starts_with(cmd.buf, "option "))
-			parse_cmd_option(cmd.buf + 7);
+		else if ((optarg =3D skip_prefix(cmd.buf, "update ")) !=3D NULL)
+			parse_cmd_update(optarg);
+		else if ((optarg =3D skip_prefix(cmd.buf, "create ")) !=3D NULL)
+			parse_cmd_create(optarg);
+		else if ((optarg =3D skip_prefix(cmd.buf, "delete ")) !=3D NULL)
+			parse_cmd_delete(optarg);
+		else if ((optarg =3D skip_prefix(cmd.buf, "verify ")) !=3D NULL)
+			parse_cmd_verify(optarg);
+		else if ((optarg =3D skip_prefix(cmd.buf, "option ")) !=3D NULL)
+			parse_cmd_option(optarg);
 		else
 			die("unknown command: %s", cmd.buf);
=20
diff --git a/daemon.c b/daemon.c
index 7bee953..9d3cc18 100644
--- a/daemon.c
+++ b/daemon.c
@@ -39,8 +39,8 @@ static int strict_paths;
 static int export_all_trees;
=20
 /* Take all paths relative to this one if non-NULL */
-static char *base_path;
-static char *interpolated_path;
+static const char *base_path;
+static const char *interpolated_path;
 static int base_path_relaxed;
=20
 /* Flag indicating client sent extra args. */
@@ -253,7 +253,7 @@ static int daemon_error(const char *dir, const char=
 *msg)
 	return -1;
 }
=20
-static char *access_hook;
+static const char *access_hook;
=20
 static int run_access_hook(struct daemon_service *service, const char =
*dir, const char *path)
 {
@@ -1164,15 +1164,16 @@ int main(int argc, char **argv)
=20
 	for (i =3D 1; i < argc; i++) {
 		char *arg =3D argv[i];
+		const char *optarg;
=20
-		if (starts_with(arg, "--listen=3D")) {
-			string_list_append(&listen_addr, xstrdup_tolower(arg + 9));
+		if ((optarg =3D skip_prefix(arg, "--listen=3D")) !=3D NULL) {
+			string_list_append(&listen_addr, xstrdup_tolower(optarg));
 			continue;
 		}
-		if (starts_with(arg, "--port=3D")) {
+		if ((optarg =3D skip_prefix(arg, "--port=3D")) !=3D NULL) {
 			char *end;
 			unsigned long n;
-			n =3D strtoul(arg+7, &end, 0);
+			n =3D strtoul(optarg, &end, 0);
 			if (arg[7] && !*end) {
 				listen_port =3D n;
 				continue;
@@ -1199,20 +1200,20 @@ int main(int argc, char **argv)
 			export_all_trees =3D 1;
 			continue;
 		}
-		if (starts_with(arg, "--access-hook=3D")) {
-			access_hook =3D arg + 14;
+		if ((optarg =3D skip_prefix(arg, "--access-hook=3D")) !=3D NULL) {
+			access_hook =3D optarg;
 			continue;
 		}
-		if (starts_with(arg, "--timeout=3D")) {
-			timeout =3D atoi(arg+10);
+		if ((optarg =3D skip_prefix(arg, "--timeout=3D")) !=3D NULL) {
+			timeout =3D atoi(optarg);
 			continue;
 		}
-		if (starts_with(arg, "--init-timeout=3D")) {
-			init_timeout =3D atoi(arg+15);
+		if ((optarg =3D skip_prefix(arg, "--init-timeout=3D")) !=3D NULL) {
+			init_timeout =3D atoi(optarg);
 			continue;
 		}
-		if (starts_with(arg, "--max-connections=3D")) {
-			max_connections =3D atoi(arg+18);
+		if ((optarg =3D skip_prefix(arg, "--max-connections=3D")) !=3D NULL)=
 {
+			max_connections =3D atoi(optarg);
 			if (max_connections < 0)
 				max_connections =3D 0;	        /* unlimited */
 			continue;
@@ -1221,16 +1222,16 @@ int main(int argc, char **argv)
 			strict_paths =3D 1;
 			continue;
 		}
-		if (starts_with(arg, "--base-path=3D")) {
-			base_path =3D arg+12;
+		if ((optarg =3D skip_prefix(arg, "--base-path=3D")) !=3D NULL) {
+			base_path =3D optarg;
 			continue;
 		}
 		if (!strcmp(arg, "--base-path-relaxed")) {
 			base_path_relaxed =3D 1;
 			continue;
 		}
-		if (starts_with(arg, "--interpolated-path=3D")) {
-			interpolated_path =3D arg+20;
+		if ((optarg =3D skip_prefix(arg, "--interpolated-path=3D")) !=3D NUL=
L) {
+			interpolated_path =3D optarg;
 			continue;
 		}
 		if (!strcmp(arg, "--reuseaddr")) {
@@ -1241,12 +1242,12 @@ int main(int argc, char **argv)
 			user_path =3D "";
 			continue;
 		}
-		if (starts_with(arg, "--user-path=3D")) {
-			user_path =3D arg + 12;
+		if ((optarg =3D skip_prefix(arg, "--user-path=3D")) !=3D NULL) {
+			user_path =3D optarg;
 			continue;
 		}
-		if (starts_with(arg, "--pid-file=3D")) {
-			pid_file =3D arg + 11;
+		if ((optarg =3D skip_prefix(arg, "--pid-file=3D")) !=3D NULL) {
+			pid_file =3D optarg;
 			continue;
 		}
 		if (!strcmp(arg, "--detach")) {
@@ -1254,35 +1255,35 @@ int main(int argc, char **argv)
 			log_syslog =3D 1;
 			continue;
 		}
-		if (starts_with(arg, "--user=3D")) {
-			user_name =3D arg + 7;
+		if ((optarg =3D skip_prefix(arg, "--user=3D")) !=3D NULL) {
+			user_name =3D optarg;
 			continue;
 		}
-		if (starts_with(arg, "--group=3D")) {
-			group_name =3D arg + 8;
+		if ((optarg =3D skip_prefix(arg, "--group=3D")) !=3D NULL) {
+			group_name =3D optarg;
 			continue;
 		}
-		if (starts_with(arg, "--enable=3D")) {
-			enable_service(arg + 9, 1);
+		if ((optarg =3D skip_prefix(arg, "--enable=3D")) !=3D NULL) {
+			enable_service(optarg, 1);
 			continue;
 		}
-		if (starts_with(arg, "--disable=3D")) {
-			enable_service(arg + 10, 0);
+		if ((optarg =3D skip_prefix(arg, "--disable=3D")) !=3D NULL) {
+			enable_service(optarg, 0);
 			continue;
 		}
-		if (starts_with(arg, "--allow-override=3D")) {
-			make_service_overridable(arg + 17, 1);
+		if ((optarg =3D skip_prefix(arg, "--allow-override=3D")) !=3D NULL) =
{
+			make_service_overridable(optarg, 1);
 			continue;
 		}
-		if (starts_with(arg, "--forbid-override=3D")) {
-			make_service_overridable(arg + 18, 0);
+		if ((optarg =3D skip_prefix(arg, "--forbid-override=3D")) !=3D NULL)=
 {
+			make_service_overridable(optarg, 0);
 			continue;
 		}
-		if (starts_with(arg, "--informative-errors")) {
+		if ((optarg =3D skip_prefix(arg, "--informative-errors")) !=3D NULL)=
 {
 			informative_errors =3D 1;
 			continue;
 		}
-		if (starts_with(arg, "--no-informative-errors")) {
+		if ((optarg =3D skip_prefix(arg, "--no-informative-errors")) !=3D NU=
LL) {
 			informative_errors =3D 0;
 			continue;
 		}
diff --git a/diff.c b/diff.c
index b79432b..90a1929 100644
--- a/diff.c
+++ b/diff.c
@@ -2353,6 +2353,7 @@ static void builtin_diff(const char *name_a,
 		xdemitconf_t xecfg;
 		struct emit_callback ecbdata;
 		const struct userdiff_funcname *pe;
+		const char *optarg;
=20
 		if (must_show_header) {
 			fprintf(o->file, "%s", header.buf);
@@ -2387,10 +2388,10 @@ static void builtin_diff(const char *name_a,
 			xdiff_set_find_func(&xecfg, pe->pattern, pe->cflags);
 		if (!diffopts)
 			;
-		else if (starts_with(diffopts, "--unified=3D"))
-			xecfg.ctxlen =3D strtoul(diffopts + 10, NULL, 10);
-		else if (starts_with(diffopts, "-u"))
-			xecfg.ctxlen =3D strtoul(diffopts + 2, NULL, 10);
+		else if ((optarg =3D skip_prefix(diffopts, "--unified=3D")) !=3D NUL=
L)
+			xecfg.ctxlen =3D strtoul(optarg, NULL, 10);
+		else if ((optarg =3D skip_prefix(diffopts, "-u")) !=3D NULL)
+			xecfg.ctxlen =3D strtoul(optarg, NULL, 10);
 		if (o->word_diff)
 			init_diff_words_data(&ecbdata, o, one, two);
 		xdi_diff_outf(&mf1, &mf2, fn_out_consume, &ecbdata,
@@ -3614,17 +3615,17 @@ int diff_opt_parse(struct diff_options *options=
, const char **av, int ac)
 		options->output_format |=3D DIFF_FORMAT_SHORTSTAT;
 	else if (!strcmp(arg, "-X") || !strcmp(arg, "--dirstat"))
 		return parse_dirstat_opt(options, "");
-	else if (starts_with(arg, "-X"))
-		return parse_dirstat_opt(options, arg + 2);
-	else if (starts_with(arg, "--dirstat=3D"))
-		return parse_dirstat_opt(options, arg + 10);
+	else if ((optarg =3D skip_prefix(arg, "-X")) !=3D NULL)
+		return parse_dirstat_opt(options, optarg);
+	else if ((optarg =3D skip_prefix(arg, "--dirstat=3D")) !=3D NULL)
+		return parse_dirstat_opt(options, optarg);
 	else if (!strcmp(arg, "--cumulative"))
 		return parse_dirstat_opt(options, "cumulative");
 	else if (!strcmp(arg, "--dirstat-by-file"))
 		return parse_dirstat_opt(options, "files");
-	else if (starts_with(arg, "--dirstat-by-file=3D")) {
+	else if ((optarg =3D skip_prefix(arg, "--dirstat-by-file=3D")) !=3D N=
ULL) {
 		parse_dirstat_opt(options, "files");
-		return parse_dirstat_opt(options, arg + 18);
+		return parse_dirstat_opt(options, optarg);
 	}
 	else if (!strcmp(arg, "--check"))
 		options->output_format |=3D DIFF_FORMAT_CHECKDIFF;
@@ -3674,9 +3675,9 @@ int diff_opt_parse(struct diff_options *options, =
const char **av, int ac)
 		DIFF_OPT_CLR(options, RENAME_EMPTY);
 	else if (!strcmp(arg, "--relative"))
 		DIFF_OPT_SET(options, RELATIVE_NAME);
-	else if (starts_with(arg, "--relative=3D")) {
+	else if ((optarg =3D skip_prefix(arg, "--relative=3D")) !=3D NULL) {
 		DIFF_OPT_SET(options, RELATIVE_NAME);
-		options->prefix =3D arg + 11;
+		options->prefix =3D optarg;
 	}
=20
 	/* xdiff options */
@@ -3727,8 +3728,8 @@ int diff_opt_parse(struct diff_options *options, =
const char **av, int ac)
 		DIFF_OPT_CLR(options, FOLLOW_RENAMES);
 	else if (!strcmp(arg, "--color"))
 		options->use_color =3D 1;
-	else if (starts_with(arg, "--color=3D")) {
-		int value =3D git_config_colorbool(NULL, arg+8);
+	else if ((optarg =3D skip_prefix(arg, "--color=3D")) !=3D NULL) {
+		int value =3D git_config_colorbool(NULL, optarg);
 		if (value < 0)
 			return error("option `color' expects \"always\", \"auto\", or \"nev=
er\"");
 		options->use_color =3D value;
@@ -3739,17 +3740,17 @@ int diff_opt_parse(struct diff_options *options=
, const char **av, int ac)
 		options->use_color =3D 1;
 		options->word_diff =3D DIFF_WORDS_COLOR;
 	}
-	else if (starts_with(arg, "--color-words=3D")) {
+	else if ((optarg =3D skip_prefix(arg, "--color-words=3D")) !=3D NULL)=
 {
 		options->use_color =3D 1;
 		options->word_diff =3D DIFF_WORDS_COLOR;
-		options->word_regex =3D arg + 14;
+		options->word_regex =3D optarg;
 	}
 	else if (!strcmp(arg, "--word-diff")) {
 		if (options->word_diff =3D=3D DIFF_WORDS_NONE)
 			options->word_diff =3D DIFF_WORDS_PLAIN;
 	}
-	else if (starts_with(arg, "--word-diff=3D")) {
-		const char *type =3D arg + 12;
+	else if ((optarg =3D skip_prefix(arg, "--word-diff=3D")) !=3D NULL) {
+		const char *type =3D optarg;
 		if (!strcmp(type, "plain"))
 			options->word_diff =3D DIFF_WORDS_PLAIN;
 		else if (!strcmp(type, "color")) {
@@ -3784,13 +3785,13 @@ int diff_opt_parse(struct diff_options *options=
, const char **av, int ac)
 	else if (!strcmp(arg, "--ignore-submodules")) {
 		DIFF_OPT_SET(options, OVERRIDE_SUBMODULE_CONFIG);
 		handle_ignore_submodules_arg(options, "all");
-	} else if (starts_with(arg, "--ignore-submodules=3D")) {
+	} else if ((optarg =3D skip_prefix(arg, "--ignore-submodules=3D")) !=3D=
 NULL) {
 		DIFF_OPT_SET(options, OVERRIDE_SUBMODULE_CONFIG);
-		handle_ignore_submodules_arg(options, arg + 20);
+		handle_ignore_submodules_arg(options, optarg);
 	} else if (!strcmp(arg, "--submodule"))
 		DIFF_OPT_SET(options, SUBMODULE_LOG);
-	else if (starts_with(arg, "--submodule=3D"))
-		return parse_submodule_opt(options, arg + 12);
+	else if ((optarg =3D skip_prefix(arg, "--submodule=3D")) !=3D NULL)
+		return parse_submodule_opt(options, optarg);
=20
 	/* misc options */
 	else if (!strcmp(arg, "-z"))
@@ -3825,8 +3826,8 @@ int diff_opt_parse(struct diff_options *options, =
const char **av, int ac)
 	}
 	else if (!strcmp(arg, "--abbrev"))
 		options->abbrev =3D DEFAULT_ABBREV;
-	else if (starts_with(arg, "--abbrev=3D")) {
-		options->abbrev =3D strtoul(arg + 9, NULL, 10);
+	else if ((optarg =3D skip_prefix(arg, "--abbrev=3D")) !=3D NULL) {
+		options->abbrev =3D strtoul(optarg, NULL, 10);
 		if (options->abbrev < MINIMUM_ABBREV)
 			options->abbrev =3D MINIMUM_ABBREV;
 		else if (40 < options->abbrev)
diff --git a/git.c b/git.c
index 3799514..35fda7e 100644
--- a/git.c
+++ b/git.c
@@ -40,6 +40,7 @@ static int handle_options(const char ***argv, int *ar=
gc, int *envchanged)
=20
 	while (*argc > 0) {
 		const char *cmd =3D (*argv)[0];
+		const char *optarg;
 		if (cmd[0] !=3D '-')
 			break;
=20
@@ -92,8 +93,8 @@ static int handle_options(const char ***argv, int *ar=
gc, int *envchanged)
 				*envchanged =3D 1;
 			(*argv)++;
 			(*argc)--;
-		} else if (starts_with(cmd, "--git-dir=3D")) {
-			setenv(GIT_DIR_ENVIRONMENT, cmd + 10, 1);
+		} else if ((optarg =3D skip_prefix(cmd, "--git-dir=3D")) !=3D NULL) =
{
+			setenv(GIT_DIR_ENVIRONMENT, optarg, 1);
 			if (envchanged)
 				*envchanged =3D 1;
 		} else if (!strcmp(cmd, "--namespace")) {
@@ -106,8 +107,8 @@ static int handle_options(const char ***argv, int *=
argc, int *envchanged)
 				*envchanged =3D 1;
 			(*argv)++;
 			(*argc)--;
-		} else if (starts_with(cmd, "--namespace=3D")) {
-			setenv(GIT_NAMESPACE_ENVIRONMENT, cmd + 12, 1);
+		} else if ((optarg =3D skip_prefix(cmd, "--namespace=3D")) !=3D NULL=
) {
+			setenv(GIT_NAMESPACE_ENVIRONMENT, optarg, 1);
 			if (envchanged)
 				*envchanged =3D 1;
 		} else if (!strcmp(cmd, "--work-tree")) {
@@ -120,8 +121,8 @@ static int handle_options(const char ***argv, int *=
argc, int *envchanged)
 				*envchanged =3D 1;
 			(*argv)++;
 			(*argc)--;
-		} else if (starts_with(cmd, "--work-tree=3D")) {
-			setenv(GIT_WORK_TREE_ENVIRONMENT, cmd + 12, 1);
+		} else if ((optarg =3D skip_prefix(cmd, "--work-tree=3D")) !=3D NULL=
) {
+			setenv(GIT_WORK_TREE_ENVIRONMENT, optarg, 1);
 			if (envchanged)
 				*envchanged =3D 1;
 		} else if (!strcmp(cmd, "--bare")) {
diff --git a/merge-recursive.c b/merge-recursive.c
index a18bd15..ba7ecb6 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2055,6 +2055,7 @@ void init_merge_options(struct merge_options *o)
=20
 int parse_merge_opt(struct merge_options *o, const char *s)
 {
+	const char *optarg;
 	if (!s || !*s)
 		return -1;
 	if (!strcmp(s, "ours"))
@@ -2063,14 +2064,14 @@ int parse_merge_opt(struct merge_options *o, co=
nst char *s)
 		o->recursive_variant =3D MERGE_RECURSIVE_THEIRS;
 	else if (!strcmp(s, "subtree"))
 		o->subtree_shift =3D "";
-	else if (starts_with(s, "subtree=3D"))
-		o->subtree_shift =3D s + strlen("subtree=3D");
+	else if ((optarg =3D skip_prefix(s, "subtree=3D")) !=3D NULL)
+		o->subtree_shift =3D optarg;
 	else if (!strcmp(s, "patience"))
 		o->xdl_opts =3D DIFF_WITH_ALG(o, PATIENCE_DIFF);
 	else if (!strcmp(s, "histogram"))
 		o->xdl_opts =3D DIFF_WITH_ALG(o, HISTOGRAM_DIFF);
-	else if (starts_with(s, "diff-algorithm=3D")) {
-		long value =3D parse_algorithm_value(s + strlen("diff-algorithm=3D")=
);
+	else if ((optarg =3D skip_prefix(s, "diff-algorithm=3D")) !=3D NULL) =
{
+		long value =3D parse_algorithm_value(optarg);
 		if (value < 0)
 			return -1;
 		/* clear out previous settings */
@@ -2088,8 +2089,8 @@ int parse_merge_opt(struct merge_options *o, cons=
t char *s)
 		o->renormalize =3D 1;
 	else if (!strcmp(s, "no-renormalize"))
 		o->renormalize =3D 0;
-	else if (starts_with(s, "rename-threshold=3D")) {
-		const char *score =3D s + strlen("rename-threshold=3D");
+	else if ((optarg =3D skip_prefix(s, "rename-threshold=3D")) !=3D NULL=
) {
+		const char *score =3D optarg;
 		if ((o->rename_score =3D parse_rename_score(&score)) =3D=3D -1 || *s=
core !=3D 0)
 			return -1;
 	}
diff --git a/revision.c b/revision.c
index a68fde6..94b66e8 100644
--- a/revision.c
+++ b/revision.c
@@ -1652,8 +1652,8 @@ static int handle_revision_opt(struct rev_info *r=
evs, int argc, const char **arg
 		revs->max_count =3D atoi(argv[1]);
 		revs->no_walk =3D 0;
 		return 2;
-	} else if (starts_with(arg, "-n")) {
-		revs->max_count =3D atoi(arg + 2);
+	} else if ((optarg =3D skip_prefix(arg, "-n")) !=3D NULL) {
+		revs->max_count =3D atoi(optarg);
 		revs->no_walk =3D 0;
 	} else if ((argcount =3D parse_long_opt("max-age", argv, &optarg))) {
 		revs->max_age =3D atoi(optarg);
@@ -1712,11 +1712,11 @@ static int handle_revision_opt(struct rev_info =
*revs, int argc, const char **arg
 	} else if (!strcmp(arg, "--author-date-order")) {
 		revs->sort_order =3D REV_SORT_BY_AUTHOR_DATE;
 		revs->topo_order =3D 1;
-	} else if (starts_with(arg, "--early-output")) {
+	} else if ((optarg =3D skip_prefix(arg, "--early-output")) !=3D NULL)=
 {
 		int count =3D 100;
-		switch (arg[14]) {
+		switch (optarg[0]) {
 		case '=3D':
-			count =3D atoi(arg+15);
+			count =3D atoi(optarg + 1);
 			/* Fallthrough */
 		case 0:
 			revs->topo_order =3D 1;
@@ -1737,12 +1737,12 @@ static int handle_revision_opt(struct rev_info =
*revs, int argc, const char **arg
 		revs->min_parents =3D 2;
 	} else if (!strcmp(arg, "--no-merges")) {
 		revs->max_parents =3D 1;
-	} else if (starts_with(arg, "--min-parents=3D")) {
-		revs->min_parents =3D atoi(arg+14);
+	} else if ((optarg =3D skip_prefix(arg, "--min-parents=3D")) !=3D NUL=
L) {
+		revs->min_parents =3D atoi(optarg);
 	} else if (starts_with(arg, "--no-min-parents")) {
 		revs->min_parents =3D 0;
-	} else if (starts_with(arg, "--max-parents=3D")) {
-		revs->max_parents =3D atoi(arg+14);
+	} else if ((optarg =3D skip_prefix(arg, "--max-parents=3D")) !=3D NUL=
L) {
+		revs->max_parents =3D atoi(optarg);
 	} else if (starts_with(arg, "--no-max-parents")) {
 		revs->max_parents =3D -1;
 	} else if (!strcmp(arg, "--boundary")) {
@@ -1818,32 +1818,30 @@ static int handle_revision_opt(struct rev_info =
*revs, int argc, const char **arg
 		revs->verbose_header =3D 1;
 		revs->pretty_given =3D 1;
 		get_commit_format(arg+8, revs);
-	} else if (starts_with(arg, "--pretty=3D") || starts_with(arg, "--for=
mat=3D")) {
+	} else if ((optarg =3D skip_prefix(arg, "--pretty=3D")) !=3D NULL ||
+		   (optarg =3D skip_prefix(arg, "--format=3D")) !=3D NULL) {
 		/*
 		 * Detached form ("--pretty X" as opposed to "--pretty=3DX")
 		 * not allowed, since the argument is optional.
 		 */
 		revs->verbose_header =3D 1;
 		revs->pretty_given =3D 1;
-		get_commit_format(arg+9, revs);
+		get_commit_format(optarg, revs);
 	} else if (!strcmp(arg, "--show-notes") || !strcmp(arg, "--notes")) {
 		revs->show_notes =3D 1;
 		revs->show_notes_given =3D 1;
 		revs->notes_opt.use_default_notes =3D 1;
 	} else if (!strcmp(arg, "--show-signature")) {
 		revs->show_signature =3D 1;
-	} else if (starts_with(arg, "--show-notes=3D") ||
-		   starts_with(arg, "--notes=3D")) {
+	} else if ((optarg =3D skip_prefix(arg, "--show-notes=3D")) !=3D NULL=
 ||
+		   (optarg =3D skip_prefix(arg, "--notes=3D")) !=3D NULL) {
 		struct strbuf buf =3D STRBUF_INIT;
 		revs->show_notes =3D 1;
 		revs->show_notes_given =3D 1;
-		if (starts_with(arg, "--show-notes")) {
-			if (revs->notes_opt.use_default_notes < 0)
-				revs->notes_opt.use_default_notes =3D 1;
-			strbuf_addstr(&buf, arg+13);
-		}
-		else
-			strbuf_addstr(&buf, arg+8);
+		if (starts_with(arg, "--show-notes") &&
+		    revs->notes_opt.use_default_notes < 0)
+			revs->notes_opt.use_default_notes =3D 1;
+		strbuf_addstr(&buf, optarg);
 		expand_notes_ref(&buf);
 		string_list_append(&revs->notes_opt.extra_notes_refs,
 				   strbuf_detach(&buf, NULL));
@@ -1880,8 +1878,8 @@ static int handle_revision_opt(struct rev_info *r=
evs, int argc, const char **arg
 		revs->abbrev =3D 0;
 	} else if (!strcmp(arg, "--abbrev")) {
 		revs->abbrev =3D DEFAULT_ABBREV;
-	} else if (starts_with(arg, "--abbrev=3D")) {
-		revs->abbrev =3D strtoul(arg + 9, NULL, 10);
+	} else if ((optarg =3D skip_prefix(arg, "--abbrev=3D")) !=3D NULL) {
+		revs->abbrev =3D strtoul(optarg, NULL, 10);
 		if (revs->abbrev < MINIMUM_ABBREV)
 			revs->abbrev =3D MINIMUM_ABBREV;
 		else if (revs->abbrev > 40)
@@ -2027,20 +2025,20 @@ static int handle_revision_pseudo_opt(const cha=
r *submodule,
 	} else if ((argcount =3D parse_long_opt("exclude", argv, &optarg))) {
 		add_ref_exclusion(&revs->ref_excludes, optarg);
 		return argcount;
-	} else if (starts_with(arg, "--branches=3D")) {
+	} else if ((optarg =3D skip_prefix(arg, "--branches=3D")) !=3D NULL) =
{
 		struct all_refs_cb cb;
 		init_all_refs_cb(&cb, revs, *flags);
-		for_each_glob_ref_in(handle_one_ref, arg + 11, "refs/heads/", &cb);
+		for_each_glob_ref_in(handle_one_ref, optarg, "refs/heads/", &cb);
 		clear_ref_exclusion(&revs->ref_excludes);
-	} else if (starts_with(arg, "--tags=3D")) {
+	} else if ((optarg =3D skip_prefix(arg, "--tags=3D")) !=3D NULL) {
 		struct all_refs_cb cb;
 		init_all_refs_cb(&cb, revs, *flags);
-		for_each_glob_ref_in(handle_one_ref, arg + 7, "refs/tags/", &cb);
+		for_each_glob_ref_in(handle_one_ref, optarg, "refs/tags/", &cb);
 		clear_ref_exclusion(&revs->ref_excludes);
-	} else if (starts_with(arg, "--remotes=3D")) {
+	} else if ((optarg =3D skip_prefix(arg, "--remotes=3D")) !=3D NULL) {
 		struct all_refs_cb cb;
 		init_all_refs_cb(&cb, revs, *flags);
-		for_each_glob_ref_in(handle_one_ref, arg + 10, "refs/remotes/", &cb)=
;
+		for_each_glob_ref_in(handle_one_ref, optarg, "refs/remotes/", &cb);
 		clear_ref_exclusion(&revs->ref_excludes);
 	} else if (!strcmp(arg, "--reflog")) {
 		handle_reflog(revs, *flags);
@@ -2048,14 +2046,14 @@ static int handle_revision_pseudo_opt(const cha=
r *submodule,
 		*flags ^=3D UNINTERESTING | BOTTOM;
 	} else if (!strcmp(arg, "--no-walk")) {
 		revs->no_walk =3D REVISION_WALK_NO_WALK_SORTED;
-	} else if (starts_with(arg, "--no-walk=3D")) {
+	} else if ((optarg =3D skip_prefix(arg, "--no-walk=3D")) !=3D NULL) {
 		/*
 		 * Detached form ("--no-walk X" as opposed to "--no-walk=3DX")
 		 * not allowed, since the argument is optional.
 		 */
-		if (!strcmp(arg + 10, "sorted"))
+		if (!strcmp(optarg, "sorted"))
 			revs->no_walk =3D REVISION_WALK_NO_WALK_SORTED;
-		else if (!strcmp(arg + 10, "unsorted"))
+		else if (!strcmp(optarg, "unsorted"))
 			revs->no_walk =3D REVISION_WALK_NO_WALK_UNSORTED;
 		else
 			return error("invalid argument to --no-walk");
diff --git a/upload-pack.c b/upload-pack.c
index ec56cdb..8523b42 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -799,6 +799,7 @@ int main(int argc, char **argv)
=20
 	for (i =3D 1; i < argc; i++) {
 		char *arg =3D argv[i];
+		const char *optarg;
=20
 		if (arg[0] !=3D '-')
 			break;
@@ -814,8 +815,8 @@ int main(int argc, char **argv)
 			strict =3D 1;
 			continue;
 		}
-		if (starts_with(arg, "--timeout=3D")) {
-			timeout =3D atoi(arg+10);
+		if ((optarg =3D skip_prefix(arg, "--timeout=3D")) !=3D NULL) {
+			timeout =3D atoi(optarg);
 			daemon_mode =3D 1;
 			continue;
 		}
--=20
1.8.5.1.208.g019362e

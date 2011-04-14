From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
Subject: [PATCH] log: convert to parse-options
Date: Thu, 14 Apr 2011 16:28:30 +0200
Message-ID: <1302791310-19640-1-git-send-email-cmn@elego.de>
References: <7vlizem9bx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 16:28:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QANXC-0006kp-NJ
	for gcvg-git-2@lo.gmane.org; Thu, 14 Apr 2011 16:28:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758854Ab1DNO2d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Apr 2011 10:28:33 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:33035 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758837Ab1DNO2c (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2011 10:28:32 -0400
Received: from bee.lab.cmartin.tk (i59F7870A.versanet.de [89.247.135.10])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id 671CA4612C;
	Thu, 14 Apr 2011 16:28:17 +0200 (CEST)
Received: (nullmailer pid 19691 invoked by uid 1000);
	Thu, 14 Apr 2011 14:28:30 -0000
X-Mailer: git-send-email 1.7.4.2.437.g4fc7e.dirty
In-Reply-To: <7vlizem9bx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171521>

Use parse-options in cmd_log_init instead of manually iterating
through them. This makes the code a bit cleaner but more importantly
allows us to catch the "--quiet" option which causes some of the
log-related commands to misbehave as it would otherwise get passed on
to the diff.

Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
---

This "fixes" the previous --quiet effects by not letting it
through. Later we can decide to make it mean the same as -s or just
leave it like that.

 builtin/log.c |   77 ++++++++++++++++++++++++++++++++++++-------------=
-------
 1 files changed, 49 insertions(+), 28 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 9a15d69..5316be3 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -25,6 +25,7 @@ static const char *default_date_mode =3D NULL;
=20
 static int default_show_root =3D 1;
 static int decoration_style;
+static int decoration_given =3D 0;
 static const char *fmt_patch_subject_prefix =3D "PATCH";
 static const char *fmt_pretty;
=20
@@ -49,12 +50,51 @@ static int parse_decoration_style(const char *var, =
const char *value)
 	return -1;
 }
=20
+static int decorate_callback(const struct option *opt, const char *arg=
, int unset)
+{
+	if (unset) {
+		decoration_style =3D 0;
+		return 0;
+	}
+
+	if (arg =3D=3D NULL) {
+		decoration_style =3D DECORATE_SHORT_REFS;
+		decoration_given =3D 1;
+		return 0;
+	}
+
+	/* First arg is irrelevant, as it just tries to parse arg */
+	decoration_style =3D parse_decoration_style("decorate", arg);
+	if (decoration_style < 0)
+		die("invalid --decorate option: %s", arg);
+
+	decoration_given =3D 1;
+
+	return 0;
+}
+
 static void cmd_log_init(int argc, const char **argv, const char *pref=
ix,
 			 struct rev_info *rev, struct setup_revision_opt *opt)
 {
-	int i;
-	int decoration_given =3D 0;
 	struct userformat_want w;
+	int help, quiet, source;
+
+	const struct option builtin_log_options[] =3D {
+		OPT_BOOLEAN(0, "h", &help, "show help"),
+		OPT_BOOLEAN(0, "quiet", &quiet, "supress diff output"),
+		OPT_BOOLEAN(0, "source", &source, "show source"),
+		{ OPTION_CALLBACK, 0, "decorate", NULL, NULL, "decorate options",
+		  PARSE_OPT_OPTARG, decorate_callback},
+		OPT_END()
+	};
+
+	argc =3D parse_options(argc, argv, prefix, builtin_log_options,
+						 builtin_log_usage,
+						 PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN |
+						 PARSE_OPT_KEEP_DASHDASH);
+
+	if (help)
+		usage(builtin_log_usage);
=20
 	rev->abbrev =3D DEFAULT_ABBREV;
 	rev->commit_format =3D CMIT_FMT_DEFAULT;
@@ -69,14 +109,12 @@ static void cmd_log_init(int argc, const char **ar=
gv, const char *prefix,
 	if (default_date_mode)
 		rev->date_mode =3D parse_date_format(default_date_mode);
=20
-	/*
-	 * Check for -h before setup_revisions(), or "git log -h" will
-	 * fail when run without a git directory.
-	 */
-	if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
-		usage(builtin_log_usage);
 	argc =3D setup_revisions(argc, argv, rev, opt);
=20
+	/* Any arguments at this point are not recognized */
+	if (argc > 1)
+		die("unrecognized argument: %s", argv[1]);
+
 	memset(&w, 0, sizeof(w));
 	userformat_find_requirements(NULL, &w);
=20
@@ -92,26 +130,9 @@ static void cmd_log_init(int argc, const char **arg=
v, const char *prefix,
 		if (rev->diffopt.nr_paths !=3D 1)
 			usage("git logs can only follow renames on one pathname at a time")=
;
 	}
-	for (i =3D 1; i < argc; i++) {
-		const char *arg =3D argv[i];
-		if (!strcmp(arg, "--decorate")) {
-			decoration_style =3D DECORATE_SHORT_REFS;
-			decoration_given =3D 1;
-		} else if (!prefixcmp(arg, "--decorate=3D")) {
-			const char *v =3D skip_prefix(arg, "--decorate=3D");
-			decoration_style =3D parse_decoration_style(arg, v);
-			if (decoration_style < 0)
-				die("invalid --decorate option: %s", arg);
-			decoration_given =3D 1;
-		} else if (!strcmp(arg, "--no-decorate")) {
-			decoration_style =3D 0;
-		} else if (!strcmp(arg, "--source")) {
-			rev->show_source =3D 1;
-		} else if (!strcmp(arg, "-h")) {
-			usage(builtin_log_usage);
-		} else
-			die("unrecognized argument: %s", arg);
-	}
+
+	if (source)
+		rev->show_source =3D 1;
=20
 	/*
 	 * defeat log.decorate configuration interacting with --pretty=3Draw
--=20
1.7.4.2.437.g4fc7e.dirty

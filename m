From: Michele Ballabio <barra_cuda@katamail.com>
Subject: [PATCH 6/9 - v3] builtin-init-db.c: use parse_options()
Date: Fri, 25 Jul 2008 21:53:28 +0200
Message-ID: <1217015608-26205-1-git-send-email-barra_cuda@katamail.com>
References: <4889EF45.1040603@free.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: dkr+ml.git@free.fr
X-From: git-owner@vger.kernel.org Fri Jul 25 21:48:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMTGh-0005n2-K3
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 21:48:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751610AbYGYTq4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 15:46:56 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751864AbYGYTq4
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 15:46:56 -0400
Received: from smtp.katamail.com ([62.149.157.154]:41337 "HELO
	smtp1.pc.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1751610AbYGYTqz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 15:46:55 -0400
Received: (qmail 16715 invoked by uid 89); 25 Jul 2008 19:46:46 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on smtp2-pc
X-Spam-Level: **
X-Spam-Status: No, score=2.3 required=5.0 tests=BAYES_50,HELO_LH_LD,RDNS_NONE
	autolearn=no version=3.2.3
Received: from unknown (HELO localhost.localdomain) (barra?cuda@katamail.com@80.104.56.56)
  by smtp2-pc with SMTP; 25 Jul 2008 19:46:44 -0000
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <4889EF45.1040603@free.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90102>

Signed-off-by: Michele Ballabio <barra_cuda@katamail.com>
---
On Friday 25 July 2008, Olivier Marin wrote:
> Michele Ballabio a =C3=A9crit :
> >=20
> >>> +		  PARSE_OPT_OPTARG, parse_opt_shared_cb, PERM_GROUP },
> >> Are you sure the default value is really used here?
> >=20
> > Yes. Perhaps I don't understand your question. Can you explain what=
 you mean?
>=20
> If I read the code correctly in parse-options.c, with OPTION_CALLBACK=
, the
> default value is not "automatically" used. You can use it in your cal=
lback
> if you want, but because you don't, I think it's never used.

Oh, you're right, but git_config_perm() handles NULL just fine, so I ca=
n
remove it. Done in this patch, thanks.

> what I suggested is more something like:
>=20
> static int parse_opt_shared_cb(const struct option *opt, const char *=
arg,
> 			       int unset)
> {
> 	*(int *)(opt->value) =3D unset ? -1 : git_config_perm("arg", arg);
> 	return 0;
> }
>=20
> int shared =3D -1;
>=20
> { OPTION_CALLBACK, 0, "shared", &shared,
> 	"permissions", "setup as shared repository",
> 	PARSE_OPT_OPTARG, parse_perm_callback },
>=20
> if (shared >=3D 0)
> 	shared_repository =3D shared;
>=20
> This way we do not change shared_repository during parsing, so we do =
not
> loose the initial value.
>=20
> But it seems nobody care about this kind of details, so perhaps, you =
can
> just ignore this suggestion.

I might be wrong, but shared_repository is initialized to PERM_UMASK an=
d
does not change before parse_options() is called, so this is not much
useful.

 builtin-init-db.c |   57 +++++++++++++++++++++++++++++++++------------=
-------
 1 files changed, 36 insertions(+), 21 deletions(-)

diff --git a/builtin-init-db.c b/builtin-init-db.c
index 38b4fcb..01b84a9 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -6,6 +6,7 @@
 #include "cache.h"
 #include "builtin.h"
 #include "exec_cmd.h"
+#include "parse-options.h"
=20
 #ifndef DEFAULT_GIT_TEMPLATE_DIR
 #define DEFAULT_GIT_TEMPLATE_DIR "/usr/share/git-core/templates"
@@ -353,8 +354,18 @@ static int guess_repository_type(const char *git_d=
ir)
 	return 1;
 }
=20
-static const char init_db_usage[] =3D
-"git init [-q | --quiet] [--bare] [--template=3D<template-directory>] =
[--shared[=3D<permissions>]]";
+static const char * const init_db_usage[] =3D {
+	"git init [-q | --quiet] [--bare] [--template=3D<dir>] [--shared[=3D<=
type>]]",
+	NULL
+};
+
+static int parse_opt_shared_cb(const struct option *opt, const char *a=
rg,
+			       int unset)
+{
+	*(int *)(opt->value) =3D unset ? PERM_UMASK :
+				       git_config_perm("arg", arg);
+	return 0;
+}
=20
 /*
  * If you want to, you can share the DB area with any number of branch=
es.
@@ -367,25 +378,29 @@ int cmd_init_db(int argc, const char **argv, cons=
t char *prefix)
 	const char *git_dir;
 	const char *template_dir =3D NULL;
 	unsigned int flags =3D 0;
-	int i;
-
-	for (i =3D 1; i < argc; i++, argv++) {
-		const char *arg =3D argv[1];
-		if (!prefixcmp(arg, "--template=3D"))
-			template_dir =3D arg+11;
-		else if (!strcmp(arg, "--bare")) {
-			static char git_dir[PATH_MAX+1];
-			is_bare_repository_cfg =3D 1;
-			setenv(GIT_DIR_ENVIRONMENT, getcwd(git_dir,
-						sizeof(git_dir)), 0);
-		} else if (!strcmp(arg, "--shared"))
-			shared_repository =3D PERM_GROUP;
-		else if (!prefixcmp(arg, "--shared=3D"))
-			shared_repository =3D git_config_perm("arg", arg+9);
-		else if (!strcmp(arg, "-q") || !strcmp(arg, "--quiet"))
-			flags |=3D INIT_DB_QUIET;
-		else
-			usage(init_db_usage);
+	int bare =3D 0;
+
+	const struct option options[] =3D {
+		OPT_STRING(0, "template", &template_dir, "path",
+			   "path to the template directory"),
+		OPT_BOOLEAN(0, "bare", &bare, "set up a bare repository"),
+		{ OPTION_CALLBACK, 0, "shared", &shared_repository,
+		  "permissions", "set up a shared repository",
+		  PARSE_OPT_OPTARG, parse_opt_shared_cb },
+		OPT_BIT('q', "quiet", &flags, "be quiet", INIT_DB_QUIET),
+		OPT_END()
+	};
+
+	argc =3D parse_options(argc, argv, options, init_db_usage, 0);
+
+	if (argc > 0)
+		usage_with_options(init_db_usage, options);
+
+	if (bare) {
+		static char git_dir[PATH_MAX+1];
+		is_bare_repository_cfg =3D 1;
+		setenv(GIT_DIR_ENVIRONMENT, getcwd(git_dir,
+					sizeof(git_dir)), 0);
 	}
=20
 	/*
--=20
1.5.6.3

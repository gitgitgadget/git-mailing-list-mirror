From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 11/12] diff.c: convert diff_scoreopt_parse to use skip_prefix()
Date: Wed, 18 Dec 2013 21:53:56 +0700
Message-ID: <1387378437-20646-12-git-send-email-pclouds@gmail.com>
References: <1387378437-20646-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 18 15:55:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtIWw-0004PC-24
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 15:55:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755207Ab3LROzP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Dec 2013 09:55:15 -0500
Received: from mail-pb0-f53.google.com ([209.85.160.53]:36324 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754693Ab3LROzL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Dec 2013 09:55:11 -0500
Received: by mail-pb0-f53.google.com with SMTP id ma3so8530157pbc.12
        for <git@vger.kernel.org>; Wed, 18 Dec 2013 06:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=rKQQHem8JkECu+0qMV3/r9HEARrRi5y1ZaZxtJKuJao=;
        b=Og1Mit7kuVlPXqf86pXaAXu9T/VOz9OuilZFy0/sfGck/Dm8rKvlieTV88YRtEfH+y
         l4FmaeWQeax7RWAqRmNyhhX0M2jzPTnG8DYXC3Tp6O9/h+62UmFystDk3EwHb8zHSOM6
         B+Jp2UYvx+EvHFd3JtjSGqwocZnr+6NRvwStQO7lPgFV+5H94zRQdRAloeDurtvO139U
         9DcFR3sFly51R5KUech74JTO6GY664ofB9ZT7m3mMwkbZET6+L3imbaWULeZ5LhpKrie
         lNI/oHNHR6Fdz9RmVNbhCT730JdS5ys+Q/S/5/SQRWuxiH99epW3/7Ja30Xg0ZyixN0c
         4bcw==
X-Received: by 10.68.218.3 with SMTP id pc3mr34695351pbc.71.1387378510809;
        Wed, 18 Dec 2013 06:55:10 -0800 (PST)
Received: from lanh ([115.73.220.136])
        by mx.google.com with ESMTPSA id z10sm718192pas.6.2013.12.18.06.55.07
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 18 Dec 2013 06:55:10 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 18 Dec 2013 21:55:07 +0700
X-Mailer: git-send-email 1.8.5.1.208.g019362e
In-Reply-To: <1387378437-20646-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239450>

While at there, partly fix the reporting as well. The reported value
with "arg+2" is only correct with -C/-B/-M, not with long option names.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 diff.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/diff.c b/diff.c
index 4da77fd..d629cc5 100644
--- a/diff.c
+++ b/diff.c
@@ -3367,7 +3367,7 @@ static int opt_arg(const char *arg, int arg_short=
, const char *arg_long, int *va
 	return 1;
 }
=20
-static int diff_scoreopt_parse(const char *opt);
+static int diff_scoreopt_parse(const char **opt);
=20
 static inline int short_opt(char opt, const char **argv,
 			    const char **optarg)
@@ -3627,13 +3627,13 @@ int diff_opt_parse(struct diff_options *options=
, const char **av, int ac)
 	/* renames options */
 	else if (starts_with(arg, "-B") || starts_with(arg, "--break-rewrites=
=3D") ||
 		 !strcmp(arg, "--break-rewrites")) {
-		if ((options->break_opt =3D diff_scoreopt_parse(arg)) =3D=3D -1)
-			return error("invalid argument to -B: %s", arg+2);
+		if ((options->break_opt =3D diff_scoreopt_parse(&arg)) =3D=3D -1)
+			return error("invalid argument to -B: %s", arg);
 	}
 	else if (starts_with(arg, "-M") || starts_with(arg, "--find-renames=3D=
") ||
 		 !strcmp(arg, "--find-renames")) {
-		if ((options->rename_score =3D diff_scoreopt_parse(arg)) =3D=3D -1)
-			return error("invalid argument to -M: %s", arg+2);
+		if ((options->rename_score =3D diff_scoreopt_parse(&arg)) =3D=3D -1)
+			return error("invalid argument to -M: %s", arg);
 		options->detect_rename =3D DIFF_DETECT_RENAME;
 	}
 	else if (!strcmp(arg, "-D") || !strcmp(arg, "--irreversible-delete"))=
 {
@@ -3643,8 +3643,8 @@ int diff_opt_parse(struct diff_options *options, =
const char **av, int ac)
 		 !strcmp(arg, "--find-copies")) {
 		if (options->detect_rename =3D=3D DIFF_DETECT_COPY)
 			DIFF_OPT_SET(options, FIND_COPIES_HARDER);
-		if ((options->rename_score =3D diff_scoreopt_parse(arg)) =3D=3D -1)
-			return error("invalid argument to -C: %s", arg+2);
+		if ((options->rename_score =3D diff_scoreopt_parse(&arg)) =3D=3D -1)
+			return error("invalid argument to -C: %s", arg);
 		options->detect_rename =3D DIFF_DETECT_COPY;
 	}
 	else if (!strcmp(arg, "--no-renames"))
@@ -3879,29 +3879,29 @@ int parse_rename_score(const char **cp_p)
 	return (int)((num >=3D scale) ? MAX_SCORE : (MAX_SCORE * num / scale)=
);
 }
=20
-static int diff_scoreopt_parse(const char *opt)
+static int diff_scoreopt_parse(const char **opt_p)
 {
+	const char *opt =3D *opt_p;
 	int opt1, opt2, cmd;
=20
 	if (*opt++ !=3D '-')
 		return -1;
 	cmd =3D *opt++;
+	*opt_p =3D opt;
 	if (cmd =3D=3D '-') {
 		/* convert the long-form arguments into short-form versions */
-		if (starts_with(opt, "break-rewrites")) {
-			opt +=3D strlen("break-rewrites");
+		if ((opt =3D skip_prefix_defval(opt, "break-rewrites", *opt_p)) !=3D=
 *opt_p) {
 			if (*opt =3D=3D 0 || *opt++ =3D=3D '=3D')
 				cmd =3D 'B';
-		} else if (starts_with(opt, "find-copies")) {
-			opt +=3D strlen("find-copies");
+		} else if ((opt =3D skip_prefix_defval(opt, "find-copies", *opt_p)) =
!=3D *opt_p) {
 			if (*opt =3D=3D 0 || *opt++ =3D=3D '=3D')
 				cmd =3D 'C';
-		} else if (starts_with(opt, "find-renames")) {
-			opt +=3D strlen("find-renames");
+		} else if ((opt =3D skip_prefix_defval(opt, "find-renames", *opt_p))=
 !=3D *opt_p) {
 			if (*opt =3D=3D 0 || *opt++ =3D=3D '=3D')
 				cmd =3D 'M';
 		}
 	}
+	*opt_p =3D opt;
 	if (cmd !=3D 'M' && cmd !=3D 'C' && cmd !=3D 'B')
 		return -1; /* that is not a -M, -C nor -B option */
=20
--=20
1.8.5.1.208.g019362e

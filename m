From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 08/15] for-each-ref: get --pretty using format_commit_message
Date: Tue,  4 Jun 2013 18:05:30 +0530
Message-ID: <1370349337-20938-9-git-send-email-artagnon@gmail.com>
References: <1370349337-20938-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 04 14:34:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjqRg-00078F-8w
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 14:34:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754035Ab3FDMeS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Jun 2013 08:34:18 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:39866 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752838Ab3FDMeN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 08:34:13 -0400
Received: by mail-pa0-f42.google.com with SMTP id rl6so312655pac.15
        for <git@vger.kernel.org>; Tue, 04 Jun 2013 05:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=i5z/3Lt4Pe20yGg3IuN4Gi9L4/lNHtOo7/N2Wq8h0cA=;
        b=dkiqmx7gx07yutfnnjZmLm0eWWHIGDcld+2K7GZZfBND6kDi/QZIUkq5Ownv9dMuMC
         p5P0eFT1vYTczf9l0qYZ33fjESLLa/gxuHKDEHgHbVy790D1JGyyX8+1kZIjWbvtv42b
         mj927qYXtToIZOisb+aBudrHMwpBtlIx3U2YfHtf4c0Zx7V9+o1+EypxtK4dlDNDhaWa
         al52hUKR7/zWtE9BkPuuVsM19PEYjylNFpBn6QSEJ4guWpTLpqVTsApo1VTSflEAH0aJ
         8bBGY2ONxHY8dMA81jwxCSTv205woge61IM7JcP6kBdzApl0PpDo+enAkYdfFjjnaoLf
         HlYg==
X-Received: by 10.68.78.37 with SMTP id y5mr28082830pbw.28.1370349253046;
        Tue, 04 Jun 2013 05:34:13 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id vz8sm67423587pac.20.2013.06.04.05.34.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 04 Jun 2013 05:34:12 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.GIT
In-Reply-To: <1370349337-20938-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226351>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

--format is very limited in its capabilities.  Introduce --pretty, whic=
h
extends the existing --format with pretty-formats.  In --pretty:

 - Existing --format %(atom) is available. They also accept some pretty
   magic.  For example, you can use "% (atom)" to only display a leadin=
g
   space if the atom produces something.

 - %ab to display a hex character 0xab is not available as it may
   conflict with other pretty's placeholders.  Use %xab instead.

 - Many pretty placeholders are designed to work on commits.  While som=
e
   of them should work on tags too, they don't (yet).

 - Unsupported atoms cause for-each-ref to exit early and report.
   Unsupported pretty placeholders are displayed as-is.

 - Pretty placeholders can not be used as a sorting criteria.

--format is considered deprecated. If the user hits a bug specific in
--format code, they are advised to migrate to --pretty.

[rr: documentation]

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-for-each-ref.txt | 22 ++++++++++++-
 builtin/for-each-ref.c             | 67 ++++++++++++++++++++++++++++++=
++++++--
 2 files changed, 85 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for=
-each-ref.txt
index f2e08d1..6135812 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -9,7 +9,8 @@ SYNOPSIS
 --------
 [verse]
 'git for-each-ref' [--count=3D<count>] [--shell|--perl|--python|--tcl]
-		   [(--sort=3D<key>)...] [--format=3D<format>] [<pattern>...]
+		   [(--sort=3D<key>)...] [--format=3D<format>|--pretty=3D<pretty>]
+		   [<pattern>...]
=20
 DESCRIPTION
 -----------
@@ -47,6 +48,25 @@ OPTIONS
 	`xx`; for example `%00` interpolates to `\0` (NUL),
 	`%09` to `\t` (TAB) and `%0a` to `\n` (LF).
=20
+<pretty>::
+	A format string with supporting placeholders described in the
+	"PRETTY FORMATS" section in linkgit:git-log[1].  Additionally
+	supports placeholders from `<format>`
+	(i.e. `%[*](fieldname)`).
++
+Caveats:
+
+1. Many of the placeholders in "PRETTY FORMATS" are designed to work
+   specifically on commit objects: when non-commit objects are
+   supplied, those placeholders won't work.
+
+2. Does not interpolate `%ab` (where `ab` are hex digits) with the
+   corresponding hex code.  To print a byte from a hex code, use
+   `%xab` (from pretty-formats) instead.
+
+3. Only the placeholders inherited from `<format>` will respect
+   quoting settings.
+
 <pattern>...::
 	If one or more patterns are given, only refs are shown that
 	match against at least one pattern, either using fnmatch(3) or
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index e2d6c5a..576a882 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -962,6 +962,58 @@ static void show_refs(struct refinfo **refs, int m=
axcount,
 	strbuf_release(&sb);
 }
=20
+struct format_one_atom_context {
+	struct refinfo *info;
+	int quote_style;
+};
+
+static size_t format_one_atom(struct strbuf *sb, const char *placehold=
er,
+			      void *format_context, void *user_data,
+			      struct strbuf *subst)
+{
+	struct format_one_atom_context *ctx =3D user_data;
+	const char *ep;
+
+	if (*placeholder =3D=3D '%') {
+		strbuf_addch(sb, '%');
+		return 1;
+	}
+
+	if (*placeholder !=3D '(')
+		return 0;
+
+	ep =3D strchr(placeholder + 1, ')');
+	if (!ep)
+		return 0;
+	print_value(sb, ctx->info, parse_atom(placeholder + 1, ep),
+		    ctx->quote_style);
+	return ep + 1 - placeholder;
+}
+
+static void show_pretty_refs(struct refinfo **refs, int maxcount,
+			     const char *format, int quote_style)
+{
+	struct pretty_print_context ctx =3D {0};
+	struct format_one_atom_context fctx;
+	struct strbuf sb =3D STRBUF_INIT;
+	int i;
+
+	ctx.format =3D format_one_atom;
+	ctx.user_data =3D &fctx;
+	fctx.quote_style =3D quote_style;
+	for (i =3D 0; i < maxcount; i++) {
+		struct commit *commit =3D NULL;
+		fctx.info =3D refs[i];
+		if (sha1_object_info(refs[i]->objectname, NULL) =3D=3D OBJ_COMMIT)
+			commit =3D lookup_commit(refs[i]->objectname);
+		strbuf_reset(&sb);
+		format_commit_message(commit, format, &sb, &ctx);
+		strbuf_addch(&sb, '\n');
+		fputs(sb.buf, stdout);
+	}
+	strbuf_release(&sb);
+}
+
 static struct ref_sort *default_sort(void)
 {
 	static const char cstr_name[] =3D "refname";
@@ -1003,7 +1055,9 @@ static char const * const for_each_ref_usage[] =3D=
 {
 int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 {
 	int num_refs;
-	const char *format =3D "%(objectname) %(objecttype)\t%(refname)";
+	const char *default_format =3D "%(objectname) %(objecttype)\t%(refnam=
e)";
+	const char *format =3D default_format;
+	const char *pretty =3D NULL;
 	struct ref_sort *sort =3D NULL, **sort_tail =3D &sort;
 	int maxcount =3D 0, quote_style =3D 0;
 	struct refinfo **refs;
@@ -1022,6 +1076,7 @@ int cmd_for_each_ref(int argc, const char **argv,=
 const char *prefix)
 		OPT_GROUP(""),
 		OPT_INTEGER( 0 , "count", &maxcount, N_("show only <n> matched refs"=
)),
 		OPT_STRING(  0 , "format", &format, N_("format"), N_("format to use =
for the output")),
+		OPT_STRING(  0 , "pretty", &pretty, N_("format"), N_("alternative fo=
rmat to use for the output")),
 		OPT_CALLBACK(0 , "sort", sort_tail, N_("key"),
 			    N_("field name to sort on"), &opt_parse_sort),
 		OPT_END(),
@@ -1036,7 +1091,10 @@ int cmd_for_each_ref(int argc, const char **argv=
, const char *prefix)
 		error("more than one quoting style?");
 		usage_with_options(for_each_ref_usage, opts);
 	}
-	if (verify_format(format))
+	if (format !=3D default_format && pretty)
+		die("--format and --pretty cannot be used together");
+	if ((pretty && verify_format(pretty)) ||
+	    (!pretty && verify_format(format)))
 		usage_with_options(for_each_ref_usage, opts);
=20
 	if (!sort)
@@ -1057,6 +1115,9 @@ int cmd_for_each_ref(int argc, const char **argv,=
 const char *prefix)
 	if (!maxcount || num_refs < maxcount)
 		maxcount =3D num_refs;
=20
-	show_refs(refs, maxcount, format, quote_style);
+	if (pretty)
+		show_pretty_refs(refs, maxcount, pretty, quote_style);
+	else
+		show_refs(refs, maxcount, format, quote_style);
 	return 0;
 }
--=20
1.8.3.GIT

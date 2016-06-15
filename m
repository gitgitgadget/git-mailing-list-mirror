From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 08/15] for-each-ref: get --pretty using format_commit_message()
Date: Sun,  9 Jun 2013 23:24:27 +0530
Message-ID: <1370800474-8940-9-git-send-email-artagnon@gmail.com>
References: <1370800474-8940-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 09 19:57:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UljrR-0006Xv-Ex
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 19:57:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751931Ab3FIR45 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 13:56:57 -0400
Received: from mail-pb0-f47.google.com ([209.85.160.47]:48484 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751922Ab3FIR4z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 13:56:55 -0400
Received: by mail-pb0-f47.google.com with SMTP id rr13so3822764pbb.20
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 10:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=411DIy5+YF/ed3lWTQpSXatYH6N6o9VCAmhsu8xgzq4=;
        b=Gy01yiYZ5HI5EIJIeVNWOMhzGxShsi65/wtZjoyxmXir0LHWtP2uvZdOvmcMk+bpQO
         QxCyjE2gxtgMJOIuQqiVDDnU+a7Ox23jZKkr4Hm1yY5zMxL9uLFDLeMd6qTegEAuGMaC
         tr9qUIdWPsppsAtRGUoKFTFpur1IJV+9jo95iHbb4ijdvY3vIszdWh4kC7sMAn//gWMm
         +4glu8q9Kzxfr7CvVce0BURGSmxmtlDN8Agm3wctP3bfylbnJl4b8z2Rbr4Q0Usnyzrw
         ewzBvUSidM+j5dU56Ozdwgs/0khO9jJTw3WA0XDqWKc4P3ExDODte+U9Td9pobGQ5096
         Cg4g==
X-Received: by 10.67.21.226 with SMTP id hn2mr10979634pad.135.1370800614758;
        Sun, 09 Jun 2013 10:56:54 -0700 (PDT)
Received: from localhost.localdomain ([122.164.213.38])
        by mx.google.com with ESMTPSA id qp4sm7275815pbc.41.2013.06.09.10.56.52
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 10:56:54 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.247.g485169c
In-Reply-To: <1370800474-8940-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227064>

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

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-for-each-ref.txt |  23 ++++++-
 builtin/for-each-ref.c             |  72 +++++++++++++++++++++-
 t/t6300-for-each-ref.sh            | 123 +++++++++++++++++++++++++++++=
++++++++
 3 files changed, 214 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for=
-each-ref.txt
index f2e08d1..d8ad758 100644
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
@@ -47,6 +48,26 @@ OPTIONS
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
+   supplied, those placeholders won't work (i.e. they will be emitted
+   literally).
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
index e2d6c5a..8611777 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -962,6 +962,63 @@ static void show_refs(struct refinfo **refs, int m=
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
+	/*
+	 * FIXME: add --date=3D for %ad, --decorate for %d and --color
+	 * for %C
+	 */
+	ctx.abbrev =3D DEFAULT_ABBREV;
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
@@ -1003,7 +1060,9 @@ static char const * const for_each_ref_usage[] =3D=
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
@@ -1022,6 +1081,7 @@ int cmd_for_each_ref(int argc, const char **argv,=
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
@@ -1036,7 +1096,10 @@ int cmd_for_each_ref(int argc, const char **argv=
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
@@ -1057,6 +1120,9 @@ int cmd_for_each_ref(int argc, const char **argv,=
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
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 752f5cb..d39e0b4 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -48,6 +48,20 @@ test_atom() {
 	"
 }
=20
+test_pretty() {
+	case "$1" in
+		head) ref=3Drefs/heads/master ;;
+		 tag) ref=3Drefs/tags/testtag ;;
+		   *) ref=3D$1 ;;
+	esac
+	printf '%s\n' "$3" >expected
+	test_expect_${4:-success} $PREREQ "basic pretty: $1 $2" "
+		git for-each-ref --pretty=3D'$2' $ref >actual &&
+		sanitize_pgp <actual >actual.clean &&
+		test_cmp expected actual.clean
+	"
+}
+
 test_atom head refname refs/heads/master
 test_atom head upstream refs/remotes/origin/master
 test_atom head objecttype commit
@@ -114,6 +128,115 @@ test_atom tag contents:signature ''
 test_atom tag contents 'Tagging at 1151939927
 '
=20
+echo "Mailmap'd <map@example.com> <author@example.com>" > $HOME/.mailm=
ap
+
+test_pretty head '%(refname)' refs/heads/master
+test_pretty head '%(upstream)' refs/remotes/origin/master
+test_pretty head '%(objecttype)' commit
+test_pretty head '%(objectsize)' 171
+test_pretty head '%(objectname)' 67a36f10722846e891fbada1ba48ed035de75=
581
+test_pretty head '%H' 67a36f10722846e891fbada1ba48ed035de75581
+test_pretty head '%h' 67a36f1
+test_pretty head '%(tree)' 0e51c00fcb93dffc755546f27593d511e1bdb46f
+test_pretty head '%T' 0e51c00fcb93dffc755546f27593d511e1bdb46f
+test_pretty head '%t' 0e51c00
+test_pretty head '%(parent)' ''
+test_pretty head '%P' ''
+test_pretty head '%(numparent)' 0
+test_pretty head '%(object)' ''
+test_pretty head '%(type)' ''
+test_pretty head '%(author)' 'A U Thor <author@example.com> 1151939924=
 +0200'
+test_pretty head '%(authorname)' 'A U Thor'
+test_pretty head '%an' 'A U Thor'
+test_pretty head '%aN' "Mailmap'd"
+test_pretty head '%(authoremail)' '<author@example.com>'
+test_pretty head '%ae' 'author@example.com'
+test_pretty head '%aE' 'map@example.com'
+test_pretty head '%(authordate)' 'Mon Jul 3 17:18:44 2006 +0200'
+test_pretty head '%aD' 'Mon, 3 Jul 2006 17:18:44 +0200'
+test_pretty head '%(committer)' 'C O Mitter <committer@example.com> 11=
51939923 +0200'
+test_pretty head '%(committername)' 'C O Mitter'
+test_pretty head '%cn' 'C O Mitter'
+test_pretty head '%(committeremail)' '<committer@example.com>'
+test_pretty head '%ce' 'committer@example.com'
+test_pretty head '%(committerdate)' 'Mon Jul 3 17:18:43 2006 +0200'
+test_pretty head '%cD' 'Mon, 3 Jul 2006 17:18:43 +0200'
+test_pretty head '%(tag)' ''
+test_pretty head '%(tagger)' ''
+test_pretty head '%(taggername)' ''
+test_pretty head '%(taggeremail)' ''
+test_pretty head '%(taggerdate)' ''
+test_pretty head '%(creator)' 'C O Mitter <committer@example.com> 1151=
939923 +0200'
+test_pretty head '%(creatordate)' 'Mon Jul 3 17:18:43 2006 +0200'
+test_pretty head '%(subject)' 'Initial'
+test_pretty head '%(contents:subject)' 'Initial'
+test_pretty head '%(body)' ''
+test_pretty head '%(contents:body)' ''
+test_pretty head '%(contents:signature)' ''
+test_pretty head '%(contents)' 'Initial
+'
+
+test_pretty head '%d' ' (HEAD, tag: testtag, origin/master, master)'
+test_pretty head '%x20' ' '
+test_pretty head '%g' '%g'
+test_pretty head '%unknown' '%unknown'
+test_pretty head '% (parent)' ''
+test_pretty head '% P' ''
+test_pretty head '% (tree)' ' 0e51c00fcb93dffc755546f27593d511e1bdb46f=
'
+test_pretty head '% T' ' 0e51c00fcb93dffc755546f27593d511e1bdb46f'
+
+test_expect_success '% (unknown)' '
+	test_must_fail git for-each-ref --pretty=3D"% (unknown)" refs/heads/m=
aster
+'
+
+test_pretty head '%<(20)%cn end' 'C O Mitter           end'
+test_pretty head '%>(20)%cn end' '          C O Mitter end'
+test_pretty head '%><(20)%cn end' '     C O Mitter      end'
+test_pretty head '%<(20)%(committername) end' 'C O Mitter           en=
d'
+test_pretty head '%>(20)%(committername) end' '          C O Mitter en=
d'
+test_pretty head '%><(20)%(committername) end' '     C O Mitter      e=
nd'
+
+test_pretty tag '%(refname)' refs/tags/testtag
+test_pretty tag '%(upstream)' ''
+test_pretty tag '%(objecttype)' tag
+test_pretty tag '%(objectsize)' 154
+test_pretty tag '%(objectname)' 98b46b1d36e5b07909de1b3886224e3e81e873=
22
+test_pretty tag '%(tree)' ''
+test_pretty tag '%(parent)' ''
+test_pretty tag '%(numparent)' ''
+test_pretty tag '%(object)' '67a36f10722846e891fbada1ba48ed035de75581'
+test_pretty tag '%(type)' 'commit'
+test_pretty tag '%(author)' ''
+test_pretty tag '%(authorname)' ''
+test_pretty tag '%(authoremail)' ''
+test_pretty tag '%(authordate)' ''
+test_pretty tag '%(committer)' ''
+test_pretty tag '%(committername)' ''
+test_pretty tag '%(committeremail)' ''
+test_pretty tag '%(committerdate)' ''
+test_pretty tag '%(tag)' 'testtag'
+test_pretty tag '%(tagger)' 'C O Mitter <committer@example.com> 115193=
9925 +0200'
+test_pretty tag '%(taggername)' 'C O Mitter'
+test_pretty tag '%(taggeremail)' '<committer@example.com>'
+test_pretty tag '%(taggerdate)' 'Mon Jul 3 17:18:45 2006 +0200'
+test_pretty tag '%(creator)' 'C O Mitter <committer@example.com> 11519=
39925 +0200'
+test_pretty tag '%(creatordate)' 'Mon Jul 3 17:18:45 2006 +0200'
+test_pretty tag '%(subject)' 'Tagging at 1151939927'
+test_pretty tag '%(contents:subject)' 'Tagging at 1151939927'
+test_pretty tag '%(body)' ''
+test_pretty tag '%(contents:body)' ''
+test_pretty tag '%(contents:signature)' ''
+test_pretty tag '%(contents)' 'Tagging at 1151939927
+'
+
+# make sure we don't segfault when non-commits are passed in
+# format_commit_message. Should be fixed so that some of these
+# placeholders produce something useful for non-commits.
+test_pretty tag '%H' '%H'
+test_pretty tag '%h' '%h'
+test_pretty tag '%T' '%T'
+test_pretty tag '%t' '%t'
+
 test_expect_success 'Check invalid atoms names are errors' '
 	test_must_fail git for-each-ref --format=3D"%(INVALID)" refs/heads
 '
--=20
1.8.3.247.g485169c

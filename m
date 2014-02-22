From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2] tag: support --sort=<spec>
Date: Sat, 22 Feb 2014 10:29:22 +0700
Message-ID: <1393039762-4843-1-git-send-email-pclouds@gmail.com>
References: <1392817167-29802-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 22 04:29:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WH3HY-0008OB-CA
	for gcvg-git-2@plane.gmane.org; Sat, 22 Feb 2014 04:29:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753459AbaBVD3N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Feb 2014 22:29:13 -0500
Received: from mail-pa0-f48.google.com ([209.85.220.48]:32918 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753129AbaBVD3M (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Feb 2014 22:29:12 -0500
Received: by mail-pa0-f48.google.com with SMTP id kx10so4265925pab.21
        for <git@vger.kernel.org>; Fri, 21 Feb 2014 19:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=M45zGL2rWIY/J9TuDT46dca0MsMdvS9OtylRhlOUpVE=;
        b=dfcQuee9JxHym7Y7ke48rZiGnzBrb/wzFoYc2GSNlTsXOG6Au+pR79HO21Xzq/sjlP
         n3SDzSimOP6/SqbPpaPyZ87tbGeVf/zD4Wf31R9gfHdTbijELHsMbNOqrJvv0lj/MpDP
         fI2WbP6B7tLVaJlSw7wfcasdgEo0eqddmf92XQrj0zZ/LXMjlzV9zvBNY7jKl3dt9GZj
         86FItd7WtnX/u0XqsceF+k5mI+xR1LAfFFjpPVfv74/TlFY6nJ7VVd2r65iW+z4aU0sE
         Wjwy305F70ye+8LBojpzrU6ww/EYIZ08Cu59ZkqEW+8kKP66CTUI5KfC9IPEYQ1hjvVp
         sUUg==
X-Received: by 10.68.129.234 with SMTP id nz10mr13104441pbb.16.1393039751324;
        Fri, 21 Feb 2014 19:29:11 -0800 (PST)
Received: from lanh ([115.73.213.219])
        by mx.google.com with ESMTPSA id vx10sm62295614pac.17.2014.02.21.19.29.06
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 21 Feb 2014 19:29:10 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 22 Feb 2014 10:29:27 +0700
X-Mailer: git-send-email 1.9.0.40.gaa8c3ea
In-Reply-To: <1392817167-29802-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242499>

--sort=3Drefname:version (or --sort=3Drefname:v for short) sorts tags a=
s
if they are versions. --sort=3D-refname reverses the order (with or
without ":version"). This syntax is chosen to make it compatible with
future extension in "for-each-ref --sort"

GNU extension strverscmp is used so this is Linux only. Mac and
Windows will need to bundle a compat implementation (and long term we
may want to use compat version only so we can make XXX-rc, XXX-pre...
appear before XXX)

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 The new prereq GNULINUX is an ugly workaround until people provide
 strverscmp compat implementation. I hope that will happen soon as
 strverscmp.c does not look very complex.

 Documentation/git-tag.txt |  6 +++++
 builtin/tag.c             | 69 +++++++++++++++++++++++++++++++++++++++=
++++----
 git-compat-util.h         |  7 +++++
 t/t7004-tag.sh            | 43 +++++++++++++++++++++++++++++
 t/test-lib.sh             |  2 ++
 5 files changed, 122 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 404257d..d8633bb 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -95,6 +95,12 @@ OPTIONS
 	using fnmatch(3)).  Multiple patterns may be given; if any of
 	them matches, the tag is shown.
=20
+--sort=3D<type>::
+	Sort in a specific order. Supported type is "refname"
+	(lexical order), "refname:version" or "refname:v" (tag names
+	are treated as version strings). Prepend "-" to reverse sorting
+	order.
+
 --column[=3D<options>]::
 --no-column::
 	Display tag listing in columns. See configuration variable
diff --git a/builtin/tag.c b/builtin/tag.c
index 74d3780..483d293 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -27,9 +27,16 @@ static const char * const git_tag_usage[] =3D {
 	NULL
 };
=20
+#define STRCMP_SORT     0	/* must be zero */
+#define STRVERSCMP_SORT 1
+#define SORT_MASK       0x7fff
+#define REVERSE_SORT    0x8000
+
 struct tag_filter {
 	const char **patterns;
 	int lines;
+	int sort;
+	struct string_list tags;
 	struct commit_list *with_commit;
 };
=20
@@ -166,7 +173,10 @@ static int show_reference(const char *refname, con=
st unsigned char *sha1,
 			return 0;
=20
 		if (!filter->lines) {
-			printf("%s\n", refname);
+			if (filter->sort)
+				string_list_append(&filter->tags, refname);
+			else
+				printf("%s\n", refname);
 			return 0;
 		}
 		printf("%-15s ", refname);
@@ -177,17 +187,39 @@ static int show_reference(const char *refname, co=
nst unsigned char *sha1,
 	return 0;
 }
=20
+static int sort_by_version(const void *a_, const void *b_)
+{
+	const struct string_list_item *a =3D a_;
+	const struct string_list_item *b =3D b_;
+	return strverscmp(a->string, b->string);
+}
+
 static int list_tags(const char **patterns, int lines,
-			struct commit_list *with_commit)
+		     struct commit_list *with_commit, int sort)
 {
 	struct tag_filter filter;
=20
 	filter.patterns =3D patterns;
 	filter.lines =3D lines;
+	filter.sort =3D sort;
 	filter.with_commit =3D with_commit;
+	memset(&filter.tags, 0, sizeof(filter.tags));
+	filter.tags.strdup_strings =3D 1;
=20
 	for_each_tag_ref(show_reference, (void *) &filter);
-
+	if (sort) {
+		int i;
+		if ((sort & SORT_MASK) =3D=3D STRVERSCMP_SORT)
+			qsort(filter.tags.items, filter.tags.nr,
+			      sizeof(struct string_list_item), sort_by_version);
+		if (sort & REVERSE_SORT)
+			for (i =3D filter.tags.nr - 1; i >=3D 0; i--)
+				printf("%s\n", filter.tags.items[i].string);
+		else
+			for (i =3D 0; i < filter.tags.nr; i++)
+				printf("%s\n", filter.tags.items[i].string);
+		string_list_clear(&filter.tags, 0);
+	}
 	return 0;
 }
=20
@@ -427,6 +459,27 @@ static int parse_opt_points_at(const struct option=
 *opt __attribute__((unused)),
 	return 0;
 }
=20
+static int parse_opt_sort(const struct option *opt, const char *arg, i=
nt unset)
+{
+	int *sort =3D opt->value;
+	if (*arg =3D=3D '-') {
+		*sort =3D REVERSE_SORT;
+		arg++;
+	} else
+		*sort =3D STRCMP_SORT;
+	if (!starts_with(arg, "refname") ||
+	    (arg[7] !=3D ':' && arg[7] !=3D '\0'))
+		die(_("unsupported sort field %s"), arg);
+	if (arg[7] =3D=3D ':') {
+		const char *modifier =3D arg + 8;
+		if (!strcmp(modifier, "version") || !strcmp(modifier, "v"))
+			*sort |=3D STRVERSCMP_SORT;
+		else
+			die(_("unsupported modifier %s"), modifier);
+	}
+	return 0;
+}
+
 int cmd_tag(int argc, const char **argv, const char *prefix)
 {
 	struct strbuf buf =3D STRBUF_INIT;
@@ -437,7 +490,7 @@ int cmd_tag(int argc, const char **argv, const char=
 *prefix)
 	struct create_tag_options opt;
 	char *cleanup_arg =3D NULL;
 	int annotate =3D 0, force =3D 0, lines =3D -1;
-	int cmdmode =3D 0;
+	int cmdmode =3D 0, sort =3D 0;
 	const char *msgfile =3D NULL, *keyid =3D NULL;
 	struct msg_arg msg =3D { 0, STRBUF_INIT };
 	struct commit_list *with_commit =3D NULL;
@@ -462,6 +515,10 @@ int cmd_tag(int argc, const char **argv, const cha=
r *prefix)
 					N_("use another key to sign the tag")),
 		OPT__FORCE(&force, N_("replace the tag if exists")),
 		OPT_COLUMN(0, "column", &colopts, N_("show tag list in columns")),
+		{
+			OPTION_CALLBACK, 0, "sort", &sort, N_("type"), N_("sort tags"),
+			PARSE_OPT_NONEG, parse_opt_sort
+		},
=20
 		OPT_GROUP(N_("Tag listing options")),
 		{
@@ -509,7 +566,9 @@ int cmd_tag(int argc, const char **argv, const char=
 *prefix)
 			copts.padding =3D 2;
 			run_column_filter(colopts, &copts);
 		}
-		ret =3D list_tags(argv, lines =3D=3D -1 ? 0 : lines, with_commit);
+		if (lines !=3D -1 && sort)
+			die(_("--sort and -n are incompatible"));
+		ret =3D list_tags(argv, lines =3D=3D -1 ? 0 : lines, with_commit, so=
rt);
 		if (column_active(colopts))
 			stop_column_filter();
 		return ret;
diff --git a/git-compat-util.h b/git-compat-util.h
index cbd86c3..22089e9 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -721,4 +721,11 @@ void warn_on_inaccessible(const char *path);
 /* Get the passwd entry for the UID of the current process. */
 struct passwd *xgetpwuid_self(void);
=20
+#ifndef __GNU_LIBRARY__
+static inline int strverscmp(const char *s1, const char *s2)
+{
+	die("strverscmp() not supported");
+}
+#endif
+
 #endif
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index c8d6e9f..0b7b170 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1380,4 +1380,47 @@ test_expect_success 'multiple --points-at are OR=
-ed together' '
 	test_cmp expect actual
 '
=20
+test_expect_success GNULINUX 'lexical sort' '
+	git tag foo1.3 &&
+	git tag foo1.6 &&
+	git tag foo1.10 &&
+	git tag -l --sort=3Drefname "foo*" >actual &&
+	cat >expect <<EOF &&
+foo1.10
+foo1.3
+foo1.6
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success GNULINUX 'version sort' '
+	git tag -l --sort=3Drefname:version "foo*" >actual &&
+	cat >expect <<EOF &&
+foo1.3
+foo1.6
+foo1.10
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success GNULINUX 'reverse version sort' '
+	git tag -l --sort=3D-refname:version "foo*" >actual &&
+	cat >expect <<EOF &&
+foo1.10
+foo1.6
+foo1.3
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success GNULINUX 'reverse lexical sort' '
+	git tag -l --sort=3D-refname "foo*" >actual &&
+	cat >expect <<EOF &&
+foo1.6
+foo1.3
+foo1.10
+EOF
+	test_cmp expect actual
+'
+
 test_done
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 1531c24..5e8c39a 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -771,6 +771,8 @@ case $(uname -s) in
 	;;
 esac
=20
+[ "$(uname -o)" =3D "GNU/Linux" ] && test_set_prereq GNULINUX
+
 ( COLUMNS=3D1 && test $COLUMNS =3D 1 ) && test_set_prereq COLUMNS_CAN_=
BE_1
 test -z "$NO_PERL" && test_set_prereq PERL
 test -z "$NO_PYTHON" && test_set_prereq PYTHON
--=20
1.9.0.40.gaa8c3ea

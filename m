From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] tag: support --sort=version
Date: Wed, 19 Feb 2014 20:39:27 +0700
Message-ID: <1392817167-29802-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 19 14:39:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WG7NB-0000Cp-F6
	for gcvg-git-2@plane.gmane.org; Wed, 19 Feb 2014 14:39:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752637AbaBSNjS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Feb 2014 08:39:18 -0500
Received: from mail-pa0-f41.google.com ([209.85.220.41]:57731 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752480AbaBSNjR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Feb 2014 08:39:17 -0500
Received: by mail-pa0-f41.google.com with SMTP id fa1so397040pad.14
        for <git@vger.kernel.org>; Wed, 19 Feb 2014 05:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=bdopULz+MgQ8fcLSRdDKmDm8R9dW0jTISm0vEmDrVsc=;
        b=YFR0D0aqFK9v+CvJhzruBqoll32q9gY3VRwMWmhsYC0DyXhOP2i/WPdfex2fVxALXn
         /jiphgZXTwAnEWoAEzZ9AbzaAgP6LbiyRA0uW39ygyJl4e/otNUKulKp4snUopu67k79
         lqO2G7f6lrXSIK+DnQr8goFkfO5a3/XnlNW2Gzgk8E7zyBWEVIGEaecc1xJwJusIyeCr
         Wqnm0lkCLS18WmvR2YF1UENDPYC9vMAdI8o31BjeYhJ3E8IwBnjaBHyr7cecS0irPtzE
         GfNbfFJPW/VJRBLIwOI9dPHeQvsIeQsvPjIst9GWP05xTzt0SnNeGxrk9f7mO/RU1poe
         0eXg==
X-Received: by 10.66.164.70 with SMTP id yo6mr2358477pab.85.1392817156851;
        Wed, 19 Feb 2014 05:39:16 -0800 (PST)
Received: from lanh ([115.73.206.30])
        by mx.google.com with ESMTPSA id g6sm1726150pat.2.2014.02.19.05.39.12
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 19 Feb 2014 05:39:14 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 19 Feb 2014 20:39:28 +0700
X-Mailer: git-send-email 1.9.0.40.gaa8c3ea
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242392>

--sort=3Dversion sorts tags as versions. GNU extension's strverscmp is
used and no real compat implementation is provided so this is Linux onl=
y.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 I didn't know that coreutils' sort is simply a wrapper of strverscmp.
 With that GNU extension, implementing --sort is easy. Mac and Windows
 are welcome to reimplement strverscmp (of rip it off glibc).

 Documentation/git-tag.txt |  4 ++++
 builtin/tag.c             | 49 +++++++++++++++++++++++++++++++++++++++=
+++-----
 git-compat-util.h         |  7 +++++++
 3 files changed, 55 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 404257d..fc23dc0 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -95,6 +95,10 @@ OPTIONS
 	using fnmatch(3)).  Multiple patterns may be given; if any of
 	them matches, the tag is shown.
=20
+--sort=3D<type>::
+	Sort in a specific order. Supported type is "version". Prepend
+	"-" to revert sort order.
+
 --column[=3D<options>]::
 --no-column::
 	Display tag listing in columns. See configuration variable
diff --git a/builtin/tag.c b/builtin/tag.c
index 74d3780..db3567b 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -30,6 +30,8 @@ static const char * const git_tag_usage[] =3D {
 struct tag_filter {
 	const char **patterns;
 	int lines;
+	int version_sort;
+	struct string_list tags;
 	struct commit_list *with_commit;
 };
=20
@@ -166,7 +168,10 @@ static int show_reference(const char *refname, con=
st unsigned char *sha1,
 			return 0;
=20
 		if (!filter->lines) {
-			printf("%s\n", refname);
+			if (filter->version_sort)
+				string_list_append(&filter->tags, refname);
+			else
+				printf("%s\n", refname);
 			return 0;
 		}
 		printf("%-15s ", refname);
@@ -177,17 +182,38 @@ static int show_reference(const char *refname, co=
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
+		     struct commit_list *with_commit, int version_sort)
 {
 	struct tag_filter filter;
=20
 	filter.patterns =3D patterns;
 	filter.lines =3D lines;
+	filter.version_sort =3D version_sort;
 	filter.with_commit =3D with_commit;
+	memset(&filter.tags, 0, sizeof(filter.tags));
+	filter.tags.strdup_strings =3D 1;
=20
 	for_each_tag_ref(show_reference, (void *) &filter);
-
+	if (version_sort) {
+		int i;
+		qsort(filter.tags.items, filter.tags.nr,
+		      sizeof(struct string_list_item), sort_by_version);
+		if (version_sort > 0)
+			for (i =3D 0; i < filter.tags.nr; i++)
+				printf("%s\n", filter.tags.items[i].string);
+		else
+			for (i =3D filter.tags.nr - 1; i >=3D 0; i--)
+				printf("%s\n", filter.tags.items[i].string);
+		string_list_clear(&filter.tags, 0);
+	}
 	return 0;
 }
=20
@@ -437,7 +463,8 @@ int cmd_tag(int argc, const char **argv, const char=
 *prefix)
 	struct create_tag_options opt;
 	char *cleanup_arg =3D NULL;
 	int annotate =3D 0, force =3D 0, lines =3D -1;
-	int cmdmode =3D 0;
+	int cmdmode =3D 0, version_sort =3D 0;
+	const char *sort =3D NULL;
 	const char *msgfile =3D NULL, *keyid =3D NULL;
 	struct msg_arg msg =3D { 0, STRBUF_INIT };
 	struct commit_list *with_commit =3D NULL;
@@ -462,6 +489,7 @@ int cmd_tag(int argc, const char **argv, const char=
 *prefix)
 					N_("use another key to sign the tag")),
 		OPT__FORCE(&force, N_("replace the tag if exists")),
 		OPT_COLUMN(0, "column", &colopts, N_("show tag list in columns")),
+		OPT_STRING(0, "sort", &sort, N_("type"), N_("sort tags")),
=20
 		OPT_GROUP(N_("Tag listing options")),
 		{
@@ -509,7 +537,18 @@ int cmd_tag(int argc, const char **argv, const cha=
r *prefix)
 			copts.padding =3D 2;
 			run_column_filter(colopts, &copts);
 		}
-		ret =3D list_tags(argv, lines =3D=3D -1 ? 0 : lines, with_commit);
+		if (sort) {
+			if (!strcmp(sort, "version"))
+				version_sort =3D 1;
+			else if (!strcmp(sort, "-version"))
+				version_sort =3D -1;
+			else
+				die(_("unsupported sort type %s"), sort);
+		}
+		if (lines !=3D -1 && version_sort)
+			die(_("--sort and -l are incompatible"));
+		ret =3D list_tags(argv, lines =3D=3D -1 ? 0 : lines, with_commit,
+				version_sort);
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
--=20
1.9.0.40.gaa8c3ea

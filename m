From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 6/6] attr: more matching optimizations from .gitignore
Date: Mon, 15 Oct 2012 13:24:39 +0700
Message-ID: <1350282279-4377-6-git-send-email-pclouds@gmail.com>
References: <1350282212-4270-1-git-send-email-pclouds@gmail.com>
 <1350282279-4377-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 15 08:25:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNe7V-0006Yh-Kk
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 08:25:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753876Ab2JOGZe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Oct 2012 02:25:34 -0400
Received: from mail-da0-f46.google.com ([209.85.210.46]:51858 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753294Ab2JOGZd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 02:25:33 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so2429486dak.19
        for <git@vger.kernel.org>; Sun, 14 Oct 2012 23:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=aJVpRAgXTs3KfdARdE/eu/pg0kcjQxuLhZ5D26omqdU=;
        b=mWCPAHyF9XoF6UF8wtFRsEY35A6Ec+xZSQq7hVk5ITX3+fdIQbdAVruokiOqVCBxZR
         lBid9/i5vfPtX/yzidqtxkg+hxjunLZAUIqHzyAYGh2ivqOjdhk7aoqKLJB6m9Tm+rvJ
         Ex8dsWp21GwUTefLD6vsZluLcGjLqobQRLau059peQ0HdUaK2f07h/NccYhA80+M8VGm
         z+4XBNWhGzUnB1RftSo9lL58eYh2TV/fR2EF2gnpHQhX8j9/pAfjsPeVm3x04QHy5AyB
         /QtXXlpa88Q2i8pxyiEiEpdEuvksH7I7M30QEU+SqaewmfstpsEgB6wYLn24GGvP1pIs
         ka+Q==
Received: by 10.68.130.194 with SMTP id og2mr34316590pbb.131.1350282333004;
        Sun, 14 Oct 2012 23:25:33 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id ni3sm2945114pbc.2.2012.10.14.23.25.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 14 Oct 2012 23:25:31 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 15 Oct 2012 13:25:21 +0700
X-Mailer: git-send-email 1.8.0.rc0.29.g1fdd78f
In-Reply-To: <1350282279-4377-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207698>

=2Egitattributes and .gitignore share the same pattern syntax but has
separate matching implementation. Over the years, ignore's
implementation accumulates more optimizations while attr's stays the
same.

This patch reuses the core matching functions that are also used by
excluded_from_list. excluded_from_list and path_matches can't be
merged due to differences in exclude and attr, for example:

* "!pattern" syntax is forbidden in .gitattributes.  As an attribute
  can be unset (i.e. set to a special value "false") or made back to
  unspecified (i.e. not even set to "false"), "!pattern attr" is unclea=
r
  which one it means.

* we support attaching attributes to directories, but git-core
  internally does not currently make use of attributes on
  directories.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/gitattributes.txt |  1 +
 attr.c                          | 52 ++++++++++++++++++++++++---------=
--------
 dir.c                           | 22 ++++++++---------
 dir.h                           | 11 +++++++++
 t/t0003-attributes.sh           | 10 ++++++++
 5 files changed, 64 insertions(+), 32 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattribu=
tes.txt
index 80120ea..b7c0e65 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -56,6 +56,7 @@ When more than one pattern matches the path, a later =
line
 overrides an earlier line.  This overriding is done per
 attribute.  The rules how the pattern matches paths are the
 same as in `.gitignore` files; see linkgit:gitignore[5].
+Unlike `.gitignore`, negative patterns are forbidden.
=20
 When deciding what attributes are assigned to a path, git
 consults `$GIT_DIR/info/attributes` file (which has the highest
diff --git a/attr.c b/attr.c
index e7caee4..2fc6353 100644
--- a/attr.c
+++ b/attr.c
@@ -115,6 +115,13 @@ struct attr_state {
 	const char *setto;
 };
=20
+struct pattern {
+	const char *pattern;
+	int patternlen;
+	int nowildcardlen;
+	int flags;		/* EXC_FLAG_* */
+};
+
 /*
  * One rule, as from a .gitattributes file.
  *
@@ -131,7 +138,7 @@ struct attr_state {
  */
 struct match_attr {
 	union {
-		char *pattern;
+		struct pattern pat;
 		struct git_attr *attr;
 	} u;
 	char is_macro;
@@ -241,9 +248,16 @@ static struct match_attr *parse_attr_line(const ch=
ar *line, const char *src,
 	if (is_macro)
 		res->u.attr =3D git_attr_internal(name, namelen);
 	else {
-		res->u.pattern =3D (char *)&(res->state[num_attr]);
-		memcpy(res->u.pattern, name, namelen);
-		res->u.pattern[namelen] =3D 0;
+		char *p =3D (char *)&(res->state[num_attr]);
+		memcpy(p, name, namelen);
+		res->u.pat.pattern =3D p;
+		parse_exclude_pattern(&res->u.pat.pattern,
+				      &res->u.pat.patternlen,
+				      &res->u.pat.flags,
+				      &res->u.pat.nowildcardlen);
+		if (res->u.pat.flags & EXC_FLAG_NEGATIVE)
+			die(_("Negative patterns are forbidden in git attributes\n"
+			      "Use '\\!' for literal leading exclamation."));
 	}
 	res->is_macro =3D is_macro;
 	res->num_attr =3D num_attr;
@@ -640,25 +654,21 @@ static void prepare_attr_stack(const char *path)
=20
 static int path_matches(const char *pathname, int pathlen,
 			const char *basename,
-			const char *pattern,
+			const struct pattern *pat,
 			const char *base, int baselen)
 {
-	if (!strchr(pattern, '/')) {
-		return (fnmatch_icase(pattern, basename, 0) =3D=3D 0);
+	const char *pattern =3D pat->pattern;
+	int prefix =3D pat->nowildcardlen;
+
+	if (pat->flags & EXC_FLAG_NODIR) {
+		return match_basename(basename,
+				      pathlen - (basename - pathname),
+				      pattern, prefix,
+				      pat->patternlen, pat->flags);
 	}
-	/*
-	 * match with FNM_PATHNAME; the pattern has base implicitly
-	 * in front of it.
-	 */
-	if (*pattern =3D=3D '/')
-		pattern++;
-	if (pathlen < baselen ||
-	    (baselen && pathname[baselen] !=3D '/') ||
-	    strncmp(pathname, base, baselen))
-		return 0;
-	if (baselen !=3D 0)
-		baselen++;
-	return fnmatch_icase(pattern, pathname + baselen, FNM_PATHNAME) =3D=3D=
 0;
+	return match_pathname(pathname, pathlen,
+			      base, baselen,
+			      pattern, prefix, pat->patternlen, pat->flags);
 }
=20
 static int macroexpand_one(int attr_nr, int rem);
@@ -696,7 +706,7 @@ static int fill(const char *path, int pathlen, cons=
t char *basename,
 		if (a->is_macro)
 			continue;
 		if (path_matches(path, pathlen, basename,
-				 a->u.pattern, base, stk->originlen))
+				 &a->u.pat, base, stk->originlen))
 			rem =3D fill_one("fill", a, rem);
 	}
 	return rem;
diff --git a/dir.c b/dir.c
index c4e64a5..ee8e711 100644
--- a/dir.c
+++ b/dir.c
@@ -308,10 +308,10 @@ static int no_wildcard(const char *string)
 	return string[simple_length(string)] =3D=3D '\0';
 }
=20
-static void parse_exclude_pattern(const char **pattern,
-				  int *patternlen,
-				  int *flags,
-				  int *nowildcardlen)
+void parse_exclude_pattern(const char **pattern,
+			   int *patternlen,
+			   int *flags,
+			   int *nowildcardlen)
 {
 	const char *p =3D *pattern;
 	size_t i, len;
@@ -530,9 +530,9 @@ static void prep_exclude(struct dir_struct *dir, co=
nst char *base, int baselen)
 	dir->basebuf[baselen] =3D '\0';
 }
=20
-static int match_basename(const char *basename, int basenamelen,
-			  const char *pattern, int prefix, int patternlen,
-			  int flags)
+int match_basename(const char *basename, int basenamelen,
+		   const char *pattern, int prefix, int patternlen,
+		   int flags)
 {
 	if (prefix =3D=3D patternlen) {
 		if (!strcmp_icase(pattern, basename))
@@ -549,10 +549,10 @@ static int match_basename(const char *basename, i=
nt basenamelen,
 	return 0;
 }
=20
-static int match_pathname(const char *pathname, int pathlen,
-			  const char *base, int baselen,
-			  const char *pattern, int prefix, int patternlen,
-			  int flags)
+int match_pathname(const char *pathname, int pathlen,
+		   const char *base, int baselen,
+		   const char *pattern, int prefix, int patternlen,
+		   int flags)
 {
 	const char *name;
 	int namelen;
diff --git a/dir.h b/dir.h
index 41ea32d..f5c89e3 100644
--- a/dir.h
+++ b/dir.h
@@ -81,6 +81,16 @@ extern int excluded_from_list(const char *pathname, =
int pathlen, const char *bas
 struct dir_entry *dir_add_ignored(struct dir_struct *dir, const char *=
pathname, int len);
=20
 /*
+ * these implement the matching logic for dir.c:excluded_from_list and
+ * attr.c:path_matches()
+ */
+extern int match_basename(const char *, int,
+			  const char *, int, int, int);
+extern int match_pathname(const char *, int,
+			  const char *, int,
+			  const char *, int, int, int);
+
+/*
  * The excluded() API is meant for callers that check each level of le=
ading
  * directory hierarchies with excluded() to avoid recursing into exclu=
ded
  * directories.  Callers that do not do so should use this API instead=
=2E
@@ -97,6 +107,7 @@ extern int path_excluded(struct path_exclude_check *=
, const char *, int namelen,
 extern int add_excludes_from_file_to_list(const char *fname, const cha=
r *base, int baselen,
 					  char **buf_p, struct exclude_list *which, int check_index);
 extern void add_excludes_from_file(struct dir_struct *, const char *fn=
ame);
+extern void parse_exclude_pattern(const char **string, int *patternlen=
, int *flags, int *nowildcardlen);
 extern void add_exclude(const char *string, const char *base,
 			int baselen, struct exclude_list *which);
 extern void free_excludes(struct exclude_list *el);
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index 51f3045..f6c21ea 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -206,6 +206,16 @@ test_expect_success 'root subdir attribute test' '
 	attr_check subdir/a/i unspecified
 '
=20
+test_expect_success 'negative patterns' '
+	echo "!f test=3Dbar" >.gitattributes &&
+	test_must_fail git check-attr test -- f
+'
+
+test_expect_success 'patterns starting with exclamation' '
+	echo "\!f test=3Dfoo" >.gitattributes &&
+	attr_check "!f" foo
+'
+
 test_expect_success 'setup bare' '
 	git clone --bare . bare.git &&
 	cd bare.git
--=20
1.8.0.rc0.29.g1fdd78f

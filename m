From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH nd/attr-match-optim-more 2/2] attr: more matching optimizations from .gitignore
Date: Tue,  9 Oct 2012 09:24:05 +0700
Message-ID: <1349749445-25397-2-git-send-email-pclouds@gmail.com>
References: <1349749445-25397-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 09 04:24:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLPUp-0003EJ-Lz
	for gcvg-git-2@plane.gmane.org; Tue, 09 Oct 2012 04:24:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753320Ab2JICYZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Oct 2012 22:24:25 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:59891 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751833Ab2JICYY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2012 22:24:24 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so4571854pbb.19
        for <git@vger.kernel.org>; Mon, 08 Oct 2012 19:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=SPCvJUDfywzgVOO2xdOG2zkvebUZ91yvd5wQGhe1cCY=;
        b=aVHPwLTkKXChf1tVJ3B/0BXtw5dv0GNlUqY/+zCM5M2PSONqy8L2q6YzwR/Vlp6d7m
         /vN6c+NSqWaMYyzZCjnc8Rff9moSznFVgDqLOavgK9t+K/2P8nnLrXMPXslU/+wPIfK5
         GWxCgwfmzklv66sG4lDXcxCqMAKW3fTAAaF97zVASOJm31RyDk4vA/5X4MzF9WV0ywL4
         C66ZgjRHZGZayVm7uV02kh19BhWaMiQO15NET17ZvPyuP7wDHbO73Gmzo535917TxdZp
         qBngz+IOL7lcOtMbkqMCAK0GN2Xqjbw95MhYb4wYXL8Tq2brx//3GKGxBj41nRdixqdG
         AGUg==
Received: by 10.68.229.194 with SMTP id ss2mr59355154pbc.17.1349749464147;
        Mon, 08 Oct 2012 19:24:24 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id it6sm11589838pbc.14.2012.10.08.19.24.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 08 Oct 2012 19:24:23 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 09 Oct 2012 09:24:17 +0700
X-Mailer: git-send-email 1.8.0.rc0.29.g1fdd78f
In-Reply-To: <1349749445-25397-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207285>

=2Egitattributes and .gitignore share the same pattern syntax but has
separate matching implementation. Over the years, ignore's
implementation accumulates more optimizations while attr's stays the
same.

This patch adds those optimizations to attr. Basically it tries to
avoid fnmatch as much as possible in favor of strncmp.

A few notes from this work is put in the documentation:

* "!pattern" syntax is not supported in .gitattributes. Negative
  patterns may work well for a single attribute like .gitignore. It's
  confusing in .gitattributes are many attributes can be
  set/unset/undefined at using the same pattern.

* we support attaching attributes to directories at the syntax
  level, but we do not really attach attributes on directory or use
  them.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 No more die() for path/ syntax. Rephrase "!syntax" messages from not
 supported to forbidden. A small test to verify that we actually
 forbid it.

 Documentation/gitattributes.txt |  3 +-
 attr.c                          | 67 +++++++++++++++++++++++++++++++++=
+-------
 dir.c                           |  8 ++---
 dir.h                           |  1 +
 t/t0003-attributes.sh           | 14 +++++++++
 5 files changed, 77 insertions(+), 16 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattribu=
tes.txt
index 80120ea..cc2ff1d 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -23,7 +23,7 @@ Each line in `gitattributes` file is of form:
 That is, a pattern followed by an attributes list,
 separated by whitespaces.  When the pattern matches the
 path in question, the attributes listed on the line are given to
-the path.
+the path. Only files can be attached attributes to.
=20
 Each attribute can be in one of these states for a given path:
=20
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
index e7caee4..7e85f82 100644
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
@@ -241,9 +248,17 @@ static struct match_attr *parse_attr_line(const ch=
ar *line, const char *src,
 	if (is_macro)
 		res->u.attr =3D git_attr_internal(name, namelen);
 	else {
-		res->u.pattern =3D (char *)&(res->state[num_attr]);
-		memcpy(res->u.pattern, name, namelen);
-		res->u.pattern[namelen] =3D 0;
+		char *p =3D (char *)&(res->state[num_attr]);
+		memcpy(p, name, namelen);
+		p[namelen] =3D 0;
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
@@ -640,25 +655,55 @@ static void prepare_attr_stack(const char *path)
=20
 static int path_matches(const char *pathname, int pathlen,
 			const char *basename,
-			const char *pattern,
+			const struct pattern *pat,
 			const char *base, int baselen)
 {
-	if (!strchr(pattern, '/')) {
+	const char *pattern =3D pat->pattern;
+	int prefix =3D pat->nowildcardlen;
+	const char *name;
+	int namelen;
+
+	if (pat->flags & EXC_FLAG_NODIR) {
+		if (prefix =3D=3D pat->patternlen &&
+		    !strcmp_icase(pattern, basename))
+			return 1;
+
+		if (pat->flags & EXC_FLAG_ENDSWITH &&
+		    pat->patternlen - 1 <=3D pathlen &&
+		    !strcmp_icase(pattern + 1, pathname +
+				  pathlen - pat->patternlen + 1))
+			return 1;
+
 		return (fnmatch_icase(pattern, basename, 0) =3D=3D 0);
 	}
 	/*
 	 * match with FNM_PATHNAME; the pattern has base implicitly
 	 * in front of it.
 	 */
-	if (*pattern =3D=3D '/')
+	if (*pattern =3D=3D '/') {
 		pattern++;
+		prefix--;
+	}
+
+	/*
+	 * note: unlike excluded_from_list, baselen here does not
+	 * contain the trailing slash
+	 */
+
 	if (pathlen < baselen ||
 	    (baselen && pathname[baselen] !=3D '/') ||
 	    strncmp(pathname, base, baselen))
 		return 0;
-	if (baselen !=3D 0)
-		baselen++;
-	return fnmatch_icase(pattern, pathname + baselen, FNM_PATHNAME) =3D=3D=
 0;
+
+	namelen =3D baselen ? pathlen - baselen - 1 : pathlen;
+	name =3D pathname + pathlen - namelen;
+
+	/* if the non-wildcard part is longer than the remaining
+	   pathname, surely it cannot match */
+	if (!namelen || prefix > namelen)
+		return 0;
+
+	return fnmatch_icase(pattern, name, FNM_PATHNAME) =3D=3D 0;
 }
=20
 static int macroexpand_one(int attr_nr, int rem);
@@ -696,7 +741,7 @@ static int fill(const char *path, int pathlen, cons=
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
index 48aed85..cddf043 100644
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
diff --git a/dir.h b/dir.h
index 41ea32d..fd5c2aa 100644
--- a/dir.h
+++ b/dir.h
@@ -97,6 +97,7 @@ extern int path_excluded(struct path_exclude_check *,=
 const char *, int namelen,
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
index 51f3045..4a1402f 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -242,4 +242,18 @@ test_expect_success 'bare repository: test info/at=
tributes' '
 	attr_check subdir/a/i unspecified
 '
=20
+test_expect_success 'leave bare' '
+	cd ..
+'
+
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
 test_done
--=20
1.8.0.rc0.29.g1fdd78f

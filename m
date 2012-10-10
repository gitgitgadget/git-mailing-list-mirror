From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 2/2] attr: more matching optimizations from .gitignore
Date: Wed, 10 Oct 2012 17:21:06 +0700
Message-ID: <1349864466-28289-1-git-send-email-pclouds@gmail.com>
References: <7vd30si665.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 10 12:21:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLtPt-0000O5-LY
	for gcvg-git-2@plane.gmane.org; Wed, 10 Oct 2012 12:21:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754938Ab2JJKVT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Oct 2012 06:21:19 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:44589 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754531Ab2JJKVR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2012 06:21:17 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so561228pbb.19
        for <git@vger.kernel.org>; Wed, 10 Oct 2012 03:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=2oTDXbffS7WlA21M7f8JC253OO03j2kfzdKTZRFYC54=;
        b=ynCy0yQ6SxII8hTbhpFnwrqHYb1kUxGwDBxD5BMc1zVFUvgSwyjDiWQMAA3v+paM8P
         pXWnKvkbQmKLPQHXZ2z1FOG+cloEIGOMt7BQVNdV7+3xdQzMMXcrl47CbwQ+lYS1Yvwg
         uiNmq4PUrZLWQb18Z+uSX8FG+oj/tlMHJXxUmsOowusL/pkKGyGYs4ttQZg5Dv3qtxan
         hDMR09POtppuBejA8z7RMLSl9ZWvpXNFIE9mrU53pFgrCg3We4O1FJV1rJV+5UNs5Ttb
         sdavTqzWPrnE8WPfQMJRc1q3SXDNt+M3VuiQkxQ0TIcl+uH2MxUSscYs4X/3vbjDtwNl
         cg6w==
Received: by 10.66.88.233 with SMTP id bj9mr60756773pab.72.1349864477167;
        Wed, 10 Oct 2012 03:21:17 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.54.82])
        by mx.google.com with ESMTPS id ih2sm817324pbc.65.2012.10.10.03.21.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 10 Oct 2012 03:21:15 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 10 Oct 2012 17:21:07 +0700
X-Mailer: git-send-email 1.7.12.1.406.g6ab07c4
In-Reply-To: <7vd30si665.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207383>

=2Egitattributes and .gitignore share the same pattern syntax but has
separate matching implementation. Over the years, ignore's
implementation accumulates more optimizations while attr's stays the
same.

This patch adds those optimizations to attr. Basically it tries to
avoid fnmatch as much as possible in favor of strncmp.

A few notes from this work is put in the documentation:

* "!pattern" syntax is not supported in .gitattributes as it's not
  clear what it means (e.g. "!path attr" is about unsetting attr, or
  undefining it..)

* patterns applying to directories

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 How about this? Diff from the previous version:

   diff --git a/Documentation/gitattributes.txt b/Documentation/gitattr=
ibutes.txt
   index cc2ff1d..9a0ed19 100644
   --- a/Documentation/gitattributes.txt
   +++ b/Documentation/gitattributes.txt
   @@ -23,7 +23,7 @@ Each line in `gitattributes` file is of form:
    That is, a pattern followed by an attributes list,
    separated by whitespaces.  When the pattern matches the
    path in question, the attributes listed on the line are given to
   -the path. Only files can be attached attributes to.
   +the path.
   =20
    Each attribute can be in one of these states for a given path:
   =20
   @@ -58,6 +58,13 @@ attribute.  The rules how the pattern matches pat=
hs are the
    same as in `.gitignore` files; see linkgit:gitignore[5].
    Unlike `.gitignore`, negative patterns are not supported.
   =20
   +Note that if a .gitignore rule matches a directory, the directory
   +is ignored, which may be seen as assigning "ignore" attribute the
   +directory and all files and directories inside. However, if a
   +.gitattributes rule matches a directory, it manipulates
   +attributes on that directory only, not files and directories
   +inside.
   +
    When deciding what attributes are assigned to a path, git
    consults `$GIT_DIR/info/attributes` file (which has the highest
    precedence), `.gitattributes` file in the same directory as the
   diff --git a/attr.c b/attr.c
   index 7e85f82..4faf1ff 100644
   --- a/attr.c
   +++ b/attr.c
   @@ -250,7 +250,6 @@ static struct match_attr *parse_attr_line(const =
char *line, const char *src,
    	else {
    		char *p =3D (char *)&(res->state[num_attr]);
    		memcpy(p, name, namelen);
   -		p[namelen] =3D 0;
    		res->u.pat.pattern =3D p;
    		parse_exclude_pattern(&res->u.pat.pattern,
    				      &res->u.pat.patternlen,
   @@ -690,16 +689,18 @@ static int path_matches(const char *pathname, =
int pathlen,
    	 * contain the trailing slash
    	 */
   =20
   -	if (pathlen < baselen ||
   +	if (pathlen < baselen + 1 ||
    	    (baselen && pathname[baselen] !=3D '/') ||
   -	    strncmp(pathname, base, baselen))
   +	    strncmp_icase(pathname, base, baselen))
    		return 0;
   =20
    	namelen =3D baselen ? pathlen - baselen - 1 : pathlen;
    	name =3D pathname + pathlen - namelen;
   =20
   -	/* if the non-wildcard part is longer than the remaining
   -	   pathname, surely it cannot match */
   +	/*
   +	 * if the non-wildcard part is longer than the remaining
   +	 * pathname, surely it cannot match
   +	 */
    	if (!namelen || prefix > namelen)
    		return 0;
=20

 Documentation/gitattributes.txt |  8 +++++
 attr.c                          | 72 +++++++++++++++++++++++++++++++++=
--------
 dir.c                           |  8 ++---
 dir.h                           |  1 +
 t/t0003-attributes.sh           | 14 ++++++++
 5 files changed, 86 insertions(+), 17 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattribu=
tes.txt
index 80120ea..9a0ed19 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -56,6 +56,14 @@ When more than one pattern matches the path, a later=
 line
 overrides an earlier line.  This overriding is done per
 attribute.  The rules how the pattern matches paths are the
 same as in `.gitignore` files; see linkgit:gitignore[5].
+Unlike `.gitignore`, negative patterns are not supported.
+
+Note that if a .gitignore rule matches a directory, the directory
+is ignored, which may be seen as assigning "ignore" attribute the
+directory and all files and directories inside. However, if a
+.gitattributes rule matches a directory, it manipulates
+attributes on that directory only, not files and directories
+inside.
=20
 When deciding what attributes are assigned to a path, git
 consults `$GIT_DIR/info/attributes` file (which has the highest
diff --git a/attr.c b/attr.c
index e7caee4..4faf1ff 100644
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
@@ -640,25 +654,57 @@ static void prepare_attr_stack(const char *path)
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
-	if (pathlen < baselen ||
+		prefix--;
+	}
+
+	/*
+	 * note: unlike excluded_from_list, baselen here does not
+	 * contain the trailing slash
+	 */
+
+	if (pathlen < baselen + 1 ||
 	    (baselen && pathname[baselen] !=3D '/') ||
-	    strncmp(pathname, base, baselen))
+	    strncmp_icase(pathname, base, baselen))
+		return 0;
+
+	namelen =3D baselen ? pathlen - baselen - 1 : pathlen;
+	name =3D pathname + pathlen - namelen;
+
+	/*
+	 * if the non-wildcard part is longer than the remaining
+	 * pathname, surely it cannot match
+	 */
+	if (!namelen || prefix > namelen)
 		return 0;
-	if (baselen !=3D 0)
-		baselen++;
-	return fnmatch_icase(pattern, pathname + baselen, FNM_PATHNAME) =3D=3D=
 0;
+
+	return fnmatch_icase(pattern, name, FNM_PATHNAME) =3D=3D 0;
 }
=20
 static int macroexpand_one(int attr_nr, int rem);
@@ -696,7 +742,7 @@ static int fill(const char *path, int pathlen, cons=
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
1.7.12.1.406.g6ab07c4

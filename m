From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 04/10] attr: more matching optimizations from .gitignore
Date: Fri,  5 Oct 2012 11:41:03 +0700
Message-ID: <1349412069-627-5-git-send-email-pclouds@gmail.com>
References: <1349412069-627-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 05 09:37:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TK2Tb-0002Gn-3o
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 09:37:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752726Ab2JEHh3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Oct 2012 03:37:29 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:53952 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752300Ab2JEHh2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2012 03:37:28 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so1402675pad.19
        for <git@vger.kernel.org>; Fri, 05 Oct 2012 00:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Zu0uOcNB2IoltQenGsFFyITzBX84G9j1DmHIjNIhzUc=;
        b=Y+xVC/Af4ZKom36ef2w64fi6ho3Sq1vb3gVdKxJYVsW4VFdskqs7Rk8BGq1xGzf4lh
         bz86ZO1f5lUVBeiDO8083vSuVJiWXXDynWvK7UeV6TPgshrdV/0M7GVso5y28JyjRoRR
         knmSO+n66aTq8+KxKSe0SmE4yzOP6nz16H8czxKzotWv8aKZzjULoWo2zYVe0IJgKwSp
         CdmoPquS841D5iujy4hk0Iy12TM+KJtkRL4LYyEc10YOz7yRfYksG2AxaT4fgnFkWSX5
         gx60CQyrJk6FT/FuZ6vwP2OdzE20sPX4T88EVNR1VI18IxzJawilC8Zz8E3EoqdmuV4v
         mXzA==
Received: by 10.68.225.5 with SMTP id rg5mr27272678pbc.73.1349412085443;
        Thu, 04 Oct 2012 21:41:25 -0700 (PDT)
Received: from tre ([115.74.45.10])
        by mx.google.com with ESMTPS id iq3sm5438749pbc.5.2012.10.04.21.41.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 04 Oct 2012 21:41:24 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Fri, 05 Oct 2012 11:41:33 +0700
X-Mailer: git-send-email 1.7.10.1.641.g9354186
In-Reply-To: <1349412069-627-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207088>

=2Egitattributes and .gitignore share the same pattern syntax but has
separate matching implementation. Over the years, ignore's
implementation accumulates more optimizations while attr's stays the
same.

This patch adds those optimizations to .gitattributes. Basically it
tries to avoid fnmatch/wildmatch in favor of strncmp as much as
possible.

There are two syntaxes that .gitignore supports but .gitattributes
does not: negative patterns and directory matching. They have never
worked and whether they will is up for future discussion. Meanwhile
make a note in the document and reject such patterns.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/gitattributes.txt |  2 ++
 attr.c                          | 68 +++++++++++++++++++++++++++++++++=
+-------
 dir.c                           |  8 ++---
 dir.h                           |  1 +
 4 files changed, 64 insertions(+), 15 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattribu=
tes.txt
index e16f3e1..702b8c1 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -56,6 +56,8 @@ When more than one pattern matches the path, a later =
line
 overrides an earlier line.  This overriding is done per
 attribute.  The rules how the pattern matches paths are the
 same as in `.gitignore` files; see linkgit:gitignore[5].
+Unlike `.gitignore`, negative patterns are not supported.
+Patterns that match directories are also not supported.
=20
 When deciding what attributes are assigned to a path, git
 consults `$GIT_DIR/info/attributes` file (which has the highest
diff --git a/attr.c b/attr.c
index aeac564..1aa058e 100644
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
@@ -241,9 +248,18 @@ static struct match_attr *parse_attr_line(const ch=
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
+			die(_("Negative patterns are not supported in git attributes"));
+		if (res->u.pat.flags & EXC_FLAG_MUSTBEDIR)
+			die(_("Directory patterns are not supported in git attributes"));
 	}
 	res->is_macro =3D is_macro;
 	res->num_attr =3D num_attr;
@@ -645,25 +661,55 @@ static void prepare_attr_stack(const char *path)
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
@@ -701,7 +747,7 @@ static int fill(const char *path, int pathlen, cons=
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
index cd13920..c6a0275 100644
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
--=20
1.7.12.1.405.gb727dc9

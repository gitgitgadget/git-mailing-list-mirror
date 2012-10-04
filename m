From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/6] attr: more matching optimizations from .gitignore
Date: Thu,  4 Oct 2012 14:39:50 +0700
Message-ID: <1349336392-1772-5-git-send-email-pclouds@gmail.com>
References: <7v626q3hen.fsf@alter.siamese.dyndns.org>
 <1349336392-1772-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 05 00:13:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtUK-0001w8-CJ
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:01:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932327Ab2JDHkj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Oct 2012 03:40:39 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:45932 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932256Ab2JDHkh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 03:40:37 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so327784pbb.19
        for <git@vger.kernel.org>; Thu, 04 Oct 2012 00:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=pABfiTBBRFlWF5eU8NOUCINZIlZt/tK7ovoHaq+LpWc=;
        b=cTIkjZYUUHGSuR1LzBA1G5WtRbZ35MQY51Frdt3KvDOCV+k+g8wxuhMUlN6K3dRnBH
         ejREbWsC1TrjkoPHIyx8o1oCzvRBls6t3ZYDeLbTb6qDE/sGJXn7/FhdYWxPVuI+Zb1o
         2kxaQ6DlM5CL+fgOIJwHzrOsVhW2GU3eJmg9iTbfSjVSTZeGs0xDRzF8NcweBcocH2zb
         4OMjY+1avV/h/SAAtEICVm98vXvaRQeKfRBiQG/CTJitYD7Inl5Wy/HrDBfbhrpGcqJN
         R6QJTEaHCF381EluRHqMtc7qK3H9mkexxtAt2GBYHr28Nv5s54ZPQt88hi99kacqMzSN
         jVoA==
Received: by 10.68.135.39 with SMTP id pp7mr19486380pbb.127.1349336436850;
        Thu, 04 Oct 2012 00:40:36 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id g1sm3839733paz.18.2012.10.04.00.40.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 04 Oct 2012 00:40:35 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 04 Oct 2012 14:40:24 +0700
X-Mailer: git-send-email 1.7.12.1.405.gb727dc9
In-Reply-To: <1349336392-1772-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206977>

=2Egitattributes and .gitignore share the same pattern syntax but has
separate matching implementation. Over the years, ignore's
implementation accumulates more optimizations while attr's stays the
same.

This patch adds those optimizations to .gitattributes. Basically it
tries to avoid fnmatch/wildmatch in favor of strncmp as much as
possible.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 attr.c | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++++-----=
-----
 dir.c  |  4 ++--
 dir.h  |  2 ++
 3 files changed, 57 insertions(+), 12 deletions(-)

diff --git a/attr.c b/attr.c
index eb576ac..3fde9fa 100644
--- a/attr.c
+++ b/attr.c
@@ -116,6 +116,13 @@ struct attr_state {
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
  * listed as they appear in the file (macros unexpanded).
  */
 struct match_attr {
-	const char *pattern;
+	struct pattern pat;
 	struct git_attr *attr;
 	char is_macro;
 	unsigned num_attr;
@@ -243,7 +250,13 @@ static struct match_attr *parse_attr_line(const ch=
ar *line, const char *src,
 		char *p =3D (char *)&(res->state[num_attr]);
 		memcpy(p, name, namelen);
 		p[namelen] =3D 0;
-		res->pattern =3D p;
+		res->pat.pattern =3D p;
+		res->pat.patternlen =3D strlen(p);
+		res->pat.nowildcardlen =3D simple_length(p);
+		if (!strchr(p, '/'))
+			res->pat.flags |=3D EXC_FLAG_NODIR;
+		if (*p =3D=3D '*' && no_wildcard(p+1))
+			res->pat.flags |=3D EXC_FLAG_ENDSWITH;
 	}
 	res->is_macro =3D is_macro;
 	res->num_attr =3D num_attr;
@@ -645,26 +658,56 @@ static void prepare_attr_stack(const char *path)
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
-	return (ignore_case && iwildmatch(pattern, pathname + baselen)) ||
-		(!ignore_case && wildmatch(pattern, pathname + baselen));
+
+	namelen =3D baselen ? pathlen - baselen - 1 : pathlen;
+	name =3D pathname + pathlen - namelen;
+
+	/* if the non-wildcard part is longer than the remaining
+	   pathname, surely it cannot match */
+	if (!namelen || prefix > namelen)
+		return 0;
+
+	return (ignore_case && iwildmatch(pattern, name)) ||
+		(!ignore_case && wildmatch(pattern, name));
 }
=20
 static int macroexpand_one(int attr_nr, int rem);
@@ -702,7 +745,7 @@ static int fill(const char *path, int pathlen, cons=
t char *basename,
 		if (a->is_macro)
 			continue;
 		if (path_matches(path, pathlen, basename,
-				 a->pattern, base, stk->originlen))
+				 &a->pat, base, stk->originlen))
 			rem =3D fill_one("fill", a, rem);
 	}
 	return rem;
diff --git a/dir.c b/dir.c
index 92cda82..fd49336 100644
--- a/dir.c
+++ b/dir.c
@@ -292,7 +292,7 @@ int match_pathspec_depth(const struct pathspec *ps,
 /*
  * Return the length of the "simple" part of a path match limiter.
  */
-static int simple_length(const char *match)
+int simple_length(const char *match)
 {
 	int len =3D -1;
=20
@@ -304,7 +304,7 @@ static int simple_length(const char *match)
 	}
 }
=20
-static int no_wildcard(const char *string)
+int no_wildcard(const char *string)
 {
 	return string[simple_length(string)] =3D=3D '\0';
 }
diff --git a/dir.h b/dir.h
index 893465a..7ea8678 100644
--- a/dir.h
+++ b/dir.h
@@ -101,6 +101,8 @@ extern void add_exclude(const char *string, const c=
har *base,
 			int baselen, struct exclude_list *which);
 extern void free_excludes(struct exclude_list *el);
 extern int file_exists(const char *);
+extern int simple_length(const char *match);
+extern int no_wildcard(const char *string);
=20
 extern int is_inside_dir(const char *dir);
 extern int dir_inside_of(const char *subdir, const char *dir);
--=20
1.7.12.1.405.gb727dc9

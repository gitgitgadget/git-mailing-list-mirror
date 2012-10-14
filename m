From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/4] exclude/attr: share full pathname matching code
Date: Sun, 14 Oct 2012 18:55:42 +0700
Message-ID: <1350215742-20761-5-git-send-email-pclouds@gmail.com>
References: <1350215742-20761-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 14 13:56:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNMoB-0004sP-I8
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 13:56:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752856Ab2JNL42 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Oct 2012 07:56:28 -0400
Received: from mail-da0-f46.google.com ([209.85.210.46]:44029 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751935Ab2JNL41 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2012 07:56:27 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so2104032dak.19
        for <git@vger.kernel.org>; Sun, 14 Oct 2012 04:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=uMHBoX/ADKiuZcIyerYCwoCNOo6A88aVoF7m7stmFLY=;
        b=vqsoryaa6et0pNUS5ln01aLRyZxdsgltSMU2JUI2F8Wq9E/WcCGf0udvqQdUdThC6t
         XpTy+cztiiOX58Znj7j7MEurxjlZdNs6/hrusEvwHlRn6hld3ZGAPJNZQ7TVMs19Z6wg
         dFc1a4yNqbAKxkG0U20uQGiU4Ju0VEYoglsPpKS6cNWdOk5sEl8WaQDgcOd6nM/gMt8e
         uqTw/rGbo6UhAVxNIBBdp4ZcrSNKpnOpxjEofHYKNEA7vVBAS1zWtg7ibrJZNmhV01ou
         IooRZQrtRBNrZftbuhvrDo+IKqqu6X2mYxnUq5ztjHf83ez4UvRyffAO5SZ5fbmJtwmd
         V+VA==
Received: by 10.68.204.137 with SMTP id ky9mr28504215pbc.90.1350215787273;
        Sun, 14 Oct 2012 04:56:27 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.44.221])
        by mx.google.com with ESMTPS id a10sm2630464paz.35.2012.10.14.04.56.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 14 Oct 2012 04:56:26 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 14 Oct 2012 18:56:12 +0700
X-Mailer: git-send-email 1.8.0.rc2.11.g2b79d01
In-Reply-To: <1350215742-20761-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207660>

match_pathname's declaration in dir.h does not have any description to
discourage the use of this function elsewhere as this function is
highly tied to how excluded_from_list and path_matches work.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 attr.c | 35 +++------------------------
 dir.c  | 85 +++++++++++++++++++++++++++++++++++++++++-----------------=
--------
 dir.h  |  3 +++
 3 files changed, 59 insertions(+), 64 deletions(-)

diff --git a/attr.c b/attr.c
index a28ce0d..2fc6353 100644
--- a/attr.c
+++ b/attr.c
@@ -659,8 +659,6 @@ static int path_matches(const char *pathname, int p=
athlen,
 {
 	const char *pattern =3D pat->pattern;
 	int prefix =3D pat->nowildcardlen;
-	const char *name;
-	int namelen;
=20
 	if (pat->flags & EXC_FLAG_NODIR) {
 		return match_basename(basename,
@@ -668,36 +666,9 @@ static int path_matches(const char *pathname, int =
pathlen,
 				      pattern, prefix,
 				      pat->patternlen, pat->flags);
 	}
-	/*
-	 * match with FNM_PATHNAME; the pattern has base implicitly
-	 * in front of it.
-	 */
-	if (*pattern =3D=3D '/') {
-		pattern++;
-		prefix--;
-	}
-
-	/*
-	 * note: unlike excluded_from_list, baselen here does not
-	 * count the trailing slash, and base[] does not end with
-	 * a trailing slash, either.
-	 */
-	if (pathlen < baselen + 1 ||
-	    (baselen && pathname[baselen] !=3D '/') ||
-	    strncmp_icase(pathname, base, baselen))
-		return 0;
-
-	namelen =3D baselen ? pathlen - baselen - 1 : pathlen;
-	name =3D pathname + pathlen - namelen;
-
-	/*
-	 * if the non-wildcard part is longer than the remaining
-	 * pathname, surely it cannot match.
-	 */
-	if (!namelen || prefix > namelen)
-		return 0;
-
-	return fnmatch_icase(pattern, name, FNM_PATHNAME) =3D=3D 0;
+	return match_pathname(pathname, pathlen,
+			      base, baselen,
+			      pattern, prefix, pat->patternlen, pat->flags);
 }
=20
 static int macroexpand_one(int attr_nr, int rem);
diff --git a/dir.c b/dir.c
index 42c42cd..ee8e711 100644
--- a/dir.c
+++ b/dir.c
@@ -549,6 +549,53 @@ int match_basename(const char *basename, int basen=
amelen,
 	return 0;
 }
=20
+int match_pathname(const char *pathname, int pathlen,
+		   const char *base, int baselen,
+		   const char *pattern, int prefix, int patternlen,
+		   int flags)
+{
+	const char *name;
+	int namelen;
+
+	/*
+	 * match with FNM_PATHNAME; the pattern has base implicitly
+	 * in front of it.
+	 */
+	if (*pattern =3D=3D '/') {
+		pattern++;
+		prefix--;
+	}
+
+	/*
+	 * baselen does not count the trailing slash. base[] may or
+	 * may not end with a trailing slash though.
+	 */
+	if (pathlen < baselen + 1 ||
+	    (baselen && pathname[baselen] !=3D '/') ||
+	    strncmp_icase(pathname, base, baselen))
+		return 0;
+
+	namelen =3D baselen ? pathlen - baselen - 1 : pathlen;
+	name =3D pathname + pathlen - namelen;
+
+	if (prefix) {
+		/*
+		 * if the non-wildcard part is longer than the
+		 * remaining pathname, surely it cannot match.
+		 */
+		if (prefix > namelen)
+			return 0;
+
+		if (strncmp_icase(pattern, name, prefix))
+			return 0;
+		pattern +=3D prefix;
+		name    +=3D prefix;
+		namelen -=3D prefix;
+	}
+
+	return fnmatch_icase(pattern, name, FNM_PATHNAME) =3D=3D 0;
+}
+
 /* Scan the list and let the last match determine the fate.
  * Return 1 for exclude, 0 for include and -1 for undecided.
  */
@@ -563,9 +610,9 @@ int excluded_from_list(const char *pathname,
=20
 	for (i =3D el->nr - 1; 0 <=3D i; i--) {
 		struct exclude *x =3D el->excludes[i];
-		const char *name, *exclude =3D x->pattern;
+		const char *exclude =3D x->pattern;
 		int to_exclude =3D x->flags & EXC_FLAG_NEGATIVE ? 0 : 1;
-		int namelen, prefix =3D x->nowildcardlen;
+		int prefix =3D x->nowildcardlen;
=20
 		if (x->flags & EXC_FLAG_MUSTBEDIR) {
 			if (*dtype =3D=3D DT_UNKNOWN)
@@ -583,36 +630,10 @@ int excluded_from_list(const char *pathname,
 			continue;
 		}
=20
-		/* match with FNM_PATHNAME:
-		 * exclude has base (baselen long) implicitly in front of it.
-		 */
-		if (*exclude =3D=3D '/') {
-			exclude++;
-			prefix--;
-		}
-
-		if (pathlen < x->baselen ||
-		    (x->baselen && pathname[x->baselen-1] !=3D '/') ||
-		    strncmp_icase(pathname, x->base, x->baselen))
-			continue;
-
-		namelen =3D x->baselen ? pathlen - x->baselen : pathlen;
-		name =3D pathname + pathlen  - namelen;
-
-		/* if the non-wildcard part is longer than the
-		   remaining pathname, surely it cannot match */
-		if (prefix > namelen)
-			continue;
-
-		if (prefix) {
-			if (strncmp_icase(exclude, name, prefix))
-				continue;
-			exclude +=3D prefix;
-			name    +=3D prefix;
-			namelen -=3D prefix;
-		}
-
-		if (!fnmatch_icase(exclude, name, FNM_PATHNAME))
+		assert(x->baselen =3D=3D 0 || x->base[x->baselen - 1] =3D=3D '/');
+		if (match_pathname(pathname, pathlen,
+				   x->base, x->baselen ? x->baselen - 1 : 0,
+				   exclude, prefix, x->patternlen, x->flags))
 			return to_exclude;
 	}
 	return -1; /* undecided */
diff --git a/dir.h b/dir.h
index d416c5a..11d054a 100644
--- a/dir.h
+++ b/dir.h
@@ -80,6 +80,9 @@ extern int excluded_from_list(const char *pathname, i=
nt pathlen, const char *bas
 			      int *dtype, struct exclude_list *el);
 extern int match_basename(const char *, int,
 			  const char *, int, int, int);
+extern int match_pathname(const char *, int,
+			  const char *, int,
+			  const char *, int, int, int);
 struct dir_entry *dir_add_ignored(struct dir_struct *dir, const char *=
pathname, int len);
=20
 /*
--=20
1.8.0.rc2.11.g2b79d01

From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/3] exclude: do strcmp as much as possible before fnmatch
Date: Sat, 26 May 2012 19:31:13 +0700
Message-ID: <1338035474-4346-3-git-send-email-pclouds@gmail.com>
References: <1338035474-4346-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 26 14:35:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYGDc-0003OA-Mj
	for gcvg-git-2@plane.gmane.org; Sat, 26 May 2012 14:35:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751905Ab2EZMfg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 May 2012 08:35:36 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:51511 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751839Ab2EZMff (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2012 08:35:35 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so2821580pbb.19
        for <git@vger.kernel.org>; Sat, 26 May 2012 05:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=uP6Sk82K7DPSPDLJ7bUtqZMLiAj3F4EEF5ezHDT2YIE=;
        b=0v/hICrolT+VHFup3x6sIJP1fehLbsWrwZHOum/TN0g9omuJeuP/eUGVPhNkuXvCiB
         aKgnPtggF2RTe9XypY9IHzSrkxAOB4bfeK+pEiBN3N+fRgoexualOpkQfrosn3trHoVQ
         PV6PAXOrGb3/K6N6rUeyLjSwEFHsZId0etoyu5xxvk4yKGhK3lT87ID1Uv/hIT5JlzUl
         8t5/kT3IVod9X95DWbZdt3oPYbkyRnhqknklEbd3yV33RfviWhWRvpoFwtcnBR3lhHw/
         Y1D8NEW/c9r9MRwJCPx9HF4DYebBI/FSP8TMIFI/auEd7V87npc/0PX9L1H58Cmk1Tdg
         kCiQ==
Received: by 10.68.211.131 with SMTP id nc3mr6404214pbc.4.1338035735384;
        Sat, 26 May 2012 05:35:35 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.50.33])
        by mx.google.com with ESMTPS id uz7sm12433442pbc.35.2012.05.26.05.35.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 26 May 2012 05:35:34 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 26 May 2012 19:31:33 +0700
X-Mailer: git-send-email 1.7.10.2.549.g9354186
In-Reply-To: <1338035474-4346-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198555>

this also avoids calling fnmatch() if the non-wildcard prefix is
longer than basename

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c | 41 +++++++++++++++++++++++++++--------------
 dir.h |  2 +-
 2 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/dir.c b/dir.c
index 8535cf2..50d744f 100644
--- a/dir.c
+++ b/dir.c
@@ -295,9 +295,11 @@ int match_pathspec_depth(const struct pathspec *ps=
,
 	return retval;
 }
=20
+const char *wildcards =3D "*?[{\\";
+
 static int no_wildcard(const char *string)
 {
-	return string[strcspn(string, "*?[{\\")] =3D=3D '\0';
+	return string[strcspn(string, wildcards)] =3D=3D '\0';
 }
=20
 void add_exclude(const char *string, const char *base,
@@ -336,8 +338,7 @@ void add_exclude(const char *string, const char *ba=
se,
 	x->flags =3D flags;
 	if (!strchr(string, '/'))
 		x->flags |=3D EXC_FLAG_NODIR;
-	if (no_wildcard(string))
-		x->flags |=3D EXC_FLAG_NOWILDCARD;
+	x->nowildcardlen =3D strcspn(string, wildcards);
 	if (*string =3D=3D '*' && no_wildcard(string+1))
 		x->flags |=3D EXC_FLAG_ENDSWITH;
 	ALLOC_GROW(which->excludes, which->nr + 1, which->alloc);
@@ -513,8 +514,9 @@ int excluded_from_list(const char *pathname,
=20
 	for (i =3D el->nr - 1; 0 <=3D i; i--) {
 		struct exclude *x =3D el->excludes[i];
-		const char *exclude =3D x->pattern;
+		const char *name, *exclude =3D x->pattern;
 		int to_exclude =3D x->to_exclude;
+		int namelen, prefix =3D x->nowildcardlen;
=20
 		if (x->flags & EXC_FLAG_MUSTBEDIR) {
 			if (*dtype =3D=3D DT_UNKNOWN)
@@ -525,7 +527,7 @@ int excluded_from_list(const char *pathname,
=20
 		if (x->flags & EXC_FLAG_NODIR) {
 			/* match basename */
-			if (x->flags & EXC_FLAG_NOWILDCARD) {
+			if (prefix =3D=3D x->patternlen) {
 				if (!strcmp_icase(exclude, basename))
 					return to_exclude;
 			} else if (x->flags & EXC_FLAG_ENDSWITH) {
@@ -539,26 +541,37 @@ int excluded_from_list(const char *pathname,
 			continue;
 		}
=20
-
 		/* match with FNM_PATHNAME:
 		 * exclude has base (baselen long) implicitly in front of it.
 		 */
-		if (*exclude =3D=3D '/')
+		if (*exclude =3D=3D '/') {
 			exclude++;
+			prefix--;
+		}
=20
 		if (pathlen < x->baselen ||
 		    (x->baselen && pathname[x->baselen-1] !=3D '/') ||
 		    strncmp_icase(pathname, x->base, x->baselen))
 			continue;
=20
-		if (x->flags & EXC_FLAG_NOWILDCARD) {
-			if (!strcmp_icase(exclude, pathname + x->baselen))
-				return to_exclude;
-		} else {
-			if (fnmatch_icase(exclude, pathname+x->baselen,
-					  FNM_PATHNAME) =3D=3D 0)
-				return to_exclude;
+		namelen =3D x->baselen ? pathlen - x->baselen : pathlen;
+		name =3D pathname + pathlen  - namelen;
+
+		/* if the non-wildcard part is longer than the
+		   remaining pathname, surely it cannot match */
+		if (prefix > namelen)
+			continue;
+
+		if (prefix) {
+			if (strncmp_icase(exclude, name, prefix))
+				continue;
+			exclude +=3D prefix;
+			name    +=3D prefix;
+			namelen -=3D prefix;
 		}
+
+		if (!namelen || !fnmatch_icase(exclude, name, FNM_PATHNAME))
+			return to_exclude;
 	}
 	return -1; /* undecided */
 }
diff --git a/dir.h b/dir.h
index 58b6fc7..39fc145 100644
--- a/dir.h
+++ b/dir.h
@@ -7,7 +7,6 @@ struct dir_entry {
 };
=20
 #define EXC_FLAG_NODIR 1
-#define EXC_FLAG_NOWILDCARD 2
 #define EXC_FLAG_ENDSWITH 4
 #define EXC_FLAG_MUSTBEDIR 8
=20
@@ -17,6 +16,7 @@ struct exclude_list {
 	struct exclude {
 		const char *pattern;
 		int patternlen;
+		int nowildcardlen;
 		const char *base;
 		int baselen;
 		int to_exclude;
--=20
1.7.10.2.549.g9354186

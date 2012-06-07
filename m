From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/4] exclude: do strcmp as much as possible before fnmatch
Date: Thu,  7 Jun 2012 14:53:36 +0700
Message-ID: <1339055617-23028-3-git-send-email-pclouds@gmail.com>
References: <1339055617-23028-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 07 09:54:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScXXs-0006MJ-MX
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 09:54:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756836Ab2FGHyM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Jun 2012 03:54:12 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:36260 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756823Ab2FGHyK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2012 03:54:10 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so706664pbb.19
        for <git@vger.kernel.org>; Thu, 07 Jun 2012 00:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=2lLA/RQnwQd85XPrz5ahhF1kEzV37ygWfC6jltbf4Fo=;
        b=xUO3jKZNLLjz6FuylmHHHAlNTBeKS0DAh+p1b2QW6Z2KnKOuROal244M3iX1S+PzUL
         4RMBBhoihVpj5ZAnnP15gv/YqfQ/ExQyFCtOGAZk2PWYUvmL+2LWW4yTNVTAm52Vz1FB
         9wPfzf0R+DH0c8rCDpd2X8oRg6ua1mTVvX0CKc6k31Up1ShXRIcUGBpdRj7omWWUtMfB
         cpUBJtm8HJAMzo7TWijylSxMkpIcZwE/Q6TDYmQahPaz1uHeh0nxYB6mivkforyTkWtU
         AetO0r7ikkfzJj18kCGAj+ZAKLKIekALOj94sug7/Eh/FKGWcBrpJAsAGhxLO3Bdco4u
         zDog==
Received: by 10.68.225.170 with SMTP id rl10mr7323818pbc.13.1339055650769;
        Thu, 07 Jun 2012 00:54:10 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id ku7sm3265858pbc.31.2012.06.07.00.54.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 07 Jun 2012 00:54:09 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 07 Jun 2012 14:53:56 +0700
X-Mailer: git-send-email 1.7.11.rc1.185.g281ad67
In-Reply-To: <1339055617-23028-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199378>

this also avoids calling fnmatch() if the non-wildcard prefix is
longer than basename

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Fixed the global "wildcards" string thing by using simple_length().

 dir.c | 37 ++++++++++++++++++++++++-------------
 dir.h |  2 +-
 2 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/dir.c b/dir.c
index bbf958c..94fe9f8 100644
--- a/dir.c
+++ b/dir.c
@@ -341,8 +341,7 @@ void add_exclude(const char *string, const char *ba=
se,
 	x->flags =3D flags;
 	if (!strchr(string, '/'))
 		x->flags |=3D EXC_FLAG_NODIR;
-	if (no_wildcard(string))
-		x->flags |=3D EXC_FLAG_NOWILDCARD;
+	x->nowildcardlen =3D simple_length(string);
 	if (*string =3D=3D '*' && no_wildcard(string+1))
 		x->flags |=3D EXC_FLAG_ENDSWITH;
 	ALLOC_GROW(which->excludes, which->nr + 1, which->alloc);
@@ -518,8 +517,9 @@ int excluded_from_list(const char *pathname,
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
@@ -530,7 +530,7 @@ int excluded_from_list(const char *pathname,
=20
 		if (x->flags & EXC_FLAG_NODIR) {
 			/* match basename */
-			if (x->flags & EXC_FLAG_NOWILDCARD) {
+			if (prefix =3D=3D x->patternlen) {
 				if (!strcmp_icase(exclude, basename))
 					return to_exclude;
 			} else if (x->flags & EXC_FLAG_ENDSWITH) {
@@ -544,26 +544,37 @@ int excluded_from_list(const char *pathname,
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
1.7.11.rc1.185.g281ad67

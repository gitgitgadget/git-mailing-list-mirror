From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/4] exclude/attr: share basename matching code
Date: Sun, 14 Oct 2012 18:55:41 +0700
Message-ID: <1350215742-20761-4-git-send-email-pclouds@gmail.com>
References: <1350215742-20761-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 14 13:56:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNMo6-0004ru-Se
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 13:56:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752844Ab2JNL4W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Oct 2012 07:56:22 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:42437 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751935Ab2JNL4W (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2012 07:56:22 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so4137646pbb.19
        for <git@vger.kernel.org>; Sun, 14 Oct 2012 04:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=UfoTG3djEvUdTswivur8z1s0o5H4YBlHs/0NWittCH8=;
        b=GouyWpn4iH/C8B7NScx/wu1wezpZQQiQZ7cz+rlfGIGU1EmnE8RDlL8Q8GkXHLkjs/
         s2im0XUhOyXwiFkcsiy7IHVpYcS87CHZI9OtMpKsLyQAxhZMVJTe5MsPTL/VKIZFs9+b
         LEYPXwaTlY9IWLtaIZI09m3skQm8kS30KM/MB2vS2mz6vL37Qa/Ff6Rnafd3DAnFDiPW
         Zmlg1zZWvLBLpBspY6LR2UdQmOhpEODtMmdPJRhOj5fXWh6BNiJReRIJ0KFrNWWWfLmi
         agfsvTytIakkzu80FhXJtQcqVYIAbYNFGPqEfQ88dMwJt/3nye8XuEAlcaPEa/cowDLc
         MLBw==
Received: by 10.68.83.68 with SMTP id o4mr29145522pby.25.1350215781665;
        Sun, 14 Oct 2012 04:56:21 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.44.221])
        by mx.google.com with ESMTPS id od2sm7396852pbb.28.2012.10.14.04.56.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 14 Oct 2012 04:56:21 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 14 Oct 2012 18:56:06 +0700
X-Mailer: git-send-email 1.8.0.rc2.11.g2b79d01
In-Reply-To: <1350215742-20761-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207659>

match_basename's declaration in dir.h does not have any description to
discourage the use of this function elsewhere as this function is
highly tied to how excluded_from_list and path_matches work.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 attr.c | 15 ++++-----------
 dir.c  | 37 ++++++++++++++++++++++++-------------
 dir.h  |  2 ++
 3 files changed, 30 insertions(+), 24 deletions(-)

diff --git a/attr.c b/attr.c
index 0964033..a28ce0d 100644
--- a/attr.c
+++ b/attr.c
@@ -663,17 +663,10 @@ static int path_matches(const char *pathname, int=
 pathlen,
 	int namelen;
=20
 	if (pat->flags & EXC_FLAG_NODIR) {
-		if (prefix =3D=3D pat->patternlen &&
-		    !strcmp_icase(pattern, basename))
-			return 1;
-
-		if (pat->flags & EXC_FLAG_ENDSWITH &&
-		    pat->patternlen - 1 <=3D pathlen &&
-		    !strcmp_icase(pattern + 1, pathname +
-				  pathlen - pat->patternlen + 1))
-			return 1;
-
-		return (fnmatch_icase(pattern, basename, 0) =3D=3D 0);
+		return match_basename(basename,
+				      pathlen - (basename - pathname),
+				      pattern, prefix,
+				      pat->patternlen, pat->flags);
 	}
 	/*
 	 * match with FNM_PATHNAME; the pattern has base implicitly
diff --git a/dir.c b/dir.c
index 0f4aea6..42c42cd 100644
--- a/dir.c
+++ b/dir.c
@@ -530,6 +530,25 @@ static void prep_exclude(struct dir_struct *dir, c=
onst char *base, int baselen)
 	dir->basebuf[baselen] =3D '\0';
 }
=20
+int match_basename(const char *basename, int basenamelen,
+		   const char *pattern, int prefix, int patternlen,
+		   int flags)
+{
+	if (prefix =3D=3D patternlen) {
+		if (!strcmp_icase(pattern, basename))
+			return 1;
+	} else if (flags & EXC_FLAG_ENDSWITH) {
+		if (patternlen - 1 <=3D basenamelen &&
+		    !strcmp_icase(pattern + 1,
+				  basename + basenamelen - patternlen + 1))
+			return 1;
+	} else {
+		if (fnmatch_icase(pattern, basename, 0) =3D=3D 0)
+			return 1;
+	}
+	return 0;
+}
+
 /* Scan the list and let the last match determine the fate.
  * Return 1 for exclude, 0 for include and -1 for undecided.
  */
@@ -556,19 +575,11 @@ int excluded_from_list(const char *pathname,
 		}
=20
 		if (x->flags & EXC_FLAG_NODIR) {
-			/* match basename */
-			if (prefix =3D=3D x->patternlen) {
-				if (!strcmp_icase(exclude, basename))
-					return to_exclude;
-			} else if (x->flags & EXC_FLAG_ENDSWITH) {
-				int len =3D pathlen - (basename - pathname);
-				if (x->patternlen - 1 <=3D len &&
-				    !strcmp_icase(exclude + 1, basename + len - x->patternlen + 1)=
)
-					return to_exclude;
-			} else {
-				if (fnmatch_icase(exclude, basename, 0) =3D=3D 0)
-					return to_exclude;
-			}
+			if (match_basename(basename,
+					   pathlen - (basename - pathname),
+					   exclude, prefix, x->patternlen,
+					   x->flags))
+				return to_exclude;
 			continue;
 		}
=20
diff --git a/dir.h b/dir.h
index fd5c2aa..d416c5a 100644
--- a/dir.h
+++ b/dir.h
@@ -78,6 +78,8 @@ extern int read_directory(struct dir_struct *, const =
char *path, int len, const
=20
 extern int excluded_from_list(const char *pathname, int pathlen, const=
 char *basename,
 			      int *dtype, struct exclude_list *el);
+extern int match_basename(const char *, int,
+			  const char *, int, int, int);
 struct dir_entry *dir_add_ignored(struct dir_struct *dir, const char *=
pathname, int len);
=20
 /*
--=20
1.8.0.rc2.11.g2b79d01

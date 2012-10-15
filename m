From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/6] exclude: split pathname matching code into a separate function
Date: Mon, 15 Oct 2012 13:24:37 +0700
Message-ID: <1350282279-4377-4-git-send-email-pclouds@gmail.com>
References: <1350282212-4270-1-git-send-email-pclouds@gmail.com>
 <1350282279-4377-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 15 08:25:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNe7E-0006HV-Qt
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 08:25:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753856Ab2JOGZQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Oct 2012 02:25:16 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:53044 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753803Ab2JOGZP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 02:25:15 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so4624292pbb.19
        for <git@vger.kernel.org>; Sun, 14 Oct 2012 23:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ZQRvCOFpjsFYdSSTSts2MrT7WXd5HNlHae+1yDMV21k=;
        b=yqzCZm5Brk+jVB/KYD2DBaUJKWroU/he2DuBqsBWOyirzyaLoWYoWhYHkU3SI0ywND
         2aIPYj2vzrFGefYWHaE1iYClUHs89hBZ+oxeIhnq7tFoFRn+nCo93GYNF9/eY+XCKKAv
         i2MihilSZctdmuSyQffNc0irZ7ti6OofWuv6ZwsTUJc6onBzw7eY6CZ4J6wYeUHNoA6/
         SGzOubd5KFp8dCqFAcPJ6niLlYYVDZDb/EF/pDlzwBglM+UCQTaQJxZx4/uCteNEEDbO
         /rKHKC5AB/4COzXSZtIyFRBP2PGbjF/Rd2UYbnqXMxpSJhOXLmX4a8UFFT2rdmc/kL2O
         JfmA==
Received: by 10.68.237.106 with SMTP id vb10mr34141784pbc.112.1350282314543;
        Sun, 14 Oct 2012 23:25:14 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id lb3sm928406pbc.73.2012.10.14.23.25.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 14 Oct 2012 23:25:13 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 15 Oct 2012 13:25:04 +0700
X-Mailer: git-send-email 1.8.0.rc0.29.g1fdd78f
In-Reply-To: <1350282279-4377-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207696>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c | 85 ++++++++++++++++++++++++++++++++++++++++++-----------------=
--------
 1 file changed, 53 insertions(+), 32 deletions(-)

diff --git a/dir.c b/dir.c
index 22d0b7b..32d1c90 100644
--- a/dir.c
+++ b/dir.c
@@ -522,6 +522,53 @@ static int match_basename(const char *basename, in=
t basenamelen,
 	return 0;
 }
=20
+static int match_pathname(const char *pathname, int pathlen,
+			  const char *base, int baselen,
+			  const char *pattern, int prefix, int patternlen,
+			  int flags)
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
@@ -536,9 +583,9 @@ int excluded_from_list(const char *pathname,
=20
 	for (i =3D el->nr - 1; 0 <=3D i; i--) {
 		struct exclude *x =3D el->excludes[i];
-		const char *name, *exclude =3D x->pattern;
+		const char *exclude =3D x->pattern;
 		int to_exclude =3D x->to_exclude;
-		int namelen, prefix =3D x->nowildcardlen;
+		int prefix =3D x->nowildcardlen;
=20
 		if (x->flags & EXC_FLAG_MUSTBEDIR) {
 			if (*dtype =3D=3D DT_UNKNOWN)
@@ -556,36 +603,10 @@ int excluded_from_list(const char *pathname,
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
--=20
1.8.0.rc0.29.g1fdd78f

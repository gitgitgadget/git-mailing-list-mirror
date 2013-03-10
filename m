From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 4/6] match_{base,path}name: replace strncmp_icase with strnequal_icase
Date: Sun, 10 Mar 2013 13:14:28 +0700
Message-ID: <1362896070-17456-5-git-send-email-pclouds@gmail.com>
References: <1362802190-7331-1-git-send-email-pclouds@gmail.com>
 <1362896070-17456-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 10 07:15:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEZXi-0001JZ-MG
	for gcvg-git-2@plane.gmane.org; Sun, 10 Mar 2013 07:15:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206Ab3CJGPF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Mar 2013 01:15:05 -0500
Received: from mail-pb0-f46.google.com ([209.85.160.46]:48560 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751167Ab3CJGPE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Mar 2013 01:15:04 -0500
Received: by mail-pb0-f46.google.com with SMTP id uo15so2614226pbc.5
        for <git@vger.kernel.org>; Sat, 09 Mar 2013 22:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=m5N6h5L1BXFACPXaZOrb78f+r7kihxYPDp7YH9wKTKI=;
        b=rVisVuL5I63nXc1M4kXnOE+r0C51RHiHkyge2EFfRqiQhDxeZYUpw6gwMedA9yjF35
         Fx8B+ifddmPFlFoaF1dwhBXrhflC1pWnGlcdR/HD367UQL+JSw90UtvQys8rCpUjZYiQ
         kT4li5pU1kW4EsPxV0TEWie7HCQRaXjF3v2tvcEJrI/0tAnJQB1vQXiCVZ0CeKTURXQb
         eoGWiX9k1t74DL8kxatb0VOzbzkdA5IBkC0Ng2uhCN0ksT0rT3QIMtloqta6sT4ahR0F
         oCRC9/Tc2z++MlfTeSfFsGlvyTdIcpQFESTeANWVD/dQy35OdMjOAC3+zKLu07LwnDjv
         G+sg==
X-Received: by 10.68.197.133 with SMTP id iu5mr16935158pbc.195.1362896103896;
        Sat, 09 Mar 2013 22:15:03 -0800 (PST)
Received: from lanh ([115.74.63.193])
        by mx.google.com with ESMTPS id wm3sm13864297pbc.4.2013.03.09.22.15.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 09 Mar 2013 22:15:03 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 10 Mar 2013 13:14:58 +0700
X-Mailer: git-send-email 1.8.1.2.536.gf441e6d
In-Reply-To: <1362896070-17456-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217784>

We could also optimize for ignore_case, assuming that non-ascii
characters are not used in most repositories. We could check that all
patterns and pathnames are ascii-only, then use git's toupper()

        before      after
user    0m0.516s    0m0.433s
user    0m0.523s    0m0.437s
user    0m0.532s    0m0.443s
user    0m0.533s    0m0.448s
user    0m0.535s    0m0.449s
user    0m0.542s    0m0.452s
user    0m0.546s    0m0.453s
user    0m0.551s    0m0.458s
user    0m0.556s    0m0.459s
user    0m0.561s    0m0.462s

Suggested-by: Fredrik Gustafsson <iveqy@iveqy.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/dir.c b/dir.c
index 46b24db..7b6a625 100644
--- a/dir.c
+++ b/dir.c
@@ -21,6 +21,25 @@ static int read_directory_recursive(struct dir_struc=
t *dir, const char *path, in
 	int check_only, const struct path_simplify *simplify);
 static int get_dtype(struct dirent *de, const char *path, int len);
=20
+/*
+ * This function is more like memequal_icase than strnequal_icase as
+ * it does not check for NUL. The caller is not supposed to pass a
+ * length longer than both input strings
+ */
+static inline strnequal_icase(const char *a, const char *b, int n)
+{
+	if (!ignore_case) {
+		while (n && *a =3D=3D *b) {
+			a++;
+			b++;
+			n--;
+		}
+		return n =3D=3D 0;
+	}
+
+	return !strncmp_icase(a, b, n);
+}
+
 inline int git_fnmatch(const char *pattern, const char *string,
 		       int flags, int prefix)
 {
@@ -611,11 +630,11 @@ int match_basename(const char *basename, int base=
namelen,
 {
 	if (prefix =3D=3D patternlen) {
 		if (patternlen =3D=3D basenamelen &&
-		    !strncmp_icase(pattern, basename, patternlen))
+		    strnequal_icase(pattern, basename, patternlen))
 			return 1;
 	} else if (flags & EXC_FLAG_ENDSWITH) {
 		if (patternlen - 1 <=3D basenamelen &&
-		    !strncmp_icase(pattern + 1,
+		    strnequal_icase(pattern + 1,
 				   basename + basenamelen - patternlen + 1,
 				   patternlen - 1))
 			return 1;
@@ -649,7 +668,7 @@ int match_pathname(const char *pathname, int pathle=
n,
 	 */
 	if (pathlen < baselen + 1 ||
 	    (baselen && (pathname[baselen] !=3D '/' ||
-			 strncmp_icase(pathname, base, baselen))))
+			 !strnequal_icase(pathname, base, baselen))))
 		return 0;
=20
 	namelen =3D baselen ? pathlen - baselen - 1 : pathlen;
@@ -663,7 +682,7 @@ int match_pathname(const char *pathname, int pathle=
n,
 		if (prefix > namelen)
 			return 0;
=20
-		if (strncmp_icase(pattern, name, prefix))
+		if (!strnequal_icase(pattern, name, prefix))
 			return 0;
 		pattern +=3D prefix;
 		name    +=3D prefix;
--=20
1.8.1.2.536.gf441e6d

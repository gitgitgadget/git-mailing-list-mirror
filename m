From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 05/13] match_{base,path}name: replace strncmp_icase with memequal_icase
Date: Tue, 12 Mar 2013 20:04:52 +0700
Message-ID: <1363093500-16796-6-git-send-email-pclouds@gmail.com>
References: <1362896070-17456-1-git-send-email-pclouds@gmail.com>
 <1363093500-16796-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 12 14:06:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFOuP-0007Yu-5L
	for gcvg-git-2@plane.gmane.org; Tue, 12 Mar 2013 14:06:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755413Ab3CLNFw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Mar 2013 09:05:52 -0400
Received: from mail-da0-f54.google.com ([209.85.210.54]:54785 "EHLO
	mail-da0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755278Ab3CLNFv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Mar 2013 09:05:51 -0400
Received: by mail-da0-f54.google.com with SMTP id p1so1259365dad.27
        for <git@vger.kernel.org>; Tue, 12 Mar 2013 06:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=ZH40xoWGfV6yKA82Do9HTspAja7ZdO5rJse4aKOax4I=;
        b=TRASQXapauI73O77zfm8brZU+hZS3OuZq8rZsZI93863h1OK0Xua3olLBEorpjrBl9
         cwxBy8U2h8XPeNxoEIf9sIkERzsb4sflbFSnY0lGxDM1NwC0iiXX5T9X4Pq1M1wVCfdz
         qosEZf9oass22IhXqv4Cf9Yaf+XIyu4kgw8x0UaE2B7qmSjBOtL8y7L7E5kyajdbzOSH
         uFzTCh39a81RCpJOkd01RGljQ4gE1E8+nh/xLHhUK4WfIipPla41cRPwm7aWx3qZIPR5
         B+kv3peEO6qxmhdsDYovpodBVBtQVyUkU5bnz8hnZzymR537pQyKolrdVlFCcpIUcDQZ
         awzw==
X-Received: by 10.68.224.65 with SMTP id ra1mr37011471pbc.55.1363093551137;
        Tue, 12 Mar 2013 06:05:51 -0700 (PDT)
Received: from lanh ([115.74.63.193])
        by mx.google.com with ESMTPS id kb3sm24994059pbc.21.2013.03.12.06.05.48
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 12 Mar 2013 06:05:50 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 12 Mar 2013 20:05:44 +0700
X-Mailer: git-send-email 1.8.1.2.536.gf441e6d
In-Reply-To: <1363093500-16796-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217955>

treat_leading_path:   0.000  0.000
read_directory:       3.578  3.501
+treat_one_path:      2.323  2.257
++is_excluded:        2.117  2.056
+++prep_exclude:      0.224  0.216
+++matching:          1.544  1.493
++dir_exist:          0.035  0.035
++index_name_exists:  0.290  0.292
lazy_init_name_hash:  0.258  0.256
+simplify_away:       0.087  0.084
+dir_add_name:        0.445  0.447

Suggested-by: Fredrik Gustafsson <iveqy@iveqy.com>
Suggested-by: Antoine Pelisse <apelisse@gmail.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/dir.c b/dir.c
index a2ab200..26c3b3a 100644
--- a/dir.c
+++ b/dir.c
@@ -47,6 +47,29 @@ static int read_directory_recursive(struct dir_struc=
t *dir, const char *path, in
 	int check_only, const struct path_simplify *simplify);
 static int get_dtype(struct dirent *de, const char *path, int len);
=20
+static inline int memequal_icase(const char *a, const char *b, int n)
+{
+	if (!memcmp(a, b, n))
+		return 1;
+
+	if (!ignore_case)
+		return 0;
+
+	/*
+	 * This assumes that ASCII is used in most repositories. We
+	 * try the ascii-only version first (i.e. Git's
+	 * toupper). Failing that, fall back to normal strncasecmp.
+	 */
+	while (n && toupper(*a) =3D=3D toupper(*b)) {
+		a++;
+		b++;
+		n--;
+	}
+	if (!n)
+		return 1;
+	return !strncasecmp(a, b, n);
+}
+
 inline int git_fnmatch(const char *pattern, const char *string,
 		       int flags, int prefix)
 {
@@ -637,11 +660,11 @@ int match_basename(const char *basename, int base=
namelen,
 {
 	if (prefix =3D=3D patternlen) {
 		if (patternlen =3D=3D basenamelen &&
-		    !strncmp_icase(pattern, basename, patternlen))
+		    memequal_icase(pattern, basename, patternlen))
 			return 1;
 	} else if (flags & EXC_FLAG_ENDSWITH) {
 		if (patternlen - 1 <=3D basenamelen &&
-		    !strncmp_icase(pattern + 1,
+		    memequal_icase(pattern + 1,
 				   basename + basenamelen - patternlen + 1,
 				   patternlen - 1))
 			return 1;
@@ -675,7 +698,7 @@ int match_pathname(const char *pathname, int pathle=
n,
 	 */
 	if (pathlen < baselen + 1 ||
 	    (baselen && (pathname[baselen] !=3D '/' ||
-			 strncmp_icase(pathname, base, baselen))))
+			 !memequal_icase(pathname, base, baselen))))
 		return 0;
=20
 	namelen =3D baselen ? pathlen - baselen - 1 : pathlen;
@@ -689,7 +712,7 @@ int match_pathname(const char *pathname, int pathle=
n,
 		if (prefix > namelen)
 			return 0;
=20
-		if (strncmp_icase(pattern, name, prefix))
+		if (!memequal_icase(pattern, name, prefix))
 			return 0;
 		pattern +=3D prefix;
 		name    +=3D prefix;
--=20
1.8.1.2.536.gf441e6d

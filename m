From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/6] exclude: split basename matching code into a separate function
Date: Mon, 15 Oct 2012 13:24:35 +0700
Message-ID: <1350282279-4377-2-git-send-email-pclouds@gmail.com>
References: <1350282212-4270-1-git-send-email-pclouds@gmail.com>
 <1350282279-4377-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 15 08:25:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNe6w-00064L-4F
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 08:25:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753426Ab2JOGY7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Oct 2012 02:24:59 -0400
Received: from mail-da0-f46.google.com ([209.85.210.46]:51858 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753358Ab2JOGY6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 02:24:58 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so2429486dak.19
        for <git@vger.kernel.org>; Sun, 14 Oct 2012 23:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=8EuvCw0XrQDl2YTWdfylAc6AEh/M101Ggji/hTCBa4E=;
        b=sDd7WO47KKCmw0X+uPVmIlpvoMVM7na/GWJ8YVLfbJEMUjW4TZtD0/l6y39KD9Di+g
         AMfWR4Yq1ml0SBq5QB5xI+/NCSQHJhgarl+N+VqIxy/+4dBo07o+SQV2ETaD4Icq8CQs
         jLDDaTHtILbDOLd3eqhwVfTJbZBmesqjY3vZwUbqhUCjiNs4bdy6AXm3zd8rTaeprlbO
         RfLHYAvMngkXDzMeAazFAHimv75P+xWY3UPGa9F2zWIX6qRFOyUO2622dTy9xttOUcUJ
         pT6HFgrcjdPZ4S0Z3P4it2B53qZdS4L/HA0SmXdQQhvfvjuFGtpruZfbQ/AJs9uzLdQ9
         dHCQ==
Received: by 10.68.222.37 with SMTP id qj5mr33939413pbc.132.1350282298227;
        Sun, 14 Oct 2012 23:24:58 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id qq1sm8566237pbc.74.2012.10.14.23.24.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 14 Oct 2012 23:24:57 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 15 Oct 2012 13:24:48 +0700
X-Mailer: git-send-email 1.8.0.rc0.29.g1fdd78f
In-Reply-To: <1350282279-4377-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207694>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/dir.c b/dir.c
index b0ae417..d9b5561 100644
--- a/dir.c
+++ b/dir.c
@@ -503,6 +503,25 @@ static void prep_exclude(struct dir_struct *dir, c=
onst char *base, int baselen)
 	dir->basebuf[baselen] =3D '\0';
 }
=20
+static int match_basename(const char *basename, int basenamelen,
+			  const char *pattern, int prefix, int patternlen,
+			  int flags)
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
@@ -529,19 +548,11 @@ int excluded_from_list(const char *pathname,
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
--=20
1.8.0.rc0.29.g1fdd78f

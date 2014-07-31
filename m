From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 2/3] lockfile.c: remove PATH_MAX limit in resolve_symlink()
Date: Thu, 31 Jul 2014 20:43:33 +0700
Message-ID: <1406814214-21725-3-git-send-email-pclouds@gmail.com>
References: <1405858399-23082-1-git-send-email-pclouds@gmail.com>
 <1406814214-21725-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, ramsay@ramsay1.demon.co.uk,
	yuelinho777@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 31 15:43:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCqe8-0004dy-C7
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jul 2014 15:43:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750977AbaGaNnr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Jul 2014 09:43:47 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:55357 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750911AbaGaNnr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2014 09:43:47 -0400
Received: by mail-pa0-f42.google.com with SMTP id lf10so3673803pab.29
        for <git@vger.kernel.org>; Thu, 31 Jul 2014 06:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=HDR5qr77f0j9LsIU2CuX42WDSG+vPCFr42MDhuOSvlc=;
        b=Qo2XKpWSKcTnDrobEeDHCqTIu2Ru5+5OSyCCeVMimbK6bftyyVrxYmp56OpOSjHlhT
         ESaSgPfILn0gsIhjRbHg+jCMp04eE6BULmHnkdiViBsXlekTpfluhYVip0y6caVYlZwW
         /k5+jVyGA+JZs0bBABY2QDeosW0ieVm4Zpf/HFBjuFAncai+gk9uDpkC+cOLSb6n+T/6
         3X5lXNGKR2yQFAVltY8sD3WqdDv2fvWkYMF0nLGmr47Chl77yysslD5gt9Fr5Yr+L2H4
         lOg4DnCmAa6KIVloU0Stjd4u6Zxt803ikQo8SXnNpc2csXT5XSiHtSCEvGW2euKl8d0o
         0W+Q==
X-Received: by 10.68.167.133 with SMTP id zo5mr4367837pbb.21.1406814226383;
        Thu, 31 Jul 2014 06:43:46 -0700 (PDT)
Received: from lanh ([115.73.244.27])
        by mx.google.com with ESMTPSA id xk1sm19373805pac.21.2014.07.31.06.43.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jul 2014 06:43:45 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Thu, 31 Jul 2014 20:43:51 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1406814214-21725-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254572>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 lockfile.c | 47 ++++++++++++++---------------------------------
 1 file changed, 14 insertions(+), 33 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index 968b28f..154915f 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -85,52 +85,33 @@ static char *last_path_elm(char *p)
=20
 static char *resolve_symlink(const char *in)
 {
-	static char p[PATH_MAX];
-	size_t s =3D sizeof(p);
+	static struct strbuf p =3D STRBUF_INIT;
+	struct strbuf link =3D STRBUF_INIT;
 	int depth =3D MAXDEPTH;
=20
-	if (strlen(in) >=3D sizeof(p))
-		return NULL;
-	strcpy(p, in);
+	strbuf_reset(&p);
+	strbuf_addstr(&p, in);
=20
 	while (depth--) {
-		char link[PATH_MAX];
-		int link_len =3D readlink(p, link, sizeof(link));
-		if (link_len < 0) {
-			/* not a symlink anymore */
-			return p;
-		}
-		else if (link_len < sizeof(link))
-			/* readlink() never null-terminates */
-			link[link_len] =3D '\0';
-		else {
-			warning("%s: symlink too long", p);
-			return p;
-		}
+		if (strbuf_readlink(&link, p.buf, 0) < 0)
+			break;	/* not a symlink anymore */
=20
-		if (is_absolute_path(link)) {
+		if (is_absolute_path(link.buf)) {
 			/* absolute path simply replaces p */
-			if (link_len < s)
-				strcpy(p, link);
-			else {
-				warning("%s: symlink too long", p);
-				return p;
-			}
+			strbuf_reset(&p);
+			strbuf_addbuf(&p, &link);
 		} else {
 			/*
 			 * link is a relative path, so I must replace the
 			 * last element of p with it.
 			 */
-			char *r =3D (char *)last_path_elm(p);
-			if (r - p + link_len < s)
-				strcpy(r, link);
-			else {
-				warning("%s: symlink too long", p);
-				return p;
-			}
+			char *r =3D (char *)last_path_elm(p.buf);
+			strbuf_setlen(&p, r - p.buf);
+			strbuf_addbuf(&p, &link);
 		}
 	}
-	return p;
+	strbuf_release(&link);
+	return p.buf;
 }
=20
=20
--=20
2.1.0.rc0.78.gc0d8480

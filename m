From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/4] Revert "test-wildmatch: add "perf" command to compare wildmatch and fnmatch"
Date: Sat, 15 Feb 2014 09:01:47 +0700
Message-ID: <1392429709-9237-3-git-send-email-pclouds@gmail.com>
References: <1392429709-9237-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 15 03:02:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEUa2-0004Rw-Df
	for gcvg-git-2@plane.gmane.org; Sat, 15 Feb 2014 03:02:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751692AbaBOCCD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Feb 2014 21:02:03 -0500
Received: from mail-pb0-f45.google.com ([209.85.160.45]:50397 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751615AbaBOCBy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Feb 2014 21:01:54 -0500
Received: by mail-pb0-f45.google.com with SMTP id un15so13016679pbc.18
        for <git@vger.kernel.org>; Fri, 14 Feb 2014 18:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=xstmcSvylc9xvLWhBxhfj3xNk9GHrgI+s1tx7CXV5lQ=;
        b=dcnsgoOVbfCYcjXWf5roj+TTI1aT6WHQIRwCZx+2J3+aa643VcjA7Cpjeabx+x60Mg
         7cJk+bPLcGdHczpOmy1F1txjRRAPt6L3gFwB4TmW2XcFKIos+MQMmKSPQ1v/Frx9vq/N
         QZz1mOD+daG3sd6NkJozKBFAURIryyY6ayaAFMBhL4NXJl3gucbOiOUq+3sgEomOHu3k
         XYSF4OqhlJLb0QXAB+Iyml3oSQCXFno1+vwmEKCBWZzoCXcPVYVV9Gq0gVS/TwOjQ6b4
         DmIuvdhkWjqVAldgb93XIRCBO3HR9/85Kb6j1ndRVQnefhKc9cP9bh0+UTwib41rAjU9
         c/Rw==
X-Received: by 10.68.98.3 with SMTP id ee3mr12764426pbb.31.1392429713786;
        Fri, 14 Feb 2014 18:01:53 -0800 (PST)
Received: from lanh ([115.73.215.60])
        by mx.google.com with ESMTPSA id iq10sm21855631pbc.14.2014.02.14.18.01.50
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 14 Feb 2014 18:01:53 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 15 Feb 2014 09:02:03 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1392429709-9237-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242172>

This reverts commit 1b25892636d2f250eb2163301440ee8c8c1ac944. compat
fnmatch will be removed soon and we can't rely on fnmatch() available
everywhere.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 test-wildmatch.c | 73 ------------------------------------------------=
--------
 1 file changed, 73 deletions(-)

diff --git a/test-wildmatch.c b/test-wildmatch.c
index a3e2643..1564bd5 100644
--- a/test-wildmatch.c
+++ b/test-wildmatch.c
@@ -4,82 +4,9 @@
 #include "cache.h"
 #include "wildmatch.h"
=20
-static int perf(int ac, char **av)
-{
-	struct timeval tv1, tv2;
-	struct stat st;
-	int fd, i, n, flags1 =3D 0, flags2 =3D 0;
-	char *buffer, *p;
-	uint32_t usec1, usec2;
-	const char *lang;
-	const char *file =3D av[0];
-	const char *pattern =3D av[1];
-
-	lang =3D getenv("LANG");
-	if (lang && strcmp(lang, "C"))
-		die("Please test it on C locale.");
-
-	if ((fd =3D open(file, O_RDONLY)) =3D=3D -1 || fstat(fd, &st))
-		die_errno("file open");
-
-	buffer =3D xmalloc(st.st_size + 2);
-	if (read(fd, buffer, st.st_size) !=3D st.st_size)
-		die_errno("read");
-
-	buffer[st.st_size] =3D '\0';
-	buffer[st.st_size + 1] =3D '\0';
-	for (i =3D 0; i < st.st_size; i++)
-		if (buffer[i] =3D=3D '\n')
-			buffer[i] =3D '\0';
-
-	n =3D atoi(av[2]);
-	if (av[3] && !strcmp(av[3], "pathname")) {
-		flags1 =3D WM_PATHNAME;
-		flags2 =3D FNM_PATHNAME;
-	}
-
-	gettimeofday(&tv1, NULL);
-	for (i =3D 0; i < n; i++) {
-		for (p =3D buffer; *p; p +=3D strlen(p) + 1)
-			wildmatch(pattern, p, flags1, NULL);
-	}
-	gettimeofday(&tv2, NULL);
-
-	usec1 =3D (uint32_t)tv2.tv_sec * 1000000 + tv2.tv_usec;
-	usec1 -=3D (uint32_t)tv1.tv_sec * 1000000 + tv1.tv_usec;
-	printf("wildmatch %ds %dus\n",
-	       (int)(usec1 / 1000000),
-	       (int)(usec1 % 1000000));
-
-	gettimeofday(&tv1, NULL);
-	for (i =3D 0; i < n; i++) {
-		for (p =3D buffer; *p; p +=3D strlen(p) + 1)
-			fnmatch(pattern, p, flags2);
-	}
-	gettimeofday(&tv2, NULL);
-
-	usec2 =3D (uint32_t)tv2.tv_sec * 1000000 + tv2.tv_usec;
-	usec2 -=3D (uint32_t)tv1.tv_sec * 1000000 + tv1.tv_usec;
-	if (usec2 > usec1)
-		printf("fnmatch   %ds %dus or %.2f%% slower\n",
-		       (int)((usec2 - usec1) / 1000000),
-		       (int)((usec2 - usec1) % 1000000),
-		       (float)(usec2 - usec1) / usec1 * 100);
-	else
-		printf("fnmatch   %ds %dus or %.2f%% faster\n",
-		       (int)((usec1 - usec2) / 1000000),
-		       (int)((usec1 - usec2) % 1000000),
-		       (float)(usec1 - usec2) / usec1 * 100);
-	return 0;
-}
-
 int main(int argc, char **argv)
 {
 	int i;
-
-	if (!strcmp(argv[1], "perf"))
-		return perf(argc - 2, argv + 2);
-
 	for (i =3D 2; i < argc; i++) {
 		if (argv[i][0] =3D=3D '/')
 			die("Forward slash is not allowed at the beginning of the\n"
--=20
1.8.5.2.240.g8478abd

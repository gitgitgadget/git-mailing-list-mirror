From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/3] match_pathname: avoid calling strncmp if baselen is 0
Date: Sat,  9 Mar 2013 11:09:48 +0700
Message-ID: <1362802190-7331-2-git-send-email-pclouds@gmail.com>
References: <1362802190-7331-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 09 05:10:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEB7E-0006Vb-8m
	for gcvg-git-2@plane.gmane.org; Sat, 09 Mar 2013 05:10:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760328Ab3CIEKH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Mar 2013 23:10:07 -0500
Received: from mail-pb0-f50.google.com ([209.85.160.50]:59129 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760297Ab3CIEKF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Mar 2013 23:10:05 -0500
Received: by mail-pb0-f50.google.com with SMTP id up1so1856915pbc.23
        for <git@vger.kernel.org>; Fri, 08 Mar 2013 20:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=R6wM94i0OhSwYDNDMtgGGjiAr7hkKypgz990N9gw8xw=;
        b=a7X/pJOii5VJMQesnqAAIaKFX+y9s9kjT4DUhl7rQdnw+Cgss/L0K9N/t6ofm1/qsN
         TpZFUepD0izA2bCeZFVgYkUFZPBAK1kX9GM/CyTzyDnx8/c6OCoqa4IFZ4AqbCmE3N3h
         LF2XOB/EZ/1+lct6qH8LV0LK+BwfrskmS1D4vzigx5dmYIj0NxoG+GCCXyZRZut06VNL
         hWjwywSUvLE7iNczYtMScLrZwWsa8Pph7y4vYKtvZeGe1eAe0EMXkp0AmuvhR1s51SeR
         SyRvqegUFoFfkZPvkxkyAFEFJn3ZgbZ1z7V/Tl6cyI6ARGGN9fMji2TnrsrqCC+RI3VM
         yZew==
X-Received: by 10.68.251.98 with SMTP id zj2mr2275150pbc.95.1362802204735;
        Fri, 08 Mar 2013 20:10:04 -0800 (PST)
Received: from lanh ([115.74.63.193])
        by mx.google.com with ESMTPS id zm1sm8141336pbc.26.2013.03.08.20.10.01
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 08 Mar 2013 20:10:03 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 09 Mar 2013 11:09:58 +0700
X-Mailer: git-send-email 1.8.1.2.536.gf441e6d
In-Reply-To: <1362802190-7331-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217696>

This reduces "git status" user time by a little bit. This is the
sorted results of 10 consecutive runs of "git ls-files
--exclude-standard -o" on webkit.git, compiled with gcc -O2:

        before      after
user    0m0.580s    0m0.546s
user    0m0.581s    0m0.549s
user    0m0.582s    0m0.550s
user    0m0.584s    0m0.558s
user    0m0.586s    0m0.560s
user    0m0.587s    0m0.561s
user    0m0.587s    0m0.562s
user    0m0.593s    0m0.566s
user    0m0.597s    0m0.568s
user    0m0.601s    0m0.573s

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index 57394e4..669cf80 100644
--- a/dir.c
+++ b/dir.c
@@ -663,7 +663,7 @@ int match_pathname(const char *pathname, int pathle=
n,
 	 */
 	if (pathlen < baselen + 1 ||
 	    (baselen && pathname[baselen] !=3D '/') ||
-	    strncmp_icase(pathname, base, baselen))
+	    (baselen && strncmp_icase(pathname, base, baselen)))
 		return 0;
=20
 	namelen =3D baselen ? pathlen - baselen - 1 : pathlen;
--=20
1.8.1.2.536.gf441e6d

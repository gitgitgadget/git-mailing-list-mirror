From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 01/12] Make starts_with() a wrapper of skip_prefix()
Date: Wed, 18 Dec 2013 21:53:46 +0700
Message-ID: <1387378437-20646-2-git-send-email-pclouds@gmail.com>
References: <1387378437-20646-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 18 15:54:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtIVw-0003BE-CR
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 15:54:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755170Ab3LROyL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Dec 2013 09:54:11 -0500
Received: from mail-pa0-f42.google.com ([209.85.220.42]:49484 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754996Ab3LROyJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Dec 2013 09:54:09 -0500
Received: by mail-pa0-f42.google.com with SMTP id lj1so6096374pab.1
        for <git@vger.kernel.org>; Wed, 18 Dec 2013 06:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ZJ77fySTmgNo3kQbK5cSq1KlHLMPvQrbgizRir74xmk=;
        b=ijFn8njuZj7W8PD2qHyT3vUPfwUWzu9lxgFblQ/oqOvriaSdprfJaT7w4wcZyhhkSE
         ORRGutFKHO7BOqTs8227CVGzvM+0n/TGEBXuLdzOVqPextZOR0/ORUMzRWs3yKNCoK4q
         EkCUT4v/xM6kLPcxoDLvQuqWlXSndzAD58AhykbAXkHAMpG18CHJlw3EuO+UEHnEzRBK
         G6uP6dEBydm9bxMHJ0sr8mtm70gOtP76rkYdF6HV4zb1aGtvMSRiBH8w4sLV5TJVpdIP
         oi7XDWYKoFsnSiL3ssw4I1xUugbtj0mh38j+AJbfIe1WoWE4Qt/zRLxrn/9Hx1eIlIue
         r6Sg==
X-Received: by 10.66.121.131 with SMTP id lk3mr33984214pab.61.1387378448826;
        Wed, 18 Dec 2013 06:54:08 -0800 (PST)
Received: from lanh ([115.73.220.136])
        by mx.google.com with ESMTPSA id ug2sm632397pac.21.2013.12.18.06.54.06
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 18 Dec 2013 06:54:08 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 18 Dec 2013 21:54:05 +0700
X-Mailer: git-send-email 1.8.5.1.208.g019362e
In-Reply-To: <1387378437-20646-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239439>

starts_with() started out as a copy of prefixcmp(). But if we don't
care about the sorting order, the logic looks closer to
skip_prefix(). This looks like a good thing to do.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 git-compat-util.h | 6 +++++-
 strbuf.c          | 9 ---------
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index b73916b..84f1078 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -350,7 +350,6 @@ extern void set_die_routine(NORETURN_PTR void (*rou=
tine)(const char *err, va_lis
 extern void set_error_routine(void (*routine)(const char *err, va_list=
 params));
 extern void set_die_is_recursing_routine(int (*routine)(void));
=20
-extern int starts_with(const char *str, const char *prefix);
 extern int prefixcmp(const char *str, const char *prefix);
 extern int ends_with(const char *str, const char *suffix);
 extern int suffixcmp(const char *str, const char *suffix);
@@ -361,6 +360,11 @@ static inline const char *skip_prefix(const char *=
str, const char *prefix)
 	return strncmp(str, prefix, len) ? NULL : str + len;
 }
=20
+static inline int starts_with(const char *str, const char *prefix)
+{
+	return skip_prefix(str, prefix) !=3D NULL;
+}
+
 #if defined(NO_MMAP) || defined(USE_WIN32_MMAP)
=20
 #ifndef PROT_READ
diff --git a/strbuf.c b/strbuf.c
index 83caf4a..bd4c0d8 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -1,15 +1,6 @@
 #include "cache.h"
 #include "refs.h"
=20
-int starts_with(const char *str, const char *prefix)
-{
-	for (; ; str++, prefix++)
-		if (!*prefix)
-			return 1;
-		else if (*str !=3D *prefix)
-			return 0;
-}
-
 int prefixcmp(const char *str, const char *prefix)
 {
 	for (; ; str++, prefix++)
--=20
1.8.5.1.208.g019362e

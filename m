From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 01/41] usage.c: move format processing out of die_errno()
Date: Sun,  8 May 2016 16:47:21 +0700
Message-ID: <1462700881-25108-2-git-send-email-pclouds@gmail.com>
References: <1462277054-5943-1-git-send-email-pclouds@gmail.com>
 <1462700881-25108-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 11:50:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azLKL-0007vq-1o
	for gcvg-git-2@plane.gmane.org; Sun, 08 May 2016 11:48:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbcEHJsi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2016 05:48:38 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35902 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750698AbcEHJsh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2016 05:48:37 -0400
Received: by mail-pf0-f193.google.com with SMTP id p185so16151525pfb.3
        for <git@vger.kernel.org>; Sun, 08 May 2016 02:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G7R9Ihn27mBlLpwfgyfSC3RmaMWX/ZRALGapUMbFnso=;
        b=wqIOu7IyCoFRD/zdYgDOEyzv0bBDen2SMxnbcJA4WZ3xJeFIycNNKaxGrmfK/cUzuM
         cBxIU7M+ImkOYbBu1x34wF9vFcBLlH7TAsaM2bJMUVqv4eoxXfjMKIX7ArvFfMIuHaoe
         WzCkBwFEMqBRpn2kUBs//arkM6bvH7FHkShGhgSR+GJuqh0VAkYiC26ZNOJAEHYAGK+p
         z/vWchSFokEpv6gWoMemaGyCTJ/MpH+fV0Gmn7zEsJg44Jz95mhIasJ/eg9DiWhHQJAe
         NQDsQjecu2HENeP9HS8UXGVBnV6Sm52gpKi1m9yv1VV06qpiKak7DaIT4y6tSAofdx8G
         X9XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G7R9Ihn27mBlLpwfgyfSC3RmaMWX/ZRALGapUMbFnso=;
        b=gMkbm7KJ3ULY6RaOP3B/JL6LAh4We5YAm9Z2Bh7JquXUszjQ8Ki13hJV17NglncvfK
         Wm0OdDrXjYoQD573u6XIQKKs18dB8xend9Us8HkGemh8iF4LXu+lCnqlNRY32dX11bGe
         74+qsb6iQtYVmkyioF49S6a36RRuaACPmAKabXVANOMQjyYT/jKVFfVhlFw2R9+7VsUU
         yOJWAddundRaix57GTQFgHKS4YYB2eTGiKQEpEqG0NB+i3jMOhhkd5FgkA7Yt2UtqFns
         o31vmm7vA2ONH4iZN2K/jV+diTgRpQrG0D97o+mQdj0lU/xW05srbiOCCRIPEZMemw74
         wDLw==
X-Gm-Message-State: AOPr4FUS70SZHwEgBLJvGzQuBmYltoZvcCRSlk4gSgN8jeJ8UTI63tV0XY57pyNybV5WaQ==
X-Received: by 10.98.102.74 with SMTP id a71mr41671847pfc.139.1462700916872;
        Sun, 08 May 2016 02:48:36 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id a64sm32777985pfa.6.2016.05.08.02.48.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 May 2016 02:48:35 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 May 2016 16:48:36 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462700881-25108-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293925>

fmt_with_err() will be shared with the coming error_errno() and
warning_errno().

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 usage.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/usage.c b/usage.c
index 82ff131..8675d72 100644
--- a/usage.c
+++ b/usage.c
@@ -109,19 +109,11 @@ void NORETURN die(const char *err, ...)
 	va_end(params);
 }
=20
-void NORETURN die_errno(const char *fmt, ...)
+static const char *fmt_with_err(char *buf, int n, const char *fmt)
 {
-	va_list params;
-	char fmt_with_err[1024];
 	char str_error[256], *err;
 	int i, j;
=20
-	if (die_is_recursing()) {
-		fputs("fatal: recursion detected in die_errno handler\n",
-			stderr);
-		exit(128);
-	}
-
 	err =3D strerror(errno);
 	for (i =3D j =3D 0; err[i] && j < sizeof(str_error) - 1; ) {
 		if ((str_error[j++] =3D err[i++]) !=3D '%')
@@ -136,10 +128,23 @@ void NORETURN die_errno(const char *fmt, ...)
 		}
 	}
 	str_error[j] =3D 0;
-	snprintf(fmt_with_err, sizeof(fmt_with_err), "%s: %s", fmt, str_error=
);
+	snprintf(buf, n, "%s: %s", fmt, str_error);
+	return buf;
+}
+
+void NORETURN die_errno(const char *fmt, ...)
+{
+	char buf[1024];
+	va_list params;
+
+	if (die_is_recursing()) {
+		fputs("fatal: recursion detected in die_errno handler\n",
+			stderr);
+		exit(128);
+	}
=20
 	va_start(params, fmt);
-	die_routine(fmt_with_err, params);
+	die_routine(fmt_with_err(buf, sizeof(buf), fmt), params);
 	va_end(params);
 }
=20
--=20
2.8.0.rc0.210.gd302cd2

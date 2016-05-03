From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 01/41] usage.c: move format processing out of die_errno()
Date: Tue,  3 May 2016 19:03:34 +0700
Message-ID: <1462277054-5943-2-git-send-email-pclouds@gmail.com>
References: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
 <1462277054-5943-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 14:06:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axZ5t-00082X-NT
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 14:06:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932861AbcECMGV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 May 2016 08:06:21 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33582 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932805AbcECMGU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 08:06:20 -0400
Received: by mail-pa0-f44.google.com with SMTP id xk12so8962841pac.0
        for <git@vger.kernel.org>; Tue, 03 May 2016 05:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G7R9Ihn27mBlLpwfgyfSC3RmaMWX/ZRALGapUMbFnso=;
        b=vsUVA/PUyLaBV+5biQeGeq9dEO61EGSWn86kK95CZrqZ9WS9yY6jqdAI5123idmHsM
         1JidBlN5VnYv1ncf/nj9SxUTltL/TrNllSiSzJg7G0SteOBKrRrEUB6S+7Poi9TuncnK
         Sw/O9VERzWBKbtwqfXjN+kOpbRinWxBPzzeO1M4y8cGnmsrxLCMB2JpU2q29gVE3CGRG
         3GNrU+RVWoEIvySrb1TLAgtRnHELGsgwxE54IAwTPygz8/hno1u/fFQvgTfgPQDc1EbB
         D8mH7V0HWmYCGLZrbrOobJbnC5kDhvg0hytVzccYq2TuihhGncTKcUPs5VOMx2mzF/db
         9i6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G7R9Ihn27mBlLpwfgyfSC3RmaMWX/ZRALGapUMbFnso=;
        b=f5TPMUtzzQJS2wcdKbpDHWHrIdMUprI554ZiST4MjVvGQ8EJt0EoYgdoKYVoswu7SI
         8UjAbxJFHnxbHqLTxxImWSNhFqyc3B7TstquK7Uh9v3l0xB/gT3MPTRZzbL1x5kvrDPk
         1fH2wJeQky+O9Xm2juGx6RDoIABXx4DTnO9R/ZF9XLJlH4X2mdGm5O2Z0UZbs1JEqbnJ
         rauxmE63baxHMGvy6VcDZKUv4cSOrMxiGA3OPtTHqra83Op+u7/nUcxWdVLL2Euj7MOD
         JEnvvxpBFYsJnskvzM2nHj45OykyMxNye48qYHqFaKgU2TEDIuEocMyxgM2oAvXPu2Hl
         rpIA==
X-Gm-Message-State: AOPr4FW1hy2ndK+f7QUGdDe0c6d9iTBrJJnsm0Da4Xb90OFr66Y6pgQcwMx7y858MwzANw==
X-Received: by 10.66.79.197 with SMTP id l5mr2864574pax.61.1462277179713;
        Tue, 03 May 2016 05:06:19 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id u2sm5509000pfi.26.2016.05.03.05.06.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 May 2016 05:06:18 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 03 May 2016 19:06:15 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462277054-5943-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293354>

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

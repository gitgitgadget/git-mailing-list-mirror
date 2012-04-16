From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH i18n 01/11] Add three convenient format printing functions with \n automatically appended
Date: Mon, 16 Apr 2012 19:49:53 +0700
Message-ID: <1334580603-11577-2-git-send-email-pclouds@gmail.com>
References: <1334580603-11577-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 16 14:51:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJlOi-0006Pt-Ch
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 14:51:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753840Ab2DPMvH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 08:51:07 -0400
Received: from mail-pz0-f52.google.com ([209.85.210.52]:33059 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753774Ab2DPMvG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 08:51:06 -0400
Received: by dake40 with SMTP id e40so6880805dak.11
        for <git@vger.kernel.org>; Mon, 16 Apr 2012 05:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=hWc72447j/urTmu8KtCDiy5mjjMg08sVg9V/6o8wufI=;
        b=vxdk1Vof95AmPET49zGfRCUS1oQkkKQ6SWFpZMAIxOTAs/VApNrbFYNbe4HsfnsKrz
         QVxPW2LPMa3As07UCPfhbvF+j78bw6B6ffkgchFxckuXxTw1C074M+g+p8nOuiwqlZZx
         TH79Mo7K4wQK7U4pd1PfB/aNhEvMzih6CUqoJ23RIxITWdrulun/fu8iLUM5X4jKTViG
         QXp7/2mfmMHa5ZaLn5uztqUZ5+9sLLbWfPmEz0x1I2NKyWHmp3ec+jp1BdOXX1O3Yj0e
         HzmOfC70Vi3CyDWu7l+SevwUmuH1eS0t9vWNfJ/xi0bX1hiNIXxN+567yNnbwBaS4XjS
         3v1g==
Received: by 10.68.238.231 with SMTP id vn7mr27586642pbc.95.1334580665676;
        Mon, 16 Apr 2012 05:51:05 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id k9sm17622616pbf.65.2012.04.16.05.51.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 16 Apr 2012 05:51:04 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 16 Apr 2012 19:50:14 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1334580603-11577-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195624>

These functions are helpful when we do not want to expose \n to
translators. For example

    printf("hello world\n");

can be converted to

    printf_ln(_("hello world"));
---
 strbuf.c |   33 +++++++++++++++++++++++++++++++++
 strbuf.h |    7 +++++++
 2 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index 5135d59..9fbc75c 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -464,3 +464,36 @@ void strbuf_addstr_urlencode(struct strbuf *sb, const char *s,
 {
 	strbuf_add_urlencode(sb, s, strlen(s), reserved);
 }
+
+void strbuf_addf_ln(struct strbuf *sb, const char *fmt, ...)
+{
+	va_list ap;
+	va_start(ap, fmt);
+	strbuf_vaddf(sb, fmt, ap);
+	va_end(ap);
+	strbuf_addch(sb, '\n');
+}
+
+int printf_ln(const char *fmt, ...)
+{
+	int ret;
+	va_list ap;
+	va_start(ap, fmt);
+	ret = vprintf(fmt, ap);
+	va_end(ap);
+	if (ret >= 0)
+		ret += printf("\n");
+	return ret;
+}
+
+int fprintf_ln(FILE *fp, const char *fmt, ...)
+{
+	int ret;
+	va_list ap;
+	va_start(ap, fmt);
+	ret = vfprintf(fp, fmt, ap);
+	va_end(ap);
+	if (ret >= 0)
+		ret += fprintf(fp, "\n");
+	return ret;
+}
diff --git a/strbuf.h b/strbuf.h
index 3effaa8..b888d40 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -99,6 +99,8 @@ __attribute__((format (printf,2,3)))
 extern void strbuf_addf(struct strbuf *sb, const char *fmt, ...);
 __attribute__((format (printf,2,0)))
 extern void strbuf_vaddf(struct strbuf *sb, const char *fmt, va_list ap);
+__attribute__((format (printf,2,3)))
+extern void strbuf_addf_ln(struct strbuf *sb, const char *fmt, ...);
 
 extern void strbuf_add_lines(struct strbuf *sb, const char *prefix, const char *buf, size_t size);
 
@@ -129,4 +131,9 @@ extern void strbuf_add_urlencode(struct strbuf *, const char *, size_t,
 extern void strbuf_addstr_urlencode(struct strbuf *, const char *,
 				    int reserved);
 
+__attribute__((format (printf,1,2)))
+extern int printf_ln(const char *fmt, ...);
+__attribute__((format (printf,2,3)))
+extern int fprintf_ln(FILE *fp, const char *fmt, ...);
+
 #endif /* STRBUF_H */
-- 
1.7.3.1.256.g2539c.dirty

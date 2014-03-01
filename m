From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 19/27] wrapper.c: wrapper to open a file, fprintf then close
Date: Sat,  1 Mar 2014 19:12:55 +0700
Message-ID: <1393675983-3232-20-git-send-email-pclouds@gmail.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
 <1393675983-3232-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 01 13:22:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJiwN-0002SK-Sm
	for gcvg-git-2@plane.gmane.org; Sat, 01 Mar 2014 13:22:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752882AbaCAMWr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Mar 2014 07:22:47 -0500
Received: from mail-pb0-f54.google.com ([209.85.160.54]:53038 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752875AbaCAMWq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2014 07:22:46 -0500
Received: by mail-pb0-f54.google.com with SMTP id ma3so1791297pbc.27
        for <git@vger.kernel.org>; Sat, 01 Mar 2014 04:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=nlIjjSQYqP4Zoui/G4l+w9XAlKB5korZ2gEhlUH8nuE=;
        b=V6cbDZoaOy/A12WH3L/DKvzwb8J/y6I57vhXG3pTFiH6gs5JskkxoHbUFGBjKXrl4k
         aokvRPhDvy0JE/c1a7yEt9efBISpSiRwLgta35SUj/5+Lx3FPj9rqAeKAqFqux0Hsor9
         qS9DQR9QMkTeO2NVzMKtXpa6wX+r4QrA5DhvdmS/ZYUcH+7m7NDhVx81ntHDNcG/TcQG
         VD2lnAC2x/qi8LCbbLL6GBLYRe19Mdmf4lp8RTxWbxTpHhzdDFYPKsawDya0IiS7wT2+
         Eu15QmAbP++TyEu3mZ92/uSnAAk8dVtHYe8jWyJZOoAp8mKbUMjyQ87mqNT/giWtKO8e
         zLow==
X-Received: by 10.66.251.42 with SMTP id zh10mr9452097pac.84.1393676566327;
        Sat, 01 Mar 2014 04:22:46 -0800 (PST)
Received: from lanh ([115.73.238.45])
        by mx.google.com with ESMTPSA id qw8sm15905432pbb.27.2014.03.01.04.22.43
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 01 Mar 2014 04:22:45 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 01 Mar 2014 19:23:11 +0700
X-Mailer: git-send-email 1.9.0.40.gaa8c3ea
In-Reply-To: <1393675983-3232-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243084>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h   |  2 ++
 wrapper.c | 31 +++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/cache.h b/cache.h
index 98b5dd3..99b86d9 100644
--- a/cache.h
+++ b/cache.h
@@ -1239,6 +1239,8 @@ static inline ssize_t write_str_in_full(int fd, c=
onst char *str)
 {
 	return write_in_full(fd, str, strlen(str));
 }
+__attribute__((format (printf,3,4)))
+extern int write_file(const char *path, int fatal, const char *fmt, ..=
=2E);
=20
 /* pager.c */
 extern void setup_pager(void);
diff --git a/wrapper.c b/wrapper.c
index 0cc5636..5ced50d 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -455,3 +455,34 @@ struct passwd *xgetpwuid_self(void)
 		    errno ? strerror(errno) : _("no such user"));
 	return pw;
 }
+
+int write_file(const char *path, int fatal, const char *fmt, ...)
+{
+	struct strbuf sb =3D STRBUF_INIT;
+	int fd =3D open(path, O_RDWR | O_CREAT | O_TRUNC, 0666);
+	va_list params;
+	if (fd < 0) {
+		if (fatal)
+			die_errno(_("could not open %s for writing"), path);
+		return -1;
+	}
+	va_start(params, fmt);
+	strbuf_vaddf(&sb, fmt, params);
+	va_end(params);
+	if (write_in_full(fd, sb.buf, sb.len) !=3D sb.len) {
+		int err =3D errno;
+		close(fd);
+		errno =3D err;
+		strbuf_release(&sb);
+		if (fatal)
+			die_errno(_("could not write to %s"), path);
+		return -1;
+	}
+	strbuf_release(&sb);
+	if (close(fd)) {
+		if (fatal)
+			die_errno(_("could not close %s"), path);
+		return -1;
+	}
+	return 0;
+}
--=20
1.9.0.40.gaa8c3ea

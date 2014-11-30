From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 20/34] wrapper.c: wrapper to open a file, fprintf then close
Date: Sun, 30 Nov 2014 15:24:45 +0700
Message-ID: <1417335899-27307-21-git-send-email-pclouds@gmail.com>
References: <1417335899-27307-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 30 09:29:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XuzsK-0008VN-2Q
	for gcvg-git-2@plane.gmane.org; Sun, 30 Nov 2014 09:29:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752109AbaK3I24 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Nov 2014 03:28:56 -0500
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35987 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751910AbaK3I2z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2014 03:28:55 -0500
Received: by mail-pa0-f45.google.com with SMTP id lj1so9145425pab.32
        for <git@vger.kernel.org>; Sun, 30 Nov 2014 00:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=3bSqJWXeiaoa8X4OSnDh+JXVUJeRWDucsWouYcu13Vg=;
        b=lK84sPwdP5Vi5ZIPxdHsRUVZeaTRfZMAOW9EXS8Rpak+2VZy5VFdkNnE/n2vdNegud
         RLmJnQ3EnTVjmp0Gf+wQYxXZGSR6ReIJGN4SlEz2G0/Ug/R5ig5b34MtrwqaI4kxJ5Hi
         ulAMMeGkItpxnXfKeshC1mLXwUzcyG9NxuG+huTySNEfAOKtVgz4XTM32fR2Kx/TFaXs
         SvB2MWnt1OwyV+53FUq7BnyzinAduKsR6lytGcAmt23t29i/YdVYsp8EycdiHcA4ACY1
         uFOSYrQ0/WAtbVWQDgysBj87IpaHdWPmELyMekdKNB+Illz8qO9PfNSpfvZobIf8JLyd
         px2g==
X-Received: by 10.66.145.42 with SMTP id sr10mr87331177pab.73.1417336135360;
        Sun, 30 Nov 2014 00:28:55 -0800 (PST)
Received: from lanh ([115.73.247.22])
        by mx.google.com with ESMTPSA id ms4sm3253228pbc.92.2014.11.30.00.28.51
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Nov 2014 00:28:54 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 30 Nov 2014 15:28:53 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1417335899-27307-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260407>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h   |  2 ++
 wrapper.c | 31 +++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/cache.h b/cache.h
index 9dc6ae0..f8e75a1 100644
--- a/cache.h
+++ b/cache.h
@@ -1499,6 +1499,8 @@ static inline ssize_t write_str_in_full(int fd, c=
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
index 007ec0d..a2dff8e 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -550,3 +550,34 @@ char *xgetcwd(void)
 		die_errno(_("unable to get current working directory"));
 	return strbuf_detach(&sb, NULL);
 }
+
+int write_file(const char *path, int fatal, const char *fmt, ...)
+{
+	struct strbuf sb =3D STRBUF_INIT;
+	va_list params;
+	int fd =3D open(path, O_RDWR | O_CREAT | O_TRUNC, 0666);
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
+		strbuf_release(&sb);
+		errno =3D err;
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
2.1.0.rc0.78.gc0d8480

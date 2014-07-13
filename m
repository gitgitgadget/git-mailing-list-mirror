From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v7 20/31] wrapper.c: wrapper to open a file, fprintf then close
Date: Sun, 13 Jul 2014 11:50:57 +0700
Message-ID: <1405227068-25506-21-git-send-email-pclouds@gmail.com>
References: <1404891197-18067-1-git-send-email-pclouds@gmail.com>
 <1405227068-25506-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Max Kirillov <max@max630.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 13 06:55:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6BoT-0000vQ-JW
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jul 2014 06:55:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752924AbaGMEy6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jul 2014 00:54:58 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:41232 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752911AbaGMEy5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2014 00:54:57 -0400
Received: by mail-pa0-f54.google.com with SMTP id fa1so174424pad.13
        for <git@vger.kernel.org>; Sat, 12 Jul 2014 21:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=UcAyMgLnM6NHq12ee9jPu5m/Q393ZCVOB2nnAVE1qEU=;
        b=km9vzURG5nn+Ty/UxFAeEmCiusJfrAFKm6I2vL3H6Ct+lOuQkznUWc2zTUYSnkYfaH
         DCBtr2V11zpXFL0w2w5/1LK6JozKMr7/0I4x3SBUuLpIWF7pJwT5F43/WODraY6daGog
         dsnxXwcjSYFEZnbTllOJkqoj4yTmMP5BdNVyRM/OD3h4dRo6zgIrcGjEMGwan1S78WC2
         52LOkTZHK0tsR5MsS+CkH7LKWa0YmaoNE5JlhFQ8o4rnUkhVUXlW1bbr69BBxr9paFtn
         4VOqs4awPEHGZ8sGEe+0Mcw8TeeWjfqbt6H5jtD3g9jkpM4xhUFeR1L+Ifz1tzdPSCw+
         GnQA==
X-Received: by 10.66.255.38 with SMTP id an6mr8743764pad.43.1405227296622;
        Sat, 12 Jul 2014 21:54:56 -0700 (PDT)
Received: from lanh ([115.73.227.1])
        by mx.google.com with ESMTPSA id zf9sm29024812pab.5.2014.07.12.21.54.53
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jul 2014 21:54:56 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 13 Jul 2014 11:54:56 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1405227068-25506-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253423>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h   |  2 ++
 wrapper.c | 31 +++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/cache.h b/cache.h
index e3ff7dc..bf4d15e 100644
--- a/cache.h
+++ b/cache.h
@@ -1359,6 +1359,8 @@ static inline ssize_t write_str_in_full(int fd, c=
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
index bc1bfb8..9d7b9ac 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -493,3 +493,34 @@ struct passwd *xgetpwuid_self(void)
 		    errno ? strerror(errno) : _("no such user"));
 	return pw;
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
1.9.1.346.ga2b5940

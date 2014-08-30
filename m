From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 20/32] wrapper.c: wrapper to open a file, fprintf then close
Date: Sat, 30 Aug 2014 15:33:50 +0700
Message-ID: <1409387642-24492-21-git-send-email-pclouds@gmail.com>
References: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 30 10:35:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNe8d-0002n1-BX
	for gcvg-git-2@plane.gmane.org; Sat, 30 Aug 2014 10:35:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbaH3Ift convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Aug 2014 04:35:49 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:42570 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751327AbaH3Ifo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2014 04:35:44 -0400
Received: by mail-pd0-f172.google.com with SMTP id z10so2023139pdj.17
        for <git@vger.kernel.org>; Sat, 30 Aug 2014 01:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ipDRqBwW+94ElqC7bq0epnIwuTT3T0iuA0nu5HV0pAg=;
        b=gQmKM64vXq0B21KlhdG7konZ6dIImj1cBggpVac+3cOo88GmhUVKhSCsHfvpMDzvSv
         0/XRP+lLgTs4w98SyhPZIEj/N59jhkzEzDxitTF4PoT1tqQdfapDgKT7Zu4NxN9RkAcD
         joQs3xx3r+r2wlCcwuR9c3JWAZz5vbaOQ/pv39y6K9Q+o1iswnEjptcOCoPzAj12W03T
         Hij9tk6QiUxUnytnyfFk6T2QJPKbBX9v6NwXxhc90Oiz/+3+UQKXpVusnmOJ1HZDdWeb
         gUjRgoLtpf1wQ0/NuUjr1uicEHAEJatCgDj/ynA+bzxn/UqdPlCxcXkGx3rIohyOILAc
         E7/A==
X-Received: by 10.68.225.133 with SMTP id rk5mr21839338pbc.101.1409387741738;
        Sat, 30 Aug 2014 01:35:41 -0700 (PDT)
Received: from lanh ([115.73.195.142])
        by mx.google.com with ESMTPSA id dq9sm3147581pdb.70.2014.08.30.01.35.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Aug 2014 01:35:41 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 30 Aug 2014 15:35:51 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256230>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
2.1.0.rc0.78.gc0d8480

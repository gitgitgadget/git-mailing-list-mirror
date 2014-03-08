From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v5 20/28] wrapper.c: wrapper to open a file, fprintf then close
Date: Sat,  8 Mar 2014 09:48:12 +0700
Message-ID: <1394246900-31535-21-git-send-email-pclouds@gmail.com>
References: <1393675983-3232-1-git-send-email-pclouds@gmail.com>
 <1394246900-31535-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 08 03:50:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WM7Kq-0005rT-Id
	for gcvg-git-2@plane.gmane.org; Sat, 08 Mar 2014 03:50:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753524AbaCHCt4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Mar 2014 21:49:56 -0500
Received: from mail-pb0-f52.google.com ([209.85.160.52]:49009 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752305AbaCHCtz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2014 21:49:55 -0500
Received: by mail-pb0-f52.google.com with SMTP id rr13so4985340pbb.11
        for <git@vger.kernel.org>; Fri, 07 Mar 2014 18:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Egx+t8UaAGrvtXFP1z5zkbiKuQ3jTrmF2Qoa6TthrJQ=;
        b=q/xfMSq4yroUSW3NB9DUce9xuACrMtbZ5NdDc8Zpw8S/KqR0NkAqW+sZIq9zgtDsoa
         oQ5U4I4U1VqSN0aF6F2/bK1P+9OEElqkLyZzSHgAAVkEoPfGKos8b5TPNF46aaBT5EbH
         OiS4DKgvSvyLUnCOgC5gEjdgkJ9FODghCAaW15PA42nHJk3Js15mI5ksqZqvxJ+0n4hv
         eZi6geunKpmLC11M081tWJcBr7d0vJ5G0fXPquYT3EpztHtYfPzVn1NgaeCPdEEdAmml
         QAgmI7bJ0yPTpTJVpFBDoQPMXVcglparZeIwPyC7Mg0ESMDcljMLYMhU60N/KNFydyF6
         Rh1A==
X-Received: by 10.68.35.129 with SMTP id h1mr26005562pbj.163.1394246994879;
        Fri, 07 Mar 2014 18:49:54 -0800 (PST)
Received: from lanh ([115.73.205.153])
        by mx.google.com with ESMTPSA id pe3sm42033819pbc.23.2014.03.07.18.49.51
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 07 Mar 2014 18:49:54 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 08 Mar 2014 09:50:28 +0700
X-Mailer: git-send-email 1.9.0.40.gaa8c3ea
In-Reply-To: <1394246900-31535-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243661>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h   |  2 ++
 wrapper.c | 31 +++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/cache.h b/cache.h
index 992e241..979ac6e 100644
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
index 0cc5636..5ad628c 100644
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
1.9.0.40.gaa8c3ea

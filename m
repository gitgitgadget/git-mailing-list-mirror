From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v6 22/32] wrapper.c: wrapper to open a file, fprintf then close
Date: Wed,  9 Jul 2014 14:33:07 +0700
Message-ID: <1404891197-18067-23-git-send-email-pclouds@gmail.com>
References: <1404891197-18067-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 09 09:35:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4mPd-00048f-RZ
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 09:35:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754990AbaGIHf2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Jul 2014 03:35:28 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:46477 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754949AbaGIHf0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 03:35:26 -0400
Received: by mail-pa0-f44.google.com with SMTP id rd3so8794534pab.3
        for <git@vger.kernel.org>; Wed, 09 Jul 2014 00:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=MRz+MEI5Tn4jq7gLE2aHpDkVpVcbG4NNjJbRUi1ovtw=;
        b=ijJmoFZaVaTEmMawcF/abRcVdBnAgVEXYYJHcb0Q8RU7GBTXMX2teE3Uhjm+qzwAzo
         1pSr78nDSQk+FsL9vcCZc/X0+scezUFl/DQ+pVtlWfMw0iroYNIWmd+iRJBtpbSJhPRP
         VeD5qgftXYwdoZhDRxYr/H46IWxeBf95a/b+aYmtE/SsrGqHt9+P5HGK2fJvblLq0OAl
         WBg1IdigZsbJtHP3IkN36R+sIUL0v2rr+1wbj2PILK7HLBbbi3B3xQhKMgYpTx9UyHHM
         F5/dSaeFDxnxJlrv9ZROoqPesW9MMgl5MuFSvCs5OFQdnssJpNDW5FovcBemAsWjeKFz
         DHbQ==
X-Received: by 10.68.189.232 with SMTP id gl8mr29729911pbc.89.1404891326127;
        Wed, 09 Jul 2014 00:35:26 -0700 (PDT)
Received: from lanh ([115.73.209.165])
        by mx.google.com with ESMTPSA id b2sm27266613pdh.20.2014.07.09.00.35.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jul 2014 00:35:25 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 09 Jul 2014 14:35:23 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1404891197-18067-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253097>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h   |  2 ++
 wrapper.c | 31 +++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/cache.h b/cache.h
index e7dd5ce..b363c00 100644
--- a/cache.h
+++ b/cache.h
@@ -1355,6 +1355,8 @@ static inline ssize_t write_str_in_full(int fd, c=
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

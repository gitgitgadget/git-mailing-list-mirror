From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 20/32] wrapper.c: wrapper to open a file, fprintf then close
Date: Thu, 11 Sep 2014 05:41:56 +0700
Message-ID: <1410388928-32265-21-git-send-email-pclouds@gmail.com>
References: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
 <1410388928-32265-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 11 00:43:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRqcE-00024L-VA
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 00:43:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753360AbaIJWnv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Sep 2014 18:43:51 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:44589 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752299AbaIJWnu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2014 18:43:50 -0400
Received: by mail-pa0-f50.google.com with SMTP id bj1so6644263pad.9
        for <git@vger.kernel.org>; Wed, 10 Sep 2014 15:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ipDRqBwW+94ElqC7bq0epnIwuTT3T0iuA0nu5HV0pAg=;
        b=xHxoHJwXhD+QPCQ4UXBI9yjRoUTmfFd+rz72IlDjxA6Wb6E45gDjUWmeGVaPXgNVhR
         DFQqW+bNgBWhmXm2Rx4g1FzRTsyItQdDoNARjFzD1Fz+lSgKuCs9+icy+6nH/VOSZ8wH
         nlln72r8co9QsDwCMUv7U9NluFnUHH6pJqYplnBgfqQL838GjBvUUYmuhWyg/kM7bzqe
         R3crL1b0lLAoZ/93qbsglmsgtTXht5JfRqgnXKj9dv/CJX74oytmmUjGkxwFfEKra5nn
         WqxPJ3KFr+9mdhakVsR2QBciEeVBSMayihCtdJBrcQDKAkQkdBf6+bHZr1a/jSL5uuuX
         9c4g==
X-Received: by 10.68.139.232 with SMTP id rb8mr41473747pbb.20.1410389030070;
        Wed, 10 Sep 2014 15:43:50 -0700 (PDT)
Received: from lanh ([115.73.197.210])
        by mx.google.com with ESMTPSA id i1sm15603924pdf.46.2014.09.10.15.43.47
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Sep 2014 15:43:49 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Thu, 11 Sep 2014 05:44:09 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1410388928-32265-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256797>

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

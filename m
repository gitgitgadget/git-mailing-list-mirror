From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 20/32] wrapper.c: wrapper to open a file, fprintf then close
Date: Sun, 28 Sep 2014 08:22:34 +0700
Message-ID: <1411867366-3821-21-git-send-email-pclouds@gmail.com>
References: <xmqqk34r9z3r.fsf@gitster.dls.corp.google.com>
 <1411867366-3821-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 28 03:24:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XY3EB-0002ak-VS
	for gcvg-git-2@plane.gmane.org; Sun, 28 Sep 2014 03:24:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753439AbaI1BYj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Sep 2014 21:24:39 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:61253 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753183AbaI1BYi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Sep 2014 21:24:38 -0400
Received: by mail-pd0-f178.google.com with SMTP id y10so523823pdj.9
        for <git@vger.kernel.org>; Sat, 27 Sep 2014 18:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=sfBlnKgQbz0AAoBO393utMtVK6kXnSptzvXMGq8jHKY=;
        b=BNwy5Vr5Lu9CHtJ5qq/eVA3YZnUg78jz7T4Qh/OyOpWkoCTMvxvwNcnUCobqRbub4Z
         YU5MCg2Sn7Z/InsbXCRERUHEnCmRKDp3UDWgeMK6ibuQwz2CEBM8pmJOKUqwoCHuoQjk
         OwINQ/tmmA5Vfvkr48xbFA8GzH7izrq1PMnHjwdZKh370y3oDpcMbhuI6aWAa6zjTCYv
         PwnDHP2zNIY/LeoDhxbiMdIM8a9rnmMB99YTi8x3cY1HLbg7eR1W8NFX/f34MaCOvDdg
         jQX+5z1TNjwyaw3XL/OtjY2F/k+SpSOufW2xihqKvBTvFhXVR2P6laEgTDj332MPzJAP
         Z9Uw==
X-Received: by 10.66.241.166 with SMTP id wj6mr33260565pac.149.1411867478237;
        Sat, 27 Sep 2014 18:24:38 -0700 (PDT)
Received: from lanh ([115.73.212.224])
        by mx.google.com with ESMTPSA id ix1sm8514988pbc.60.2014.09.27.18.24.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Sep 2014 18:24:37 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 28 Sep 2014 08:24:41 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1411867366-3821-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257579>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h   |  2 ++
 wrapper.c | 31 +++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/cache.h b/cache.h
index 1784fc6..aedfd05 100644
--- a/cache.h
+++ b/cache.h
@@ -1452,6 +1452,8 @@ static inline ssize_t write_str_in_full(int fd, c=
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
index 25074d7..d53a3b3 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -537,3 +537,34 @@ char *xgetcwd(void)
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

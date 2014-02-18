From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 19/25] wrapper.c: wrapper to open a file, fprintf then close
Date: Tue, 18 Feb 2014 20:40:08 +0700
Message-ID: <1392730814-19656-20-git-send-email-pclouds@gmail.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 18 14:42:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFkwi-0000pO-HP
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 14:42:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755252AbaBRNmd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Feb 2014 08:42:33 -0500
Received: from mail-pa0-f42.google.com ([209.85.220.42]:36852 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932086AbaBRNmJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 08:42:09 -0500
Received: by mail-pa0-f42.google.com with SMTP id kl14so16728021pab.15
        for <git@vger.kernel.org>; Tue, 18 Feb 2014 05:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=twqZ3jP4NWPw9TQjmGmPQjAc1OzO61AXs3G7fuV2QjQ=;
        b=kqmpiv6dB1aPxjDZQ/6FQEcRyTNm2rdt2t0R3VvZCdWlVOz4CDTmL8UaveYOpfjilv
         sEZbsULtOp3eEOH8DED3rT1Qc1JbYfPBs/8CiUHIdTATdF7DkfXhBDx1CMDQRKgG1QW6
         ghvcBC4erhUK+agmhcSvD+wX9fQjQQh9QUHx6lvTmbGqsZofV2Knlegg974vO3ajOR2V
         Sc1/Mt8nX60wEXgeQsOwsG9ACltPj3BzD9K6TJLt60YJbfyN2GejLZe3btN6sOzf4Udu
         aeN1nEJ3EEHyINE2GQBQGGo6OiemYPJs66bC81snWaql7qP8LB1QwkyqXSwjMwez+Bd9
         dxLw==
X-Received: by 10.68.125.164 with SMTP id mr4mr32970951pbb.27.1392730928595;
        Tue, 18 Feb 2014 05:42:08 -0800 (PST)
Received: from lanh ([115.73.228.211])
        by mx.google.com with ESMTPSA id hb10sm56116896pbd.1.2014.02.18.05.42.05
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 18 Feb 2014 05:42:08 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 18 Feb 2014 20:42:21 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242320>

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
1.8.5.2.240.g8478abd

From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 22/23] mingw32: add uname()
Date: Mon,  8 Dec 2014 21:05:06 +0700
Message-ID: <1418047507-22892-24-git-send-email-pclouds@gmail.com>
References: <1418047507-22892-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 08 14:56:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xxynr-0005JC-Kt
	for gcvg-git-2@plane.gmane.org; Mon, 08 Dec 2014 14:56:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755546AbaLHN4j convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Dec 2014 08:56:39 -0500
Received: from mail-pa0-f52.google.com ([209.85.220.52]:56807 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751150AbaLHN4i (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2014 08:56:38 -0500
Received: by mail-pa0-f52.google.com with SMTP id eu11so5281304pac.11
        for <git@vger.kernel.org>; Mon, 08 Dec 2014 05:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=FFAb2EKxPLOD85TGQgY1rMa72MfuoLbW6gxFK49pv/k=;
        b=Suyqir4/sD+seKF9jaAej2fwijvrDsMOUNrsoshB4AmO9rY13Gep/o2spZ/3VaB3sV
         Y6Mry6lcZMhw8byS5vnHMsq/F5owR2/UH6kEkufGLHZCiRZK7PFvK0FxD7LZ44N/IWjB
         Cbi0aFZ4laUmY+U0poxu6aG/H6XGUP9g8851csrzBjxxZfRzg8TKjgFfAqg+kufbh8pO
         S6jnWEhzLk/k4oPL+MhGt0X3cUUp5u1RNXfExm8nqGQ9jP710Q2Jt2zXS3iIT/YdhNxp
         wqe8/vhBZFXc2t8D5UXHi/fMeOOa7p5Y36F9dPgmFcKOFB+xwlpD5iheHO5gr4HqQScT
         X+Ug==
X-Received: by 10.66.248.36 with SMTP id yj4mr53994272pac.51.1418046997631;
        Mon, 08 Dec 2014 05:56:37 -0800 (PST)
Received: from lanh ([115.73.205.130])
        by mx.google.com with ESMTPSA id yo1sm14358139pab.27.2014.12.08.05.56.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Dec 2014 05:56:37 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 08 Dec 2014 21:07:13 +0700
X-Mailer: git-send-email 2.2.0.60.gb7b3c64
In-Reply-To: <1418047507-22892-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261040>

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 compat/mingw.c | 11 +++++++++++
 compat/mingw.h |  9 +++++++++
 2 files changed, 20 insertions(+)

diff --git a/compat/mingw.c b/compat/mingw.c
index c5c37e5..88140e4 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -2128,3 +2128,14 @@ void mingw_startup()
 	/* initialize Unicode console */
 	winansi_init();
 }
+
+int uname(struct utsname *buf)
+{
+	DWORD v =3D GetVersion();
+	memset(buf, 0, sizeof(*buf));
+	strcpy(buf->sysname, "Windows");
+	sprintf(buf->release, "%u.%u", v & 0xff, (v >> 8) & 0xff);
+	/* assuming NT variants only.. */
+	sprintf(buf->version, "%u", (v >> 16) & 0x7fff);
+	return 0;
+}
diff --git a/compat/mingw.h b/compat/mingw.h
index df0e320..d00ba7a 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -77,6 +77,14 @@ struct itimerval {
 };
 #define ITIMER_REAL 0
=20
+struct utsname {
+	char sysname[16];
+	char nodename[1];
+	char release[16];
+	char version[16];
+	char machine[1];
+};
+
 /*
  * sanitize preprocessor namespace polluted by Windows headers definin=
g
  * macros which collide with git local versions
@@ -166,6 +174,7 @@ struct passwd *getpwuid(uid_t uid);
 int setitimer(int type, struct itimerval *in, struct itimerval *out);
 int sigaction(int sig, struct sigaction *in, struct sigaction *out);
 int link(const char *oldpath, const char *newpath);
+int uname(struct utsname *buf);
=20
 /*
  * replacements of existing functions
--=20
2.2.0.60.gb7b3c64

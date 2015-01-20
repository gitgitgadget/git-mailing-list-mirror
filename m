From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 22/24] mingw32: add uname()
Date: Tue, 20 Jan 2015 20:03:31 +0700
Message-ID: <1421759013-8494-23-git-send-email-pclouds@gmail.com>
References: <1421759013-8494-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 20 14:06:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDYVU-00048q-47
	for gcvg-git-2@plane.gmane.org; Tue, 20 Jan 2015 14:06:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755171AbbATNGD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Jan 2015 08:06:03 -0500
Received: from mail-pa0-f44.google.com ([209.85.220.44]:42384 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754832AbbATNGB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2015 08:06:01 -0500
Received: by mail-pa0-f44.google.com with SMTP id et14so45581220pad.3
        for <git@vger.kernel.org>; Tue, 20 Jan 2015 05:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=2ezOXqjRH/9w3vNjEULztVwZmg3AO8ICsjaLOaB5NZA=;
        b=Ey9eekyfCor1kNyFpohXbcRwOH/Ele9lNhbjdqVAmpk5jlhIXTct/RaGyGBrN4eSQo
         Q5v0lO5u9MY/fUPF6/rJ4xYB9oJaN3/A1ZSk8PC+QLnmc7cV19jidxVeCRxPkJHwjhMA
         iSJj/u18+39CjButDYCuONYSx7jeBvI9C1lgIizGvb08ixwbk71o/vH71AuPSBGifjBA
         t+Jh8sgRKkMFS6nP6OrzNgKEhaJbKdGWk4IPZM/0com+ivFxn51n1e/whHbTB7f/plN4
         Sza1SnqOw6Zyqya0SMdb7T8lgcVgC17O9GfrxEUPsak3NkcBv31DUIS/kCBujwVZX4r6
         vkKw==
X-Received: by 10.68.141.204 with SMTP id rq12mr52662071pbb.7.1421759160754;
        Tue, 20 Jan 2015 05:06:00 -0800 (PST)
Received: from lanh ([115.73.212.1])
        by mx.google.com with ESMTPSA id wt4sm3282492pab.4.2015.01.20.05.05.57
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jan 2015 05:05:59 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 20 Jan 2015 20:06:10 +0700
X-Mailer: git-send-email 2.2.0.84.ge9c7a8a
In-Reply-To: <1421759013-8494-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262674>

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
2.2.0.84.ge9c7a8a

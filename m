From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 21/22] mingw32: add uname()
Date: Sat,  8 Nov 2014 16:39:54 +0700
Message-ID: <1415439595-469-22-git-send-email-pclouds@gmail.com>
References: <1414411846-4450-1-git-send-email-pclouds@gmail.com>
 <1415439595-469-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 08 10:41:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xn2Wg-0001vX-Ty
	for gcvg-git-2@plane.gmane.org; Sat, 08 Nov 2014 10:41:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753711AbaKHJli convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Nov 2014 04:41:38 -0500
Received: from mail-pd0-f180.google.com ([209.85.192.180]:37669 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753707AbaKHJlh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Nov 2014 04:41:37 -0500
Received: by mail-pd0-f180.google.com with SMTP id ft15so4786285pdb.39
        for <git@vger.kernel.org>; Sat, 08 Nov 2014 01:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=09cRFCrSHiN3pnSjGCtTC65O2d4lcLgoyb42k0UG1Ks=;
        b=cLt4AF3kHYccOaC6Mz4nedaBzdm9z/7Ti+Uz1Ln2l8SO8RE2SPXCeMXvUcSmnHEKJZ
         JBLDIIQwNuLtCu684imWxXAEJxYXrvmHOEJoChhlJ10CXhD6IV+NFphzllh0XTWYicBa
         V7+IWsS2SjIDepwVdS3+C3Of6eBE36NsOmLXGOqRA6fpfx3W0QHVLgQrmeykFtbtadT5
         67VljL97kxgZvzZA/XQPn7RdILy6JPg0htJbOoDrHuO1nB+0yiUCThTXFB77J7+A3RTC
         pEn00BvIfuEG+VMHTb+OW68xwNR9s4tJKsvGxENwMTsMxbwMN4jbcjt1JS1WjKVpmbln
         efTQ==
X-Received: by 10.68.216.70 with SMTP id oo6mr18371794pbc.124.1415439696994;
        Sat, 08 Nov 2014 01:41:36 -0800 (PST)
Received: from lanh ([115.73.197.54])
        by mx.google.com with ESMTPSA id m5sm11049108pdi.24.2014.11.08.01.41.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Nov 2014 01:41:36 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 08 Nov 2014 16:41:51 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1415439595-469-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 compat/mingw.c | 11 +++++++++++
 compat/mingw.h |  9 +++++++++
 2 files changed, 20 insertions(+)

diff --git a/compat/mingw.c b/compat/mingw.c
index c5c37e5..b817678 100644
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
+	sprintf(buf->sysname, "Windows");
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
2.1.0.rc0.78.gc0d8480

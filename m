From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 22/24] mingw32: add uname()
Date: Sun,  8 Feb 2015 15:55:46 +0700
Message-ID: <1423385748-19825-23-git-send-email-pclouds@gmail.com>
References: <1423385748-19825-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 08 09:58:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKNgm-0003UE-RG
	for gcvg-git-2@plane.gmane.org; Sun, 08 Feb 2015 09:58:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755221AbbBHI54 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Feb 2015 03:57:56 -0500
Received: from mail-pa0-f44.google.com ([209.85.220.44]:52036 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755188AbbBHI5z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2015 03:57:55 -0500
Received: by mail-pa0-f44.google.com with SMTP id rd3so26980715pab.3
        for <git@vger.kernel.org>; Sun, 08 Feb 2015 00:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=B6vu+n73QIPBvOWyLvceEdvVTvXq3aL0no1u3cU65UQ=;
        b=Ct3UOGmWK+V1VoqmpAxm5ShdT5B+KJ3l3kAHuHkPcOHzbJBbDy4iWNR2E0kqxcQuq4
         XgnvP6CRDlOGKJ+hWpR5+ZfLo9dIwcoSdl2Fb/bHwb6n0/y6VexSOh3Z/4nad+q7eNtL
         QxHR7iHPmQTWRoLxW/IJEWPSBgaucuoW47rYeQS2KKVfV0wm5uQ+QYHgu6jUXqUzCGvf
         K7hdt9g534SXTQ4y/mn8iBVJf/DecXht0U2PsxosxcgzjCtHczXwml1BY8nGAaaOVtXU
         WWfe22xhZONyLhVk6hWXCvqw1pu4/ULnwaRQsrY53OQMVapxpigB58UsgtnQl3FJp275
         Moew==
X-Received: by 10.66.193.33 with SMTP id hl1mr19221288pac.141.1423385875360;
        Sun, 08 Feb 2015 00:57:55 -0800 (PST)
Received: from lanh ([115.73.243.52])
        by mx.google.com with ESMTPSA id fo8sm12932289pdb.74.2015.02.08.00.57.52
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Feb 2015 00:57:54 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 Feb 2015 15:58:02 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1423385748-19825-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263484>

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
2.3.0.rc1.137.g477eb31

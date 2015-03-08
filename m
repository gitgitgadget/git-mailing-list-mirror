From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 22/24] mingw32: add uname()
Date: Sun,  8 Mar 2015 17:12:45 +0700
Message-ID: <1425809567-25518-23-git-send-email-pclouds@gmail.com>
References: <1425809567-25518-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 08 11:15:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUYEz-0004Zs-1Q
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 11:15:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbbCHKPQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Mar 2015 06:15:16 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:41767 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751940AbbCHKPO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2015 06:15:14 -0400
Received: by pablj1 with SMTP id lj1so58496232pab.8
        for <git@vger.kernel.org>; Sun, 08 Mar 2015 03:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=B6vu+n73QIPBvOWyLvceEdvVTvXq3aL0no1u3cU65UQ=;
        b=zsCg9kN9wdYOGcNB5VBa4RZUPuI2n0ilmF05DKUkNu954t2eNV/a6uHg8G0kfqgpto
         Fi6Ye2mmTc3KLLfFNhRBXkyzo5sCsWJdthJgdvUSAGf7VQeVxrnRHzkrks3jImQg+oFS
         eFjoCGHhNwI21SknfMrORrYrvZM7rYB7fG3Vt2rdRNjYG9wSjOz8NMOZsjhq8OiJ3iBk
         HR+vJUXnFwJPFs+IB+UA0hu5rO5GbFAZWbzfN228MT8ZSZSYmMDajkAlilNZNshOP4Cy
         1Co3KcfYjMMMUw/ClCDcJm2i8w0F1weuOiOD50ObD6LrH24+qLHLBQgCdF7A/aIv14A4
         B91A==
X-Received: by 10.70.61.161 with SMTP id q1mr5143177pdr.33.1425809713390;
        Sun, 08 Mar 2015 03:15:13 -0700 (PDT)
Received: from lanh ([115.73.247.162])
        by mx.google.com with ESMTPSA id pm9sm1307560pdb.59.2015.03.08.03.15.10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Mar 2015 03:15:12 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 Mar 2015 17:15:09 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1425809567-25518-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265077>

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

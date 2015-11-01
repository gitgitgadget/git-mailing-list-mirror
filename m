From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/5] read-cache: allow index-helper to prepare shm before git reads it
Date: Sun,  1 Nov 2015 14:55:44 +0100
Message-ID: <1446386146-10438-4-git-send-email-pclouds@gmail.com>
References: <1446386146-10438-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <christian.couder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 01 14:56:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zst7M-0002MO-Eq
	for gcvg-git-2@plane.gmane.org; Sun, 01 Nov 2015 14:56:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752768AbbKAN4N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Nov 2015 08:56:13 -0500
Received: from mail-wi0-f169.google.com ([209.85.212.169]:34155 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752499AbbKAN4I (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2015 08:56:08 -0500
Received: by wikq8 with SMTP id q8so36600707wik.1
        for <git@vger.kernel.org>; Sun, 01 Nov 2015 05:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=9lkYCsKXu9uV8eRRWX/Hw7LUnkm4Vk1INdp0dpX09kw=;
        b=APjPKDBHWv67yyuCiaWtXJQbAqLQpFUyg2GcpnUTm37iNrGJa4gfRRVP28KCIunkCZ
         8EG3rpic8C5hhGLBSLhtTZk3UwkvFOJ5O4vAhbfD2Ny6IGIlPJD7EKXIViaSZ1snUuM1
         gdi1I7QwIy3sbRUMZ+z6YME/UgW9fbL7R5rzFvGwCR10xi3SYJPSAkueenyzQ2cE1Qp8
         82wFngPJ9KZ7+DNmr3EY5YNXYH0V0Rc04hWJVQv5W5YTjjm2XsMhzzdR0sh6tKgW3iGo
         uI8u/SG45RZ0Cl87IZV5drDOh4XfuaeZVzOrVv0arv5igR9jxR1JWM+laQ+ab7V233W3
         apWA==
X-Received: by 10.194.92.138 with SMTP id cm10mr18286443wjb.6.1446386167235;
        Sun, 01 Nov 2015 05:56:07 -0800 (PST)
Received: from duynguyen-vnpc.dek-tpc.internal.homenet.telecomitalia.it (host171-164-static.60-79-b.business.telecomitalia.it. [79.60.164.171])
        by smtp.gmail.com with ESMTPSA id bk2sm17185525wjc.3.2015.11.01.05.56.05
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 01 Nov 2015 05:56:06 -0800 (PST)
X-Mailer: git-send-email 2.2.0.513.g477eb31
In-Reply-To: <1446386146-10438-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280631>

If index-helper puts 'W' before pid in $GIT_DIR/index-helper.pid, then
git will sleep for a while, expecting to be waken up by SIGUSR1 when
index-helper has done shm preparation, or after the timeout.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 read-cache.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 893223e..ae33951 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1591,14 +1591,24 @@ static void do_poke(struct strbuf *sb, int refr=
esh_cache)
 	PostMessage(hwnd, refresh_cache ? WM_USER : WM_USER + 1, 0, 0);
 }
 #else
+static void do_nothing(int sig)
+{
+}
+
 static void do_poke(struct strbuf *sb, int refresh_cache)
 {
-	char	*start =3D sb->buf;
+	int	 wait  =3D sb->buf[0] =3D=3D 'W';
+	char	*start =3D wait ? sb->buf + 1 : sb->buf;
 	char	*end   =3D NULL;
 	pid_t	 pid   =3D strtoul(start, &end, 10);
+	int	 ret;
 	if (!end || end !=3D sb->buf + sb->len)
 		return;
-	kill(pid, refresh_cache ? SIGHUP : SIGUSR1);
+	ret =3D kill(pid, refresh_cache ? SIGHUP : SIGUSR1);
+	if (!refresh_cache && !ret && wait) {
+		signal(SIGHUP, do_nothing);
+		sleep(1);
+	}
 }
 #endif
=20
--=20
2.2.0.513.g477eb31

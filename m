From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 16/26] git-compat-util.h: add inotify stubs on non-Linux platforms
Date: Mon,  3 Feb 2014 11:29:04 +0700
Message-ID: <1391401754-15347-17-git-send-email-pclouds@gmail.com>
References: <1389952060-12297-1-git-send-email-pclouds@gmail.com>
 <1391401754-15347-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 03 05:30:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WABBQ-0001Ky-AP
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 05:30:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752932AbaBCEav convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Feb 2014 23:30:51 -0500
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34671 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752929AbaBCEau (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Feb 2014 23:30:50 -0500
Received: by mail-pa0-f42.google.com with SMTP id kl14so6659269pab.1
        for <git@vger.kernel.org>; Sun, 02 Feb 2014 20:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=scGkko/FkZi/KjfymVKzKJ6Sn1j8w0wxEnhqSa4CTxA=;
        b=cmxP8rPpdltosCsWl8rUUnxGkT3+KlQRYMsU+3SrQ/ZrqiS/ta/Lbifzp8jjVX81cv
         twQJLUvsaWyxlx/1587L170eIfzvRuDpqFnj77zIzQwoKsaqfFuRXj+ZrjbhrDbsxSCN
         8az7M4YwovOzUrK0AolJUWCivaMNjlEf+GStMHHJG0a71KkZ6K90bLzajX0+dDezwDUf
         KhRtsW4S+pQreW0iv/cZCvWDZW3Vv8/5AjXU9avJXAsdLtn/DdAxwM85rT1DkkRSmxmX
         UnHrQi3vtcTK1TeauWgKaVcdS58do5A3BWD6N3illKBWRP6x7pI24LE4D099lC2fS8A+
         v3PQ==
X-Received: by 10.68.197.234 with SMTP id ix10mr34731918pbc.80.1391401850617;
        Sun, 02 Feb 2014 20:30:50 -0800 (PST)
Received: from lanh ([115.73.226.68])
        by mx.google.com with ESMTPSA id xv2sm51413914pbb.39.2014.02.02.20.30.47
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 02 Feb 2014 20:30:49 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 03 Feb 2014 11:30:48 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1391401754-15347-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241411>

This is to avoid spreading #ifdef HAVE_INOTIFY around and keep most
code compiled even if it's never active.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 config.mak.uname  |  1 +
 git-compat-util.h | 43 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/config.mak.uname b/config.mak.uname
index 7d31fad..ee548f5 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -33,6 +33,7 @@ ifeq ($(uname_S),Linux)
 	HAVE_PATHS_H =3D YesPlease
 	LIBC_CONTAINS_LIBINTL =3D YesPlease
 	HAVE_DEV_TTY =3D YesPlease
+	BASIC_CFLAGS +=3D -DHAVE_INOTIFY
 endif
 ifeq ($(uname_S),GNU/kFreeBSD)
 	NO_STRLCPY =3D YesPlease
diff --git a/git-compat-util.h b/git-compat-util.h
index cbd86c3..8b55dd0 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -128,6 +128,9 @@
 #else
 #include <poll.h>
 #endif
+#ifdef HAVE_INOTIFY
+#include <sys/inotify.h>
+#endif
=20
 #if defined(__MINGW32__)
 /* pull in Windows compatibility stuff */
@@ -721,4 +724,44 @@ void warn_on_inaccessible(const char *path);
 /* Get the passwd entry for the UID of the current process. */
 struct passwd *xgetpwuid_self(void);
=20
+#ifndef HAVE_INOTIFY
+/* Keep inotify-specific code build, even if it's not used */
+
+#define IN_DELETE_SELF	1
+#define IN_MOVE_SELF	2
+#define IN_ATTRIB	4
+#define IN_DELETE	8
+#define IN_MODIFY	16
+#define IN_MOVED_FROM	32
+#define IN_MOVED_TO	64
+#define IN_Q_OVERFLOW	128
+#define IN_UNMOUNT	256
+#define IN_CREATE	512
+#define IN_ISDIR	1024
+#define IN_IGNORED	2048
+
+struct inotify_event {
+	int event, mask, wd, len;
+	char name[FLEX_ARRAY];
+};
+
+static inline int inotify_init()
+{
+	errno =3D ENOSYS;
+	return -1;
+}
+
+static inline int inotify_add_watch(int fd, const char *path, int opti=
ons)
+{
+	errno =3D ENOSYS;
+	return -1;
+}
+
+static inline int inotify_rm_watch(int fd, int wd)
+{
+	errno =3D ENOSYS;
+	return -1;
+}
+#endif
+
 #endif
--=20
1.8.5.2.240.g8478abd

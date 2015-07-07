From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v5 01/44] wrapper: implement xopen()
Date: Tue,  7 Jul 2015 22:20:19 +0800
Message-ID: <1436278862-2638-2-git-send-email-pyokagan@gmail.com>
References: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 07 16:21:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCTkY-00041m-GJ
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 16:21:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757429AbbGGOVY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Jul 2015 10:21:24 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35617 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757238AbbGGOVT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 10:21:19 -0400
Received: by pactm7 with SMTP id tm7so114117582pac.2
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 07:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=BRZ7cB72kZgyjtUR0n2WRgdMtlHFtqtP5LU1EZvEl6w=;
        b=Hft8FGe6hEqUU/xY6bA7oyXXFRnq/nDGNOxwEldNcydqBkG4rnCm6O8fB3h41u7i6t
         eywNliY2yp6yFrkatBeo3+vPWQnAnZGU2qSLFZDy+KW5Z641qJf+bDy21Vn+zKmYeG9G
         2meiT+JV9ICjUwOwCoodHswobiwW1NEGAlm5M8+qqobTjkXkxpleZXYqilILfxNFl0kn
         p7SIB9EYsL409esNBsSFs+IOwiEOm70FMA+PGxq/WrapAapBfIVAxcSNbk8sz59hCXdF
         NNSlWLbdsD7z372G6F1KBj0+UkU9fq9E6lURo2drLXZ0sufEOH/KuYMIYQKcgnFbWZFP
         nhqQ==
X-Received: by 10.68.217.2 with SMTP id ou2mr9511799pbc.71.1436278879293;
        Tue, 07 Jul 2015 07:21:19 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id z4sm3800359pdo.88.2015.07.07.07.21.16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Jul 2015 07:21:17 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.76.gf60a929
In-Reply-To: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273521>

A common usage pattern of open() is to check if it was successful, and
die() if it was not:

	int fd =3D open(path, O_WRONLY | O_CREAT, 0777);
	if (fd < 0)
		die_errno(_("Could not open '%s' for writing."), path);

Implement a wrapper function xopen() that does the above so that we can
save a few lines of code, and make the die() messages consistent.

Helped-by: Torsten B=C3=B6gershausen <tboegi@web.de>
Helped-by: Jeff King <peff@peff.net>
Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

Notes:
    v5
   =20
    * Remove assert()s since we do not need to over-zealously check aga=
inst
      insane code.
   =20
    * Use va_arg(va, int) instead of va_arg(va, mode_t) to guard agains=
t
      undefined behavior if mode_t is incompatible with the promoted in=
teger
      argument (int).
   =20
    * The read/write error messages have returned as they can be used t=
o
      better diagnose permission errors. Hopefully I got the logic righ=
t
      this time.

 git-compat-util.h |  1 +
 wrapper.c         | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index c6d391f..e168dfd 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -717,6 +717,7 @@ extern void *xrealloc(void *ptr, size_t size);
 extern void *xcalloc(size_t nmemb, size_t size);
 extern void *xmmap(void *start, size_t length, int prot, int flags, in=
t fd, off_t offset);
 extern void *xmmap_gently(void *start, size_t length, int prot, int fl=
ags, int fd, off_t offset);
+extern int xopen(const char *path, int flags, ...);
 extern ssize_t xread(int fd, void *buf, size_t len);
 extern ssize_t xwrite(int fd, const void *buf, size_t len);
 extern ssize_t xpread(int fd, void *buf, size_t len, off_t offset);
diff --git a/wrapper.c b/wrapper.c
index ff49807..0a4502d 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -189,6 +189,41 @@ void *xcalloc(size_t nmemb, size_t size)
 # endif
 #endif
=20
+/**
+ * xopen() is the same as open(), but it die()s if the open() fails.
+ */
+int xopen(const char *path, int oflag, ...)
+{
+	mode_t mode =3D 0;
+	va_list ap;
+
+	/*
+	 * va_arg() will have undefined behavior if the specified type is not
+	 * compatible with the argument type. Since integers are promoted to
+	 * ints, we fetch the next argument as an int, and then cast it to a
+	 * mode_t to avoid undefined behavior.
+	 */
+	va_start(ap, oflag);
+	if (oflag & O_CREAT)
+		mode =3D va_arg(ap, int);
+	va_end(ap);
+
+	for (;;) {
+		int fd =3D open(path, oflag, mode);
+		if (fd >=3D 0)
+			return fd;
+		if (errno =3D=3D EINTR)
+			continue;
+
+		if ((oflag & O_RDWR) =3D=3D O_RDWR)
+			die_errno(_("could not open '%s' for reading and writing"), path);
+		else if ((oflag & O_WRONLY) =3D=3D O_WRONLY)
+			die_errno(_("could not open '%s' for writing"), path);
+		else
+			die_errno(_("could not open '%s' for reading"), path);
+	}
+}
+
 /*
  * xread() is the same a read(), but it automatically restarts read()
  * operations with a recoverable error (EAGAIN and EINTR). xread()
--=20
2.5.0.rc1.76.gf60a929

From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v4 01/44] wrapper: implement xopen()
Date: Sun, 28 Jun 2015 22:05:23 +0800
Message-ID: <1435500366-31700-2-git-send-email-pyokagan@gmail.com>
References: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 28 16:07:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9DEe-0001Yf-2M
	for gcvg-git-2@plane.gmane.org; Sun, 28 Jun 2015 16:07:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752374AbbF1OHA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 28 Jun 2015 10:07:00 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:33231 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752286AbbF1OG5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jun 2015 10:06:57 -0400
Received: by pdjn11 with SMTP id n11so101596966pdj.0
        for <git@vger.kernel.org>; Sun, 28 Jun 2015 07:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=peYJKO66cCxQAwZJJYZ7p5IOctsEi6nC16f2WPd/eOU=;
        b=T+395rRTLeJdJy9ds8LRHBR41ORa6mAij7jmgXvUjWyIWEK1i99a63XP2aKE62OVss
         1BpXwgSdo6k8+G1mgwkGkU6UUoL3PU/MGfW3Om4tPcTUIsblYsCYDPPbETQpV3Da5auE
         HxrWrIkMLa061CzAqVTSWtSE9zpalruzFadN8bZ6ZvwbntKckOzg0NPbvVEEkPC7Lq6H
         cQUREJvqfVyayN+alyAzYiv/G/qUzL58GP4wu8Ze4mpcWlcFDUF8GXssRmFNwnUmSnQM
         Bj2bqVgypb8J1OEIJ/98h46MlbErYdty6DyKIONbhdUerymUwPRU3Hvp/+rwO+jZmPKd
         Chbg==
X-Received: by 10.70.95.106 with SMTP id dj10mr22475284pdb.103.1435500415504;
        Sun, 28 Jun 2015 07:06:55 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id qa1sm39244820pab.0.2015.06.28.07.06.51
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 28 Jun 2015 07:06:54 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc0.76.gb2c6e93
In-Reply-To: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272877>

A common usage pattern of open() is to check if it was successful, and
die() if it was not:

	int fd =3D open(path, O_WRONLY | O_CREAT, 0777);
	if (fd < 0)
		die_errno(_("Could not open '%s' for writing."), path);

Implement a wrapper function xopen() that does the above so that we can
save a few lines of code, and make the die() messages consistent.

Helped-by: Torsten B=C3=B6gershausen <tboegi@web.de>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 git-compat-util.h |  1 +
 wrapper.c         | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+)

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
index ff49807..7e13ae0 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -189,6 +189,31 @@ void *xcalloc(size_t nmemb, size_t size)
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
+	va_start(ap, oflag);
+	if (oflag & O_CREAT)
+		mode =3D va_arg(ap, mode_t);
+	va_end(ap);
+
+	assert(path);
+
+	for (;;) {
+		int fd =3D open(path, oflag, mode);
+		if (fd >=3D 0)
+			return fd;
+		if (errno =3D=3D EINTR)
+			continue;
+		die_errno(_("could not open '%s'"), path);
+	}
+}
+
 /*
  * xread() is the same a read(), but it automatically restarts read()
  * operations with a recoverable error (EAGAIN and EINTR). xread()
--=20
2.5.0.rc0.76.gb2c6e93

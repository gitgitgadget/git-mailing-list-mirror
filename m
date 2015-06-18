From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH/WIP v3 01/31] wrapper: implement xopen()
Date: Thu, 18 Jun 2015 19:25:13 +0800
Message-ID: <1434626743-8552-2-git-send-email-pyokagan@gmail.com>
References: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 18 13:26:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5Xxi-0004Py-Az
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 13:26:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755462AbbFRL0W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Jun 2015 07:26:22 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:36401 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755280AbbFRL0O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 07:26:14 -0400
Received: by pdjm12 with SMTP id m12so64645220pdj.3
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 04:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=fC4XHxSctGVnruCDuOyo71MmNHPDATZ5b9SrC8aQ2PE=;
        b=QgRrAHuMaJJiTHfhqnFozetNc3NfGutfknCZkddzYIFE/YMZEKPYTrA/EFRSLdp0CP
         R4quF3b8alhljepaEDHI7O5DNAPw4BR6RofOsS9qOPb3DKoIUEAjrF9AvHz/0T94xEwf
         1qGyux8tLRuUBhqp9WCj7Q8ZvIvnhg+VVbBLo7O14Ec86+4Y/YHhu0cVyFJ9IgGRM/G3
         GPr3ZhL3fXsRtdY8T/e8izcJoqSrxb80R6jK4bwnpBpKKPZ4zZkiVHxkHu9x4A7q2eSf
         terSh4r61FIPj5nczwfj6ii7HoyMUsj0bhlW5JWkTMWlk0+EEldh4kV49HBA+JBc7V0N
         6E7Q==
X-Received: by 10.70.96.139 with SMTP id ds11mr20270640pdb.98.1434626773717;
        Thu, 18 Jun 2015 04:26:13 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id j9sm5443016pdl.65.2015.06.18.04.26.10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Jun 2015 04:26:12 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271965>

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
index 0cc7ae8..bc77d77 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -719,6 +719,7 @@ extern void *xrealloc(void *ptr, size_t size);
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
index c1a663f..82658b3 100644
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
2.1.4

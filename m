From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH/WIP v2 01/19] wrapper: implement xopen()
Date: Thu, 11 Jun 2015 18:21:47 +0800
Message-ID: <1434018125-31804-2-git-send-email-pyokagan@gmail.com>
References: <1434018125-31804-1-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 11 12:22:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2zct-0007bo-4a
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 12:22:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482AbbFKKWT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Jun 2015 06:22:19 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:35572 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101AbbFKKWR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2015 06:22:17 -0400
Received: by pdbnf5 with SMTP id nf5so1981333pdb.2
        for <git@vger.kernel.org>; Thu, 11 Jun 2015 03:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Sm+e/Q3A2eHJ5xKll9PFA5Z8wdjIstQsxCocbS5V8gs=;
        b=DAeoZXSJmnPsQVOcN/0/wupr02BaWcOGXalG+hinzFQW9jHarwKmKoXShDBvltEdNK
         5tteI55s8rR9m8zqaSYAIw6dvskEFXxdgjlBVQuGlp1wkNfj/YRYgmdLDktxrBeQ7ck6
         aoCXz/WR1oeSWlImK6iAvEx6Jtt+dvSdemJyPLpSX6n5vePwbx0j3segnfWtKikr/2Wj
         ghozggBu9aa504Onjhf1ttQ3ZGwb5dEqX1Tp0QkuaF+UklIjLnqRvL1r9qHusytza5fa
         r6p2fdnYvxcL0u+DWRyDGMzWpg29ORHiXSq5xeh7H2X0NuF+w/igyD+MWTEndvHFK6ox
         TuyQ==
X-Received: by 10.68.107.97 with SMTP id hb1mr13649698pbb.143.1434018136960;
        Thu, 11 Jun 2015 03:22:16 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id q4sm300488pdo.42.2015.06.11.03.22.13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Jun 2015 03:22:15 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1434018125-31804-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271382>

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

Notes:
    v2
   =20
    * retry on EINTR
   =20
    * mode is now an optional argument in xopen(). We use the mode argu=
ment
      only if O_CREAT is specified in oflag.

 git-compat-util.h |  1 +
 wrapper.c         | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index 17584ad..95cc278 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -718,6 +718,7 @@ extern char *xstrndup(const char *str, size_t len);
 extern void *xrealloc(void *ptr, size_t size);
 extern void *xcalloc(size_t nmemb, size_t size);
 extern void *xmmap(void *start, size_t length, int prot, int flags, in=
t fd, off_t offset);
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

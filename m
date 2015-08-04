From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v7 01/45] wrapper: implement xopen()
Date: Tue,  4 Aug 2015 21:51:22 +0800
Message-ID: <1438696326-19590-2-git-send-email-pyokagan@gmail.com>
References: <1438696326-19590-1-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 04 15:53:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMceY-00028L-OQ
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 15:53:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934149AbbHDNxF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Aug 2015 09:53:05 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35866 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933627AbbHDNxD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2015 09:53:03 -0400
Received: by pacgq8 with SMTP id gq8so9158890pac.3
        for <git@vger.kernel.org>; Tue, 04 Aug 2015 06:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=7cnbafwOIQ4eSQaKL/ax7D0wEqkzv13Vc6Py1NiveJM=;
        b=XqY/LV/CvzKr8JbrYk0NhcC+sckKvl+PmnoM7MRmhzrNTJFrJC+nwxzh/Gxutduy6z
         Vt+ngLJNIFMQyARRE+djt3CkzkNjf07gp0vBPUgVVAftlztWb3MzOM/guKvJ4lbQyfEX
         G6aoc8hc7Klt449E0suWdTdVIgDoD+doehW9NV9uw8uPU3YI6t6Eh3fZGvDKGFD9pY4I
         0jFG8NklD0/4XtKHtxlz13JzYwVOK/0VsnVFiD3sePAVhKNrj/JkQ3D7tOS3SD0Nko5b
         xxvMZA3t1+vtNyonxIgZIsCQatxkta5h0vRpF+dFYF0AkWYrUQnsD/sviLGCOmulDNDp
         cGxA==
X-Received: by 10.66.55.105 with SMTP id r9mr8048582pap.143.1438696381538;
        Tue, 04 Aug 2015 06:53:01 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id ph4sm1580517pdb.43.2015.08.04.06.52.59
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Aug 2015 06:53:00 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.280.gd88bd6e
In-Reply-To: <1438696326-19590-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275275>

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
2.5.0.280.gd88bd6e

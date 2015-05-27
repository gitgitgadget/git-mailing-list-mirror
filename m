From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH/WIP 1/8] wrapper: implement xopen()
Date: Wed, 27 May 2015 21:33:31 +0800
Message-ID: <1432733618-25629-2-git-send-email-pyokagan@gmail.com>
References: <1432733618-25629-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 27 15:34:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxbTd-00065H-1l
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 15:34:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752701AbbE0Ne1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 09:34:27 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:35645 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751326AbbE0NeY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 09:34:24 -0400
Received: by pdea3 with SMTP id a3so15329026pde.2
        for <git@vger.kernel.org>; Wed, 27 May 2015 06:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0dt0s9R9I/Ns8ZJ+adEvOcciQnfNCCXwwzRAdfcW2jg=;
        b=FGm9SCO6xunqMjfD9R2jKmUVB/vbQl5AU6Hg5UXuMfAicHSwrsLwBwHbxPiBHs+aeM
         UxPoDwf6gF5krXXFBOPhWNqwD00DDDWpZ4JcfBVxchC+gbL6i9fi2y6xC4Of+6Ydj105
         e8IDFFCJHR8dDxEuPSKK7WrwQ5PBAtUg+FDDW6sNYAaQT9+00sHzYXNhg1yTRw+I+GZ9
         lXkjCPpwDCoYKmklw5naNycs5I0eLv6Y7IY3HXxeyodJk9FnEGteIBJv4yZCUc+p8hzZ
         NWw4k8oTr9gZ5FtCzDjezw0Bti4epyYGnsDz6VHQWl+kPHCTnM55NgBitjSkiWfx4hV9
         Ciwg==
X-Received: by 10.70.54.164 with SMTP id k4mr59279369pdp.61.1432733664301;
        Wed, 27 May 2015 06:34:24 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id e5sm16301395pdc.94.2015.05.27.06.34.21
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 May 2015 06:34:22 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1432733618-25629-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270049>

A common usage pattern of open() is to check if it was successful, and
die() if it was not:

	int fd = open(path, O_WRONLY | O_CREAT, 0777);
	if (fd < 0)
		die_errno(_("Could not open '%s' for writing."), path);

Implement a wrapper function xopen() that does the above so that we can
save a few lines of code, and make the die() messages consistent.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 git-compat-util.h |  1 +
 wrapper.c         | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index 17584ad..9745962 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -718,6 +718,7 @@ extern char *xstrndup(const char *str, size_t len);
 extern void *xrealloc(void *ptr, size_t size);
 extern void *xcalloc(size_t nmemb, size_t size);
 extern void *xmmap(void *start, size_t length, int prot, int flags, int fd, off_t offset);
+extern int xopen(const char *path, int flags, mode_t mode);
 extern ssize_t xread(int fd, void *buf, size_t len);
 extern ssize_t xwrite(int fd, const void *buf, size_t len);
 extern ssize_t xpread(int fd, void *buf, size_t len, off_t offset);
diff --git a/wrapper.c b/wrapper.c
index c1a663f..971665a 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -189,6 +189,24 @@ void *xcalloc(size_t nmemb, size_t size)
 # endif
 #endif
 
+/**
+ * xopen() is the same as open(), but it die()s if the open() fails.
+ */
+int xopen(const char *path, int flags, mode_t mode)
+{
+	int fd;
+
+	assert(path);
+	fd = open(path, flags, mode);
+	if (fd < 0) {
+		if ((flags & O_WRONLY) || (flags & O_RDWR))
+			die_errno(_("could not open '%s' for writing"), path);
+		else
+			die_errno(_("could not open '%s' for reading"), path);
+	}
+	return fd;
+}
+
 /*
  * xread() is the same a read(), but it automatically restarts read()
  * operations with a recoverable error (EAGAIN and EINTR). xread()
-- 
2.1.4

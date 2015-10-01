From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv6 3/8] xread_nonblock: add functionality to read from fds without blocking
Date: Wed, 30 Sep 2015 18:54:11 -0700
Message-ID: <1443664456-1307-4-git-send-email-sbeller@google.com>
References: <1443664456-1307-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>, ramsay@ramsayjones.plus.com,
	jacob.keller@gmail.com, peff@peff.net, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	ericsunshine@gmail.com
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 01 03:55:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZhT5T-0000Ih-IE
	for gcvg-git-2@plane.gmane.org; Thu, 01 Oct 2015 03:55:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755137AbbJABzC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Sep 2015 21:55:02 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:35971 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753173AbbJAByc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Sep 2015 21:54:32 -0400
Received: by pablk4 with SMTP id lk4so57019553pab.3
        for <git@vger.kernel.org>; Wed, 30 Sep 2015 18:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9jw67h/4uiRs3v/3koveKVizsM+D74aQraq4ZgXvQu0=;
        b=EpIjLOYE5Wa9V1oX3tCuxPLsx/z1ivrd+NBbaNIuuRC0irzLZIVRN7mP/SDDMU8zH+
         plox9LqyDxn+x25ekhYvnfHLSWVQqpnXoCP1wScW6y+lGsYxXy0hdCVS7Wko0vsj3MUl
         klRmWutIHJDA+EbHTWXoPmAQk+VsUhsB03iqHztrwRpyAXtrGgCey41lV1FAo4gUUyXt
         XWVVXw1nnGbOSs1VDFKJLH6alfTMv5Lft6lb3JM/UZG6UPSMeb1ao0ls1epGbhZ/rRT6
         s2B4n5LeFbSRsSdbEnNyg35oph50TJ2C6qcE1j7JJSFv7FwY2st8zW/dDBlbl/GWiwzI
         xKkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9jw67h/4uiRs3v/3koveKVizsM+D74aQraq4ZgXvQu0=;
        b=JBxkDQADIKwqH8L8SnQ68Q9CXH43j8tpn76ShYpps8OZlWDnOJTFGVIZcHvkse/TCm
         jDEQhb88Vr+rGuq49OMWZbCjKNvVNbHqJTrVgcYJxorvRl9qCY1jJRXxcb0lxd6HbXi8
         RRtzjdw41Y1JRIJw8uDYh5e/1r0pAdpQ/tfBXgyAnWCL4nCaxsuhAWJksSSdHMB3YGpJ
         vJIzoYnQ8dOF8DRoXrURLzcUoeLsViqWEm5yzDejdkCPh3j/Gz64OxKbp9SDgeanFvNA
         0ywzDk8YV9hpxU2hbcBL2seAuwUa1YUyV1N+ojuHmZ4iWHL2lffS3Ikfngi4URyZjMKG
         kMvw==
X-Gm-Message-State: ALoCoQl2xoxcWBChFs+XTCXYXdYnARJNkJO5CWKDqXs5H1luJOMSX9L0zSnm94E7KV5h9cUrBxPt
X-Received: by 10.68.244.34 with SMTP id xd2mr8656974pbc.50.1443664472167;
        Wed, 30 Sep 2015 18:54:32 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:8d91:1679:adb7:b916])
        by smtp.gmail.com with ESMTPSA id xd10sm3102159pab.25.2015.09.30.18.54.31
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 30 Sep 2015 18:54:31 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.275.gf20166c.dirty
In-Reply-To: <1443664456-1307-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278879>

Provide a wrapper to read(), similar to xread(), that restarts on
EINTR but not EAGAIN (or EWOULDBLOCK). This enables the caller to
handle polling itself, possibly polling multiple sockets or performing
some other action.

Helped-by: Jacob Keller <jacob.keller@gmail.com>
Helped-by: Jeff King <peff@peff.net>,
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-compat-util.h |  1 +
 wrapper.c         | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index c6d391f..9ccea85 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -718,6 +718,7 @@ extern void *xcalloc(size_t nmemb, size_t size);
 extern void *xmmap(void *start, size_t length, int prot, int flags, int fd, off_t offset);
 extern void *xmmap_gently(void *start, size_t length, int prot, int flags, int fd, off_t offset);
 extern ssize_t xread(int fd, void *buf, size_t len);
+extern ssize_t xread_nonblock(int fd, void *buf, size_t len);
 extern ssize_t xwrite(int fd, const void *buf, size_t len);
 extern ssize_t xpread(int fd, void *buf, size_t len, off_t offset);
 extern int xdup(int fd);
diff --git a/wrapper.c b/wrapper.c
index 5517928..41a21e1 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -217,6 +217,28 @@ ssize_t xread(int fd, void *buf, size_t len)
 }
 
 /*
+ * xread_nonblock() is the same a read(), but it automatically restarts read()
+ * interrupted operations (EINTR). xread_nonblock() DOES NOT GUARANTEE that
+ * "len" bytes is read. EWOULDBLOCK is turned into EAGAIN.
+ */
+ssize_t xread_nonblock(int fd, void *buf, size_t len)
+{
+	ssize_t nr;
+	if (len > MAX_IO_SIZE)
+		len = MAX_IO_SIZE;
+	while (1) {
+		nr = read(fd, buf, len);
+		if (nr < 0) {
+			if (errno == EINTR)
+				continue;
+			if (errno == EWOULDBLOCK)
+				errno = EAGAIN;
+		}
+		return nr;
+	}
+}
+
+/*
  * xwrite() is the same a write(), but it automatically restarts write()
  * operations with a recoverable error (EAGAIN and EINTR). xwrite() DOES NOT
  * GUARANTEE that "len" bytes is written even if the operation is successful.
-- 
2.5.0.275.gf20166c.dirty

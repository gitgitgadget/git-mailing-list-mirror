From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 03/14] copy_fd: pass error message back through a strbuf
Date: Tue, 2 Dec 2014 21:13:44 -0800
Message-ID: <20141203051344.GM6527@google.com>
References: <1416262453-30349-1-git-send-email-sbeller@google.com>
 <20141117233525.GC4336@google.com>
 <CAGZ79kYU1f1COjtv+4MzgbPLi42m1JQsXsuuCr3WXsuR8XrO7w@mail.gmail.com>
 <20141118004841.GE4336@google.com>
 <CAGZ79kbF6JjxgHX2KZFhSh9QyGOXeS=cVK0z=CM4n9-ErRDJ8A@mail.gmail.com>
 <20141203050217.GJ6527@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 06:13:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xw2G8-0005St-NI
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 06:13:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750952AbaLCFNs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 00:13:48 -0500
Received: from mail-ig0-f177.google.com ([209.85.213.177]:49874 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750707AbaLCFNr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 00:13:47 -0500
Received: by mail-ig0-f177.google.com with SMTP id z20so12141620igj.4
        for <git@vger.kernel.org>; Tue, 02 Dec 2014 21:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=KekDCeDKJiH7POaKZnHjwLBHfIR/XQE4dd5xGN9eZ7s=;
        b=qUk+858AtK5+WbIarNaJRf7jpu12CyFfIYpdIV0I6q1jszCMLuhH3CxgSvY2P90jZD
         CKrFJQKWZAzgPZ4vM6Fj+Bpgy+DNKulHt/fV+tE4crRu8cS3MiR9Q8JPp6l2w61o0ckH
         xTq0bOyqHGo0IWFkbkWAt07FvmQwWhpQFZ48T0yV3gZxfpA4ZMhlRbKu+8Kui9e2Xqb+
         +8naytN5QJCoWQHpzsxvedXptGsCHvIz7zFA2LP1Cp60xdlzuFjaohfuCTVnYFo+w9tO
         Nmyp8Ee5M6o+BkC8XhJ95VvAd0CpBU+37CC5LY569ZgIwPJbloQ7ESU0unG7r7bxcqZj
         pzUw==
X-Received: by 10.43.128.71 with SMTP id hd7mr5685371icc.36.1417583627203;
        Tue, 02 Dec 2014 21:13:47 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:fd7b:507b:3c7b:554e])
        by mx.google.com with ESMTPSA id c62sm12221731ioe.22.2014.12.02.21.13.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Dec 2014 21:13:46 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141203050217.GJ6527@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260627>

This way, callers can put the message in context or even avoid
printing the message altogether.

Currently hold_lock_file_for_append tries to save errno in order to
produce a meaningful message about the failure and tries to print a
second message using errno.  Unfortunately the errno it uses is not
meaningful because copy_fd makes no effort to set a meaningful errno
value.  This change is preparation for simplifying the
hold_lock_file_for_append behavior.

No user-visible change intended yet.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
The title feature.

 cache.h    |  2 +-
 convert.c  |  6 +++++-
 copy.c     | 32 +++++++++++++++++++++-----------
 lockfile.c |  6 +++++-
 4 files changed, 32 insertions(+), 14 deletions(-)

diff --git a/cache.h b/cache.h
index 99ed096..ddaa30f 100644
--- a/cache.h
+++ b/cache.h
@@ -1479,7 +1479,7 @@ extern const char *git_mailmap_blob;
 extern void maybe_flush_or_die(FILE *, const char *);
 __attribute__((format (printf, 2, 3)))
 extern void fprintf_or_die(FILE *, const char *fmt, ...);
-extern int copy_fd(int ifd, int ofd);
+extern int copy_fd(int ifd, int ofd, struct strbuf *err);
 extern int copy_file(const char *dst, const char *src, int mode);
 extern int copy_file_with_time(const char *dst, const char *src, int mode);
 extern void write_or_die(int fd, const void *buf, size_t count);
diff --git a/convert.c b/convert.c
index 9a5612e..e301447 100644
--- a/convert.c
+++ b/convert.c
@@ -358,7 +358,11 @@ static int filter_buffer_or_fd(int in, int out, void *data)
 	if (params->src) {
 		write_err = (write_in_full(child_process.in, params->src, params->size) < 0);
 	} else {
-		write_err = copy_fd(params->fd, child_process.in);
+		struct strbuf err = STRBUF_INIT;
+		write_err = copy_fd(params->fd, child_process.in, &err);
+		if (write_err)
+			error("copy-fd: %s", err.buf);
+		strbuf_release(&err);
 	}
 
 	if (close(child_process.in))
diff --git a/copy.c b/copy.c
index f2970ec..828661a 100644
--- a/copy.c
+++ b/copy.c
@@ -1,19 +1,22 @@
 #include "cache.h"
 
-int copy_fd(int ifd, int ofd)
+int copy_fd(int ifd, int ofd, struct strbuf *err)
 {
+	assert(err);
+
 	while (1) {
 		char buffer[8192];
 		ssize_t len = xread(ifd, buffer, sizeof(buffer));
 		if (!len)
 			break;
 		if (len < 0) {
-			return error("copy-fd: read returned %s",
-				     strerror(errno));
+			strbuf_addf(err, "read returned %s", strerror(errno));
+			return -1;
+		}
+		if (write_in_full(ofd, buffer, len) < 0) {
+			strbuf_addf(err, "write returned %s", strerror(errno));
+			return -1;
 		}
-		if (write_in_full(ofd, buffer, len) < 0)
-			return error("copy-fd: write returned %s",
-				     strerror(errno));
 	}
 	return 0;
 }
@@ -33,7 +36,8 @@ static int copy_times(const char *dst, const char *src)
 
 int copy_file(const char *dst, const char *src, int mode)
 {
-	int fdi, fdo, status;
+	int fdi, fdo;
+	struct strbuf err = STRBUF_INIT;
 
 	mode = (mode & 0111) ? 0777 : 0666;
 	if ((fdi = open(src, O_RDONLY)) < 0)
@@ -42,15 +46,21 @@ int copy_file(const char *dst, const char *src, int mode)
 		close(fdi);
 		return fdo;
 	}
-	status = copy_fd(fdi, fdo);
+	if (copy_fd(fdi, fdo, &err)) {
+		close(fdi);
+		close(fdo);
+		error("copy-fd: %s", err.buf);
+		strbuf_release(&err);
+		return -1;
+	}
+	strbuf_release(&err);
 	close(fdi);
 	if (close(fdo) != 0)
 		return error("%s: close error: %s", dst, strerror(errno));
-
-	if (!status && adjust_shared_perm(dst))
+	if (adjust_shared_perm(dst))
 		return -1;
 
-	return status;
+	return 0;
 }
 
 int copy_file_with_time(const char *dst, const char *src, int mode)
diff --git a/lockfile.c b/lockfile.c
index 4f16ee7..b3020f3 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -182,6 +182,7 @@ int hold_lock_file_for_update(struct lock_file *lk, const char *path, int flags)
 int hold_lock_file_for_append(struct lock_file *lk, const char *path, int flags)
 {
 	int fd, orig_fd;
+	struct strbuf err = STRBUF_INIT;
 
 	fd = lock_file(lk, path, flags);
 	if (fd < 0) {
@@ -202,9 +203,11 @@ int hold_lock_file_for_append(struct lock_file *lk, const char *path, int flags)
 			errno = save_errno;
 			return -1;
 		}
-	} else if (copy_fd(orig_fd, fd)) {
+	} else if (copy_fd(orig_fd, fd, &err)) {
 		int save_errno = errno;
 
+		error("copy-fd: %s", err.buf);
+		strbuf_release(&err);
 		if (flags & LOCK_DIE_ON_ERROR)
 			exit(128);
 		close(orig_fd);
@@ -214,6 +217,7 @@ int hold_lock_file_for_append(struct lock_file *lk, const char *path, int flags)
 	} else {
 		close(orig_fd);
 	}
+	strbuf_release(&err);
 	return fd;
 }
 

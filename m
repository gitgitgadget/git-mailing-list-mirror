From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] copy.c: make copy_fd preserve meaningful errno
Date: Mon, 17 Nov 2014 15:35:25 -0800
Message-ID: <20141117233525.GC4336@google.com>
References: <1416262453-30349-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org,
	Ronnie Sahlberg <sahlberg@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Nov 18 00:35:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqVpS-0003Ut-68
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 00:35:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751547AbaKQXfZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 18:35:25 -0500
Received: from mail-ig0-f182.google.com ([209.85.213.182]:41718 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751297AbaKQXfY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 18:35:24 -0500
Received: by mail-ig0-f182.google.com with SMTP id hn15so3029210igb.3
        for <git@vger.kernel.org>; Mon, 17 Nov 2014 15:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=fiGGj3u2Px+5/U4gKiYmhpruy2uHCEnC6AOqNRqC7Vo=;
        b=xbZwCAx6accndjPzk27zSXX+a+QAJhZTOSbXfwQxPpTc2DCL005ZxeE06XN0JRHosv
         QA+MmfkvXbHBd+lqNJ658qr052kHJNx1WfoSyGEop8EkBwV3Osv0bgU14nfsEh/mHGX2
         Oj+jOtiuGfdZsQyEOuBx01QFwaomT3NEYrQ+8gu/cUDI6AkSkE4+mGMhR+0yq60K56RY
         SDYgPxAUS8HJv8MJWTL1hlQJcfjMfneTrmO7qpRdntE6uiJyGxwQa2kCMRk7FxEERw2T
         YypXjL6hbwLI4PW9rte7jUw4nCyG2A2XI1mYWRNVlQpwqo929pjj8y6vPfVRr6p6BbgC
         Tq4g==
X-Received: by 10.107.9.65 with SMTP id j62mr6458642ioi.57.1416267324052;
        Mon, 17 Nov 2014 15:35:24 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:8c00:16f4:9f72:d6ec])
        by mx.google.com with ESMTPSA id a4sm6713504igx.10.2014.11.17.15.35.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 17 Nov 2014 15:35:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1416262453-30349-1-git-send-email-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Stefan Beller wrote:

> This patch was sent previously to the list as part of
> that series[2], but it seems to be unrelated to me.

Thanks.  Good call.

[...]
> From: Ronnie Sahlberg <sahlberg@google.com>
>
> Update copy_fd to return a meaningful errno on failure and also
> preserve the existing errno variable.

Some functions in git make errno meaningful on error and others don't.
In general, the more we only use errno immediately after a system
call, the better, so based on the above description this seems like a
step in the wrong direction.

Do any callers care about errno?  Does the function's API
documentation say it will make errno meaningful on error, so people
making changes to copy_fd in the future know to maintain that
property?

*searches*

Looks like callers are:

 convert.c::filter_buffer_or_fd, which doesn't care

 copy.c::copy_file, which also doesn't care

 lockfile.c::hold_lock_file_for_append, which started caring
 in order to propagate errno in v2.2.0-rc0~53^2~2 (restore errno
 before returning, 2014-10-01).  But no callers of that function
 care yet.

So this is about fixing a bug-waiting-to-happen in
hold_lock_file_for_append.  That would be enough to motivate the
change.

[...]
>  copy.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)

Please also update the API documentation in cache.h so we remember not
to backslide in the future.

[...]
> --- a/copy.c
> +++ b/copy.c
> @@ -8,12 +8,17 @@ int copy_fd(int ifd, int ofd)
>  		if (!len)
>  			break;
>  		if (len < 0) {
> -			return error("copy-fd: read returned %s",
> -				     strerror(errno));
> +			int save_errno = errno;
> +			error("copy-fd: read returned %s", strerror(errno));
> +			errno = save_errno;
> +			return -1;

Any caller is presumably going to turn around and print strerror(errno)
again, producing repetitive output.

Can we do better?  E.g., if the signature were

	int copy_fd(int ifd, int ofd, struct strbuf *err);

then we could write the error message to the err strbuf for the
caller to print.  The error handling would be more explicit so
there would be no need to protect errno from clobbering by other
system calls (both here and in callers).

Something like this:

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

diff --git i/cache.h w/cache.h
index 99ed096..ddaa30f 100644
--- i/cache.h
+++ w/cache.h
@@ -1479,7 +1479,7 @@ extern const char *git_mailmap_blob;
 extern void maybe_flush_or_die(FILE *, const char *);
 __attribute__((format (printf, 2, 3)))
 extern void fprintf_or_die(FILE *, const char *fmt, ...);
-extern int copy_fd(int ifd, int ofd);
+extern int copy_fd(int ifd, int ofd, struct strbuf *err);
 extern int copy_file(const char *dst, const char *src, int mode);
 extern int copy_file_with_time(const char *dst, const char *src, int mode);
 extern void write_or_die(int fd, const void *buf, size_t count);
diff --git i/convert.c w/convert.c
index 9a5612e..e301447 100644
--- i/convert.c
+++ w/convert.c
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
diff --git i/copy.c w/copy.c
index f2970ec..828661a 100644
--- i/copy.c
+++ w/copy.c
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
diff --git i/lockfile.c w/lockfile.c
index 4f16ee7..c47976e 100644
--- i/lockfile.c
+++ w/lockfile.c
@@ -179,37 +179,52 @@ int hold_lock_file_for_update(struct lock_file *lk, const char *path, int flags)
 	return fd;
 }
 
-int hold_lock_file_for_append(struct lock_file *lk, const char *path, int flags)
+/*
+ * Like strbuf_addf but inserts at the front of a strbuf instead
+ * of appending.
+ */
+static void strbuf_prefixf(struct strbuf *sb, const char *fmt, ...)
+{
+	size_t pos, len;
+	va_list ap;
+
+	pos = sb->len;
+
+	va_start(ap, fmt);
+	strbuf_vaddf(sb, fmt, ap);
+	va_end(ap);
+
+	len = sb->len - pos;
+	strbuf_insert(sb, 0, sb->buf + pos, len);
+	strbuf_remove(sb, pos + len, len);
+}
+
+int hold_lock_file_for_append(struct lock_file *lk, const char *path,
+			      int flags, struct strbuf *err)
 {
 	int fd, orig_fd;
 
+	assert(!(flags & LOCK_DIE_ON_ERROR));
+	assert(err && !err->len);
+
 	fd = lock_file(lk, path, flags);
 	if (fd < 0) {
-		if (flags & LOCK_DIE_ON_ERROR)
-			unable_to_lock_die(path, errno);
+		unable_to_lock_message(path, errno, err);
 		return fd;
 	}
 
 	orig_fd = open(path, O_RDONLY);
 	if (orig_fd < 0) {
 		if (errno != ENOENT) {
-			int save_errno = errno;
-
-			if (flags & LOCK_DIE_ON_ERROR)
-				die("cannot open '%s' for copying", path);
+			strbuf_addf(err, "cannot open '%s' for copying: %s",
+				    path, strerror(errno));
 			rollback_lock_file(lk);
-			error("cannot open '%s' for copying", path);
-			errno = save_errno;
 			return -1;
 		}
-	} else if (copy_fd(orig_fd, fd)) {
-		int save_errno = errno;
-
-		if (flags & LOCK_DIE_ON_ERROR)
-			exit(128);
+	} else if (copy_fd(orig_fd, fd, err)) {
+		strbuf_prefixf(err, "cannot copy '%s': ", path);
 		close(orig_fd);
 		rollback_lock_file(lk);
-		errno = save_errno;
 		return -1;
 	} else {
 		close(orig_fd);
diff --git i/lockfile.h w/lockfile.h
index cd2ec95..ca36a1d 100644
--- i/lockfile.h
+++ w/lockfile.h
@@ -75,7 +75,8 @@ extern void unable_to_lock_message(const char *path, int err,
 				   struct strbuf *buf);
 extern NORETURN void unable_to_lock_die(const char *path, int err);
 extern int hold_lock_file_for_update(struct lock_file *, const char *path, int);
-extern int hold_lock_file_for_append(struct lock_file *, const char *path, int);
+extern int hold_lock_file_for_append(struct lock_file *, const char *path,
+				     int, struct strbuf *err);
 extern FILE *fdopen_lock_file(struct lock_file *, const char *mode);
 extern char *get_locked_file_path(struct lock_file *);
 extern int commit_lock_file_to(struct lock_file *, const char *path);
diff --git i/sha1_file.c w/sha1_file.c
index d7f1838..9ae1839 100644
--- i/sha1_file.c
+++ w/sha1_file.c
@@ -403,14 +403,24 @@ void read_info_alternates(const char * relative_base, int depth)
 
 void add_to_alternates_file(const char *reference)
 {
-	struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
-	int fd = hold_lock_file_for_append(lock, git_path("objects/info/alternates"), LOCK_DIE_ON_ERROR);
-	char *alt = mkpath("%s\n", reference);
+	struct lock_file *lock;
+	int fd;
+	char *alt;
+	struct strbuf err = STRBUF_INIT;
+
+	lock = xcalloc(1, sizeof(*lock));
+	fd = hold_lock_file_for_append(lock, git_path("objects/info/alternates"),
+				       0, &err);
+	if (fd < 0)
+		die("%s", err.buf);
+	alt = mkpath("%s\n", reference);
 	write_or_die(fd, alt, strlen(alt));
 	if (commit_lock_file(lock))
 		die("could not close alternates file");
 	if (alt_odb_tail)
 		link_alt_odb_entries(alt, strlen(alt), '\n', NULL, 0);
+
+	strbuf_release(&err);
 }
 
 int foreach_alt_odb(alt_odb_fn fn, void *cb)

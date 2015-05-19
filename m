From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] sha1_file: pass empty buffer to index empty file
Date: Tue, 19 May 2015 11:11:38 -0700
Message-ID: <xmqqk2w48mjp.fsf@gitster.dls.corp.google.com>
References: <xmqqa8x4fjf5.fsf@gitster.dls.corp.google.com>
	<1431806796-28902-1-git-send-email-gjthill@gmail.com>
	<xmqqegmfds1n.fsf@gitster.dls.corp.google.com>
	<xmqqvbfrc952.fsf@gitster.dls.corp.google.com>
	<20150519063716.GA22771@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jim Hill <gjthill@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 19 20:11:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YulzX-0007Q7-Jo
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 20:11:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751607AbbESSLn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 14:11:43 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:35558 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751242AbbESSLm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 14:11:42 -0400
Received: by igbyr2 with SMTP id yr2so82798132igb.0
        for <git@vger.kernel.org>; Tue, 19 May 2015 11:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Z7qdlLDxwp+27l1lrUpjIHQkyR7U+SZOXjicxi+VsQU=;
        b=dajyh+nQx1oD6PuucwS6kUVHknC+omkaaGnovtr2frcucSoZ5WoiZWBqQ3iv7k5ZNk
         dD8xyUxpxgX1x/ZjfcqUvW9CkG04nBwdZwG6Ne+AW6Ww2CKb+tZZMdj1E7N1lSMay9Aa
         TjxOF82BGE5D0HRw7/IFHUUJFvypRcrMIP5v8vhA1cO26RnOFn/fIpUnQXZROPQ8Qwxl
         /GccI3fLRBhq6CfNF3axEYlGA5ra5EBXhxHNqwRnuPY2vNcoDc5AcK6lVf8zlbJJYKID
         io9qkJsHOEAyTlW4YvVta94+mVURCSb2kprNprNfOpEfn/rbIJP3J3FKd6bfD1xiR+25
         voMw==
X-Received: by 10.42.81.6 with SMTP id x6mr27234394ick.89.1432059101820;
        Tue, 19 May 2015 11:11:41 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:799e:649b:b86b:7c03])
        by mx.google.com with ESMTPSA id j194sm10508622ioe.7.2015.05.19.11.11.38
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 19 May 2015 11:11:40 -0700 (PDT)
In-Reply-To: <20150519063716.GA22771@peff.net> (Jeff King's message of "Tue,
	19 May 2015 02:37:16 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269382>

Jeff King <peff@peff.net> writes:

> On Sun, May 17, 2015 at 12:10:49PM -0700, Junio C Hamano wrote:
>
>> I spoke too fast X-<.  "while sh t0021-*.sh; do :; done" dies after
>> a few iterations and with this squashed in it doesn't.
>> 
>>  t/t0021-conversion.sh | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
>> index 42e6423..b778faf 100755
>> --- a/t/t0021-conversion.sh
>> +++ b/t/t0021-conversion.sh
>> @@ -218,7 +218,7 @@ test_expect_success "filter: clean empty file" '
>>  '
>>  
>>  test_expect_success "filter: smudge empty file" '
>> -	git config filter.empty-in-repo.clean true &&
>> +	git config filter.empty-in-repo.clean "cat >/dev/null" &&
>
> Hmm, I thought we turned off SIGPIPE when writing to filters these days.
> Looks like we still complain if we get EPIPE, though. I feel like it
> should be the filter's business whether it wants to consume all of the
> input or not[1], and we should only be checking its exit status.
>
> -Peff
>
> [1] As a practical example, consider a file format that has a lot of
>     cruft at the end. The clean filter would want to read only to the
>     start of the cruft, and then stop for reasons of efficiency.

Yes.  Let's do these two.  The preparatory patch is larger than the
real change.

-- >8 --
From: Junio C Hamano <gitster@pobox.com>
Date: Tue, 19 May 2015 10:55:16 -0700
Subject: [PATCH] copy.c: make copy_fd() report its status silently

When copy_fd() function encounters errors, it emits error messages
itself, which makes it impossible for callers to take responsibility
for reporting errors, especially when they want to ignore certaion
errors.

Move the error reporting to its callers in preparation.

 - copy_file() and copy_file_with_time() by indirection get their
   own calls to error().

 - hold_lock_file_for_append(), when told to die on error, used to
   exit(128) relying on the error message from copy_fd(), but now it
   does its own die() instead.  Note that the callers that do not
   pass LOCK_DIE_ON_ERROR need to be adjusted for this change, but
   fortunately there is none ;-)

 - filter_buffer_or_fd() has its own error() already, in addition to
   the message from copy_fd(), so this will change the output but
   arguably in a better way.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h    |  4 ++++
 copy.c     | 17 +++++++++++------
 lockfile.c |  2 +-
 3 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/cache.h b/cache.h
index 22b7b81..2981eec 100644
--- a/cache.h
+++ b/cache.h
@@ -1482,9 +1482,13 @@ extern const char *git_mailmap_blob;
 extern void maybe_flush_or_die(FILE *, const char *);
 __attribute__((format (printf, 2, 3)))
 extern void fprintf_or_die(FILE *, const char *fmt, ...);
+
+#define COPY_READ_ERROR (-2)
+#define COPY_WRITE_ERROR (-3)
 extern int copy_fd(int ifd, int ofd);
 extern int copy_file(const char *dst, const char *src, int mode);
 extern int copy_file_with_time(const char *dst, const char *src, int mode);
+
 extern void write_or_die(int fd, const void *buf, size_t count);
 extern int write_or_whine(int fd, const void *buf, size_t count, const char *msg);
 extern int write_or_whine_pipe(int fd, const void *buf, size_t count, const char *msg);
diff --git a/copy.c b/copy.c
index f2970ec..574fa1f 100644
--- a/copy.c
+++ b/copy.c
@@ -7,13 +7,10 @@ int copy_fd(int ifd, int ofd)
 		ssize_t len = xread(ifd, buffer, sizeof(buffer));
 		if (!len)
 			break;
-		if (len < 0) {
-			return error("copy-fd: read returned %s",
-				     strerror(errno));
-		}
+		if (len < 0)
+			return COPY_READ_ERROR;
 		if (write_in_full(ofd, buffer, len) < 0)
-			return error("copy-fd: write returned %s",
-				     strerror(errno));
+			return COPY_WRITE_ERROR;
 	}
 	return 0;
 }
@@ -43,6 +40,14 @@ int copy_file(const char *dst, const char *src, int mode)
 		return fdo;
 	}
 	status = copy_fd(fdi, fdo);
+	switch (status) {
+	case COPY_READ_ERROR:
+		error("copy-fd: read returned %s", strerror(errno));
+		break;
+	case COPY_WRITE_ERROR:
+		error("copy-fd: write returned %s", strerror(errno));
+		break;
+	}
 	close(fdi);
 	if (close(fdo) != 0)
 		return error("%s: close error: %s", dst, strerror(errno));
diff --git a/lockfile.c b/lockfile.c
index 4f16ee7..beba0ed 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -206,7 +206,7 @@ int hold_lock_file_for_append(struct lock_file *lk, const char *path, int flags)
 		int save_errno = errno;
 
 		if (flags & LOCK_DIE_ON_ERROR)
-			exit(128);
+			die("failed to prepare '%s' for appending", path);
 		close(orig_fd);
 		rollback_lock_file(lk);
 		errno = save_errno;
-- 
2.4.1-413-ga38dc94

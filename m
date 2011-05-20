From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCH] wrapper: Introduce xclose to restart close on EINTR
Date: Fri, 20 May 2011 14:05:38 -0500
Message-ID: <20110520190538.GG17177@elie>
References: <20110520071609.GA6755@domU-12-31-39-06-A8-0A.compute-1.internal>
 <1305880223-7542-1-git-send-email-artagnon@gmail.com>
 <1305880223-7542-3-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <christian.couder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 20 21:05:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNV1B-0001ZV-L2
	for gcvg-git-2@lo.gmane.org; Fri, 20 May 2011 21:05:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935481Ab1ETTFo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2011 15:05:44 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:38109 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934841Ab1ETTFn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2011 15:05:43 -0400
Received: by iwn34 with SMTP id 34so3262777iwn.19
        for <git@vger.kernel.org>; Fri, 20 May 2011 12:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=bsEKvz7pksTK0Noq72UfXG4zQmAwGwADnDlNhycvoEk=;
        b=h+OEuAfZl+QduonvyClAfudrTAPQkQDYtY0ER7sZachdNJcBKVWKOmxtXk4UZAKyEl
         uGwiBY+jPeiTVWGPICkGHrfDaKALVMbERYx/O8tNqCfRLTZjjW+++76Q52WgYnL1RnOf
         j5BBfAeW6zMnnqyy5IqgIdacZKUB4iy9eCkNQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=KGQCogVbzHJ0UChswXKA4zCyx8S9jie5RYVmUhmUD3nnSKGbKEhllYiEl/KAmBqeQp
         vFeNldwTsbzpx5ht/53aR1v9V7KXHIoOZp6Ssf9mb+3K07r10QLqlNYiLJU4sOZaQdLA
         3AsvB7GKn+QDXUH9AmhwHjlXWiKgERanTueiQ=
Received: by 10.42.228.68 with SMTP id jd4mr5057532icb.142.1305918342957;
        Fri, 20 May 2011 12:05:42 -0700 (PDT)
Received: from elie (adsl-69-209-78-180.dsl.chcgil.sbcglobal.net [69.209.78.180])
        by mx.google.com with ESMTPS id hn6sm1218848icb.19.2011.05.20.12.05.40
        (version=SSLv3 cipher=OTHER);
        Fri, 20 May 2011 12:05:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1305880223-7542-3-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174075>

Ramkumar Ramachandra wrote:

> [Subject: [RFC PATCH] wrapper: Introduce xclose to restart close on EINTR]

close never returns with errno == EINTR on Linux, but it can happen on
Solaris, for example.

I can't think of a reason git would want to call close() without this
loop.  Maybe it would make sense to wrap close() unconditionally (see
below).

> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -141,6 +141,21 @@ ssize_t xwrite(int fd, const void *buf, size_t len)
>  	}
>  }
>  
> +/*
> + * xclose() is the same a close(), but it automatically restarts close()
> + * operations with a recoverable error (EINTR).
> + */

If there is to be an xclose, I think I'd say something like

	/*
	 * xclose() is like close(), but it retries if interrupted by
	 * a signal on platforms like Solaris that allow that to avoid
	 * unnecessarily leaking a file descriptor.  It quietly returns
	 * -1 with errno set appropriately on failure.
	 */

to avoid confusion with the semantics of xmalloc.

> +int xclose(int fd)
> +{
> +	int ret;
> +	while (1) {
> +		ret = close(fd);
> +		if ((ret < 0) && errno == EINTR)
> +			continue;
> +		return ret;
> +	}
> +}

Micronit: close() can only return 0 or -1, so this can be written more
simply as

	while (close(fd)) {
		if (errno == EINTR)
			continue;
		return -1;
	}
	return 0;

Untested.

-- >8 --
Subject: compat: wrap close() to avoid having to worry about EINTR

On some non-Linux platforms, close() can return EINTR to indicate
interruption by a signal.  In a poll or select loop, that could be
good behavior to prevent hangs, but that doesn't apply anywhere within
git.  Let close() loop unconditionally in this case to avoid
preventable file descriptor leaks.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 git-compat-util.h |   12 +++++++++++-
 wrapper.c         |   15 ---------------
 2 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 6e06ad4..1326edb 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -428,7 +428,6 @@ extern void *xcalloc(size_t nmemb, size_t size);
 extern void *xmmap(void *start, size_t length, int prot, int flags, int fd, off_t offset);
 extern ssize_t xread(int fd, void *buf, size_t len);
 extern ssize_t xwrite(int fd, const void *buf, size_t len);
-extern int xclose(int fd);
 extern int xdup(int fd);
 extern FILE *xfdopen(int fd, const char *mode);
 extern int xmkstemp(char *template);
@@ -450,6 +449,17 @@ static inline int has_extension(const char *filename, const char *ext)
 	return len > extlen && !memcmp(filename + len - extlen, ext, extlen);
 }
 
+/* Sane close - resumes after interruption by signals */
+static inline int git_close(int fd)
+{
+	while (close(fd)) {
+		if (errno != EINTR)
+			return -1;
+	}
+	return 0;
+}
+#define close git_close
+
 /* Sane ctype - no locale, and works with signed chars */
 #undef isascii
 #undef isspace
diff --git a/wrapper.c b/wrapper.c
index 717e989..2829000 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -141,21 +141,6 @@ ssize_t xwrite(int fd, const void *buf, size_t len)
 	}
 }
 
-/*
- * xclose() is the same a close(), but it automatically restarts close()
- * operations with a recoverable error (EINTR).
- */
-int xclose(int fd)
-{
-	int ret;
-	while (1) {
-		ret = close(fd);
-		if ((ret < 0) && errno == EINTR)
-			continue;
-		return ret;
-	}
-}
-
 ssize_t read_in_full(int fd, void *buf, size_t count)
 {
 	char *p = buf;
-- 
1.7.5.1

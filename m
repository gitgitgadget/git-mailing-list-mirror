From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 03/13] xread_nonblock: add functionality to read from fds nonblockingly
Date: Mon, 21 Sep 2015 17:02:23 -0700
Message-ID: <xmqqwpvj7240.fsf@gitster.mtv.corp.google.com>
References: <1442875159-13027-1-git-send-email-sbeller@google.com>
	<1442875159-13027-4-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, jacob.keller@gmail.com, peff@peff.net,
	jrnieder@gmail.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, vlovich@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Sep 22 02:02:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeB2U-00023n-Kc
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 02:02:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757468AbbIVAC0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2015 20:02:26 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:36076 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756162AbbIVACZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2015 20:02:25 -0400
Received: by padbj2 with SMTP id bj2so5239178pad.3
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 17:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=LR10yIPekA6yxLFY2ps30CWYb2Biats3+AZJPZAiXe0=;
        b=eaqjs0v+XW/P9E9/9Z8KGdgoMWSytiBBWiQGsW5gLh8osbTH9WMSmQ2AvbpRAxFNTY
         ijc1JyiI8tRvAjQBVb8aZZvNkNSVBCP6JBhpwoeGxebknGqgVAEO5qYAa726QkrKIo76
         cSeY2SZ96ZZMOLJgHJBitRhGODPkuTN1HF8uVkTpkxfxAaZ9T3BKOkPgJp0NrueUd/8s
         l22gX+wMviWZDZKdL+luw0xDO+/U3ycEWj60lzWlKGQiIhLyvOBfhGhGuIfXKt6pY2pa
         iGql2thhKZmPMELljptDMD+jHBXiN7rUdmBNu0SvZ/T471/Gb0CD1FKE2Hx6dgZPPxpD
         r+mg==
X-Received: by 10.68.104.227 with SMTP id gh3mr28350864pbb.108.1442880145288;
        Mon, 21 Sep 2015 17:02:25 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:89f8:25c:a9fe:f701])
        by smtp.gmail.com with ESMTPSA id by1sm26819713pab.6.2015.09.21.17.02.24
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Mon, 21 Sep 2015 17:02:24 -0700 (PDT)
In-Reply-To: <1442875159-13027-4-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 21 Sep 2015 15:39:09 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278364>

Stefan Beller <sbeller@google.com> writes:

> This wrapper just restarts on EINTR, but not on EAGAIN like xread
> does. This gives less guarantees on the actual reading rather than
> on returning fast.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  git-compat-util.h |  1 +
>  wrapper.c         | 22 ++++++++++++++++++++++
>  2 files changed, 23 insertions(+)
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index c6d391f..9ccea85 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -718,6 +718,7 @@ extern void *xcalloc(size_t nmemb, size_t size);
>  extern void *xmmap(void *start, size_t length, int prot, int flags, int fd, off_t offset);
>  extern void *xmmap_gently(void *start, size_t length, int prot, int flags, int fd, off_t offset);
>  extern ssize_t xread(int fd, void *buf, size_t len);
> +extern ssize_t xread_nonblock(int fd, void *buf, size_t len);
>  extern ssize_t xwrite(int fd, const void *buf, size_t len);
>  extern ssize_t xpread(int fd, void *buf, size_t len, off_t offset);
>  extern int xdup(int fd);
> diff --git a/wrapper.c b/wrapper.c
> index 50267a4..54ce231 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -223,6 +223,28 @@ ssize_t xread(int fd, void *buf, size_t len)
>  }
>  
>  /*
> + * xread_nonblock() is the same a read(), but it automatically restarts read()
> + * interrupted operations (EINTR). xread_nonblock() DOES NOT GUARANTEE that
> + * "len" bytes is read even if the data is available.
> + */

This comment is somewhat misleading to readers who knew there was
xread() and this new one is a variant of it.  xread() does not say
anything about "if the data is available" (it just blocks and
insists reading that much if the data is not ready yet).  If we drop
the "even if ..." from the end, that confusion would be avoided.

Turning EWOULDBLOCK to EAGAIN is a very useful thing to help the
callers, and it deserves to be described in the above comment.

> +ssize_t xread_nonblock(int fd, void *buf, size_t len)
> +{
> +	ssize_t nr;
> +	if (len > MAX_IO_SIZE)
> +	    len = MAX_IO_SIZE;

This line is under-indented?

> +	while (1) {
> +		nr = read(fd, buf, len);
> +		if (nr < 0) {
> +			if (errno == EINTR)
> +				continue;
> +			if (errno == EWOULDBLOCK)
> +				errno = EAGAIN;
> +		}
> +		return nr;
> +	}
> +}
> +
> +/*
>   * xwrite() is the same a write(), but it automatically restarts write()
>   * operations with a recoverable error (EAGAIN and EINTR). xwrite() DOES NOT
>   * GUARANTEE that "len" bytes is written even if the operation is successful.

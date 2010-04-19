From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] Fix checkout of large files to network shares under Windows
 XP
Date: Mon, 19 Apr 2010 22:43:10 +0200
Message-ID: <4BCCC05E.4030206@lsrfire.ath.cx>
References: <4BCC5083.30801@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 19 22:43:34 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3xob-0006Tk-Sp
	for gcvg-git-2@lo.gmane.org; Mon, 19 Apr 2010 22:43:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178Ab0DSUn3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Apr 2010 16:43:29 -0400
Received: from india601.server4you.de ([85.25.151.105]:33998 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751030Ab0DSUn2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Apr 2010 16:43:28 -0400
Received: from [10.0.1.100] (p57B7D9FE.dip.t-dialin.net [87.183.217.254])
	by india601.server4you.de (Postfix) with ESMTPSA id 39BFD2F805A;
	Mon, 19 Apr 2010 22:43:16 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <4BCC5083.30801@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145327>

Am 19.04.2010 14:45, schrieb Sebastian Schuberth:
> This fixes msysGit issue 409, see
> http://code.google.com/p/msysgit/issues/detail?id=409
> 
> Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
> ---
>  compat/mingw.c |   24 ++++++++++++++++++++++++
>  compat/mingw.h |    3 +++
>  2 files changed, 27 insertions(+), 0 deletions(-)
> 
> diff --git a/compat/mingw.c b/compat/mingw.c
> index 7ec615c..672d074 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -293,6 +293,30 @@ int mingw_open (const char *filename, int oflags, ...)
>  	return fd;
>  }
>  
> +#undef write
> +ssize_t mingw_write(int fd, const void *buf, size_t count)
> +{
> +	ssize_t written = 0;
> +	size_t total = 0, size = count;
> +
> +	while (total < count && size > 0) {
> +		written = write(fd, buf, size);
> +		if (written < 0 && errno == EINVAL) {
> +			// There seems to be a bug in the Windows XP network stack that
> +			// causes writes with sizes > 64 MB to fail, so we halve the size
> +			// until we succeed or ultimately fail.

C style comments (/*...*/) are preferred over C++ style comments (//...)
for git.

Is there a known-good size, or at least a mostly-working one?  Would it
make sense to start with that size instead of halving and trying until
that size is reached?

> +			size /= 2;
> +		} else {
> +			buf += written;
> +			total += written;

What about other errors?  You need to break out of the loop instead of
adding -1 to buf and total, right?

> +			if (total + size > count)
> +				size = count - total;
> +		}
> +	}

Shouldn't the loop be left in the successful case, too?  write(2) is
allowed to write less than requested, so the caller already needs to
deal with that case anyway.

> +
> +	return written < 0 ? written : total;
> +}
> +
>  #undef fopen
>  FILE *mingw_fopen (const char *filename, const char *otype)
>  {
> diff --git a/compat/mingw.h b/compat/mingw.h
> index 756f3ab..751bb4c 100644
> --- a/compat/mingw.h
> +++ b/compat/mingw.h
> @@ -178,6 +178,9 @@ int mingw_rmdir(const char *path);
>  int mingw_open (const char *filename, int oflags, ...);
>  #define open mingw_open
>  
> +ssize_t mingw_write(int fd, const void *buf, size_t count);
> +#define write mingw_write
> +
>  FILE *mingw_fopen (const char *filename, const char *otype);
>  #define fopen mingw_fopen
>  

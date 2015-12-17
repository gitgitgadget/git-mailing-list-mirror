From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] mingw: emulate write(2) that fails with a EPIPE
Date: Thu, 17 Dec 2015 11:22:49 -0800
Message-ID: <xmqqwpscc22e.fsf@gitster.mtv.corp.google.com>
References: <01da36219c18373f8507e19035e141d7e56b2d18.1450267413.git.johannes.schindelin@gmx.de>
	<ca357ac83a9990d6c88b637b76c6cc7f30d3f7be.1450372051.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Dec 17 20:22:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9e8e-0008GC-V0
	for gcvg-git-2@plane.gmane.org; Thu, 17 Dec 2015 20:22:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752431AbbLQTWw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2015 14:22:52 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50789 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752482AbbLQTWv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2015 14:22:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D6B4F351B2;
	Thu, 17 Dec 2015 14:22:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=t454urhr9TqssFN4LPcG301rpzY=; b=f4kToL
	iv4dK1mE/L9nr9iOuyyIAPCBbt4lVuHTWsPMV2DaF6idFrr9Sug9flvLYpbR+42q
	hYfMnX8tBNhZMS8RUM6U5gTRjF7oZ497vrrIiIxFLbsZlCtMxlN9iUAC0sTpC60/
	QiCZwejALTpX/+mxLMlYn0TXdMKy78woU+xB4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VD+nQj5i1kFS64eDaN8IPOZJRiXQHTrx
	9AQvfURLlZL6Ey9gSraRzUxN4aAILZ6yFPYMaz7yyXj0Jqs0YBnvBX3D1LVelV9a
	LLyu96oK+YhsWJIcBhUgIqH0yA2VV1zKUGfie8k3Z5l8h6yAIlWHgQ3mcQUTO79Q
	UQprX/7jMD8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CBB8F351B1;
	Thu, 17 Dec 2015 14:22:50 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 43E77351B0;
	Thu, 17 Dec 2015 14:22:50 -0500 (EST)
In-Reply-To: <ca357ac83a9990d6c88b637b76c6cc7f30d3f7be.1450372051.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Thu, 17 Dec 2015 18:08:15 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8FE67A12-A4F3-11E5-B433-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282668>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> On Windows, when writing to a pipe fails, errno is always
> EINVAL. However, Git expects it to be EPIPE.
>
> According to the documentation, there are two cases in which write()
> triggers EINVAL: the buffer is NULL, or the length is odd but the mode
> is 16-bit Unicode (the broken pipe is not mentioned as possible cause).
> Git never sets the file mode to anything but binary, therefore we know
> that errno should actually be EPIPE if it is EINVAL and the buffer is
> not NULL.
>
> See https://msdn.microsoft.com/en-us/library/1570wh78.aspx for more
> details.
>
> This works around t5571.11 failing with v2.6.4 on Windows.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  compat/mingw.c | 17 +++++++++++++++++
>  compat/mingw.h |  3 +++
>  2 files changed, 20 insertions(+)
>
> diff --git a/compat/mingw.c b/compat/mingw.c
> index 90bdb1e..5edea29 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -394,6 +394,23 @@ int mingw_fflush(FILE *stream)
>  	return ret;
>  }
>  
> +#undef write
> +ssize_t mingw_write(int fd, const void *buf, size_t len)
> +{
> +	ssize_t result = write(fd, buf, len);
> +
> +	if (result < 0 && errno == EINVAL && buf) {
> +		/* check if fd is a pipe */
> +		HANDLE h = (HANDLE) _get_osfhandle(fd);
> +		if (GetFileType(h) == FILE_TYPE_PIPE)
> +			errno = EPIPE;
> +		else
> +			errno = EINVAL;
> +	}
> +
> +	return result;
> +}
> +
>  int mingw_access(const char *filename, int mode)
>  {
>  	wchar_t wfilename[MAX_PATH];
> diff --git a/compat/mingw.h b/compat/mingw.h
> index 738865c..57ca477 100644
> --- a/compat/mingw.h
> +++ b/compat/mingw.h
> @@ -210,6 +210,9 @@ FILE *mingw_freopen (const char *filename, const char *otype, FILE *stream);
>  int mingw_fflush(FILE *stream);
>  #define fflush mingw_fflush
>  
> +ssize_t mingw_write(int fd, const void *buf, size_t len);
> +#define write mingw_write
> +
>  int mingw_access(const char *filename, int mode);
>  #undef access
>  #define access mingw_access


PLEASE DON'T DO THE BELOW TO THE SAME MESSAGE AS THE PATCH ITSELF.
"git apply" would not read and understand the next line as a natural
language sentence for obvious reasons.

> Interdiff vs v1:
>
> diff --git a/compat/mingw.c b/compat/mingw.c
> index 90bdb1e..5edea29 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -394,6 +394,23 @@ int mingw_fflush(FILE *stream)
>  	return ret;
>  }
>  
> +#undef write
> +ssize_t mingw_write(int fd, const void *buf, size_t len)
> +{
> +	ssize_t result = write(fd, buf, len);
> +
> +	if (result < 0 && errno == EINVAL && buf) {
> +		/* check if fd is a pipe */
> +		HANDLE h = (HANDLE) _get_osfhandle(fd);
> +		if (GetFileType(h) == FILE_TYPE_PIPE)
> +			errno = EPIPE;
> +		else
> +			errno = EINVAL;
> +	}
> +
> +	return result;
> +}
> +
>  int mingw_access(const char *filename, int mode)
>  {
>  	wchar_t wfilename[MAX_PATH];
> diff --git a/compat/mingw.h b/compat/mingw.h
> index 2aca347..57ca477 100644
> --- a/compat/mingw.h
> +++ b/compat/mingw.h
> @@ -210,22 +210,7 @@ FILE *mingw_freopen (const char *filename, const char *otype, FILE *stream);
>  int mingw_fflush(FILE *stream);
>  #define fflush mingw_fflush
>  
> -static inline ssize_t mingw_write(int fd, const void *buf, size_t len)
> -{
> -	ssize_t result = write(fd, buf, len);
> -
> -	if (result < 0 && errno == EINVAL && buf) {
> -		/* check if fd is a pipe */
> -		HANDLE h = (HANDLE) _get_osfhandle(fd);
> -		if (GetFileType(h) == FILE_TYPE_PIPE)
> -			errno = EPIPE;
> -		else
> -			errno = EINVAL;
> -	}
> -
> -	return result;
> -}
> -
> +ssize_t mingw_write(int fd, const void *buf, size_t len);
>  #define write mingw_write
>  
>  int mingw_access(const char *filename, int mode);

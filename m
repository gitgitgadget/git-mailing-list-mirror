From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2] mingw: emulate write(2) that fails with a EPIPE
Date: Fri, 18 Dec 2015 21:57:14 +0100
Message-ID: <5674732A.3050104@kdbg.org>
References: <01da36219c18373f8507e19035e141d7e56b2d18.1450267413.git.johannes.schindelin@gmx.de>
 <ca357ac83a9990d6c88b637b76c6cc7f30d3f7be.1450372051.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Dec 18 21:57:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aA25u-00023C-Og
	for gcvg-git-2@plane.gmane.org; Fri, 18 Dec 2015 21:57:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965093AbbLRU5T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Dec 2015 15:57:19 -0500
Received: from bsmtp8.bon.at ([213.33.87.20]:22524 "EHLO bsmtp8.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933011AbbLRU5S (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Dec 2015 15:57:18 -0500
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp8.bon.at (Postfix) with ESMTPSA id 3pMjDq5Q2dz5tlJ;
	Fri, 18 Dec 2015 21:57:15 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 1246753B4;
	Fri, 18 Dec 2015 21:57:15 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
In-Reply-To: <ca357ac83a9990d6c88b637b76c6cc7f30d3f7be.1450372051.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282715>

Am 17.12.2015 um 18:08 schrieb Johannes Schindelin:
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
>   compat/mingw.c | 17 +++++++++++++++++
>   compat/mingw.h |  3 +++
>   2 files changed, 20 insertions(+)
>
> diff --git a/compat/mingw.c b/compat/mingw.c
> index 90bdb1e..5edea29 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -394,6 +394,23 @@ int mingw_fflush(FILE *stream)
>   	return ret;
>   }
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
>   int mingw_access(const char *filename, int mode)
>   {
>   	wchar_t wfilename[MAX_PATH];

Looks good. I tested the patch, and it fixes the failure exposed by 
t5571.11.

Acked-by: Johannes Sixt <j6t@kdbg.org>

Thanks!

-- Hannes

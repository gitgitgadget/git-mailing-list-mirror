From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2] Mark win32's pthread_exit() as NORETURN
Date: Tue, 1 Mar 2016 20:34:58 +0100
Message-ID: <56D5EEE2.3080100@kdbg.org>
References: <69eef72cfc77e62ad7ad17c6df5f2d2396c64991.1456840324.git.johannes.schindelin@gmx.de>
 <d584d8bdaa8645a406c96f2a11f04febf57b2c25.1456841593.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
To: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 20:35:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaq4b-0002Xw-FJ
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 20:35:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751624AbcCATfD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 14:35:03 -0500
Received: from bsmtp8.bon.at ([213.33.87.20]:55249 "EHLO bsmtp8.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751187AbcCATfC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 14:35:02 -0500
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp8.bon.at (Postfix) with ESMTPSA id 3qF7vl3k9Tz5tlM;
	Tue,  1 Mar 2016 20:34:59 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 4B7D251EA;
	Tue,  1 Mar 2016 20:34:58 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <d584d8bdaa8645a406c96f2a11f04febf57b2c25.1456841593.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288057>

Am 01.03.2016 um 15:13 schrieb Johannes Schindelin:
> The pthread_exit() function is not expected to return. Ever. On Windows,
> we call ExitThread() whose documentation claims: "This function does not
> return a value.":
>
> 	https://msdn.microsoft.com/en-us/library/windows/desktop/ms682659

This is misleading: MSDN marks all functions declared void as "does not 
return a value," for example, look at EnterCriticalSection:

https://msdn.microsoft.com/en-us/library/windows/desktop/ms682608

For this reason, I actually prefer your version 1 patch without the 
explanation.

>
> Pointed out by Jeff King.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>
> 	Relative to v1, only the commit message changed (to clarify that
> 	ExitThread() indeed never returns).
>
>   compat/win32/pthread.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/compat/win32/pthread.h b/compat/win32/pthread.h
> index 20b35a2..148db60 100644
> --- a/compat/win32/pthread.h
> +++ b/compat/win32/pthread.h
> @@ -78,7 +78,7 @@ extern int win32_pthread_join(pthread_t *thread, void **value_ptr);
>   #define pthread_equal(t1, t2) ((t1).tid == (t2).tid)
>   extern pthread_t pthread_self(void);
>
> -static inline int pthread_exit(void *ret)
> +static inline int NORETURN pthread_exit(void *ret)

I would have written it as

#ifdef __GNUC__
__attribute__((__noreturn__))
#endif
static inline int pthread_exit(void *ret) ...

but I can live with your version as long as it compiles.

Your solution is pragmatic: NORETURN is defined in git-compat-util.h, 
and by using it here, we depend on that pthread.h is included 
sufficiently late that the macro is available at this point. The 
instance in compat/nedmalloc/malloc.c.h is bracketed with #ifndef WIN32 
so that it is not compiled on Windows, all other instances are after 
git-compat-util.h or cache.h or in headers that are to be included only 
after git-compat-util.h or cache.h per convention. Looks like we are safe.

>   {
>   	ExitThread((DWORD)(intptr_t)ret);
>   }
>

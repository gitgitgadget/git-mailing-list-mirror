Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C5838F922
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 04:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790138521; cv=none; b=iayiCrGFxtM3/HXzW0xLBqWW8eH24xz5H3L+fmbJrrh77cvmOA38+OVBtqxGa0ZqDrkzdDSdDP7IgK7UH2iczWNXJBYe2w7V7+8thDWrmhSCDcCRxXizEdVhhl+bGxoev+ifRNOeBri8SdyqP3VhPK3pYz1GzWmqBlAVbGryTJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790138521; c=relaxed/simple;
	bh=byVqvzMajVlOLn+qVlCMWPL9pGcMsb0rJkHaDiIJUsE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rq2t8kcDo+pWozRqMPIMB29HMzVPrNy70hhHEnA/hY1AKz8aWaSOLsu1pCvAXUm1/T/gasQ5Ysx73Ok2hq3z+0QIUY7wP4jGsiGoqx2g1AgWSRJj1FTW9aqRu570p09v2hmU0qTr6GGDKCptROIGrNE62vp29yhMVms+GafZ/v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.100] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4hqPSW6MW2zRnlV;
	Wed, 23 Sep 2026 06:41:47 +0200 (CEST)
Message-ID: <3e2befed-355b-4a82-af82-25dedaee0565@kdbg.org>
Date: Wed, 23 Sep 2026 06:41:47 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] compat/winansi: fix die_lasterr() argument formatting
To: Yongqiang Tian <yqtian668@gmail.com>
Cc: ps@pks.im, l.s.r@web.de, git@vger.kernel.org
References: <20260916042312.35891-1-yqtian668@gmail.com>
 <20260921062114.14450-1-yqtian668@gmail.com>
 <20260921234756.77997-1-yqtian668@gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20260921234756.77997-1-yqtian668@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 22.09.26 um 01:47 schrieb Yongqiang Tian:
> During WinANSI initialization, duplicate_handle() reports the handle
> when DuplicateHandle() fails. die_lasterr() collects the formatting
> arguments in a va_list, but passes that va_list to die_errno() as an
> ordinary variadic argument. die_errno() consequently formats part of
> the va_list representation instead of the supplied handle, producing
> an incorrect fatal message.
> 
> The helper also converts GetLastError() to errno, losing the exact
> Windows error code.
> 
> Remove die_lasterr() and report GetLastError() directly at its four
> call sites, following the existing Windows diagnostic style. This
> passes the handle to the formatter correctly and preserves the Windows
> error code. Keep the existing %li representation of the handle.
> 
> Helped-by: Johannes Sixt <j6t@kdbg.org>
> Helped-by: René Scharfe <l.s.r@web.de>
> Signed-off-by: Yongqiang Tian <yqtian668@gmail.com>
> ---
> 
> Changes since v2:
> - Add Helped-by trailers for Johannes Sixt and René Scharfe.
> - Move build validation details below the separator.
> - No code changes.

This round looks very good now. I tested it and it works as desired.
Thanks! FWIW:

Acked-by: Johannes Sixt <j6t@kdbg.org>

> 
> Validation (performed for v2; the code is unchanged):
> - Built compat/winansi.o with DEVELOPER=1 using MinGW GCC 13.
> - Built and linked the complete git.exe.
> 
>  compat/winansi.c | 19 +++++--------------
>  1 file changed, 5 insertions(+), 14 deletions(-)
> 
> diff --git a/compat/winansi.c b/compat/winansi.c
> index 3ce1900939..088734a1df 100644
> --- a/compat/winansi.c
> +++ b/compat/winansi.c
> @@ -436,15 +436,6 @@ static void winansi_exit(void)
>  	CloseHandle(hthread);
>  }
>  
> -static void die_lasterr(const char *fmt, ...)
> -{
> -	va_list params;
> -	va_start(params, fmt);
> -	errno = err_win_to_posix(GetLastError());
> -	die_errno(fmt, params);
> -	va_end(params);
> -}
> -
>  #undef dup2
>  int winansi_dup2(int oldfd, int newfd)
>  {
> @@ -462,8 +453,8 @@ static HANDLE duplicate_handle(HANDLE hnd)
>  	HANDLE hresult, hproc = GetCurrentProcess();
>  	if (!DuplicateHandle(hproc, hnd, hproc, &hresult, 0, TRUE,
>  			DUPLICATE_SAME_ACCESS))
> -		die_lasterr("DuplicateHandle(%li) failed",
> -			(long) (intptr_t) hnd);
> +		die("DuplicateHandle(%li) failed: %lu",
> +		    (long) (intptr_t) hnd, GetLastError());
>  	return hresult;
>  }
>  
> @@ -609,16 +600,16 @@ void winansi_init(void)
>  	hwrite = CreateNamedPipeW(name, PIPE_ACCESS_OUTBOUND,
>  		PIPE_TYPE_BYTE | PIPE_WAIT, 1, BUFFER_SIZE, 0, 0, NULL);
>  	if (hwrite == INVALID_HANDLE_VALUE)
> -		die_lasterr("CreateNamedPipe failed");
> +		die("CreateNamedPipe failed: %lu", GetLastError());
>  
>  	hread = CreateFileW(name, GENERIC_READ, 0, NULL, OPEN_EXISTING, 0, NULL);
>  	if (hread == INVALID_HANDLE_VALUE)
> -		die_lasterr("CreateFile for named pipe failed");
> +		die("CreateFile for named pipe failed: %lu", GetLastError());
>  
>  	/* start console spool thread on the pipe's read end */
>  	hthread = CreateThread(NULL, 0, console_thread, NULL, 0, NULL);
>  	if (!hthread)
> -		die_lasterr("CreateThread(console_thread) failed");
> +		die("CreateThread(console_thread) failed: %lu", GetLastError());
>  
>  	/* schedule cleanup routine */
>  	if (atexit(winansi_exit))


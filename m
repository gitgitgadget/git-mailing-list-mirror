Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 146481F404
	for <e@80x24.org>; Mon, 10 Sep 2018 19:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbeIKAks (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Sep 2018 20:40:48 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:49665 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728110AbeIKAkr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Sep 2018 20:40:47 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 428JRP67myz5tlR;
        Mon, 10 Sep 2018 21:45:05 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 8B66E2E3D;
        Mon, 10 Sep 2018 21:45:05 +0200 (CEST)
From:   Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 2/2] mingw: fix mingw_open_append to work with named
 pipes
To:     jeffhost@microsoft.com
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <pull.35.git.gitgitgadget@gmail.com>
 <pull.35.v2.git.gitgitgadget@gmail.com>
 <f0361dd306d19fa741c813885d240e041dc09a7a.1536599118.git.gitgitgadget@gmail.com>
X-Mozilla-News-Host: news://nntp.gmane.org
Message-ID: <a309396f-bb33-477d-5d92-a98699f5a856@kdbg.org>
Date:   Mon, 10 Sep 2018 21:45:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <f0361dd306d19fa741c813885d240e041dc09a7a.1536599118.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.09.18 um 19:05 schrieb Jeff Hostetler via GitGitGadget:
> diff --git a/compat/mingw.c b/compat/mingw.c
> index 858ca14a57..f87376b26a 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -341,6 +341,19 @@ int mingw_mkdir(const char *path, int mode)
>   	return ret;
>   }
>   
> +/*
> + * Calling CreateFile() using FILE_APPEND_DATA and without FILE_WRITE_DATA
> + * is documented in [1] as opening a writable file handle in append mode.
> + * (It is believed that) this is atomic since it is maintained by the
> + * kernel unlike the O_APPEND flag which is racily maintained by the CRT.
> + *
> + * [1] https://docs.microsoft.com/en-us/windows/desktop/fileio/file-access-rights-constants
> + *
> + * This trick does not appear to work for named pipes.  Instead it creates
> + * a named pipe client handle that cannot be written to.  Callers should
> + * just use the regular _wopen() for them.  (And since client handle gets
> + * bound to a unique server handle, it isn't really an issue.)
> + */
>   static int mingw_open_append(wchar_t const *wfilename, int oflags, ...)
>   {
>   	HANDLE handle;
> @@ -360,10 +373,12 @@ static int mingw_open_append(wchar_t const *wfilename, int oflags, ...)
>   			NULL, create, FILE_ATTRIBUTE_NORMAL, NULL);
>   	if (handle == INVALID_HANDLE_VALUE)
>   		return errno = err_win_to_posix(GetLastError()), -1;
> +
>   	/*
>   	 * No O_APPEND here, because the CRT uses it only to reset the
> -	 * file pointer to EOF on write(); but that is not necessary
> -	 * for a file created with FILE_APPEND_DATA.
> +	 * file pointer to EOF before each write(); but that is not
> +	 * necessary (and may lead to races) for a file created with
> +	 * FILE_APPEND_DATA.
>   	 */
>   	fd = _open_osfhandle((intptr_t)handle, O_BINARY);
>   	if (fd < 0)
> @@ -371,6 +386,23 @@ static int mingw_open_append(wchar_t const *wfilename, int oflags, ...)
>   	return fd;
>   }
>   
> +#define IS_SBS(ch) (((ch) == '/') || ((ch) == '\\'))
> +/*
> + * Does the pathname map to the local named pipe filesystem?
> + * That is, does it have a "//./pipe/" prefix?
> + */
> +static int mingw_is_local_named_pipe_path(const char *filename)
> +{
> +	return (IS_SBS(filename[0]) &&
> +		IS_SBS(filename[1]) &&
> +		filename[2] == '.'  &&
> +		IS_SBS(filename[3]) &&
> +		!strncasecmp(filename+4, "pipe", 4) &&
> +		IS_SBS(filename[8]) &&
> +		filename[9]);
> +}
> +#undef IS_SBS
> +
>   int mingw_open (const char *filename, int oflags, ...)
>   {
>   	typedef int (*open_fn_t)(wchar_t const *wfilename, int oflags, ...);
> @@ -387,7 +419,7 @@ int mingw_open (const char *filename, int oflags, ...)
>   	if (filename && !strcmp(filename, "/dev/null"))
>   		filename = "nul";
>   
> -	if (oflags & O_APPEND)
> +	if ((oflags & O_APPEND) && !mingw_is_local_named_pipe_path(filename))
>   		open_fn = mingw_open_append;
>   	else
>   		open_fn = _wopen;

This looks reasonable.

I wonder which part of the code uses local named pipes. Is it downstream 
in Git for Windows or one of the topics in flight?

-- Hannes

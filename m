Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E93C27C76
	for <git@archiver.kernel.org>; Sat, 21 Jan 2023 22:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjAUWxd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Jan 2023 17:53:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjAUWxc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jan 2023 17:53:32 -0500
Received: from bsmtp2.bon.at (bsmtp2.bon.at [213.33.87.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAAD925E37
        for <git@vger.kernel.org>; Sat, 21 Jan 2023 14:53:29 -0800 (PST)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 4Nzs921BYpz5tl9;
        Sat, 21 Jan 2023 23:53:25 +0100 (CET)
Message-ID: <b516a0a0-6802-2a06-597b-0837a89be9da@kdbg.org>
Date:   Sat, 21 Jan 2023 23:53:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] win32: fix thread usage for win32
To:     Rose via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Seija Kijin <doremylover123@gmail.com>, git@vger.kernel.org
References: <pull.1440.git.git.1674334159116.gitgitgadget@gmail.com>
Content-Language: en-US
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <pull.1440.git.git.1674334159116.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 21.01.23 um 21:49 schrieb Rose via GitGitGadget:
> From: Seija Kijin <doremylover123@gmail.com>
> 
> Use pthread_exit instead of async_exit.
> 
> This means we do not have
> to deal with Windows's implementation
> requiring an unsigned exit coded
> despite the POSIX exit code requiring
> a signed exit code.
> 
> Use _beginthreadex instead of CreateThread
> since we use the Windows CRT.
> 
> Finally, check for NULL handles, not "INVALID_HANDLE,"
> as _beginthreadex guarantees a valid handle in most cases

This explains *what* the patch does, but not *why*. You replace
CreateThread() in winansi.c, but what has this to do with async_exit and
why must it be changed?

Please take the time to explain this story more thoroughly.

> 
> Signed-off-by: Seija Kijin <doremylover123@gmail.com>
> ---
>     win32: fix thread usage for win32
>     
>     Use pthread_exit instead of async_exit.
>     
>     This means we do not have to deal with Windows's implementation
>     requiring an unsigned exit coded despite the POSIX exit code requiring a
>     signed exit code.
>     
>     Use _beginthreadex instead of CreateThread since we use the Windows CRT.
>     
>     Finally, check for NULL handles, not "INVALID_HANDLE," as _beginthreadex
>     guarantees a valid handle in most cases
>     
>     Signed-off-by: Seija Kijin doremylover123@gmail.com
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1440%2FAtariDreams%2FCreateThread-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1440/AtariDreams/CreateThread-v1
> Pull-Request: https://github.com/git/git/pull/1440
> 
>  compat/mingw.c   |  2 +-
>  compat/winansi.c |  8 ++++----
>  run-command.c    | 33 ++++++++++++++-------------------
>  3 files changed, 19 insertions(+), 24 deletions(-)
> 
> diff --git a/compat/mingw.c b/compat/mingw.c
> index af397e68a1d..c41d821b382 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -2295,7 +2295,7 @@ static int start_timer_thread(void)
>  	timer_event = CreateEvent(NULL, FALSE, FALSE, NULL);
>  	if (timer_event) {
>  		timer_thread = (HANDLE) _beginthreadex(NULL, 0, ticktack, NULL, 0, NULL);
> -		if (!timer_thread )
> +		if (!timer_thread)
>  			return errno = ENOMEM,
>  				error("cannot start timer thread");
>  	} else
> diff --git a/compat/winansi.c b/compat/winansi.c
> index 3abe8dd5a27..be65b27bd75 100644
> --- a/compat/winansi.c
> +++ b/compat/winansi.c
> @@ -340,7 +340,7 @@ enum {
>  	TEXT = 0, ESCAPE = 033, BRACKET = '['
>  };
>  
> -static DWORD WINAPI console_thread(LPVOID unused)
> +static unsigned int WINAPI console_thread(LPVOID unused)
>  {
>  	unsigned char buffer[BUFFER_SIZE];
>  	DWORD bytes;
> @@ -643,9 +643,9 @@ void winansi_init(void)
>  		die_lasterr("CreateFile for named pipe failed");
>  
>  	/* start console spool thread on the pipe's read end */
> -	hthread = CreateThread(NULL, 0, console_thread, NULL, 0, NULL);
> -	if (hthread == INVALID_HANDLE_VALUE)
> -		die_lasterr("CreateThread(console_thread) failed");
> +	hthread = (HANDLE)_beginthreadex(NULL, 0, console_thread, NULL, 0, NULL);
> +	if (!hthread)
> +		die_lasterr("_beginthreadex(console_thread) failed");
>  
>  	/* schedule cleanup routine */
>  	if (atexit(winansi_exit))
> diff --git a/run-command.c b/run-command.c
> index 50cc011654e..93fd0d22d4f 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -1030,6 +1030,13 @@ static void *run_thread(void *data)
>  	return (void *)ret;
>  }
>  
> +int in_async(void)
> +{
> +	if (!main_thread_set)
> +		return 0; /* no asyncs started yet */
> +	return !pthread_equal(main_thread, pthread_self());
> +}
> +
>  static NORETURN void die_async(const char *err, va_list params)
>  {
>  	report_fn die_message_fn = get_die_message_routine();
> @@ -1055,18 +1062,6 @@ static int async_die_is_recursing(void)
>  	return ret != NULL;
>  }
>  
> -int in_async(void)
> -{
> -	if (!main_thread_set)
> -		return 0; /* no asyncs started yet */
> -	return !pthread_equal(main_thread, pthread_self());
> -}
> -
> -static void NORETURN async_exit(int code)
> -{
> -	pthread_exit((void *)(intptr_t)code);
> -}
> -
>  #else
>  
>  static struct {
> @@ -1112,18 +1107,18 @@ int in_async(void)
>  	return process_is_async;
>  }
>  
> -static void NORETURN async_exit(int code)
> -{
> -	exit(code);
> -}
> -
>  #endif
>  
>  void check_pipe(int err)
>  {
>  	if (err == EPIPE) {
> -		if (in_async())
> -			async_exit(141);
> +		if (in_async()) {
> +#ifdef NO_PTHREADS
> +			exit(141);
> +#else
> +			pthread_exit((void *)141);
> +#endif
> +		}
>  
>  		signal(SIGPIPE, SIG_DFL);
>  		raise(SIGPIPE);
> 
> base-commit: 904d404274fef6695c78a6b055edd184b72e2f9b


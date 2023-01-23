Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57368C05027
	for <git@archiver.kernel.org>; Mon, 23 Jan 2023 17:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbjAWRoH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Jan 2023 12:44:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjAWRoG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2023 12:44:06 -0500
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F3D2B087
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 09:44:05 -0800 (PST)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 045F6CA1253;
        Mon, 23 Jan 2023 12:44:05 -0500 (EST)
Received: from [192.168.4.22] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id AB001CC83BB;
        Mon, 23 Jan 2023 12:44:04 -0500 (EST)
Message-ID: <9e75f76b-081c-c763-0fae-edd6d97fbc88@jeffhostetler.com>
Date:   Mon, 23 Jan 2023 12:43:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH v4] win32: fix thread usage for win32
Content-Language: en-US
To:     Rose via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Rose <83477269+AtariDreams@users.noreply.github.com>,
        Seija Kijin <doremylover123@gmail.com>
References: <pull.1440.v3.git.git.1674492373925.gitgitgadget@gmail.com>
 <pull.1440.v4.git.git.1674492499537.gitgitgadget@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
In-Reply-To: <pull.1440.v4.git.git.1674492499537.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: mailmunge 3.10 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 1/23/23 11:48 AM, Rose via GitGitGadget wrote:
> From: Seija Kijin <doremylover123@gmail.com>
> 
> Use _beginthreadex instead of CreateThread
> since we use the Windows CRT,
> as Microsoft recommends _beginthreadex
> over CreateThread for these situations.
> 
> Finally, check for NULL handles, not "INVALID_HANDLE,"
> as _beginthreadex guarantees a valid handle in most cases
> 
> Signed-off-by: Seija Kijin <doremylover123@gmail.com>
> ---
>      win32: fix thread usage for win32
>      
>      Use pthread_exit instead of async_exit.
>      
>      This means we do not have to deal with Windows's implementation
>      requiring an unsigned exit coded despite the POSIX exit code requiring a
>      signed exit code.
>      
>      Use _beginthreadex instead of CreateThread since we use the Windows CRT.
>      
>      Finally, check for NULL handles, not "INVALID_HANDLE," as _beginthreadex
>      guarantees a valid handle in most cases
>      
>      Signed-off-by: Seija Kijin doremylover123@gmail.com
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1440%2FAtariDreams%2FCreateThread-v4
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1440/AtariDreams/CreateThread-v4
> Pull-Request: https://github.com/git/git/pull/1440
> 
> Range-diff vs v3:
> 
>   1:  68baafba2bd ! 1:  2e2d5ce7745 win32: fix thread usage for win32
>       @@ Commit message
>        
>            Signed-off-by: Seija Kijin <doremylover123@gmail.com>
>        
>       - ## compat/mingw.c ##
>       -@@ compat/mingw.c: static int start_timer_thread(void)
>       - 	timer_event = CreateEvent(NULL, FALSE, FALSE, NULL);
>       - 	if (timer_event) {
>       - 		timer_thread = (HANDLE) _beginthreadex(NULL, 0, ticktack, NULL, 0, NULL);
>       --		if (!timer_thread )
>       -+		if (!timer_thread)
>       - 			return errno = ENOMEM,
>       - 				error("cannot start timer thread");
>       - 	} else
>       -
>         ## compat/winansi.c ##
>        @@ compat/winansi.c: enum {
>         	TEXT = 0, ESCAPE = 033, BRACKET = '['
> 
> 
>   compat/winansi.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/compat/winansi.c b/compat/winansi.c
> index 3abe8dd5a27..be65b27bd75 100644
> --- a/compat/winansi.c
> +++ b/compat/winansi.c
> @@ -340,7 +340,7 @@ enum {
>   	TEXT = 0, ESCAPE = 033, BRACKET = '['
>   };
>   
> -static DWORD WINAPI console_thread(LPVOID unused)
> +static unsigned int WINAPI console_thread(LPVOID unused)
>   {
>   	unsigned char buffer[BUFFER_SIZE];
>   	DWORD bytes;
> @@ -643,9 +643,9 @@ void winansi_init(void)
>   		die_lasterr("CreateFile for named pipe failed");
>   
>   	/* start console spool thread on the pipe's read end */
> -	hthread = CreateThread(NULL, 0, console_thread, NULL, 0, NULL);
> -	if (hthread == INVALID_HANDLE_VALUE)
> -		die_lasterr("CreateThread(console_thread) failed");
> +	hthread = (HANDLE)_beginthreadex(NULL, 0, console_thread, NULL, 0, NULL);
> +	if (!hthread)
> +		die_lasterr("_beginthreadex(console_thread) failed");
>   
>   	/* schedule cleanup routine */
>   	if (atexit(winansi_exit))
> 
> base-commit: 56c8fb1e95377900ec9d53c07886022af0a5d3c2

This change may or may not be harmless, but it scares me
because it is possibly a very subtle change and is being
made for an unknown reason -- is there a problem being
fixed here?  Or is this just churn for the sake of churn
to avoid an awkward cast of the return code?

What does _beginthreadex() specifically do that we need
it to do for us?

_beginthreadex() does some CRT init and then calls CreateThread(),
so what are we missing by calling CreateThread() directly?

The code in question is 11+ years old and it hasn't been a
problem (right?), so I have to wonder what value do we get
from this change.

The containing function here is setting up a special console
thread and named pipe to access the console, so I doubt that
any of the tests in the test suite actually would actually
exercise this change (since the tests aren't interactive).

The low-level Windows startup code is very tricky and sensitive
(and we need to test with both GCC's CRT and MSVC's CRT).
As I said earlier, the change may or may not be harmless, but
I question the need for it.

Jeff



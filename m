Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7C481FF40
	for <e@80x24.org>; Fri, 16 Dec 2016 17:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755151AbcLPRsF (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Dec 2016 12:48:05 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:26383 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754552AbcLPRsE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2016 12:48:04 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3tgHpV2N3jz5tlH;
        Fri, 16 Dec 2016 18:48:02 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 4A9461E70;
        Fri, 16 Dec 2016 18:48:01 +0100 (CET)
Subject: Re: [PATCH 1/1] mingw: intercept isatty() to handle /dev/null as Git
 expects it
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
References: <cover.1481454992.git.johannes.schindelin@gmx.de>
 <42ddc270ea04e01e899cc479063e5d602e4a4448.1481454992.git.johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Pranit Bauva <pranit.bauva@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <129f000c-49c1-0e75-26b3-c96e9b442443@kdbg.org>
Date:   Fri, 16 Dec 2016 18:48:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <42ddc270ea04e01e899cc479063e5d602e4a4448.1481454992.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 11.12.2016 um 12:16 schrieb Johannes Schindelin:
> When Git's source code calls isatty(), it really asks whether the
> respective file descriptor is connected to an interactive terminal.
>
> Windows' _isatty() function, however, determines whether the file
> descriptor is associated with a character device. And NUL, Windows'
> equivalent of /dev/null, is a character device.
>
> Which means that for years, Git mistakenly detected an associated
> interactive terminal when being run through the test suite, which
> almost always redirects stdin, stdout and stderr to /dev/null.
>
> This bug only became obvious, and painfully so, when the new
> bisect--helper entered the `pu` branch and made the automatic build & test
> time out because t6030 was waiting for an answer.
>
> For details, see
>
> 	https://msdn.microsoft.com/en-us/library/f4s0ddew.aspx
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  compat/mingw.h   |  3 +++
>  compat/winansi.c | 33 +++++++++++++++++++++++++++++++++
>  2 files changed, 36 insertions(+)
>
> diff --git a/compat/mingw.h b/compat/mingw.h
> index 034fff9479..3350169555 100644
> --- a/compat/mingw.h
> +++ b/compat/mingw.h
> @@ -384,6 +384,9 @@ int mingw_raise(int sig);
>   * ANSI emulation wrappers
>   */
>
> +int winansi_isatty(int fd);
> +#define isatty winansi_isatty
> +
>  void winansi_init(void);
>  HANDLE winansi_get_osfhandle(int fd);
>
> diff --git a/compat/winansi.c b/compat/winansi.c
> index db4a5b0a37..cb725fb02f 100644
> --- a/compat/winansi.c
> +++ b/compat/winansi.c
> @@ -7,6 +7,9 @@
>  #include <wingdi.h>
>  #include <winreg.h>
>
> +/* In this file, we actually want to use Windows' own isatty(). */
> +#undef isatty
> +
>  /*
>   ANSI codes used by git: m, K
>
> @@ -570,6 +573,36 @@ static void detect_msys_tty(int fd)
>
>  #endif
>
> +int winansi_isatty(int fd)
> +{
> +	int res = isatty(fd);
> +
> +	if (res) {
> +		/*
> +		 * Make sure that /dev/null is not fooling Git into believing
> +		 * that we are connected to a terminal, as "_isatty() returns a
> +		 * nonzero value if the descriptor is associated with a
> +		 * character device."; for more information, see
> +		 *
> +		 * https://msdn.microsoft.com/en-us/library/f4s0ddew.aspx
> +		 */
> +		HANDLE handle = (HANDLE)_get_osfhandle(fd);
> +		if (fd == STDIN_FILENO) {
> +			DWORD dummy;
> +
> +			if (!GetConsoleMode(handle, &dummy))
> +				res = 0;
> +		} else if (fd == STDOUT_FILENO || fd == STDERR_FILENO) {
> +			CONSOLE_SCREEN_BUFFER_INFO dummy;
> +
> +			if (!GetConsoleScreenBufferInfo(handle, &dummy))
> +				res = 0;

I am sorry to have to report that this check does not work as expected. 
I am operating Git from CMD, not mintty, BTW.

It fails with GetLastError() == 6 (invalid handle value). The reason for 
this is, I think, that in reality we are not writing to the console 
directly, but to a pipe, which is drained by console_thread(), which 
writes to the console.

I have little clue what this winansi.c file is doing. Do you have any 
pointers where I should start digging?

Wait...

Should we not use winansi_get_osfhandle() instead of _get_osfhandle()?

> +		}
> +	}
> +
> +	return res;
> +}
> +
>  void winansi_init(void)
>  {
>  	int con1, con2;
>


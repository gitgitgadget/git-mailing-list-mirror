Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A81F31FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 19:35:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753840AbcLSTee (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 14:34:34 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:60147 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753357AbcLSTed (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 14:34:33 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3tjB1z1wcPz5tlQ;
        Mon, 19 Dec 2016 20:34:31 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id A01711E70;
        Mon, 19 Dec 2016 20:34:30 +0100 (CET)
Subject: Re: [PATCH] winansi_isatty(): fix when Git is used from CMD
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
References: <cover.1481454992.git.johannes.schindelin@gmx.de>
 <42ddc270ea04e01e899cc479063e5d602e4a4448.1481454992.git.johannes.schindelin@gmx.de>
 <129f000c-49c1-0e75-26b3-c96e9b442443@kdbg.org>
 <xmqqy3zfsq4q.fsf@gitster.mtv.corp.google.com>
 <5977e71d-da58-7cb0-bc69-343bb3a1341d@kdbg.org>
 <ffc6a7a0-4ae4-b755-0b09-5bcd7114a2e6@kdbg.org>
 <d661dbf1-9852-965a-2ca9-67d763115b9e@kdbg.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Pranit Bauva <pranit.bauva@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <3f06ea33-b4de-48b4-593e-239eb6e87dd4@kdbg.org>
Date:   Mon, 19 Dec 2016 20:34:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <d661dbf1-9852-965a-2ca9-67d763115b9e@kdbg.org>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 18.12.2016 um 16:37 schrieb Johannes Sixt:
> winansi.c is all about overriding MSVCRT's console handling. If we are
> connected to a console, then by the time isatty() is called (from
> outside the emulation layer), all handling of file descriptors 1 and 2
> is already outside MSVCRT's control. In particular, we have determined
> unambiguously whether a terminal is connected (see is_console()). I
> suggest to have the implementation below (on top of the patch I'm
> responding to).
>
> What do you think?

I thought a bit more about this approach, and I retract it. I think it 
does not work when Git is connected to an MSYS TTY, i.e., when the 
"console" is in reality the pipe that is detected in detect_msys_tty().

At the same time I wonder how your original winansi_isatty() could have 
worked: In this case, MSVCRT's isatty() would return 1 (because 
detect_msys_tty() has set things up that this happens), but then 
winansi_isatty() checks whether the handle underlying fd 0, 1 or 2 is a 
real Windows console. But it is not: it is a pipe. Am I missing something?

>
> diff --git a/compat/winansi.c b/compat/winansi.c
> index ba360be69b..1748d17777 100644
> --- a/compat/winansi.c
> +++ b/compat/winansi.c
> @@ -575,9 +575,8 @@ static void detect_msys_tty(int fd)
>
>  int winansi_isatty(int fd)
>  {
> -	int res = isatty(fd);
> -
> -	if (res) {
> +	switch (fd) {
> +	case 0:
>  		/*
>  		 * Make sure that /dev/null is not fooling Git into believing
>  		 * that we are connected to a terminal, as "_isatty() returns a
> @@ -586,21 +585,19 @@ int winansi_isatty(int fd)
>  		 *
>  		 * https://msdn.microsoft.com/en-us/library/f4s0ddew.aspx
>  		 */
> -		HANDLE handle = winansi_get_osfhandle(fd);
> -		if (fd == STDIN_FILENO) {
> +		{
> +			HANDLE handle = (HANDLE)_get_osfhandle(fd);
>  			DWORD dummy;
>
> -			if (!GetConsoleMode(handle, &dummy))
> -				res = 0;
> -		} else if (fd == STDOUT_FILENO || fd == STDERR_FILENO) {
> -			CONSOLE_SCREEN_BUFFER_INFO dummy;
> -
> -			if (!GetConsoleScreenBufferInfo(handle, &dummy))
> -				res = 0;
> +			return !!GetConsoleMode(handle, &dummy);
>  		}
> +	case 1:
> +		return !!hconsole1;
> +	case 2:
> +		return !!hconsole2;
>  	}
>
> -	return res;
> +	return isatty(fd);
>  }
>
>  void winansi_init(void)
>


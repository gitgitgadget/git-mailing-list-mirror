Return-Path: <SRS0=5D3W=ZY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F095C432C0
	for <git@archiver.kernel.org>; Mon,  2 Dec 2019 17:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E97D020848
	for <git@archiver.kernel.org>; Mon,  2 Dec 2019 17:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbfLBRfQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Dec 2019 12:35:16 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:33146 "EHLO bsmtp2.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727471AbfLBRfQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Dec 2019 12:35:16 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 47RXLl4KxGz5tlB;
        Mon,  2 Dec 2019 18:35:11 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 89F8C2093;
        Mon,  2 Dec 2019 18:35:10 +0100 (CET)
Subject: Re: [PATCH v3 0/2] Brown-bag fix on top of
 js/mingw-inherit-only-std-handles
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.480.v2.git.1575110200.gitgitgadget@gmail.com>
 <pull.480.v3.git.1575286409.gitgitgadget@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <a4ac4530-9b5c-3eb6-ada2-067c6ef73868@kdbg.org>
Date:   Mon, 2 Dec 2019 18:35:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <pull.480.v3.git.1575286409.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 02.12.19 um 12:33 schrieb Johannes Schindelin via GitGitGadget:
> Range-diff vs v2:
> 
>  1:  280b6d08a4 = 1:  280b6d08a4 mingw: do set `errno` correctly when trying to restrict handle inheritance
>  2:  c3dea00fb1 ! 2:  e04e1269b3 mingw: translate ERROR_SUCCESS to errno = 0
>      @@ -3,12 +3,15 @@
>           mingw: translate ERROR_SUCCESS to errno = 0

The subject line would have to be adjusted as well.

	mingw: forbid translating ERROR_SUCCESS to an errno value

or something.

>       
>           Johannes Sixt pointed out that the `err_win_to_posix()` function
>      -    mishandles `ERROR_SUCCESS`. This commit fixes that.
>      +    mishandles `ERROR_SUCCESS`: it maps it to `ENOSYS`.
>       
>      -    Technically, we try to only assign `errno` to the corresponding value of
>      -    `GetLastError()` (which translation is performed by that function) when
>      -    a Win32 API call failed, so this change is purely defensive and is not
>      -    expected to fix an existing bug in our code base.
>      +    The only purpose of this function is to map Win32 API errors to `errno`
>      +    ones, and there is actually no equivalent to `ERROR_SUCCESS`: the idea
>      +    of `errno` is that it will only be set in case of an error, and left
>      +    alone in case of success.
>      +
>      +    Therefore, as pointed out by Junio Hamano, it is a bug to call this
>      +    function when there was not even any error to map.
>       
>           Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>       
>      @@ -19,7 +22,7 @@
>        	case ERROR_SHARING_BUFFER_EXCEEDED: error = ENFILE; break;
>        	case ERROR_SHARING_VIOLATION: error = EACCES; break;
>        	case ERROR_STACK_OVERFLOW: error = ENOMEM; break;
>      -+	case ERROR_SUCCESS: error = 0; break;
>      ++	case ERROR_SUCCESS: BUG("err_win_to_posix() called without an error!");
>        	case ERROR_SWAPERROR: error = ENOENT; break;
>        	case ERROR_TOO_MANY_MODULES: error = EMFILE; break;
>        	case ERROR_TOO_MANY_OPEN_FILES: error = EMFILE; break;
> 

-- Hannes

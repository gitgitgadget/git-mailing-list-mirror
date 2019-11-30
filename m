Return-Path: <SRS0=RoqO=ZW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B886EC432C0
	for <git@archiver.kernel.org>; Sat, 30 Nov 2019 19:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 959BC2073C
	for <git@archiver.kernel.org>; Sat, 30 Nov 2019 19:14:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbfK3TOC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Nov 2019 14:14:02 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:10258 "EHLO bsmtp2.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727025AbfK3TOC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Nov 2019 14:14:02 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 47QLdd5Gz0z5tlB;
        Sat, 30 Nov 2019 20:13:57 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 8CB3C2093;
        Sat, 30 Nov 2019 20:13:56 +0100 (CET)
Subject: Re: [PATCH v2 0/2] Brown-bag fix on top of
 js/mingw-inherit-only-std-handles
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.480.git.1575063876.gitgitgadget@gmail.com>
 <pull.480.v2.git.1575110200.gitgitgadget@gmail.com>
 <xmqq5zj12qc2.fsf@gitster-ct.c.googlers.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <6beaf25f-1369-3e77-fd54-fdb5a1e63707@kdbg.org>
Date:   Sat, 30 Nov 2019 20:13:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <xmqq5zj12qc2.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 30.11.19 um 19:04 schrieb Junio C Hamano:
> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
>>  * We now assign errno only when the call to CreateProcessW() failed.
> 
> Meaning the global variable 'errno' is left as it was (instead of
> getting cleared) when a system call succeeds?  That I think is the
> correct behaviour people who use the variable expect.

I hope you mean people who read the code. You cannot possibly mean
developers who expect that the run-command API keeps errno unchanged if
the calls were successful. I'm pretty sure they do not provide such a
guarantee.

> 
>>  * For good measure, we teach the err_win_to_posix() function to translate 
>>    ERROR_SUCCESS into the errno value 0.
> 
> So, I am not sure if this is a good idea---who are the callers of
> this function and why do they call it?  I would imagine that a
> caller who makes a system call, upon seeing a failure from the
> system call, calls this helper with the Windows error code it
> received from the system call so that errno can be updated with a
> POSIXy value.  If my imagination is correct, such a caller should
> not be assigning anything to errno if the underlying system call
> succeeds, i.e. returns ERROR_SUCCESS.  So a better solution might
> be for the function to BUG() when fed ERROR_SUCCESS to point fingers
> at the caller, no?

Just like on POSIX the value of errno is indeterminate after a
successful system call, the value of GetLastError() indeterminate after
a successful Windows API call. Therefore, the err_win_to_posix() would
not be able to point at a bogus caller reliably. For this reason, let's
consider the function as a simple error code translator, and then
translating ERROR_SUCCESS to 0 (or is there ESUCCESS?) makes total sense.

-- Hannes

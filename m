Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECA9C433EF
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 21:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B625A60F44
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 21:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238130AbhIVVXH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 17:23:07 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:58796 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238141AbhIVVXF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 17:23:05 -0400
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 4HFB7J52p0z5tl9;
        Wed, 22 Sep 2021 23:21:32 +0200 (CEST)
Subject: Re: [PATCH cb/pedantic-build-for-developers] lazyload.h: fix warnings
 about mismatching function pointer types
To:     Carlo Arenas <carenas@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <4381472f-a9db-b8a7-a395-81c3935309ae@kdbg.org>
 <CAPUEspguHsx+BtViT5tO3eyZSJf7mJ0of-K3vAMqB0-ju4fpsg@mail.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <2793c9c0-57ee-c7e0-957c-01d9aa27b44b@kdbg.org>
Date:   Wed, 22 Sep 2021 23:21:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAPUEspguHsx+BtViT5tO3eyZSJf7mJ0of-K3vAMqB0-ju4fpsg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 22.09.21 um 22:16 schrieb Carlo Arenas:
> On Wed, Sep 22, 2021 at 12:56 PM Johannes Sixt <j6t@kdbg.org> wrote:
>>
>> Here, GCC warns about every use of the INIT_PROC_ADDR macro, for example:
>>
>> In file included from compat/mingw.c:8:
>> compat/mingw.c: In function 'mingw_strftime':
>> compat/win32/lazyload.h:38:12: warning: assignment to
>>    'size_t (*)(char *, size_t,  const char *, const struct tm *)'
>>    {aka 'long long unsigned int (*)(char *, long long unsigned int,
>>       const char *, const struct tm *)'} from incompatible pointer type
>>    'FARPROC' {aka 'long long int (*)()'} [-Wincompatible-pointer-types]
>>    38 |  (function = get_proc_addr(&proc_addr_##function))
>>       |            ^
>> compat/mingw.c:1014:6: note: in expansion of macro 'INIT_PROC_ADDR'
>>  1014 |  if (INIT_PROC_ADDR(strftime))
>>       |      ^~~~~~~~~~~~~~
> 
> did you have CFLAGS adding -Wincompatible-pointer-types explicitly?

I don't know of the top of my head (am not at that Windows box right
now). I am fairly certain that I do not have DEVELOPER set.

> This is the reason why the code that got merged to master had -Wno
> for this case.
> 
>> (message wrapper for convenience). Insert a cast to keep the compiler
>> happy. A cast is fine in these cases because they are generic function
>> pointer values that have been looked up in a DLL.
> 
> I have a more complete "fix" which I got stuck testing GGG[1]; you are likely
> going to also hit -Wcast-function-type otherwise.

I think that the correct solution is that get_proc_addr() returns void*,
not FARPROC. Then either no cast is needed (because void* can be
converted to function pointer type implicitly) or a cast is needed and
that is then not between incompatible function pointer types and should
not trigger -Wcast-function-type, theoretically.

>> ---
>>  How can this have worked ever without a warning?
> 
> POSIX have a specific exception that allows (void *) for this,...

Sure, but as you can see in the warning message, FARPROC is not void*,
but a somewhat generic function pointer type. I was not questioning the
assignment of function pointer values of different types, but the
absence of a warning.

-- Hannes

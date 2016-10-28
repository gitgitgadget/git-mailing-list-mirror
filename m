Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 183822035F
	for <e@80x24.org>; Fri, 28 Oct 2016 20:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761793AbcJ1U0E (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 16:26:04 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:59320 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1761721AbcJ1U0E (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 16:26:04 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3t5FdP4b1Sz5tlD;
        Fri, 28 Oct 2016 22:26:01 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 1BB67101;
        Fri, 28 Oct 2016 22:26:01 +0200 (CEST)
Subject: Re: [PATCH] compat: Allow static initializer for pthreads on Windows
To:     Jacob Keller <jacob.keller@gmail.com>
References: <20161026215732.16411-1-sbeller@google.com>
 <93be5d21-6cb6-ee2b-9f4f-c2fe7c690d6c@kdbg.org>
 <xmqqlgxa8h3a.fsf@gitster.mtv.corp.google.com>
 <67e38b43-0264-12f2-cca8-4b718ed7dc9d@kdbg.org>
 <xmqqh97y8g74.fsf@gitster.mtv.corp.google.com>
 <xmqqd1im8foi.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kbP3pgPHgv-x1Q-Q1QwmXc=gOyxWhXh2SngO8WSZc3PFA@mail.gmail.com>
 <34c88c40-2088-fd74-5d26-56c0599b7eb9@kdbg.org>
 <xmqqr3716301.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kY_fZ_pDtVnwJoDkR6PjTNoqDMN5OC70Z8SH_J0Wvkq-w@mail.gmail.com>
 <a2e5acd6-485d-0387-7a85-6042dee702f7@kdbg.org>
 <CA+P7+xpckfaeHmoEGQBdLD-=Kf7gQ-jOxGFKrKmiFH1SBN7GjA@mail.gmail.com>
 <alpine.DEB.2.20.1610281356310.3264@virtualbox>
 <CA+P7+xoyF8EG079eC-dfTSj+YrbxhPWx356-jZ90gDs6SwyppA@mail.gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Simon Ruderich <simon@ruderich.org>, Jeff King <peff@peff.net>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <38b70094-5550-8512-7735-a6739f435803@kdbg.org>
Date:   Fri, 28 Oct 2016 22:26:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <CA+P7+xoyF8EG079eC-dfTSj+YrbxhPWx356-jZ90gDs6SwyppA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 28.10.2016 um 20:48 schrieb Jacob Keller:
> On Fri, Oct 28, 2016 at 4:58 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>> Hi Jake,
>>
>> On Thu, 27 Oct 2016, Jacob Keller wrote:
>>
>>> I agree with Stefan that there isn't really a great place to put a
>>> dynamic initialization.
>>
>> Ummm. Wait. What???
>>
>> https://github.com/git/git/blob/v2.10.1/common-main.c#L25-L41
>
> I think Stefan has since provided a better suggestion of isolating the
> dynamic initialization into the MINGW startup section. However, you
> are right either place works, though I think platforms which support
> static initialization should use it.

It's a pity that this new patch introduces the first use of 
PTHREAD_MUTEX_INITILIZER. (I do not count the one in compat/nedmalloc, 
it's in platform specific code.) We have to introduce a dummy definition 
on Windows to even compile the code.

Now we have a double-edged sword: Other coders who are not aware of this 
thread might think it works. But it does not.

Another problem with the proposed patch is that there is no declaration 
for attr_start() before the call in compat/mingw.c. We would have to 
move the declaration of attr_start() to cache.h (for example), because 
#including attr.h in compat/mingw.c is plainly wrong. However, it would 
not be a major offense to #include attr.h in common-main.c. But when we 
do that, we can certainly spare the few cycles to call pthread_mutex_init.

-- Hannes


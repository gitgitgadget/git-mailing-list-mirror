Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B6871FF40
	for <e@80x24.org>; Wed, 30 Nov 2016 22:37:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758791AbcK3Whp (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Nov 2016 17:37:45 -0500
Received: from avasout05.plus.net ([84.93.230.250]:33603 "EHLO
        avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758226AbcK3Who (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2016 17:37:44 -0500
Received: from [10.0.2.15] ([143.159.212.40])
        by avasout05 with smtp
        id ENdg1u0090srQBz01NdhnX; Wed, 30 Nov 2016 22:37:42 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=Qskc5h6d c=1 sm=1 tr=0
 a=8Z0saNXTz8GoXi/9Q5ysMA==:117 a=8Z0saNXTz8GoXi/9Q5ysMA==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=5rxgeBVgAAAA:8 a=PKzvZo6CAAAA:8
 a=lXleW3H5gwwluVQ7KzcA:9 a=WwEvmB4MHieOfmKn:21 a=jWHiJItPLHxSF_7f:21
 a=QEXdDO2ut3YA:10 a=yJM6EZoI5SlJf8ks9Ge_:22 a=PwKx63F5tFurRwaNxrlG:22
 a=q92HNjYiIAC_jH7JDaYf:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH] difftool.c: mark a file-local symbol with static
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
References: <4ddad7ea-5ac8-20b2-da9e-5843c486878a@ramsayjones.plus.com>
 <alpine.DEB.2.20.1611301204020.117539@virtualbox>
 <29abc89b-9ca5-930f-8e90-ca446ac2b96a@ramsayjones.plus.com>
 <xmqqtwaod7ly.fsf@gitster.mtv.corp.google.com>
 <20161130212510.ihcmvig7jq44p3nx@sigill.intra.peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <3e6a6685-19ec-4536-4a5f-3a56e30fb530@ramsayjones.plus.com>
Date:   Wed, 30 Nov 2016 22:37:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20161130212510.ihcmvig7jq44p3nx@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 30/11/16 21:25, Jeff King wrote:
> On Wed, Nov 30, 2016 at 12:40:25PM -0800, Junio C Hamano wrote:
> 
>> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
>>
>>> [I have fixed my config.mak file now, so I don't see the warning
>>> anymore! Having -Wno-format-zero-length in DEVELOPER_CFLAGS, or
>>> not, is a separate matter.]
>>
>> I suspect that 658df95a4a ("add DEVELOPER makefile knob to check for
>> acknowledged warnings", 2016-02-25) took it from me (namely, Make
>> script in my 'todo' branch).  In turn, I added it to my set of flags
>> in order to squelch this exact warning, so...
> 
> For anybody interested in the history, we started using this when
> status_printf() got the format attribute. Relevant patch and discussion:
> 
>   http://public-inbox.org/git/20130710002328.GC19423@sigill.intra.peff.net/T/#u

Ah, thank you! I've been trying to remember this for the last hour or so ...
(I misremembered something about gettext, and went looking in the wrong
direction ;-) ).

> We went with disabling the warning because it really is wrong. It makes
> an assumption that calling a format function with an empty string
> doesn't do anything, but that's only true of the stock printf functions.
> Our custom functions _do_ have a side effect in this case.

Yes, I agree, gcc is making an unwarranted assumption.

> The other options are to have a special function for "print a warning
> (or status) line with no content". Or to teach those functions to handle
> newlines specially. We've often discussed that you should be able to do:
> 
>   warning("foo\nbar");
> 
> and have it print:
> 
>   warning: foo
>   warning: bar
> 
> That's useful in itself, and would probably make cases like this easier
> to handle, too. But it's a pretty big change. Another option would be to
> just teach formatting functions to handle a single "\n" as a synonym for
> the empty string (or even detect trailing newlines and avoid appending
> our own in that case). That would mean you could do:
> 
>   warning("\n");
> 
> to print a blank line. That's arguably more obvious about the intent to
> a reader (I say arguably because the new behavior _is_ subtle if you
> happen to know that warning() usually appends a newline).

Yes, I remember the discussion now and agree that this could
cause problems.

> Anyway. Those are all options, but I don't think there is any problem
> with sticking with warning("") for now. It is not the first part of the
> code that tickles the format-zero-length warning.

Hmm, well I have been building git for some time with the warning
enabled without problem.

[I can see a few examples of 'status_printf_ln(s, c, "%s", "");' in
git-grep output, so ...]

I am not suggesting any change here, and was just curious why it
seemed to be unnecessary now (I knew it was necessary at one time).

ATB,
Ramsay Jones


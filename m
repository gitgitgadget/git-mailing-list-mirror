Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AF5A20705
	for <e@80x24.org>; Thu,  8 Sep 2016 19:06:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938937AbcIHTGr (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 15:06:47 -0400
Received: from avasout08.plus.net ([212.159.14.20]:40026 "EHLO
        avasout08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937116AbcIHTGq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 15:06:46 -0400
Received: from [10.0.2.15] ([209.93.82.95])
        by avasout08 with smtp
        id h76d1t00423PrXV0176eQA; Thu, 08 Sep 2016 20:06:39 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=Y6S6iVWN c=1 sm=1 tr=0
 a=MrGUH+yfTxdMEvUZuMmDjA==:117 a=MrGUH+yfTxdMEvUZuMmDjA==:17
 a=IkcTkHD0fZMA:10 a=pW1bYtSW8WSpXtOenQkA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v2 3/3] Use the newly-introduced regexec_buf() function
To:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <cover.1473090278.git.johannes.schindelin@gmx.de>
 <cover.1473319844.git.johannes.schindelin@gmx.de>
 <324ecba64eb0436988aca846fb444eafda290d13.1473319844.git.johannes.schindelin@gmx.de>
 <alpine.DEB.2.20.1609080954010.129229@virtualbox>
 <20160908081024.yku2xlb3jj4rplkp@sigill.intra.peff.net>
 <20160908081446.zlcmz6ci4cw4vc2e@sigill.intra.peff.net>
 <20160908083509.ygh4flpunyyp4hua@sigill.intra.peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <ac0f3441-d28f-fc5c-0273-f614b2cd4e07@ramsayjones.plus.com>
Date:   Thu, 8 Sep 2016 20:06:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160908083509.ygh4flpunyyp4hua@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 08/09/16 09:35, Jeff King wrote:
> On Thu, Sep 08, 2016 at 04:14:46AM -0400, Jeff King wrote:
> 
>> On Thu, Sep 08, 2016 at 04:10:24AM -0400, Jeff King wrote:
>>
>>> On Thu, Sep 08, 2016 at 09:54:51AM +0200, Johannes Schindelin wrote:
>>>
>>>>>  diff.c             |  3 ++-
>>>>>  diffcore-pickaxe.c | 18 ++++++++----------
>>>>>  xdiff-interface.c  | 13 ++++---------
>>>>>  3 files changed, 14 insertions(+), 20 deletions(-)
>>>>
>>>> I just realized that this should switch the test_expect_failure from 1/3
>>>> to a test_expect_success.
>>>
>>> Yep. I wonder if we also would want to test that we correctly find
>>> regexes inside binary files.
>>>
>>> E.g., given a mixed binary/text file like:
>>>
>>>   printf 'binary\0text' >file &&
>>>   git add file &&
>>>   git commit -m file
>>>
>>> then "git log -Stext" will find that file, but "--pickaxe-regex" will
>>> not (using stock git). Ditto for "-Gtext".
>>>
>>> Your patch should fix that.
>>
>> Of course if I had actually _looked carefully_ at your patch, I would
>> have seen that your test doesn't just check that we don't segfault, but
>> actually confirms that we find the entry.
>>
>> Sorry for the noise.
> 
> Actually, I take it back again. Your test case doesn't have an embedded
> NUL in it (so we check that git finds it, but aside from the lack of
> segfault, stock git would already find it).

This reminds me ... despite the native cygwin regex library no longer
having the 'regex bug' (ie t0070.5 now passes), I still have NO_REGEX
set on cygwin. This is because, when building with the native library,
we have an "unexpected pass" for t7008.12, which looks like:

test_expect_failure 'git grep .fi a' '
        git grep .fi a
'
[where the file a is set up earlier by: echo 'binaryQfile' | q_to_nul >a]

commit f96e5673 ("grep: use REG_STARTEND for all matching if available",
22-05-2010) introduced this test and expects ".. NUL characters themselves
are not matched in any way". With the native library on cygwin they are
matched, with the compat/regex they are not. Indeed, if you use the system
'grep' command (rather than 'git grep'), then it will also not match ... :-D

Slightly off topic, but ...

ATB,
Ramsay Jones



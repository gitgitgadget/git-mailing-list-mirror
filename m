Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E89620970
	for <e@80x24.org>; Tue, 11 Apr 2017 20:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753514AbdDKUmi (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 16:42:38 -0400
Received: from siwi.pair.com ([209.68.5.199]:21636 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753504AbdDKUmf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 16:42:35 -0400
Received: from [10.160.98.126] (unknown [167.220.148.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 1DF4684561;
        Tue, 11 Apr 2017 16:42:34 -0400 (EDT)
Subject: Re: [PATCH v2] unpack-trees: avoid duplicate ODB lookups during
 checkout
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>, git@vger.kernel.org
References: <20170407155306.42375-1-git@jeffhostetler.com>
 <20170407155306.42375-2-git@jeffhostetler.com>
 <23662d7b-84a9-4b71-1aa5-5d3d111f5c3d@web.de>
 <ea0aa4ea-1c28-c1dd-db92-d4758b9dca88@jeffhostetler.com>
 <001f55c6-a694-7dde-b14b-9d1dcc9c9a09@web.de>
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <ad2b5a8c-f9d0-82cb-25b8-76c1922af7f5@jeffhostetler.com>
Date:   Tue, 11 Apr 2017 16:42:33 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <001f55c6-a694-7dde-b14b-9d1dcc9c9a09@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/10/2017 7:09 PM, René Scharfe wrote:
> Am 10.04.2017 um 23:26 schrieb Jeff Hostetler:
>> On 4/8/2017 10:06 AM, René Scharfe wrote:
>>> Am 07.04.2017 um 17:53 schrieb git@jeffhostetler.com:
>>>> +            /* implicitly borrow buf[i-1] inside tree_desc[i] */
>>>> +            memcpy(&t[i], &t[i-1], sizeof(struct tree_desc));
>>>
>>> An assignment would be simpler:
>>>
>>>             t[i] = t[i - 1];
>>
>> True, but this might be a coin toss.  Maybe we should
>> see what the generated assembly looks like for each ??
>
> Clang, GCC and ICC inline that memcpy call; the assembly output is the
> same for both variants: https://godbolt.org/g/1q0YwK.  I guess you worry
> about compilers that are just bad at struct assignments (i.e. worse than
> calling memcpy)?  Do you have examples (just curious)?

Nice website!  Really!

Yes, my concern was that structure copies would do it
field by field rather than just a block copy.  No, I
don't have any examples -- maybe just some very old
brain cells.... :-)

And I just checked VS2015 and the structure copy is a
few instructions shorter, but roughly the same.

>
> Assignments are easier on the eye of human readers in any case, and
> there is no way to silently get the size wrong.

agreed. thanks.

>
>> I tried to hit the common cases.  This loop runs a lot
>> and I didn't want to put an O(n^2) thing in there to
>> look for any matching peer.  Most of the time we are
>> in a simple 2 or 3 way effort.  I didn't want to pay
>> for the looping/branching overhead for the obscure [4..8]
>> efforts.
>
> Makes sense, and it's a nice heuristic.  Perhaps it would be a good idea
> to document these choices in a comment?

Good point. Thanks.



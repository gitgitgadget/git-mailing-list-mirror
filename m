Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6672720196
	for <e@80x24.org>; Thu, 14 Jul 2016 20:53:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752297AbcGNUxA (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 16:53:00 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:42679 "EHLO bsmtp3.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751737AbcGNUw6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 16:52:58 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 3rr7FM6zvBz5tlK;
	Thu, 14 Jul 2016 22:52:55 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 118AD52C6;
	Thu, 14 Jul 2016 22:52:55 +0200 (CEST)
Subject: Re: [PATCH v4 2/5] t5000: test tar files that overflow ustar headers
To:	Junio C Hamano <gitster@pobox.com>
References: <20160630090614.GA16725@sigill.intra.peff.net>
 <20160630090857.GB17463@sigill.intra.peff.net>
 <alpine.DEB.2.20.1607141745420.6426@virtualbox>
 <19a2d02e-3918-3bc9-db34-66e12ab950e4@kdbg.org>
 <xmqqa8hkrvu5.fsf@gitster.mtv.corp.google.com>
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	=?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
From:	Johannes Sixt <j6t@kdbg.org>
Message-ID: <3d71cf3a-44c7-0620-0375-fb7ecf2fac13@kdbg.org>
Date:	Thu, 14 Jul 2016 22:52:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2
MIME-Version: 1.0
In-Reply-To: <xmqqa8hkrvu5.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Am 14.07.2016 um 19:08 schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
>
>> Am 14.07.2016 um 17:47 schrieb Johannes Schindelin:
>>> On Thu, 30 Jun 2016, Jeff King wrote:
>>>> The ustar format only has room for 11 (or 12, depending on
>>>> some implementations) octal digits for the size and mtime of
>>>> each file. For values larger than this, we have to add pax
>>>> extended headers to specify the real data, and git does not
>>>> yet know how to do so.
>>>>
>>>> [...]
>>>>  t/t5000/19f9c8273ec45a8938e6999cb59b3ff66739902a | Bin 0 -> 2048 bytes
>>>
>>> It appears that this blob cannot be read when sizeof(unsigned long) == 4.
>>> This happens to break the t5000 test on Windows, where that comparison
>>> holds true.
>>
>> The problem occurs in parse_sha1_header_extended(), where the
>> calculation of the size in the object header overflows our 32-bit
>> unsigned long.
>
> OK, then we'd want something that measures how big "unsigned long"
> is, and use it as a lazy prerequisite 64BIT_LONG, tweaking the other
> patch to t0006 the other Johannes sent yesterday.
>
> Dscho?  I'll revert the merge of 'js/t0006-for-v2.9.2' out of
> 'next' so that we can replace it with your newer version, but it
> needs to be massaged to lose the strong linkage with "time", as
> it is no longer "is our time big enough", I would think.

My first thought was that this is not warranted because t0006 is about 
commit time stamps, but the huge-tar breakage is file sizes, and the 
cases should be treated differently.

But on second thought, under the hood, both boil down to the size of 
unsigned long in our implementation. It may make sense to tie both cases 
to the same prerequisite.

On third thought, however, I think the two requirements could diverge in 
the future. The file size case should depend on the size of size_t. The 
timestamp case may become dependent on the size of time_t if we decide 
to move timestamp handling away from unsigned long: in modern(!) 
Microsoft SDKs, time_t is 64 bits, but unsigned long is 32 bits, in both 
the 32-bit and 64-bit environments!

-- Hannes


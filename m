Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 906BD1F405
	for <e@80x24.org>; Thu,  9 Aug 2018 21:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbeHIXk5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 19:40:57 -0400
Received: from siwi.pair.com ([209.68.5.199]:27978 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727156AbeHIXk5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 19:40:57 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 7FCD93F4097;
        Thu,  9 Aug 2018 17:14:17 -0400 (EDT)
Received: from [192.168.1.71] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 4652C3F4093;
        Thu,  9 Aug 2018 17:14:17 -0400 (EDT)
Subject: Re: [PATCH v2] clone: report duplicate entries on case-insensitive
 filesystems
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org, pawelparuzel95@gmail.com,
        sandals@crustytoothpaste.net, Elijah Newren <newren@gmail.com>,
        tboegi@web.de
References: <20180730152756.15012-1-pclouds@gmail.com>
 <20180807190110.16216-1-pclouds@gmail.com>
 <xmqq7el2km82.fsf@gitster-ct.c.googlers.com>
 <fc56d572-e333-2e05-2130-71b53e251a13@jeffhostetler.com>
 <20180808223139.GA3902@sigill.intra.peff.net>
 <xmqqbmace5i1.fsf@gitster-ct.c.googlers.com>
 <20180809142333.GB1439@sigill.intra.peff.net>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <34b22185-a0bc-f712-b5e5-fc5e2697dcc2@jeffhostetler.com>
Date:   Thu, 9 Aug 2018 17:14:16 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180809142333.GB1439@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/9/2018 10:23 AM, Jeff King wrote:
> On Wed, Aug 08, 2018 at 05:41:10PM -0700, Junio C Hamano wrote:
> 
>>> If we have an equivalence-class hashmap and feed it inodes (or again,
>>> some system equivalent) as the keys, we should get buckets of
>>> collisions.
>>
>> I guess one way to get "some system equivalent" that can be used as
>> the last resort, when there absolutely is no inum equivalent, is to
>> rehash the working tree file that shouldn't be there when we detect
>> a collision.
>>
>> If we found that there is something when we tried to write out
>> "Foo.txt", if we open "Foo.txt" on the working tree and hash-object
>> it, we should find the matching blob somewhere in the index _before_
>> "Foo.txt".  On a case-insensitive filesytem, it may well be
>> "foo.txt", but we do not even have to know "foo.txt" and "Foo.txt"
>> only differ in case.
> 
> Clever. You might still run into false positives when there is
> duplicated content in the repository (especially, say, zero-length
> files).  But the fact that you only do the hashing on known duplicates
> helps with that.
> 

I worry that the false positives make this a non-starter.  I mean, if
clone creates files 'A' and 'B' (both equal) and then tries to create
'b', would the collision code reports that 'b' collided with 'A' because
that was the first OID match?  Ideally with this scheme we'd have to
search the entire index prior to 'b' and then report that 'b' collided
with either 'A' or 'B'.  Neither message instills confidence.  And
there's no way to prefer answer 'B' over 'A' without using knowledge
of the FS name mangling/aliasing rules -- unless we want to just assume
ignore-case for this iteration.

> One of the things I did like about the equivalence-class approach is
> that it can be done in a single linear pass in the worst case. Whereas
> anything that searches when we see a collision is quite likely to be
> quadratic. But as I said before, it may not be worth worrying too much
> about that for an error code path where we expect the number of
> collisions to be small.
> 
> -Peff
> 

Sorry to be paranoid, but I have an index with 3.5M entries, the word
"quadratic" rings all kinds of alarm bells for me.  :-)

Granted, we expect the number of collisions to be small, but searching
back for each collision over the already-populated portion of the index
could be expensive.

Jeff


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C2E41F597
	for <e@80x24.org>; Fri,  3 Aug 2018 18:23:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbeHCUUq (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 16:20:46 -0400
Received: from siwi.pair.com ([209.68.5.199]:35504 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728079AbeHCUUq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 16:20:46 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id CFB833F40F4;
        Fri,  3 Aug 2018 14:23:20 -0400 (EDT)
Received: from [192.168.1.6] (211.sub-174-231-169.myvzw.com [174.231.169.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 8DA1E3F409D;
        Fri,  3 Aug 2018 14:23:19 -0400 (EDT)
Subject: Re: [PATCH/RFC] clone: report duplicate entries on case-insensitive
 filesystems
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>, Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?Pawe=c5=82_Paruzel?= <pawelparuzel95@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
References: <xmqqo9enb4n9.fsf@gitster-ct.c.googlers.com>
 <20180731192931.GD3372@sigill.intra.peff.net>
 <xmqqva8v9nc1.fsf@gitster-ct.c.googlers.com>
 <20180731203746.GA9442@sigill.intra.peff.net>
 <xmqqin4v9l7u.fsf@gitster-ct.c.googlers.com>
 <xmqq1sbh7phx.fsf@gitster-ct.c.googlers.com>
 <CACsJy8DFX2=CaTomc33uuHQ-nBvgfutVbaQ2DxT_p8-hzj6PsA@mail.gmail.com>
 <xmqqpnz03f9o.fsf@gitster-ct.c.googlers.com>
 <20180802190644.GE23690@sigill.intra.peff.net>
 <xmqqmuu4zd1l.fsf@gitster-ct.c.googlers.com>
 <20180802212819.GA32538@sigill.intra.peff.net>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <5b17454b-7fa7-7a9c-92d9-214e6e697785@jeffhostetler.com>
Date:   Fri, 3 Aug 2018 14:23:17 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180802212819.GA32538@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/2/2018 5:28 PM, Jeff King wrote:
> On Thu, Aug 02, 2018 at 02:14:30PM -0700, Junio C Hamano wrote:
> 
>> Jeff King <peff@peff.net> writes:
>>
>>> I also wonder if Windows could return some other file-unique identifier
>>> that would work in place of an inode here. That would be pretty easy to
>>> swap in via an #ifdef's helper function. I'd be OK shipping without that
>>> and letting Windows folks fill it in later (as long as we do not do
>>> anything too stupid until then, like claim all of the inode==0 files are
>>> the same).
>>
>> Yeah, but such a useful file-unique identifier would probably be
>> used in place of inum in their (l)stat emulation already, if exists,
>> no?
> 
> Maybe. It might not work as ino_t. Or it might be expensive to get.  Or
> maybe it's simply impossible. I don't know much about Windows. Some
> searching implies that NTFS does have a "file index" concept which is
> supposed to be unique.

This is hard and/or expensive on Windows.  Yes, you can get the
"file index" values for an open file handle with a cost similar to
an fstat().  Unfortunately, the FindFirst/FindNext routines (equivalent
to the opendir/readdir routines), don't give you that data.  So we'd
have to scan the directory and then open and stat each file.  This is
terribly expensive on Windows -- and the reason we have the fscache
layer (in the GfW version) to intercept the lstat() calls whenever
possible.

It might be possible to use the NTFS Master File Table to discover
this (very big handwave), but I would need to do a little digging.

This would all be NTFS specific.  FAT and other volume types would not
be covered.

Another thing to keep in mind is that the collision could be because
of case folding (or other such nonsense) on a directory in the path.
I mean, if someone on Linux builds a commit containing:

     a/b/c/D/e/foo.txt
     a/b/c/d/e/foo.txt

we'll get a similar collision as if one of them were spelled "FOO.txt".

Also, do we need to worry about hard-links or symlinks here?
If checkout populates symlinks, then you might have another collision
opportunity.  For example:

     a/b/c/D/e/foo.txt
     a/link -> ./b/c/d
     a/link/e/foo.txt

Also, some platforms (like the Mac) allow directory hard-links.
Granted, Git doesn't create hard-links during checkout, but the
user might.

I'm sure there are other edge cases here that make reporting
difficult; these are just a few I thought of.  I guess what I'm
trying to say is that as a first step just report that you found
a collision -- without trying to identify the set existing objects
that it collided with.

> 
> At any rate, until we have an actual plan for Windows, I think it would
> make sense only to split the cases into "has working inodes" and
> "other", and make sure "other" does something sensible in the meantime
> (like mention the conflict, but skip trying to list duplicates).

Yes, this should be split.  Do the "easy" Linux version first.
Keep in mind that there may also be a different solution for the Mac.

> When somebody wants to work on Windows support, then we can figure out
> if it just needs to wrap the "get unique identifier" operation, or if it
> would use a totally different algorithm.
> 
> -Peff
> 

Jeff

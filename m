Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D3981F597
	for <e@80x24.org>; Tue, 31 Jul 2018 19:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732419AbeGaVVd (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 17:21:33 -0400
Received: from siwi.pair.com ([209.68.5.199]:28509 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732219AbeGaVVd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 17:21:33 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id A4C853F4015;
        Tue, 31 Jul 2018 15:39:42 -0400 (EDT)
Received: from [192.168.1.6] (166.sub-174-231-168.myvzw.com [174.231.168.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 3B1203F400D;
        Tue, 31 Jul 2018 15:39:42 -0400 (EDT)
Subject: Re: Git clone and case sensitivity
To:     Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?Q?Pawe=c5=82_Paruzel?= <pawelparuzel95@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <24A09B73-B4D4-4C22-BC1B-41B22CB59FE6@gmail.com>
 <20180727205909.GC376343@genre.crustytoothpaste.net>
 <20180728043559.GA29185@duynguyen.home>
 <CACsJy8A3pd85fDrbak8TCnmkMb_FDmmpaNd5tBSCKBGkGswKCg@mail.gmail.com>
 <20180728044857.GA10444@sigill.intra.peff.net>
 <20180728051105.GA32243@duynguyen.home>
 <20180728095659.GA21450@sigill.intra.peff.net>
 <CACsJy8DTQhinpLOhojnrpFt3_2tVo3mo1Dwv-x4aF3mZJ2Rhgg@mail.gmail.com>
 <20180729092759.GA14484@sigill.intra.peff.net>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <c174d972-fc5b-88e7-b437-89b9dd29e579@jeffhostetler.com>
Date:   Tue, 31 Jul 2018 15:39:41 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180729092759.GA14484@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/29/2018 5:28 AM, Jeff King wrote:
> On Sun, Jul 29, 2018 at 07:26:41AM +0200, Duy Nguyen wrote:
> 
>>> strcasecmp() will only catch a subset of the cases. We really need to
>>> follow the same folding rules that the filesystem would.
>>
>> True. But that's how we handle case insensitivity internally. If a
>> filesytem has more sophisticated folding rules then git will not work
>> well on that one anyway.
> 
> Hrm. Yeah, I guess that's the best we can do for the actual in-memory
> checks. Everything else depends on doing an actual filesystem operation,
> and our icase stuff kicks in way before then. I was mostly thinking of
> HFS+ utf8 normalization weirdness, but I guess people are accustomed to
> that by now.
> 
>>> For the case of clone, I actually wonder if we could detect during the
>>> checkout step that a file already exists. Since we know that the
>>> directory we started with was empty, then if it does, either:
>>>
>>>    - there's some funny case-folding going on that means two paths in the
>>>      repository map to the same name in the filesystem; or
>>>
>>>    - somebody else is writing to the directory at the same time as us
>>
>> This is exactly what my first patch does (minus the sparse checkout
>> part).
> 
> Right, sorry, I should have read that one more carefully.
> 
>> But without knowing the exact folding rules, I don't think we can
>> locate this "somebody else" who wrote the first path. So if N paths
>> are treated the same by this filesystem, we could only report N-1 of
>> them.
>>
>> If we want to report just one path when this happens though, then this
>> works quite well.
> 
> Hmm. Since most such systems are case-preserving, would it be possible
> to report the name of the existing file? Doing it via opendir/readdir is
> hacky, and anyway puts the burden on us to find the matching name. Doing
> it via fstat() on the opened file doesn't work because at that the
> filesystem has resolved the name to an inode.
> 
> So yeah, perhaps strcasecmp() is the best we can do (I do agree that
> being able to mention all of the conflicting names is a benefit).
> 
> I guess we should be using fspathcmp(), though, in case it later learns
> to be smarter.
> 
> -Peff
> 

As has already been mentioned, this gets into weird territory really
fast, between case folding, final space/dot on windows, utf8 NFC/NFD
weirdness on the mac, utf8 invisible chars on the mac, long/short names
on windows, and etc.

And that's just for filenames.  Things really get weird if directory
names have these ambiguities.

Perhaps just print the problematic paths (where the collision is
detected) and let the user decide how to correct them.

Perhaps we could have a separate tool that could scan the index or
commit for potential conflicts and warn them in advance (granted, it
might not be perfect and may report a few false positives).

Forcing them into a sparse-checkout situation might be over their
skill level.

Jeff

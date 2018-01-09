Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05E201F406
	for <e@80x24.org>; Tue,  9 Jan 2018 14:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932205AbeAIO4R (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 09:56:17 -0500
Received: from siwi.pair.com ([209.68.5.199]:30619 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751592AbeAIO4O (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 09:56:14 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 3D2BB84512;
        Tue,  9 Jan 2018 09:56:13 -0500 (EST)
Received: from [10.160.98.77] (unknown [167.220.148.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id D07FC844F4;
        Tue,  9 Jan 2018 09:56:12 -0500 (EST)
Subject: Re: [PATCH v4 0/4] Add --no-ahead-behind to status
To:     Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Cc:     Ben Peart <peartben@gmail.com>, git@vger.kernel.org,
        gitster@pobox.com, Jeff Hostetler <jeffhost@microsoft.com>
References: <20180108154822.54829-1-git@jeffhostetler.com>
 <7b759564-5544-8845-0594-e8342a0b4ba5@gmail.com>
 <8affe37c-d937-d7e0-fe06-cf7c8db173fa@jeffhostetler.com>
 <20180109072044.GD32257@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1801091407480.37@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <c19f6469-190a-33e7-20a2-fcb17b8e45d9@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <98758cd5-de26-0f15-ad8b-c2abd62f67d3@jeffhostetler.com>
Date:   Tue, 9 Jan 2018 09:56:12 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <c19f6469-190a-33e7-20a2-fcb17b8e45d9@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 1/9/2018 9:29 AM, Derrick Stolee wrote:
> On 1/9/2018 8:15 AM, Johannes Schindelin wrote:
>> Hi Peff,
>>
>> On Tue, 9 Jan 2018, Jeff King wrote:
>>
>>> On Mon, Jan 08, 2018 at 03:04:20PM -0500, Jeff Hostetler wrote:
>>>
>>>>> I was thinking about something similar to the logic we use today
>>>>> about whether to start reporting progress on other long commands.
>>>>> That would mean you could still get the ahead/behind values if you
>>>>> aren't that far behind but would only get "different" if that
>>>>> calculation gets too expensive (which implies the actual value isn't
>>>>> going to be all that helpful anyway).
>>>> After a off-line conversation with the others I'm going to look into
>>>> a version that is limited to n commits rather than be completely on or
>>>> off.  I think if you are for example less than 100 a/b then those numbers
>>>> have value; if you are past n, then they have much less value.
>>>>
>>>> I'd rather do it by a fixed limit than by time to ensure that output
>>>> is predictable on graph shape and not on system load.
>>> I like this direction a lot. I had hoped we could say "100+ commits
>>> ahead",
>> How about "100+ commits apart" instead?
> 
> Unfortunately, we can _never_ guarantee more than 1 commit ahead/behind unless we walk to the merge base (or have generation numbers). For example, suppose the 101st commit in each history has a parent that in the recent history of the other commit. (There must be merge commits to make this work without creating cycles, but the ahead/behind counts could be much lower than the number of walked commits.)
> 
>>
>>> but I don't think we can do so accurately without generation numbers.
>> Even with generation numbers, it is not possible to say whether two given
>> commits reflect diverging branches or have an ancestor-descendant
>> relationship (or in graph speak: whether they are comparable).
> 
> If you walk commits using a priority queue where the priority is the generation number, then you can know that you have walked all reachable commits with generation greater than X, so you know among those commits which are comparable or not.
> 
> For this to work accurately, you must walk from both tips to a generation lower than each. It does not help the case where one branch is 100,000+ commits ahead, where most of those commits have higher generation number than the behind commit.
> 
>> It could potentially make it possible to cut off the commit traversal, but
>> I do not even see how that would be possible.
>>
>> The only thing you could say for sure is that two different commits with
>> the same generation number are for sure "uncomparable", i.e. reflect
>> diverging branches.
>>
>>> E.g., the case I mentioned at the bottom of this mail:
>>>
>>>    https://public-inbox.org/git/20171224143318.GC23648@sigill.intra.peff.net/
>>>
>>> I haven't thought too hard on it, but I suspect with generation numbers
>>> you could bound it and at least say "100+ ahead" or "100+ behind".
>> If you have walked 100 commits and still have not found a merge base,
>> there is no telling whether one start point is the ancestor of the other.
>> All you can say is that there are more than 100 commits in the
>> "difference".
>>
>> You would not even be able to say that the *shortest* path between those
>> two start points is longer than 100 commits, you can construct
>> pathological DAGs pretty easily.
>>
>> Even if you had generation numbers, and one commit's generation number
>> was, say, 17, and the other one's was 17,171, you could not necessarily
>> assume that the 17 one is the ancestor of the 17,171 one, all you can say
>> that it is not possible the other way round.
> 
> This is why we cannot _always_ use generation numbers, but they do help in some cases.
> 
>>> But I don't think you can approximate both ahead and behind together
>>> without finding the actual merge base.
>>>
>>> But even still, finding small answers quickly and accurately and punting
>>> to "really far, I didn't bother to compute it" on the big ones would be
>>> an improvement over always punting.
>> Indeed. The longer I think about it, the more I like the "100+ commits
>> apart" idea.
>>
> 
> Again, I strongly suggest we drop this approach because it will be more pain than it is worth.

Good comments all.  Thanks!
I will leave the patch series as it is with the existing on/off setting
and call it quits.

Thanks,
Jeff


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3ED1020960
	for <e@80x24.org>; Mon, 10 Apr 2017 21:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752099AbdDJV2Q (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Apr 2017 17:28:16 -0400
Received: from siwi.pair.com ([209.68.5.199]:47671 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751514AbdDJV2P (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2017 17:28:15 -0400
Received: from [10.160.98.126] (unknown [167.220.148.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 54ADB8456E;
        Mon, 10 Apr 2017 17:28:14 -0400 (EDT)
Subject: Re: [PATCH v2] unpack-trees: avoid duplicate ODB lookups during
 checkout
To:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
References: <20170407155306.42375-1-git@jeffhostetler.com>
 <20170407155306.42375-2-git@jeffhostetler.com>
 <23662d7b-84a9-4b71-1aa5-5d3d111f5c3d@web.de>
 <20170410205540.wvlb7ch7bodiytmh@sigill.intra.peff.net>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Jeff Hostetler <jeffhost@microsoft.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <ed64f8fc-9cec-4c46-b9e6-9e9e4983f95a@jeffhostetler.com>
Date:   Mon, 10 Apr 2017 17:28:13 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170410205540.wvlb7ch7bodiytmh@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/10/2017 4:55 PM, Jeff King wrote:
> On Sat, Apr 08, 2017 at 04:06:41PM +0200, René Scharfe wrote:
>
>>> +		} else if (i > 1 && are_same_oid(&names[i], &names[i-2])) {
>>> +			/* implicitly borrow buf[i-2] inside tree_desc[i] */
>>> +			memcpy(&t[i], &t[i-2], sizeof(struct tree_desc));
>>
>> Similar case.
>>
>>> +			buf[i] = NULL;
>>
>> What makes the previous two entries special, or differently put: Why not
>> just check *all* previous entries?  MAX_UNPACK_TREES is 8; the number of
>> comparisons would just about double in the worst case and stay the same for
>> three trees or less.  The order of four trees or more wouldn't matter
>> anymore.
>
> If I understand correctly, we've got N (up to 8) trees, and we want to
> find sets of duplicates. Adjacency doesn't matter. Aren't our options
> basically:
>
>   - look through all previous entries naively, O(N^2)
>
>   - sort the list, O(N log N); but we need the original order, so we'd
>     have to unsort at the end, too
>
>   - use a hash table, O(N) but with O(N) extra storage
>
> I know N=8 isn't very big algorithmically speaking, but it would feel
> ugly to introduce something quadratic. Especially the limit of 8 seems
> rather arbitrary. In normal cases we see at most a 3-way merge. Beyond
> that we're in octopus territory, and 8 is way too low there (I think the
> octopus strategy just unpacks one at a time and barfs if there are any
> conflicts).
>
> I assume the rationale behind "check the last 2" is just "this
> optimization will kick in reliably for all sane cases", weird octopus
> unpack-trees be damned (though reading ca885a4fe, it sounds like 4-trees
> can actually happen, but I'm not clear on how).

yeah, i didn't want to pay for the obscure (n >= 4) cases with any
of the above.  doing 2 or 3 gets us checkout and merge.  these are
the common usages.

Jeff


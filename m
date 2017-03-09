Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08AA2202F8
	for <e@80x24.org>; Thu,  9 Mar 2017 18:26:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932077AbdCIS0V (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 13:26:21 -0500
Received: from siwi.pair.com ([209.68.5.199]:38182 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755019AbdCIS0U (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 13:26:20 -0500
Received: from [10.160.98.126] (unknown [167.220.148.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id B41CD84675;
        Thu,  9 Mar 2017 13:26:18 -0500 (EST)
Subject: Re: [PATCH 02/10] pack-objects: add --partial-by-size=n
 --partial-special
To:     Jeff King <peff@peff.net>, Jeff Hostetler <jeffhost@microsoft.com>
References: <1488994685-37403-1-git-send-email-jeffhost@microsoft.com>
 <1488994685-37403-3-git-send-email-jeffhost@microsoft.com>
 <20170309073117.g3br5btsfwntcdpe@sigill.intra.peff.net>
Cc:     git@vger.kernel.org, gitster@pobox.com, markbt@efaref.net,
        benpeart@microsoft.com, jonathantanmy@google.com
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <6157cad3-6bbd-7f2c-15bb-6487089272a7@jeffhostetler.com>
Date:   Thu, 9 Mar 2017 13:26:11 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170309073117.g3br5btsfwntcdpe@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/9/2017 2:31 AM, Jeff King wrote:
> On Wed, Mar 08, 2017 at 05:37:57PM +0000, Jeff Hostetler wrote:
>
>> From: Jeff Hostetler <git@jeffhostetler.com>
>>
>> Teach pack-objects to omit blobs from the generated packfile.
>>
>> When the --partial-by-size=n[kmg] argument is used, only blobs
>> smaller than the requested size are included.  When n is zero,
>> no blobs are included.
>>
>> When the --partial-special argument is used, git special files,
>> such as ".gitattributes" and ".gitignores" are included.
>>
>> When both are given, the union of two are included.
>
> I understand why one would want to do:
>
>   --partial-by-size=100 --partial-special
>
> and get the union. The first one restricts, and the second one adds back
> in. But I don't understand why "--partial-special" by itself makes any
> sense. Wouldn't we already be including all blobs, and it would be a
> noop?

My thought was that the "--partial-special" when used by itself
would *only* give you the .git* files (and if we had something
like a .gitsparse/ directory, everything under it).  The client
could then do a "special" clone -- mainly to get the sparse checkout
templates under .gitsparse/ and then come back for a sparse fetch
using one of them.  Somewhat of a chicken-n-egg problem, unless the
user knows the template names in advance.

>
>
> Also, I was thinking a bit on Junio's comment elsewhere on whether
> read_object_list_from_stdin() should do the same limiting. I think the
> answer is "probably not", because whoever is generating that object list
> can cull the set. You could do it today with something like:
>
>   git rev-list --objects HEAD |
>   git cat-file --batch-check='%(objectsize) %(objecttype) %(objectname) %(rest)' |
>   perl -lne 's/^(\d+) (\S+) //; print if $2 ne "blob" || $1 < 100' |
>   git pack-objects
>
> But if we are going to add this --partial-by-size for the pack-objects
> traversal, shouldn't we just add it to rev-list? Then:
>
>   git rev-list --objects --partial-by-size=100 --partial-special |
>   git pack-objects
>
> works, and you should get it in the pack-objects basically for free (I
> think you'd have to allow through the "--partial" arguments on stdin,
> and make sure the rev-list implementation is done via
> traverse_commit_list).
>
> As a bonus, I suspect it would make the --partial-special path-handling
> easier, because you'd see each tree entry rather than the fully
> constructed path (so no more monkeying around with "/").

Interesting.  Let me give that a try and see what it looks like.

>
>> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
>> index 7e052bb..2df2f49 100644
>> --- a/builtin/pack-objects.c
>> +++ b/builtin/pack-objects.c
>> @@ -77,6 +77,10 @@ static unsigned long cache_max_small_delta_size = 1000;
>>
>>  static unsigned long window_memory_limit = 0;
>>
>> +static signed long partial_by_size = -1;
>
> I would have expected this to be an off_t, though I think
> OPT_MAGNITUDE() forces you into "unsigned long". I guess it is nothing
> new for Git; we use "unsigned long" for single object sizes elsewhere,
> so systems with a 32-bit long are out of luck anyway until we fix that.
>
> The signed "long" here is unfortunate, as it limits us to 2G on such
> systems. Maybe it is not worth worrying too much about. The "big object"
> threshold is usually around 500MB. I think the failure behavior is not
> great, though (asking for "3G" would go negative and effectively be
> ignored).
>
> I think handling all cases would involve swapping out OPT_MAGNITUDE()
> for a special callback that writes the "yes, the user set this" bit in a
> separate variable.

Yeah, there is a bit of confusion there.  I used OPT_MAGNITUDE in
one place (for the argument checking), but couldn't in another place.
And I tried to pass the original string across the wire for sanity.
And I had to fight with the types a little.  It would probably be
simpler to replace that with a custom handler (or a uint64_t version
of magnitude) that would do the right thing and then use that numeric
value elsewhere.

Thanks,
Jeff


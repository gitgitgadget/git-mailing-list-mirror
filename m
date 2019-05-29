Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E05671F462
	for <e@80x24.org>; Wed, 29 May 2019 21:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbfE2V3R (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 May 2019 17:29:17 -0400
Received: from siwi.pair.com ([209.68.5.199]:59088 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbfE2V3Q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 May 2019 17:29:16 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 028A93F4023;
        Wed, 29 May 2019 17:29:16 -0400 (EDT)
Received: from [IPv6:2001:4898:6808:13e:c90f:aaf8:aafe:c1ce] (unknown [IPv6:2001:4898:a800:1010:7a45:aaf8:aafe:c1ce])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 645473F4019;
        Wed, 29 May 2019 17:29:15 -0400 (EDT)
Subject: Re: [PATCH v1 3/5] list-objects-filter: implement composite filters
To:     Matthew DeVore <matvore@comcast.net>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Matthew DeVore <matvore@google.com>, jonathantanmy@google.com,
        jrn@google.com, git@vger.kernel.org, dstolee@microsoft.com,
        jeffhost@microsoft.com, jrnieder@gmail.com, pclouds@gmail.com
References: <cover.1558484115.git.matvore@google.com>
 <1f95597eedc4c651868601c0ff7c4a4d97ca4457.1558484115.git.matvore@google.com>
 <2b47d4b1-ea62-d59e-77e0-d95dfad084e0@jeffhostetler.com>
 <xmqqh89e31fg.fsf@gitster-ct.c.googlers.com>
 <20190529150228.GC4700@comcast.net>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <9f1025ec-a3d7-c5f4-4a7a-15e4131f2b87@jeffhostetler.com>
Date:   Wed, 29 May 2019 17:29:14 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190529150228.GC4700@comcast.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/29/2019 11:02 AM, Matthew DeVore wrote:
> On Tue, May 28, 2019 at 10:59:31AM -0700, Junio C Hamano wrote:
>> Jeff Hostetler <git@jeffhostetler.com> writes:
>>
>>> In the RFC version, there was discussion [2] of the wire format
>>> and the need to be backwards compatible with existing servers and
>>> so use the "combine:" syntax so that we only have a single filter
>>> line on the wire.  Would it be better to have compliant servers
>>> advertise a "filters" (plural) capability in addition to the
> 
> This is a good idea and I hadn't considered it. It does seem to make the
> repeated filter lines a safer bet than I though.
> 
>>> existing "filter" (singular) capability?  Then the client would
>>> know that it could send a series of filter lines using the existing
>>> syntax.  Likewise, if the "filters" capability was omitted, the
>>> client could error out without the extra round-trip.
>>
>> All good ideas.
> 
> After hacking the code halfway together to make the above idea work, and
> learning quite a lot in the process, I saw set_git_option in transport.c and
> realized that all existing transport options are assumed to be ? (0 or 1) rather
> than * (0 or more). So "filter" would be the first transport option that is
> repeated.
> 
> Even though multiple reviewers have weighed in supporting repeated filter lines,
> I'm still conflicted about it. It seems the drawback to the + syntax is the
> requirement for encoding the individual filters, but this encoding is no longer
> required since the sparse:path=... filter no longer has to be supported. And the
> URL encoding, if it is ever reintroduced, is just boilerplate and is unlikely to
> change later or cause a significant maintainance burden.

Was sparse:path filter the only reason for needing all the URL encoding?
The sparse:oid form allows values <ref>:<path> and these (or at least
the <path> portion) may contain special characters.  So don't we need to
URL encode this form too?


> 
> The essence of the repeated filter line is that we need additional high-level
> machinery just for the sake of making the lower-level machinery... marginally
> simpler, hopefully? And if we ever need to add new filter combinations (like OR
> or XOR rather than AND) this repeated filter line thing will be a legacy
> annoyance (users will wonder why does repeated "filter" mean AND rather than
> one of the other supported combination methods?). Repeating filter lines seems
> like a leaky abstraction to me.
> 
> I would be helped if someone re-iterated why the repeated filter lines are a
> good idea in light of the fact that URL escaping is no longer required to make
> it work.
> 

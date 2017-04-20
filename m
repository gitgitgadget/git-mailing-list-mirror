Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B93EB1FA26
	for <e@80x24.org>; Thu, 20 Apr 2017 18:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970556AbdDTSIu (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 14:08:50 -0400
Received: from siwi.pair.com ([209.68.5.199]:21826 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S970506AbdDTSIs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 14:08:48 -0400
Received: from [10.160.98.126] (unknown [167.220.148.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 53532845B4;
        Thu, 20 Apr 2017 14:08:47 -0400 (EDT)
Subject: Re: [PATCH v1] diffcore-rename: speed up register_rename_src
To:     Jeff King <peff@peff.net>
References: <20170418194421.22453-1-git@jeffhostetler.com>
 <20170418194421.22453-2-git@jeffhostetler.com>
 <20170419013214.q35jarvmk5jhqdyi@sigill.intra.peff.net>
 <xmqqd1c9cdzi.fsf@gitster.mtv.corp.google.com>
 <20170419025608.xy5nvso6k6lb5z7g@sigill.intra.peff.net>
 <20170419031839.m2zgwywa2soejiqk@sigill.intra.peff.net>
 <40228c69-7946-3ef1-35de-4cea9b0312e4@jeffhostetler.com>
 <20170420161359.haolllw4ac5jjqx4@sigill.intra.peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <4d400fb6-201e-e1ba-cc3a-935951ab3e14@jeffhostetler.com>
Date:   Thu, 20 Apr 2017 14:08:46 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170420161359.haolllw4ac5jjqx4@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/20/2017 12:13 PM, Jeff King wrote:
> On Thu, Apr 20, 2017 at 10:00:04AM -0400, Jeff Hostetler wrote:
>
>> Perhaps the thing to learn from this (and the other ones) is that
>> we have lots of places where we are building a sorted list by
>> iterating over a sorted list.  The insert routines are general
>> purpose and cannot assume this, so they search first.  Perhaps it
>> would be clearer to have independent _append and _insert functions
>> and have the caller explicitly call the appropriate one.  The mainline
>> iterations on the existing index could just call the _append form
>> and never have to worry about searching or the negative-integer
>> return trick.  Whereas, the random iterations (such as on the
>> command's arg list), would always call the _insert form.
>
> Yes. I'd be much happier if your patch was flipping between two
> general-purpose insertion functions. And if that same trick was used on
> the dst side.
>
> Or even, given that this these functions are called from a single
> location that has sorted input, the binary search was just replaced
> completely with an append combined with a sort-check.
>
> That's not the minimal change you were going for, but I think the end
> result is simpler and more consistent.

OK, let me take a stab at something like that and
see where it takes me.

WRT your earlier comment about how often we add or delete 4M
files and then run status.  The use case that started this was a
1% sparse-checkout followed by a read-tree (which reset the
skip-worktree bits) and then status (which thought 99% of the
worktree had been deleted or maybe renamed).  There are probably
other ways to get into this state, but that's how this started.
The more subtle point is that -- for these obscenely large
values of n -- any time I see an O(n log n) operation that could
or should be O(n), I want to stop and look at it.


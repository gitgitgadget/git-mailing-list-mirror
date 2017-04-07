Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A38F220966
	for <e@80x24.org>; Fri,  7 Apr 2017 18:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934182AbdDGS1a (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Apr 2017 14:27:30 -0400
Received: from siwi.pair.com ([209.68.5.199]:38754 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933978AbdDGS10 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2017 14:27:26 -0400
Received: from [10.160.98.126] (unknown [167.220.148.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 6251384695;
        Fri,  7 Apr 2017 14:27:25 -0400 (EDT)
Subject: Re: [PATCH v6 0/3] read-cache: speed up add_index_entry
To:     Jeff King <peff@peff.net>
References: <20170406163442.36463-1-git@jeffhostetler.com>
 <20170407044626.ypsqnyxguw43gprm@sigill.intra.peff.net>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Jeff Hostetler <jeffhost@microsoft.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <6f31ee65-517e-419c-b0c1-3ccdd3f95b37@jeffhostetler.com>
Date:   Fri, 7 Apr 2017 14:27:24 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170407044626.ypsqnyxguw43gprm@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/7/2017 12:46 AM, Jeff King wrote:
> On Thu, Apr 06, 2017 at 04:34:39PM +0000, git@jeffhostetler.com wrote:
>
>> Teach add_index_entry_with_check() and has_dir_name()
>> to avoid index lookups if the given path sorts after
>> the last entry in the index.
>>
>> This saves at least 2 binary searches per entry.
>>
>> This improves performance during checkout and read-tree because
>> merge_working_tree() and unpack_trees() processes a list of already
>> sorted entries.
>
> Just thinking about this algorithmically for a moment. You're saving the
> binary search when the input is given in sorted order. But in other
> cases you're adding an extra strcmp() before the binary search begins.
> So it's a tradeoff.
>
> How often is the input sorted?  You save O(log n) strcmps for a "hit"
> with your patch, and one for a "miss". So it's a net win if we expect at
> least 1/log(n) of additions to be sorted (I'm talking about individual
> calls, but it should scale linearly either way over a set of n calls).
>
> I have no clue if that's a reasonable assumption or not.

I was seeing checkout call merge_working_tree to iterate over the
source index/trees and call add_index_entry() for each.  For example,
in a "checkout -b" like operation where both sides are the same, this
calls keep_entry() which appends the entry to the new index array.
The append path should always be taken because the iteration is being
driven from a sorted list.

I would think calls to add/stage individual files arrive in random
order, so I'm not suggesting replacing the code -- just checking the
end first.

Jeff


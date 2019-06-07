Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 673411F462
	for <e@80x24.org>; Fri,  7 Jun 2019 18:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730424AbfFGS5E (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jun 2019 14:57:04 -0400
Received: from siwi.pair.com ([209.68.5.199]:50700 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729709AbfFGS5D (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jun 2019 14:57:03 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 8A9343F4090;
        Fri,  7 Jun 2019 14:57:02 -0400 (EDT)
Received: from [IPv6:2001:4898:6808:13e:5d6e:aba4:2027:955c] (unknown [IPv6:2001:4898:a800:1012:ea2:aba4:2027:955c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 4D1563F408C;
        Fri,  7 Jun 2019 14:57:02 -0400 (EDT)
Subject: Re: Is --filter-print-omitted correct/used/needed?
To:     Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Cc:     Git List <git@vger.kernel.org>
References: <CAJoAoZktk-w40MEsRZesvkX23Xn2uMUPiO_cMHa=-xfdyVHCWg@mail.gmail.com>
 <CAP8UFD2Kyq9nrAnoj3AxQyLgiGHycLEdJbJOQx_stsepsqmX4g@mail.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <e9017ba5-5b52-9e50-96ff-743d7e2ff4df@jeffhostetler.com>
Date:   Fri, 7 Jun 2019 14:57:01 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAP8UFD2Kyq9nrAnoj3AxQyLgiGHycLEdJbJOQx_stsepsqmX4g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 6/7/2019 2:38 AM, Christian Couder wrote:
> On Thu, Jun 6, 2019 at 10:18 PM Emily Shaffer <emilyshaffer@google.com> wrote:
> 
> 
> 
>> I grepped the Git source and found that we only provide a non-NULL
>> "omitted" when someone calls "git rev-list --filter-print-omitted",
>> which we verify with a simple test case for "blobs:none", in which
>> case the "border" objects which were omitted must be the same as all
>> objects which were omitted (since blobs aren't pointing to anything
>> else). I think if we had written a similar test case with some trees
>> we expect to omit we might have noticed sooner.
> 
> It seems that --filter-print-omitted was introduced in caf3827e2f
> (rev-list: add list-objects filtering support, 2017-11-21) so I cc'ed
> Jeff.
> 
> [...]

The --filter-print-omitted was intended to print the complete list
of omitted objects.  For example, a packfile built from a filtered
command and a packfile build from the unfiltered command would differ
by exactly that set of objects.

So the discrepancy reported by the tree:1 example is incorrect.
The omitted set is the full set, not the frontier.  So when
--filter-print-omitted is used, we still have to do the full tree walk.
When not specified, we do get the perf boost because we can terminate
the tree walk early.


>> So, what do we use --filter-print-omitted for? Is anybody needing it?
>> Or do we just use it to verify this one test case? Should we fix it,
>> or get rid of it, or neither?
>
> In caf3827e2f there is:
> 
>      This patch introduces handling of missing objects to help
>      debugging and development of the "partial clone" mechanism,
>      and once the mechanism is implemented, for a power user to
>      perform operations that are missing-object aware without
>      incurring the cost of checking if a missing link is expected.
> 
> So I would say that if you think that --filter-print-omitted doesn't
> help in debugging or development, and can even be confusing, and that
> it also doesn't help performance for power users or anyone else, then
> it would make sense to remove it, unless you find a way to make it
> fulfill its original goals, or maybe other worthwhile goals.

I don't currently have a use for that (other than the existing test
cases), but we could use that in the future as a guide for the server
to put the omitted objects on a CDN, for example.

So I'd say let's leave it as is for now.


Jeff




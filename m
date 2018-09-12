Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EBBA1F404
	for <e@80x24.org>; Wed, 12 Sep 2018 19:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbeIMAre (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 20:47:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:47274 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728197AbeIMAre (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 20:47:34 -0400
Received: (qmail 8562 invoked by uid 109); 12 Sep 2018 19:41:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 12 Sep 2018 19:41:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28510 invoked by uid 111); 12 Sep 2018 19:41:46 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 12 Sep 2018 15:41:46 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Sep 2018 15:41:30 -0400
Date:   Wed, 12 Sep 2018 15:41:30 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/1] commit-reach: properly peel tags
Message-ID: <20180912194130.GA22146@sigill.intra.peff.net>
References: <pull.39.git.gitgitgadget@gmail.com>
 <948e222228d2f2868b85a425142382e63a17773a.1536762173.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <948e222228d2f2868b85a425142382e63a17773a.1536762173.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 12, 2018 at 07:22:56AM -0700, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <dstolee@microsoft.com>
> 
> The can_all_from_reach_with_flag() algorithm was refactored in 4fbcca4e
> "commit-reach: make can_all_from_reach... linear" but incorrectly
> assumed that all objects provided were commits. During a fetch
> negotiation, ok_to_give_up() in upload-pack.c may provide unpeeled tags
> to the 'from' array. The current code creates a segfault.
> 
> Add a direct call to can_all_from_reach_with_flag() in 'test-tool reach'
> and add a test in t6600-test-reach.sh that demonstrates this segfault.

Thanks, that makes a lot of sense for reproducing. I almost wonder if
the whole X_array of commits in test-reach could just go away, and we'd
feed whatever list of objects the caller happens to send. That may make
it simpler to include non-commit objects in a variety of tests.

That said, I didn't look closely at other fallout in the program from
that, so I'll defer to your judgement.

> Correct the issue by peeling tags when investigating the initial list
> of objects in the 'from' array.
> 
> Signed-off-by: Jeff King <peff@peff.net>

I'm not sure if this should just be Reported-by, since I don't know that
I actually contributed any code. ;) But for anything I might have
contributed, certainly you have my signoff.

>  	for (i = 0; i < from->nr; i++) {
> -		list[i] = (struct commit *)from->objects[i].item;
> +		struct object *from_one = from->objects[i].item;
>  
> -		if (parse_commit(list[i]) ||
> -		    list[i]->generation < min_generation)
> -			return 0;
> +		from_one = deref_tag(the_repository, from_one,
> +				     "a from object", 0);
> +		if (!from_one || from_one->type != OBJ_COMMIT) {
> +			from->objects[i].item->flags |= assign_flag;
> +			continue;
> +		}

I didn't resurrect the comment from this conditional that was in the
original code (mostly because I wasn't sure if the reasoning was still
entirely valid, or what setting the flag here actually means). But it's
probably worth saying something here to explain why it's OK to punt on
this case, and what it means to just set the flag.

> [...]

The rest of the patch looks sane to me. I didn't go through the trouble
to reproduce the segfault with the test, but it sounds like you did.

-Peff

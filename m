Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 701EE1F404
	for <e@80x24.org>; Fri,  6 Apr 2018 18:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751808AbeDFS6E (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 14:58:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:56138 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751779AbeDFS6D (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 14:58:03 -0400
Received: (qmail 23447 invoked by uid 109); 6 Apr 2018 18:58:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 06 Apr 2018 18:58:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28034 invoked by uid 111); 6 Apr 2018 18:59:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 06 Apr 2018 14:59:04 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Apr 2018 14:58:01 -0400
Date:   Fri, 6 Apr 2018 14:58:01 -0400
From:   Jeff King <peff@peff.net>
To:     Harald Nordgren <haraldnordgren@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v8] ls-remote: create '--sort' option
Message-ID: <20180406185801.GA921@sigill.intra.peff.net>
References: <20180402005248.52418-1-haraldnordgren@gmail.com>
 <20180404230110.9950-1-haraldnordgren@gmail.com>
 <CAHwyqnU4jv=wW_no4ff_E2TgvGtga1GOhZoDKd93J5MMUtLFCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHwyqnU4jv=wW_no4ff_E2TgvGtga1GOhZoDKd93J5MMUtLFCA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 05, 2018 at 01:11:34AM +0200, Harald Nordgren wrote:

> Without digging to much into the `ref-filter` code itself, it seems
> like there is an opportunity to generalize and unfify the logic
> between these two cases. As well as using `ALLOC_GROW`. But maybe that
> is best left as a follow-up task? Especially since this patch focuses
> on `ls-remote`. Seems possibly like too big of a change to start
> changing a different sub-command.

Yes and no. By refactoring we have the potential to regress another
unrelated command. But by not refactoring, we set up a potential misuse
of the other interface which may lead to more bugs down the road.

I think an important thing is to split out the refactoring steps into
their own patches, so it's easy to see that they're not hurting the
existing uses. I have some sample patches, which I'll send in a moment.

> Wouldn't a `ref_array_push()` also require `ref->symref`, maybe then
> we could pass the whole ref? It needs to be very clear that it's a
> `ref` and not a `ref_array_item` that is being pushed. Much of my
> logic here deals specifically with trying to treat a ref as
> ref_array_item.

I think it would be OK to have the push operation return the actual
item, which can then be filled in more. That's how the internal
ref-filter code does it already.

> From my viewpoint as implementer, I was very happy that I could
> implement the feature *without* invoking `filter_refs` since that
> `filter->kind` switching looks a pretty daunting. I'm not exactly sure
> what a `git ls-remote --contains HEAD` would do, maybe you could
> explain a bit more?

I agree it would be a bit larger of a retro-fit to adapt filter_refs()
for our purpose here. And since we're not doing any filtering at this
point, there's not much benefit.

Here are the refactoring patches I came up with. I think they're a
benefit to ref-filter on their own, and then it should be pretty easy
for you to build your patch on top.

  [1/3]: ref-filter: use "struct object_id" consistently
  [2/3]: ref-filter: make ref_array_item allocation more consistent
  [3/3]: ref-filter: factor ref_array pushing into its own function

 builtin/tag.c        |  2 +-
 builtin/verify-tag.c |  2 +-
 ref-filter.c         | 36 +++++++++++++++++++++++++-----------
 ref-filter.h         | 10 +++++++++-
 4 files changed, 36 insertions(+), 14 deletions(-)

-Peff

PS I'm going to be offline for a few weeks starting tomorrow, so I won't
   be responsive to this thread. :) If you like the direction, please
   feel free to pick up those patches, rebase yours on top, and then
   send them all out as a series.

   In case it's easier than applying from the list, you can fetch them
   from the "jk/ref-array-push" branch of https://github.com/peff/git.

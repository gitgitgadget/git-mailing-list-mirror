Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 784ED20A10
	for <e@80x24.org>; Thu, 28 Sep 2017 22:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750891AbdI1Wmr (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Sep 2017 18:42:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:53964 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750805AbdI1Wmq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Sep 2017 18:42:46 -0400
Received: (qmail 2893 invoked by uid 109); 28 Sep 2017 22:42:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 28 Sep 2017 22:42:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31781 invoked by uid 111); 28 Sep 2017 22:43:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 28 Sep 2017 18:43:25 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Sep 2017 18:42:44 -0400
Date:   Thu, 28 Sep 2017 18:42:44 -0400
From:   Jeff King <peff@peff.net>
To:     Olga Telezhnaya <olyatelezhnaya@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH Outreachy] mru: use double-linked list from list.h
Message-ID: <20170928224244.pi34zwifnornssqk@sigill.intra.peff.net>
References: <CAP8UFD24A8rxMfLMFmSStWnBMMeB58SqUdNoo3niQuc7LqRMMg@mail.gmail.com>
 <0102015ec7a3424b-529be659-bdb6-42c4-a48f-db264f33d53a-000000@eu-west-1.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0102015ec7a3424b-529be659-bdb6-42c4-a48f-db264f33d53a-000000@eu-west-1.amazonses.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 28, 2017 at 08:38:39AM +0000, Olga Telezhnaya wrote:

> diff --git a/packfile.c b/packfile.c
> index f69a5c8d607af..ae3b0b2e9c09a 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -876,6 +876,7 @@ void prepare_packed_git(void)
>  	for (alt = alt_odb_list; alt; alt = alt->next)
>  		prepare_packed_git_one(alt->path, 0);
>  	rearrange_packed_git();
> +	INIT_LIST_HEAD(&packed_git_mru.list);
>  	prepare_packed_git_mru();
>  	prepare_packed_git_run_once = 1;
>  }

I was thinking on this hunk a bit more, and I think it's not quite
right.

The prepare_packed_git_mru() function will clear the mru list and then
re-add each item from the packed_git list. But by calling
INIT_LIST_HEAD() here, we're effectively clearing the packed_git_mru
list, and we end up leaking whatever was on the list before.

So for the first call to prepare_packed_git, we really need this
INIT_LIST_HEAD() call. But for subsequent calls (which come from
reprepare_packed_git()), we must not call it.

There are a few ways to work around it that I can think of:

  1. Check whether packed_git_mru.list.head is NULL, and only initialize
     in that case.

  2. Use a static initializer for packed_git_mru.list, so that we don't
     have do the first-time initializing here.

  3. Teach reprepare_packed_git() to do the mru_clear() call, so that we
     know the list is empty when we get here.

One final and more invasive option is to stop regenerating the
packed_git_mru list from scratch during each prepare_packed_git(). I did
it that way so that we start with the same order that
rearrange_packed_git() will give us, but I'm not sure how much value
that has in practice (it probably had a lot more when we didn't have the
mru, and the time-sorted pack order helped find recent objects more
quickly).

The alternative would be to just teach install_packed_git() to add each
newly-added pack to the mru list, and then never clear the list (and we
wouldn't need an mru_clear() at all, then).

-Peff

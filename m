Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA28A20A10
	for <e@80x24.org>; Thu, 28 Sep 2017 21:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751697AbdI1VEm (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Sep 2017 17:04:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:53800 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751129AbdI1VEm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Sep 2017 17:04:42 -0400
Received: (qmail 30866 invoked by uid 109); 28 Sep 2017 21:04:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 28 Sep 2017 21:04:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30543 invoked by uid 111); 28 Sep 2017 21:05:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 28 Sep 2017 17:05:21 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Sep 2017 17:04:39 -0400
Date:   Thu, 28 Sep 2017 17:04:39 -0400
From:   Jeff King <peff@peff.net>
To:     Olga Telezhnaya <olyatelezhnaya@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH Outreachy] mru: use double-linked list from list.h
Message-ID: <20170928210439.msmzxlih4ykrsmee@sigill.intra.peff.net>
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

> Simplify mru.c, mru.h and related code by reusing the double-linked
> list implementation from list.h instead of a custom one.

The commit message is a good reason to talk about why we want to do
this. In this case, the answer may be fairly obvious. But I sometimes
find that things that are obvious to me as the patch author are not
quite as obvious to people reading it later (either reviewing, or six
months from now when they are hunting the cause of a bug).

> -void mru_mark(struct mru *mru, struct mru_entry *entry)
> +void mru_mark(struct mru *head, struct mru *entry)
>  {
> -	/* If we're already at the front of the list, nothing to do */
> -	if (mru->head == entry)
> -		return;
> -
> -	/* Otherwise, remove us from our current slot... */
> -	if (entry->prev)
> -		entry->prev->next = entry->next;
> -	if (entry->next)
> -		entry->next->prev = entry->prev;
> -	else
> -		mru->tail = entry->prev;
> -
> -	/* And insert us at the beginning. */
> -	entry->prev = NULL;
> -	entry->next = mru->head;
> -	if (mru->head)
> -		mru->head->prev = entry;
> -	mru->head = entry;
> +	/* To mark means to put at the front of the list. */
> +	list_del(&entry->list);
> +	list_add(&entry->list, &head->list);
>  }

Nice, this hunk is very satisfying. :)

> -void mru_clear(struct mru *mru)
> +void mru_clear(struct mru *head)
>  {
> -	struct mru_entry *p = mru->head;
> -
> -	while (p) {
> -		struct mru_entry *to_free = p;
> -		p = p->next;
> +	struct list_head *p1;
> +	struct list_head *p2;
> +	struct mru *to_free;
> +	
> +	list_for_each_safe(p1, p2, &head->list) {
> +		to_free = list_entry(p1, struct mru, list);
>  		free(to_free);
>  	}
> -	mru->head = mru->tail = NULL;
> +	INIT_LIST_HEAD(&head->list);

Two minor style comments here:

  - Perhaps "tmp" is a better name than "p2" for the second argument of
    a list_for_each_safe, as it makes it less likely to confuse p1 and
    p2 (though admittedly the whole function is short enough that it
    probably doesn't matter much either way).

  - It's a good practice to declare variables in the smallest scope
    possible. So I think the declaration of to_free could go inside the
    loop.

    You could actually get rid of it entirely with:

      free(list_entry(p1, struct mru, list));

    but I certainly don't mind using a variable for better readability.

> @@ -29,17 +28,13 @@
>   * you will begin traversing the whole list again.
>   */
>  
> -struct mru_entry {
> -	void *item;
> -	struct mru_entry *prev, *next;
> -};
> -
>  struct mru {
> -	struct mru_entry *head, *tail;
> +	struct list_head list;
> +        void *item;
>  };

The decision to get rid of the "mru versus mru_entry" distinction
surprised me a little. In the original, a "struct mru" represented the
whole list. In the list.h implementation, a "struct list_head" serves
that purpose, as a sentinel value. But that sentinel doesn't need to
have an "item", right? I.e., we could have:

  struct mru {
          struct list_head head;
  };

  struct mru_entry {
          void *item;
	  struct list_head list;
  };

As I said in my response to Junio (and as we discussed a little
off-list), I think we can eventually move to having no structs at all
(just list_heads embedded inside the existing packfile objects). At
which point the user of the API would just declare:

  LIST_HEAD(packed_git_mru);

themselves. So I'm actually fine with this direction if we're using it
as the "middle step" that I mentioned there.

>  struct mru {
> -	struct mru_entry *head, *tail;
> +	struct list_head list;
> +        void *item;
>  };

The funny indentation in this diff shows that "void *item" is indented
with spaces, not a tab.

> [...]

I pointed out a few minor bits, but overall this is looking very strong.
Great work!

-Peff

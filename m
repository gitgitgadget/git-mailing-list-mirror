Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 866491F405
	for <e@80x24.org>; Thu,  9 Aug 2018 21:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbeHJAX1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 20:23:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:49216 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727268AbeHJAX1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 20:23:27 -0400
Received: (qmail 6193 invoked by uid 109); 9 Aug 2018 21:56:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 09 Aug 2018 21:56:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14225 invoked by uid 111); 9 Aug 2018 21:56:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 09 Aug 2018 17:56:41 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Aug 2018 17:56:37 -0400
Date:   Thu, 9 Aug 2018 17:56:37 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        git <git@vger.kernel.org>, Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH 02/10] string-list.h: add string_list_pop function.
Message-ID: <20180809215637.GA12441@sigill.intra.peff.net>
References: <20180808221752.195419-1-sbeller@google.com>
 <20180808221752.195419-3-sbeller@google.com>
 <CAN0heSqjazimYu4de=xCQ9epSxezVyKPQQ16amZZvoaBh_SKdQ@mail.gmail.com>
 <xmqqzhxv9qkj.fsf@gitster-ct.c.googlers.com>
 <20180809214148.GD11342@sigill.intra.peff.net>
 <CAGZ79kZK=5gftetj3XLTbu-n3WKwRUQQDj12yxDBV0WEN8gg9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kZK=5gftetj3XLTbu-n3WKwRUQQDj12yxDBV0WEN8gg9Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 09, 2018 at 02:52:29PM -0700, Stefan Beller wrote:

> > In many cases you can just do:
> >
> >   while (list->nr) {
> >         work_on(list->items[list->nr - 1]);
> >         list_remove(list, list->nr - 1);
> >   }
> >
> > and then all of those memory ownership issues like:
> 
> [...]
> >
> > just go away. :)
> 
> The only complication here is the lack of list_remove(index),
> we do have list_remove(string), which internally searches the
> item and removes it. Hence I did not want to use it.

Heh, I almost dug into that more.

I think you could have helpers to spell the two lines above even more
nicely:

  while (list->nr) {
        work_on(list_top(list));
	list_pop(list); /* note this doesn't return anything! */
  }

But yes, it's not possible with the current functions.

> Another idea I had was to keep the list immutable (except amending,
> just like a constitution ;-) and store an index of how far we got in that
> list already. That wastes memory for keeping entries around, but is safe
> for memory due to its nature.

You can also use a list.h linked-list. Then removal from the list and
freeing are two separate operations (but it exercises your malloc a lot
more if you're constantly pushing and popping).

> > Where that falls down is if you really need work_on() to put more items
> > on the stack, but only after you've removed the current top. But then
> > writing it out may still be nicer, because it makes it clear you have to
> > do:
> >
> >   const char *cur_string = xstrdup(list->items[list->nr-1].string);
> 
> Another way would be to use
> 
>   string_list_pop(&list, &string_dst, &util_dst);
> i.e.
>   /* Returns 0 if the dst was filled */
>   int (struct string_list *, char **, void**)
> 
> as then we do not expose the internals and would not have issues
> with reallocs.

Yes, I almost suggested that, but there's the question of memory
ownership of string_dst. Does it need freed or not? Is that answer
dependent on the strdup_strings flag?

> > if you want the data to live past the removal.
> 
> In the code proposed there are no additions (hence no reallocs)
> and the need for the data is short lived.
> 
> But I can see how the design was just fitting my purpose and
> we could come up with some better API.

Yeah, I didn't actually dig into your use case. I just want to make sure
we don't add a crappy function to our API. ;)

-Peff

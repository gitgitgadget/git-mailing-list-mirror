Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73B201F405
	for <e@80x24.org>; Thu,  9 Aug 2018 21:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbeHJAIe (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 20:08:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:49146 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727268AbeHJAIe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 20:08:34 -0400
Received: (qmail 5611 invoked by uid 109); 9 Aug 2018 21:41:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 09 Aug 2018 21:41:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14001 invoked by uid 111); 9 Aug 2018 21:41:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 09 Aug 2018 17:41:52 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Aug 2018 17:41:48 -0400
Date:   Thu, 9 Aug 2018 17:41:48 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Git Mailing List <git@vger.kernel.org>, hvoigt@hvoigt.net
Subject: Re: [PATCH 02/10] string-list.h: add string_list_pop function.
Message-ID: <20180809214148.GD11342@sigill.intra.peff.net>
References: <20180808221752.195419-1-sbeller@google.com>
 <20180808221752.195419-3-sbeller@google.com>
 <CAN0heSqjazimYu4de=xCQ9epSxezVyKPQQ16amZZvoaBh_SKdQ@mail.gmail.com>
 <xmqqzhxv9qkj.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzhxv9qkj.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 09, 2018 at 02:29:32PM -0700, Junio C Hamano wrote:

> >> +struct string_list_item *string_list_pop(struct string_list *list)
> >> +{
> >> +       if (list->nr == 0)
> >> +               return 0;
> >
> > return NULL, not 0.
> 
> It is OK to return NULL, which may make the caller a bit simpler,
> i.e.
> 
> 	while (item = list_pop(list))
> 		work_on(item);
> 
> but if we consider it a good discipline for the caller to see if
> there are still things on the stack before attempting to pop, then
> instead of returning NULL, we can have BUG("") there, which requires
> the caller to be more like this:
> 
> 	while (list->nr)
> 		work_on(list_pop(list));
> 
> which is not so bad.

In many cases you can just do:

  while (list->nr) {
	work_on(list->items[list->nr - 1]);
	list_remove(list, list->nr - 1);
  }

and then all of those memory ownership issues like:

> > The memory ownership is now with the caller. That is, the caller needs
> > to check/know `list->strdup_strings` and know `free_util` to be able to
> > properly free all memory.
> 
> > OTOH, the pointer returned by this function is only guaranteed to be
> > valid until you start inserting into the list (well, you can do one
> > insertion per pop without worrying, but that's quite detailed
> > implementation knowledge).
> 
> Yes, it is a more grave limitation when using string_list as a
> stack.  A single realloc() and you are dead X-<.

just go away. :)

Where that falls down is if you really need work_on() to put more items
on the stack, but only after you've removed the current top. But then
writing it out may still be nicer, because it makes it clear you have to
do:

  const char *cur_string = xstrdup(list->items[list->nr-1].string);

if you want the data to live past the removal.

-Peff

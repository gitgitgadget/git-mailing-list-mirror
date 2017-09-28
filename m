Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A955220A10
	for <e@80x24.org>; Thu, 28 Sep 2017 20:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751613AbdI1UrI (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Sep 2017 16:47:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:53778 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751409AbdI1UrH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Sep 2017 16:47:07 -0400
Received: (qmail 30089 invoked by uid 109); 28 Sep 2017 20:47:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 28 Sep 2017 20:47:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30457 invoked by uid 111); 28 Sep 2017 20:47:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 28 Sep 2017 16:47:46 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Sep 2017 16:47:05 -0400
Date:   Thu, 28 Sep 2017 16:47:05 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Olga Telezhnaya <olyatelezhnaya@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH Outreachy] mru: use double-linked list from list.h
Message-ID: <20170928204705.7ixxspiflmhsdh7d@sigill.intra.peff.net>
References: <CAP8UFD24A8rxMfLMFmSStWnBMMeB58SqUdNoo3niQuc7LqRMMg@mail.gmail.com>
 <0102015ec7a3424b-529be659-bdb6-42c4-a48f-db264f33d53a-000000@eu-west-1.amazonses.com>
 <xmqq8tgz13x7.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8tgz13x7.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 28, 2017 at 08:03:00PM +0900, Junio C Hamano wrote:

> > -	for (entry = packed_git_mru.head; entry; entry = entry->next) {
> > +	list_for_each(pos, &packed_git_mru.list) {
> > +		struct mru *entry = list_entry(pos, struct mru, list);
> >  		struct packed_git *p = entry->item;
> >  		off_t offset;
> 
> I was a bit surprised to see a change outside mru.[ch] like this
> one.  The reason why I was surprised was because I expected mru.[ch]
> would offer its own API that encapsulates enumeration like this one
> and this patch would just be reimplementing that API using the list
> API, instead of rewriting the users of mru API to directly access
> the list API.
> 
> Alas, there is no such mru API that lets a mru user to iterate over
> elements, so the original of the above code were using mru's
> implementation detail directly.
> 
> We probably want to invent mru_for_each() that hides the fact that
> mru is implemented in terms of list_head from the users of mru API
> and use it here.

I agree that the caller would be a little shorter with an mru-specific
iterator (e.g., we could probably do the list_entry() part
automatically).

But I also think this patch may be a stepping stone to dropping "struct
mru" entirely, and just pushing a "struct list_head mru" into the
packed_git object itself (or of course any object you like). At which
point we'd just directly use the list iterators anyway.

(One could argue that if that's our end goal, we could go straight
there. But I think this middle state has value, because the individual
steps are easier to verify).

> > @@ -8,18 +10,15 @@
> >   *
> >   *   // Create a list.  Zero-initialization is required.
> >   *   static struct mru cache;
> > - *   mru_append(&cache, item);
> > - *   ...
> > + *   INIT_LIST_HEAD(&cache.list);
> 
> "Zero-initialization is required." is no longer true, it seems, and
> the comment above needs to be updated, right?
> 
> More importantly, this leaks to the user of the API the fact that
> mru is internally implemented in terms of the list API, which is
> not necessary (when we want to update the implementation later, we'd
> need to update all the users again).  Perhaps you'd want
> 
> 	INIT_MRU(cache);
> 
> which is #define'd in this file, perhaps like so:
> 
> 	#define INIT_MRU(mru)	INIT_LIST_HEAD(&((mru).list))

I'd make the same claims here as above (both that I agree your proposed
interface looks nicer, but also that I think we eventually do want to
expose that this is tightly coupled with list.h).

-Peff

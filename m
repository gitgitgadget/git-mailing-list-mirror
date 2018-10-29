Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B87711F453
	for <e@80x24.org>; Mon, 29 Oct 2018 20:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729563AbeJ3FCG (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Oct 2018 01:02:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:59784 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726983AbeJ3FCG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Oct 2018 01:02:06 -0400
Received: (qmail 1134 invoked by uid 109); 29 Oct 2018 20:11:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 29 Oct 2018 20:11:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22614 invoked by uid 111); 29 Oct 2018 20:11:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 29 Oct 2018 16:11:08 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Oct 2018 16:11:51 -0400
Date:   Mon, 29 Oct 2018 16:11:51 -0400
From:   Jeff King <peff@peff.net>
To:     Ben Peart <peartben@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 06/10] preload-index.c: remove #ifdef NO_PTHREADS
Message-ID: <20181029201151.GA32277@sigill.intra.peff.net>
References: <20181027071003.1347-1-pclouds@gmail.com>
 <20181027173008.18852-1-pclouds@gmail.com>
 <20181027173008.18852-7-pclouds@gmail.com>
 <0ee246db-d781-9a42-8b8c-3e98c132b0ae@gmail.com>
 <CACsJy8CYnngeA8JcFy83qYxKj3saB21Y32VV3R5o1PY_tkAq5Q@mail.gmail.com>
 <2935e3e8-c529-4292-baa3-fc3c9074028b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2935e3e8-c529-4292-baa3-fc3c9074028b@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 29, 2018 at 02:05:58PM -0400, Ben Peart wrote:

> On 10/29/2018 1:26 PM, Duy Nguyen wrote:
> > On Mon, Oct 29, 2018 at 6:21 PM Ben Peart <peartben@gmail.com> wrote:
> > > @@ -114,6 +104,9 @@ static void preload_index(struct index_state *index,
> > >           threads = index->cache_nr / THREAD_COST;
> > >           if ((index->cache_nr > 1) && (threads < 2) &&
> > > git_env_bool("GIT_TEST_PRELOAD_INDEX", 0))
> > >                   threads = 2;
> > > +       cpus = online_cpus();
> > > +       if (threads > cpus)
> > > +               threads = cpus;
> > >           if (threads < 2)
> > >                   return;
> > >           trace_performance_enter();
> > 
> > Capping the number of threads to online_cpus() does not always make
> > sense. In this case (or at least the original use case where we stat()
> > over nfs) we want to issue as many requests to nfs server as possible
> > to reduce latency and it has nothing to do with how many cores we
> > have. Using more threads than cores might make sense since threads are
> > blocked by nfs client, but we still want to send more to the server.
> > 
> 
> That makes sense.  Some test will be necessary then.
> 
> I guess HAVE_THREADS is functionally the same as online_cpus() == 1. For
> some reason, I prefer the latter - probably because I'm typically already
> calling it and so it doesn't feel like a 'special' value/test I have to
> remember. I just know I need to make sure the logic works correctly with any
> number of cps greater than zero. :-)

I don't think they're functionally the same. If you see online_cpus()
== 1, you are in one of two cases:

  - the system supports threads, but CPU-bound tasks should stick to a
    single thread

  - the system does not even support threading, and calling
    pthread_create() will give you ENOSYS

In the first case, if your task is _not_ CPU bound (i.e., the stat()
thing), then you want to distinguish those cases.

I'm not sure if I'm violently agreeing, but it just wasn't clear to me
from the above discussion that we all agreed that HAVE_THREADS is still
necessary in some cases.

(I do think in cases where it is not, that we would do just as well to
avoid it; if that is all you were saying, then I agree. ;) ).

-Peff

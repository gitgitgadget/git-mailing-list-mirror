Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EA881F453
	for <e@80x24.org>; Mon, 29 Oct 2018 14:25:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbeJ2XOa (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 19:14:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:58984 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725967AbeJ2XOa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 19:14:30 -0400
Received: (qmail 20469 invoked by uid 109); 29 Oct 2018 14:25:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 29 Oct 2018 14:25:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17929 invoked by uid 111); 29 Oct 2018 14:24:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 29 Oct 2018 10:24:54 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Oct 2018 10:25:37 -0400
Date:   Mon, 29 Oct 2018 10:25:37 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org, Ben Peart <peartben@gmail.com>
Subject: Re: [PATCH 06/10] grep: remove #ifdef NO_PTHREADS
Message-ID: <20181029142536.GE17668@sigill.intra.peff.net>
References: <20181027071003.1347-1-pclouds@gmail.com>
 <20181027071003.1347-7-pclouds@gmail.com>
 <20181027074443.GE26685@sigill.intra.peff.net>
 <xmqqo9bd8pko.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo9bd8pko.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 29, 2018 at 11:16:39AM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Cases like this are kind of weird. I'd expect to see wait_all() return
> > immediately when !HAVE_THREADS. But we don't need to, because later we
> > do this:
> >
> >> -	if (num_threads)
> >> +	if (HAVE_THREADS && num_threads)
> >>  		hit |= wait_all();
> >
> > Which I think works, but it feels like we're introducing some subtle
> > dependencies about which functions get called in which cases. I'd hoped
> > in general that the non-threaded code paths could mostly just collapse
> > down into the same as the "threads == 1" cases, and we wouldn't have to
> > ask "are threads even supported" in a lot of places.
> 
> True, but the way "grep" code works with threads is already strange,
> and I suspect that the subtle strangeness you feel mostly comes from
> that.  The single threaded code signaled "hit" with return value of
> individual functions like grep_file(), but the meaning of return
> value from them is changed to "does not matter--we do not have
> meaningful result yet at this point" when threading is used.
> 
> In the new world order where "threading is the norm but
> single-threaded is still supported", I wonder if we would want to
> drive the single threaded case the same way with the add_work(run)
> interface and return the "did we see hits?" etc. from the same (or
> at lesat "more similar than today's") interface, so that the flow of
> data smells the same in both cases.

Right, your second paragraph here is a better statement of what I was
trying to get at. ;)

But if the problem is simply that we are not quite there yet in the grep
code, I am OK with taking this as the first pass, and knowing that there
is more cleanup to be done later (though that sort of thing is IMHO very
useful in a commit message).

-Peff

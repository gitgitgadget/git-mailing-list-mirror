Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CEF61F453
	for <e@80x24.org>; Thu, 18 Oct 2018 06:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbeJROsS (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 10:48:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:44418 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727357AbeJROsS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Oct 2018 10:48:18 -0400
Received: (qmail 16252 invoked by uid 109); 18 Oct 2018 06:48:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 18 Oct 2018 06:48:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27545 invoked by uid 111); 18 Oct 2018 06:47:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 18 Oct 2018 02:47:59 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Oct 2018 02:48:46 -0400
Date:   Thu, 18 Oct 2018 02:48:46 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>, git@vger.kernel.org,
        Bob Peterson <rpeterso@redhat.com>
Subject: Re: [RFC] revision: Add --sticky-default option
Message-ID: <20181018064845.GB23537@sigill.intra.peff.net>
References: <20181016212438.30176-1-agruenba@redhat.com>
 <20181017091215.GA2052@sigill.intra.peff.net>
 <CAHc6FU5mXL2j=jL=LqtRt30uBt8tGop350FnwK845fci-Qc=tg@mail.gmail.com>
 <20181017181350.GB28326@sigill.intra.peff.net>
 <xmqqva60uedt.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqva60uedt.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 18, 2018 at 12:23:26PM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I'd probably call it something verbose and boring like
> > --use-default-with-uninteresting or --default-on-negative.
> > I dunno.
> 
> These two names are improvement, but there needs a hint that the
> change we are interested in is to use default even when revs are
> given as long as ALL of them are negative ones.  Which in turn means
> there is NO positive ones given.
> 
> So perhaps "--use-default-without-any-positive".

Yeah, though that's getting pretty long. Another way is probably to say
"only" more clearly. Like "--default-on-only-negative" or something.

> Having said that, I have to wonder how serious a breakage we are
> going to cause to established users and scripts if we made this
> change without any explicit option.  After all, it would be rather
> obvious that people will get a history with some commits (or none at
> all) when they were expecting no output that the "default behaviour"
> has changed.  I also wonder how would scripts take advantage of the
> current "defeat --default as soon as we see any rev, even a negative
> one"---in short, I am not sure if the theoretical regression this
> new "option" is trying to avoid is worth avoiding in the first
> place.

Just to play devil's advocate, how about this:

  git log --branches=jk/* --not origin/master

Right now that shows nothing if there are no matching branches. But I
think under the proposed behavior, it would start showing HEAD, which
seems counter-intuitive.

Or are we going to count any positive selector as a positive ref, even
if it matches nothing? I could buy that, though it means that the
command above is subtly different from one or both of:

  branches() {
    git for-each-ref --format='%(refname)' refs/heads/jk/*
  }

  # is --stdin a selector, too?
  branches | git log --stdin --not origin/master

  # here we have no idea that the user did a query and must show HEAD
  git log $(branches) --not origin/master

> Is there a way to say "usually this command has built-in --default=HEAD
> behaviour, but I am declining that" already, i.e. 
> 
>     $ git log --no-default $REVS

I don't think we have that, but regardless of this patch, it seems like
a potentially useful thing. I think we mostly get around it by the fact
that scripts ought to be using "rev-list", and it does not have such a
default that needs to be overridden.

-Peff

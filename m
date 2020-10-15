Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F93C433DF
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 01:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E97022254
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 01:36:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387776AbgJOBgI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Oct 2020 21:36:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:60572 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728457AbgJOBgI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Oct 2020 21:36:08 -0400
Received: (qmail 19316 invoked by uid 109); 15 Oct 2020 01:36:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 15 Oct 2020 01:36:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23821 invoked by uid 111); 15 Oct 2020 01:36:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Oct 2020 21:36:07 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 14 Oct 2020 21:36:07 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>
Subject: Re: [RFC] CodingGuidelines: mark external declarations with "extern"
Message-ID: <20201015013607.GA388244@coredump.intra.peff.net>
References: <xmqq8scgzqis.fsf@gitster.c.googlers.com>
 <20201009015505.GB1314@generichostname>
 <xmqqtuv4uncn.fsf@gitster.c.googlers.com>
 <xmqqy2kfryiu.fsf@gitster.c.googlers.com>
 <xmqqtuv3ryhr.fsf_-_@gitster.c.googlers.com>
 <20201009195701.GA967869@coredump.intra.peff.net>
 <xmqqpn5rrvfg.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpn5rrvfg.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 09, 2020 at 01:33:39PM -0700, Junio C Hamano wrote:

> >> [...]By doing so, we would also prevent a
> >> mistake of not writing "extern" when we need to (i.e. decls of data
> >> items, that are not functions) when less experienced developers try
> >> to mimic how the existing surrounding declarations are written.
> >
> > but to my recollection that has not been a big problem. And it's one
> > that's usually easily caught by the compiler. A missing "extern" on a
> > variable will usually get you a multiple-definition warning at
> > link-time (if you manage to also omit the actual definition you won't
> > see that, though "make sparse" will warn that your variable ought to be
> > static).
> 
> Not really, that is where the "common" extension comes in, to help
> us with it hurt others without it, unknowingly X-<.

As others noted, gcc 10 actually does complain about this. And we can
easily stick -fno-common into the DEVELOPER knobs, if it's something we
want to catch (I had actually forgotten it wasn't the default).

That said....

> And I have a strong preference, after thinking about it, to have
> "extern" in front in the declarations.  It gives another clue for
> patterns I feed to "git grep" to latch onto, and help my eyes to
> scan and tell decls and defns apart in the output.  The benefit
> alone is worth the extra 7 columns in front spent, which you call
> "clutter".

I still don't like it, and I'm convinced spending any effort to switch
between the two styles is a waste of time. But it's absolutely not the
hill I want to die on, so if you feel strongly, go for it.

> > +void set_error_routine(report_fn routine);
> > +void set_warn_routine(report_fn routine);
> > +report_fn get_error_routine(void);
> > +report_fn get_warn_routine(void);
> 
> these are good, but they are better with "extern" in front in a
> header file to make it clear they are declarations and not
> definitions when they appear in "git grep" output.

I see you picked up my patch as jk/report-fn-typedef, but applied it
directly on v2.28, and not on top of your "drop these extra externs"
patch. That makes sense if we're not going to remove them, but then your
conflict resolution shows my patch as removing them. :)

If we're going to keep them, it should probably leave them in the
existing spots? Or I guess it is OK as-is if you're planning to add them
back in to all of the functions shortly after, not just the ones that
already had extern on them.

-Peff

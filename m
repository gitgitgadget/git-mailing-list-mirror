Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E21C433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 05:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E241C6112F
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 05:43:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbhIUFoe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 01:44:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:51492 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229441AbhIUFod (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 01:44:33 -0400
Received: (qmail 3650 invoked by uid 109); 21 Sep 2021 05:43:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 21 Sep 2021 05:43:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29160 invoked by uid 111); 21 Sep 2021 05:43:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 21 Sep 2021 01:43:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 21 Sep 2021 01:43:05 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Carlo Arenas <carenas@gmail.com>, Git List <git@vger.kernel.org>,
        Hamza Mahfooz <someguy@effective-light.com>
Subject: Re: [PATCH 1/5] grep: stop modifying buffer in strip_timestamp
Message-ID: <YUlw6V7AL8l6mbSh@coredump.intra.peff.net>
References: <YUlVZk1xXulAqdef@coredump.intra.peff.net>
 <YUlVsLkFGRfRqpKG@coredump.intra.peff.net>
 <CAPUEsphSyZB-vtubjYhN_5Gy3Zv0HQ=fH=+G8kMYzJyrOLXPxQ@mail.gmail.com>
 <CAPig+cQnC1LLPtuC0qVX7EQ_ki4pev6scRox3utA45XeLHfGig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cQnC1LLPtuC0qVX7EQ_ki4pev6scRox3utA45XeLHfGig@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 21, 2021 at 01:24:41AM -0400, Eric Sunshine wrote:

> On Tue, Sep 21, 2021 at 1:18 AM Carlo Arenas <carenas@gmail.com> wrote:
> > On Mon, Sep 20, 2021 at 9:09 PM Jeff King <peff@peff.net> wrote:
> > > @@ -971,7 +966,7 @@ static int match_one_pattern(struct grep_pat *p, char *bol, char *eol,
> > >                 switch (p->field) {
> > >                 case GREP_HEADER_AUTHOR:
> > >                 case GREP_HEADER_COMMITTER:
> > > -                       saved_ch = strip_timestamp(bol, &eol);
> > > +                       strip_timestamp(bol, &eol);
> >
> > Why not something like (plus added error handling, even if it seems
> > the original didn't have them)?
> >
> >   eol = strrchr(bol, '>');
> 
> strrchr() would search backward from the NUL, not from `eol`, thus
> would not be a faithful conversion (and might not be safe, though I
> didn't dig through all the callers).

Right. The point is that we should be respecting "eol" here in the first
place. Plus the final result is the character _after_ the '>'. Plus when
it returns NULL, you'd want to leave "eol" untouched (stripping
nothing).

So yeah, I'm sure it could be rewritten around memrchr() or something,
but I doubt it would be much shorter, and the chance of introducing an
off-by-one seems non-trivial. :)

-Peff

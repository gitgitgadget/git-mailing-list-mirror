Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B326CC2D0E4
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 07:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D14E20684
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 07:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729871AbgKXHJj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 02:09:39 -0500
Received: from cloud.peff.net ([104.130.231.41]:39848 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729538AbgKXHJj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 02:09:39 -0500
Received: (qmail 32430 invoked by uid 109); 24 Nov 2020 07:09:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 24 Nov 2020 07:09:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11919 invoked by uid 111); 24 Nov 2020 07:09:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 24 Nov 2020 02:09:38 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 24 Nov 2020 02:09:38 -0500
From:   Jeff King <peff@peff.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Dominik Salvet <dominik.salvet@gmail.com>
Subject: Re: [RFC/PATCH] Add fetch.updateHead option
Message-ID: <X7yxsl9/L4SLiuCW@coredump.intra.peff.net>
References: <20201118091219.3341585-1-felipe.contreras@gmail.com>
 <20201120235203.GA353076@coredump.intra.peff.net>
 <CAMP44s1LwYCMa3a7QyUBX2GRAu3XkRYPF1yy0DTQbUh+9eHxcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMP44s1LwYCMa3a7QyUBX2GRAu3XkRYPF1yy0DTQbUh+9eHxcg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 20, 2020 at 07:41:48PM -0600, Felipe Contreras wrote:

> > > +static void update_head(int config, const struct ref *head, const struct remote *remote)
> > > +{
> > > +     struct strbuf ref = STRBUF_INIT, target = STRBUF_INIT;
> > > +     const char *r, *head_name = NULL;
> > > +
> > > +     if (!head || !head->symref || !remote)
> > > +             return;
> >
> > I'd expect us to return early here, as well, if the config is set to
> > "never". I think your function will usually still do the right thing
> > (because we return early before writing), but it makes a pointless
> > lookup of the current origin/HEAD. But see below.
> 
> If the config is set to "never", the function update_head is never
> called, since the boolean need_update_head is never set in the outer
> function.

True.

> I don't like the convolutedness of this approach, but couldn't think
> of anything better.

In general, I think keeping as much logic as possible in update_head()
makes sense, rather than the caller. We don't need to avoid running
update_head() when the config is "never" if it is a true noop in that
case.

Unfortunately, we do still need to make a decision on whether to send a
request for "HEAD" to the other side in some cases, so some logic has to
be there.

But if we don't send such a request, but we _do_ find out about HEAD
somehow (e.g., because the user said "git fetch origin HEAD", which
seems like an obvious thing for someone to try in this case), we
probably should trigger the function.

> > since otherwise it doesn't ask about HEAD in a v2 exchange. What about:
> >
> >   git fetch origin master
> >
> > That won't report on HEAD either, even with your patch, because it hits
> > the part of the conditional before your "else if". What should it do?  I
> > can see an argument for "nothing, we only update head on full configured
> > fetches", but if so we should definitely make that clear in the
> > documentation. I can also see an argument for "always, if we happen to
> > have heard about it" (just like we opportunistically update tracking
> > refs even if they are fetched by name into FETCH_HEAD).
> 
> I don't see the point in complicating the code for those corner-cases.

I would think:

  git pull origin master

isn't that much of a corner case, and people would expect a HEAD update
to trigger (especially if that HEAD is master). That will run "git fetch
origin master" under the hood (and update both FETCH_HEAD and
refs/remotes/origin/master).

> And I also don't see how HEAD can be fetched unless we specifically
> ask for it. What would that command look like?

I think it would be nice if any of:

  - git fetch

  - git fetch origin

  - git fetch origin master

  - git fetch origin HEAD

triggered the auto-update, along with their git-pull equivalents. In the
first three, v2 protocol will require mentioning HEAD as a ref-prefix.

> Also, there's two optimizations that apparently went unnoticed:
> 
> 1. In the case of "missing". We could preemptively check if there's
> already an "origin/HEAD" before adding "HEAD" to the prefixes (and
> setting need_update_head). That would probably complicate the code.

Hmm. That might be worth doing, as it does involve extra network traffic
(and the server-side lookup is more complicated, as it looks up all
possible variants of HEAD). But it is only a few bytes. I guess it would
involve saving the value of origin/HEAD between the two calls, but that
doesn't seem all that hard.

But I'd also be OK with just unconditionally asking for HEAD (but as
above, I think it should happen even with a refspec, and anytime we hear
about HEAD we should consider updating the symref).

-Peff

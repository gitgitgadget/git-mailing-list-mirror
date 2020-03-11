Return-Path: <SRS0=DQ4e=44=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09643C4CECE
	for <git@archiver.kernel.org>; Wed, 11 Mar 2020 19:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5BE72074A
	for <git@archiver.kernel.org>; Wed, 11 Mar 2020 19:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731040AbgCKTKX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Mar 2020 15:10:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:36696 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1731030AbgCKTKX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Mar 2020 15:10:23 -0400
Received: (qmail 3430 invoked by uid 109); 11 Mar 2020 19:10:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 11 Mar 2020 19:10:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22162 invoked by uid 111); 11 Mar 2020 19:19:44 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 11 Mar 2020 15:19:44 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 11 Mar 2020 15:10:21 -0400
From:   Jeff King <peff@peff.net>
To:     Robert Dailey <rcdailey.lists@gmail.com>
Cc:     Git <git@vger.kernel.org>
Subject: Re: Using push.default with push.remote.push
Message-ID: <20200311191021.GA27978@coredump.intra.peff.net>
References: <CAHd499BhLe0xF_k2ASV=ZuM7LVvxui_cxzB9UrJ2MDCyyNUmtw@mail.gmail.com>
 <20200311162517.GA27893@coredump.intra.peff.net>
 <CAHd499AGQ5k7ON+YY84b6LY1sh9MOw8fsrE2shOibujX1iKeiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHd499AGQ5k7ON+YY84b6LY1sh9MOw8fsrE2shOibujX1iKeiQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 11, 2020 at 11:56:05AM -0500, Robert Dailey wrote:

> > Then when would remote.*.push with a wildcard ever do anything?
> 
> Maybe this is where a potential disconnect is, but I've always viewed
> the wildcard refspec as a mapping, rather than an all-inclusive "Push
> all the things". In other words, I view it as more of a structural
> guide than a behavioral one. I recognize I probably have this wrong,
> but it probably speaks to how some users view it, or at least, some
> valid use cases to have more of a structural mechanism to map branches
> to remote repositories, with `git push --all` being a supplement to
> say "Push all branches using this mapping".

I see. So you really want "push the current branch by default, but using
this refspec to map the names". That doesn't exist right now, but it
seems like it would be a reasonable thing to have.

Bringing in your other reply:

> I think `branch.*.pushRef` in this case is not enough. It implies that
> for every branch I want to be mapped in this way, I'd have to manually
> specify this config. Rather, I think a `remote.*.pushRef` would be
> more appropriate, so that it would automatically set the
> `branch.*.pushRef` version as needed, so I only set up the mapping
> once.

Yes, my suggestion would require per-branch config. And something like
remote.*.pushRef makes sense to me as the implementation for what we
were discussing above. I think you'd want the name to somehow indicate
that it's a mapping to be used when pushing a ref, and not the
definitive "this is what we will push" directive.

I don't think it would make sense to use with something like "upstream"
in push.default, because that's mapping the name already. So possibly it
should be restricted to "current". I suppose it would also make sense
with "matching". There the current remote.*.push _mostly_ does the same
thing, but with one subtle exception that it pushes everything that
matches the left-hand side of the refspec, not just ones that exist on
the right-hand side.

So I dunno. I could see it as being limited to "current", or being
applied as it makes sense for each individual push.default. I'll leave
that to whoever decides to work on the feature. :)

-Peff

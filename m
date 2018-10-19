Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9466F1F453
	for <e@80x24.org>; Fri, 19 Oct 2018 16:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbeJTAtc (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 20:49:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:46498 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727482AbeJTAtb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 20:49:31 -0400
Received: (qmail 24925 invoked by uid 109); 19 Oct 2018 16:42:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 19 Oct 2018 16:42:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12706 invoked by uid 111); 19 Oct 2018 16:41:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 19 Oct 2018 12:41:51 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Oct 2018 12:42:38 -0400
Date:   Fri, 19 Oct 2018 12:42:38 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 19/24] submodule.c: remove implicit dependency on
 the_index
Message-ID: <20181019164237.GA24740@sigill.intra.peff.net>
References: <20180826100314.5137-1-pclouds@gmail.com>
 <20180903180932.32260-1-pclouds@gmail.com>
 <20180903180932.32260-20-pclouds@gmail.com>
 <20181019162021.GA14778@sigill.intra.peff.net>
 <CACsJy8CGLRi64WzNUM-6NUm3i0JW7+ptfh7+NhiSb7J9Qb0u0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8CGLRi64WzNUM-6NUm3i0JW7+ptfh7+NhiSb7J9Qb0u0w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 19, 2018 at 06:33:30PM +0200, Duy Nguyen wrote:

> > This function doesn't actually make use of the newly added "istate" (nor
> > does it use the_index, so there's not a spot that forgot to get
> > converted). Is this in preparation for more refactoring, or is it just a
> > mistake and can be dropped?
> 
> It's possible that it was needed at some point when I converted diff
> api to pass index_state around. But in later iterations I think I
> passed "struct repository *" instead because diff code needed much
> more than the index, but did not clean this up. Sorry.
> 
> In this function, we still have the_repository for
> repo_init_revisions() and it should be gone eventually. "struct
> repository *r" could take the place of "struct index_state *istate"
> instead and we would need to reopen the path again.
> 
> So I'm not sure, if it's really bad, we could remove it now. Otherwise
> we could just leave it there, I don't think this "istate" will survive
> very long. I already started deleting some of the_repository in "kill
> the_index" series.

OK, that all makes sense. I need to either drop it or mark it unused to
satisfy -Wunused-parameters. I think I'd lean toward the former, if
it's not likely to be used (even if we add "struct repository" later,
the separate index parameter would just go away then).

> > I don't see anything in the "Kill the_index, final part" series that
> > would need it.
> 
> Yeah. Killing the_index is just the first small step (didn't look that
> small when I started). Now it's all about the_repository ;-) and we
> have like 400 references of it just in library code.

I suspect it is much worse than that, even. There are many spots that
likely are relying on global data that _should_ be in the repository
struct but aren't yet. I don't think there's even an easy way to count
those. ;)

-Peff

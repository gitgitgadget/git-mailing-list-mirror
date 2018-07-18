Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD13E1F597
	for <e@80x24.org>; Wed, 18 Jul 2018 22:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728929AbeGRXct (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 19:32:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:51984 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728103AbeGRXct (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 19:32:49 -0400
Received: (qmail 24136 invoked by uid 109); 18 Jul 2018 22:52:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 18 Jul 2018 22:52:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5101 invoked by uid 111); 18 Jul 2018 22:52:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 18 Jul 2018 18:52:48 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Jul 2018 18:52:42 -0400
Date:   Wed, 18 Jul 2018 18:52:42 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        Derrick Stolee <dstolee@microsoft.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 1/3] check_replace_refs: fix outdated comment
Message-ID: <20180718225242.GB21451@sigill.intra.peff.net>
References: <20180718204424.GA1483@sigill.intra.peff.net>
 <20180718204449.GA31816@sigill.intra.peff.net>
 <xmqqlga8i2ux.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlga8i2ux.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 18, 2018 at 03:41:10PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Commit afc711b8e1 (rename read_replace_refs to
> > check_replace_refs, 2014-02-18) added a comment mentioning
> > that check_replace_refs is set in two ways:
> >
> >   - from user intent via --no-replace-objects, etc
> >
> >   - after seeing there are no replace refs to respect
> >
> > Since c3c36d7de2 (replace-object: check_replace_refs is safe
> > in multi repo environment, 2018-04-11) the second is no
> > longer true. Let's drop that part of the comment.
> >
> 
> I wonder if c3c36d7de2 should be corrected so that we would have
> this bit per in-core repository instance?  When the superproject and
> its three submodules all have an in-core repository instance each,
> and only one of the submodules uses replace ref, the original
> optimization disabled by that patch would be an obvious thing to
> have per repository.

I think c3c36d7de2 represents that bit by checking the non-emptiness of
the refs/replace map.

What it doesn't do is represent a per-repository notion of "are we even
even interested in the replace feature". Right now there are probably
few cases where that would matter. It comes from the environment, so
it's automatically passed down to children anyway. You could tweak the
environment, but if you did so you'd probably be in a separate process
anyway, so none of this multi-repo-in-one-process stuff would matter
either way.  But there may be cases with programs which manually tweak
the value and then recurse into a submodule.

It would be made slightly worse with my config patch, if you expected:

  git config core.usereplacerefs true
  git -C submodule core.usereplacerefs false
  git log --submodule=log

to respect replace refs in the outer repo, but not the inner one.

-Peff

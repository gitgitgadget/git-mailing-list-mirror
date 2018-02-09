Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6140C1F404
	for <e@80x24.org>; Fri,  9 Feb 2018 22:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753110AbeBIWaO (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 17:30:14 -0500
Received: from cloud.peff.net ([104.130.231.41]:47608 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752522AbeBIWaN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 17:30:13 -0500
Received: (qmail 14358 invoked by uid 109); 9 Feb 2018 22:30:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 09 Feb 2018 22:30:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26830 invoked by uid 111); 9 Feb 2018 22:30:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 09 Feb 2018 17:30:56 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Feb 2018 17:30:11 -0500
Date:   Fri, 9 Feb 2018 17:30:11 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Leo Gaspard <leo@gaspard.io>, Joey Hess <id@joeyh.name>,
        git@vger.kernel.org, Brandon Williams <bmwill@google.com>
Subject: Re: Fetch-hooks
Message-ID: <20180209223011.GA24578@sigill.intra.peff.net>
References: <5898be69-4211-d441-494d-93477179cf0e@gaspard.io>
 <87inb8mn0w.fsf@evledraar.gmail.com>
 <c8d1eb4d-c3d2-5834-a46b-931e825315aa@gaspard.io>
 <20180208153040.GA5180@kitenet.net>
 <871af155-a159-2a29-2e48-74e7a98b60d4@gaspard.io>
 <87bmgzmbsk.fsf@evledraar.gmail.com>
 <fa470be4-75fb-76ed-ed93-5c10fcfb8842@gaspard.io>
 <87po5dbz1a.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87po5dbz1a.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 09, 2018 at 11:04:17PM +0100, Ævar Arnfjörð Bjarmason wrote:

> One thing that's not discussed yet, and I know just enough about for it
> to tingle my spidey sense, but not enough to say for sure (CC'd Jeff &
> Brandon who know more) is that this feature once shipped might cause
> higher load on git hosting providers.
> 
> This is because people will inevitably use it in popular projects for
> some custom filtering, and because you're continually re-fetching and
> inspecting stuff what used to be a really cheap no-op "pull" most of the
> time is a more expensive negotiation every time before the client
> rejects the refs again, and worse for hosting providers because you have
> bespoke ref fetching strategies you have less odds of being able to
> cache both the negotiation and the pack you serve.

Most of the discussion so far seems to be about "accept this ref or
don't accept this ref", which seems OK. But if you are going to do
custom tweaking like rewriting objects, or making it common to refuse
some refs, then I think things get pretty inefficient for _everybody_.

The negotiation for future fetches uses the existing refs as the
starting point. And if we don't know that we have the objects because
there are no refs pointing at them, they're going to get transferred
again. That's extra load no the server, and extra time for the user
waiting on the network.

I tend to agree with the direction of thinking you outlined: you're
generally better off completing the fetch to a local namespace that
tracks the other side completely, and then manipulating the local refs
as you see fit (e.g., fetching into refs/quarantine, and then migrating
"good" refs over to refs/remotes/origin).

-Peff

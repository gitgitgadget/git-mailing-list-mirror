Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 505391F404
	for <e@80x24.org>; Mon, 19 Feb 2018 21:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753726AbeBSVXu (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Feb 2018 16:23:50 -0500
Received: from cloud.peff.net ([104.130.231.41]:57282 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753702AbeBSVXt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Feb 2018 16:23:49 -0500
Received: (qmail 5006 invoked by uid 109); 19 Feb 2018 21:23:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 19 Feb 2018 21:23:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7694 invoked by uid 111); 19 Feb 2018 21:24:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 19 Feb 2018 16:24:36 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Feb 2018 16:23:47 -0500
Date:   Mon, 19 Feb 2018 16:23:47 -0500
From:   Jeff King <peff@peff.net>
To:     Leo Gaspard <leo@gaspard.io>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Joey Hess <id@joeyh.name>, git@vger.kernel.org,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: Fetch-hooks
Message-ID: <20180219212347.GA9748@sigill.intra.peff.net>
References: <fa470be4-75fb-76ed-ed93-5c10fcfb8842@gaspard.io>
 <87po5dbz1a.fsf@evledraar.gmail.com>
 <20180209223011.GA24578@sigill.intra.peff.net>
 <87e7c3b8-3b3c-1cb0-9b11-e4bf3044e539@gaspard.io>
 <20180210001317.GA26856@sigill.intra.peff.net>
 <3de8dec0-12c9-56e2-5902-97755f78ab50@gaspard.io>
 <20180210122131.GB21843@sigill.intra.peff.net>
 <5abf8565-1aa1-c101-83a7-90781682bc7a@gaspard.io>
 <20180214013520.GA25188@sigill.intra.peff.net>
 <96dd7fb3-849b-8de6-7c3a-cd6bde9da432@gaspard.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <96dd7fb3-849b-8de6-7c3a-cd6bde9da432@gaspard.io>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 14, 2018 at 03:02:00AM +0100, Leo Gaspard wrote:

> > So does anybody actually want to be able to adjust the refs as they pass
> > through? It really sounds like you just want to be able to reject or not
> > reject the fetch. And that rejecting would be the uncommon case, so it's
> > OK to just abort the whole operation and expect the user to figure it
> > out.
> 
> This completely fits my use case (modulo the fact that it's more similar
> to the `update` hook than to `pre-receive` I think, as verifying the
> signature requires the objects to already have been downloaded), indeed,
> though I'm not sure it would have fit Joey's (based on my understanding,
> adding a merge was what was originally asked for).
> 
> Actually, I'm wondering if the existing semantics of `update` could not
> be reused for the `pre-fetch`. Would it make sense to just call `update`
> during a fetch in the same way as during a receive-pack? That said it
> likely makes this a breaking change, though it's maybe unlikely that a
> repository is used both for fetching and for receive-pack'ing, it could
> happen.
> 
> So the proposal as I understand it would currently be adding a
> `fetch-update` hook that does exactly the same thing as `update` but for
> `fetch`. This solves my use case in a nice way, though it likely doesn't
> solve Joey's original one (which has been taken care of by a wrapper
> since then).
> 
> What do you all think about it?

I think it should be a separate hook; having an existing hook trigger in
new places is likely to cause confusion and regressions.

If you do go this route, please model it after "pre-receive" rather than
"update". We had "update" originally but found it was too limiting for
hooks to see only one ref at a time. So we introduced pre-receive. The
"update" hook remains for historical reasons, but I don't think we'd
want to reproduce the mistake. :)

-Peff

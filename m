Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1EDB1F576
	for <e@80x24.org>; Tue,  6 Mar 2018 06:29:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750782AbeCFG3I (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 01:29:08 -0500
Received: from cloud.peff.net ([104.130.231.41]:48408 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750723AbeCFG3I (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 01:29:08 -0500
Received: (qmail 13942 invoked by uid 109); 6 Mar 2018 06:29:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 06 Mar 2018 06:29:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1305 invoked by uid 111); 6 Mar 2018 06:29:59 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 06 Mar 2018 01:29:59 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Mar 2018 07:29:02 +0100
Date:   Tue, 6 Mar 2018 07:29:02 +0100
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        sbeller@google.com, gitster@pobox.com, stolee@gmail.com,
        git@jeffhostetler.com, pclouds@gmail.com
Subject: Re: [PATCH v3 12/35] serve: introduce git-serve
Message-ID: <20180306062901.GA3522@sigill.intra.peff.net>
References: <20180125235838.138135-1-bmwill@google.com>
 <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-13-bmwill@google.com>
 <20180222093327.GA12442@sigill.intra.peff.net>
 <20180223214557.GF234838@google.com>
 <20180303043338.GC27689@sigill.intra.peff.net>
 <20180305184321.GC72475@google.com>
 <20180305205254.GC5953@sigill.intra.peff.net>
 <20180305213649.GF28067@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180305213649.GF28067@aiede.svl.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 05, 2018 at 01:36:49PM -0800, Jonathan Nieder wrote:

> > I agree that would be a lot more pleasant for adding protocol features.
> > But I just worry that the stateful protocols get a lot less efficient.
> > I'm having trouble coming up with an easy reproduction, but my
> > recollection is that http has some nasty corner cases, because each
> > round of "have" lines sent to the server has to summarize the previous
> > conversation. So you can get a case where the client's requests keep
> > getting bigger and bigger during the negotiation (and eventually getting
> > large enough to cause problems).
> 
> That's not so much a corner case as just how negotiation works over
> http.

Sure. What I meant more was "there are corner cases where it gets out of
control and doesn't work".

I have had to give the advice in the past "if your fetch over http
doesn't work, try it over ssh". If we change the ssh protocol to be
stateless, too, then that closes that escape hatch.

I haven't had to give that advice for a while, though. Maybe tweaks to
the parameters or just larger buffers have made the problem go away over
the years?

> We want to do better (e.g. see [1]) but that's a bigger change than
> the initial protocol v2.
> 
> As Brandon explained it to me, we really do want to use stateless-rpc
> semantics by default, since that's just better for maintainability.
> Instead of having two protocols, one that is sane and one that
> struggles to hoist that into stateless-rpc, there would be one
> stateless baseline plus capabilities to make use of state.

Yes, I think that would be a nice end-game. It just wasn't clear to me
where we'd be in the interim.

-Peff

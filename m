Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93D471FBB0
	for <e@80x24.org>; Thu,  1 Dec 2016 19:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932923AbcLATqY (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 14:46:24 -0500
Received: from cloud.peff.net ([104.130.231.41]:50069 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932520AbcLATqY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 14:46:24 -0500
Received: (qmail 12140 invoked by uid 109); 1 Dec 2016 19:46:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Dec 2016 19:46:23 +0000
Received: (qmail 2690 invoked by uid 111); 1 Dec 2016 19:46:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Dec 2016 14:46:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Dec 2016 14:46:21 -0500
Date:   Thu, 1 Dec 2016 14:46:21 -0500
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: bw/transport-protocol-policy
Message-ID: <20161201194621.dd3dbjv25ul6qgu5@sigill.intra.peff.net>
References: <xmqqk2bngn03.fsf@gitster.mtv.corp.google.com>
 <20161201083005.dui572o4jxsqacas@sigill.intra.peff.net>
 <20161201181415.GA54082@google.com>
 <20161201192055.44mtvtacyhpbqbqu@sigill.intra.peff.net>
 <20161201193524.GC54082@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161201193524.GC54082@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 01, 2016 at 11:35:24AM -0800, Brandon Williams wrote:

> > I wouldn't expect anyone to ever set GIT_PROTOCOL_FROM_USER=1, but it
> > does behave in a funny way here, overriding the "redirect" flag. I think
> > we'd want something more like:
> > 
> >   if (redirect < 0)
> > 	redirect = git_env_bool("GIT_PROTOCOL_FROM_USER", 1);
> > 
> > and then pass in "-1" from transport_check_allowed().
> 
> I don't think I quite follow your solution but I came up with this:
> 
>   case PROTOCOL_ALLOW_USER_ONLY:
>     return redirect ? 0 : git_env_bool("GIT_PROTOCOL_FROM_USER", 1);
> 
> Which should address the same issue.

I think mine was confused a bit by using the word "redirect". It was
really meant to be "from_user", and could take three values: definitely
yes, definitely no, and unknown (-1). And in the unknown case, we pull
the value from the environment.

Yours combines "definitely no" and "unknown" into a single value ("1" in
your case, but that is because "redirect" and "from_user" have inverted
logic from each other).

I think that is OK, as there isn't any case where a caller would want to
say "definitely no". The most they would say is "_I_ am not doing
anything to make you think this value is not from the user", but we
would still want to check the environment to see that nobody _else_ had
put in such a restriction.

-Peff

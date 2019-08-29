Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 578941F461
	for <e@80x24.org>; Thu, 29 Aug 2019 13:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbfH2NwP (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Aug 2019 09:52:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:32874 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727684AbfH2NwP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Aug 2019 09:52:15 -0400
Received: (qmail 23694 invoked by uid 109); 29 Aug 2019 13:52:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 29 Aug 2019 13:52:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23052 invoked by uid 111); 29 Aug 2019 13:53:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 29 Aug 2019 09:53:43 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 29 Aug 2019 09:52:14 -0400
From:   Jeff King <peff@peff.net>
To:     Mike Hommey <mh@glandium.org>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH] replace: stop replace lookup when reaching a
 self-reference
Message-ID: <20190829135213.GB1797@sigill.intra.peff.net>
References: <20190829112249.32262-1-mh@glandium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190829112249.32262-1-mh@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 29, 2019 at 08:22:49PM +0900, Mike Hommey wrote:

> It is possible to end up in situations where a replace ref points to
> itself. In that case, it would seem better to stop the lookup rather
> than try to follow the link infinitely and fail with "replace depth too
> high".

I don't think this is worth doing. It's just a special case (a 2-node
cycle in the replace graph) of a more general one (an n-node cycle).

We catch the general case with the depth counter (though of course there
are other techniques, which we could debate). Is it worth adding extra
code to cover this special one?

> I'm not entirely sure whether it's actually worth fixing. Arguably, `git
> replace` should also avoid the footgun in the first place (although in
> my case, it wasn't due to `git replace` itself).

Yes, if "git replace $OID $OID" does not complain, it probably should.

Perhaps it should even confirm that the replacement can be resolved, and
does not point to the original object. That covers the n-node case, as
well.

-Peff

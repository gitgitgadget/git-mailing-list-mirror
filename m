Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE6C120248
	for <e@80x24.org>; Thu, 11 Apr 2019 20:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfDKUEy (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Apr 2019 16:04:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:55566 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726538AbfDKUEy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Apr 2019 16:04:54 -0400
Received: (qmail 14532 invoked by uid 109); 11 Apr 2019 20:04:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 11 Apr 2019 20:04:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32442 invoked by uid 111); 11 Apr 2019 20:05:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 11 Apr 2019 16:05:23 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Apr 2019 16:04:52 -0400
Date:   Thu, 11 Apr 2019 16:04:52 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?546L5YGl5by6?= <jianqiang.wang@securitygossip.com>
Subject: Re: [PATCH 0/4] use xmalloc in more places
Message-ID: <20190411200452.GA19315@sigill.intra.peff.net>
References: <20190411134736.GA28543@sigill.intra.peff.net>
 <20190411191452.GA21290@D-10-18-172-132.dhcp4.washington.edu>
 <20190411193735.GB32528@sigill.intra.peff.net>
 <20190411194308.GA26327@D-10-18-172-132.dhcp4.washington.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190411194308.GA26327@D-10-18-172-132.dhcp4.washington.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 11, 2019 at 12:43:08PM -0700, Taylor Blau wrote:

> > I don't think we can ban malloc, since we have to use it ourselves. :)
> >
> > With some contortions, we probably could unban it specifically in
> > wrapper.c (though note there are a few other calls I've left which would
> > need to be handled somehow).
> 
> Right. I think that I should have made this point clearer in my initial
> reply. I was thinking that we could #undef the banned macro in
> wrapper.c, or some similar hula-hooping.

That _probably_ works, but I think technically falls afoul of platforms
on which there's a malloc macro in the first place. We need to not just
#undef it then, but restore the original macro, which is impossible. So
you're better off just not fudging it in the first place. Which would
probably be something like:

  #define SUPPRESS_BAN_MALLOC
  #include "git-compat-util.h"

or something, with the appropriate magic in banned.h.

This might be academic, but you wouldn't know until somebody's platform
subtly breaks. ;) We did run into it already with strcpy(), I think,
hence the defensive #undefs in banned.h.

> Yeah... maybe that's the bigger question that I hadn't asked. I made the
> suggestion thinking that it would help newcomers avoid writing
> 'malloc()' and sending it if they didn't know we use our 'xmalloc()'
> instead.
> 
> But I'm not sure if the argument holds up. I think that in general
> exactly the sorts of new-comers that I'm thinking of would have more
> than one review cycle anyway, so it might not be worth the effort,
> anyway...

I think it's still a reasonable thought, even if I'm not sure the
balance of cost/reward is quite there so far (but might change if it's
an error we see people start to make). Compared to coccinelle, the
banned-function approach is a little nicer for helping new submitters
because it catches the problem during a normal compile (and we know
nobody would ever submit a patch without having at least compiled it,
right? ;) ).

-Peff

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97E2D20248
	for <e@80x24.org>; Thu, 11 Apr 2019 19:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbfDKThi (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Apr 2019 15:37:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:55512 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726577AbfDKThh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Apr 2019 15:37:37 -0400
Received: (qmail 13625 invoked by uid 109); 11 Apr 2019 19:37:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 11 Apr 2019 19:37:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32171 invoked by uid 111); 11 Apr 2019 19:38:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 11 Apr 2019 15:38:06 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Apr 2019 15:37:35 -0400
Date:   Thu, 11 Apr 2019 15:37:35 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?546L5YGl5by6?= <jianqiang.wang@securitygossip.com>
Subject: Re: [PATCH 0/4] use xmalloc in more places
Message-ID: <20190411193735.GB32528@sigill.intra.peff.net>
References: <20190411134736.GA28543@sigill.intra.peff.net>
 <20190411191452.GA21290@D-10-18-172-132.dhcp4.washington.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190411191452.GA21290@D-10-18-172-132.dhcp4.washington.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 11, 2019 at 12:14:52PM -0700, Taylor Blau wrote:

> > This series cleans up most of the bare calls found by:
> >
> >   git grep -E '[^a-z_](m|c|re)alloc\(' '*.c' :^compat :^contrib :^wrapper.c
> 
> This (admittedly pretty awesome) 'git grep' invocation reminds me of a
> series I was pretty sure you wrote to ban functions like 'strcpy' and
> other obviously bad things.
> 
> Some quick searching turned up [1], which landed as f225611d1c
> (automatically ban strcpy(), 2018-07-26). Do we want something similar
> here? Of course, the locations below would have to be exempt, but it
> seems worthwhile (and would save a review cycle in the case that someone
> added a 'malloc' in a patch sent here).

I don't think we can ban malloc, since we have to use it ourselves. :)

With some contortions, we probably could unban it specifically in
wrapper.c (though note there are a few other calls I've left which would
need to be handled somehow).

Another option would be coccinelle patches to convert malloc() to
xmalloc(), etc (with an exception for the wrappers). I'm not entirely
comfortable with automatic conversion here because there's often some
follow-up adjustments (i.e., we can stop handling allocation errors and
maybe delete some code). I think coccinelle can identify callers and
barf, though.

I'm not sure whether coccinelle saves review cycles (since that implies
people actually run it, though maybe that is better now that it's part
of Travis?). It seems to me that it's usually more helpful for people
periodically doing follow-up auditing.

So I dunno. If this was a common mistake I'd be more concerned with
saving review cycles, but all of the cases I found were actually just
leftovers from the very early days of Git.

-Peff

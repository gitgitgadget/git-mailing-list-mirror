Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4297E20281
	for <e@80x24.org>; Thu, 21 Sep 2017 04:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751450AbdIUEsD (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Sep 2017 00:48:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:45570 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751361AbdIUEsD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2017 00:48:03 -0400
Received: (qmail 1734 invoked by uid 109); 21 Sep 2017 04:48:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 21 Sep 2017 04:48:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19059 invoked by uid 111); 21 Sep 2017 04:48:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 21 Sep 2017 00:48:40 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Sep 2017 00:48:00 -0400
Date:   Thu, 21 Sep 2017 00:48:00 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] revision: replace "struct cmdline_pathspec" with
 argv_array
Message-ID: <20170921044800.2m4vi5zd2nyer3bc@sigill.intra.peff.net>
References: <1505936846-2195-4-git-send-email-martin.agren@gmail.com>
 <20170920202552.kkwhigmv7lq6cj3y@sigill.intra.peff.net>
 <20170920203659.xqy76bg5nfabvbfx@sigill.intra.peff.net>
 <20170920224826.GH27425@aiede.mtv.corp.google.com>
 <20170921030424.akqaou7tqj2updgr@sigill.intra.peff.net>
 <20170921034900.GB88098@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170921034900.GB88098@aiede.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 20, 2017 at 08:49:00PM -0700, Jonathan Nieder wrote:

> The patch I am replying to tightens the contract for parse_pathspec().

I disagree with this bit. In my view that was already the contract for
parse_pathspec(), and it is simply poorly documented. You can see it
being required elsewhere already (e.g., in line_log_init(), and quite
probably in other places that feed custom argv-arrays to
setup_revisions).

> In other words, it was not at all obvious that "(2) The memory remains
> useful until around the time of program exit" did not hold.  To a
> casual reader it instead looks like (2) does hold, and there's no
> documentation short of delving into the implementation of
> parse_pathspec() to convince a reader otherwise.  The documentation
> that is present leads to the opposite conclusion.

I guess the point I was trying to make is that I _didn't_ have that
opposite conclusion. A sane API does not create hidden memory ownership
dependencies (though also as I said, it does not hurt to double check if
you think it may be wrong, and certainly documenting also does not
hurt).

> The assertion (1) that this allocation is going to happen multiple
> times in a program isn't true either.  As you noted, we only read
> stdin once.  But that doesn't matter as long as (2) doesn't hold.

I don't think I asserted that this allocation happens multiple times. I
_did_ assert that the revision machinery may be called multiple times,
and I'd rather fix the leak than have people figure out the maximum
number of bytes we might leak in a given program. In other words, the
more important point of what I wrote is that we should not be reaching
for UNLEAK() at all in a function like this, even if you might be able
to justify it after analysis.

> TBH saying that I should write the one-sentence doc patch feels like
> a cop-out.  Just like it is not sustainable for those reviewers that
> are interested in good test coverage to be the only ones who write
> tests, I think we cannot avoid treating documentation of API contracts
> as a shared responsibility.

Hopefully the first paragraph I wrote above explains why I don't see
this as changing the contract at all (and therefore making the
documentation update orthogonal).

I agree that it's a good practice to leave the whole codebase a little
prettier than when you started, even if it's not strictly related to the
small change you want to make. And I hope my record of patches shows
that I follow through on that practice as a general rule.

But I also think it's easy for reviewers to ask for those orthogonal
changes, when it would be a similar amount of work for them to
communicate their suggestion in the form of a patch.

-Peff

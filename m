Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2571C20401
	for <e@80x24.org>; Wed, 14 Jun 2017 10:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751857AbdFNKDz (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 06:03:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:39905 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751624AbdFNKDy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 06:03:54 -0400
Received: (qmail 16767 invoked by uid 109); 14 Jun 2017 10:03:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Jun 2017 10:03:53 +0000
Received: (qmail 10266 invoked by uid 111); 14 Jun 2017 10:03:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Jun 2017 06:03:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Jun 2017 06:03:52 -0400
Date:   Wed, 14 Jun 2017 06:03:52 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Zero King <l2dy@macports.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 8/8] t0012: test "-h" with builtins
Message-ID: <20170614100352.ebkvlntpcpug3hax@sigill.intra.peff.net>
References: <20170530050949.dkgu3u26qj6ycusy@sigill.intra.peff.net>
 <20170530051930.pqywvihwl5klg7hz@sigill.intra.peff.net>
 <20170613230803.GP133952@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170613230803.GP133952@aiede.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 13, 2017 at 04:08:03PM -0700, Jonathan Nieder wrote:

> > +test_expect_success 'generate builtin list' '
> > +	git --list-builtins >builtins
> > +'
> > +
> > +while read builtin
> > +do
> > +	test_expect_success "$builtin can handle -h" '
> > +		test_expect_code 129 git $builtin -h >output 2>&1 &&
> > +		test_i18ngrep usage output
> > +	'
> > +done <builtins
> 
> I love this.  A few thoughts:
> 
> - I think the "generate builtin list" test should be marked as setup
>   so people know it can't be skipped.  I'll send a followup to do that.
> 
> - By the same token, if "generate builtin list" fails then these
>   commands afterward would fail in an unpleasant way.  Fortunately
>   that's straightforward to fix, too.

Be my guest if you want, but I don't think either of those is actually
worth spending any time on. It's a nice convenience when tests are
independent, but ultimately if any single test fails, the results of all
tests after it must be suspect. There are too many hidden dependencies
to treat it any other way.

So I have no problem with skipping tests while debugging for a quicker
turnaround, with the knowledge that what you're seeing _might_ be
slightly invalidated. But I don't think it's worth dumping developer
time into trying to make each block independent. That's what individual
scripts are for.

(I also think it's particularly worthless for this script; the whole
thing runs in ~500ms on my machine. It takes longer to type
GIT_TEST_SKIP).

> - This checks both stdout and stderr to verify that the usage appears
>   somewhere.  I would have expected commands to be consistent ---
>   should they always send usage to stdout, since the user requested it,
>   or to stderr, since that's what we have done historically?
> 
>   So I understand why this test is agnostic about that but I suspect
>   it's pointing to some inconsistency that could be fixed independently.

The difference is between parse-option's usage_with_options() and
usage(). The former sends "-h" to stdout and errors to stderr, which I
think is sensible. The latter only knows about stderr.

I think it would be reasonable to have follow the parse-options strategy
consistently. It will definitely take some tweaking, though. There are
lots of commands that respect "-h" only by hitting some default
unhandled case. So you'll not only have to have a stdout analog for
usage(), but you'll have to teach each command when to use each.

> - Do we plan to translate the "usage:" prefix some day?  I could go
>   both ways --- on one hand, having a predictable error:/usage:/fatal:
>   prefix may make life easier for e.g. GUI authors trying to show
>   different kinds of error messages in different ways, but on the other
>   hand, always using English for the prefix may be unfriendly to non
>   English speakers.
> 
>   In the past I had assumed it would never be translated but now I'm
>   not so sure.  What do you think?

I don't have an opinion either way. I know we don't translate it now,
but it has been discussed. I figured it couldn't hurt to use i18ngrep to
future-proof it.

> - Should we have something like this for non-builtins, too?

That would be nice, though you'll probably need some cooperation from
the Makefile to get the list. I was specifically worried about catching
the particular setup_git_directory() interaction with builtins here, so
it seemed like a good stopping point.

But as a general rule, making sure that everything responds sensibly to
"-h" seems like a good thing.

-Peff

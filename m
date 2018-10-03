Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B8191F453
	for <e@80x24.org>; Wed,  3 Oct 2018 07:06:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbeJCNxv (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 09:53:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:39524 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726521AbeJCNxv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 09:53:51 -0400
Received: (qmail 7892 invoked by uid 109); 3 Oct 2018 07:06:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 03 Oct 2018 07:06:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10618 invoked by uid 111); 3 Oct 2018 07:06:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 03 Oct 2018 03:06:09 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Oct 2018 03:06:45 -0400
Date:   Wed, 3 Oct 2018 03:06:45 -0400
From:   Jeff King <peff@peff.net>
To:     Rasmus Villemoes <rv@rasmusvillemoes.dk>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 1/3] help: redirect to aliased commands for "git cmd
 --help"
Message-ID: <20181003070645.GA6019@sigill.intra.peff.net>
References: <20180926102636.30691-1-rv@rasmusvillemoes.dk>
 <20181001112107.28956-1-rv@rasmusvillemoes.dk>
 <20181003021358.GA20553@sigill.intra.peff.net>
 <9ab3d69a-033a-e5a0-7459-c6ba8a2ec853@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9ab3d69a-033a-e5a0-7459-c6ba8a2ec853@rasmusvillemoes.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 03, 2018 at 08:24:14AM +0200, Rasmus Villemoes wrote:

> > The comment probably needs to spell out that exclude_guides
> > is the same as your "we were invoked as...".
> 
> Will do. That will also make the string --exclude-guides (i.e., with a
> dash) appear in the comment, making it more likely to be found should
> anyone change when and how --exclude-guides is implied.

OK. I can live with that.

> > So we split only to find argv[0] here. But then we don't return it. That
> > works because the split is done in place, meaning we must have inserted
> > a NUL in alias. That's sufficiently subtle that it might be worth
> > spelling it out in a comment.
> 
> OK, I actually had precisely
> 
> +		/*
> +		 * We use split_cmdline() to get the first word of the
> +		 * alias, to ensure that we use the same rules as when
> +		 * the alias is actually used. split_cmdline()
> +		 * modifies alias in-place.
> +		 */
> 
> in v1, but thought it might be overly verbose. I'll put it back in.

:) That's perfect.

> > We don't need to free alias here as we do above, because we're passing
> > it back. We should free argv, though, I think (not its elements, just
> > the array itself).
> 
> Yeah, I thought about this, and removing free(argv) was the last thing I
> did before sending v1 - because we were going to leak alias anyway. I'm
> happy to put it back in, along with...

Thanks. I think this is different than "alias" because we really do leak
it _here_, whereas alias lives on and can be UNLEAKed later.

> > Unfortunately the caller is going to leak our returned "alias", [...] I think it may be OK to overlook
> > that and just UNLEAK() it in cmd_help().
> 
> ...this. Except I'd rather do the UNLEAK in check_git_cmd (the
> documentation does say "only from cmd_* functions or their direct
> helpers") to make it a more targeted annotation.

Yeah, I think that's fine. Thanks!

-Peff

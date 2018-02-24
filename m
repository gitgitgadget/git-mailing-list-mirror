Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E4421F404
	for <e@80x24.org>; Sat, 24 Feb 2018 04:03:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752113AbeBXEDx (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 23:03:53 -0500
Received: from cloud.peff.net ([104.130.231.41]:35142 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751943AbeBXEDw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 23:03:52 -0500
Received: (qmail 3258 invoked by uid 109); 24 Feb 2018 04:03:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 24 Feb 2018 04:03:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23430 invoked by uid 111); 24 Feb 2018 04:04:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 23 Feb 2018 23:04:40 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Feb 2018 23:03:50 -0500
Date:   Fri, 23 Feb 2018 23:03:50 -0500
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, gitster@pobox.com,
        jrnieder@gmail.com, stolee@gmail.com, git@jeffhostetler.com,
        pclouds@gmail.com
Subject: Re: [PATCH v3 13/35] ls-refs: introduce ls-refs server command
Message-ID: <20180224040350.GB16743@sigill.intra.peff.net>
References: <20180125235838.138135-1-bmwill@google.com>
 <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-14-bmwill@google.com>
 <20180222094831.GB12442@sigill.intra.peff.net>
 <20180223004514.GP185096@google.com>
 <20180224001954.GA153423@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180224001954.GA153423@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 23, 2018 at 04:19:54PM -0800, Brandon Williams wrote:

> > We always have the ability to extend the patterns accepted via a feature
> > (or capability) to ls-refs, so maybe the best thing to do now would only
> > support a few patterns with specific semantics.  Something like if you
> > say "master" only match against refs/heads/ and refs/tags/ and if you
> > want something else you would need to specify "refs/pull/master"?
> > 
> > That way we could only support globs at the end "master*" where * can
> > match anything (including slashes)
> 
> After some in-office discussion it seems like the best thing to do for
> this (right now since if we change our mind we can just introduce a
> capability which extends the patterns supported) would be to left-anchor
> the ref-patterns and only allow for a single wildcard character '*'
> which matches zero or more characters (and doesn't care about slashes
> '/').  This wildcard character should only be supported at the end of
> the ref pattern.  This means that if a client wants 'master' then they
> would need to specify 'refs/heads/master' (and the other
> ref_rev_parse_rules expansions) as a ref pattern. But they could say
> "refs/heads/*" for all refs under refs/heads.

Heh, I just responded without having read this and came up with the same
suggestion.

So I agree that is the right path. Or the simplification I mentioned
that "refs/heads/master" would return that ref or possibly
"refs/heads/master/foo" if it exists. Remember that it's fine to be
overly broad here. This is purely an optimization in the advertisement,
as we'd still pick out the refs we care about in a separate step.

-Peff

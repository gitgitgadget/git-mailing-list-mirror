Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2C181FAF4
	for <e@80x24.org>; Tue, 14 Feb 2017 19:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753438AbdBNTve (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 14:51:34 -0500
Received: from cloud.peff.net ([104.130.231.41]:55247 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751480AbdBNTvb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 14:51:31 -0500
Received: (qmail 15884 invoked by uid 109); 14 Feb 2017 19:51:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Feb 2017 19:51:30 +0000
Received: (qmail 6016 invoked by uid 111); 14 Feb 2017 19:51:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Feb 2017 14:51:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Feb 2017 14:51:27 -0500
Date:   Tue, 14 Feb 2017 14:51:27 -0500
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH 5/7] grep: fix "--" rev/pathspec disambiguation
Message-ID: <20170214195127.q6gs6ayp6w7uxi72@sigill.intra.peff.net>
References: <20170214060021.einv7372exbxa23z@sigill.intra.peff.net>
 <20170214060555.yzh6hhi2t7pkeqvi@sigill.intra.peff.net>
 <20170214185621.GC44208@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170214185621.GC44208@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 14, 2017 at 10:56:21AM -0800, Brandon Williams wrote:

> On 02/14, Jeff King wrote:
> > -	/* Check revs and then paths */
> > +	/*
> > +	 * We have to find "--" in a separate pass, because its presence
> > +	 * influences how we will parse arguments that come before it.
> > +	 */
> > +	for (i = 0; i < argc; i++) {
> > +		if (!strcmp(argv[i], "--")) {
> > +			seen_dashdash = 1;
> > +			break;
> > +		}
> > +	}
> 
> So this simply checks if "--" is an argument that was provided.  This
> then allows grep to know ahead of time how to handle revs/paths
> preceding a "--" or in the absences of the "--".  Seems sensible to me.

By the way, we have to check again later for "--" when parsing the revs
themselves. In theory you could set seen_dashdash to the offset of the
dashdash in the array, and do the iteration more like:

  for (i = 0; i < dashdash_pos; i++)
          handle_rev(argv[i]);
  for (i = dashdash_pos + 1; i < argc; i++)
          handle_path(argv[i]);

But our loops also handle the case where there is no "--" at all, and I
think that approach ends up convoluting the logic. I didn't go very far
in that direction before giving it up, though.

-Peff

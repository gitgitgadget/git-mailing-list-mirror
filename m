Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FAA61F461
	for <e@80x24.org>; Sat, 29 Jun 2019 07:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfF2Hzj (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Jun 2019 03:55:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:54864 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726789AbfF2Hzi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Jun 2019 03:55:38 -0400
Received: (qmail 18565 invoked by uid 109); 29 Jun 2019 07:55:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 29 Jun 2019 07:55:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23363 invoked by uid 111); 29 Jun 2019 07:56:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 29 Jun 2019 03:56:30 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 29 Jun 2019 03:55:36 -0400
Date:   Sat, 29 Jun 2019 03:55:36 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] check_everything_connected: assume alternate ref tips
 are valid
Message-ID: <20190629075536.GB5080@sigill.intra.peff.net>
References: <20190628101131.GA22862@sigill.intra.peff.net>
 <xmqqpnmx8ysf.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpnmx8ysf.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 28, 2019 at 09:22:56AM -0700, Junio C Hamano wrote:

> >  	argv_array_push(&rev_list.args, "--quiet");
> > +	argv_array_push(&rev_list.args, "--alternate-refs");
> >  	if (opt->progress)
> >  		argv_array_pushf(&rev_list.args, "--progress=%s",
> >  				 _("Checking connectivity"));
> 
> Quite honestly, I am very surprised that we did not do this.  The
> idea of alternate object store, as well as reducing transfer cost by
> advertising their tips as '.have' phony refs, is almost as old as
> the pack protocol itself.

Yeah, as you note we are already telling the other side of the push
"hey, we already have these objects". So we are almost always just
walking over our own local objects in the connectivity check, which is
silly.

I only did "clone --reference" in the perf test because it was the
simplest, but a push to a server with alternates should be similarly
improved. E.g., doing this in a clone of linux.git:

  git init --bare dst.git
  echo '../../.git/objects' >dst.git/objects/info/alternates
  time git push dst.git HEAD

goes from 40+ seconds to 100ms or so. Again, obviously that's the best
case, but it should also improve the normal case of somebody pulling
down "torvalds/linux.git" and pushing it back up to their own
"peff/linux.git", too.

I don't have real-world numbers yet from GitHub, because we're not
actually advertising .haves on push right now. All of the Git pieces are
now in places to do so, but we still have to make some tweaks at our
replication layer. But soon. :)

-Peff

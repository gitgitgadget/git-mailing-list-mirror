Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C059201B0
	for <e@80x24.org>; Tue, 28 Feb 2017 13:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751769AbdB1NA0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 08:00:26 -0500
Received: from cloud.peff.net ([104.130.231.41]:35603 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751783AbdB1NAZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 08:00:25 -0500
Received: (qmail 23829 invoked by uid 109); 28 Feb 2017 12:33:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Feb 2017 12:33:33 +0000
Received: (qmail 25574 invoked by uid 111); 28 Feb 2017 12:33:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Feb 2017 07:33:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Feb 2017 07:33:31 -0500
Date:   Tue, 28 Feb 2017 07:33:31 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 4/8] interpret_branch_name: allow callers to restrict
 expansions
Message-ID: <20170228123331.wubqplp5zjwzz6is@sigill.intra.peff.net>
References: <20170228120633.zkwfqms57fk7dkl5@sigill.intra.peff.net>
 <20170228121434.2dhngs4peq5acic2@sigill.intra.peff.net>
 <20170228122338.xkefanyhtwbomoit@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170228122338.xkefanyhtwbomoit@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 28, 2017 at 07:23:38AM -0500, Jeff King wrote:

> > -int interpret_branch_name(const char *name, int namelen, struct strbuf *buf)
> > +int interpret_branch_name(const char *name, int namelen, struct strbuf *buf,
> > +			  unsigned allowed)
> >  {
> >  	char *at;
> >  	const char *start;
> > @@ -1254,24 +1275,29 @@ int interpret_branch_name(const char *name, int namelen, struct strbuf *buf)
> >  		if (len == namelen)
> >  			return len; /* consumed all */
> >  		else
> > -			return reinterpret(name, namelen, len, buf);
> > +			return reinterpret(name, namelen, len, buf, allowed);
> >  	}
> 
> It's hard to see from this context, but a careful reader may note that
> we do not check "allowed" at all before calling
> interpret_nth_prior_checkout(). This is looking for branch names via
> HEAD, so I don't think it can ever return anything but a local name.
> 
> Which, hmm. I guess was valid when the flag was "only_branches", but
> would not be valid under INTERPRET_BRANCH_REMOTE. I wonder if
> 
>   git branch -r -D @{-1}
> 
> incorrectly deletes refs/remotes/origin/master if you previously had
> refs/heads/origin/master checked out.

The answer is "yes", it's broken. So interpret_branch_name() should do
an "allowed" check before expanding the nth-prior. The fix should be
easy, especially on top of the earlier 426f76595 (which, incidentally, I
already based this series on).

I'll hold off on re-rolling to see if it collects any other review.

-Peff

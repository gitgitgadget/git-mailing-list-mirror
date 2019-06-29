Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21F431F461
	for <e@80x24.org>; Sat, 29 Jun 2019 00:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfF2AZp (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jun 2019 20:25:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:54734 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726643AbfF2AZo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jun 2019 20:25:44 -0400
Received: (qmail 16064 invoked by uid 109); 29 Jun 2019 00:25:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 29 Jun 2019 00:25:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22130 invoked by uid 111); 29 Jun 2019 00:26:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 28 Jun 2019 20:26:36 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Jun 2019 20:25:42 -0400
Date:   Fri, 28 Jun 2019 20:25:42 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Derrick Stolee <stolee@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/6] test-lib: introduce test_commit_bulk
Message-ID: <20190629002542.GF2625@sigill.intra.peff.net>
References: <20190628093751.GA3569@sigill.intra.peff.net>
 <20190628093911.GA27329@sigill.intra.peff.net>
 <CAPig+cQAKVOqYH-CcqzViP_zuKwg5fWO2_i8=Z5t=BVf9uoAXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cQAKVOqYH-CcqzViP_zuKwg5fWO2_i8=Z5t=BVf9uoAXQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 28, 2019 at 05:32:35PM -0400, Eric Sunshine wrote:

> > +# The message, filename, and contents strings are evaluated by the shell inside
> > +# double-quotes, with $n set to the current commit number. So you can do:
> > +#
> > +#   test_commit_bulk --filename=file --contents='modification $n'
> 
> Considering that test_commit_bulk() is intended to be used within a
> test body, and considering that test bodies are almost always
> encapsulated in single quotes, recommending single quoting the value
> of --contents= seems contraindicated. Double quotes likely would be
> better.

I hoped people reading it would realize that they would need to suppress
interpolation of $ one way or another. But I guess many people who touch
the test suite aren't actually prolific shell writers.

Anyway, I'm going to look into changing this to a printf string, which
would make this easier.

> > +       in_dir=${indir:+-C "$indir"}
> 
> Doesn't this suffer the problem in which some older/broken
> shells[1][2][3][4] incorrectly expand this to:

That line is leftover dead code; see my response to Junio.

> Same comment applies to other instances of ${indir:+-C "$indir"} below.

Those ones are fine because of the double-quotes (and whitespace
splitting on the replacement value happens before interpolation). Try
this:

  x=''
  y='with spaces'
  sh -c 'for i in "$@"; do echo arg: $i; done' -- \
    ${x:+-x "$x"} \
    ${y:+-y "$y"}

-Peff

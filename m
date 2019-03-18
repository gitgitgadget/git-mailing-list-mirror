Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91E3B20248
	for <e@80x24.org>; Mon, 18 Mar 2019 21:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfCRVE1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 17:04:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:55448 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726832AbfCRVE1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 17:04:27 -0400
Received: (qmail 9843 invoked by uid 109); 18 Mar 2019 21:04:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 18 Mar 2019 21:04:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23683 invoked by uid 111); 18 Mar 2019 21:04:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 18 Mar 2019 17:04:47 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Mar 2019 17:04:24 -0400
Date:   Mon, 18 Mar 2019 17:04:24 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 2/3] parse-options: make OPT_ARGUMENT()  more useful
Message-ID: <20190318210424.GA29661@sigill.intra.peff.net>
References: <pull.163.git.gitgitgadget@gmail.com>
 <pull.163.v2.git.gitgitgadget@gmail.com>
 <10775638ad8f2ef9b64b8dbaf71b80d8546e81d8.1552562701.git.gitgitgadget@gmail.com>
 <20190315031553.GB28943@sigill.intra.peff.net>
 <xmqq7ecw7vbb.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7ecw7vbb.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 18, 2019 at 11:47:20AM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> +`OPT_ARGUMENT(long, &int_var, description)`::
> >>  	Introduce a long-option argument that will be kept in `argv[]`.
> >> +	If this option was seen, `int_var` will be set to one (except
> >> +	if a `NULL` pointer was passed).
> >
> > So this effectively makes it into a "bool" that we keep. I think that's
> > fine. It always uses NOARG, so it is not like we would ever need to see
> > "we got --foo, and this is the argument it had".
> >
> > I did wonder if it was possible for "--no-foo" to trigger this (leaving
> > the caller who looks at the int unsure if they saw "--foo" or
> > "--no-foo"), but it seems that the parse-options code checks for
> > OPTION_ARGUMENT before it ever looks at negation.
> 
> When a caller that needs to tell --no-foo and lack of any foo
> related option arises, we should be able to update the function
> further so that the caller can initialize the variable to -1
> (unspecified) and make sure that 0 is left upon seeing --no-foo
> so it's not a show stopper, I guess.

The way it is written, I think the intent is that you would do:

  OPT_ARGUMENT("foo", &saw_foo, ...),
  OPT_ARGUMENT("no-foo", &saw_no_foo, ...),

I'm happy to punt on it until it ever comes up (which I suspect may be
never).

-Peff

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E193D20282
	for <e@80x24.org>; Tue, 20 Jun 2017 16:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751095AbdFTQPQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 12:15:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:46444 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751036AbdFTQPQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 12:15:16 -0400
Received: (qmail 30595 invoked by uid 109); 20 Jun 2017 16:15:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 20 Jun 2017 16:15:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14329 invoked by uid 111); 20 Jun 2017 16:15:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 20 Jun 2017 12:15:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Jun 2017 12:15:14 -0400
Date:   Tue, 20 Jun 2017 12:15:14 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH] die routine: change recursion limit from 1 to 1024
Message-ID: <20170620161514.ygbflanx4pldc7n7@sigill.intra.peff.net>
References: <20170619220036.22656-1-avarab@gmail.com>
 <20170620155459.a6e7pypxx6vpdbvs@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170620155459.a6e7pypxx6vpdbvs@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 20, 2017 at 11:54:59AM -0400, Jeff King wrote:

> > Now, git-grep could make use of the pluggable error facility added in
> > commit c19a490e37 ("usage: allow pluggable die-recursion checks",
> > 2013-04-16).
> 
> Yeah, I think this is a bug in git-grep and should be fixed, independent
> of this commit. You should be able to use as a template the callbacks
> added by the child of c19a490e37:
> 
>   1ece66bc9 (run-command: use thread-aware die_is_recursing routine,
>   2013-04-16)

To clarify, I think anytime we spawn worker threads that might run die()
we probably need to be installing not just a custom recursion handler
but a custom die function.

It's weird to see:

  $ git grep ...
  fatal: some error
  fatal: some error
  fatal: some error

Or even:

  $ git grep ...
  fatal: some error
  some actual results
  more actual results

I'm not sure what the _right_ thing is there, but it probably involves
recording the per-thread errors in individual buffers, waiting for the
master to pthread_join() them all, and then doing something like:

  /* this also covers the case of only having 1 error */
  int all_errors_identical = 1;
  for (i = 1; i < nr_errors; i++) {
	if (strcmp(errors[i], errors[i-1])) {
		all_errors_identical = 0;
		break;
	}
  }

  if (all_errors_identical) {
	/* just show it */
	die("%s", errors[0]);
  } else {
	for (i = 0; i < nr_errors; i++)
		error("%s", errors[i]);
	die("multiple errors encountered");
  }

I don't know if we'd want to actually get into the details of what
"multiple errors" means. It isn't _all_ of the possible errors, because
each thread stopped running when it hit the die(). But it's also not
just one error.

Actually, I guess we could just pick one error and show only that one.
That would most closely match the non-threaded case. And it's way
simpler than what I wrote above.

Hrm. I guess you could even do that without buffering if you allow the
thread to take down the whole process. The only thing you'd need to do
is teach die() to take a mutex so that we don't racily show multiple
errors.

That seems like the best option (I almost just deleted my entire email,
but maybe the thought process in leading there is useful).

-Peff

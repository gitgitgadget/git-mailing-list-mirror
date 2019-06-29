Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3831C1F461
	for <e@80x24.org>; Sat, 29 Jun 2019 00:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfF2AJp (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jun 2019 20:09:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:54702 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726694AbfF2AJp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jun 2019 20:09:45 -0400
Received: (qmail 16018 invoked by uid 109); 29 Jun 2019 00:09:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 29 Jun 2019 00:09:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22029 invoked by uid 111); 29 Jun 2019 00:10:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 28 Jun 2019 20:10:36 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Jun 2019 20:09:43 -0400
Date:   Fri, 28 Jun 2019 20:09:43 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/6] test-lib: introduce test_commit_bulk
Message-ID: <20190629000942.GC2625@sigill.intra.peff.net>
References: <20190628093751.GA3569@sigill.intra.peff.net>
 <20190628093911.GA27329@sigill.intra.peff.net>
 <2d4410a9-fd3e-8b9f-00b5-f8eba4d51b42@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2d4410a9-fd3e-8b9f-00b5-f8eba4d51b42@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 28, 2019 at 08:35:28AM -0400, Derrick Stolee wrote:

> > +		while test "$total" -gt 0
> > +		do
> > +			echo "commit $ref" &&
> > +			printf 'author %s <%s> %s\n' \
> > +				"$GIT_AUTHOR_NAME" \
> > +				"$GIT_AUTHOR_EMAIL" \
> > +				"$cur_time -0700" &&
> > +			printf 'committer %s <%s> %s\n' \
> > +				"$GIT_COMMITTER_NAME" \
> > +				"$GIT_COMMITTER_EMAIL" \
> > +				"$cur_time -0700" &&
> > +			echo "data <<EOF" &&
> > +			eval "echo \"$message\"" &&
> > +			echo "EOF" &&
> > +			eval "echo \"M 644 inline $filename\"" &&
> > +			echo "data <<EOF" &&
> > +			eval "echo \"$contents\"" &&
> > +			echo "EOF" &&
> > +			echo &&
> > +			n=$((n + 1)) &&
> > +			cur_time=$((cur_time + 1)) &&
> > +			total=$((total - 1)) ||
> > +			echo "poison fast-import stream"
> > +		done
> 
> I am not very good at the nitty-gritty details of our scripts, but
> looking at this I wonder if there is a cleaner and possibly faster
> way to do this loop. The top thing on my mind are the 'eval "echo X"'
> lines. If they start processes, then we can improve the performance.
> If not, then it may not be worth it.

No, evals by themselves don't require a process.  That whole loop should
all happen as a single process (because it's the left-hand side of the
pipe, it does require a subshell).

We could drop even that process by writing into a temporary file. The
size probably wouldn't be a big deal, and I doubt the latency would even
matter much (and anyway, when you're running the tests in parallel
anyway, CPU time is the most important metric).

It might also make the code a little simpler, since we'd be running in
the main shell and could just use test_tick naturally (rather than the
manual addition hackery).

I'll take a look.

I wasn't super concerned with eliminating processes here as long as the
number of them is constant with respect to the number of commits we're
generating. The big improvement is taking, say, 300 test_commit calls
and turning it into a single bulk call. Replacing a single-commit
test_commit with this would be break-even at best.

> In wonder if instead we could create some format string outside the
> loop and then pass the values that change between iterations into
> that format string.

The evals should be fast. But they are potentially error-prone, since
callers have to pass something like --message='commit $n' with single
quotes to keep the "$" intact. But because all of our test snippets are
inside single-quotes already, you end up with:

  test_bulk_commit --message="commit \$n"

(though in practice most of the callers used the --id shorthand, which
neatly sidesteps this).

Since there's literally only one variable to interpolate, we could swap
this out for using printf formatters, and letting "%s" mean the same as
"$n". It should perform the same but is a bit less magical and a bit
harder to screw up. It would also be easier to handle if
test_commit_bulk eventually became C code. The only downside I can think
of is that you can't mention "%s" twice, but I find it hard to imagine a
caller would want that anyway.

So I'll also take a look at that.

-Peff

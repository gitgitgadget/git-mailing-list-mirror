Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CBCC1FC3E
	for <e@80x24.org>; Fri, 28 Apr 2017 07:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756589AbdD1H44 (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 03:56:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:41511 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756217AbdD1H4y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 03:56:54 -0400
Received: (qmail 1602 invoked by uid 109); 28 Apr 2017 07:56:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 28 Apr 2017 07:56:37 +0000
Received: (qmail 17296 invoked by uid 111); 28 Apr 2017 07:57:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 28 Apr 2017 03:57:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Apr 2017 03:56:36 -0400
Date:   Fri, 28 Apr 2017 03:56:36 -0400
From:   Jeff King <peff@peff.net>
To:     Marc Branchaud <marcnarc@xiplink.com>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 0/2] Make diff plumbing commands respect the
 indentHeuristic.
Message-ID: <20170428075635.x5rqcvgv6tohj74n@sigill.intra.peff.net>
References: <19607a03-71e0-440b-7213-64d25f6fa8da@xiplink.com>
 <20170427205037.1787-1-marcnarc@xiplink.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170427205037.1787-1-marcnarc@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 27, 2017 at 04:50:35PM -0400, Marc Branchaud wrote:

> So here's my attempt at fixing this.
> 
> The thing I was missing is that init_revisions() calls diff_setup(), which
> sets the xdl options.  It's therefore necessary to have the
> diff_indent_heuristic flag set before calling init_revisions().
> 
> A naive way to get the indentHeuristic config option respected in the
> diff-* plumbing commands is to make them use the git_diff_heuristic_config()
> callback right at the start of their main cmd functions.
> 
> But I did not like that for two reasons:
> 
> * It would make these commands invoke git_config() twice.
> 
> * It doesn't avoid the problem if/when someone creates a new diff-something
>   plumbing command, and forgets to set the diff_indent_heuristic flag before
>   calling init_revisions().

Yeah, I think that would be the wrong way to go. Either this option is
diff_basic_config() or it is not. And if it is not, the plumbing commands
have no business checking it.

Thinking on it more, I think it probably should be basic config. We
discussed all along making these options the default, which shows that
plumbing interfaces do not need to be protected from them.

> So instead I chose to make the indentHeuristic option part of diff's basic
> configuration, and in each of the diff plumbing commands I moved the call to
> git_config() before the call to init_revisions().

Yes, I think that's the right thing to do.

> This still doesn't really future-proof things for possible new diff plumbing
> commands, because someone could still invoke init_revisions() before setting
> up diff's basic configuration.  But I don't see an obvious way of ensuring
> that the diff_indent_heuristic flag is respected regardless of when
> diff_setup() is invoked.

I think the config-based stuff would have to be bumped down to
setup_revisions(), leaving init_revisions() as a initialization
function. But that would break new cases, as some callers would
want to do:

  init_revisions(&revs);
  revs.foo = 1; /* override any config */
  setup_revisions(argc, argv, &revs); /* let command-line override us */

So you'd really need three phases:

  init_revisions(&revs); /* baked-in defaults */
  setup_revision_config(&revs);
  setup_revision_args(argc, argv, &revs);

and you could override each set of defaults in between the calls.  But
that would require tweaking each caller. In practice, I think the rule
"set up your config before calling init_revisions" is probably OK, now
that we know about it.

I think there is existing breakage in any case where a diff_basic_config
option is handled in diff_setup(). The only one I see is the dirstat
stuff. So I think:

  git config diff.dirstat changes,5
  git rev-list HEAD | git diff-tree --stdin --dirstat

was supposed to respect that "5" but doesn't. I didn't test, though.

-Peff

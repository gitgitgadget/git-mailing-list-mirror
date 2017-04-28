Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 209C2207E4
	for <e@80x24.org>; Fri, 28 Apr 2017 22:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S642763AbdD1WFD (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 18:05:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:42050 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2993823AbdD1WE4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 18:04:56 -0400
Received: (qmail 31417 invoked by uid 109); 28 Apr 2017 22:04:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 28 Apr 2017 22:04:52 +0000
Received: (qmail 25760 invoked by uid 111); 28 Apr 2017 22:05:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 28 Apr 2017 18:05:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Apr 2017 18:04:50 -0400
Date:   Fri, 28 Apr 2017 18:04:50 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Marc Branchaud <marcnarc@xiplink.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 0/2] Make diff plumbing commands respect the
 indentHeuristic.
Message-ID: <20170428220450.olqitnuwhrxzg3pv@sigill.intra.peff.net>
References: <19607a03-71e0-440b-7213-64d25f6fa8da@xiplink.com>
 <20170427205037.1787-1-marcnarc@xiplink.com>
 <CAGZ79kbUqVfz+6Y0XkTL7FCZfaD+2YRMZ_v0vP8-DOFhWc+ELw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kbUqVfz+6Y0XkTL7FCZfaD+2YRMZ_v0vP8-DOFhWc+ELw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 28, 2017 at 10:34:15AM -0700, Stefan Beller wrote:

> > So instead I chose to make the indentHeuristic option part of diff's basic
> > configuration, and in each of the diff plumbing commands I moved the call to
> > git_config() before the call to init_revisions().
> [...]
> 
> The feature was included in v2.11 (released 2016-11-29) and we got no
> negative feedback. Quite the opposite, all feedback we got, was positive.
> This could be explained by having the feature as an experimental feature
> and users who would be broken by it, did not test it yet or did not speak up.

Yeah, if the point you're trying to make is "nobody will be mad if this
is turned on by default", I don't think shipping it as a config option
is very conclusive.

I think a more interesting argument is: we turned on renames by default
a few versions ago, which changes the diff in a much bigger way, and
nobody complained.

  As a side note, I do happen to know of one program that depends
  heavily on diffs remaining stable. Imagine you have a Git hosting site
  which lets people comment on lines of diffs. You need some way to
  address the lines of the diff so that the annotations appear in the
  correct position when you regenerate the diff later.

  One way to do it is to just position the comment at the n'th line of
  the diff. Which obviously breaks if the diff changes. IMHO that is a
  bug in that program, which should be fixed to use the line numbers
  from the original blob (which is still not foolproof, because a
  different diff algorithm may move a change such that the line isn't
  even part of the diff anymore).

  I'm not worried about this particular program, as I happen to know it
  has already been fixed. But it's possible others have made a similar
  mistake.

> So I'd propose to turn it on by default and anyone negatively impacted by that
> could then use the config to turn it off for themselves (including plumbing).
> 
> Something like this, maybe?

Yeah, as long as this is on top of Marc's patches, I think it is the
natural conclusion that we had planned.

I don't know if we would want to be extra paranoid about patch-ids.
There is no helping:

  git rev-list HEAD | git diff-tree --stdin -p | git patch-id --stable

because diff-tree doesn't know that it's trying for "--stable" output.
But the diffs we compute internally for patch-id could disable the
heuristics. I'm not sure if those matter, though. AFAIK those are used
only for internal comparisons within a single program. I.e., we never
compare them against input from the user, nor do we output them to the
user. So they'll change, but I don't think anybody would care.

-Peff

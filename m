Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 592551F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 00:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbeJKH7V (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 03:59:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:36444 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726046AbeJKH7V (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 03:59:21 -0400
Received: (qmail 17535 invoked by uid 109); 11 Oct 2018 00:34:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 11 Oct 2018 00:34:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24391 invoked by uid 111); 11 Oct 2018 00:33:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 10 Oct 2018 20:33:51 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Oct 2018 20:34:40 -0400
Date:   Wed, 10 Oct 2018 20:34:40 -0400
From:   Jeff King <peff@peff.net>
To:     Daniels Umanovskis <daniels@umanovskis.se>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] branch: introduce --show-current display option
Message-ID: <20181011003440.GD13853@sigill.intra.peff.net>
References: <20181010205432.11990-1-daniels@umanovskis.se>
 <20181010205432.11990-2-daniels@umanovskis.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181010205432.11990-2-daniels@umanovskis.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 10, 2018 at 10:54:32PM +0200, Daniels Umanovskis wrote:

> When called with --show-current, git branch will print the current
> branch name and terminate. Only the actual name gets printed,
> without refs/heads. In detached HEAD state, nothing is output.

I also wondered what happens in an unborn-branch state (i.e., we are on
refs/heads/master, but have not yet made any commits).

In that case, resolve_ref_unsafe() will return the branch name, but a
null oid. And you'll print that. Which seems sensible.

> Intended both for scripting and interactive/informative use.
> Unlike git branch --list, no filtering is needed to just get the
> branch name.

We should not advertise this to be used for scripting. The git-branch
command is porcelain, and we reserve the right to change its output
between versions, or based on user config. Fortunately, there is already
a blessed way to get this in a script, which is:

  git symbolic-ref [--short] HEAD

I'm not opposed to having "branch --show-current" as a more user-facing
alternative for people who want to query the state. I do wonder if
people would want it to show extra information, like:

  - if we're detached, from where (like the normal "branch --list"
    shows)

  - are we on an unborn branch

  - are we ahead/behind an upstream (like "branch -v")

I guess that's slowly reinventing the first line of "git status -b".
Maybe that's a good thing; possibly this should just be a way to get
that data without doing the rest of git-status, and it's perhaps more
discoverable since it's part of git-branch. I dunno.

It just seems like in its current form it might be in an uncanny valley
where it is not quite scriptable plumbing, but not as informative as
other porcelain.

-Peff

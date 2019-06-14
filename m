Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E191D1F462
	for <e@80x24.org>; Fri, 14 Jun 2019 21:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbfFNV1Q (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jun 2019 17:27:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:55702 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726071AbfFNV1Q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jun 2019 17:27:16 -0400
Received: (qmail 22033 invoked by uid 109); 14 Jun 2019 21:27:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 14 Jun 2019 21:27:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30655 invoked by uid 111); 14 Jun 2019 21:28:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 14 Jun 2019 17:28:03 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Jun 2019 17:27:14 -0400
Date:   Fri, 14 Jun 2019 17:27:14 -0400
From:   Jeff King <peff@peff.net>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] rev-list: clarify --abbrev and --abbrev-commit usage
Message-ID: <20190614212714.GA15798@sigill.intra.peff.net>
References: <20190613221541.10007-1-emilyshaffer@google.com>
 <20190614161841.GB30083@sigill.intra.peff.net>
 <20190614205950.GC233791@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190614205950.GC233791@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 14, 2019 at 01:59:50PM -0700, Emily Shaffer wrote:

> > So no, I cannot see a way in which "rev-list --abbrev" is useful without
> > "--abbrev-commit". Which means that perhaps the former should imply the
> > latter.
> 
> Maybe it should; maybe this patch is a good excuse to do so, and enforce
> mutual exclusion of --abbrev-commit/--abbrev and --no-abbrev. Maybe it's
> also a good time to add --abbrev-commit=<length>?

Hmm, yeah, I think that would reduce confusion quite a bit. If it were
"--abbrev-commit=<length>", then "--abbrev" would not be useful for
anything in rev-list. It would still work as a historical item, but we
would not need or want to advertise it in the usage at all. Good
suggestion.

> > is not right. Possibly:
> > 
> >   --abbrev-commit [--abbrev=<n>] | --no-abbrev
> > 
> > would show the interaction more clearly, but I don't have a strong
> > opinion.
> 
> I did consider demonstrating it this way, but when both --abbrev-commit
> and --no-abbrev are used together, we don't complain or reject the
> invocation - which I would expect if the usage states the two options
> are mutually exclusive.

Ah, I see. I don't consider "|" to indicate an exclusion to the point
that the options are rejected. Only that you wouldn't want to use both,
because one counteracts the other. So every "--no-foo" is mutually
exclusive with "--foo" in the sense that one override the other. But the
outcome is "last one wins", and not "whoops, we cannot figure out what
you meant". And that's what the original:

      --abbrev=<n> | --no-abbrev

before your patch was trying to say (and I suspect there are many other
cases of "|" with this kind of last-one-wins behavior).

> I've been trying to think of good reasons not to enforce their mutual
> exclusion, and the one I keep coming back to is that --no-abbrev might
> be desired to override a git config'd abbreviation length - although I
> didn't check to see whether we have one, maybe we would want one later.
> And even in that case, I suppose that --abbrev-commit would not be
> explicitly added to the call (because we'd infer from the config), or
> that if it did need to be explicitly added (like if we need the user to
> say they want abbreviation, but we want to use their configured
> preferred length) then we could still reject the addition of
> --no-abbrev.
>
> So maybe it makes even more sense to take this patch as an opportunity
> to make these options mutually exclusive... although that checking I
> think would wind up in revision.c, and therefore widen the impact of
> the change significantly.

You can configure core.abbrev, though I'm not sure if it ever requests
abbreviation itself, or if it simply sets the length when we do happen
to abbreviate based on command-line options.

But forgetting config for a moment, last-one-wins is useful even among
command line options. E.g., imagine an alias like this:

  [alias]
  mylog = git rev-list --abbrev-commit --pretty=oneline

It's nice if you can run "git mylog --no-abbrev" and have it do what you
expect, instead of complaining "you cannot use --abbrev-commit and
--no-abbrev together".

That's a toy example, but you can imagine more elaborate scripts that
set some default options, and allow arbitrary per-invocation options to
be appended.

-Peff

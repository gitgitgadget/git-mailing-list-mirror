Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F02C433E0
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 12:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C86C92071A
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 12:45:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728561AbgFPMpE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:45:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:33014 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbgFPMpD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 08:45:03 -0400
Received: (qmail 21547 invoked by uid 109); 16 Jun 2020 12:45:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Jun 2020 12:45:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12790 invoked by uid 111); 16 Jun 2020 12:45:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Jun 2020 08:45:02 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 16 Jun 2020 08:45:02 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Don Goodman-Wilson via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Don Goodman-Wilson <don@goodman-wilson.com>
Subject: Re: [PATCH 1/9] init: allow overriding the default branch name for
 new repositories
Message-ID: <20200616124502.GC666057@coredump.intra.peff.net>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
 <90912e32da1192cfc3b39a18cb606caa46e85b1c.1591823971.git.gitgitgadget@gmail.com>
 <CAPig+cSnEvVB5vsffFXidG1-XNxDX10u2XhD9NqV3pwh8zyxxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cSnEvVB5vsffFXidG1-XNxDX10u2XhD9NqV3pwh8zyxxw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 10, 2020 at 08:16:38PM -0400, Eric Sunshine wrote:

> > +/*
> > + * Retrieves the name of the default branch. If `short_name` is non-zero, the
> > + * branch name will be prefixed with "refs/heads/".
> > + */
> > +char *git_default_branch_name(int short_name);
> 
> Overall, the internal logic regarding duplicating/freeing strings
> would probably be easier to grok if there were two separate functions:
> 
>     char *git_default_branch_name(void);
>     char *git_default_ref_name(void);
> 
> but that's subjective.

Having seen one of the callers, might it be worth avoiding handing off
ownership of the string entirely?

I.e., this comes from a string that's already owned for the lifetime of
the process (either the environment, or a string stored by the config
machinery). Could we just pass that back (or if we want to be more
careful about getenv() lifetimes, we can copy it into a static owned by
this function)?

Then all of the callers can stop dealing with the extra free(), and you
can do:

  const char *git_default_branch_name(void)
  {
	return skip_prefix("refs/heads/", git_default_ref_name());
  }

-Peff

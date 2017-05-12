Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66E6D20188
	for <e@80x24.org>; Fri, 12 May 2017 09:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756746AbdELJWU (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 05:22:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:50224 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756683AbdELJWR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 05:22:17 -0400
Received: (qmail 3958 invoked by uid 109); 12 May 2017 09:22:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 May 2017 09:22:14 +0000
Received: (qmail 22435 invoked by uid 111); 12 May 2017 09:22:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 May 2017 05:22:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 May 2017 05:22:12 -0400
Date:   Fri, 12 May 2017 05:22:12 -0400
From:   Jeff King <peff@peff.net>
To:     Sebastian Schuberth <sschuberth@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [BUG] fast-export --anonymize does not maintain fixup! commits
Message-ID: <20170512092212.wpw232jfpp3bnqol@sigill.intra.peff.net>
References: <CAHGBnuOzWSCR9wr=TSGoJSnimZDx2Gr-eR3+LFXmpc9m0cv4qw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHGBnuOzWSCR9wr=TSGoJSnimZDx2Gr-eR3+LFXmpc9m0cv4qw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 11, 2017 at 04:38:17PM +0200, Sebastian Schuberth wrote:

> I just tried to created an anonymized repo to allow the list to
> reproduce a bug in "rebase -i" I discovered in Git 2.13 for Linux
> (Windows is not affected). However, in order to reproduce the bug it's
> important to keep the "fixup!" prefixes as part of the commit
> messages. Unfortunately, "fast-export --anonymize" does not maintain
> these (or any other command prefixes in commit messages). Given that
> the --anonymize option is explicitly designed to help reproducing
> bugs, I consider this to be a bug in the --anonymize option itself.

Yes, it probably should handle those prefixes.

I don't know if I'd call it a bug. Maybe a missing feature. :)

My plan when implementing "--anonymize" was to err on the side of
simplicity and dropping information, since the most important function
is not revealing anonymized data. And then we could add back in useful
bits of data as they were determined to be useful and harmless.

So this seems like a good example of that. I think I'd prefer to see us
add in known prefixes like "fixup!" and "squash!" then try to guess what
other prefixes might be OK. I don't know of any other command prefixes
besides those two, so maybe that's all you were suggesting.

It shouldn't be too hard to add. You'd probably need to make two
adjustments to anonymize_commit_message():

  1. Teach it to store the mapping of anonymized messages, using
     anonymize_mem().

  2. Parse "fixup! <msg>" and just anonymize_mem() the second half. I
     think technically this wouldn't handle a fixup-of-fixup, but I
     don't think rebase handles recursive ones anyway.

-Peff

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D620C433F5
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 09:27:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236305AbhLJJa4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 04:30:56 -0500
Received: from cloud.peff.net ([104.130.231.41]:48560 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232841AbhLJJaz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 04:30:55 -0500
Received: (qmail 18057 invoked by uid 109); 10 Dec 2021 09:27:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Dec 2021 09:27:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28434 invoked by uid 111); 10 Dec 2021 09:27:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Dec 2021 04:27:22 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 10 Dec 2021 04:27:19 -0500
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 11/19] tests: fix broken &&-chains in `$(...)` command
 substitutions
Message-ID: <YbMddynehrDgsSWO@coredump.intra.peff.net>
References: <20211209051115.52629-1-sunshine@sunshineco.com>
 <20211209051115.52629-12-sunshine@sunshineco.com>
 <CABPp-BGBhxbvh_Ob=bR8U9f-3muiBzWmFruKLXd=K7420i8COw@mail.gmail.com>
 <CAPig+cQzTnQiwT4Nmpp8qYJOaRpy2pK7DDOu42Wk-1TfmbUxSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cQzTnQiwT4Nmpp8qYJOaRpy2pK7DDOu42Wk-1TfmbUxSg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 09, 2021 at 11:53:47AM -0500, Eric Sunshine wrote:

> On Thu, Dec 9, 2021 at 11:44 AM Elijah Newren <newren@gmail.com> wrote:
> > On Wed, Dec 8, 2021 at 11:39 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > >  test_expect_success !MINGW 'a constipated git dies with SIGPIPE even if parent ignores it' '
> > > -       OUT=$( ((trap "" PIPE; large_git; echo $? 1>&3) | :) 3>&1 ) &&
> > > +       OUT=$( ((trap "" PIPE && large_git; echo $? 1>&3) | :) 3>&1 ) &&
> >
> > Shouldn't the second ';' be replaced with '&&' as well?
> 
> Thanks for reading so carefully. In this case, the answer is "no", the
> semicolon is correct. This code legitimately wants to capture in the
> OUT variable the numeric exit status of the command preceding `echo
> $?`. If the semicolon is replaced with `&&`, then the echo won't be
> executed if the exit status is non-zero, but we want `echo` to be
> executed regardless of the exit status. So, the code is correct with
> the semicolon, and would be incorrect with `&&`. (I hope I'm
> explaining this well enough to make sense.)

That makes sense to me. I wondered why it was even worth changing the
earlier semi-colon in that case, then, but...

> It's this sort of special case which accounts for why the new linter
> (as mentioned in the cover letter) has special understanding that a
> broken &&-chain can be legitimate in certain circumstances, such as
> explicit handling of `$?`.

...your unseen magic script explains it. :)

All of the changes here look reasonable. We'd either want to know about
failure (e.g., "cd") or don't expect it to fail (e.g., "echo").

These "trap" calls are probably fine. I can't imagine why they'd fail,
but being a weird shell builtin I wonder if it's possible for them to
fail in odd circumstances. I'm happy to leave that as a hypothetical
until we see it in practice.

-Peff

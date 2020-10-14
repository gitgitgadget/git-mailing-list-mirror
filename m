Return-Path: <SRS0=1eW7=DV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C14BCC433DF
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 18:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A0932222A
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 18:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbgJNSKA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Oct 2020 14:10:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:60054 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727369AbgJNSKA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Oct 2020 14:10:00 -0400
Received: (qmail 18227 invoked by uid 109); 14 Oct 2020 18:09:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Oct 2020 18:09:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19355 invoked by uid 111); 14 Oct 2020 18:09:59 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Oct 2020 14:09:59 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 14 Oct 2020 14:09:59 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 1/3] test-lib: allow selecting tests by
 substring/regex with --run
Message-ID: <20201014180959.GC24279@coredump.intra.peff.net>
References: <pull.878.git.git.1602545164.gitgitgadget@gmail.com>
 <pull.878.v2.git.git.1602616786.gitgitgadget@gmail.com>
 <41e2528e83ba7087c9d21f0b15efed416f1512f8.1602616786.git.gitgitgadget@gmail.com>
 <20201014170413.GB21687@coredump.intra.peff.net>
 <CABPp-BEOrYhUBZ112Z7qFgwUYojmus6_Ra0G0Ts4y+n=-D5vMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BEOrYhUBZ112Z7qFgwUYojmus6_Ra0G0Ts4y+n=-D5vMw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 14, 2020 at 10:50:03AM -0700, Elijah Newren wrote:

> > > @@ -819,9 +821,8 @@ match_test_selector_list () {
> > >                       *)
> > >                               if expr "z$selector" : "z[0-9]*[^0-9]" >/dev/null
> > >                               then
> > > -                                     echo "error: $title: invalid non-numeric in test" \
> > > -                                             "selector: '$orig_selector'" >&2
> > > -                                     exit 1
> > > +                                     echo "$title" | grep -q "$selector" && return
> > > +                                     continue
> > >                               fi
> >
> > I like that you allow regexes. It's unfortunate that the skip-check
> > costs us a process in every test. It may not be that big a deal since we
> > only pay it if you use a non-numeric selector. But I wonder if there's
> > any reason not to use "expr" here, as well.
> 
> I originally used [[ $title =~ "$selector" ]] in order to avoid the
> sub-shell...but that was bash-specific.  I briefly looked to see if
> there was a shell portable way to handle regexes, wasn't having much
> luck, and decided that this is only likely to arise when people are
> passing --run and thus only running a single script and they avoid all
> the subprocesses that would have been invoked inside the test, so it's
> still a big net win overall.  Does expr handle regexes, portably?  Or
> are you suggesting dropping the regex handling and limit it to
> substring matching?  In either case, does using expr save us anything
> (isn't expr a shell command)?

There's an expr command doing a regex match in the diff context quoted
above. :)

I was wrong that it would save us a process, though. I thought it was a
builtin in modern shells, but it doesn't appear to be in either dash or
bash. So there's little reason to prefer it over grep here (switching to
globs could be done with case and would save a process).

-Peff

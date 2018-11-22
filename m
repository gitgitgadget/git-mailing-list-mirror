Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEFD61F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 16:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404318AbeKWDSp (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Nov 2018 22:18:45 -0500
Received: from cloud.peff.net ([104.130.231.41]:48684 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2388792AbeKWDSp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Nov 2018 22:18:45 -0500
Received: (qmail 24257 invoked by uid 109); 22 Nov 2018 16:38:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 22 Nov 2018 16:38:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23413 invoked by uid 111); 22 Nov 2018 16:38:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 22 Nov 2018 11:38:01 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Nov 2018 11:38:36 -0500
Date:   Thu, 22 Nov 2018 11:38:36 -0500
From:   Jeff King <peff@peff.net>
To:     Bryan Turner <bturner@atlassian.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Git Users <git@vger.kernel.org>,
        git-for-windows@googlegroups.com, git-packagers@googlegroups.com
Subject: Re: Git for Windows v2.20.0-rc0, was Re: [ANNOUNCE] Git v2.20.0-rc0
Message-ID: <20181122163835.GF28192@sigill.intra.peff.net>
References: <xmqqh8gefowy.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1811202152290.41@tvgsbejvaqbjf.bet>
 <CAGyf7-FALWBEfcu4OOsrQEKZJ=ub0=exM_f-Y7=avPqiwOeH7Q@mail.gmail.com>
 <20181121142026.GA10324@sigill.intra.peff.net>
 <CAGyf7-FDZxCTfXV_HwHRS3PiWnLR08F5B=whxAizOsjJFUCi+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGyf7-FDZxCTfXV_HwHRS3PiWnLR08F5B=whxAizOsjJFUCi+g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 21, 2018 at 11:28:28AM -0800, Bryan Turner wrote:

> But that test code exists because Bitbucket Server provides a Java API
> [1][2] which allows third-party developers to easily build arbitrary
> Git commands to invoke for their own functionality. Setting
> `GitBranchCreateBuilder.reflog(true)` will trigger adding "-l" to the
> assembled "git branch" command. I've changed the code now so that it
> will use "--create-reflog" instead; however, because many of the
> Bitbucket Server add-ons on Marketplace [3], whether free or paid, are
> not open source, and because there are a significant number of
> in-house plugins that are not listed there, it's difficult to know how
> many might be affected. If I were to hazard a guess it would be
> _none_, but I've been surprised before. The end result is that the net
> impact is hard to predict--especially because Git on the server would
> need to be upgraded to 2.20.

Yeah, that is slightly worrisome. In some sense we can guess that
calling ".reflog(true)" is in the same league as our assumption of
"probably nobody is using -l in the first place", but it's one more
place that might have encouraged people into using it, even if it's a
noop.

> (In case you're curious why we used shorthand options, it's because of
> our Windows support. While "git branch" commands rarely, if ever, get
> very long, as a general rule we use shorthand options where they exist
> to keep our command lines shorter, to allow passing more options
> without hitting the hard limit (generally 32K) imposed by
> Windows--something we _have_ had issues with on other commands. For
> commands like "git diff", where it's not possible to pass in paths via
> stdin, every character matters.)

I follow your reasoning, though that is not the engineering decision I
would have made. The long-names tend to be more robust, and while saving
a few bytes might make a case work that would not otherwise, it is
really only delaying the inevitable. But hey, it's not my product. ;)

We probably should support --stdin in more places to cover situations
like this. Patches, welcome.

Also, I have noticed that performance with a large number of pathspecs
tends to be pretty poor, as we search them linearly. I wonder if you've
run into that, too (or maybe, coming from a Java world, you simply have
a small number of extremely long path names ;) ). A while ago I
experimented with putting non-wildcard pathspecs into a trie structure
that we could traverse while walking the actual trees to diff. I never
really polished it because having a huge number of pathspecs didn't seem
like a common use case.

> To try and protect against the unexpected, we have a Supported
> Platforms [4] page which lists Git versions that we've _explicitly
> tested_ with Bitbucket Server. 2.20 won't be marked tested until a
> future release, so the majority of installs will not use it with older
> versions of the system--but there's always that subset who ignore the
> documentation. (Since we do text parsing on Git output, subtle
> breakages do happen from time to time.)
> 
> I would say it's _unlikely_ that we'll hear of any installations where
> all the conditions are met for this to come up:
> - Git 2.20
> - Bitbucket Server (without fixes)
> - Third-party add-on using `reflog(true)`

Thanks for laying this out (and again, thanks for testing and reporting
this before the release!).

I'm comfortable with continuing with the change in v2.20 at this point,
but I'm also totally fine with bumping it for another release. Your case
is about Bitbucket, but there may well be other scripts in the wild.

> It's really just that a) I was caught off guard by the change (my own
> fault for not reading the 2.19 announcement more carefully) and b)
> it's impossible for me to say with _certainty_ that it won't be an
> issue. I'd imagine that latter point is true of the change in general,
> though (it's not really possible to know what scripts it might break,
> and that's going to be true regardless of when the change actually
> gets released), and I'd agree that that shouldn't hold Git back from
> making useful improvements.

The advantage of bumping is that if you switch Bitbucket to
"--create-reflog" _now_, it's more likely to be deployed by the time the
Git change comes.

In theory that also helps people who may not have upgraded to v2.19 yet,
but I suspect in many cases people don't notice the warning at all
(because it's buried in some script output) and will only notice once
the breaking change ships. Then the deprecation period only gives us a
larger ability to say "I told you so...", but that is small satisfaction
to the person whose script was broken.

-Peff

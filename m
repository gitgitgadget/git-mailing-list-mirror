Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA32D1F597
	for <e@80x24.org>; Tue, 31 Jul 2018 19:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732252AbeGaUuh (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 16:50:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:37624 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1732248AbeGaUuh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 16:50:37 -0400
Received: (qmail 1708 invoked by uid 109); 31 Jul 2018 19:08:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 31 Jul 2018 19:08:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4489 invoked by uid 111); 31 Jul 2018 19:08:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 31 Jul 2018 15:08:56 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 31 Jul 2018 15:08:53 -0400
Date:   Tue, 31 Jul 2018 15:08:53 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Git List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH v2 01/10] t/test-lib: teach --chain-lint to detect broken
 &&-chains in subshells
Message-ID: <20180731190853.GB3372@sigill.intra.peff.net>
References: <20180626073001.6555-1-sunshine@sunshineco.com>
 <20180711064642.6933-1-sunshine@sunshineco.com>
 <20180711064642.6933-2-sunshine@sunshineco.com>
 <20180730181356.GA156463@aiede.svl.corp.google.com>
 <CAPig+cRFMKBQVVYjhS6-Yyy-aQCYXGiqG6XoqucJoedCvAzheQ@mail.gmail.com>
 <20180730205914.GE156463@aiede.svl.corp.google.com>
 <CAPig+cRTgh6DStUdmXqvhbL_7sQY6wu21h27rjq_i=kZ_d+LAw@mail.gmail.com>
 <20180731125026.GA8072@sigill.intra.peff.net>
 <CAPig+cTqod7KY=EKPbFUFK=mpO1T2jUgpozMVN_0R51vgJLsDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cTqod7KY=EKPbFUFK=mpO1T2jUgpozMVN_0R51vgJLsDw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 31, 2018 at 02:55:51PM -0400, Eric Sunshine wrote:

> > I hesitate to make any suggestion here, as I think we may have passed
> > a point of useful cost/benefit in sinking more time into this script.
> > But...is switching to awk or perl an option? Our test suite already
> > depends on having a vanilla perl, so I don't think it would be a new
> > dependency. And it would give you actual data structures.
> 
> It would, and I did consider it, however, I was very concerned about
> startup cost (launch time) with heavyweight perl considering that it
> would have to be run for _every_ test. With 13000+ tests, that cost
> was a very real concern, especially for Windows users, but even for
> MacOS users (such as myself, for which the full test suite already
> takes probably close to 30 minutes to run, even on a ram drive). So, I
> wanted something very lightweight (and deliberately used that word in
> the commit message), and 'sed' seemed the lightest-weight of the
> bunch.

Both perl and sed seem about the same on my system (sometimes one is
faster than the other, and sometimes vice versa). However, I expect for
Windows the problem is not how big the child executable is, but running
a child process at all. I might be wrong, though.

> 'awk' might be about as lightweight as 'sed', and it may even be
> possible to coerce it into handling the task (since the linter's job
> is primarily just a bunch of regex matching with very little
> "manipulating"). v1 of the linter was somewhat simpler and didn't deal
> with these more complex cases, such as nested here-docs. v1 also did
> rather more "manipulating" of the script since the result was meant to
> be run by the shell. When it came time to implement v2, which detects
> broken &&-chains itself by textual inspection, most of the
> functionality (coming from v1) was already implemented in 'sed', so
> 'awk' never really came up as a candidate since rewriting the script
> from scratch in 'awk' didn't seem like a good idea. (And, at the time
> v2 was started, I didn't know that these more complex cases would
> arise.) So, 'awk' might be a viable alternative, and perhaps I'll take
> a stab at it for fun at some point (or not), but I don't think there's
> a pressing need right now.

Yeah, I agree with that.

-Peff

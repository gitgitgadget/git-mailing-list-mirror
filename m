Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C64B20248
	for <e@80x24.org>; Wed,  6 Mar 2019 04:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbfCFEt6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 23:49:58 -0500
Received: from cloud.peff.net ([104.130.231.41]:40488 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727089AbfCFEt6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 23:49:58 -0500
Received: (qmail 4863 invoked by uid 109); 6 Mar 2019 04:49:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 06 Mar 2019 04:49:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9526 invoked by uid 111); 6 Mar 2019 04:50:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 05 Mar 2019 23:50:15 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Mar 2019 23:49:56 -0500
Date:   Tue, 5 Mar 2019 23:49:56 -0500
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?utf-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Matthieu Moy <Matthieu.Moy@gmail.com>
Subject: Re: GSoC 2019: Git's application submitted
Message-ID: <20190306044955.GC6664@sigill.intra.peff.net>
References: <CAP8UFD2kt=Rv4pC67q0s+CKjgmBON_KkK09igfwe-0709Di2RQ@mail.gmail.com>
 <CACsJy8DhDe+28z2=3v1dBqco7q2Zj12hdKKT==yWFPui8SBkiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8DhDe+28z2=3v1dBqco7q2Zj12hdKKT==yWFPui8SBkiw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 05, 2019 at 07:04:59PM +0700, Duy Nguyen wrote:

> On Mon, Feb 4, 2019 at 4:17 PM Christian Couder
> <christian.couder@gmail.com> wrote:
> >
> > Hi everyone,
> >
> > There are now ideas, micro-projects and organization application pages
> > for GSoC 2019 on https://git.github.io/
> >
> > It would be nice to have a few more project ideas.
> 
> Not sure if it's too late now. Anyway this could be something fun to
> do: support C-based tests in our test suite.
> 
> A while back I noticed some test running very long because it was
> trying a lot of input combination. The actual logic is not much, but
> because of the increasing number of test cases, overhead goes off the
> roof. The last part is probably not true, but Windows port I think is
> hit much harder than what I experience, and I think Dscho did complain
> about it.
> 
> So what this project does is somehow allow people to write test cases
> in C instead of shell. Imagine replacing t3070-wildmatch.sh with a
> binary program t3070-wildmatch that behaves the same way. This test
> framework needs to support the same basic feature set as test-lib.sh:
> TAP output, test results summary, maybe -i and --valgrind... To
> demonstrate that the test framework works, one of these long test
> files should be rewritten in C. I'm sure there's one that is simple to
> rewrite.
> 
> I'm pretty sure I had some fun with this idea and made some prototype
> but I couldn't find it. If I do, I'll post the link here.

In my experience, it's nicer to have a tool written in C that can be
driven by arbitrary input. That makes it easy to write new test cases,
because you just have to write in some easy domain-specific format
instead of embedding the test data in C code.

And many of our tests do work like that (in fact, many of the Git
plumbing tools function as that). E.g., test-date gives you direct
access to the low-level routines, and we feed it a variety of dates.

That doesn't help with the cost of invoking that tool over and over,
though, once per test case. I wonder if we could have some kind of
hybrid. I.e., where t3070 is still a shell script, but it primarily
consists of running one big binary, like:

  test-wildmatch <<-\EOF
  case 1
  case 2
  ...etc
  EOF

but with one added twist: test-wildmatch would actually generate TAP
output for each test, rather than just returning 0/1 for each success or
failure, and being embedded in a test_expect_success.

It seems like that would even be pretty easy to do, with the exception
of the numbering. It would be nice if we could intermingle this kind of
"chunk of C tests" with normal tests, but we'd have to figure out how
many tests it ran and increment our shell-script's counter
appropriately.

-Peff

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74D5E20986
	for <e@80x24.org>; Fri, 21 Oct 2016 08:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753497AbcJUInw (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 04:43:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:60526 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753283AbcJUInv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 04:43:51 -0400
Received: (qmail 11082 invoked by uid 109); 21 Oct 2016 08:43:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 21 Oct 2016 08:43:50 +0000
Received: (qmail 1088 invoked by uid 111); 21 Oct 2016 08:44:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 21 Oct 2016 04:44:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Oct 2016 04:43:48 -0400
Date:   Fri, 21 Oct 2016 04:43:48 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: Prove "Tests out of sequence" Error
Message-ID: <20161021084348.dp4jfpfownodl7nz@sigill.intra.peff.net>
References: <D9C1E13F-88A2-483E-A549-1C2294EACFEB@gmail.com>
 <CAGZ79kZo3LdcRmrjQTAvgx=H6U2tdjASK3qv5A2K5J2HQ2NvSw@mail.gmail.com>
 <20161021082035.xad6wfny5i6wtshh@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161021082035.xad6wfny5i6wtshh@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 21, 2016 at 04:20:35AM -0400, Jeff King wrote:

> Yes, but I do not see how it can trigger this:
> 
> > >   Parse errors: Tests out of sequence.  Found (2) but expected (3)
> > >                 Tests out of sequence.  Found (3) but expected (4)
> > >                 Tests out of sequence.  Found (4) but expected (5)
> > >                 Bad plan.  You planned 4 tests but ran 5.
> 
> The TAP output from one of our tests should look something like:
> 
>   ok 1 - subject one
>   ok 2 - subject two
>   ok 3 - subject three
>   ok 4 - subject four
>   # passed all 4 test(s)
>   1..4
> 
> the "plan" is the bit at the end. That looks like $test_count
> accidentally got incremented by one and we generated something like:
> 
>   ok 1 - subject one
>   ok 3 - subject two
>   ok 4 - subject three
>   ok 5 - subject four
>   1..4
> 
> which would explain the "out of sequence" errors as well as the "planned
> 4 but ran 5".

Hmm, actually the numbering problem is the other way around. It finds 2
but expects 3, so it is more like:

  ok 1 - subject one
  ok 2 - something else stuck in here!
  ok 2 - subject two
  ...

which gives us a clue. And thanks to TAP auto-numbering, you can also
trigger this like:

  ok 1 - subject one
  ok
  ok 2 - subject two

The "ok" by itself is taken to mean "ok 2". And now I have enough to
generate this locally. t5547 does:

  test_commit ok &&
  ...
  git cat-file commit $commit

which will print a line with just "ok" on it. Normally this is not sent
to stdout at all; test output goes to /dev/null unless "--verbose" is
given. When "--verbose" is used, we get all manner of random program
output intermingled with our TAP output, which is an accident waiting to
happen. Usually nobody cares, because they only use "--verbose" when
debugging a test individually (and nothing is parsing the TAP output).
But I can trigger the problem with:

  prove t5547-push-quarantine.sh :: -v

The Travis tests do exactly this (along with --tee to actually save the
output). It seems like a minor miracle that this is the first test
output that has actually triggered as TAP input. I'd suggest that the
problem is not in the test, though, but that our "--verbose" option is
unsuitable for using with a TAP harness.

The obvious fix would be to send "--verbose" output to stderr, but I
suspect that would end up annoying for people who do:

  ./t5547-push-quarantine.sh -v | less

to read long output. Probably we need some option like "--log" which
logs in the same way that "--tee" does, but _without_ sending the data
to stdout. Naively, that just means replacing the "tee" invocation with
"cat", but I suspect it will be a lot more complicated than that,
because we still need to let the TAP output go to stdout.

-Peff

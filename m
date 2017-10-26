Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E37971FAED
	for <e@80x24.org>; Thu, 26 Oct 2017 06:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751476AbdJZGcz (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Oct 2017 02:32:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:36378 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750949AbdJZGcx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Oct 2017 02:32:53 -0400
Received: (qmail 8174 invoked by uid 109); 26 Oct 2017 06:32:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 26 Oct 2017 06:32:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28488 invoked by uid 111); 26 Oct 2017 06:33:00 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 26 Oct 2017 02:33:00 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Oct 2017 23:32:51 -0700
Date:   Wed, 25 Oct 2017 23:32:51 -0700
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] t1404: add a bunch of tests of D/F conflicts
Message-ID: <20171026063250.dckc22ocr3zjmsxv@sigill.intra.peff.net>
References: <cover.1508856679.git.mhagger@alum.mit.edu>
 <be088bd57e61f4ea0dc974a65829a928ecd30534.1508856679.git.mhagger@alum.mit.edu>
 <CAPig+cRLB=dGD=+Af=yYL3M709LRpeUrtvcDLo9iBKYy2HAW-w@mail.gmail.com>
 <20171024194634.pigmvgoqtdexvjhc@sigill.intra.peff.net>
 <e66694a3-98e2-33aa-4cdd-dac41d2a89d5@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e66694a3-98e2-33aa-4cdd-dac41d2a89d5@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 25, 2017 at 10:03:09AM +0200, Michael Haggerty wrote:

> > Yeah. It's supported by dash and many other shells, but we do try to
> > avoid it[1]. I think in this case we could just drop it (but keep
> > setting the "local foo" ones to empty with "foo=".
> 
> I do wish that we could allow "local", as it avoids a lot of headaches
> and potential breakage. According to [1],

Agreed.

> > However, every single POSIX-compliant shell I've tested implements the
> > 'local' keyword, which lets you declare variables that won't be
> > returned from the current function. So nowadays you can safely count
> > on it working.
> 
> He mentions that ksh93 doesn't support "local", but that it differs from
> POSIX in many other ways, too.

Yes, the conclusion we came to in the thread I linked earlier is the
same: ksh is affected, but that shell is a problem for other reasons. I
don't know if anybody tested with "modern" ksh like mksh, though. Should
be easy enough:

  cat >foo.sh <<\EOF
  fun() {
    local x=3
    echo inside: $x
  }
  x=2
  fun
  echo after: $x
  EOF

  mksh foo.sh

which produces the expected:

  inside: 3
  after: 2

So that's good.

> Perhaps we could slip in a couple of "local" as a compatibility test to
> see if anybody complains, like we did with a couple of C features recently.

That sounds reasonable to me. But from the earlier conversation, beware
that:

  local x
  ...
  x=5

is not necessarily enough to notice the problem on broken shells (they
may complain that "local" is not a command, and quietly stomp on the
global). I think:

  local x=5

would be enough (though depend on how you use $x, the failure mode might
be pretty subtle). Or we could even add an explicit test in t0000 like
the example above.

> But I agree that this bug fix is not the correct occasion to change
> policy on something like this, so I'll reroll without "local".

Also agreed.

-Peff

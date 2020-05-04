Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA80C3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 15:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D8FF206D7
	for <git@archiver.kernel.org>; Mon,  4 May 2020 15:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbgEDPNw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 11:13:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:35836 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726509AbgEDPNw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 May 2020 11:13:52 -0400
Received: (qmail 31246 invoked by uid 109); 4 May 2020 15:13:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 04 May 2020 15:13:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17659 invoked by uid 111); 4 May 2020 15:13:51 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 04 May 2020 11:13:51 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 4 May 2020 11:13:51 -0400
From:   Jeff King <peff@peff.net>
To:     Danh Doan <congdanhqx@gmail.com>
Cc:     clime <clime7@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] ref-filter: apply --ignore-case to all sorting keys
Message-ID: <20200504151351.GC11373@coredump.intra.peff.net>
References: <20200503090952.GA170768@coredump.intra.peff.net>
 <20200503091157.GA170902@coredump.intra.peff.net>
 <20200503114351.GA28680@danh.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200503114351.GA28680@danh.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 03, 2020 at 06:44:02PM +0700, Danh Doan wrote:

> On 2020-05-03 05:11:57-0400, Jeff King <peff@peff.net> wrote:
> > +test_expect_success 'for-each-ref --ignore-case works on multiple sort keys' '
> > +	# name refs numerically to avoid case-insensitive filesystem conflicts
> > +	nr=0 &&
> > +	for email in a A b B
> > +	do
> > +		for subject in a A b B
> > +		do
> > +			GIT_COMMITTER_EMAIL="$email@example.com" \
> > +			git tag -m "tag $subject" icase-$(printf %02d $nr) &&
> > +			nr=$((nr+1))||
> 
> The CodingGuidelines said we want to spell `$nr` instead of `nr`
> inside arithmetic expansion for dash older than 0.5.4
> 
> I'm not sure if we should go with just `$((nr+1))` or it's better to
> loosen our Guidelines. Since Debian Jessie (oldest supported Debian)
> ships 0.5.7. I don't know about other systems.

Hmm, somehow I didn't know about that rule. We have many cases already
in the test suite and elsewhere (try grepping for '$(([a-z]', which
isn't exhaustive but turns up many examples).

Maybe it's time to loosen the rule?

I've actually seen style guides suggesting to never use "$" there for a
few reasons:

  - it's slightly cleaner to read (this is the recommendation and
    rationale in Google's shell style guide)

  - it's less surprising if you somehow end up with a non-number in your
    variable:

      $ foo=bar
      $ bar=41
      $ echo $((foo + 1))
      dash: 8: Illegal number: bar
      $ echo $(($foo + 1))
      42

    That's using dash. With bash, both produce the answer 42! Clearly
    this isn't something we should be doing either way, but I'd much
    rather see "illegal number" in some cases which would alert us that
    something confusing is going on.

-Peff

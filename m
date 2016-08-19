Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 048CB2018E
	for <e@80x24.org>; Fri, 19 Aug 2016 14:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754106AbcHSOwN (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 10:52:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:58144 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753616AbcHSOwN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 10:52:13 -0400
Received: (qmail 2711 invoked by uid 109); 19 Aug 2016 14:51:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 Aug 2016 14:51:25 +0000
Received: (qmail 26200 invoked by uid 111); 19 Aug 2016 14:51:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 Aug 2016 10:51:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Aug 2016 10:51:23 -0400
Date:   Fri, 19 Aug 2016 10:51:23 -0400
From:   Jeff King <peff@peff.net>
To:     Brian Henderson <henderson.bj@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        e@80x24.org
Subject: Re: [PATCH v2 1/3] diff-highlight: add some tests.
Message-ID: <20160819145123.73hf7ffysy53l3kz@sigill.intra.peff.net>
References: <20160817153124.7770-1-henderson.bj@gmail.com>
 <20160810085635.GA1672@starla>
 <20160817153124.7770-2-henderson.bj@gmail.com>
 <xmqqziob8b6i.fsf@gitster.mtv.corp.google.com>
 <20160819144235.GA29458@tci.corp.yp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160819144235.GA29458@tci.corp.yp.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 19, 2016 at 07:42:35AM -0700, Brian Henderson wrote:

> > > +# PERL is required, but assumed to be present, although not necessarily modern
> > > +# some tests require 5.8
> > > +test_expect_success PERL 'name' 'true'
> > 
> > If the platform lacks PERL prerequisite, this will simply be
> > skipped, and if the platform has it, it will always succeed.
> > 
> > I am not sure what you are trying to achieve by having this line
> > here.
> 
> I originally didn't have this line, and my comment was referring to the
> t/README which says
> 
>    Even without the PERL prerequisite, tests can assume there is a
>    usable perl interpreter at $PERL_PATH, though it need not be
>    particularly modern.
> 
> There is current functionality in diff-highlight which requires at least
> perl 5.8 (the utf8 functions). I was going to add a test for this as
> well, but I'm not super comfy with multibyte chars.

Yeah, I'd agree this test would want the PERL prereq. It is not just
using perl for one-liners in support of the script; it is testing major
perl functionality that should be skipped if we do not have a modern
perl available.

> Eric recommended adding this line, what do you think?
> 
> would `test_set_prereq PERL` be better?

test_set_prereq is for telling the test scripts that we _have_ perl, but
what I think this script wants to do is test "do we have perl?" and
abort otherwise. The way to do that is:

  if ! test_have_prereq PERL
  then
	skip_all='skipping diff-highlight tests; perl not available'
	test_done
  fi

> > > +test_expect_success 'diff-highlight does not highlight whole line' '
> > > +	dh_test \
> > > +		"aaa\nbbb\nccc\n" \
> > > +		"aaa\n000\nccc\n"
> > > +'
> 
> This (at least to me) is desired. See comment for `sub
> is_pair_interesting`

Yeah, that is an intentional behavior, and makes sense to test.

> > > +test_expect_success 'diff-highlight does not highlight mismatched hunk size' '
> > > +	dh_test \
> > > +		"aaa\nbbb\n" \
> > > +		"aaa\nb0b\nccc\n"
> > > +'
> 
> This is undesired behavior, but currently implemented for simplicity,
> see `sub show_hunk`
> 
> Do they need comments or something?

Undesired behavior should generally not be tested for. It just makes
life harder for somebody when they make a change that violates it, and
they have to figure out "oh, but it's _good_ that I changed that, the
tests were wrong" (or more likely "I didn't fix it, but it's just broken
in a different way, and neither is preferable").

If you want to document known shortcomings, the best thing to do is show
what you'd _like_ to have happen, and mark it as test_expect_failure;
the test scripts show this as a known-breakage, and somebody later who
fixes it can flip the "failure" to "success".

-Peff

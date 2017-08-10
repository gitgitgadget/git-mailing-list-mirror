Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BB2920899
	for <e@80x24.org>; Thu, 10 Aug 2017 07:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751702AbdHJHg0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 03:36:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:34158 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751391AbdHJHgY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 03:36:24 -0400
Received: (qmail 25865 invoked by uid 109); 10 Aug 2017 07:36:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 10 Aug 2017 07:36:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2243 invoked by uid 111); 10 Aug 2017 07:36:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 10 Aug 2017 03:36:47 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Aug 2017 03:36:22 -0400
Date:   Thu, 10 Aug 2017 03:36:22 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/5] interpret-trailers: add an option to show only
 existing trailers
Message-ID: <20170810073622.ojm2ezqodkcflj5y@sigill.intra.peff.net>
References: <20170809122147.g44nwaitzctbadzm@sigill.intra.peff.net>
 <20170809122439.fscozhyvxcx2oq2n@sigill.intra.peff.net>
 <20170809113820.50cfb247@twelve2.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170809113820.50cfb247@twelve2.svl.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 09, 2017 at 11:38:20AM -0700, Jonathan Tan wrote:

> > diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
> > index e5b0718ef6..525fd53e5b 100755
> > --- a/t/t7513-interpret-trailers.sh
> > +++ b/t/t7513-interpret-trailers.sh
> > @@ -1312,4 +1312,19 @@ test_expect_success 'only-trailers omits non-trailer in middle of block' '
> >  	test_cmp expected actual
> >  '
> >  
> > +test_expect_success 'only existing' '
> > +	cat >expected <<-\EOF &&
> > +		existing: existing-value
> > +	EOF
> > +	git interpret-trailers \
> > +		--only-trailers --only-existing >actual <<-\EOF &&
> > +		my subject
> > +
> > +		my body
> > +
> > +		existing: existing-value
> > +	EOF
> > +	test_cmp expected actual
> 
> Would it be worth asserting that the "sign" trailer is configured here
> and would normally appear? Maybe through a grep on the output of "git
> config".

I'd much rather re-add it than assert it with grep hackery. Note that
its presence is implied in all of the follow-on tests, too (so I had
sort of assumed that its presence in the --only-trailers test would
imply that it was carried through to the others). We can be more
explicit, though, I guess.

> > diff --git a/trailer.c b/trailer.c
> > index a4ff99f98a..88f6efe523 100644
> > --- a/trailer.c
> > +++ b/trailer.c
> > @@ -991,9 +991,10 @@ void process_trailers(const char *file, struct process_trailer_options *opts,
> >  	trailer_end = process_input_file(opts->only_trailers ? NULL : outfile,
> >  					 sb.buf, &head);
> >  
> > -	process_command_line_args(&arg_head, trailers);
> > -
> > -	process_trailers_lists(&head, &arg_head);
> > +	if (!opts->only_existing) {
> > +		process_command_line_args(&arg_head, trailers);
> > +		process_trailers_lists(&head, &arg_head);
> > +	}
> 
> This is a bit confusing, but it is correct, since
> process_command_line_args() processes both configured trailers and
> command-line trailers.

Yes, it confused me, too. That combination is why "--trailer" is
disallowed with --only-existing (which otherwise could work together). I
didn't think it was worth refactoring for a case that I don't think
anybody would care about.

> Having said that, it might be worth declaring LIST_HEAD(arg_head) inside
> the if block now.

Agreed.

-Peff

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A32E1F859
	for <e@80x24.org>; Fri, 19 Aug 2016 21:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755567AbcHSVEe (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 17:04:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:58369 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1755555AbcHSVEe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 17:04:34 -0400
Received: (qmail 25553 invoked by uid 109); 19 Aug 2016 21:04:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 Aug 2016 21:04:33 +0000
Received: (qmail 29970 invoked by uid 111); 19 Aug 2016 21:04:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 Aug 2016 17:04:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Aug 2016 17:04:31 -0400
Date:   Fri, 19 Aug 2016 17:04:31 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brian Henderson <henderson.bj@gmail.com>, git@vger.kernel.org,
        e@80x24.org
Subject: Re: [PATCH] diff-highlight: add some tests.
Message-ID: <20160819210431.usy6x3x6sdhe3vbp@sigill.intra.peff.net>
References: <xmqqh9ag39zk.fsf@gitster.mtv.corp.google.com>
 <20160819201837.GA18918@tci.corp.yp.com>
 <xmqqbn0o1ob7.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbn0o1ob7.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 19, 2016 at 01:44:28PM -0700, Junio C Hamano wrote:

> Brian Henderson <henderson.bj@gmail.com> writes:
> 
> > Junio, how does this look?
> > ...
> > +# dh_test is a test helper function which takes 1) some file data, 2) some
> > +# change of the file data, creates a diff and commit of the changes and passes
> > +# that through diff-highlight.
> > +# The optional 3rd parameter is the expected output of diff-highlight minus the
> > +# diff/commit header. This parameter is given directly to printf as the format
> > +# string (in order to properly handle ascii escape codes; CW, CR), so any '%'
> > +# need to be doubled to protect it.
> > +# Don't include a 3rd parameter if diff-highlight is supposed to leave the
> > +# input unmodified.
> > +# For convienence, the 3rd parameter can begin with a newline which will be
> > +# stripped.
> 
> You seem to be stripping any and all empty lines with "perl -pe"; I
> am not sure if that is sensible.
> 
> I really do not see the point of being able to spell
> 
> "
> aaa
> bbb
> "
> 
> when you can perfectly well read
> 
> "aaa
> bbb"
> 
> or even "aaa\nbbb\n" for that matter.  I personally do not think the
> difference is worth the cost of an extra invocation of Perl, but we
> already saw how stubborn you are, so there is no point spending my
> time on trying to convince you further.  Assuming that it is so
> precious that the input can start with an extra blank line, what you
> wrote is a sensible implementation.

I didn't want to bikeshed, so I resisted saying so up until now, but I
actually think:

  dh_test \
    "aaa\nbbb\nccc\n" \
    "aaa\n0bb\nccc\n" \
    <<-EOF
  aaa
  -${CW}b${CR}bb
  +${CW}0${CR}bb
  EOF

might before readable, if only because it lets you indent the content to
match the rest of the test content. For that matter, I'm not sure that:

  cat >a <<-\EOF &&
  aaa
  bbb
  ccc
  EOF

  cat >b <<-\EOF &&
  aaa
  0bb
  ccc
  EOF

  dh_test a b <<\EOF
  aaa
  -${CW}b${CR}bb
  +${CW}0${CR}bb
  EOF

isn't more readable, too. It's more lines, certainly, but it makes it
very easy to see what the input files look like, rather than cramming
"\n" into the middle of a string (the existing code does make the diff
easy to see for _this_ case, because the pre- and post-image line up
vertically, but that is only the case for pure transliterations like
this).

Just my two cents.

-Peff

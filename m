Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99D68202AC
	for <e@80x24.org>; Thu, 13 Jul 2017 18:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752771AbdGMSpo (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 14:45:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:39646 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751350AbdGMSpo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 14:45:44 -0400
Received: (qmail 1130 invoked by uid 109); 13 Jul 2017 18:45:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 13 Jul 2017 18:45:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3373 invoked by uid 111); 13 Jul 2017 18:45:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 13 Jul 2017 14:45:56 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Jul 2017 14:45:41 -0400
Date:   Thu, 13 Jul 2017 14:45:41 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 03/15] t: use test_decode_color rather than literal ANSI
 codes
Message-ID: <20170713184541.ferc3eif7j4mazpg@sigill.intra.peff.net>
References: <20170713145553.3epnsw23zajwg3ee@sigill.intra.peff.net>
 <20170713145841.4win5tbx4efwjsa2@sigill.intra.peff.net>
 <CAGZ79kaE7wjFR-=DiPU5xwknS1nxDHR5+S6+UGPFTF0uNBA3dQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kaE7wjFR-=DiPU5xwknS1nxDHR5+S6+UGPFTF0uNBA3dQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 13, 2017 at 11:40:32AM -0700, Stefan Beller wrote:

> On Thu, Jul 13, 2017 at 7:58 AM, Jeff King <peff@peff.net> wrote:
> 
> > I really only need t6300 and t6006 converted to build on for the rest of
> > the series. But t4207 was easy to do. t4026 still uses raw codes, but
> > converting it would be a pretty big job, so I punted.
> 
> I think it is good to have raw codes in at least one place to test
> that raw codes work, but then again it could be specific test calling
> out that this is tested.

Yeah, that thought crossed my mind, too. t4026 would definitely be the
place for it, as it is about exhaustively testing the various colors.
The others are just about feeding color codes through config and
user-formats.

> > @@ -59,7 +54,8 @@ EOF
> >  # to this test since it does not contain any decoration, hence --first-parent
> >  test_expect_success 'Commit Decorations Colored Correctly' '
> >         git log --first-parent --abbrev=10 --all --decorate --oneline --color=always |
> > -       sed "s/[0-9a-f]\{10,10\}/COMMIT_ID/" >out &&
> > +       sed "s/[0-9a-f]\{10,10\}/COMMIT_ID/" |
> > +       test_decode_color >out &&
> 
> Just some thoughts:
> 
> This extension of the pipe-chain is not making it worse as gits exit code
> is already hidden.

Yes, I noticed the existing pipe-chain. We can fix it while we're here,
though I think it's not a big deal in practice.

> The sed "s/[0-9a-f]\{10,10\}/COMMIT_ID/" is sort of funny, because
> I would have expected it to break in the future with e.g. the sha1 to longer
> hash conversion. But as we specify --abbrev=10, this seems future proof.
> In an ideal world this would be encapsulated in a function (c.f. t/diff-lib.sh).

I agree it's a bit gross. Possibly:

  git log --format='%C(auto)%d %s'

would be easier for the test to parse (I'm pretty sure that didn't exist
back when this test was written).

-Peff

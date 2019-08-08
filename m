Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27F301F731
	for <e@80x24.org>; Thu,  8 Aug 2019 11:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389565AbfHHLAZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 07:00:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:37612 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726721AbfHHLAZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 07:00:25 -0400
Received: (qmail 11973 invoked by uid 109); 8 Aug 2019 11:00:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 08 Aug 2019 11:00:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19239 invoked by uid 111); 8 Aug 2019 11:02:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 08 Aug 2019 07:02:54 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 8 Aug 2019 07:00:24 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/1] merge-recursive: avoid directory rename detection in
 recursive case
Message-ID: <20190808110023.GB14189@sigill.intra.peff.net>
References: <20190726220928.GG113966@google.com>
 <20190805223350.27504-1-newren@gmail.com>
 <20190806202829.GB26909@google.com>
 <CABPp-BFZig73jXKkKNaz=YpT4enB3_ARQ1KTz_ttPYobkY6Bhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BFZig73jXKkKNaz=YpT4enB3_ARQ1KTz_ttPYobkY6Bhg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 06, 2019 at 02:16:25PM -0700, Elijah Newren wrote:

> > > +             test_i18ngrep ! CONFLICT out &&
> > > +             test_i18ngrep ! BUG: err &&
> >
> > The BUG is gone. But should it not use i18ngrep? BUG() isn't localized.
> 
> Technically, yes, you're right. However, this line's purpose isn't
> correctness of the test but documentation for the person reading the
> testcase about what it's real original purpose was; my real test was
> the "test_must_be_empty err" check I have below it, but I added this
> line just to document the intent better.  I kind of like the
> "CONFLICT" and "BUG" lines looking similar just so the reader of the
> testcase doesn't have to try to reason through why they are different,
> although I guess it does present the problem that more careful readers
> like yourself might do a double take.

I think it would be better to drop the grep for BUG entirely.

Not BUG()-ing should be something we implicitly assume for all commands,
and checking the exit code already covers that[1]. I don't think we
should be cluttering up every test, even ones that are in response to a
BUG(), with redundant checks. If you really want to document it further,
a comment can do that without incurring extra run-time overhead. But I
think in this case that your existing comments and commit message cover
it quite well.

-Peff

[1] There are cases where there's a crash in a sub-process, but in that
    case the failure should be surfaced in the way the test is written.
    It is here, and I'd argue that any case where it isn't probably
    ought to be rewritten (because you're missing not just BUG()s, but
    probably die()).

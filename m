Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FFFF1F403
	for <e@80x24.org>; Sat,  9 Jun 2018 09:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753207AbeFIJTs (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Jun 2018 05:19:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:39972 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753178AbeFIJTr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jun 2018 05:19:47 -0400
Received: (qmail 27206 invoked by uid 109); 9 Jun 2018 09:19:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 09 Jun 2018 09:19:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2240 invoked by uid 111); 9 Jun 2018 09:20:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 09 Jun 2018 05:20:01 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 09 Jun 2018 05:19:45 -0400
Date:   Sat, 9 Jun 2018 05:19:45 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH] fsck: avoid looking at NULL blob->object
Message-ID: <20180609091945.GA6817@sigill.intra.peff.net>
References: <20180609083159.GA6158@sigill.intra.peff.net>
 <CAPig+cTgCD5=96XG=Z5FwOsPbN409DxzAfPy0p=wnoLywu++dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cTgCD5=96XG=Z5FwOsPbN409DxzAfPy0p=wnoLywu++dw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 09, 2018 at 04:38:54AM -0400, Eric Sunshine wrote:

> On Sat, Jun 9, 2018 at 4:32 AM, Jeff King <peff@peff.net> wrote:
> > Commit 159e7b080b (fsck: detect gitmodules files,
> > 2018-05-02) taught fsck to look at the content of
> > .gitmodules files. If the object turns out not to be a blob
> > at all, we just complain and punt on checking the content.
> > And since this was such an obvious and trivial code path, I
> > didn't even bother to add a test.
> > [...]
> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
> > diff --git a/t/t7415-submodule-names.sh b/t/t7415-submodule-names.sh
> > @@ -151,4 +151,22 @@ test_expect_success 'fsck detects symlinked .gitmodules file' '
> > +test_expect_success 'fsck detects non-blob .gitmodules' '
> > +       git init non-blob &&
> > +       (
> > +               cd non-blob &&
> > +
> > +               # As above, make the funny directly to avoid index restrictions.
> 
> Is there a word missing after "funny"?

Oops, should be "funny tree" (that's what I get for trying to wordsmith
it at the last minute).

> > +               mkdir subdir &&
> > +               cp ../.gitmodules subdir/file &&
> > +               git add subdir/file &&
> > +               git commit -m ok &&
> > +               tree=$(git ls-tree HEAD | sed s/subdir/.gitmodules/ | git mktree) &&
> > +               commit=$(git commit-tree $tree) &&
> 
> I see that this is just mirroring the preceding test, but do you need
> to assign to variable 'commit' which is never consulted by anything
> later in the test?

No (nor above). I think originally I had planned to points refs to these
commits, but it isn't necessary for fsck. In fact, in the final form of
the patches, we do not even need the commit at all, since we will
complain about .gitmodules in _any_ tree (early versions actually did an
extra pass to find which trees were root trees).

-Peff

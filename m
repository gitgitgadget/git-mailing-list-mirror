Return-Path: <SRS0=kCdt=CQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 294F7C433E2
	for <git@archiver.kernel.org>; Mon,  7 Sep 2020 08:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE5F9216C4
	for <git@archiver.kernel.org>; Mon,  7 Sep 2020 08:25:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbgIGIZN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Sep 2020 04:25:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:50290 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727956AbgIGIZM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Sep 2020 04:25:12 -0400
Received: (qmail 13062 invoked by uid 109); 7 Sep 2020 08:25:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 07 Sep 2020 08:25:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14559 invoked by uid 111); 7 Sep 2020 08:25:13 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 07 Sep 2020 04:25:13 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 7 Sep 2020 04:25:10 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Tom Hale <tomnott@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] add--interactive.perl: specify --no-color explicitly
Message-ID: <20200907082510.GA1264377@coredump.intra.peff.net>
References: <20200907080632.GA1261825@coredump.intra.peff.net>
 <20200907081739.GB1263923@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200907081739.GB1263923@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 07, 2020 at 04:17:39AM -0400, Jeff King wrote:

> Our color tests of "git add -p" do something a bit different from how a
> normal user would behave: we pretend there's a pager in use, so that Git
> thinks it's OK to write color to a non-tty stdout.  This comes from
> 8539b46534 (t3701: avoid depending on the TTY prerequisite, 2019-12-06),
> which allows us to avoid a lot of complicated mock-tty code.
> 
> However, those environment variables also make their way down to
> sub-processes of add--interactive, including the "diff-files" we run to
> generate the patches. As a result, it thinks it should output color,
> too. So in t3701.50, for example, the machine-readable version of the
> diff we get unexpectedly has color in it. We fail to parse it as a diff
> and think there are zero hunks.

By the way, this is an instance of a more generic bug, which is that:

  git -p my-script

will cause any sub-programs of git-my-script to think their stdout is
going to a pager, even if my-script redirects them to a file or another
pipe.

I had a solution long ago in:

  https://lore.kernel.org/git/20150810052353.GB15441@sigill.intra.peff.net/

but it raises a bunch of interesting portability questions. Since this
comes up so rarely, I never really pursued it further.

-Peff

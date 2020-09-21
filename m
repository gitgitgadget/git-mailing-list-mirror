Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C221C4363C
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 19:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20A7A2193E
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 19:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbgIUTbW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 15:31:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:35792 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726471AbgIUTbV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 15:31:21 -0400
Received: (qmail 9197 invoked by uid 109); 21 Sep 2020 19:31:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 21 Sep 2020 19:31:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23923 invoked by uid 111); 21 Sep 2020 19:31:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 21 Sep 2020 15:31:21 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 21 Sep 2020 15:31:20 -0400
From:   Jeff King <peff@peff.net>
To:     Thomas Guyot <tguyot@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Thomas Guyot-Sionnest <dermoth@aei.ca>
Subject: Re: [PATCH 2/2] Allow passing pipes for input pipes to diff
 --no-index
Message-ID: <20200921193120.GB2399334@coredump.intra.peff.net>
References: <20200918113256.8699-1-tguyot@gmail.com>
 <20200918113256.8699-3-tguyot@gmail.com>
 <20200918143647.GB1606445@nand.local>
 <CALqVohfFjsh-2jZLNNwON_V95Dfh-aEh1aMb53t4NQrM0qz1tQ@mail.gmail.com>
 <20200918171950.GA183026@coredump.intra.peff.net>
 <xmqqbli3m0w6.fsf@gitster.c.googlers.com>
 <20200918180239.GA186717@coredump.intra.peff.net>
 <f338b63f-fd89-095c-b036-8d548fd2470c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f338b63f-fd89-095c-b036-8d548fd2470c@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 20, 2020 at 08:54:53AM -0400, Thomas Guyot wrote:

> Considering the issue with MacOS I'm starting to think the best solution
> is to not use any heuristic and read passed-in files directly. That
> said, I don't think it makes much change either way (if I resurrect
> Brian's patch is will probably end up being a hybrid between the two as
> both read the pipe at the same place and my approach was simpler further
> down).
> 
> I'm not sure which way I prefer to start first - will you accept a patch
> that reads passed in files as-is if I I start with this one?

I think the ideal is:

  - implement a command-line option to read the content of paths on the
    command-line literally (i.e., reading from pipes, dereferencing
    symlinks, etc)

  - make sure we have the inverse option (which you should get for free
    in step 1 if you use parse_options)

  - flip the default to do literal reads

We'd sometimes wait several versions before that last step to give
people time to adjust scripts, etc. But in this case, I suspect it would
be OK to just flip it immediately. We don't consider "git diff" itself
part of the stable plumbing, and the --no-index part of it I would
consider even less stable. And AFAICT most people consider the current
behavior a bug because it doesn't behave like other diff tools.

-Peff

Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FAE3C47247
	for <git@archiver.kernel.org>; Tue,  5 May 2020 21:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0452620752
	for <git@archiver.kernel.org>; Tue,  5 May 2020 21:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729284AbgEEV6o (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 17:58:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:38464 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729247AbgEEV6o (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 May 2020 17:58:44 -0400
Received: (qmail 15349 invoked by uid 109); 5 May 2020 21:58:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 May 2020 21:58:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3002 invoked by uid 111); 5 May 2020 21:58:44 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 05 May 2020 17:58:44 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 5 May 2020 17:58:43 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 1/2] CI: limit GitHub Actions to designated branches
Message-ID: <20200505215843.GA646020@coredump.intra.peff.net>
References: <73de97dfebfccabe9f1bf32ea41aea5008a949cd.1588607262.git.congdanhqx@gmail.com>
 <20200504162311.GE12842@coredump.intra.peff.net>
 <20200504215824.GC45250@syl.local>
 <20200504233634.GB39798@coredump.intra.peff.net>
 <20200505002055.GC64230@syl.local>
 <20200505164326.GA64077@coredump.intra.peff.net>
 <xmqqo8r2b6y4.fsf@gitster.c.googlers.com>
 <20200505182418.GA66702@coredump.intra.peff.net>
 <20200505210451.GA645290@coredump.intra.peff.net>
 <xmqqlfm69il6.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlfm69il6.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 05, 2020 at 02:29:09PM -0700, Junio C Hamano wrote:

> > This commit adds a new job which checks a special ref within the
> > repository for CI config, and (optionally) causes all of the other jobs
> > to be skipped.
> 
> Nice---that way, all existing jobs do not even need to know about
> the special controlling ref.

Yep. Also, it only has to run once. It's not too expensive, but it does
seem to take a few seconds to run.

I think the VM setup is usually pretty quick due to the way Actions is
implemented. I made sure we avoid cloning the whole normal git.git tree,
but we still have to clone the individual config branch. It seems to
take ~3-5s to run that job. I'd have liked to make it even cheaper for
branches which don't want CI (less for latency, but more just because I
hate to waste GitHub's resources), but I think that's the best we can
do. And for cases where we actually run CI, 3s is a drop in the bucket. ;)

> > Right now the logic is to run CI for all branches by default, unless a
> > whitelist exists, in which case the branch must be mentioned there
> > (using its fully qualified ref name).
> 
> So there is no wildcard?  Not really complaining, but am wondering.

Correct, there's no wildcard. It would be easy to add one, now that this
gets us to a working shell environment with the refname available. And
probably worth doing if we don't just go the "execute a program from the
config tree" route.

> > Or since we're running a shell in a VM, we really
> > could just run "./allow-ref $refname" and let individual forks specify
> > whatever shell code they like.
> 
> I presume that you are saying "checking out the tree of refs/ci/config
> and there is a program allow-ref that can tell which one to run ci on"?

Yes, exactly.

-Peff

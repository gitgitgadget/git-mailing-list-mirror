Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62EB21FADF
	for <e@80x24.org>; Thu, 18 Jan 2018 21:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754440AbeARVhj (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 16:37:39 -0500
Received: from cloud.peff.net ([104.130.231.41]:48546 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753476AbeARVhg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 16:37:36 -0500
Received: (qmail 18919 invoked by uid 109); 18 Jan 2018 21:37:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 18 Jan 2018 21:37:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15343 invoked by uid 111); 18 Jan 2018 21:38:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 18 Jan 2018 16:38:10 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Jan 2018 16:37:32 -0500
Date:   Thu, 18 Jan 2018 16:37:32 -0500
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] read-cache: don't write index twice if we can't
 write shared index
Message-ID: <20180118213732.GA7403@sigill.intra.peff.net>
References: <CACsJy8A_moFProjfPAJFn2aP52w5qdYdOu4Ygox1qMMitNUHLg@mail.gmail.com>
 <20180114101820.4273-1-pclouds@gmail.com>
 <20180114101820.4273-3-pclouds@gmail.com>
 <CAM0VKjmGo5gjUBpTQp9M+pvZzBMDAmYYCu-5VfG-8LYRxU7i0Q@mail.gmail.com>
 <CACsJy8BBXQ9KErfiuf2ty_4szE2fiHLDiKvMig1LbSefzf-o7w@mail.gmail.com>
 <20180118132931.GA21914@sigill.intra.peff.net>
 <CACsJy8BkJXeaG3mYNEsfVK4N_-WxwU2Pk2pa1FThH1sMEW2yxA@mail.gmail.com>
 <20180118150014.GA2097@ash>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180118150014.GA2097@ash>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 18, 2018 at 10:00:14PM +0700, Duy Nguyen wrote:

> The test suite was run as root, no wonder why my removing write access
> has no effect. I got the test to pass with this, but then it fails
> with
> 
>     Can't write .prove (Permission denied) at /usr/share/perl/5.22/App/Prove.pm line 542.
> 
> Some more chown'ing or chmod'ing is required....

Ah, right. I agree that we probably ought to run the ci as non-root.
However, if the test requires non-root, it probably needs to be marked
with the SANITY prereq.

I also ran into one funny thing: if you run the script with "-i", then
we do not run the test_when_finished block. And therefore the "ro"
directory is left without its write bit, and the next test run fails, as
it cannot "rm -rf" the old trash directory out of the way.

I'm not sure there's a good solution, though. Skipping the
test_when_finished block on a "-i" run is intentional, to let you
inspect the broken state.

> Subject: [PATCH] ci: don't accidentally run the test suite as root
> 
> This script assigns and adds a user named "ci" in a subshell so the
> outer CI_USER is not affected. For some reason, CI_USER is actually
> empty on Travis linux32 builds. This makes the following "su" useless
> and the test suite is run as root.

Are we sure this was the problem on Travis, and it wasn't just an issue
with how I reproduced via docker?

-Peff

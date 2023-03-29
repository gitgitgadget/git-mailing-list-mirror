Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309EFC76196
	for <git@archiver.kernel.org>; Wed, 29 Mar 2023 02:37:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjC2Ch0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 22:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjC2ChS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 22:37:18 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB1630D3
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 19:37:03 -0700 (PDT)
Received: (qmail 5610 invoked by uid 109); 29 Mar 2023 02:37:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 29 Mar 2023 02:37:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4286 invoked by uid 111); 29 Mar 2023 02:37:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Mar 2023 22:37:02 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Mar 2023 22:37:02 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Michael J Gruber <git@grubix.eu>
Subject: Re: [PATCH 3/4] tests: drop here-doc check from internal chain-linter
Message-ID: <20230329023702.GA1793752@coredump.intra.peff.net>
References: <20230328202043.GA1241391@coredump.intra.peff.net>
 <20230328202819.GC1241631@coredump.intra.peff.net>
 <xmqqzg7wczx7.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzg7wczx7.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 28, 2023 at 02:46:12PM -0700, Junio C Hamano wrote:

> > -		if test "OK-117" != "$(test_eval_ "fail_117 && $1${LF}${LF}echo OK-\$?" 3>&1)"
> > +		test_eval_ "fail_117 && $1"
> > +		if test $? != 117
> >  		then
> > -			BUG "broken &&-chain or run-away HERE-DOC: $1"
> > +			BUG "broken &&-chain: $1"
> >  		fi
> 
> This "here-doc" linter is a cute trick.  With seemingly so little
> extra code, it catches a breakage in such an unexpected way.
> 
> Even with a very small code footprint, overhead of an extra process
> is still there, and it would be very hard to figure out what it does
> (once you are told what it does, you can probably figure out how it
> works).  These make it a "cute trick".

Yes, I thought it was quite clever (and it is attributed to you), but I
agree that I did not quite realize what it was doing until after running
git-blame. I only started with "gee, why didn't we write this in the
simpler way?", which is often a good starting point for archaeology. :)

> While it is a bit sad to see it lost, the resulting code certainly
> is easier to follow, I would think.  I do not offhand know how
> valuable detecting unterminated here-doc is, compared to the
> increased clarity of hte code.

I think the complexity is merited _if_ we think it is catching useful
cases. And I do count unterminated here-doc as a useful case, because,
as with broken &&-chains, the failure mode is so nasty (a test will
report success, even though part of the test was simply not run!).

I just think chainlint.pl is doing a good enough job of catching it that
we can rely on it. I'll be curious if Eric has input there on whether it
can do even better, which would remove all of the caveats from the
commit message.

-Peff

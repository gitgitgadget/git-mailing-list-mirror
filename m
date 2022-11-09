Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35839C433FE
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 13:11:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiKINLw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 08:11:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiKINLu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 08:11:50 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E252C1D316
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 05:11:47 -0800 (PST)
Received: (qmail 12335 invoked by uid 109); 9 Nov 2022 13:11:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 09 Nov 2022 13:11:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14554 invoked by uid 111); 9 Nov 2022 13:11:46 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 09 Nov 2022 08:11:46 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 9 Nov 2022 08:11:45 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 0/4] chainlint: improve annotated output
Message-ID: <Y2unEeio8cgmBWCX@coredump.intra.peff.net>
References: <pull.1375.git.git.1667934510.gitgitgadget@gmail.com>
 <Y2q78ofF8fsAX8XU@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y2q78ofF8fsAX8XU@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 08, 2022 at 03:28:34PM -0500, Taylor Blau wrote:

> On Tue, Nov 08, 2022 at 07:08:26PM +0000, Eric Sunshine via GitGitGadget wrote:
> > This patch series further improves the output by instead making chainlint.pl
> > annotate the original test definition rather than the parsed token stream,
> > thus preserving indentation (and whitespace, in general), here-doc bodies,
> > etc., which should make it easier for a test author to relate each problem
> > back to the source.
> 
> Very nicely done. The changes all seemed reasonable to me (and, in fact,
> the approach is pretty straightforward -- the diffstat is misleading
> since many of changes are to chainlint's expected output).
> 
> So I'm happy with it, but let's hear from some other folks who are more
> familiar with this area before we start merging it down.

I don't claim to be _that_ familiar with the code itself, but all of the
patches look reasonable to me. And most importantly, I dug out the state
of my tree from early September (via the reflog) before I fixed all of
the chainlint problems on my local topics. The improvement in the output
with this series is night and day.

I was a little surprised that using a class in patch 3 would cause such
a slowdown. But it's not that hard to believe that the workload is so
heavy on string comparison and manipulation that the overloaded string
and comparison functions introduce significant overhead. It has been a
long time since I've optimized any perl, but I remember the rule of
thumb being to minimize the number of lines of perl (because all of the
builtin stuff is blazingly fast C, and all of the perl is byte-code).

At any rate, the result you came up with doesn't look too bad. The only
risk is that you forgot to s/$token/$token->[0]/ somewhere, and I
suspect we'd have found that in running the tests.

So it all seems like a step forward to me.

-Peff

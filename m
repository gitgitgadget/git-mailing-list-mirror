Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0DA41F462
	for <e@80x24.org>; Thu, 13 Jun 2019 19:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfFMTQc (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 15:16:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:54294 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725842AbfFMTQc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jun 2019 15:16:32 -0400
Received: (qmail 4080 invoked by uid 109); 13 Jun 2019 19:16:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 13 Jun 2019 19:16:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21248 invoked by uid 111); 13 Jun 2019 19:17:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 13 Jun 2019 15:17:19 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Jun 2019 15:16:30 -0400
Date:   Thu, 13 Jun 2019 15:16:30 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Rohit Ashiwal via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Subject: Re: [PATCH 2/2] archive: avoid spawning `gzip`
Message-ID: <20190613191630.GA30854@sigill.intra.peff.net>
References: <20190413015102.GC2040@sigill.intra.peff.net>
 <8ef2164c-1d44-33bf-ea8a-49fa0b5c8abf@web.de>
 <20190415213556.GB28128@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1904261047560.45@tvgsbejvaqbjf.bet>
 <f6f32bc0-109c-e0eb-f7d2-9e46647f260c@web.de>
 <45afd432-9e45-ea76-aa1b-e8cd1264e3a0@web.de>
 <nycvar.QRO.7.76.6.1904291720120.45@tvgsbejvaqbjf.bet>
 <05e97774-5dd1-7224-940f-e50558118d93@web.de>
 <20190501181807.GC4109@sigill.intra.peff.net>
 <c00a062a-4f01-4754-3429-e7bb2a26aac1@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c00a062a-4f01-4754-3429-e7bb2a26aac1@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 10, 2019 at 12:44:54PM +0200, René Scharfe wrote:

> Am 01.05.19 um 20:18 schrieb Jeff King:
> > On Wed, May 01, 2019 at 07:45:05PM +0200, René Scharfe wrote:
> >
> >>> But since the performance is still not quite on par with `gzip`, I would
> >>> actually rather not, and really, just punt on that one, stating that
> >>> people interested in higher performance should use `pigz`.
> >>
> >> Here are my performance numbers for generating .tar.gz files again:
> 
> OK, tried one more version, with pthreads (patch at the end).  Also
> redid all measurements for better comparability; everything is faster
> now for some reason (perhaps due to a compiler update? clang version
> 7.0.1-8 now):

Hmm. Interesting that using pthreads is still slower than just shelling
out to gzip:

> master, using gzip(1):
> Benchmark #1: git archive --format=tgz HEAD
>   Time (mean ± σ):     15.697 s ±  0.246 s    [User: 19.213 s, System: 0.386 s]
>   Range (min … max):   15.405 s … 16.103 s    10 runs
> [...]
> using zlib in a separate thread (that's the new one):
> Benchmark #1: git archive --format=tgz HEAD
>   Time (mean ± σ):     16.310 s ±  0.237 s    [User: 20.075 s, System: 0.173 s]
>   Range (min … max):   15.983 s … 16.790 s    10 runs

I wonder if zlib is just slower. Or if the cost of context switching
is somehow higher than just dumping big chunks over a pipe. In
particular, our gzip-alike is still faster than pthreads:

> using a gzip-lookalike:
> Benchmark #1: git archive --format=tgz HEAD
>   Time (mean ± σ):     16.289 s ±  0.218 s    [User: 19.485 s, System: 0.337 s]
>   Range (min … max):   16.020 s … 16.555 s    10 runs

though it looks like the timings do overlap.

> > At GitHub we certainly do cache the git-archive output. We'd also be
> > just fine with the sequential solution. We generally turn down
> > pack.threads to 1, and keep our CPUs busy by serving multiple users
> > anyway.
> >
> > So whatever has the lowest overall CPU time is generally preferable, but
> > the times are close enough that I don't think we'd care much either way
> > (and it's probably not worth having a config option or similar).
> 
> Moving back to 2009 and reducing the number of utilized cores both feels
> weird, but the sequential solution *is* the most obvious, easiest and
> (by a narrow margin) lightest one if gzip(1) is not an option anymore.

It sounds like we resolved to give the "internal gzip" its own name
(whether it's a gzip-alike command, or a special name we recognize to
trigger the internal code). So maybe we could continue to default to
"gzip -cn", but platforms could do otherwise when shipping gzip there is
a pain (i.e. Windows, but maybe also anybody else who wants to set
NO_EXTERNAL_GZIP or detect it from autoconf).

-Peff

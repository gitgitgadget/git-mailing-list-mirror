Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFCD71F4C0
	for <e@80x24.org>; Tue, 22 Oct 2019 06:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387681AbfJVGmy (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 02:42:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:54490 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2387548AbfJVGmy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 02:42:54 -0400
Received: (qmail 24829 invoked by uid 109); 22 Oct 2019 06:42:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 22 Oct 2019 06:42:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13399 invoked by uid 111); 22 Oct 2019 06:45:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 22 Oct 2019 02:45:59 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 22 Oct 2019 02:42:52 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [ANNOUNCE] Git v2.24.0-rc0
Message-ID: <20191022064252.GA11308@sigill.intra.peff.net>
References: <xmqq4l065zx5.fsf@gitster-ct.c.googlers.com>
 <c554383b-b569-79f8-88f6-7017be76da9d@gmail.com>
 <CABPp-BG0Vrdo_w-e270oauLwHoLyaiTHKpfOwgLNBoeikoqq-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BG0Vrdo_w-e270oauLwHoLyaiTHKpfOwgLNBoeikoqq-g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 21, 2019 at 04:04:22PM -0700, Elijah Newren wrote:

> > 4211.3: git log --follow [...]8.56(8.41+0.15) -0.2%       3.67(3.53+0.13) -57.2%
> 
> Many nice speedups here, not just commit-graph (the rev-list cases)
> but also log -L (from sg/line-log-tree-diff-optim, I believe), and log
> --follow.  I'm curious if the log --follow speedup comes from sg's
> series or something else...

The "log --follow" speedup comes from turning on commit-graphs. You can
see a similar effect without "--follow", since "git log <path>" is going
to be dominated by the commit traversal, and not accessing the trees
(especially if <path> is at the top-level).

> > 0001.9: rev-list --objects $commit --not --all                0.08(0.05+0.03)       0.08(0.05+0.03) +0.0%       0.09(0.07+0.02) +12.5%
> 
> Looks like this one increased too, with a similar magnitude to the
> 7300.2 you pointed out.  But the base is kinda small; is this just
> noise?

Probably. I also frequently run the perf suite between major version
releases, and this kind of noise is quite common.

> I'm also curious what change it was that made these rebase tests faster.

Perf changes of this magnitude are usually pretty easy to bisect. You
can even do:

  git bisect start --term-old=slow --term-new=fast

so you don't have to confuse yourself with opposite good/bad markers.
I just ran:

  make && (cd t/perf && GIT_SKIP_TESTS=p3400.[3456] ./p3400*)

at each stopping point and eyeballed the resulting time (which for some
reason seems to be about 10x faster than Stolee's machine, but does
still show the same relative speedup). I was surprised that this also
yields 31b1de6a09 (commit-graph: turn on commit-graph by default,
2019-08-13). I wouldn't have expected commit access to dominate the
rebase time so much.

-Peff

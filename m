Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26372C433F5
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 16:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE7D460F35
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 16:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbhJKQev (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Oct 2021 12:34:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:37050 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232375AbhJKQeu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Oct 2021 12:34:50 -0400
Received: (qmail 29193 invoked by uid 109); 11 Oct 2021 16:32:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 11 Oct 2021 16:32:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19907 invoked by uid 111); 11 Oct 2021 16:32:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 11 Oct 2021 12:32:49 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 11 Oct 2021 12:32:49 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: "git reflog expire" blindly trusting timestamps in reflogs
Message-ID: <YWRnMbAOQ1t2DVHb@coredump.intra.peff.net>
References: <b25ac1cc-8e77-17e6-602a-b289c1e1cfeb@web.de>
 <30df5e39-3f2a-00d8-541b-347c43f36b38@gmail.com>
 <581663a7-9b16-e464-ada7-368f20c99ff1@web.de>
 <xmqqsfxersvy.fsf@gitster.g>
 <ba3e16f7-bf9c-c5f3-4c0d-8288db6f44c7@web.de>
 <87wnmmkzaa.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87wnmmkzaa.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 09, 2021 at 04:57:20PM +0200, Ævar Arnfjörð Bjarmason wrote:

> On Sat, Oct 09 2021, René Scharfe wrote:
> 
> > Turn off automatic background maintenance for perf tests by default to
> > avoid interference with performance measurements.
> 
> Turning off background GC during the perf tests seems like a good idea
> in general, so I think this patch should go in. Even with the WIP
> (haven't picked it up again in a while) test mode I menitoned in[1] it
> still wouldn't make any sense to run detached background GC in t/perf.
> 
> Because first of all we take the repo as-is (hardlinks and all), so
> changing it is a bug in itself.

Lots of perf tests modify the repository. This is generally OK as Git
tends to write and rename tempfiles (breaking the hardlink) rather than
modifying anything in place. We also only do the hardlink thing for the
objects/ directory, so the scope is limited.

It does make me a little nervous, but to my knowledge we've never had a
perf test which hurt the original donor repo in this way. And there are
more subtle ways to screw things up with various filesystem references;
see 36e834abc1 (t/perf: avoid copying worktree files from test repo,
2021-02-26).

That's all just an aside; I agree that we should avoid background gc
just because it confuses performance tests.

-Peff

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0BDC4338F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 17:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FE80610FD
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 17:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237557AbhHCRO2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 13:14:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:37204 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237830AbhHCROM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 13:14:12 -0400
Received: (qmail 1656 invoked by uid 109); 3 Aug 2021 17:13:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 03 Aug 2021 17:13:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15421 invoked by uid 111); 3 Aug 2021 17:13:47 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 03 Aug 2021 13:13:47 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 3 Aug 2021 13:13:46 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 0/2] [RFC] Switch default merge backend from recursive to
 ort
Message-ID: <YQl5SlmJsFbQ3Kw+@coredump.intra.peff.net>
References: <pull.1055.git.git.1627776461.gitgitgadget@gmail.com>
 <YQlnNXgk3qcGb5Bk@coredump.intra.peff.net>
 <CABPp-BGgcpMbFrEjaDxpfb8=Wr_5O76qCDq1OSbpemrnYDcsqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BGgcpMbFrEjaDxpfb8=Wr_5O76qCDq1OSbpemrnYDcsqw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 03, 2021 at 10:57:12AM -0600, Elijah Newren wrote:

> > The nice thing is that the two strategies can co-exist. So if it does
> > turn out to have any regressions, it's an easy revert to switch back,
> > and even post-release users can switch at runtime. We have pull.twohead,
> > but I don't think we have an equivalent that would impact a bare "git
> > merge" or "git rebase -m". Maybe it would be worth adding those as an
> > escape hatch?
> 
> Actually, pull.twohead is not pull specific; it already affects merge,
> rebase (-m is the default for rebase, btw), cherry-pick, and revert.
> pull.twohead has affected a bare "git merge" since 1c7b76be7d ("Build
> in merge", 2008-07-07).  I thought it was weird that "merge strategy"
> for the merge command was specified via a config option under "pull",
> and included my misgivings about it in the commit message of
> 14c4586c2d ("merge,rebase,revert: select ort or recursive by config or
> environment", 2020-11-02) when I made sequencer.c pay attention to
> that config option as well:
> 
> """
>     Also, allow folks to pick the new algorithm via config setting.  It
>     turns out builtin/merge.c already had a way to allow users to specify a
>     different default merge algorithm: pull.twohead.  Rather odd
>     configuration name (especially to be in the 'pull' namespace rather than
>     'merge') but it's there.  Add that same configuration to rebase,
>     cherry-pick, and revert.
> """
>
> But no one had an alternate suggestion or opinion on attempting to
> migrate the configuration to a different name, so it has just stuck.
> Anyway, if folks want to try out 'ort' with the 2.32 or 2.33 releases,
> they can set pull.twohead=ort.  Once we switch the default, they can
> set pull.twohead=recursive to get the old default.

Ah, thanks for clarifying. I think we are in good shape, then. We could
possibly introduce merge.twohead as a synonym, but given that most
people would probably not ever even look at this, it may not be worth
worrying about.

-Peff

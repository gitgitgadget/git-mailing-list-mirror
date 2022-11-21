Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 940C3C4332F
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 19:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbiKUT2O (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 14:28:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbiKUT2L (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 14:28:11 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BC42250C
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 11:28:10 -0800 (PST)
Received: (qmail 12563 invoked by uid 109); 21 Nov 2022 19:28:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 21 Nov 2022 19:28:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26695 invoked by uid 111); 21 Nov 2022 19:28:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 21 Nov 2022 14:28:09 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 21 Nov 2022 14:28:08 -0500
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Eric Wong <e@80x24.org>,
        Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 06/18] chainlint.pl: validate test scripts in parallel
Message-ID: <Y3vRSBptFTR+AV1f@coredump.intra.peff.net>
References: <pull.1322.git.git.1661992197.gitgitgadget@gmail.com>
 <62fc652eb47a4df83d88a197e376f28dbbab3b52.1661992197.git.gitgitgadget@gmail.com>
 <20220906223537.M956576@dcvr>
 <CAPig+cSx661-HEr3JcAD5MuYfgHviGQ1cSAftkgw6gj2FgTQVg@mail.gmail.com>
 <YxfXQ0IJjq/FT2Uh@coredump.intra.peff.net>
 <CAPig+cTge7kp9bH+Xd8wpqmEZuuEFE0xQdgqaFP1WAQ-F+xyHA@mail.gmail.com>
 <Y3u9ul1cu+L5d5IZ@coredump.intra.peff.net>
 <CAPig+cQfkkY2Eh=QD47QoUGuAiCEpxSsX24x_8ts2GTKVnV1aw@mail.gmail.com>
 <Y3vI99ZiNdXddX8C@coredump.intra.peff.net>
 <CAPig+cQEdidB4YHm9OiyOUe8mbTPBajjX5t-_6ZJVwRykXkqmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cQEdidB4YHm9OiyOUe8mbTPBajjX5t-_6ZJVwRykXkqmg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 21, 2022 at 02:00:41PM -0500, Eric Sunshine wrote:

> On Mon, Nov 21, 2022 at 1:52 PM Jeff King <peff@peff.net> wrote:
> > On Mon, Nov 21, 2022 at 01:47:42PM -0500, Eric Sunshine wrote:
> > > I think Ævar's use-case for `make` parallelization was to speed up
> > > git-bisect runs. But thinking about it now, the likelihood of "lint"
> > > problems cropping up during a git-bisect run is effectively nil, in
> > > which case setting GIT_TEST_CHAIN_LINT=1 should be a perfectly
> > > appropriate way to take linting out of the equation when bisecting.
> >
> > Yes. It's also dumb to run a straight "make test" while bisecting in the
> > first place, because you are going to run a zillion tests that aren't
> > relevant to your bisection. Bisecting on "cd t && ./test-that-fails" is
> > faster, at which point you're only running the one lint process (and if
> > it really bothers you, you can disable chain lint as you suggest).
> 
> I think I misspoke. Dredging up old memories, I think Ævar's use-case
> is that he now runs:
> 
>     git rebase -i --exec 'make test' ...
> 
> in order to ensure that the entire test suite passes for _every_ patch
> in a series. (This is due to him having missed a runtime breakage by
> only running "make test" after the final patch in a series was
> applied, when the breakage was only temporary -- added by one patch,
> but resolved by some other later patch.)

Yeah, I do that sometimes, too, especially when heavy refactoring is
involved.

> Even so, GIT_TEST_CHAIN_LINT=0 should be appropriate here too.

Agreed. But also, my original point stands. If you are running 10 CPU
minutes of tests, then a few CPU seconds of linting is not really that
important.

-Peff

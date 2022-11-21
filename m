Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BDFC433FE
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 18:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbiKUSEq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 13:04:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiKUSEp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 13:04:45 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601B95C776
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 10:04:43 -0800 (PST)
Received: (qmail 12277 invoked by uid 109); 21 Nov 2022 18:04:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 21 Nov 2022 18:04:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25945 invoked by uid 111); 21 Nov 2022 18:04:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 21 Nov 2022 13:04:43 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 21 Nov 2022 13:04:42 -0500
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
Message-ID: <Y3u9ul1cu+L5d5IZ@coredump.intra.peff.net>
References: <pull.1322.git.git.1661992197.gitgitgadget@gmail.com>
 <62fc652eb47a4df83d88a197e376f28dbbab3b52.1661992197.git.gitgitgadget@gmail.com>
 <20220906223537.M956576@dcvr>
 <CAPig+cSx661-HEr3JcAD5MuYfgHviGQ1cSAftkgw6gj2FgTQVg@mail.gmail.com>
 <YxfXQ0IJjq/FT2Uh@coredump.intra.peff.net>
 <CAPig+cTge7kp9bH+Xd8wpqmEZuuEFE0xQdgqaFP1WAQ-F+xyHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cTge7kp9bH+Xd8wpqmEZuuEFE0xQdgqaFP1WAQ-F+xyHA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 20, 2022 at 11:02:54PM -0500, Eric Sunshine wrote:

> > And if we did cache the results and avoid extra invocations via "make",
> > then we'd want all the parallelism to move to there anyway.
> >
> > Maybe that gives you more food for thought about whether perl's "use
> > threads" is worth having.
> 
> I'm not especially happy about the significant overhead of "ithreads";
> on my (old) machine, although it does improve perceived time
> significantly, it eats up quite a bit of additional user-time. As
> such, I would not be unhappy to see "ithreads" go away, especially
> since fast linting on Windows seems unattainable (at least with Perl).
> 
> Overall, I think Ævar's plan to parallelize linting via "make" is
> probably the way to go.

TBH, I think just running the linter once per test script when the
script is run would be sufficient. That is one extra process per script,
but they are already shell scripts running a bunch of processes. You get
parallelism for free because you're already running the tests in
parallel. You lose out on "don't bother linting because the file hasn't
changed", but I'm not sure that's really worth the extra complexity
overall.

-Peff

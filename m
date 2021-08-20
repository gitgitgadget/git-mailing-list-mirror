Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C48C4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 18:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2A4C6128B
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 18:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237087AbhHTSX7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 14:23:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:53474 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237617AbhHTSXq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 14:23:46 -0400
Received: (qmail 23490 invoked by uid 109); 20 Aug 2021 18:23:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 20 Aug 2021 18:23:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7053 invoked by uid 111); 20 Aug 2021 18:23:06 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 20 Aug 2021 14:23:06 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 20 Aug 2021 14:23:05 -0400
From:   Jeff King <peff@peff.net>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Carlo Arenas <carenas@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] test-lib-functions.sh: keep user's HOME, TERM and
 SHELL for 'test_pause' and 'debug'
Message-ID: <YR/zCcPF2FTeBXvH@coredump.intra.peff.net>
References: <pull.1022.git.1629393395.gitgitgadget@gmail.com>
 <CAPig+cT2FfaYBbsRMy7vxXkvsxn4BcFTn4bGJjgvJKznXg1OYg@mail.gmail.com>
 <CABPp-BFKEoHTgdSnUO86zSPYR0mLHv-vUB+Z-SoTtYQbUY4H=Q@mail.gmail.com>
 <CAPig+cRk-BB79+pO83A6Qov9W75_91gzaHY4Le1MYKDUWagugg@mail.gmail.com>
 <53752b7d-c294-9507-a7f0-af2aee491251@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <53752b7d-c294-9507-a7f0-af2aee491251@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 20, 2021 at 08:12:50AM -0400, Philippe Blain wrote:

> Thanks everyone for sharing their input and concerns. I understand that the behaviour
> change might not be wanted all the time, or by everyone.
> 
> I also did not think about the implications of changing $HOME that could lead to the
> test framework overwriting stuff in my home. I checked the tests and there are only
> a handful of them that seem to reference HOME, but still, for those tests it would be
> undesirable to reset HOME.
> 
> In light of this I'm thinking of simply adding flags to 'test_pause' and 'debug' to signal
> that one wants to use their original TERM, HOME and SHELL, with appropriate  caveats in
> the description of the functions:
> 
> test_pause     # original behaviour
> test_pause -t  # use USER_TERM
> test_pause -s  # use SHELL instead of TEST_SHELL_PATH
> test_pause -h  # use USER_HOME
> 
> and combinations of these three.
> 
> For 'debug', Carlo's idea of just symlinking/copying gdbinit and/or llldbinit to the test
> HOME might be easier, and would cover the majority of developers, I think. As for TERM,
> we could do 'debug -t' as above, or use USER_TERM always...
> 
> I'll explore these ideas before sending v2.

As an even more different alternative, what do you think about making it
easier to break out of the test suite at a particular state? That would
let you inspect it from your regular shell environment.

E.g., most of my test debugging happens via:

  ./t1234-foo.sh -i
  cd trash\ directory-1234-foo/
  gdb --args ../../git some-command

That implies that the test you're interested in is actually failing
(though I have been known to insert "false &&" to make it so), and that
running the test doesn't wreck the on-disk state.

But what if we could do something like:

  ./t1234-foo.sh --debug=42

to stop _before_ running test 42, print out the commands it would run,
and leave the trash directory so that you can inspect it yourself?

That does not have the "resume after I'm done inspecting" property that
test_pause, but IMHO that is not really that useful for debugging.

It will also occasionally cause headaches when a test relies on other
parts of the environment (e.g., environment variables defined
previously, or functions defined in the script). But I find those are
usually a minority of cases.

-Peff

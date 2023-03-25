Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A034C6FD1F
	for <git@archiver.kernel.org>; Sat, 25 Mar 2023 08:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjCYIE5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Mar 2023 04:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjCYIE4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2023 04:04:56 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B246EB1
        for <git@vger.kernel.org>; Sat, 25 Mar 2023 01:04:54 -0700 (PDT)
Received: (qmail 11668 invoked by uid 109); 25 Mar 2023 08:04:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 25 Mar 2023 08:04:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11451 invoked by uid 111); 25 Mar 2023 08:04:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 25 Mar 2023 04:04:54 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 25 Mar 2023 04:04:53 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Michael J Gruber <git@grubix.eu>, git@vger.kernel.org,
        Phillip Wood <phillip.wood123@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH] t3070: make chain lint tester happy
Message-ID: <20230325080453.GA852237@coredump.intra.peff.net>
References: <13accf6f99d367d137eefd02e3f6bf05bf099e00.1679328580.git.phillip.wood@dunelm.org.uk>
 <3714ba2f6528c38eb9c438126316a08b0cefca7c.1679696180.git.git@grubix.eu>
 <20230325063731.GB562387@coredump.intra.peff.net>
 <CAPig+cT9zjP++ECkTMjh33gzWyh_ho6n8_XYkXTHxnuGiDbnow@mail.gmail.com>
 <20230325075832.GA579632@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230325075832.GA579632@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 25, 2023 at 03:58:32AM -0400, Jeff King wrote:

> > > This looks like the right solution. I do wonder how Phillip managed to
> > > miss it, though, since the test script complains loudly.
> > 
> > I am unable to reproduce any linting errors when running this script
> > through chainlint, which is why I was more than a little confused by
> > this patch when I read it, and I was just about to ask for more
> > information, such as the actual error message.
> 
> It's not your chain-lint script, but rather the builtin one that sticks
> "(exit 117) &&" in front of the snippet and evals it. So it creates the
> exact "foo && bar &" situation by prepending a line to the snippet.

And btw, I think that is the answer to "how did Phillip not notice it?".
When running "make test" these days, we rely on chainlint.pl to detect
any problems, and then set GIT_TEST_CHAIN_LINT=0 so that the scripts do
not invoke it again. But that variable also suppresses the internal
linter, and thus "make test" passes, but running the script individually
does not.

It does seem like a recipe for confusion if the two linters are not in
agreement. I think we might want to either:

  1. Say that the internal linter still has value, and tweak the
     suppression so it only turns off the extra per-script run of
     chainlint.pl, and not the internal one (which is cheap-ish to run).

  2. Say that the internal linter does not have value, and we should
     rely on chainlint.pl. In which case we might as well ditch the
     internal one completely.

     I'm OK with this direction, if we're comfortable that there are no
     real problems that would be caught by the internal one but not the
     script.

-Peff

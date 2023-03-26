Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD50C6FD1C
	for <git@archiver.kernel.org>; Sun, 26 Mar 2023 14:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbjCZOzO convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 26 Mar 2023 10:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbjCZOzN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Mar 2023 10:55:13 -0400
Received: from mailproxy06.manitu.net (mailproxy06.manitu.net [217.11.48.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448CC4C2C
        for <git@vger.kernel.org>; Sun, 26 Mar 2023 07:55:10 -0700 (PDT)
Received: from localhost (unknown [IPv6:2001:9e8:6a4b:fe00:d15d:79a0:79b3:f596])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: michael@grubix.eu)
        by mailproxy06.manitu.net (Postfix) with ESMTPSA id 869C2580145;
        Sun, 26 Mar 2023 16:55:08 +0200 (CEST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <e240a88d-37d0-83c6-7268-0fc15f5dee18@dunelm.org.uk>
References: <13accf6f99d367d137eefd02e3f6bf05bf099e00.1679328580.git.phillip.wood@dunelm.org.uk> <3714ba2f6528c38eb9c438126316a08b0cefca7c.1679696180.git.git@grubix.eu> <20230325063731.GB562387@coredump.intra.peff.net> <CAPig+cT9zjP++ECkTMjh33gzWyh_ho6n8_XYkXTHxnuGiDbnow@mail.gmail.com> <20230325075832.GA579632@coredump.intra.peff.net> <20230325080453.GA852237@coredump.intra.peff.net> <e240a88d-37d0-83c6-7268-0fc15f5dee18@dunelm.org.uk>
Subject: Re: [PATCH] t3070: make chain lint tester happy
From:   Michael J Gruber <git@grubix.eu>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
To:     Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        phillip.wood@dunelm.org.uk
Message-ID: <167984249791.10846.2305256693136683802.git@grubix.eu>
Date:   Sun, 26 Mar 2023 16:54:57 +0200
User-Agent: alot/0.10
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood venit, vidit, dixit 2023-03-26 16:30:31:
> On 25/03/2023 08:04, Jeff King wrote:
> > On Sat, Mar 25, 2023 at 03:58:32AM -0400, Jeff King wrote:
> > 
> >>>> This looks like the right solution. I do wonder how Phillip managed to
> >>>> miss it, though, since the test script complains loudly.
> >>>
> >>> I am unable to reproduce any linting errors when running this script
> >>> through chainlint, which is why I was more than a little confused by
> >>> this patch when I read it, and I was just about to ask for more
> >>> information, such as the actual error message.
> >>
> >> It's not your chain-lint script, but rather the builtin one that sticks
> >> "(exit 117) &&" in front of the snippet and evals it. So it creates the
> >> exact "foo && bar &" situation by prepending a line to the snippet.
> > 
> > And btw, I think that is the answer to "how did Phillip not notice it?".
> > When running "make test" these days, we rely on chainlint.pl to detect
> > any problems, and then set GIT_TEST_CHAIN_LINT=0 so that the scripts do
> > not invoke it again. But that variable also suppresses the internal
> > linter, and thus "make test" passes, but running the script individually
> > does not.
> 
> Ah, that explains it, I was wondering how the CI run had passed. Thanks 
> to Michael for the patch and Peff and Eric for digging into cause of the 
> problem
> 
> Best Wishes
> 
> Phillip
> 
> > It does seem like a recipe for confusion if the two linters are not in
> > agreement. I think we might want to either:
> > 
> >    1. Say that the internal linter still has value, and tweak the
> >       suppression so it only turns off the extra per-script run of
> >       chainlint.pl, and not the internal one (which is cheap-ish to run).
> > 
> >    2. Say that the internal linter does not have value, and we should
> >       rely on chainlint.pl. In which case we might as well ditch the
> >       internal one completely.
> > 
> >       I'm OK with this direction, if we're comfortable that there are no
> >       real problems that would be caught by the internal one but not the
> >       script.
> > 
> > -Peff

Yes, I learned quite a bit from that ;)

In fact, as a list-irregular these days, I was neither aware of the
second linter, nor did I learn it from the test lib code: That gave me
the impression that chainlint.pl was merely a self-test of our linter
(which I guess was half-true for the invocation that I spotted).

I second that we should either settle for one (if one is strictly
superior) or else always run both (if we run any of them). They don't
cause a noticable overhead, do they?

Cheers
Michael

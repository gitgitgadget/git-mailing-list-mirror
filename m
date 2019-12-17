Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE84CC43603
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 05:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB4932072D
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 05:53:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbfLQFxk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 00:53:40 -0500
Received: from cloud.peff.net ([104.130.231.41]:48328 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726772AbfLQFxj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 00:53:39 -0500
Received: (qmail 29892 invoked by uid 109); 17 Dec 2019 05:53:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 17 Dec 2019 05:53:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20009 invoked by uid 111); 17 Dec 2019 05:58:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 17 Dec 2019 00:58:15 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 17 Dec 2019 00:53:38 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/7] t3701: avoid depending on the TTY prerequisite
Message-ID: <20191217055338.GC2762303@coredump.intra.peff.net>
References: <pull.172.git.1575637705.gitgitgadget@gmail.com>
 <ed870d34a8479366df786e76e2770df344469a41.1575637705.git.gitgitgadget@gmail.com>
 <20191216121859.GP6527@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191216121859.GP6527@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 16, 2019 at 01:18:59PM +0100, SZEDER Gábor wrote:

> > And we found exactly such a trick earlier already: when we added a test
> > case to verify that the main loop of `git add -i` is colored
> > appropriately. Let's use that trick instead of the TTY prerequisite.
> 
> It's much more interesting _what_ that trick is than when it was
> found.  Is it setting TERM=vt100, or is it setting both TERM=vt100 and
> GIT_PAGER_IN_USE=true?  I'm inclined to think the latter, but I'm not
> sure I interpreted the comment below right.

It's both. GIT_PAGER_IN_USE tells Git not to bother checking isatty(),
and then TERM=vt100 is necessary to override test-lib's TERM=dumb
specifically for the color code.

> In any case, there are a couple of tests in other test scripts that
> test color relying on the TTY prereq.  So maybe it would be worth to
> make this into a "global" helper function by adding it to
> 'test-lib-functions.sh', so we can drop a few more prereqs.
> 
> OTOH, some of those other tests have descriptions like:
> 
>   t3203-branch-output.sh:test_expect_success TTY '%(color) present with tty'
>   t7004-tag.sh:test_expect_success TTY '%(color) present with tty'
> 
> i.e. their description is specific about checking the behaviour with a
> tty, so I'm not entirely sure.

Hmm. I have mixed feelings on this. I do like the simplicity of avoiding
test_terminal (which is unportable and has also contributed to some
confusing behavior in the past[1]). But it also takes us further away from
a real-world setup.

That might be OK for the tests you quoted above, if we're OK with
assuming the equivalence of isatty() and GIT_PAGER_IN_USE for the color
code (though we'd probably want to make sure that's tested _somewhere_).

But it obviously would not work for test-terminal callers that are
checking the pager behavior. And I suspect it may create other oddities;
e.g., a script which calls a sub-command that looks at GIT_PAGER_IN_USE,
even though the sub-command's output is going to a pipe. Though one
could argue that's a bug[2] (that could be triggered by _actually_
sending the script's output to pager).

If we're going to get rid of test-terminal.pl (and I would be happy
enough to see it go), I'd rather we mock things up at the isatty()
level, something like what I showed in:

  https://lore.kernel.org/git/20190524062724.GC25694@sigill.intra.peff.net/

That gives us a more realistic setup, and we could reliably use it
everywhere that test-terminal is used.

-Peff

[1] I had issues a while back with test-terminal's stdin feature being
    racy:

      https://lore.kernel.org/git/20190520125016.GA13474@sigill.intra.peff.net/

[2] Long ago I had a patch to make PAGER_IN_USE more careful by making
    sure that our pipe is the same as the pager pipe. It did (and does)
    work, but it would need some portability adjustments. I never
    bothered to follow up because it really does seem to be a pretty
    unlikely setup in practice. But if you're curious:

      https://lore.kernel.org/git/20150810052353.GB15441@sigill.intra.peff.net/

-Peff

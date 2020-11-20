Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DFD9C64E69
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 18:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D59B2415A
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 18:39:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731413AbgKTSjG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Nov 2020 13:39:06 -0500
Received: from cloud.peff.net ([104.130.231.41]:36914 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731407AbgKTSjF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Nov 2020 13:39:05 -0500
Received: (qmail 5816 invoked by uid 109); 20 Nov 2020 18:39:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 20 Nov 2020 18:39:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9306 invoked by uid 111); 20 Nov 2020 18:39:04 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 20 Nov 2020 13:39:03 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 20 Nov 2020 13:39:03 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/7] t1300: test "set all" mode with value_regex
Message-ID: <20201120183903.GA320614@coredump.intra.peff.net>
References: <pull.796.git.1605801143.gitgitgadget@gmail.com>
 <2da2131114eb47e70ccaf8fb9c51bf7fb5b173b0.1605801143.git.gitgitgadget@gmail.com>
 <xmqqo8jtvvby.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo8jtvvby.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 19, 2020 at 02:24:33PM -0800, Junio C Hamano wrote:

> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> > +test_expect_success 'set all config with value_regex' '
> > +	q_to_tab >initial <<-\EOF &&
> > +	[abc]
> > +	Qkey = one
> > +	EOF
> > +
> > +	cp initial .git/config &&
> 
> Not a new problem with this patch, but does the above pattern
> introduce potential problems?  I am wondering if overwriting the
> config file with a little piece that has only the stuff the test is
> interested in, while wiping the parts that may be essential for
> repository integrity (e.g. "extensions.objectFormat"), is OK in the
> long run (brian cc'ed for his sha256 work).  There also are
> autodetected crlf settings etc. that are in the .git/config when a
> test repository is created, and we probably would want to keep them
> intact.

t1300 is full of this kind of junk. Several years ago, while working on
some of the repositoryformatversion code, I noticed that we will accept
a repository that does not have core.repositoryformatversion set at all,
nor even has a .git/config present!

It's easy to fix in the code, but it causes failures all over t1300. So
then I started converting t1300 to use "config --file" (which
almost certainly didn't exist back when most of those tests were
originally written).  I don't remember how or why it got hairy, but it
was enough that I eventually dropped it (unlike many of my other stale
topics, I don't think I've even kept rebasing it forward as a WIP).

Possibly I was concerned that people in the wild were relying on a blank
or missing config being the same as repositoryformatversion=0. That will
definitely stop working in a sha256 world anyway, though, because
they'll need the objectFormat extension.

So that got a bit off-track, but I think:

  - t1300 already is very much like this, so it's not a new thing

  - but I would be happy not to see it go further in that direction,
    even if it means inconsistency with the rest of the script

-Peff

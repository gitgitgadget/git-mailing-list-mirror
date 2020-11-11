Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E21C388F9
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 18:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6028206FB
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 18:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbgKKSHP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 13:07:15 -0500
Received: from cloud.peff.net ([104.130.231.41]:54768 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbgKKSHO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 13:07:14 -0500
Received: (qmail 13592 invoked by uid 109); 11 Nov 2020 18:07:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 11 Nov 2020 18:07:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17669 invoked by uid 111); 11 Nov 2020 18:07:13 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 11 Nov 2020 13:07:13 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 11 Nov 2020 13:07:13 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 9/9] add -i: verify in the tests that colors can be
 overridden
Message-ID: <20201111180713.GC9902@coredump.intra.peff.net>
References: <pull.785.git.1605051739.gitgitgadget@gmail.com>
 <38355ec98f04783367d74e38cda3ce5d6632c7ac.1605051739.git.gitgitgadget@gmail.com>
 <20201111023549.GB806755@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2011111635140.18437@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2011111635140.18437@tvgsbejvaqbjf.bet>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 11, 2020 at 04:53:13PM +0100, Johannes Schindelin wrote:

> > If we are using dash, then surely BASH_XTRACEFD does not matter either
> > way?
> 
> It kinda does, though. Dash _does_ respect the `BASH_XTRACEFD` variable,
> funnily enough, but does not hand the settings through to sub-shells,
> whereas Bash does.

Really? That's news to me, and doesn't seem to trigger:

  [bash uses it]
  $ bash -xc 'BASH_XTRACEFD=3; echo foo' 3>trace
  + BASH_XTRACEFD=3
  foo
  $ cat trace
  + echo foo

  [dash does not]
  $ dash -xc 'BASH_XTRACEFD=3; echo foo' 3>trace
  + BASH_XTRACEFD=3
  + echo foo
  foo
  $ cat trace

> > Perhaps the subshell is important if we are running bash, though.
> 
> The most important thing, which I of course _failed_ to describe most
> prominently, is that _in general_ `-x` will mess up the `err` file, i.e.
> when running with anything but Bash. Therefoer we need the `grep` instead
> of a `test_cmp`, and that's what I tried to convey in v2.

Yeah. I understood that part (because it has bit me so many times ;) ),
but I agree it's good to make it clear.

> Oh my. I really had tried to avoid going _this_ deep. The `.meta` setting
> is not even read by the interactive add command:
> 
> 	$ git grep -w meta git-add--interactive.perl add-interactive.c \
> 		add-patch.c
> 
> comes up empty.
> [how and why add--interactive.perl reads color config]

Hmm. Right, I knew about that weirdness. But I assumed that the builtin
add-interactive was doing the diffs in-core. Otherwise, why would we
have seen the failure to load diff.color.frag in the first place?
Philippe's simple example just did "git add -p". So now I'm doubly
confused.

The answer seems to be that render_hunk() always _replaces_ the colors
we got from running the external diff. Whereas the perl version only
applied coloring when reading back in the results of an edit operation
(and likewise used the frag color when generating a split hunk header).

I'm not sure that what the builtin version is doing is wrong, but it
seems like it's putting a lot of extra effort into parsing colors off of
the colorized version. Whereas the perl version just assumes the lines
match up. I do wonder if there are corner cases we might hit around
filters here, though. The lines we get from a filter might bear no
resemblance at all to diff lines. The only thing we require in the perl
version is that they have correspond 1-to-1 with the unfiltered diff
lines in meaning.

> For those reasons, v2 brings more changes than I had hoped for. In the
> end, it is a better patch series, obviously. So even if I was reluctant to
> work on all this: thank you for prodding me.

Heh. Sorry and thanks, I guess? :) I'll try to read over v2 carefully.

-Peff

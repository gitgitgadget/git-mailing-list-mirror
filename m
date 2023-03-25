Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B696C6FD20
	for <git@archiver.kernel.org>; Sat, 25 Mar 2023 07:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjCYH6f (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Mar 2023 03:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjCYH6e (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2023 03:58:34 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF085E1A8
        for <git@vger.kernel.org>; Sat, 25 Mar 2023 00:58:33 -0700 (PDT)
Received: (qmail 11623 invoked by uid 109); 25 Mar 2023 07:58:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 25 Mar 2023 07:58:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11355 invoked by uid 111); 25 Mar 2023 07:58:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 25 Mar 2023 03:58:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 25 Mar 2023 03:58:32 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Michael J Gruber <git@grubix.eu>, git@vger.kernel.org,
        Phillip Wood <phillip.wood123@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH] t3070: make chain lint tester happy
Message-ID: <20230325075832.GA579632@coredump.intra.peff.net>
References: <13accf6f99d367d137eefd02e3f6bf05bf099e00.1679328580.git.phillip.wood@dunelm.org.uk>
 <3714ba2f6528c38eb9c438126316a08b0cefca7c.1679696180.git.git@grubix.eu>
 <20230325063731.GB562387@coredump.intra.peff.net>
 <CAPig+cT9zjP++ECkTMjh33gzWyh_ho6n8_XYkXTHxnuGiDbnow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cT9zjP++ECkTMjh33gzWyh_ho6n8_XYkXTHxnuGiDbnow@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 25, 2023 at 02:54:45AM -0400, Eric Sunshine wrote:

> > > +     {
> > > +             test-tool wildmatch wildmatch \
> > > +                     aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaab \
> > > +                     "*a*a*a*a*a*a*a*a*a*a*a*a*a*a*a*a" &
> > > +             pid=$!
> > > +     } &&
> >
> > This looks like the right solution. I do wonder how Phillip managed to
> > miss it, though, since the test script complains loudly.
> 
> I am unable to reproduce any linting errors when running this script
> through chainlint, which is why I was more than a little confused by
> this patch when I read it, and I was just about to ask for more
> information, such as the actual error message.

It's not your chain-lint script, but rather the builtin one that sticks
"(exit 117) &&" in front of the snippet and evals it. So it creates the
exact "foo && bar &" situation by prepending a line to the snippet.

So running (on seen, which has 1f2e05f0b79):

  ./t3070-wildmatch.sh

gives me:

  ok 1890 - ipathmatch (via ls-files): match '[Z-y]' 'Z'
  error: bug in the test script: broken &&-chain or run-away HERE-DOC:
  	test-tool wildmatch wildmatch \
  		aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaab \
  		"*a*a*a*a*a*a*a*a*a*a*a*a*a*a*a*a" &
  	pid=$! &&
  	sleep 2 &&
  	! kill $!

-Peff

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA81C6FD1F
	for <git@archiver.kernel.org>; Sat, 25 Mar 2023 19:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjCYTrH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Mar 2023 15:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjCYTrF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2023 15:47:05 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7962B8E
        for <git@vger.kernel.org>; Sat, 25 Mar 2023 12:47:04 -0700 (PDT)
Received: (qmail 19004 invoked by uid 109); 25 Mar 2023 19:47:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 25 Mar 2023 19:47:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19137 invoked by uid 111); 25 Mar 2023 19:47:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 25 Mar 2023 15:47:01 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 25 Mar 2023 15:47:00 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Michael J Gruber <git@grubix.eu>, git@vger.kernel.org,
        Phillip Wood <phillip.wood123@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH] t3070: make chain lint tester happy
Message-ID: <20230325194700.GA186113@coredump.intra.peff.net>
References: <13accf6f99d367d137eefd02e3f6bf05bf099e00.1679328580.git.phillip.wood@dunelm.org.uk>
 <3714ba2f6528c38eb9c438126316a08b0cefca7c.1679696180.git.git@grubix.eu>
 <20230325063731.GB562387@coredump.intra.peff.net>
 <CAPig+cT9zjP++ECkTMjh33gzWyh_ho6n8_XYkXTHxnuGiDbnow@mail.gmail.com>
 <20230325075832.GA579632@coredump.intra.peff.net>
 <20230325080453.GA852237@coredump.intra.peff.net>
 <CAPig+cTBwAugUL_u_SPebFRj4j1Gv6FMuH8vn+uUy=6_+GXy3A@mail.gmail.com>
 <20230325084107.GB3738217@coredump.intra.peff.net>
 <20230325085127.GA26684@coredump.intra.peff.net>
 <CAPig+cQtLFX4PgXyyK_AAkCvg4Aw2RAC5MmLbib-aHHgTBcDuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cQtLFX4PgXyyK_AAkCvg4Aw2RAC5MmLbib-aHHgTBcDuw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 25, 2023 at 05:09:15AM -0400, Eric Sunshine wrote:

> > Hmm, actually chainlint.pl does not seem to catch this:
> >
> > -- >8 --
> > test_expect_success 'ok, first line cannot break &&-chain' '
> >         true &
> >         pid=$!
> > '
> >
> > test_expect_success 'not ok, failure is lost' '
> >         false &&
> >         true &
> >         pid=$!
> > '
> > -- >8 --
> 
> Right, that's one of the "special cases" I mentioned earlier; an
> intentional simplification of implementation to keep the complexity
> level down. Although the linter is genuinely parsing the shell code,
> it doesn't really understand or check shell semantics, and is just
> using simple heuristics to detect the common types of &&-breakage and
> missing `return 1`.

Ah, OK. I thought the special case was ignoring the first one (which you
probably need to do to make "{ cmd & pid=$!; }" work inside braces), not
the second.

> This particular simplification is that if it encounters one of the
> special cases in which some construct (such as "&") should not be
> considered as a break in the &&-chain, it clears all "??AMP??" flags
> which come before that point in the current parse context.

That makes sense, though it does mean that an easy typo ("&" for "&&")
wouldn't get caught. I don't recall this case happening a lot, though.

It does make me inclined to keep the built-in checker, just because we
know it can catch this case (at least at the top-level of the snippet).

> More specifically, it's not even building a parse tree; it's just
> trying to detect problems on-the-fly as it parses, so when it finds
> something like "&" which is _not_ a breakage, it can't easily go back
> and recheck which earlier "??AMP??" annotations are still needed. So,
> it just clears the earlier ones unconditionally with the hope of not
> letting too many false-negatives through. It would certainly be
> possible to make it do a better job of detection, but doing so would
> complicate the code quite a bit. (Eventually, I think it would be best
> to build a parse tree, which would make it easier to incorporate other
> linting ideas I have in mind, but I don't have any immediate plans to
> do so.)

Yeah, I certainly don't think this case merits all that effort. I'm
thinking it is worth tweaking CHAINLINTSUPPRESS so that the internal one
is run by "make test", though.

-Peff

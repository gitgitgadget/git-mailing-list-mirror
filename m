Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C9AC6FD1C
	for <git@archiver.kernel.org>; Sat, 25 Mar 2023 08:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbjCYIvb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Mar 2023 04:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCYIva (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2023 04:51:30 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF321DBF4
        for <git@vger.kernel.org>; Sat, 25 Mar 2023 01:51:28 -0700 (PDT)
Received: (qmail 13026 invoked by uid 109); 25 Mar 2023 08:51:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 25 Mar 2023 08:51:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12155 invoked by uid 111); 25 Mar 2023 08:51:28 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 25 Mar 2023 04:51:28 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 25 Mar 2023 04:51:27 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Michael J Gruber <git@grubix.eu>, git@vger.kernel.org,
        Phillip Wood <phillip.wood123@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH] t3070: make chain lint tester happy
Message-ID: <20230325085127.GA26684@coredump.intra.peff.net>
References: <13accf6f99d367d137eefd02e3f6bf05bf099e00.1679328580.git.phillip.wood@dunelm.org.uk>
 <3714ba2f6528c38eb9c438126316a08b0cefca7c.1679696180.git.git@grubix.eu>
 <20230325063731.GB562387@coredump.intra.peff.net>
 <CAPig+cT9zjP++ECkTMjh33gzWyh_ho6n8_XYkXTHxnuGiDbnow@mail.gmail.com>
 <20230325075832.GA579632@coredump.intra.peff.net>
 <20230325080453.GA852237@coredump.intra.peff.net>
 <CAPig+cTBwAugUL_u_SPebFRj4j1Gv6FMuH8vn+uUy=6_+GXy3A@mail.gmail.com>
 <20230325084107.GB3738217@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230325084107.GB3738217@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 25, 2023 at 04:41:08AM -0400, Jeff King wrote:

> Right, the chainlint.pl one is much more thorough. I just wondered if
> there were any cases we were worried about it missing, that the internal
> one catches. We found one in this thread, but as discussed, it is not a
> problem (presumably chainlint.pl catches a "real" case where an
> earlier line is hidden by the "&", but I wouldn't mind seeing it
> complain here as a matter of style/future-proofing).

Hmm, actually chainlint.pl does not seem to catch this:

-- >8 --
test_expect_success 'ok, first line cannot break &&-chain' '
	true &
	pid=$!
'

test_expect_success 'not ok, failure is lost' '
	false &&
	true &
	pid=$!
'
-- >8 --

It's a little funny, because we actually background the whole "false &&
true" chain. So if you did "wait $pid" at the end, you would see the
failure. But the test in this thread doesn't actually do that (it
depends on kill after 2 seconds not finding the pid). Plus in general
this seems like an accident that we should be flagging.

-Peff

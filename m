Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A0D8C3DA6F
	for <git@archiver.kernel.org>; Thu, 24 Aug 2023 21:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239535AbjHXVDD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Aug 2023 17:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243686AbjHXVCs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2023 17:02:48 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E0C1FFB
        for <git@vger.kernel.org>; Thu, 24 Aug 2023 14:02:39 -0700 (PDT)
Received: (qmail 16432 invoked by uid 109); 24 Aug 2023 21:02:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 24 Aug 2023 21:02:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22508 invoked by uid 111); 24 Aug 2023 21:02:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 24 Aug 2023 17:02:39 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 24 Aug 2023 17:02:38 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Teng Long <dyroneteng@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 1/3] leak tests: mark a handful of tests as leak-free
Message-ID: <20230824210238.GA940724@coredump.intra.peff.net>
References: <cover.1692902414.git.me@ttaylorr.com>
 <b1711c4c817f95011bc477a9485c115b4926c7da.1692902414.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b1711c4c817f95011bc477a9485c115b4926c7da.1692902414.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 24, 2023 at 02:40:38PM -0400, Taylor Blau wrote:

> In the topic merged via 5a4f8381b6 (Merge branch
> 'ab/mark-leak-free-tests', 2021-10-25), a handful of tests in the suite
> were marked as leak-free.
> 
> As far as I can tell, each patch from that series ran tests from a
> handful of subject areas, such as "some ls-files tests", or "all trace2
> tests". This left some gaps in which tests had and hadn't been audited
> to be leak-free.
> 
> This patch closes those gaps by exporting TEST_PASSES_SANITIZE_LEAK=true
> before sourcing t/test-lib.sh on most remaining leak-free tests. This
> list was compiled by doing:
> 
>     $ make SANITIZE=leak
>     $ make \
>         GIT_TEST_PASSING_SANITIZE_LEAK=check \
>         GIT_TEST_SANITIZE_LEAK_LOG=true \
>         GIT_TEST_OPTS=-vi test

So having resolved my "oops, lsan logs are racy" problem, my system now
agrees with yours on which tests are now leak-free. And we definitely
_were_ leak free less than year ago when I posted that other patch. So
I'm not sure I buy the "these were missed in 5a4f8381b6" logic.

The one in t5571, I mentioned earlier that I bisected to 861c56f6f9
(branch: fix a leak in setup_tracking, 2023-06-11).

The one in t7516 seems to have been fixed by 866b43e644
(do_read_index(): always mark index as initialized unless erroring out,
2023-06-29).

I found both by bisecting between v2.39.0 (which shows the leak) and
v2.42.0 (which doesn't).

-Peff

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9B2C433FE
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 19:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234675AbiKVTIc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 14:08:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234478AbiKVTI3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 14:08:29 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E36275D3
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 11:08:28 -0800 (PST)
Received: (qmail 18818 invoked by uid 109); 22 Nov 2022 19:08:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 22 Nov 2022 19:08:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5882 invoked by uid 111); 22 Nov 2022 19:08:28 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 22 Nov 2022 14:08:28 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 22 Nov 2022 14:08:27 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Git List <git@vger.kernel.org>,
        Kyle Zhao <kylezhao@tencent.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH] t5516: fail to run in verbose mode
Message-ID: <Y30eK/mNYeLNtOi2@coredump.intra.peff.net>
References: <20221121134040.12260-1-worldhello.net@gmail.com>
 <xmqqo7szsjs4.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo7szsjs4.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 22, 2022 at 01:19:39PM +0900, Junio C Hamano wrote:

> Jiang Xin <worldhello.net@gmail.com> writes:
> 
> > From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> >
> > The test case "push with config push.useBitmap" of t5516 was introduced
> > in commit 82f67ee13f (send-pack.c: add config push.useBitmaps,
> > 2022-06-17). It won't work in verbose mode, e.g.:
> >
> >     $ sh t5516-fetch-push.sh --run='1,115' -v
> >
> > This is because "git-push" will run in a tty in this case, and the
> 
> Right.  "-v" involves redirecting the stdout/stderr of the commands
> being run in the test to stdout/stderr in the environment the tests
> are run, so
> 
>     $ sh t5516-fetch-push.sh --run='1,115' -v >log 2>&1
> 
> would have succeeded correctly.  Forcing the behaviour with the
> "--quiet" option is certainly a good way to gain stability.

I agree this is a good fix for now, but I wonder philosophically what it
means. That is, I could see two arguments:

  1. Our tests sometimes run with stderr connected to a tty and
     sometimes not. This means the test environment isn't consistent,
     and perhaps we should be piping all "-v" tests through "cat" or
     something so that the environment is stable.

  2. Having "-v" run through a tty is yet another source of variation
     that may help us find bugs (though of course sometimes it finds
     false positives). I'm a little uncomfortable with this just because
     it's not providing us variation in any kind of planned or cohesive
     way. This failure lasted for months before somebody noticed it was
     broken under "-v".

     But if we take that approach, then tests are responsible for
     handling both cases. Passing "--quiet" here works, though it feels
     like making test_subcommand more flexible is the right fix. Looks
     like we had an "inexact" variant at one point, but it was dropped
     (because it was buggy) in 16dcec218b (test-lib-functions: remove
     test_subcommand_inexact, 2022-03-25).

None of which needs to hold up this patch, but I wonder if we'd want to
pursue the larger fix in (1).

-Peff

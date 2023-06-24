Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBABEB64D7
	for <git@archiver.kernel.org>; Sat, 24 Jun 2023 01:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbjFXBbI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jun 2023 21:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjFXBbH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2023 21:31:07 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C3C213A
        for <git@vger.kernel.org>; Fri, 23 Jun 2023 18:31:06 -0700 (PDT)
Received: (qmail 14302 invoked by uid 109); 24 Jun 2023 01:31:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 24 Jun 2023 01:31:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8805 invoked by uid 111); 24 Jun 2023 01:31:08 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 23 Jun 2023 21:31:08 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 23 Jun 2023 21:31:04 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Emily Shaffer <nasamuffin@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v3 06/12] builtin/config.c: test misuse of format_config()
Message-ID: <20230624013104.GE95358@coredump.intra.peff.net>
References: <a2a891a069f46d3d77cafe61f64402c93cffaae4.1687290233.git.gitgitgadget@gmail.com>
 <20230623203219.3255267-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230623203219.3255267-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 23, 2023 at 01:32:19PM -0700, Jonathan Tan wrote:

> "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > +test_expect_success '--show-origin with --default' '
> > +	test_must_fail git config --show-origin --default foo some.key
> > +'
> 
> On my machine, this fails with
> 
>   BUG: config.c:4035: current_config_origin_type called outside config callback
>   /usr/local/google/home/jonathantanmy/git/t/test-lib-functions.sh: line 1067: 3255109 Aborted                 "$@" 2>&7
>   test_must_fail: died by signal 6: git config --show-origin --default foo some.key
> 
> (So it indeed fails, as expected, but test_must_fail seems to not like
> the exit code.)
> 
> Not sure if we need to be more precise with the exit code we're testing
> for.

That is test_must_fail operating as intended. We should _never_ hit a
BUG() call, no matter what garbage we get from the user or the disk. The
resolution is generally one of:

  - there really is a bug, so we should fix it

  - the invocation is garbage and expected to fail, but we should catch
    it sooner and give a nice error message, rather than getting as far
    as a BUG() call

But I didn't look at the patches to know which case this is.

-Peff

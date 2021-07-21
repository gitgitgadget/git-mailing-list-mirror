Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 603AAC12002
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 08:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 464F9611C1
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 08:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235371AbhGUHdO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 03:33:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:55866 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236241AbhGUHao (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 03:30:44 -0400
Received: (qmail 7361 invoked by uid 109); 21 Jul 2021 08:10:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 21 Jul 2021 08:10:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32216 invoked by uid 111); 21 Jul 2021 08:11:00 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 21 Jul 2021 04:11:00 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 21 Jul 2021 04:10:59 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, avarab@gmail.com
Subject: Re: [PATCH] multi-pack-index: fix potential segfault without
 sub-command
Message-ID: <YPfWkzRtQKthOgZx@coredump.intra.peff.net>
References: <8c0bb3e0dc121bd68f7014000fbb60b28750a0fe.1626715096.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8c0bb3e0dc121bd68f7014000fbb60b28750a0fe.1626715096.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 19, 2021 at 01:18:49PM -0400, Taylor Blau wrote:

> Since cd57bc41bb (builtin/multi-pack-index.c: display usage on
> unrecognized command, 2021-03-30) we have used a "usage" label to avoid
> having two separate callers of usage_with_options (one when no arguments
> are given, and another for unrecognized sub-commands).
> 
> But the first caller has been broken since cd57bc41bb, since it will
> happily jump to usage without arguments, and then pass argv[0] to the
> "unrecognized subcommand" error.
> 
> Many compilers will save us from a segfault here, but the end result is
> ugly, since it mentions an unrecognized subcommand when we didn't even
> pass one, and (on GCC) includes "(null)" in its output.
> 
> Move the "usage" label down past the error about unrecognized
> subcommands so that it is only triggered when it should be. While we're
> at it, bulk up our test coverage in this area, too.

Good find. The code change seems obviously correct.

> +test_expect_success 'usage shown without sub-command' '
> +	test_expect_code 129 git multi-pack-index 2>err &&
> +	! test_i18ngrep "unrecognized subcommand" err
> +'

I think we're avoiding test_i18ngrep in new code these days.

-Peff

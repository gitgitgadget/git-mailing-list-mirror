Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93327C0018C
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 18:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 618AF233F6
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 18:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731967AbgLPSrT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 13:47:19 -0500
Received: from cloud.peff.net ([104.130.231.41]:34924 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731964AbgLPSrS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 13:47:18 -0500
Received: (qmail 24022 invoked by uid 109); 16 Dec 2020 18:46:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 16 Dec 2020 18:46:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32055 invoked by uid 111); 16 Dec 2020 18:46:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 16 Dec 2020 13:46:37 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 16 Dec 2020 13:46:37 -0500
From:   Jeff King <peff@peff.net>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        "Daniel C . Klauer" <daniel.c.klauer@web.de>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH] pack-redundant: fix crash when one packfile in repo
Message-ID: <X9pWDRAn7GmJgt7Z@coredump.intra.peff.net>
References: <CANYiYbHOczhRoJkOofFNQ6VA3BiyOF=QjffFBDvLn43Ts8B67w@mail.gmail.com>
 <20201216100952.16890-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201216100952.16890-1-worldhello.net@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 16, 2020 at 05:09:52AM -0500, Jiang Xin wrote:

> Command `git pack-redundant --all` will crash if there is only one
> packfile in the repository.  This is because, if there is only one
> packfile in local_packs, `cmp_local_packs` will do nothing and will
> leave `pl->unique_objects` as uninitialized.

Thanks, that makes sense. And I'm glad I waited to get the opinion of
somebody much more clueful. Mine was a band-aid, but yours is hitting
the root cause and will help any other downstream code that assumes
unique_objects isn't NULL.

>  builtin/pack-redundant.c  |  6 ++++
>  t/t5323-pack-redundant.sh | 65 +++++++++++++++++++++++++++++----------

The new test coverage makes sense, I think, though as Junio noted, it
should be done independent of the $git_pack_redundant change (which will
also make the diff a lot easier to review).

-Peff

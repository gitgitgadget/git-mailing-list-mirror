Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF254C433E0
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 18:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF10764E62
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 18:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232895AbhBQScj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 13:32:39 -0500
Received: from cloud.peff.net ([104.130.231.41]:36054 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231562AbhBQSci (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 13:32:38 -0500
Received: (qmail 19426 invoked by uid 109); 17 Feb 2021 18:31:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 17 Feb 2021 18:31:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6975 invoked by uid 111); 17 Feb 2021 18:31:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 17 Feb 2021 13:31:57 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 17 Feb 2021 13:31:57 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?Q?Ren=C3=A9_Scharfe=2E?= <l.s.r@web.de>
Cc:     Eli Schwartz <eschwartz@archlinux.org>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] pretty: add merge and exclude options to %(describe)
Message-ID: <YC1hHYeCmC6+heWZ@coredump.intra.peff.net>
References: <7418f1d8-78c2-61a7-4f03-62360b986a41@archlinux.org>
 <5561d11b-08c3-bcf7-5d37-a7d6c6bfb715@web.de>
 <b7bd37c4-ab13-0297-da46-716e26de10d6@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b7bd37c4-ab13-0297-da46-716e26de10d6@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 14, 2021 at 11:10:57AM +0100, René Scharfe. wrote:

> Allow restricting the tags used by the placeholder %(describe) with the
> options match and exclude.  E.g. the following command describes the
> current commit using official version tags, without those for release
> candidates:
> 
>    $ git log -1 --format='%(describe:match=v[0-9]*,exclude=*rc*)'

An interesting side effect of this series is that it allows remote users
asking for archives to fill in this data, too (by using export-subst
placeholders). That includes servers allowing "git archive --remote",
but also services like GitHub that will run git-archive on behalf of
clients.

I wonder what avenues for mischief this provides. Certainly using extra
CPU to run git-describe. But I guess also probing at otherwise hidden
refs using the match/exclude system (though since it's limited to
refs/tags/, that's pretty unlikely).

I present this mostly as an observation, not an objection. Certainly we
already have %D which can look at hidden refs. And I strongly suspect
that the server-side git-upload-archive does not respect hidden refs
when resolving object names in the first place.

Kind of an interesting thought as we extend the formatting language,
though. I generally think of them as something that is always under
control of caller, but export-subst's $Format$ will come from the repo
contents.

-Peff

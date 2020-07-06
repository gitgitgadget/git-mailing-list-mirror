Return-Path: <SRS0=tGm0=AR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA20C433E1
	for <git@archiver.kernel.org>; Mon,  6 Jul 2020 20:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB9B020675
	for <git@archiver.kernel.org>; Mon,  6 Jul 2020 20:41:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgGFUlH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jul 2020 16:41:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:50180 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbgGFUlH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jul 2020 16:41:07 -0400
Received: (qmail 13513 invoked by uid 109); 6 Jul 2020 20:41:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 06 Jul 2020 20:41:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19279 invoked by uid 111); 6 Jul 2020 20:41:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 06 Jul 2020 16:41:07 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 6 Jul 2020 16:41:06 -0400
From:   Jeff King <peff@peff.net>
To:     trygveaa@gmail.com
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Heba Waly <heba.waly@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Wait for child on signal death for aliases to
 builtins
Message-ID: <20200706204106.GA85133@coredump.intra.peff.net>
References: <20200704221839.421997-1-trygveaa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200704221839.421997-1-trygveaa@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 05, 2020 at 12:18:37AM +0200, trygveaa@gmail.com wrote:

> From: Trygve Aaberge <trygveaa@gmail.com>
> 
> When you hit ^C all the processes in the tree receives it. When a git
> command uses a pager, git ignores this and waits until the pager quits.
> However, when using an alias there is an additional process in the tree
> which didn't ignore the signal. That caused it to exit which in turn
> caused the pager to exit. This fixes that for aliases to builtins.
> 
> This was originally fixed in 46df6906f3 (see that for a more in
> explanation), but broke by a regression in b914084007.

Good catch. The regression is technically in b914084007, but the real
culprit is the extra (commented out) code path added in ee4512ed48
(trace2: create new combined trace facility, 2019-02-22).

Your fix here looks good, but it does make me wonder if we could avoid
or shrink this duplicate code path. I.e., could it just do the logging
necessary but still leave the actual process spawn to the
execv_dashed_external() below. It may be hard to untangle, though, so
certainly this makes sense in the meantime.

A test would be nice, but I don't think it's very feasible for the same
reason mentioned in 46df6906f3.

-Peff

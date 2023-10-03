Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64FFE8FDAF
	for <git@archiver.kernel.org>; Tue,  3 Oct 2023 20:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241051AbjJCUQW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Oct 2023 16:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbjJCUQV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2023 16:16:21 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9687FA7
        for <git@vger.kernel.org>; Tue,  3 Oct 2023 13:16:18 -0700 (PDT)
Received: (qmail 14452 invoked by uid 109); 3 Oct 2023 20:16:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 03 Oct 2023 20:16:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14444 invoked by uid 111); 3 Oct 2023 20:16:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 03 Oct 2023 16:16:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 3 Oct 2023 16:16:17 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] builtin/repack.c: avoid making cruft packs preferred
Message-ID: <20231003201617.GE1562@coredump.intra.peff.net>
References: <19d9aae08eab05c6b5dda4c2090236b1c3f62998.1696349955.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <19d9aae08eab05c6b5dda4c2090236b1c3f62998.1696349955.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 03, 2023 at 12:27:51PM -0400, Taylor Blau wrote:

> Note that this behavior is usually just a performance regression. But
> it's possible it could be a correctness issue.
> 
> Suppose an object was duplicated among the cruft and non-cruft pack. The
> MIDX will pick the one from the pack with the lowest mtime, which will
> always be the cruft one. But if the non-cruft pack happens to sort
> earlier in lexical order, we'll treat that one as preferred, but not all
> duplicates will be resolved in favor of that pack.
> 
> So if we happened to have an object which appears in both packs
> (e.g., due to a cruft object being freshened, causing it to appear
> loose, and then repacking it via the `--geometric` repack) it's possible
> the duplicate would be picked from the non-preferred pack.

I'm not sure I understand how that is a correctness issue. The contents
of the object are the same in either pack. Or do you mean that the
pack-reuse code in pack-objects.c may get confused and try to use the
wrong pack/offset when sending the object out? I would think it would
always be coming from the preferred pack for that code (so the outcome
is just that we fail to do the pack-reuse optimization very well, but we
don't generate a wrong answer).

Other than that, the explanation and patch make perfect sense to me, and
the patch looks good.

-Peff

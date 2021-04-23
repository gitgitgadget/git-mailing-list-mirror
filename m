Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFADC433ED
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 12:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C89A06145A
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 12:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbhDWM6F (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 08:58:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:33296 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230305AbhDWM6E (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 08:58:04 -0400
Received: (qmail 6744 invoked by uid 109); 23 Apr 2021 12:57:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 23 Apr 2021 12:57:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8208 invoked by uid 111); 23 Apr 2021 12:57:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 23 Apr 2021 08:57:27 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 23 Apr 2021 08:57:26 -0400
From:   Jeff King <peff@peff.net>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH] refs: remove EINVAL specification from the errno
 sideband in read_raw_ref_fn
Message-ID: <YILENm8vZE28HyuZ@coredump.intra.peff.net>
References: <pull.1011.git.git.1619173446857.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1011.git.git.1619173446857.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 23, 2021 at 10:24:06AM +0000, Han-Wen Nienhuys via GitGitGadget wrote:

> Subject: refs: remove EINVAL specification from the errno sideband in read_raw_ref_fn

The subject says "read_raw_ref_fn", but the patch is touching
refs_resolve_ref_unsafe(). The former is an abstract type, and I didn't
dig to see the relationships, but I'll focus on the code change in the
patch.

> A grep for EINVAL */*c reveals that no code inspects EINVAL after reading
> references.

I don't think that's sufficient, for two reasons:

  - in general we try to be careful about forks and topics in flight,
    which might end up with semantic conflicts. So we don't necessarily
    assume that we can see all code, and prefer if any subtle changes
    like this at least result in a compile failure (e.g., changing
    function name or signature). In practice, this is balanced with how
    likely such code is, how bad the breakage would be, what we're
    gaining, etc.

  - just because they are not looking for EINVAL specifically doesn't
    mean they are not looking at errno at all (e.g., after calling
    refs_resolve_ref_unsafe(), lock_ref_oid_basic() does so). So we have
    to set errno to _something_ after the error. After your patch, we
    don't set it at all for these error returns, and so we'll be left
    with whatever junk was in errno from a previous unrelated syscall,
    which could be very misleading. Since we have to set it to
    something, EINVAL seems like a reasonable value.

I certainly buy the argument that errno is a pretty lousy channel for
passing back error data, for a number of reasons.  If we were going all
the way towards getting rid of errno in this function (and replacing it
with something better, as we must, since some callers _do_ care about
more detailed information), I could see the value. But this patch
doesn't get us anywhere useful and risks regressions in the meantime.

-Peff

Return-Path: <SRS0=HTZL=AL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 214BBC433E0
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 18:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED4452067D
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 18:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbgF3Szi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Jun 2020 14:55:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:46408 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726682AbgF3Szh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jun 2020 14:55:37 -0400
Received: (qmail 13727 invoked by uid 109); 30 Jun 2020 18:55:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 30 Jun 2020 18:55:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25724 invoked by uid 111); 30 Jun 2020 18:55:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 30 Jun 2020 14:55:36 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 30 Jun 2020 14:55:36 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Git List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 2/3] t4216: fix broken '&&'-chain
Message-ID: <20200630185536.GA1888406@coredump.intra.peff.net>
References: <cover.1593536481.git.me@ttaylorr.com>
 <5a20a97658fa8e6c874c9c9cafb2cf49e39f94d6.1593536481.git.me@ttaylorr.com>
 <CAPig+cQv3cHe5ci3mDvNKYXbVQt6Rp5icG-woaDCqfAtzZ6SZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cQv3cHe5ci3mDvNKYXbVQt6Rp5icG-woaDCqfAtzZ6SZw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 30, 2020 at 01:50:22PM -0400, Eric Sunshine wrote:

> > diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
> > @@ -53,7 +53,7 @@ sane_unset GIT_TRACE2_PERF_BRIEF
> >  sane_unset GIT_TRACE2_CONFIG_PARAMS
> 
> Not related to this patch, but 'sane_unset' is pointless outside of a
> test since there is no &&-chain to maintain. Plain 'unset' would work
> just as well and be less misleading.

We do this in lots of other places, too. Try:

  git grep sane_unset | grep -v '&&'

Though seeing the variables they cover, I think many of them may come
from the same few authors. :)

I wonder if it is worth keeping these as sane_unset, though. Your
comment is based on the knowledge that the "sane" part of the function
is ignoring the return value. But we could conceivably have other
portability fixes (it's not impossible that a shell wants one "unset"
per variable, for example), in which case we'd want it in more places.

That's hypothetical, of course, but saying "just use our portable unset
wrapper that behaves sanely" seems like exactly what these call sites
want, now and in a hypothetical future.

-Peff

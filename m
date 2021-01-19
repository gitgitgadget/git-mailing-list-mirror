Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DB3C433E0
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 22:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6222C23104
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 22:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbhASWzN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 17:55:13 -0500
Received: from cloud.peff.net ([104.130.231.41]:60386 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727387AbhASWyp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 17:54:45 -0500
Received: (qmail 15377 invoked by uid 109); 19 Jan 2021 22:53:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 19 Jan 2021 22:53:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13505 invoked by uid 111); 19 Jan 2021 22:53:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 19 Jan 2021 17:53:58 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 19 Jan 2021 17:53:56 -0500
From:   Jeff King <peff@peff.net>
To:     Jacob Vosmaer <jacob@gitlab.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] ls-refs.c: minimize number of refs visited
Message-ID: <YAdjBC7z2eE1Z0uk@coredump.intra.peff.net>
References: <20210119144251.27924-1-jacob@gitlab.com>
 <20210119144251.27924-2-jacob@gitlab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210119144251.27924-2-jacob@gitlab.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 19, 2021 at 03:42:51PM +0100, Jacob Vosmaer wrote:

> The previous implementation of ls-refs would perform exactly one ref
> walk, matching each ref against the prefixes (if any) provided by the
> user. This can be expensive if there are a lot of refs and the user
> only cares about a small subset of them.
> 
> In this patch we analyze the prefixes provided by the user and build a
> minimal set of disjoint prefixes that contains all of them. We then do
> a ref walk for each of these minimal prefixes.

Thanks for posting this. I have a vague recollection that we considered
this either when we did the for-each-ref prefixes, or when we added
ls-refs prefixes, but I can't seem to find either. At any rate, at
GitHub we haven't generally found it to be a problem because our
horrifically-large repos tend to be aggregated alternates repos, not the
ones people serve upload-pack out of (though I did just time it, and
some of our largest repos should save a few hundred milliseconds per
advertisement, which is certainly not nothing).

I do think we should reuse the code from ref-filter, as Taylor showed.

> This commit also fixes a bug in ls-refs.c that was not triggered
> before: we were using a strvec set to zero, which is not how you are
> supposed to initialize a strvec. We now call strvec_init after zeroing.

Good catch. It didn't matter until now because nobody relied on having a
NULL entry when no prefix had been added (instead, they always iterated
over prefixes->nr). IMHO that is worth fixing as a separate commit.

-Peff

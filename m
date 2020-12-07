Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C99AC4361B
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 18:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B9602389F
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 18:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbgLGSt1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 13:49:27 -0500
Received: from cloud.peff.net ([104.130.231.41]:55140 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725960AbgLGSt1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 13:49:27 -0500
Received: (qmail 8870 invoked by uid 109); 7 Dec 2020 18:48:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 07 Dec 2020 18:48:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25036 invoked by uid 111); 7 Dec 2020 18:48:45 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 07 Dec 2020 13:48:45 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 7 Dec 2020 13:48:45 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     me@ttaylorr.com, git@vger.kernel.org, dstolee@microsoft.com,
        gitster@pobox.com, martin.agren@gmail.com, szeder.dev@gmail.com
Subject: Re: [PATCH v2 23/24] pack-bitmap-write: relax unique rewalk condition
Message-ID: <X855DX0CE//Cndwb@coredump.intra.peff.net>
References: <X8fBHz2A82hxUzV8@nand.local>
 <20201207181909.3032039-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201207181909.3032039-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 07, 2020 at 10:19:09AM -0800, Jonathan Tan wrote:

> Quoting from the next patch [1]:
> 
> >              |   runtime (sec)    |   peak heap (GB)   |
> >              |                    |                    |
> >              |   from  |   with   |   from  |   with   |
> >              | scratch | existing | scratch | existing |
> >   -----------+---------+----------+---------+-----------
> >   last patch | 100.641 |   35.560 |   2.152 |    2.224 |
> >   this patch |  99.720 |   11.696 |   2.152 |    2.217 |
> 
> That is true, but it is not ameliorated much :-(
> 
> If you have steps to generate these timings, I would like to try
> comparing the performance between all patches and all-except-23.

Yes, the drop in CPU performance is disappointing. And there may be a
better way of selecting the commits that recovers some of it.

But all-except-23 is not workable from a memory usage perspective.
Originally we did not have that commit at all, and a full repack of our
git/git fork network (i.e., all forks stuffed into one alternates repo)
went from 16GB to OOM-ing after growing 80+GB (I don't know how large it
would have gone on a bigger machine).

-Peff

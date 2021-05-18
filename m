Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB01C433ED
	for <git@archiver.kernel.org>; Tue, 18 May 2021 07:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17EFE611BF
	for <git@archiver.kernel.org>; Tue, 18 May 2021 07:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240896AbhERHnb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 03:43:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:57492 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239746AbhERHnb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 03:43:31 -0400
Received: (qmail 11365 invoked by uid 109); 18 May 2021 07:42:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 May 2021 07:42:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5470 invoked by uid 111); 18 May 2021 07:42:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 May 2021 03:42:14 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 18 May 2021 03:42:11 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, stolee@gmail.com,
        git@jeffhostetler.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 2/4] csum-file.h: increase hashfile buffer size
Message-ID: <YKNv0zeobEFgHsad@coredump.intra.peff.net>
References: <pull.916.git.1616785928.gitgitgadget@gmail.com>
 <pull.916.v2.git.1621254292.gitgitgadget@gmail.com>
 <9dc602f6c4221e2259778842ec3d1eda57508333.1621254292.git.gitgitgadget@gmail.com>
 <YKNtUKIHoCCOMYmn@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YKNtUKIHoCCOMYmn@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 18, 2021 at 03:31:28AM -0400, Jeff King wrote:

> Does this have to use the same-size buffer? We could read and check
> smaller chunks, like:
> 
>   while (count > 0) {
> 	static unsigned char chunk[1024];
> 	unsigned int chunk_len = sizeof(chunk) < count ? sizeof(chunk) : count;
> 	ssize_t ret = read_in_full(f->check_fd, chunk, chunk_len);
> 
> 	if (ret < 0)
> 	   ...
> 	if (ret != count)
> 	   ...
> 	if (memcmp(buf, chunk, chunk_len))
> 	   ...
> 	buf += chunk_len;
> 	count -= chunk_len;
>   }

That should be "ret != chunk_len" in the middle conditional, of course.
In case you do go this route (I typed this straight into my email, so
other bugs may be lurking. But I noticed that one. :) ).

-Peff

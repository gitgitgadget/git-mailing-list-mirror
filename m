Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE8ACC432BE
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 09:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B1E260FE6
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 09:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244735AbhIBJKs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 05:10:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:37232 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233656AbhIBJKs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 05:10:48 -0400
Received: (qmail 21779 invoked by uid 109); 2 Sep 2021 09:09:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 02 Sep 2021 09:09:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22752 invoked by uid 111); 2 Sep 2021 09:09:51 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 02 Sep 2021 05:09:51 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 2 Sep 2021 05:09:48 -0400
From:   Jeff King <peff@peff.net>
To:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, hanwen@google.com
Subject: Re: [PATCH 3/3] fixup! reftable: add a heap-based priority queue for
 reftable records
Message-ID: <YTCU3F+0sKcrym6F@coredump.intra.peff.net>
References: <20210902053023.44006-1-carenas@gmail.com>
 <20210902053023.44006-4-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210902053023.44006-4-carenas@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 01, 2021 at 10:30:23PM -0700, Carlo Marcelo Arenas Belón wrote:

> diff --git a/reftable/pq.c b/reftable/pq.c
> index 8918d158e2..a6acca006b 100644
> --- a/reftable/pq.c
> +++ b/reftable/pq.c
> @@ -43,12 +43,14 @@ int merged_iter_pqueue_is_empty(struct merged_iter_pqueue pq)
>  
>  void merged_iter_pqueue_check(struct merged_iter_pqueue pq)
>  {
> +#ifndef NDEBUG
>  	int i = 0;
>  	for (i = 1; i < pq.len; i++) {
>  		int parent = (i - 1) / 2;
>  
>  		assert(pq_less(pq.heap[parent], pq.heap[i]));
>  	}
> +#endif
>  }

This will trigger -Wunused-parameter warnings, since the function body
is now empty when NDEBUG is undefined. Probably switching the assert()
to die() would be better, since the whole point of the function is just
to exit on error.

If there's a problem using die() from the reftable code, it could also
return an error and the caller in the test helper could propagate it.

-Peff

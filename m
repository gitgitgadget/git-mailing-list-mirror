Return-Path: <SRS0=WCE0=5E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D05C4332D
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 16:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68FB420658
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 16:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbgCSQHI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Mar 2020 12:07:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:43966 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727064AbgCSQHI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Mar 2020 12:07:08 -0400
Received: (qmail 25831 invoked by uid 109); 19 Mar 2020 16:07:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Mar 2020 16:07:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28313 invoked by uid 111); 19 Mar 2020 16:16:47 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 19 Mar 2020 12:16:47 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 19 Mar 2020 12:07:07 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/6] t5616: use rev-parse instead to get HEAD's object_id
Message-ID: <20200319160707.GE3513282@coredump.intra.peff.net>
References: <cover.1584625896.git.congdanhqx@gmail.com>
 <b9beadcc510301ba385f1b01b653024c8f369b49.1584625896.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b9beadcc510301ba385f1b01b653024c8f369b49.1584625896.git.congdanhqx@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 19, 2020 at 09:00:05PM +0700, Đoàn Trần Công Danh wrote:

> Only HEAD's object_id is necessary, rev-list is an overkill.
> 
> Despite POSIX requires grep(1) treat single pattern with <newline>
> as multiple patterns.
> busybox's grep(1) (as of v1.31.1) haven't implemented it yet.
> 
> Use rev-parse to simplify the test and avoid busybox unimplemented
> features.

That makes sense. It would also future-proof us against the test
changing the graph such that HEAD actually has ancestors.

> diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
> index 77bb91e976..135187c5b5 100755
> --- a/t/t5616-partial-clone.sh
> +++ b/t/t5616-partial-clone.sh
> @@ -49,7 +49,7 @@ test_expect_success 'do partial clone 1' '
>  test_expect_success 'verify that .promisor file contains refs fetched' '
>  	ls pc1/.git/objects/pack/pack-*.promisor >promisorlist &&
>  	test_line_count = 1 promisorlist &&
> -	git -C srv.bare rev-list HEAD >headhash &&
> +	git -C srv.bare rev-parse HEAD >headhash &&

Maybe worth using "rev-parse --verify" which would double check that we
produced a useful hash (it seems like an unlikely failure mode, but it's
easy enough to cover).

-Peff

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E615EC433B4
	for <git@archiver.kernel.org>; Fri,  7 May 2021 21:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B743261157
	for <git@archiver.kernel.org>; Fri,  7 May 2021 21:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbhEGV5u (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 May 2021 17:57:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:47670 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229470AbhEGV5t (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 May 2021 17:57:49 -0400
Received: (qmail 2939 invoked by uid 109); 7 May 2021 21:56:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 07 May 2021 21:56:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4158 invoked by uid 111); 7 May 2021 21:56:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 07 May 2021 17:56:49 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 7 May 2021 17:56:47 -0400
From:   Jeff King <peff@peff.net>
To:     Will Chandler <wfc@wfchandler.org>
Cc:     git@vger.kernel.org, ps@pks.im
Subject: Re: [PATCH] refs: cleanup directories when deleting packed ref
Message-ID: <YJW3n6lVWVAuLQap@coredump.intra.peff.net>
References: <YJVQpaDwkQH/aCee@mini.wfchandler.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YJVQpaDwkQH/aCee@mini.wfchandler.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 07, 2021 at 10:37:25AM -0400, Will Chandler wrote:

> When deleting a packed ref, a lockfile is made in the directory that
> would contain the loose copy of that ref, creating any directories in
> the ref's path that do not exist. When the transaction completes, the
> lockfile is deleted, but any empty parent directories made when creating
> the lockfile are left in place.  These empty directories are not removed
> by 'pack-refs' or other housekeeping tasks and will accumulate over
> time.
> 
> When deleting a loose ref, we remove all empty parent directories at the
> end of the transaction.
> 
> This commit applies the parent directory cleanup logic used when
> deleting loose refs to packed refs as well.

Hmm. I can certainly believe that such a bug exists, but...

> +test_expect_success 'directory not created deleting packed ref' '
> +	git branch d1/d2/r1 HEAD &&
> +	git pack-refs --all &&
> +	test_path_is_missing .git/refs/heads/d1/d2 &&
> +	git branch -d d1/d2/r1 &&
> +	test_path_is_missing .git/refs/heads/d1/d2 &&
> +	test_path_is_missing .git/refs/heads/d1
> +'

...this test passes even without your patch applied. I wonder if there's
something else required to trigger the problem.

-Peff

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B249FC4338F
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 03:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84EDD60C40
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 03:55:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236073AbhHSD4c (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Aug 2021 23:56:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:51782 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235806AbhHSD4c (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Aug 2021 23:56:32 -0400
Received: (qmail 11242 invoked by uid 109); 19 Aug 2021 03:55:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 19 Aug 2021 03:55:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26187 invoked by uid 111); 19 Aug 2021 03:55:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 18 Aug 2021 23:55:55 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 18 Aug 2021 23:55:55 -0400
From:   Jeff King <peff@peff.net>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Han-Wen Nienhuys <hanwen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH] fixup! propagate errno from failing read
Message-ID: <YR3WS1AnqCuiJWyX@coredump.intra.peff.net>
References: <pull.1068.git.git.1629203489546.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1068.git.git.1629203489546.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 17, 2021 at 12:31:29PM +0000, Han-Wen Nienhuys via GitGitGadget wrote:

> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index cc4b10236e2..dd17718160a 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -109,6 +109,20 @@ test_expect_success 'git branch -m n/n n should work' '
>  	git reflog exists refs/heads/n
>  '
>  
> +test_expect_success 'git branch -m with symlinked .git/refs' '
> +	git init subdir &&
> +	test_when_finished "rm -rf subdir" &&
> +	(cd subdir &&
> +		for d in refs objects packed-refs ; do
> +		rm -rf .git/$d &&
> +		ln -s ../../.git/$d .git/$d ; done ) &&
> +	git --git-dir subdir/.git/ branch rename-src &&
> +	expect=$(git rev-parse rename-src) &&
> +	git --git-dir subdir/.git/ branch -m rename-src rename-dest &&
> +	test $(git rev-parse rename-dest) = "$expect" &&
> +	git branch -D rename-dest
> +'

This test presumably needs the SYMLINKS prerequisite. I noticed that the
Windows CI for "next" is now failing.

-Peff

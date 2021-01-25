Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20973C433E6
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 23:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F054522AAA
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 23:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732558AbhAYXrQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jan 2021 18:47:16 -0500
Received: from cloud.peff.net ([104.130.231.41]:38312 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732475AbhAYVQt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 16:16:49 -0500
Received: (qmail 9695 invoked by uid 109); 25 Jan 2021 21:16:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 25 Jan 2021 21:16:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21891 invoked by uid 111); 25 Jan 2021 21:16:04 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 25 Jan 2021 16:16:04 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 25 Jan 2021 16:16:03 -0500
From:   Jeff King <peff@peff.net>
To:     Jacob Vosmaer <jacob@gitlab.com>
Cc:     git@vger.kernel.org, jeffhost@microsoft.com,
        jonathantanmy@google.com, gitster@pobox.com
Subject: Re: [PATCH v2] upload-pack.c: fix filter spec quoting bug
Message-ID: <YA81EwddIG7QVI/1@coredump.intra.peff.net>
References: <YAs2RMT1rEH/2LSp@coredump.intra.peff.net>
 <20210125170921.14291-1-jacob@gitlab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210125170921.14291-1-jacob@gitlab.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 25, 2021 at 06:09:21PM +0100, Jacob Vosmaer wrote:

> +test_expect_success 'hook works with partial clone' '
> +	clear_hook_results &&
> +	test_config_global uploadpack.packObjectsHook ./hook &&
> +	test_config_global uploadpack.allowFilter true &&

I was going to complain that:

 test_config -C dst.git uploadpack.packObjectsHook ./hook &&
 test_config -C dst.git uploadpack.allowFilter true &&

would be more clear, since it tells us which repo we care about
impacting. But the rest of the script doesn't do that, and indeed it
can't, because we don't allow packObjectsHook to be set in per-repo
config for security reasons. :)

(We could do it per-repo for allowFilter, but I think it is just as well
to keep the two calls consistent).

> +	git clone --bare --no-local --filter=blob:none . dst.git &&
> +	git -C dst.git rev-list --objects --missing=print HEAD >objects &&
> +	grep "^?" objects

Previously that clone would fail, so the bug-fix is demonstrated by it
succeeding. But the other two commands are added to make sure that we
actually did apply the filter correctly. Even better. Thanks for being
thorough.

-Peff

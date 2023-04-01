Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 227ADC6FD1D
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 08:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbjDAIWj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 04:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjDAIWi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 04:22:38 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6AECA05
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 01:22:36 -0700 (PDT)
Received: (qmail 15727 invoked by uid 109); 1 Apr 2023 08:22:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 01 Apr 2023 08:22:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3150 invoked by uid 111); 1 Apr 2023 08:22:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 01 Apr 2023 04:22:34 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 1 Apr 2023 04:22:33 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, vdye@github.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH] fetch: download bundles once, even with --all
Message-ID: <20230401082233.GA3503828@coredump.intra.peff.net>
References: <pull.1508.git.1680278344173.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1508.git.1680278344173.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 31, 2023 at 03:59:04PM +0000, Derrick Stolee via GitGitGadget wrote:

> diff --git a/bundle-uri.c b/bundle-uri.c
> index 177c1810402..56390651b92 100644
> --- a/bundle-uri.c
> +++ b/bundle-uri.c
> @@ -792,6 +792,15 @@ int fetch_bundle_uri(struct repository *r, const char *uri,
>  
>  	init_bundle_list(&list);
>  
> +	/*
> +	 * Do not fetch a NULL or empty bundle URI. An empty bundle URI
> +	 * could signal that a configured bundle URI has been disabled.
> +	 */
> +	if (!uri || !*uri) {
> +		result = 0;
> +		goto cleanup;
> +	}

Coverity flagged this "!uri"; it can never be true since we
unconditionally xstrdup(uri) at the top of the function, and we'd
segfault in that case.

I think the existing code that assumes a non-NULL uri is reasonable.
Even before the xstrdup() we'd have segfaulted when it was handed to
fetch_bundle_uri_internal().

It's not a huge deal, in the sense that you're just being overly
defensive, but the comment and conditional here are a little misleading.

-Peff

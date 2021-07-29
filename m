Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2996AC4338F
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 15:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1042E60F22
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 15:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbhG2P3E (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jul 2021 11:29:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:60884 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229657AbhG2P3D (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jul 2021 11:29:03 -0400
Received: (qmail 8763 invoked by uid 109); 29 Jul 2021 15:28:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 29 Jul 2021 15:28:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20584 invoked by uid 111); 29 Jul 2021 15:28:59 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 29 Jul 2021 11:28:59 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 29 Jul 2021 11:28:58 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 4/7] merge-ort: switch our strmaps over to using
 memory pools
Message-ID: <YQLJOsvATnTBd9pB@coredump.intra.peff.net>
References: <pull.990.git.1627044897.gitgitgadget@gmail.com>
 <pull.990.v2.git.1627531121.gitgitgadget@gmail.com>
 <dd8839b284330892a3bbcafbc03d71489fc9b01f.1627531121.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dd8839b284330892a3bbcafbc03d71489fc9b01f.1627531121.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 29, 2021 at 03:58:38AM +0000, Elijah Newren via GitGitGadget wrote:

> diff --git a/merge-ort.c b/merge-ort.c
> index 2bca4b71f2a..5fd2a4ccd35 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -539,15 +539,19 @@ static void clear_or_reinit_internal_opts(struct merge_options_internal *opti,
>  	void (*strset_func)(struct strset *) =
>  		reinitialize ? strset_partial_clear : strset_clear;
>  
> -	/*
> -	 * We marked opti->paths with strdup_strings = 0, so that we
> -	 * wouldn't have to make another copy of the fullpath created by
> -	 * make_traverse_path from setup_path_info().  But, now that we've
> -	 * used it and have no other references to these strings, it is time
> -	 * to deallocate them.
> -	 */
> -	free_strmap_strings(&opti->paths);
> -	strmap_func(&opti->paths, 1);
> +	if (opti->pool)
> +		strmap_func(&opti->paths, 0);

This isn't new in your patch here, but I did scratch my head a bit over
what "strmap_func" is. It's a bit less confusing if you read the whole
function (as opposed to a diff), since then you're more likely to see
the definition. But something like "strmap_clear_func()" would have been
a lot less confusing.

Arguably, the existence of these function indirections is perhaps a sign
that the strmap API should provide a version of the clear functions that
takes "partial / not-partial" as a parameter.

(Again, not really part of this patch series, but I hadn't looked at
some of the earlier optimization steps).

-Peff

Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE00EC2D0A3
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 20:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92594206CB
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 20:31:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732019AbgKDUbS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 15:31:18 -0500
Received: from cloud.peff.net ([104.130.231.41]:47874 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731930AbgKDUbS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 15:31:18 -0500
Received: (qmail 11320 invoked by uid 109); 4 Nov 2020 20:31:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 04 Nov 2020 20:31:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14836 invoked by uid 111); 4 Nov 2020 20:31:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 04 Nov 2020 15:31:17 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 4 Nov 2020 15:31:17 -0500
From:   Jeff King <peff@peff.net>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3 10/13] strmap: add a strset sub-type
Message-ID: <20201104203117.GC3629238@coredump.intra.peff.net>
References: <pull.835.v2.git.git.1602549650.gitgitgadget@gmail.com>
 <pull.835.v3.git.git.1604343313.gitgitgadget@gmail.com>
 <0f57735f5e30ad61a2e6fdb118067afbcea69660.1604343314.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0f57735f5e30ad61a2e6fdb118067afbcea69660.1604343314.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 02, 2020 at 06:55:10PM +0000, Elijah Newren via GitGitGadget wrote:

> +int strset_check_and_add(struct strset *set, const char *str)
> +{
> +	if (strset_contains(set, str))
> +		return 1;
> +	strset_add(set, str);
> +	return 0;
> +}

With this implementation, I wonder if it is worth having such a
specialized function. The value of an atomic check-and-add operation is
that it can reuse the effort to hash the string for both operations (it
could also reuse any open-table probing effort, but for a chained hash
like our implementation, it's cheap to add a new entry to the front of
the list).

I doubt it matters all that much for the use case in shortlog. Perhaps
we should just open-code it there for now, and we can revisit it if
another user comes up.

> --- a/strmap.h
> +++ b/strmap.h
> @@ -28,6 +28,10 @@ int cmp_strmap_entry(const void *hashmap_cmp_fn_data,
>  			.map.strdup_strings = 1,                          \
>  			.default_value = 0,                               \
>  		    }
> +#define STRSET_INIT { \
> +			.map.map = HASHMAP_INIT(cmp_strmap_entry, NULL),  \
> +			.map.strdup_strings = 1,                          \
> +		    }

As with strint, this could be:

  #define STRSET_INIT { .map = STRMAP_INIT }

-Peff

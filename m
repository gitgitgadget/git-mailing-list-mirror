Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F25C2D0A3
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 20:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEE8B2080D
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 20:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730505AbgKDUsK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 15:48:10 -0500
Received: from cloud.peff.net ([104.130.231.41]:48066 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728815AbgKDUsK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 15:48:10 -0500
Received: (qmail 11501 invoked by uid 109); 4 Nov 2020 20:48:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 04 Nov 2020 20:48:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15561 invoked by uid 111); 4 Nov 2020 20:48:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 04 Nov 2020 15:48:09 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 4 Nov 2020 15:48:09 -0500
From:   Jeff King <peff@peff.net>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3 13/13] Use new HASHMAP_INIT macro to simplify hashmap
 initialization
Message-ID: <20201104204809.GE3629238@coredump.intra.peff.net>
References: <pull.835.v2.git.git.1602549650.gitgitgadget@gmail.com>
 <pull.835.v3.git.git.1604343313.gitgitgadget@gmail.com>
 <5f41fc63e5355121cf882f63e1b38b8df1948df8.1604343314.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5f41fc63e5355121cf882f63e1b38b8df1948df8.1604343314.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 02, 2020 at 06:55:13PM +0000, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
> 
> Now that hashamp has lazy initialization and a HASHMAP_INIT macro,
> hashmaps allocated on the stack can be initialized without a call to
> hashmap_init() and in some cases makes the code a bit shorter.  Convert
> some callsites over to take advantage of this.

These all look obviously correct. I suspect there are more, but there's
no need for us to be thorough at this point.

> --- a/range-diff.c
> +++ b/range-diff.c
> @@ -232,11 +232,9 @@ static int patch_util_cmp(const void *dummy, const struct patch_util *a,
>  
>  static void find_exact_matches(struct string_list *a, struct string_list *b)
>  {
> -	struct hashmap map;
> +	struct hashmap map = HASHMAP_INIT((hashmap_cmp_fn)patch_util_cmp, NULL);

Not related to your patch, but we should in general try to define these
comparison functions with the correct signature, rather than cast them.

I think I've already inflated your series enough, so let's leave it for
now, but just a mental note that it might be useful to circle back and
fix these en masse (I know we cleaned up several a while back, so I'm
actually surprised to see one still here).

-Peff

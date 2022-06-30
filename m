Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1588FC433EF
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 18:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236181AbiF3SR4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 14:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbiF3SRx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 14:17:53 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8CD40E76
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 11:17:53 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6354213485A;
        Thu, 30 Jun 2022 14:17:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pjWyyl4aAxUjQ8kolbXXkKrk2NUkJVEsouY5hb
        Ey0s0=; b=RksfTWvhLaGhzygavn8g+c3rLYvz0EzP+/ERRX51tMOYuIF3d/pluw
        /U6Omel2LfE69RIL5e+NwLQI1FIzPi9/WbUcPNeudrEdt2jVuZL3V7dZ6XqwoB7w
        ocE2z3NSymiZBd9gT6gmADhbmIN3zMxYejkNkpbiqLhXzOqhvDpvQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5A6E1134858;
        Thu, 30 Jun 2022 14:17:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C0516134857;
        Thu, 30 Jun 2022 14:17:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 2/3] xdiff: introduce XDL_CALLOC_ARRAY()
References: <pull.1272.git.1656516334.gitgitgadget@gmail.com>
        <8bead9856be7b39d3d03f688f53d678832d60109.1656516334.git.gitgitgadget@gmail.com>
Date:   Thu, 30 Jun 2022 11:17:50 -0700
In-Reply-To: <8bead9856be7b39d3d03f688f53d678832d60109.1656516334.git.gitgitgadget@gmail.com>
        (Phillip Wood via GitGitGadget's message of "Wed, 29 Jun 2022 15:25:33
        +0000")
Message-ID: <xmqqy1xednht.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F441A7F4-F8A0-11EC-AFD2-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/xdiff/xmacros.h b/xdiff/xmacros.h
> index 9fd3c5da91a..23db8e785d7 100644
> --- a/xdiff/xmacros.h
> +++ b/xdiff/xmacros.h
> @@ -55,4 +55,10 @@ do { \
>  		? xdl_malloc((nr) * sizeof(*(p)))	\
>  		: NULL)
>  
> +/* Allocate an array of nr zeroed out elements, returns NULL on failure */
> +#define XDL_CALLOC_ARRAY(p, nr)				\
> +	(XDL_ALLOC_ARRAY((p), (nr))			\
> +		? memset((p), 0, (nr) * sizeof(*(p)))	\
> +		: NULL)
> +

This implementation is somewhat dissapointing.  Allocating and then
clearing is conceptually different from allocating an already
cleared buffer.

Wouldn't it make more sense to build on top of xcalloc() or its
counterpart in xdl world by introducing xdl_calloc()?  For that,
this step would probably need to become two patches.  The first
patch introduces xdl_calloc(), which uses xcalloc() in our codebase,
and turn the existing "alloc and clear" code to use it, and the
second patch would wrap the use of xdl_calloc() in the size-safe
macro XDL_CALLOC_ARRAY().


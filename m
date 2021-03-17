Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C6FC433DB
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 19:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE62D64F53
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 19:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbhCQTTe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 15:19:34 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54800 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233128AbhCQTTJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 15:19:09 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4B8C6134FE5;
        Wed, 17 Mar 2021 15:19:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wAIQGbuX811hy0UWrayB4wA0XEY=; b=wL5HER
        fyQ/hNWixOcbB0ylxrdi7/cJ608K+gGbSVNxZ6PIgAP6az89w1SQJ8VUas9XcQpR
        lzNd3mrUij3TCIOukrP301VvG+addEUl/Ijviz3hCbcQvtw/5F0EHKo9X5W3Fp24
        86VPwxsyoMlJIYumkE8kxK6U3MX+4vRjDLJxI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=O7s9wAokMoTptIhJUWMSB58SXL3nuBBU
        m24lcyKXzumz/d2i13ETtKABgD2c8Bf8/WxIqLwT8AqdlJ8aM3RTjNpRxTM78dGW
        dM/hrkUCAbz6LDHLoEYgwNcA43rlWBL5OB0G0umfe0SEFvBzDqFCb4szuDMqkdOR
        J7BwEjXtJz0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 44427134FE4;
        Wed, 17 Mar 2021 15:19:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 88707134FE3;
        Wed, 17 Mar 2021 15:19:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/2] fsmonitor: fix memory corruption in some corner cases
References: <pull.891.git.1615995049.gitgitgadget@gmail.com>
        <e194809e547eb5bc8e8d1ad09d874ebfde0efe4f.1615995049.git.gitgitgadget@gmail.com>
Date:   Wed, 17 Mar 2021 12:19:04 -0700
In-Reply-To: <e194809e547eb5bc8e8d1ad09d874ebfde0efe4f.1615995049.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Wed, 17 Mar 2021
        15:30:48 +0000")
Message-ID: <xmqqwnu5twpj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A470EA22-8755-11EB-A399-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -1544,8 +1544,8 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
>  	o->merge_size = len;
>  	mark_all_ce_unused(o->src_index);
>  
> -	if (o->src_index->fsmonitor_last_update)
> -		o->result.fsmonitor_last_update = o->src_index->fsmonitor_last_update;
> +	o->result.fsmonitor_last_update =
> +		xstrdup_or_null(o->src_index->fsmonitor_last_update);

And this won't happen twice, so there is no need to free what is in
the o->result side before assignment.  And 2/2 frees it so we do not
leak at the end either.

Will queue; thanks.

>  
>  	/*
>  	 * Sparse checkout loop #1: set NEW_SKIP_WORKTREE on existing entries

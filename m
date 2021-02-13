Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F250C433DB
	for <git@archiver.kernel.org>; Sat, 13 Feb 2021 01:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCC0064D9D
	for <git@archiver.kernel.org>; Sat, 13 Feb 2021 01:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbhBMBF2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Feb 2021 20:05:28 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64931 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbhBMBF1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Feb 2021 20:05:27 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CC583AEC92;
        Fri, 12 Feb 2021 20:04:44 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zFrZ7hsbsjPA7wDaDFos2A1txQs=; b=e5fTOk
        JVCPUPA84R28vDq05wThwQRDFPPa9k6EGrBttNGAOvgaSV5DCgWMcv1rBSe6Cmv9
        YHUsV/dBxH78VyJ6cyBPiPQMniV8sayPTW3mR3ahNg3JCAZMkaW0MdtVvNL0+yTF
        6Y+tCPj0MkU7HCugtfQWQ7pc3nUXCM71ACjaw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vDVwoekupDyc65GLMnUGTuTO0Asf4fAn
        U1fj6VreSgtfnHSfB/AyOpd9fxYkvoGYG/heUA9ol/8+NnN0k2+GV0xl6AQjZan2
        BIaKcK3fZKm+mDi89jNYzUTV93DqK7ZMsXv9LwgeDR0D6wW9pVwYHOcqYssDxNwf
        sI64iG6mjmU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C3B19AEC91;
        Fri, 12 Feb 2021 20:04:44 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 50A6CAEC8F;
        Fri, 12 Feb 2021 20:04:44 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Karsten Blees <blees@dcon.de>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 2/2] diffcore-rename: filter rename_src list when
 possible
References: <pull.842.git.1612331345.gitgitgadget@gmail.com>
        <pull.842.v2.git.1612382628.gitgitgadget@gmail.com>
        <7ae9460d3dba84122c2674b46e4339b9d42bdedd.1612382628.git.gitgitgadget@gmail.com>
Date:   Fri, 12 Feb 2021 17:04:43 -0800
In-Reply-To: <7ae9460d3dba84122c2674b46e4339b9d42bdedd.1612382628.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Wed, 03 Feb 2021
        20:03:47 +0000")
Message-ID: <xmqqczx4vkus.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 757C7B64-6D97-11EB-BC09-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +		return; /* culling incompatbile with break detection */

incompatible.

>  	/*
> -	 * Calculate how many renames are left (but all the source
> -	 * files still remain as options for rename/copies!)
> +	 * Calculate how many renames are left
>  	 */

This no longer needs to be a multi-line comment, does it?


Return-Path: <SRS0=ek70=5Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A1BC2D0F4
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 19:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B595B20771
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 19:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cG2PWQnH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729237AbgDHTL3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Apr 2020 15:11:29 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55485 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728255AbgDHTL3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Apr 2020 15:11:29 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 615E5B80F7;
        Wed,  8 Apr 2020 15:11:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=M7Q6xQCzHlT/Pf5zRjayTJdcFUs=; b=cG2PWQ
        nHmtP3Xlq1aYaT8Mkat0/tUNt+AyPteh0Pt2YIujEAJmvAZAg7WQdPX1KPKH6Q0j
        fLOranXsOGleLlQ0sZj7YwI4rh8r1PSVKwf5JUGK9AAm1vl28+Hv9DTEWzeUO/DL
        eTL3Z3Do8Y8ujTs4H/abRAiGq8UoNGI4qMjAE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TAp8AOOg81LE270ojZ3AAl85AKP/lzgT
        g1xL47iKMXKow1uh/dQZbGlbBsl+wK/yhwGYXQjcytPO1oeDPB02y147W70xfg82
        sc48c8CzL4viSAs/WoCemrLg6PDgKRqidUG4jnJ0oR/838WW0XxiBJz4Yw2ezIju
        3gseUHDmoVg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 595ADB80F6;
        Wed,  8 Apr 2020 15:11:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A578DB80F5;
        Wed,  8 Apr 2020 15:11:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] bloom: ignore renames when computing changed paths
References: <pull.601.git.1586363907252.gitgitgadget@gmail.com>
Date:   Wed, 08 Apr 2020 12:11:23 -0700
In-Reply-To: <pull.601.git.1586363907252.gitgitgadget@gmail.com> (Derrick
        Stolee via GitGitGadget's message of "Wed, 08 Apr 2020 16:38:27
        +0000")
Message-ID: <xmqqftddpzc4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BD732B44-79CC-11EA-A1B9-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> The changed-path Bloom filters record an entry in the filter for
> every path that was changed. This includes every add and delete,
> regardless of whther a rename was detected. Detecting renames
> causes significant performance issues, but also will trigger
> downloading missing blobs in partial clone.
>
> The simple fix is to disable rename detection when computing a
> changed-path Bloom filter.

Makes perfect sense to me.

> diff --git a/bloom.c b/bloom.c
> index c5b461d1cfe..dd9bab9bbd6 100644
> --- a/bloom.c
> +++ b/bloom.c
> @@ -189,6 +189,7 @@ struct bloom_filter *get_bloom_filter(struct repository *r,
>  
>  	repo_diff_setup(r, &diffopt);
>  	diffopt.flags.recursive = 1;
> +	diffopt.detect_rename = 0;
>  	diffopt.max_changes = max_changes;
>  	diff_setup_done(&diffopt);
>  
>
> base-commit: d5b873c832d832e44523d1d2a9d29afe2b84c84f

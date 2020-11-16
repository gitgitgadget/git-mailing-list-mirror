Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CEFC4742C
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 20:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66D1E217A0
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 20:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BndEVuwF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730520AbgKPUO3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Nov 2020 15:14:29 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64992 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgKPUO2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Nov 2020 15:14:28 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E4D7FF6088;
        Mon, 16 Nov 2020 15:14:26 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KdvLGu5CkjzppL7e1fnXPGXGuKw=; b=BndEVu
        wFT883mcni6CkHZWw6UcDMsXiORxKvLivW3eHFRh8KI5pjEdfu19B2YGFai6+kox
        zvpNXx07A8BygVkDIrh2OycYhKfJkQShzNh38LZIyiXX2PLKroSHTfZp5MZQRGYY
        zpzEVUORTMbqtDIEr5ryzTlmfOhQR8jUdy3cY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hp3koGSNHxPPb9V4GbFkn142mxLr21q1
        OhQ9BZBpLmFPxRgRcsZT1xtbQdd/40UPsKnfeGun8Ggt5VQKY8srGsnYCjydshzr
        Z5Dwebfo+Adc7NqrXrFdxUcvb+zSZD5xCCRBoC3PMeFgzK6UIkRiLDj/Hngf7J4Y
        +ms4m7Jw5iE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DD6EDF6086;
        Mon, 16 Nov 2020 15:14:26 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 26197F6084;
        Mon, 16 Nov 2020 15:14:24 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org, stolee@gmail.com, newren@gmail.com
Subject: Re: [PATCH] rm: honor sparse checkout patterns
References: <9f2135f90ffea7f4ccb226f506bf554deab324cc.1605205427.git.matheus.bernardino@usp.br>
Date:   Mon, 16 Nov 2020 12:14:22 -0800
In-Reply-To: <9f2135f90ffea7f4ccb226f506bf554deab324cc.1605205427.git.matheus.bernardino@usp.br>
        (Matheus Tavares's message of "Thu, 12 Nov 2020 18:01:09 -0300")
Message-ID: <xmqqeekt83fl.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 51E58CB6-2848-11EB-8959-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares <matheus.bernardino@usp.br> writes:

> Make git-rm honor the 'sparse.restrictCmds' setting, by restricting its
> operation to the paths that match both the command line pathspecs and
> the repository's sparsity patterns.

> This better matches the expectations
> of users with sparse-checkout definitions, while still allowing them
> to optionally enable the old behavior with 'sparse.restrictCmds=false'
> or the global '--no-restrict-to-sparse-paths' option.

Hmph.  Is "rm" the only oddball that ignores the sparse setting?

>  to the paths specified by the sparsity patterns, or to the intersection of
>  those paths and any (like `*.c`) that the user might also specify on the
>  command line. When false, the affected commands will work on full trees,
> -ignoring the sparsity patterns. For now, only git-grep honors this setting.
> +ignoring the sparsity patterns. For now, only git-grep and git-rm honor this
> +setting.

I am not sure if this is a good direction to go---can we make an
inventory of all commands that affect working tree files and see
which ones need the same treatment before going forward with just
"grep" and "rm"?  Documenting the decision on the ones that will not
get the same treatment may also be a good idea.  What I am aiming
for is to prevent users from having to know in which versions of Git
they can rely on the sparsity patterns with what commands, and doing
things piecemeal like these two topics would be a road to confusion.

Thanks.

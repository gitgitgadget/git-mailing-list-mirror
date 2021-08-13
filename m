Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 874BFC432BE
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 21:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64A6660F51
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 21:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234971AbhHMVp3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 17:45:29 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64045 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234853AbhHMVp2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 17:45:28 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F07E1E6FD9;
        Fri, 13 Aug 2021 17:44:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2+8VfxKWIaDfjjj+Ur7Tsu75amBlhyZjIBFQFx
        YIiUo=; b=EZP5G5goZT2mov83ltAR7QMKPTo0faslxkkEBz+V3q8X5Z5L9WwbaF
        xdhZcVwoUIqm0fvBNiXT4gNTItkiDTnKmdxZZ4er2P1DlT9rFv3sifBWvjDHBxZV
        BpVfpkEzROP4BBCA/ObO1MRI88+0hCAm8oSH/NrVklgO8Wk9MVJtE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E1E35E6FD8;
        Fri, 13 Aug 2021 17:44:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 505C2E6FD7;
        Fri, 13 Aug 2021 17:44:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, matheus.bernardino@usp.br,
        emilyshaffer@google.com, ramsay@ramsayjones.plus.com,
        steadmon@google.com
Subject: Re: [PATCH v2 5/8] grep: allocate subrepos on heap
References: <cover.1628618950.git.jonathantanmy@google.com>
        <cover.1628888668.git.jonathantanmy@google.com>
        <3f2481522404bcf66d83d02bd63b6bf682cee0ef.1628888668.git.jonathantanmy@google.com>
Date:   Fri, 13 Aug 2021 14:44:58 -0700
In-Reply-To: <3f2481522404bcf66d83d02bd63b6bf682cee0ef.1628888668.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Fri, 13 Aug 2021 14:05:20 -0700")
Message-ID: <xmqqh7ftuihx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B50CF6F6-FC7F-11EB-8DA6-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> +static void free_repos(void)
> +{
> +	int i;
> +
> +	for (i = 0; i < repos_to_free_nr; i++) {
> +		repo_clear(repos_to_free[i]);
> +		free(repos_to_free[i]);
> +	}
> +	free(repos_to_free);
> +	repos_to_free_nr = 0;
> +	repos_to_free_alloc = 0;

The clearing of nr/alloc is new in this round.

It does not matter if we won't using anything that allocates
repositories and accumulates them in repos_to_free after we call
free_repos() once, but then clearing the nr/alloc would not matter,
either, so it may be more consistent to FREE_AND_NULL(repos_to_free)
here, not just free(), to prepare for another call to ALLOC_GROW()
on the <repos_to_free, repos_to_free_nr, repos_to_free_alloc> tuple,
which eventually will call into REALLOC_ARRAY() on the pointer, I
would think.



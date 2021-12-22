Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D59C433EF
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 05:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242632AbhLVF6r (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 00:58:47 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53461 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242630AbhLVF6r (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 00:58:47 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 59B46FC8E7;
        Wed, 22 Dec 2021 00:58:46 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RAq7Vmm2tbY8fFadKfj5SEnswAGNsk6kJVhvD8
        lQ0QM=; b=GSxYAVVDHuwYu5wD7B5WuFyxZFBEr6qJXo3UWLj65pjdie2b1TUCVJ
        2a1Q6maKTPkw+wNccojQojBVFNPBm/5SnZXs62jqDemw0vqBBUvEHueDi5mcDL/T
        +5Hyxiaa0aNrkoH3A1mlQxV80AkJc6IWdKbGMiB6IIXtldgibF62I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 50804FC8E6;
        Wed, 22 Dec 2021 00:58:46 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B2765FC8E5;
        Wed, 22 Dec 2021 00:58:45 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 2/2] refs: set the repo in debug_ref_store.base
References: <pull.1163.git.git.1640090038.gitgitgadget@gmail.com>
        <75e5392032dbdbdedf8a2b76a7098e4dc1133d82.1640090038.git.gitgitgadget@gmail.com>
Date:   Tue, 21 Dec 2021 21:58:44 -0800
In-Reply-To: <75e5392032dbdbdedf8a2b76a7098e4dc1133d82.1640090038.git.gitgitgadget@gmail.com>
        (Han-Wen Nienhuys via GitGitGadget's message of "Tue, 21 Dec 2021
        12:33:58 +0000")
Message-ID: <xmqqtuf1kwob.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3975CE22-62EC-11EC-967D-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> This is for consistency with the files backend.

Hmmmm.  Could you explain what it exactly means?

I can see that files_ref_store structure has the .repo member and
files_ref_store_create() uses it to remember which repository the
ref store is for, but that is an implementation detail that is not
exposed outside the files backend, isn't it?

To put it differently, what is broken with the current code that
leaves the .repo member in refs->base uninitialized?  We are
presumably helping the caller that wants to know the repository the
ref store belongs to via this pointer with this change---what is
that caller?

> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  refs/debug.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/refs/debug.c b/refs/debug.c
> index cf6ad36fbb0..136cfd7c700 100644
> --- a/refs/debug.c
> +++ b/refs/debug.c
> @@ -26,6 +26,7 @@ struct ref_store *maybe_debug_wrap_ref_store(const char *gitdir, struct ref_stor
>  	be_copy->name = store->be->name;
>  	trace_printf_key(&trace_refs, "ref_store for %s\n", gitdir);
>  	res->refs = store;
> +	res->base.repo = store->repo;
>  	base_ref_store_init((struct ref_store *)res, be_copy);
>  	return (struct ref_store *)res;
>  }

Thanks.

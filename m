Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DDDFC4338F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 20:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 594F560F6E
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 20:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbhGZTaJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 15:30:09 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64461 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbhGZTaE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 15:30:04 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DA870DDBE3;
        Mon, 26 Jul 2021 16:10:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GAdH4EX+BGnCBQpOi6RmNFdaLOyQqs8MEHpOsH
        EyGno=; b=BIyBma5avCUkSeIdOHA8tDXTdwpfNhzKPoMgH/60k9za5A5QyfYnG6
        +6EpTeq+c8b8v6poRM05xhnMM09BfWWY/GAkUKwFev6pF8hB7pTcu1lxUH7sjg7U
        7bQC8TcCXcB8bUa+2NyJwFGyNkQqn7m8PZykWSrYIPNrNsj4l8Nq4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D11EDDDBE1;
        Mon, 26 Jul 2021 16:10:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4C291DDBE0;
        Mon, 26 Jul 2021 16:10:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     andrzej@ahunt.org
Cc:     git@vger.kernel.org, phillip.wood123@gmail.com, newren@gmail.com
Subject: Re: [PATCH v2 07/12] read-cache: call diff_setup_done to avoid leak
References: <20210620151204.19260-1-andrzej@ahunt.org>
        <20210725130830.5145-1-andrzej@ahunt.org>
        <20210725130830.5145-8-andrzej@ahunt.org>
Date:   Mon, 26 Jul 2021 13:10:31 -0700
In-Reply-To: <20210725130830.5145-8-andrzej@ahunt.org> (andrzej@ahunt.org's
        message of "Sun, 25 Jul 2021 15:08:25 +0200")
Message-ID: <xmqqa6m8j0p4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 87CEC254-EE4D-11EB-B35E-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

andrzej@ahunt.org writes:

> From: Andrzej Hunt <ajrhunt@google.com>
>
> repo_diff_setup() calls through to diff.c's static prep_parse_options(),
> which in  turn allocates a new array into diff_opts.parseopts.
> diff_setup_done() is responsible for freeing that array, and has the
> benefit of verifying diff_opts too - hence we add a call to
> diff_setup_done() to avoid leaking parseopts.

Right.  Thanks.

>
> Output from the leak as found while running t0090 with LSAN:
>
> Direct leak of 7120 byte(s) in 1 object(s) allocated from:
>     #0 0x49a82d in malloc ../projects/compiler-rt/lib/asan/asan_malloc_linux.cpp:145:3
>     #1 0xa8bf89 in do_xmalloc wrapper.c:41:8
>     #2 0x7a7bae in prep_parse_options diff.c:5636:2
>     #3 0x7a7bae in repo_diff_setup diff.c:4611:2
>     #4 0x93716c in repo_index_has_changes read-cache.c:2518:3
>     #5 0x872233 in unclean merge-ort-wrappers.c:12:14
>     #6 0x872233 in merge_ort_recursive merge-ort-wrappers.c:53:6
>     #7 0x5d5b11 in try_merge_strategy builtin/merge.c:752:12
>     #8 0x5d0b6b in cmd_merge builtin/merge.c:1666:9
>     #9 0x4ce83e in run_builtin git.c:475:11
>     #10 0x4ccafe in handle_builtin git.c:729:3
>     #11 0x4cb01c in run_argv git.c:818:4
>     #12 0x4cb01c in cmd_main git.c:949:19
>     #13 0x6bdc2d in main common-main.c:52:11
>     #14 0x7f551eb51349 in __libc_start_main (/lib64/libc.so.6+0x24349)
>
> SUMMARY: AddressSanitizer: 7120 byte(s) leaked in 1 allocation(s)
>
> Signed-off-by: Andrzej Hunt <andrzej@ahunt.org>
> ---
>  read-cache.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/read-cache.c b/read-cache.c
> index 46ccd66f34..83d1817ad0 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -2505,6 +2505,7 @@ int repo_index_has_changes(struct repository *repo,
>  		opt.flags.exit_with_status = 1;
>  		if (!sb)
>  			opt.flags.quick = 1;
> +		diff_setup_done(&opt);
>  		do_diff_cache(&cmp, &opt);
>  		diffcore_std(&opt);
>  		for (i = 0; sb && i < diff_queued_diff.nr; i++) {

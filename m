Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83EA4C4338F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 20:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65A2460F6E
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 20:04:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbhGZTYC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 15:24:02 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56863 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbhGZTYB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 15:24:01 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7E541D0DD7;
        Mon, 26 Jul 2021 16:04:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zv2F0yI3JDs+w8HnTRE5Pu9DjlYOG2C8KHhGKP
        noA0E=; b=k+Hx4H3jDLpNM3boSObVcGkRJ31sqz+3LpOVTlbz1bsCbJeEcGrsrs
        TmLDF8Sgt3QnvbaD1OEkSwK06G4VeUwXE/VSjgYwo9F7bopb0M+P8D9j/mqNuoEw
        7mauTZn8VTIZzmymz0cmGiPdNtlishLaCRE7G5TWhoQcFUWa1Ap5g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 77292D0DD6;
        Mon, 26 Jul 2021 16:04:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 09ADFD0DD4;
        Mon, 26 Jul 2021 16:04:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     andrzej@ahunt.org
Cc:     git@vger.kernel.org, phillip.wood123@gmail.com, newren@gmail.com
Subject: Re: [PATCH v2 06/12] ref-filter: also free head for ATOM_HEAD to
 avoid leak
References: <20210620151204.19260-1-andrzej@ahunt.org>
        <20210725130830.5145-1-andrzej@ahunt.org>
        <20210725130830.5145-7-andrzej@ahunt.org>
Date:   Mon, 26 Jul 2021 13:04:28 -0700
In-Reply-To: <20210725130830.5145-7-andrzej@ahunt.org> (andrzej@ahunt.org's
        message of "Sun, 25 Jul 2021 15:08:24 +0200")
Message-ID: <xmqqeebkj0z7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AF4778E0-EE4C-11EB-BB5B-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

andrzej@ahunt.org writes:

> From: Andrzej Hunt <ajrhunt@google.com>
>
> u.head is populated using resolve_refdup(), which returns a newly
> allocated string - hence we also need to free() it.

Correct.  The solution makes me wonder if this approach scales as we
add more and more members to u.* union that need deallocating, but
for now, this is perfectly adequate.

Thanks.

>
> Found while running t0041 with LSAN:
>
> Direct leak of 16 byte(s) in 1 object(s) allocated from:
>     #0 0x486804 in strdup ../projects/compiler-rt/lib/asan/asan_interceptors.cpp:452:3
>     #1 0xa8be98 in xstrdup wrapper.c:29:14
>     #2 0x9481db in head_atom_parser ref-filter.c:549:17
>     #3 0x9408c7 in parse_ref_filter_atom ref-filter.c:703:30
>     #4 0x9400e3 in verify_ref_format ref-filter.c:974:8
>     #5 0x4f9e8b in print_ref_list builtin/branch.c:439:6
>     #6 0x4f9e8b in cmd_branch builtin/branch.c:757:3
>     #7 0x4ce83e in run_builtin git.c:475:11
>     #8 0x4ccafe in handle_builtin git.c:729:3
>     #9 0x4cb01c in run_argv git.c:818:4
>     #10 0x4cb01c in cmd_main git.c:949:19
>     #11 0x6bdc2d in main common-main.c:52:11
>     #12 0x7f96edf86349 in __libc_start_main (/lib64/libc.so.6+0x24349)
>
> SUMMARY: AddressSanitizer: 16 byte(s) leaked in 1 allocation(s).
>
> Signed-off-by: Andrzej Hunt <andrzej@ahunt.org>
> ---
>  ref-filter.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/ref-filter.c b/ref-filter.c
> index f45d3a1b26..0cfef7b719 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -2226,8 +2226,12 @@ void ref_array_clear(struct ref_array *array)
>  	FREE_AND_NULL(array->items);
>  	array->nr = array->alloc = 0;
>  
> -	for (i = 0; i < used_atom_cnt; i++)
> -		free((char *)used_atom[i].name);
> +	for (i = 0; i < used_atom_cnt; i++) {
> +		struct used_atom *atom = &used_atom[i];
> +		if (atom->atom_type == ATOM_HEAD)
> +			free(atom->u.head);
> +		free((char *)atom->name);
> +	}
>  	FREE_AND_NULL(used_atom);
>  	used_atom_cnt = 0;

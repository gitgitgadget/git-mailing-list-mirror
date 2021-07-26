Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF66C4338F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 20:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54D8460F6E
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 20:15:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbhGZTe4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 15:34:56 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55545 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbhGZTez (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 15:34:55 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9EF6B154306;
        Mon, 26 Jul 2021 16:15:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=A16EB+aEcuxjqX5HkPhFTk4h5uOBjYasBDnv1J
        h7WnI=; b=dGwdUe3RwmqJHwVvjRBODlFZA9ujEF/1kKUKiyBuBp+ZQbnzphXl8M
        PJFRVZlAQUHKW9+zwedTXhtekalnc+ZiE8QovmpHuOlVR1T7iRFYxccrclmLZM9P
        a+Fa9icJY9j+Q4sfEbKc2w42wE7eOJ+wC959SYRrGoGpvawvPNIIM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 97559154305;
        Mon, 26 Jul 2021 16:15:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DA941154304;
        Mon, 26 Jul 2021 16:15:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     andrzej@ahunt.org
Cc:     git@vger.kernel.org, phillip.wood123@gmail.com, newren@gmail.com
Subject: Re: [PATCH v2 08/12] convert: release strbuf to avoid leak
References: <20210620151204.19260-1-andrzej@ahunt.org>
        <20210725130830.5145-1-andrzej@ahunt.org>
        <20210725130830.5145-9-andrzej@ahunt.org>
Date:   Mon, 26 Jul 2021 13:15:19 -0700
In-Reply-To: <20210725130830.5145-9-andrzej@ahunt.org> (andrzej@ahunt.org's
        message of "Sun, 25 Jul 2021 15:08:26 +0200")
Message-ID: <xmqq5ywwj0h4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 33D0818C-EE4E-11EB-BEC1-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

andrzej@ahunt.org writes:

> From: Andrzej Hunt <ajrhunt@google.com>
>
> apply_multi_file_filter and async_query_available_blobs both query
> subprocess output using subprocess_read_status, which writes data into
> the identically named filter_status strbuf. We add a strbuf_release to
> avoid leaking their contents.
>
> Leak output seen when running t0021 with LSAN:

Obviously correct.  Thanks.

>
> Direct leak of 24 byte(s) in 1 object(s) allocated from:
>     #0 0x49ab49 in realloc ../projects/compiler-rt/lib/asan/asan_malloc_linux.cpp:164:3
>     #1 0xa8c2b5 in xrealloc wrapper.c:126:8
>     #2 0x9ff99d in strbuf_grow strbuf.c:98:2
>     #3 0x9ff99d in strbuf_addbuf strbuf.c:304:2
>     #4 0xa101d6 in subprocess_read_status sub-process.c:45:5
>     #5 0x77793c in apply_multi_file_filter convert.c:886:8
>     #6 0x77793c in apply_filter convert.c:1042:10
>     #7 0x77a0b5 in convert_to_git_filter_fd convert.c:1492:7
>     #8 0x8b48cd in index_stream_convert_blob object-file.c:2156:2
>     #9 0x8b48cd in index_fd object-file.c:2248:9
>     #10 0x597411 in hash_fd builtin/hash-object.c:43:9
>     #11 0x596be1 in hash_object builtin/hash-object.c:59:2
>     #12 0x596be1 in cmd_hash_object builtin/hash-object.c:153:3
>     #13 0x4ce83e in run_builtin git.c:475:11
>     #14 0x4ccafe in handle_builtin git.c:729:3
>     #15 0x4cb01c in run_argv git.c:818:4
>     #16 0x4cb01c in cmd_main git.c:949:19
>     #17 0x6bdc2d in main common-main.c:52:11
>     #18 0x7f42acf79349 in __libc_start_main (/lib64/libc.so.6+0x24349)
>
> SUMMARY: AddressSanitizer: 24 byte(s) leaked in 1 allocation(s).
>
> Direct leak of 120 byte(s) in 5 object(s) allocated from:
>     #0 0x49ab49 in realloc ../projects/compiler-rt/lib/asan/asan_malloc_linux.cpp:164:3
>     #1 0xa8c295 in xrealloc wrapper.c:126:8
>     #2 0x9ff97d in strbuf_grow strbuf.c:98:2
>     #3 0x9ff97d in strbuf_addbuf strbuf.c:304:2
>     #4 0xa101b6 in subprocess_read_status sub-process.c:45:5
>     #5 0x775c73 in async_query_available_blobs convert.c:960:8
>     #6 0x80029d in finish_delayed_checkout entry.c:183:9
>     #7 0xa65d1e in check_updates unpack-trees.c:493:10
>     #8 0xa5f469 in unpack_trees unpack-trees.c:1747:8
>     #9 0x525971 in checkout builtin/clone.c:815:6
>     #10 0x525971 in cmd_clone builtin/clone.c:1409:8
>     #11 0x4ce83e in run_builtin git.c:475:11
>     #12 0x4ccafe in handle_builtin git.c:729:3
>     #13 0x4cb01c in run_argv git.c:818:4
>     #14 0x4cb01c in cmd_main git.c:949:19
>     #15 0x6bdc2d in main common-main.c:52:11
>     #16 0x7fa253fce349 in __libc_start_main (/lib64/libc.so.6+0x24349)
>
> SUMMARY: AddressSanitizer: 120 byte(s) leaked in 5 allocation(s).
>
> Signed-off-by: Andrzej Hunt <andrzej@ahunt.org>
> ---
>  convert.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/convert.c b/convert.c
> index fd9c84b025..0d6fb3410a 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -916,6 +916,7 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
>  	else
>  		strbuf_swap(dst, &nbuf);
>  	strbuf_release(&nbuf);
> +	strbuf_release(&filter_status);
>  	return !err;
>  }
>  
> @@ -966,6 +967,7 @@ int async_query_available_blobs(const char *cmd, struct string_list *available_p
>  
>  	if (err)
>  		handle_filter_error(&filter_status, entry, 0);
> +	strbuf_release(&filter_status);
>  	return !err;
>  }

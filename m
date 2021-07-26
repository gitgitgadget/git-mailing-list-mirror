Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818E2C4338F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 22:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65C0E60F6C
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 22:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233805AbhGZWHO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 18:07:14 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62643 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233780AbhGZWHO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 18:07:14 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D3981D1EF1;
        Mon, 26 Jul 2021 18:47:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZafYXtpDQnw7jV1RAAuJdL3ErS+Wi+5TikFXl3
        5NdTQ=; b=EfeOyiji4DOhnS8WALwi0f5CoEP/K994ylEPCKkmF+Yo1UVZe5NZxI
        cuXyJ0xTNQlEXcR2KvgWjd8Lg513uiPXbNUSQm45jqFJJbt5CBUFIoBGlJn2TB0a
        AnVxEUxy1uz0Uq8Kv5+atnkjUIuYaBQR+GvLMT6E6SKluS8oiV5P8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C8FCBD1EF0;
        Mon, 26 Jul 2021 18:47:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 37544D1EEF;
        Mon, 26 Jul 2021 18:47:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Turner <dturner@twosigma.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/3] diff --submodule=diff: Don't print failure message
 twice
References: <20210726183358.3255233-1-dturner@twosigma.com>
        <20210726183358.3255233-3-dturner@twosigma.com>
Date:   Mon, 26 Jul 2021 15:47:40 -0700
In-Reply-To: <20210726183358.3255233-3-dturner@twosigma.com> (David Turner's
        message of "Mon, 26 Jul 2021 14:33:58 -0400")
Message-ID: <xmqqzgu8g0ab.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7BE0F866-EE63-11EB-8BF3-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Turner <dturner@twosigma.com> writes:

> When we fail to start a diff command inside a submodule, immediately
> exit the routine rather than trying to finish the command and printing
> a second message.
>
> Signed-off-by: David Turner <dturner@twosigma.com>
> ---
>  submodule.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/submodule.c b/submodule.c
> index 9031527a16..0acfad3d4c 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -713,8 +713,10 @@ void show_submodule_inline_diff(struct diff_options *o, const char *path,
>  		strvec_push(&cp.args, oid_to_hex(new_oid));
>  
>  	prepare_submodule_repo_env(&cp.env_array);
> -	if (start_command(&cp))
> +	if (start_command(&cp)) {
>  		diff_emit_submodule_error(o, "(diff failed)\n");
> +		goto done;
> +	}
>  
>  	while (strbuf_getwholeline_fd(&sb, cp.out, '\n') != EOF)
>  		diff_emit_submodule_pipethrough(o, sb.buf, sb.len);

Again, makes sense.  Thanks.

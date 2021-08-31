Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C7CC432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 06:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C45161027
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 06:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbhHaGUW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 02:20:22 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51127 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbhHaGUV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 02:20:21 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5F32ED82A5;
        Tue, 31 Aug 2021 02:19:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uVpeP1v4PWMXqY7Q+O934VXVRkk2dO0GX3GyVe
        kSs7o=; b=LM1MwdXwMDLFQRFNg1whLbfw+4PpZKKqubt4NHWcprUF51EmVjC7hF
        bNlyTQsFid5QErzccwIsiZg+6RnGW0vxIzEnw6+DdTytSr+8NkPHyUQpYBACagZH
        W2297JWIjJavwU1kgPh6MDKum+2chLktggjTktILWII4FlD30dco8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5545AD82A4;
        Tue, 31 Aug 2021 02:19:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D22CCD82A3;
        Tue, 31 Aug 2021 02:19:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Turner <dturner@twosigma.com>
Cc:     git@vger.kernel.org, novalis@novalis.org
Subject: Re: [PATCH v2 3/3] diff --submodule=diff: Don't print failure
 message twice
References: <20210802170004.4103535-1-dturner@twosigma.com>
        <20210802170004.4103535-3-dturner@twosigma.com>
Date:   Mon, 30 Aug 2021 23:19:25 -0700
In-Reply-To: <20210802170004.4103535-3-dturner@twosigma.com> (David Turner's
        message of "Mon, 2 Aug 2021 13:00:04 -0400")
Message-ID: <xmqqo89exhjm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 63F59DDE-0A23-11EC-9442-D601C7D8090B-77302942!pb-smtp1.pobox.com
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
> index d13d103975..2e98e840af 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -720,8 +720,10 @@ void show_submodule_inline_diff(struct diff_options *o, const char *path,
>  		strvec_push(&cp.env_array, GIT_WORK_TREE_ENVIRONMENT "=.");
>  	}
>  
> -	if (start_command(&cp))
> +	if (start_command(&cp)) {
>  		diff_emit_submodule_error(o, "(diff failed)\n");
> +		goto done;
> +	}
>  
>  	while (strbuf_getwholeline_fd(&sb, cp.out, '\n') != EOF)
>  		diff_emit_submodule_pipethrough(o, sb.buf, sb.len);

Makes sense.

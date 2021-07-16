Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFD7C12002
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 20:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7F9260241
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 20:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234024AbhGPUXL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 16:23:11 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59679 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233227AbhGPUXJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 16:23:09 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 09988E05AD;
        Fri, 16 Jul 2021 16:20:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=h+w0um06tztBdLiaZIQDZELl5m8ptEK0cZ4wS9
        agQoQ=; b=fPPAqkwtxCLcFYSrrMNcxOxWjNjpETvFI5U907gwWEBAK8yJiJ17gG
        vCK2agsSwq5CeCOsrDx3pbA6RlKG+EKKeqz+AGYUZqffGj6nQF63vYTCoEXERLuK
        YdcgFFKaz45l6B9VKCRhfZsLidvF2uNJZIzyWXvN9Eppyz63qWLKI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 00A66E05AC;
        Fri, 16 Jul 2021 16:20:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 70F0BE05AB;
        Fri, 16 Jul 2021 16:20:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Luca Weiss via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
Subject: Re: [PATCH 2/2] merge: make sure to terminate message with newline
References: <pull.1048.git.git.1626421416.gitgitgadget@gmail.com>
        <31371c25743e1001b4fac89e80e7206ff477ac8a.1626421416.git.gitgitgadget@gmail.com>
Date:   Fri, 16 Jul 2021 13:20:09 -0700
In-Reply-To: <31371c25743e1001b4fac89e80e7206ff477ac8a.1626421416.git.gitgitgadget@gmail.com>
        (Luca Weiss via GitGitGadget's message of "Fri, 16 Jul 2021 07:43:36
        +0000")
Message-ID: <xmqqeebyqadi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3847C302-E673-11EB-BA76-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Luca Weiss via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Luca Weiss <luca@z3ntu.xyz>

Please explain what you are trying to fix here.  The title hints
that this change is to deal with an message that ends in an
incomplete line, but where does that incomplete line come?

I find it somewhat important to know that details especially because
in this patch ...

> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>  builtin/merge.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/builtin/merge.c b/builtin/merge.c
> index a8a843b1f54..646bb49367f 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -867,6 +867,7 @@ static void prepare_to_commit(struct commit_list *remoteheads)
>  	}
>  	if (signoff)
>  		append_signoff(&msg, ignore_non_trailer(msg.buf, msg.len), 0);
> +	strbuf_complete_line(&msg);

... the placement of this call looks dubious.

Before the context of this hunk, we 

 - started with an empty msg at the beginning of this function;

 - added merge_msg to msg, where merge_msg came from options like -F
   and -m;

 - optionally added to msg comments to be shown in the editor; and

 - optionally called append_signoff() to add s-o-b.

At which step do we make msg end with an incomplete line and under
what condition?

If it is after processing -F/-m and if we did not call the editor,
for example, we "append" the sign-off after that incomplete line and
your new call to strbuf_complete_line() would be too late if that is
the case, wouldn't it?  I do not know if that is, since your commit
log message lacks meaningful details, and that is exactly why people
want you to explain what breakage you observed and what your fix is.

Thanks.

>  	write_merge_heads(remoteheads);
>  	write_file_buf(git_path_merge_msg(the_repository), msg.buf, msg.len);
>  	if (run_commit_hook(0 < option_edit, get_index_file(), "prepare-commit-msg",

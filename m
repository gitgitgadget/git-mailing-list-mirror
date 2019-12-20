Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 483EEC43603
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 19:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C61C20866
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 19:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GqNwc02i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbfLTT3i (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 14:29:38 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58331 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727459AbfLTT3h (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 14:29:37 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 924F13983E;
        Fri, 20 Dec 2019 14:29:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xojbpXzn9nLT+WuirdaWAAS4PeM=; b=GqNwc0
        2iKkAdsH5vtPtzgfTq1P9augLu1BwxB5C+L4Z7lcK3odbgBZ1kBSXCM6yZUcd44i
        gSEpdWUdvVSjnMKlHFyRaXjKvJxZtd6mlTtYC1LGQZcfWnfmzW5O+VsxbK4MUWD7
        hM3zBTNOOiu2wgh2ZyViNvm+UQJn1ufdaLVN0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BC68Owqz4R6O8M9XuCxUi+mjIkegK6dF
        +6OCArZaBf2HzICmjDUBhkMIG44NSK9jf1Ph8A46riukFLUXTsvLxVcv3Vf/kDAI
        dWII/L9OWwOcO9VHnwTG59L2dtuXmYYwHhfnWgkLynHdoj2qHyzAnV8Ks0qMh/cb
        Hn4B0s17700=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 89D763983D;
        Fri, 20 Dec 2019 14:29:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EBE633983C;
        Fri, 20 Dec 2019 14:29:34 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        plroskin@gmail.com, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/2] rebase: fix saving of --signoff state for am-based rebases
References: <pull.680.git.git.1576868036.gitgitgadget@gmail.com>
        <c64984e146e509a743c9adc7b61bf7b274103cf9.1576868036.git.gitgitgadget@gmail.com>
Date:   Fri, 20 Dec 2019 11:29:32 -0800
In-Reply-To: <c64984e146e509a743c9adc7b61bf7b274103cf9.1576868036.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Fri, 20 Dec 2019
        18:53:56 +0000")
Message-ID: <xmqqsgle94o3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0DDFC566-235F-11EA-B0BD-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> This was an error introduced in the conversion from shell in commit
> 21853626eac5 ("built-in rebase: call `git am` directly", 2019-01-18),
> which was noticed by a random browsing of the code.

Wow, thanks.

This probably indicates that nobody uses "rebase --signoff" in real
life (i.e. where correct signed-off-by line matters).  But still the
bug is worth fixing.

>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  builtin/rebase.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index ddf33bc9d4..e354ec84bb 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -706,7 +706,7 @@ static int rebase_write_basic_state(struct rebase_options *opts)
>  		write_file(state_dir_path("gpg_sign_opt", opts), "%s",
>  			   opts->gpg_sign_opt);
>  	if (opts->signoff)
> -		write_file(state_dir_path("strategy", opts), "--signoff");
> +		write_file(state_dir_path("signoff", opts), "--signoff");
>  
>  	return 0;
>  }

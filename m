Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45050C433F5
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 19:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239361AbhKVTEH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 14:04:07 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55844 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235518AbhKVTEG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 14:04:06 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7E23DF448A;
        Mon, 22 Nov 2021 14:00:59 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dOCe+qR0WGMHtFORrgISL3hYzKBKCGtJ6RW8rN
        IDFMQ=; b=NVhmhzpxjHoZzk44KmmOIjpIbRV7uhoDziqOPslvt4ybbLT7a4K9Uq
        nC87E5tOdGNFaC3GMLS8hLhMvpdqrHX7maKdNqNY6wnXaANxegiSvsq+LUtI9c9m
        m+OMvxxPQDgewrBrrrFfLgwICqLVilywDWSgSqBvH4/Hft/x+fpVE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6ED60F4489;
        Mon, 22 Nov 2021 14:00:59 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CAEF8F4487;
        Mon, 22 Nov 2021 14:00:58 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH] refs: drop force_create argument of create_reflog API
References: <pull.1144.git.git.1637590749342.gitgitgadget@gmail.com>
Date:   Mon, 22 Nov 2021 11:00:57 -0800
In-Reply-To: <pull.1144.git.git.1637590749342.gitgitgadget@gmail.com> (Han-Wen
        Nienhuys via GitGitGadget's message of "Mon, 22 Nov 2021 14:19:08
        +0000")
Message-ID: <xmqq4k84f21i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 87604460-4BC6-11EC-B8CF-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> There is only one caller, builtin/checkout.c, and it hardcodes
> force_create=1.
>
> This argument was introduced in abd0cd3a301 (refs: new public ref function:
> safe_create_reflog, 2015-07-21), which promised to immediately use it in a
> follow-on commit, but that never happened.
>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---

Thanks.  It's an obvious simplification.  I wish all our changes were
like this ;-)

> diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
> index b314b81a45b..98f827edfb7 100644
> --- a/t/helper/test-ref-store.c
> +++ b/t/helper/test-ref-store.c
> @@ -181,11 +181,10 @@ static int cmd_reflog_exists(struct ref_store *refs, const char **argv)
>  static int cmd_create_reflog(struct ref_store *refs, const char **argv)
>  {
>  	const char *refname = notnull(*argv++, "refname");
> -	int force_create = arg_flags(*argv++, "force-create");
>  	struct strbuf err = STRBUF_INIT;
>  	int ret;
>  
> -	ret = refs_create_reflog(refs, refname, force_create, &err);
> +	ret = refs_create_reflog(refs, refname, &err);
>  	if (err.len)
>  		puts(err.buf);
>  	return ret;
> diff --git a/t/t1405-main-ref-store.sh b/t/t1405-main-ref-store.sh
> index 49718b7ea7f..c89cef2d26b 100755
> --- a/t/t1405-main-ref-store.sh
> +++ b/t/t1405-main-ref-store.sh
> @@ -108,7 +108,7 @@ test_expect_success 'delete_reflog(HEAD)' '
>  '
>  
>  test_expect_success 'create-reflog(HEAD)' '
> -	$RUN create-reflog HEAD 1 &&
> +	$RUN create-reflog HEAD &&
>  	git reflog exists HEAD
>  '
>  
> diff --git a/t/t1406-submodule-ref-store.sh b/t/t1406-submodule-ref-store.sh
> index 0a87058971e..f1e57a9c051 100755
> --- a/t/t1406-submodule-ref-store.sh
> +++ b/t/t1406-submodule-ref-store.sh
> @@ -92,7 +92,7 @@ test_expect_success 'delete_reflog() not allowed' '
>  '
>  
>  test_expect_success 'create-reflog() not allowed' '
> -	test_must_fail $RUN create-reflog HEAD 1
> +	test_must_fail $RUN create-reflog HEAD
>  '
>  
>  test_done
>
> base-commit: cd3e606211bb1cf8bc57f7d76bab98cc17a150bc

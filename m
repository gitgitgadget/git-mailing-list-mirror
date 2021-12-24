Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 430AEC433EF
	for <git@archiver.kernel.org>; Fri, 24 Dec 2021 04:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351295AbhLXEqb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Dec 2021 23:46:31 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51971 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240362AbhLXEqb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Dec 2021 23:46:31 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 38A51F21C1;
        Thu, 23 Dec 2021 23:46:30 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=pKZr2DaANqvDrfSQuUNS+VEOw+/C34i4qwLYD1z3ibk=; b=qrho
        ZvbRt7xNbz7mMH6DQc4PI1MTxfauihkj4qbLW2GFOkyfN1GW2b7S21zEZjBsCEcd
        hyvFP1kBJYlRW7z46rsm+WaYknw7yKP3lwgriO7/CjybCE6GbTPY3JZWFyorQDkR
        Ekl1IHHw1u0tjJV3+EdSX7BRX+AQzbECDgQQxUA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1FA82F21BE;
        Thu, 23 Dec 2021 23:46:30 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 720F9F21BD;
        Thu, 23 Dec 2021 23:46:29 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 3/3] reftable: support preset file mode for writing
References: <pull.1164.git.git.1640287790.gitgitgadget@gmail.com>
        <c01b1c335a33e5f44289c520a1634d071d882223.1640287790.git.gitgitgadget@gmail.com>
Date:   Thu, 23 Dec 2021 20:46:28 -0800
Message-ID: <xmqqsfui4nkr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 75ACB822-6474-11EC-81DA-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> Create files with mode 0666, so umask works as intended. Provides an override,
> which is useful to support shared repos (test t1301-shared-repo.sh).

> +	/* Default mode for creating files. If unset, use 0666 (+umask) */
> +	unsigned int default_permissions;
> +

Presumably this is primed by a call to get_shared_repository(),
possibly followed by calc_shared_perm(), but having it in the
interface is a good idea, as it allows us to avoid making these
git-core specific calls from reftable/ library proper?

> diff --git a/reftable/stack.c b/reftable/stack.c
> index df5021ebf08..56bf5f2d84a 100644
> --- a/reftable/stack.c
> +++ b/reftable/stack.c
> @@ -469,7 +469,7 @@ static int reftable_stack_init_addition(struct reftable_addition *add,
>  	strbuf_addstr(&add->lock_file_name, ".lock");
>  
>  	add->lock_file_fd = open(add->lock_file_name.buf,
> -				 O_EXCL | O_CREAT | O_WRONLY, 0644);
> +				 O_EXCL | O_CREAT | O_WRONLY, 0666);

This change makes sense.

>  	if (add->lock_file_fd < 0) {
>  		if (errno == EEXIST) {
>  			err = REFTABLE_LOCK_ERROR;
> @@ -478,6 +478,13 @@ static int reftable_stack_init_addition(struct reftable_addition *add,
>  		}
>  		goto done;
>  	}
> +	if (st->config.default_permissions) {
> +		if (chmod(add->lock_file_name.buf, st->config.default_permissions) < 0) {
> +			err = REFTABLE_IO_ERROR;
> +			goto done;

This part does not exactly make sense, though.

If this were a library code meant to link with ONLY with Git, I
would have recommended to make a adjust_shared_perm() call from
here, without having to have "unsigned int default_permissions" to
reftable_write_options structure.

I wonder if it is a better design to make the new member in the
structure a pointer to a generic and opaque helper function that is
called from here, i.e.

	if (st->config.adjust_perm &&
            st->config.adjust_perm(add->lock_file_name.buf) < 0) {
		err = REFTABLE_IO_ERROR;
		goto done;
	}

so that when linking with and calling from git, we can just stuff
the pointer to adjust_shared_perm function to the member?

> +		}
> +	}
> +

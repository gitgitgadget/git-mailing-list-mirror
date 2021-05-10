Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57BC7C433B4
	for <git@archiver.kernel.org>; Mon, 10 May 2021 07:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F64E61433
	for <git@archiver.kernel.org>; Mon, 10 May 2021 07:27:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhEJH2q (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 03:28:46 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64852 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbhEJH2p (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 03:28:45 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 37C5112F29E;
        Mon, 10 May 2021 03:27:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PUSxtmqnC1NaZOVwsrOkAjRLMhmZ8quHBT5NcE
        JuSHw=; b=Zb9kxoAVN0C7rMFrqPDTdJjtojoUXEaiUnKzhfsW+kgVSMeGdcqMe6
        M8J2WsdO+topUeBVlzZTOf8aKUbvRUy3QuSZcVLqqARawDv2NHm3VK3wHdEIJ7Fv
        HZ3Pfd5pcFxj1vLNVH78jrHuYdqt+v0Pzt1xtE0ysJ8u7Wpz7f6XI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2FB6612F29D;
        Mon, 10 May 2021 03:27:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6718B12F29C;
        Mon, 10 May 2021 03:27:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v3] [GSOC] ref-filter: fix read invalid union member bug
References: <pull.949.v2.git.1620318676776.gitgitgadget@gmail.com>
        <pull.949.v3.git.1620487572222.gitgitgadget@gmail.com>
Date:   Mon, 10 May 2021 16:27:36 +0900
In-Reply-To: <pull.949.v3.git.1620487572222.gitgitgadget@gmail.com> (ZheNing
        Hu via GitGitGadget's message of "Sat, 08 May 2021 15:26:11 +0000")
Message-ID: <xmqqcztzqc9j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 32A26160-B161-11EB-BA8D-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: ZheNing Hu <adlternative@gmail.com>
>
> used_atom.u is an union, and it has different members depending on
> what atom the auxiliary data the union part of the "struct
> used_atom" wants to record. At most only one of the members can be
> valid at any one time. Since the code checks u.remote_ref without
> even making sure if the atom is "push" or "push:" (which are only
> two cases that u.remote_ref.push becomes valid), but u.remote_ref
> shares the same storage for other members of the union, the check
> was reading from an invalid member, which was the bug.
>
> Modify the condition here to check whether the atom name
> equals to "push" or starts with "push:", to avoid reading the
> value of invalid member of the union.
>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> ---

Just a final sanity check.  Is this a recent breakage or was the
code introduced at cc72385f (for-each-ref: let upstream/push
optionally report the remote name, 2017-10-05) broken from the
beginning?

I am wondering if it is easy to add a test to cover the codepath
that is affected by this change.

Thanks.

> diff --git a/ref-filter.c b/ref-filter.c
> index a0adb4551d87..213d3773ada3 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -1730,7 +1730,7 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
>  			else
>  				v->s = xstrdup("");
>  			continue;
> -		} else if (atom->u.remote_ref.push) {
> +		} else if (!strcmp(atom->name, "push") || starts_with(atom->name, "push:")) {
>  			const char *branch_name;
>  			v->s = xstrdup("");
>  			if (!skip_prefix(ref->refname, "refs/heads/",
>
> base-commit: 311531c9de557d25ac087c1637818bd2aad6eb3a

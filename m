Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB60C4708F
	for <git@archiver.kernel.org>; Mon, 31 May 2021 06:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 481FE610C9
	for <git@archiver.kernel.org>; Mon, 31 May 2021 06:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhEaGgd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 02:36:33 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54408 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbhEaGgc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 02:36:32 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E085BB395C;
        Mon, 31 May 2021 02:34:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=hMWmYdCRa9qO0QS76AE9ibRTqKm3bdizLlD/kIrqiqg=; b=ZV+0
        R3LO8sMmuSy6xNaDwWwrsisPXO04HeEgBB4yeYOnADbrJQUYxPviQ0aSdHaNemYW
        tXwL4/y8ntrp3VBMJc4meu+5nYKW1zKFvat6QnHXsNgqXb/SPiDZ28paYuKZlnle
        gqP0FRg1KmKxTgBcV1hsH88gNkOpyNweDwDCyoY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D6E1FB395B;
        Mon, 31 May 2021 02:34:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6189CB3958;
        Mon, 31 May 2021 02:34:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 03/15] push: reorder switch cases
References: <20210529071115.1908310-1-felipe.contreras@gmail.com>
        <20210529074458.1916817-4-felipe.contreras@gmail.com>
Date:   Mon, 31 May 2021 15:34:51 +0900
Message-ID: <xmqqeednwgvo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4E369D36-C1DA-11EB-B6A7-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> We want all the cases that don't do anything with a branch first, and
> then the rest.
>
> Will help further patches.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  builtin/push.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/builtin/push.c b/builtin/push.c
> index f4e919450d..c19321bb9d 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -254,11 +254,19 @@ static void setup_default_push_refspecs(struct remote *remote)
>  	int triangular = is_workflow_triangular(remote);
>  
>  	switch (push_default) {
> -	default:
>  	case PUSH_DEFAULT_MATCHING:
>  		refspec_append(&rs, ":");
>  		return;
>  
> +	case PUSH_DEFAULT_NOTHING:
> +		die(_("You didn't specify any refspecs to push, and "
> +		    "push.default is \"nothing\"."));
> +		return;
> +	default:
> +	}
> +
> +	switch (push_default) {
> +	default:

This is not quite "reorder" but split into two.  It is not yet clear
how it helps, but hopefully we'll find out why splitting the switch
into two switches is a good idea soon in a later step, so the title
needs updating to sell that aspect of the change (unless it is a
pointless change made by mistake that the originally-single switch
got split into two, but that is unlikely the case ;-).

>  	case PUSH_DEFAULT_UNSPECIFIED:
>  	case PUSH_DEFAULT_SIMPLE:
>  		setup_push_simple(remote, branch, triangular);
> @@ -271,11 +279,6 @@ static void setup_default_push_refspecs(struct remote *remote)
>  	case PUSH_DEFAULT_CURRENT:
>  		setup_push_current(remote, branch);
>  		return;
> -
> -	case PUSH_DEFAULT_NOTHING:
> -		die(_("You didn't specify any refspecs to push, and "
> -		    "push.default is \"nothing\"."));
> -		return;
>  	}
>  }

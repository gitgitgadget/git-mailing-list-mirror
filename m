Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54617C47082
	for <git@archiver.kernel.org>; Mon, 31 May 2021 05:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A4AB610C8
	for <git@archiver.kernel.org>; Mon, 31 May 2021 05:05:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbhEaFGh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 01:06:37 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60243 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbhEaFGh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 01:06:37 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BBD72D4829;
        Mon, 31 May 2021 01:04:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=CGIoCx+hN97gJ8/yPD0CufQSP837e+6ik1CWVldUdPA=; b=xrw1
        5TihR6KyDtx13dWsykabH57hlOVK7eo38pFHNBQ7gzaKVJU0m7IyF1w+tjCl3ddm
        SWMF4JVD8+dRdJ6wV0+lRVOEfOVbOo3bQp0IHfxOjS/nBSMfDqNMd29qQbFfIehA
        aqB1Nh00UX1EOI9/eTd9cwj/pJYOzSAHdJWXINg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A061AD4828;
        Mon, 31 May 2021 01:04:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0C7FFD4827;
        Mon, 31 May 2021 01:04:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Mathias Kunter <mathiaskunter@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Ramkumar Ramachandra <r@artagnon.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Matthieu Moy <git@matthieu-moy.fr>
Subject: Re: [PATCH v2 3/6] push: reorganize setup_push_simple()
References: <20210529071115.1908310-1-felipe.contreras@gmail.com>
        <20210529071115.1908310-4-felipe.contreras@gmail.com>
Date:   Mon, 31 May 2021 14:04:55 +0900
Message-ID: <xmqq7djfxzm0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BE56A99C-C1CD-11EB-BB32-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Simply move the code around and remove dead code. In particular the
> 'trivial' conditional is a no-op since that part of the code is the
> !trivial leg of the conditional beforehand.
>
> No functional changes.
>
> Suggestions-by: Elijah Newren <newren@gmail.com>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  builtin/push.c | 29 ++++++++++++-----------------
>  1 file changed, 12 insertions(+), 17 deletions(-)

Much cleaner.  Nice.

> diff --git a/builtin/push.c b/builtin/push.c
> index d173c39283..9c807ed707 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -225,13 +225,14 @@ static void setup_push_current(struct remote *remote, struct branch *branch)
>  
>  static void setup_push_simple(struct remote *remote, struct branch *branch, int triangular)
>  {
> +	const char *dst;
> +
> +	if (!branch)
> +		die(_(message_detached_head_die), remote->name);
> +
>  	if (triangular) {
> -		if (!branch)
> -			die(_(message_detached_head_die), remote->name);
> -		refspec_appendf(&rs, "%s:%s", branch->refname, branch->refname);
> +		dst = branch->refname;
>  	} else {
> -		if (!branch)
> -			die(_(message_detached_head_die), remote->name);
>  		if (!branch->merge_nr || !branch->merge || !branch->remote_name)
>  			die(_("The current branch %s has no upstream branch.\n"
>  			    "To push the current branch and set the remote as upstream, use\n"
> @@ -243,20 +244,14 @@ static void setup_push_simple(struct remote *remote, struct branch *branch, int
>  		if (branch->merge_nr != 1)
>  			die(_("The current branch %s has multiple upstream branches, "
>  			    "refusing to push."), branch->name);
> -		if (triangular)
> -			die(_("You are pushing to remote '%s', which is not the upstream of\n"
> -			      "your current branch '%s', without telling me what to push\n"
> -			      "to update which remote branch."),
> -			    remote->name, branch->name);
> -
> -		if (1) {
> -			/* Additional safety */
> -			if (strcmp(branch->refname, branch->merge[0]->src))
> -				die_push_simple(branch, remote);
> -		}
>  
> -		refspec_appendf(&rs, "%s:%s", branch->refname, branch->merge[0]->src);
> +		/* Additional safety */
> +		if (strcmp(branch->refname, branch->merge[0]->src))
> +			die_push_simple(branch, remote);
> +
> +		dst = branch->merge[0]->src;
>  	}
> +	refspec_appendf(&rs, "%s:%s", branch->refname, dst);
>  }
>  
>  static int is_workflow_triangular(struct remote *remote)

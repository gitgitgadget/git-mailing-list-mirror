Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E5BC4708F
	for <git@archiver.kernel.org>; Mon, 31 May 2021 05:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 951586024A
	for <git@archiver.kernel.org>; Mon, 31 May 2021 05:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhEaFGg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 01:06:36 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63393 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbhEaFGf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 01:06:35 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3BCB612C914;
        Mon, 31 May 2021 01:04:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=8gamDuL6ph0Urnf0pHEjewbuOivQCxxETnNMrfCu1kM=; b=CtTW
        hM5qhquGsp5n2877rbkNOcGkPMyP56Uz80F4CZ32YIJ4Ahq2WyeeOIAGJsJhEpCL
        xC3tccebQ4UuuIIB8dTjI2MWxw6TQzna2ihW0kpuX8igTAMi2GUBl0mit3HVah2o
        g94PhUEQu+Pb/W54D+hgI+kjCiZ3YXp9i1uxVpw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 33E1E12C913;
        Mon, 31 May 2021 01:04:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7989412C912;
        Mon, 31 May 2021 01:04:53 -0400 (EDT)
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
Subject: Re: [PATCH v2 2/6] push: move code to setup_push_simple()
References: <20210529071115.1908310-1-felipe.contreras@gmail.com>
        <20210529071115.1908310-3-felipe.contreras@gmail.com>
Date:   Mon, 31 May 2021 14:04:51 +0900
Message-ID: <xmqqczt7xzm4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BC37BBBA-C1CD-11EB-9DBB-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> In order to avoid doing unnecessary things and simplify it in further
> patches.
>
> The code is copied exactly as-is; no functional changes.

The title says "move" and I expected to see corresponding deletions,
but it seems that this (possibly temporarily) duplicates what these
two functions do, without removing them, which (possibly
temporarily) risks the two to drift apart.  So, the resulting code
from this step will do nothing wrong (it's just two function's
bodies inlined in duplicated form), but depending on how the code
evolves, it might turn out to be a good change or a bad change---we
cannot judge by this step alone.

From a quick scanning of the remainder of the series, it seems that
3/6 and 4/6 improve the copied code without changing the behaviour,
and at the end these two functions remain, so we have duplicated
logic for these two functions and improvements only live in one of
the copies (namely, in the setup_push_simple())?  Would that be a
problem, or it is too much work to do better, I wonder?

Let's keep reading.

> Reviewed-by: Elijah Newren <newren@gmail.com>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  builtin/push.c | 36 ++++++++++++++++++++++++++++++++----
>  1 file changed, 32 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/push.c b/builtin/push.c
> index 7045e4ef0c..d173c39283 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -225,10 +225,38 @@ static void setup_push_current(struct remote *remote, struct branch *branch)
>  
>  static void setup_push_simple(struct remote *remote, struct branch *branch, int triangular)
>  {
> -	if (triangular)
> -		setup_push_current(remote, branch);
> -	else
> -		setup_push_upstream(remote, branch, triangular, 1);
> +	if (triangular) {
> +		if (!branch)
> +			die(_(message_detached_head_die), remote->name);
> +		refspec_appendf(&rs, "%s:%s", branch->refname, branch->refname);
> +	} else {
> +		if (!branch)
> +			die(_(message_detached_head_die), remote->name);
> +		if (!branch->merge_nr || !branch->merge || !branch->remote_name)
> +			die(_("The current branch %s has no upstream branch.\n"
> +			    "To push the current branch and set the remote as upstream, use\n"
> +			    "\n"
> +			    "    git push --set-upstream %s %s\n"),
> +			    branch->name,
> +			    remote->name,
> +			    branch->name);
> +		if (branch->merge_nr != 1)
> +			die(_("The current branch %s has multiple upstream branches, "
> +			    "refusing to push."), branch->name);
> +		if (triangular)
> +			die(_("You are pushing to remote '%s', which is not the upstream of\n"
> +			      "your current branch '%s', without telling me what to push\n"
> +			      "to update which remote branch."),
> +			    remote->name, branch->name);
> +
> +		if (1) {
> +			/* Additional safety */
> +			if (strcmp(branch->refname, branch->merge[0]->src))
> +				die_push_simple(branch, remote);
> +		}
> +
> +		refspec_appendf(&rs, "%s:%s", branch->refname, branch->merge[0]->src);
> +	}
>  }
>  
>  static int is_workflow_triangular(struct remote *remote)

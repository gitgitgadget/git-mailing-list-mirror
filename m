Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54DBEC4708F
	for <git@archiver.kernel.org>; Mon, 31 May 2021 06:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31705611CA
	for <git@archiver.kernel.org>; Mon, 31 May 2021 06:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhEaGqi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 02:46:38 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64319 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbhEaGqg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 02:46:36 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 87EA9B3A33;
        Mon, 31 May 2021 02:44:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=ES+3PGgn6PCc8kvREUCP6Om/HGTJxRSEq5ebE/ef5Os=; b=jdcK
        RCNdWesDskjdyjjRVt/mVroPrXPPnFOsSGURe1CCbVWrTyg6PtHYBJW7bN4rrQcd
        llJ9KOaQ+wZz3dRHDIFOe0ku8mM5/a50ptNPX3Kce1iZtKj0cRKIxOdGzC2dHgEZ
        QlArv5rhsB6kCOMqmmulr5/SXnbGNEF25jXynVc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7E573B3A32;
        Mon, 31 May 2021 02:44:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0AFC1B3A31;
        Mon, 31 May 2021 02:44:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 08/15] push: get rid of all the setup_push_* functions
References: <20210529071115.1908310-1-felipe.contreras@gmail.com>
        <20210529074458.1916817-9-felipe.contreras@gmail.com>
Date:   Mon, 31 May 2021 15:44:55 +0900
Message-ID: <xmqq35u3wgew.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B6036CCC-C1DB-11EB-8DCE-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Their code is much simpler now and can move into the parent function.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  builtin/push.c | 38 +++++++++++---------------------------
>  1 file changed, 11 insertions(+), 27 deletions(-)

Finally, this resolves the risk of deliberately duplicated code of
diverging, which was made in the earlier series.  Without seeing
this step, it has been dubious if the earlier change was a good one,
but with this step, it is a very clear win.

Nicely done.

> diff --git a/builtin/push.c b/builtin/push.c
> index 21968abf6e..dbb4f78e61 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -202,30 +202,6 @@ static const char *get_upstream_ref(struct branch *branch, const char *remote_na
>  	return branch->merge[0]->src;
>  }
>  
> -static const char *setup_push_upstream(struct remote *remote, struct branch *branch,
> -	int triangular)
> -{
> -	if (triangular)
> -		die(_("You are pushing to remote '%s', which is not the upstream of\n"
> -		      "your current branch '%s', without telling me what to push\n"
> -		      "to update which remote branch."),
> -		    remote->name, branch->name);
> -	return get_upstream_ref(branch, remote->name);
> -}
> -
> -static const char *setup_push_current(struct remote *remote, struct branch *branch)
> -{
> -	return branch->refname;
> -}
> -
> -static const char *setup_push_simple(struct remote *remote, struct branch *branch, int triangular)
> -{
> -	if (!triangular)
> -		if (strcmp(branch->refname, get_upstream_ref(branch, remote->name)))
> -			die_push_simple(branch, remote);
> -	return branch->refname;
> -}
> -
>  static int is_workflow_triangular(struct remote *remote)
>  {
>  	struct remote *fetch_remote = remote_get(NULL);
> @@ -258,15 +234,23 @@ static void setup_default_push_refspecs(struct remote *remote)
>  	default:
>  	case PUSH_DEFAULT_UNSPECIFIED:
>  	case PUSH_DEFAULT_SIMPLE:
> -		dst = setup_push_simple(remote, branch, triangular);
> +		if (!triangular)
> +			if (strcmp(branch->refname, get_upstream_ref(branch, remote->name)))
> +				die_push_simple(branch, remote);
> +		dst = branch->refname;
>  		break;
>  
>  	case PUSH_DEFAULT_UPSTREAM:
> -		dst = setup_push_upstream(remote, branch, triangular);
> +		if (triangular)
> +			die(_("You are pushing to remote '%s', which is not the upstream of\n"
> +			      "your current branch '%s', without telling me what to push\n"
> +			      "to update which remote branch."),
> +			    remote->name, branch->name);
> +		dst = get_upstream_ref(branch, remote->name);
>  		break;
>  
>  	case PUSH_DEFAULT_CURRENT:
> -		dst = setup_push_current(remote, branch);
> +		dst = branch->refname;
>  		break;
>  	}

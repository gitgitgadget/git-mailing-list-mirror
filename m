Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C9EC433E0
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 17:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFD1920774
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 17:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="f+ZRvArs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgHLRej (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 13:34:39 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54928 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbgHLRej (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 13:34:39 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B5F756F056;
        Wed, 12 Aug 2020 13:34:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sjzjGKF18xVsecnkF6ztVt+p8LY=; b=f+ZRvA
        rsiT0BIE3nf1amfj+hDII0fvDl+lqKncaVGiyBq+e2Bjow+khHnpsMBqjQDysZ1V
        UHFK+G1jujrx2P+BgGnMiaJGNqI2cAx3C2hxZbILs8HxnYFiI900P3LZLYeKmZ8O
        30bdmLUaSP0Cbf2vwvcLQXiM1Fzq55pWwmyl8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MBMMrfuOB+BcZzOVbPUsRDt8yKix8aaB
        nHgmWxBu8tuPI/eF1W87NWPKRNrdHwco2bqvyLMYsqs023r1GGY9iTL7SUtWJuYl
        08x+jonS2D53Jewxul/VAzPdJYQq6O+CXGGUJ5OmMhuH7LYnn12yDf5iQ1/8+irC
        ryD8pCPksy0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ADE686F055;
        Wed, 12 Aug 2020 13:34:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2E9E46F054;
        Wed, 12 Aug 2020 13:34:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 3/7] fetch: avoid reading submodule config until needed
References: <20200724223844.2723397-1-jonathantanmy@google.com>
        <cover.1597184948.git.jonathantanmy@google.com>
        <8b4a522a13089ea144e922280f1c71a4ec3afa1f.1597184949.git.jonathantanmy@google.com>
Date:   Wed, 12 Aug 2020 10:34:35 -0700
In-Reply-To: <8b4a522a13089ea144e922280f1c71a4ec3afa1f.1597184949.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Tue, 11 Aug 2020 15:52:18 -0700")
Message-ID: <xmqqo8nf7opg.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 175EB9A4-DCC2-11EA-9DFE-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Teach "git fetch" to avoid reading the submodule config until necessary.
> This allows users to avoid the lazy-fetching of this potentially missing
> config file by specifying the --recurse-submodules=no command line
> option.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  builtin/fetch.c    | 10 ++++++++--
>  submodule-config.c |  5 +++--
>  2 files changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index a5498646bf..29db219c68 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1786,12 +1786,18 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>  		free(anon);
>  	}
>  
> -	fetch_config_from_gitmodules(&submodule_fetch_jobs_config,
> -				     &recurse_submodules);
>  	git_config(git_fetch_config, NULL);
>  
>  	argc = parse_options(argc, argv, prefix,
>  			     builtin_fetch_options, builtin_fetch_usage, 0);
> +	if (recurse_submodules != RECURSE_SUBMODULES_OFF) {
> +		int *sfjc = submodule_fetch_jobs_config == -1
> +			    ? &submodule_fetch_jobs_config : NULL;
> +		int *rs = recurse_submodules == RECURSE_SUBMODULES_DEFAULT
> +			  ? &recurse_submodules : NULL;
> +
> +		fetch_config_from_gitmodules(sfjc, rs);
> +	}

Hmph.  Instead of calling fetch_config_from... upfront, first
reading the fetch configuration and also command line options to see
if we are told to recurse, and only enter the new "if()" statement
does make sense---we'll avoid calling fetch_config_from... when we
are told not to recurse into submodules.

But it is not quite clear why the two parameters to the function can
now be conditional, and what benefit we gain by doing so, in the
body of the new "if()" statement.  Don't you need to explain to your
future peer developers what is going on here in the log message?

>  	if (deepen_relative) {
>  		if (deepen_relative < 0)
> diff --git a/submodule-config.c b/submodule-config.c
> index e175dfbc38..8d65273ed2 100644
> --- a/submodule-config.c
> +++ b/submodule-config.c
> @@ -776,10 +776,11 @@ struct fetch_config {
>  static int gitmodules_fetch_config(const char *var, const char *value, void *cb)
>  {
>  	struct fetch_config *config = cb;
> -	if (!strcmp(var, "submodule.fetchjobs")) {
> +	if (!strcmp(var, "submodule.fetchjobs") && config->max_children) {
>  		*(config->max_children) = parse_submodule_fetchjobs(var, value);
>  		return 0;

Because the new "if()" statement in cmd_fetch can pass NULL to
either of the two parameters to fetch_config_from_gitmodules(), it
now becomes possible for this function to get an instance of "struct
fetch_config" with .max_children field set to NULL.

The above justifies why assignment to *(config->max_children) must
be skipped when .max_children is NULL, but it does not justify the
new code, where .max_children==NULL does not stop the if/else if/
cascade.

	if (!strcmp(var, "submodule.fetchjobs")) {
		if (config->max_children)
			*(config->max_children) = parse...
		return 0;
	}

Why sfjc or rs is allowed to be NULL in certain cases, and why doing
so is a good idea, should be explained nevertheless, though.

> -	} else if (!strcmp(var, "fetch.recursesubmodules")) {
> +	} else if (!strcmp(var, "fetch.recursesubmodules") &&
> +		   config->recurse_submodules) {
>  		*(config->recurse_submodules) = parse_fetch_recurse_submodules_arg(var, value);
>  		return 0;

Likewise.

Thanks.


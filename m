Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 047D5C433F5
	for <git@archiver.kernel.org>; Mon, 28 Mar 2022 16:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242059AbiC1QZ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 12:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242014AbiC1QZ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 12:25:26 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E211FA51
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 09:23:44 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2E4DD10CCC7;
        Mon, 28 Mar 2022 12:23:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pLvLo62prljEUbMqSsT9FllAqbsoAqsgoc6/wn
        Vifu0=; b=UasqYzb4jsgS+XjIrKI9Z9gjJ++MtMBqI924ECz5WWjrjCv3zYlErg
        +6tKhIRvFLwOvtddr5cbJhOtal7dc1AvqV6vfWrwBdA3IanOOPwD0TgJnybB2bnI
        RHAs605Fi63aL3RMiuWbfnrv54fP3WJ1huM4kyS/2OAJX/Q1sB8G0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 23EFC10CCC6;
        Mon, 28 Mar 2022 12:23:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7E12E10CCC5;
        Mon, 28 Mar 2022 12:23:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Tao Klerks <tao@klerks.biz>
Subject: Re: [PATCH v3] tracking branches: add advice to ambiguous refspec
 error
References: <pull.1183.v2.git.1647940686394.gitgitgadget@gmail.com>
        <pull.1183.v3.git.1648450268285.gitgitgadget@gmail.com>
Date:   Mon, 28 Mar 2022 09:23:41 -0700
In-Reply-To: <pull.1183.v3.git.1648450268285.gitgitgadget@gmail.com> (Tao
        Klerks via GitGitGadget's message of "Mon, 28 Mar 2022 06:51:08
        +0000")
Message-ID: <xmqqwnge2ghe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6EF1C4F8-AEB3-11EC-99ED-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Tao Klerks <tao@klerks.biz>
>
> The error "not tracking: ambiguous information for ref" is raised
> when we are evaluating what tracking information to set on a branch,
> and find that the ref to be added as tracking branch is mapped
> under multiple remotes' fetch refspecs.

OK.

>  Documentation/config/advice.txt |  4 +++
>  advice.c                        |  1 +
>  advice.h                        |  1 +
>  branch.c                        | 44 +++++++++++++++++++++++++++++----
>  4 files changed, 45 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
> index c40eb09cb7e..90f7dbd03aa 100644
> --- a/Documentation/config/advice.txt
> +++ b/Documentation/config/advice.txt
> @@ -4,6 +4,10 @@ advice.*::
>  	can tell Git that you do not need help by setting these to 'false':
>  +
>  --
> +	ambiguousFetchRefspec::
> +		Advice shown when branch tracking relationship setup fails due
> +		to multiple remotes' refspecs mapping to the same remote
> +		tracking namespace in the repo.

	Advice shown when fetch refspec for multiple remotes map to
	the same remote-tracking branch namespace and causes branch
	tracking set-up to fail.

"remote-tracking" should be spelled as a single word.  There are
some existing mistakes in the code, but let's not make it worse.

> diff --git a/branch.c b/branch.c
> index 6b31df539a5..5c28d432103 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -18,9 +18,15 @@ struct tracking {
>  	int matches;
>  };
>  
> +struct find_tracked_branch_cb {
> +	struct tracking *tracking;
> +	struct strbuf remotes_advice;
> +};
> +
>  static int find_tracked_branch(struct remote *remote, void *priv)
>  {
> -	struct tracking *tracking = priv;
> +	struct find_tracked_branch_cb *ftb = priv;
> +	struct tracking *tracking = ftb->tracking;
>  
>  	if (!remote_find_tracking(remote, &tracking->spec)) {
>  		if (++tracking->matches == 1) {
>  			string_list_append(tracking->srcs, tracking->spec.src);
>  			tracking->remote = remote->name;
>  		} else {
>  			free(tracking->spec.src);
>  			string_list_clear(tracking->srcs, 0);
>  		}
> +		/*
> +		 * TRANSLATORS: This is a line listing a remote with duplicate
> +		 * refspecs, to be later included in advice message
> +		 * ambiguousFetchRefspec. For RTL languages you'll probably want
> +		 * to swap the "%s" and leading "  " space around.
> +		 */
> +		strbuf_addf(&ftb->remotes_advice, _("  %s\n"), remote->name);
>  		tracking->spec.src = NULL;
>  	}

This is wasteful.  remotes_advice does not have to be filled when we
are not going to give advice, i.e. there is only one matching remote
and no second or subsequent ones, which should be the majority case.
And we should not make majority of users who do not make a mistake
that needs the advice message pay the cost of giving advice to those
who screw up, if we can avoid it.

Instead, only when we are looking at the second one, we can stuff
tracking->remote (i.e. the first one) to remotes_advice, and then
append remote->name there.  Perhaps we can do it like so?

	struct strbuf *names = &ftb->remotes_advice;
	const char *namefmt = N_("  %s\n");

	switch (++tracking->matches) {
	case 1:
		string_list_append(tracking->srcs, tracking->spec.src);
		tracking->remote = remote->name;
		break;
	case 2:
		strbuf_addf(names, _(namefmt), tracking->remote);
		/* fall through */
	default:
		strbuf_addf(names, _(namefmt), remote->name);
                free(tracking->spec.src);
                string_list_clear(tracking->srcs, 0);
                break;
	}
	tracking->spec.src = NULL;

For a bonus point, remotes_advice member can be left empty without
paying the cost to strbuf_addf() when the advice configuration says
we are not going to show the message.

Thanks.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E1CC433F5
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 03:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbiADDqs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jan 2022 22:46:48 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56979 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbiADDqr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jan 2022 22:46:47 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7FEEF1726C7;
        Mon,  3 Jan 2022 22:46:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=YxqqTioMcT7xPtUGxqQtAX4KcULucOzU7AbM5JJBc2A=; b=mERC
        C0sdFZerC822D9SPNCftS03o6QjvFkSwfzIj0Ku8eNflJSxOyx0ENZPVeGHUObbV
        SDh6Y7HnSuI7dYGp7FkYC3DaB+92mwAxU9eOV/XxBnw2JPGe94VTep7vLj/s+wfU
        CwChsZ62ML+fI4Ra9jyBkqSAiXtA36mdCeumvAk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7794A1726C6;
        Mon,  3 Jan 2022 22:46:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D7C311726C3;
        Mon,  3 Jan 2022 22:46:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 1/1] push: make 'set-upstream' have dafault arguments
References: <20211209101550.19582-1-chakrabortyabhradeep79@gmail.com>
        <20220101143748.2582-1-chakrabortyabhradeep79@gmail.com>
        <20220101143748.2582-2-chakrabortyabhradeep79@gmail.com>
Date:   Mon, 03 Jan 2022 19:46:42 -0800
Message-ID: <xmqqy23wduxp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EF0A5946-6D10-11EC-9005-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com> writes:

> Teach "git push -u" not to require repository and refspec.  When
> the user do not give what repository to push to, or which
> branch(es) to push, behave as if the default remote repository
> and a refspec (depending on the "push.default" configuration)
> are given.

That means if the user says push.default==nothing, we should error
out "git push -u" as before, but that is not what the change to
setup_default_push_refspecs() function does, is it?

> -static void setup_default_push_refspecs(struct remote *remote)
> +static void setup_default_push_refspecs(struct remote *remote, int flags)
>  {
>  	struct branch *branch;
>  	const char *dst;
>  	int same_remote;
> +	int is_default_u = (flags & TRANSPORT_PUSH_SET_UPSTREAM);
>  
>  	switch (push_default) {
>  	case PUSH_DEFAULT_MATCHING:
> @@ -214,6 +215,8 @@ static void setup_default_push_refspecs(struct remote *remote)
>  		return;
>  
>  	case PUSH_DEFAULT_NOTHING:
> +		if (is_default_u)
> +			break;
>  		die(_("You didn't specify any refspecs to push, and "
>  		    "push.default is \"nothing\"."));
>  		return;
> @@ -234,11 +237,15 @@ static void setup_default_push_refspecs(struct remote *remote)
>  	case PUSH_DEFAULT_SIMPLE:
>  		if (!same_remote)
>  			break;
> +		if (is_default_u)
> +			break;
>  		if (strcmp(branch->refname, get_upstream_ref(branch, remote->name)))
>  			die_push_simple(branch, remote);
>  		break;
>  
>  	case PUSH_DEFAULT_UPSTREAM:
> +		if (is_default_u)
> +			break;
>  		if (!same_remote)
>  			die(_("You are pushing to remote '%s', which is not the upstream of\n"
>  			      "your current branch '%s', without telling me what to push\n"

So, I am not sure if many of the above changes are sensible.  The
first one certainly does not sound like sensible.

> diff --git a/t/t5523-push-upstream.sh b/t/t5523-push-upstream.sh
> index fdb4292056..c2d11c3f2a 100755
> --- a/t/t5523-push-upstream.sh
> +++ b/t/t5523-push-upstream.sh
> @@ -60,6 +60,86 @@ test_expect_success 'push -u :topic_2' '
>  	check_config topic_2 upstream refs/heads/other2
>  '
>  
> +default_u_setup() {

Style. (cf. Documentation/CodingGuildelines).

> +	git checkout main &&
> +	test_might_fail	git branch --unset-upstream &&
> +	test_config push.default $1 &&
> +	test_config remote.pushDefault upstream
> +}
> +
> +check_empty_config() {

Likewise.

> +	test_expect_code 1 git config "branch.$1.remote" &&
> +	test_expect_code 1 git config "branch.$1.merge"
> +}
> +
> +for i in simple current upstream nothing
> +do
> +	test_expect_success 'push -u with push.default=$i' '
> +		default_u_setup $i &&
> +		git push -u &&
> +		check_config main upstream refs/heads/main &&
> +		git push -u upstream main:other &&
> +		git push -u &&
> +		check_config main upstream refs/heads/main
> +	'
> +
> +	test_expect_success 'push -u -f with push.default=$i' '
> +		default_u_setup $i &&
> +		git push -u -f &&
> +		check_config main upstream refs/heads/main
> +	'
> +done
> +
> +for i in simple current upstream nothing matching
> +do
> +	test_expect_success 'push -u --prune with push.default=$i' '
> +		default_u_setup $i &&
> +		git push upstream main:test_u215 &&
> +		git push -u --prune >out &&
> +		check_config main upstream refs/heads/main &&
> +		test_i18ngrep "[deleted]" out &&
> +		test_i18ngrep ! "Branch '"'"'test_u215'"'"' set up to track" out
> +	'
> +
> +	test_expect_success 'push -u --mirror with push.default=$i' '
> +		default_u_setup $i &&
> +		test_might_fail git branch mirror1 &&
> +		test_might_fail git branch mirror2 &&
> +		git push -u --mirror &&
> +		check_config main upstream  refs/heads/main &&
> +		check_config mirror1 upstream refs/heads/mirror1 &&
> +		check_config mirror2 upstream refs/heads/mirror2
> +	'
> +done
> +
> +for i in '' '-f'
> +do
> +
> +	test_expect_success 'push -u $i with push.default=matching' '

Doesn't $i show in the output as-is here?  Quote the test title in
double-quotes, while using single-qoutes around the test body.

> +		default_u_setup matching &&
> +		test_might_fail git branch test_u &&
> +		test_might_fail git branch test_u2 &&
> +		git push upstream main:test_u2 &&
> +		git push -u $i &&
> +		check_config main upstream refs/heads/main &&
> +		check_config test_u2 upstream refs/heads/test_u2 &&
> +		check_empty_config test_u
> +	'
> +done
> +

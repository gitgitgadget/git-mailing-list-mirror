Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DFDC433EF
	for <git@archiver.kernel.org>; Wed, 15 Dec 2021 21:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbhLOVaY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Dec 2021 16:30:24 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65534 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbhLOVaW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Dec 2021 16:30:22 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8E39A16FE15;
        Wed, 15 Dec 2021 16:30:22 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Gk44mVuDdnJwTULDc8LNaOGryTDL79dJm1/mI+
        ddOsE=; b=Hxoo2W2Lv6zBAWzwsjbRRl0oIrSGD9xx+kXi827ZudXJSuv+5tIzQA
        IrIiAr4aWsOKtAFekquWCsNWObOvc4bs123M1v+uBRbVgjXfnPtXqhlI/QUiQBcm
        NmpCOKzwWEo6iQ1DTMOheAQIzssFWlk9DKud6Il2/zwD1MwXQrUy4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8758816FE14;
        Wed, 15 Dec 2021 16:30:22 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DD70116FE13;
        Wed, 15 Dec 2021 16:30:18 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, chooglen@google.com, avarab@gmail.com,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v6 1/3] branch: accept multiple upstream branches for
 tracking
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
        <cover.1639524556.git.steadmon@google.com>
        <43d6f83fedc022c44d6a3be249e7fd8cd2a25007.1639524556.git.steadmon@google.com>
Date:   Wed, 15 Dec 2021 13:30:17 -0800
In-Reply-To: <43d6f83fedc022c44d6a3be249e7fd8cd2a25007.1639524556.git.steadmon@google.com>
        (Josh Steadmon's message of "Tue, 14 Dec 2021 15:44:54 -0800")
Message-ID: <xmqqlf0l4kuu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 337F0522-5DEE-11EC-889F-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> + * `origin` is the name of the remote owning the upstream branches. NULL means
> + * the upstream branches are local to this repo.
> + *
> + * `remotes` is a list of refs that are upstream of local
> + */
> +static int install_branch_config_multiple_remotes(int flag, const char *local,
> +		const char *origin, struct string_list *remotes)
>  {
>  	const char *shortname = NULL;
>  	struct strbuf key = STRBUF_INIT;
> +	struct string_list_item *item;
>  	int rebasing = should_setup_rebase(origin);
>  
> -	if (skip_prefix(remote, "refs/heads/", &shortname)
> -	    && !strcmp(local, shortname)
> -	    && !origin) {
> -		warning(_("Not setting branch %s as its own upstream."),
> -			local);
> -		return 0;
> -	}
> +	if (!remotes->nr)
> +		BUG("must provide at least one remote for branch config");
> +	if (rebasing && remotes->nr > 1)
> +		die(_("cannot inherit upstream tracking configuration when rebasing is requested"));
> +
> +	if (!origin)
> +		for_each_string_list_item(item, remotes)
> +			if (skip_prefix(item->string, "refs/heads/", &shortname)
> +			    && !strcmp(local, shortname)) {
> +				warning(_("not setting branch '%s' as its own upstream."),
> +					local);
> +				return 0;
> +			}

OK, if there is the current branch _among_ the remotes and we are
synching with the local repository, we reject to muck the
configuration for 'local' branch with any of the refs in 'remotes'.

Makes sense.

Just FYI (because there is nothing actionable on your part), there
is another topic in flight that wants to change the warning message
to be phrased like so:

		_("not setting branch '%s' as its own upstream")

i.e. without capitalizing the first word, and without finishing the
sentence with a full stop.  I'll make the conflict resolution to
read as such.

> -test_expect_success '--set-upstream-to notices an error to set branch as own upstream' '
> +test_expect_success '--set-upstream-to notices an error to set branch as own upstream' "
>  	git branch --set-upstream-to refs/heads/my13 my13 2>actual &&
>  	cat >expect <<-\EOF &&
> -	warning: Not setting branch my13 as its own upstream.
> +	warning: not setting branch 'my13' as its own upstream.

Likewise.

>  	EOF
>  	test_expect_code 1 git config branch.my13.remote &&
>  	test_expect_code 1 git config branch.my13.merge &&
>  	test_cmp expect actual
> -'
> +"

The above is currently correct but it often is an invitation for
future bugs to use double-quotes around the executable part of
test_expect_success.  We can always write ' --> '\'' to enclose the
thing in a pair of single quotes when we start needing to refer to
$shell_variables in the executable part, so let's take the above
patch as-is, but something to keep in mind.

Thanks, queued.


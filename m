Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DAFBC433DB
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 22:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C037661A41
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 22:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbhCYW5f (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Mar 2021 18:57:35 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64794 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbhCYW5W (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Mar 2021 18:57:22 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C744DA5EE5;
        Thu, 25 Mar 2021 18:57:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CK+FxtG8UBS0lMx0VKzSYB4QFRk=; b=TLxDzj
        T43kE7SsZViA9/5I3AAZSK9zneT0iLbtWHOL4VYOd8cnz39UBVFFdds0XP2twUZx
        jHB56GLhbNth1SAjEBkbeeKjCnilbdAyF5l/pvd3vIzaGImzpZPqGlJu/b7Nu8Cd
        ndux+stskIxDTM0zrNzMfMVJ9IRPxR+sT0zIM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jEbZWMfTq9W/jchgwikguP6v4+/q0FQR
        X8mywLgwsosA4Rbk1/F2TL1O22KQ4p0cwFUOahTxORL4TwdSg0rp5zhtnqGF4Sbf
        cc6D0LhzhJPQ/5Cn7cPuYRqpytLTrlfNhI8ZWRvo4+bm7ndgsHkK2ofuBWLZz+PE
        k8mfRLRipTk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A1718A5EE4;
        Thu, 25 Mar 2021 18:57:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DC7C0A5EE3;
        Thu, 25 Mar 2021 18:57:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Li Linchao via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        dscho <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Li Linchao <lilinchao@oschina.cn>
Subject: Re: [PATCH v7] builtin/clone.c: add --reject-shallow option
References: <pull.865.v6.git.1614878345754.gitgitgadget@gmail.com>
        <pull.865.v7.git.1616670558261.gitgitgadget@gmail.com>
Date:   Thu, 25 Mar 2021 15:57:19 -0700
In-Reply-To: <pull.865.v7.git.1616670558261.gitgitgadget@gmail.com> (Li
        Linchao via GitGitGadget's message of "Thu, 25 Mar 2021 11:09:17
        +0000")
Message-ID: <xmqqmtuqu9io.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 74974DAA-8DBD-11EB-ACE2-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Li Linchao via GitGitGadget" <gitgitgadget@gmail.com> writes:

> @@ -1216,6 +1234,10 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  		if (filter_options.choice)
>  			warning(_("--filter is ignored in local clones; use file:// instead."));
>  		if (!access(mkpath("%s/shallow", path), F_OK)) {
> +			if (reject_shallow)
> +				die(_("source repository is shallow, reject to clone."));
> +			else
> +				warning(_("source repository is shallow."));

Hmph, is it an improvement to warn() when the user does not mind
cloning a shallow repository?

	$ git clone --depth=3 $URL clone-1
	$ git clone file://$(pwd)/clone-1 clone-2

would give us clone-2 that is just as functional as clone-1 is, no?
clone-1 may be missing objects that is needed far into the past, and
clone-2 would lack the same set of objects as clone-1 does, but a
user who is happily using clone-1 would be happy with clone-2 the
same way, no?

> diff --git a/fetch-pack.c b/fetch-pack.c
> index fb04a76ca263..72b378449a07 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -1129,9 +1129,13 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
>  	if (args->deepen)
>  		setup_alternate_shallow(&shallow_lock, &alternate_shallow_file,
>  					NULL);
> -	else if (si->nr_ours || si->nr_theirs)
> +	else if (si->nr_ours || si->nr_theirs) {
> +		if (args->remote_shallow)
> +			die(_("source repository is shallow, reject to clone."));

Stopping early before calling get_pack() would significantly reduce
the overhead, which is good.

> +		else
> +			warning(_("source repository is shallow."));

The same question on the wisdom of warning here.

> @@ -1498,10 +1502,14 @@ static void receive_shallow_info(struct fetch_pack_args *args,
>  		 * rejected (unless --update-shallow is set); do the same.
>  		 */
>  		prepare_shallow_info(si, shallows);
> -		if (si->nr_ours || si->nr_theirs)
> +		if (si->nr_ours || si->nr_theirs) {
> +			if (args->remote_shallow)
> +				die(_("source repository is shallow, reject to clone."));
> +			else
> +				warning(_("source repository is shallow."));

OK, so, this is the equivalent of the above for protocol-v2?  The
same comments apply, then.

> diff --git a/t/t5606-clone-options.sh b/t/t5606-clone-options.sh
> index 428b0aac93fa..2863b8b28d44 100755
> --- a/t/t5606-clone-options.sh
> +++ b/t/t5606-clone-options.sh
> @@ -5,6 +5,8 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
>  export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>  
>  . ./test-lib.sh
> +. "$TEST_DIRECTORY"/lib-httpd.sh
> +start_httpd
>  
>  test_expect_success 'setup' '
>  
> @@ -45,6 +47,51 @@ test_expect_success 'disallows --bare with --separate-git-dir' '
>  
>  '
>  
> +test_expect_success 'fail to clone http shallow repository' '

s/fail to clone/reject cloning/, perhaps.

> +test_expect_success 'clone shallow repository with --no-reject-shallow' '
> +	rm -rf shallow-repo &&
> +	git clone --depth=1 --no-local parent shallow-repo &&
> +	git clone --no-reject-shallow --no-local shallow-repo clone-repo

OK.  Also without "--no-reject-shallow" option, the command would
successfully clone from the shallow-repo, I presume?

The changes look more-or-less good to me, except for the "warning()"
bit, which I do not think is a good idea.

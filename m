Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B5CA20954
	for <e@80x24.org>; Fri, 24 Nov 2017 06:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753192AbdKXG5K (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Nov 2017 01:57:10 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61827 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752963AbdKXG5H (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Nov 2017 01:57:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E21D4B75B4;
        Fri, 24 Nov 2017 01:57:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UkMRMz122KAUHJnT6+1hDKEy4ZQ=; b=pp6kGO
        GvD8bIrqhNXsVo928pjr5dpaCu5jdv8PocBJSTr9bEqTGB6k4PSZZLQcJVtcl6GV
        J85Xh3bH4X5q7KZYp6IbGNPPp+5HYh6H+T0vbPxMcddRPpyUkG6EbW7YVsNxDBQb
        6gS4DAEzT29Qa4dhrVxwQJSyQO6YtAd7x2gVE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FINpUpiKhClZq0NdHN5uQcehfMs/o+/M
        m3RrLNEvVRrhuDpaVchc90kb9QsbWdvQY+maCZzhV2gruXfcE/ctNSd2o+G1vZ2Y
        DikkP4pAnq5huSroQwnxYBC6zrKi7g6ybqG48aofmkFqJ0SHfil3XjDBGb2E7YMy
        phcHqfK4Bjo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DACC8B75B3;
        Fri, 24 Nov 2017 01:57:06 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5788BB75B2;
        Fri, 24 Nov 2017 01:57:06 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 2/4] worktree: add --[no-]track option to the add subcommand
References: <mailto:20171118224706.13810-1-t.gummerer@gmail.com>
        <20171122223020.2780-1-t.gummerer@gmail.com>
        <20171122223020.2780-3-t.gummerer@gmail.com>
Date:   Fri, 24 Nov 2017 15:57:04 +0900
In-Reply-To: <20171122223020.2780-3-t.gummerer@gmail.com> (Thomas Gummerer's
        message of "Wed, 22 Nov 2017 22:30:18 +0000")
Message-ID: <xmqqa7zcnozj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AEE9295E-D0E4-11E7-903A-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
> index b5c47ac602..53042ce565 100755
> --- a/t/t2025-worktree-add.sh
> +++ b/t/t2025-worktree-add.sh
> @@ -313,5 +313,60 @@ test_expect_success 'checkout a branch under bisect' '
>  test_expect_success 'rename a branch under bisect not allowed' '
>  	test_must_fail git branch -M under-bisect bisect-with-new-name
>  '
> +# Is branch "refs/heads/$1" set to pull from "$2/$3"?
> +test_branch_upstream () {
> +	printf "%s\n" "$2" "refs/heads/$3" >expect.upstream &&
> +	{
> +		git config "branch.$1.remote" &&
> +		git config "branch.$1.merge"
> +	} >actual.upstream &&
> +	test_cmp expect.upstream actual.upstream
> +}

OK.

> +test_expect_success '--track sets up tracking' '
> +	test_when_finished rm -rf track &&
> +	git worktree add --track -b track track master &&
> +	git config "branch.track.merge" &&
> +	(
> +		test_branch_upstream track . master
> +	)
> +'

Is this "git config" necessary, or is it a remnant of a debugging
session?  It is tested in the helper that branch.track.merge is set
to something, and otherwise the helper would fail the same way as
this standalnoe "git config" would, no?

> +# setup remote repository $1 and repository $2 with $1 set up as
> +# remote.  The remote has two branches, master and foo.
> +setup_remote_repo () {
> +	git init $1 &&
> +	(
> +		cd $1 &&
> +		test_commit $1_master &&
> +		git checkout -b foo &&
> +		test_commit upstream_foo
> +	) &&
> +	git init $2 &&
> +	(
> +		cd $2 &&
> +		test_commit $2_master &&
> +		git remote add $1 ../$1 &&
> +		git config remote.$1.fetch \
> +			"refs/heads/*:refs/remotes/$1/*" &&
> +		git fetch --all
> +	)
> +}
> +
> +test_expect_success '--no-track avoids setting up tracking' '
> +	test_when_finished rm -rf repo_upstream repo_local foo &&
> +	setup_remote_repo repo_upstream repo_local &&
> +	(
> +		cd repo_local &&
> +		git worktree add --no-track -b foo ../foo repo_upstream/foo
> +	) &&
> +	(
> +		cd foo &&
> +		! test_branch_upstream foo repo_upstream foo &&

It is true that this test helper must yield failure.  But what you
expect probably is more than that, no?  For example, the test helper
would fail even if branch.foo.remote is set to the upstream as long
as branch.foo.merge is not set to point at their foo, but what you
really want to make sure is that neither configuration variable is
set.

> +		git rev-parse repo_upstream/foo >expect &&
> +		git rev-parse foo >actual &&
> +		test_cmp expect actual
> +	)
> +'
>  
>  test_done

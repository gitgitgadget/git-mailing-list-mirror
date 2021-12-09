Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B74C433F5
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 18:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243257AbhLIS2K (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 13:28:10 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58356 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbhLIS2J (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 13:28:09 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D7F4A179C7B;
        Thu,  9 Dec 2021 13:24:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=imXfe/eB6QiNBZDfrpyjwIJFpKnSkhOE0R1CG+
        w4bQw=; b=rxYtJ6pwyjcyFEmlNjU5OT95fC/oE2m8lK3ifInSbzZCcCNnx7owfp
        rJooWkFBdD/Af3Oy6ReD9uuc2fEXLJuCvpKbUDUliiAY0LZNMaSEeQzKJYlTwCws
        Vzc+wfI+jWcqs08NC5jEsxsBi7tQj69EnZ9XwtEcwtQOFArnnUq2s=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CFAB5179C7A;
        Thu,  9 Dec 2021 13:24:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1EAE0179C78;
        Thu,  9 Dec 2021 13:24:32 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 02/14] t5403: refactor rebase post-checkout hook tests
References: <pull.1049.git.1633082702.gitgitgadget@gmail.com>
        <pull.1049.v2.git.1638975481.gitgitgadget@gmail.com>
        <a67a5a03b94ccbaec85da2c93ce5bbffcd5cfac9.1638975482.git.gitgitgadget@gmail.com>
Date:   Thu, 09 Dec 2021 10:24:30 -0800
In-Reply-To: <a67a5a03b94ccbaec85da2c93ce5bbffcd5cfac9.1638975482.git.gitgitgadget@gmail.com>
        (Phillip Wood via GitGitGadget's message of "Wed, 08 Dec 2021 14:57:49
        +0000")
Message-ID: <xmqqk0gdskkh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 41051D60-591D-11EC-BA93-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> These tests only test the default backend and do not check that the
> arguments passed to the hook are correct. Fix this by running the
> tests with both backends and adding checks for the hook arguments.

Nice.

> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  t/t5403-post-checkout-hook.sh | 42 ++++++++++++++++++++++-------------
>  1 file changed, 26 insertions(+), 16 deletions(-)
>
> diff --git a/t/t5403-post-checkout-hook.sh b/t/t5403-post-checkout-hook.sh
> index 1ec9e23be75..272b02687ba 100755
> --- a/t/t5403-post-checkout-hook.sh
> +++ b/t/t5403-post-checkout-hook.sh
> @@ -49,23 +49,33 @@ test_expect_success 'post-checkout receives the right args when not switching br
>  	test $old = $new && test $flag = 0
>  '
>  
> -test_expect_success 'post-checkout is triggered on rebase' '
> -	test_when_finished "rm -f .git/post-checkout.args" &&
> -	git checkout -b rebase-test main &&
> -	rm -f .git/post-checkout.args &&
> -	git rebase rebase-on-me &&
> -	read old new flag <.git/post-checkout.args &&
> -	test $old != $new && test $flag = 1
> -'
> +test_rebase () {
> +	args="$*" &&
> +	test_expect_success "post-checkout is triggered on rebase $args" '
> +		test_when_finished "rm -f .git/post-checkout.args" &&
> +		git checkout -B rebase-test main &&
> +		rm -f .git/post-checkout.args &&
> +		git rebase $args rebase-on-me &&
> +		read old new flag <.git/post-checkout.args &&
> +		test_cmp_rev main $old &&
> +		test_cmp_rev rebase-on-me $new &&
> +		test $flag = 1
> +	'

OK, so we now make sure $old and $new are what we expect, in
addition to what $flag we got.  And the change from -b to -B is
understandable as this needs to be prepared to run more than once.

> -test_expect_success 'post-checkout is triggered on rebase with fast-forward' '
> -	test_when_finished "rm -f .git/post-checkout.args" &&
> -	git checkout -b ff-rebase-test rebase-on-me^ &&
> -	rm -f .git/post-checkout.args &&
> -	git rebase rebase-on-me &&
> -	read old new flag <.git/post-checkout.args &&
> -	test $old != $new && test $flag = 1
> -'
> +	test_expect_success "post-checkout is triggered on rebase $args with fast-forward" '
> +		test_when_finished "rm -f .git/post-checkout.args" &&
> +		git checkout -B ff-rebase-test rebase-on-me^ &&
> +		rm -f .git/post-checkout.args &&
> +		git rebase $args rebase-on-me &&
> +		read old new flag <.git/post-checkout.args &&
> +		test_cmp_rev rebase-on-me^ $old &&
> +		test_cmp_rev rebase-on-me $new &&
> +		test $flag = 1
> +	'
> +}

Likewise.

> +test_rebase --apply &&
> +test_rebase --merge

I am not sure if "&&" is appropriate here.  It is like saying

	test_expect_success "test on apply" '
		body of apply test
	' &&

	test_expect_success "test on merge" '
		body of merge test
	'

no?  In other words, even if somebody broke the apply backend, we
still are interested in seeing the merge backend succeed.

>  test_expect_success 'post-checkout hook is triggered by clone' '
>  	mkdir -p templates/hooks &&

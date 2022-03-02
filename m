Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98FCC433EF
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 23:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiCBXvs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 18:51:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiCBXvr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 18:51:47 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FF34C412
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 15:51:03 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9B84D17C139;
        Wed,  2 Mar 2022 18:32:04 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=qDwvyb/OtXGg
        hKc+wJjeSQfOnU/0jg43KEyS5vOdsII=; b=Sx/k4b33cZFyGDLmiDTjHSIarc3y
        oj9BJ4TSoAXniAPFySap/arEG+xSZUzaCR3hfMRDHYvogMxGdrabyQTtnX6RhF3M
        hgjnN/uwCrpPgHbRYWA29RkEekU8ekCoFsM/EaA44pUqE4HQ6JJrFYsUtRiryCQZ
        nPI88cMAv771HQQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 91E3517C138;
        Wed,  2 Mar 2022 18:32:04 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0FEBD17C136;
        Wed,  2 Mar 2022 18:32:02 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v4 1/3] stash: add tests to ensure reflog --rewrite
 --updatref behavior
References: <pull.1218.v3.git.git.1645817452.gitgitgadget@gmail.com>
        <pull.1218.v4.git.git.1646260044.gitgitgadget@gmail.com>
        <08bb8d3a9b9cd75c8b2aed11db9456baef6f415b.1646260044.git.gitgitgadget@gmail.com>
Date:   Wed, 02 Mar 2022 15:32:01 -0800
In-Reply-To: <08bb8d3a9b9cd75c8b2aed11db9456baef6f415b.1646260044.git.gitgitgadget@gmail.com>
        (John Cai via GitGitGadget's message of "Wed, 02 Mar 2022 22:27:22
        +0000")
Message-ID: <xmqqlexsexse.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F653BC68-9A80-11EC-97E4-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: John Cai <johncai86@gmail.com>
>
> There is missing test coverage to ensure that the resulting reflogs
> after a git stash drop has had its old oid rewritten if applicable, and
> if the refs/stash has been updated if applicable.
>
> Add two tests that verify both of these happen.
>
> Helped-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Signed-off-by: John Cai <johncai86@gmail.com>
> ---
>  t/t3903-stash.sh | 43 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 42 insertions(+), 1 deletion(-)
>
> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index b149e2af441..a2f8d0c52e7 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -41,7 +41,7 @@ diff_cmp () {
>  	rm -f "$1.compare" "$2.compare"
>  }
> =20
> -test_expect_success 'stash some dirty working directory' '
> +setup_stash() {

Style.

	setup_stash () {

but more importantly, is this really setting up "stash"?
"setup_stash_test" or something, perhaps?

> +test_expect_success 'stash some dirty working directory' '
> +	setup_stash
>  '

OK.

> +test_expect_success 'drop stash reflog updates refs/stash' '
> +	git reset --hard &&
> +	git rev-parse refs/stash >expect &&
> +	echo 9 >file &&
> +	git stash &&
> +	git stash drop stash@{0} &&
> +	git rev-parse refs/stash >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success REFFILES 'drop stash reflog updates refs/stash wit=
h rewrite' '
> +	git init repo &&
> +	(
> +		cd repo &&
> +		setup_stash
> +	) &&

Hmph, so this is done inside the subdirectory.  The implementation
of the helper in this iteration does look cleaner than in the
previous iteration.

But these many references to "repo/" and "-C repo" we see below
makes me wonder why we do not put the whole thing inside the
subshell we started earlier.

i.e.

	git init repo &&
	(
		cd repo &&
		setup_stash_test &&

		echo 9 >file &&
		old=3D$(git rev-parse stash@{0}) &&
		git stash &&
		new=3D$(git rev-parse stash@{0}) &&
		...

		test_cmp expect actual
	)

> +	echo 9 >repo/file &&
> +
> +	old_oid=3D"$(git -C repo rev-parse stash@{0})" &&
> +	git -C repo stash &&
> +	new_oid=3D"$(git -C repo rev-parse stash@{0})" &&
> +
> +	cat >expect <<-EOF &&
> +	$(test_oid zero) $old_oid
> +	$old_oid $new_oid
> +	EOF
> +	cut -d" " -f1-2 repo/.git/logs/refs/stash >actual &&
> +	test_cmp expect actual &&
> +
> +	git -C repo stash drop stash@{1} &&
> +	cut -d" " -f1-2 repo/.git/logs/refs/stash >actual &&
> +	cat >expect <<-EOF &&
> +	$(test_oid zero) $new_oid
> +	EOF
> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'stash pop' '
>  	git reset --hard &&
>  	git stash pop &&

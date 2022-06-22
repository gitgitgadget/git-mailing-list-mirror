Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C3BC433EF
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 18:10:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377033AbiFVSKN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 14:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376474AbiFVSKM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 14:10:12 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232F839814
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 11:10:11 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 52CA71476E8;
        Wed, 22 Jun 2022 14:10:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=O07qJLbo+vnS
        9NkvW6bD9vPCgjSyao44JgaLUN36iko=; b=lfA1jl38uM8RuVgrNgAQJxRIZT7S
        IZdlDZjDAnFZa0H1TXovQ99/ZmskOh+srwa6bfsTDQ1eMsgP4TCBLoqsN8tJ8wXZ
        5xN/7n+ZQFdYkF1jiRaH9n1B3wqQmeLgPd5BnUct+z2KJbQMDZqoROQgkICim3u6
        Y0zD5s0qkdRrfpc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3C0571476E6;
        Wed, 22 Jun 2022 14:10:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C11F21476E5;
        Wed, 22 Jun 2022 14:10:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Carlos_L=C3=B3pez_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?Q?Martin_=C3=85gren_=5B_=5D?= <martin.agren@gmail.com>,
        "Paul Eggert [ ]" <eggert@cs.ucla.edu>,
        "Carlos L." <00xc@protonmail.com>
Subject: Re: [PATCH v3 2/2] tests: add tests for grep --max-count
References: <pull.1278.v2.git.git.1655789777023.gitgitgadget@gmail.com>
        <pull.1278.v3.git.git.1655917628.gitgitgadget@gmail.com>
        <525958af877c3bbd024ffd3aee0c64e469c3d6cf.1655917628.git.gitgitgadget@gmail.com>
Date:   Wed, 22 Jun 2022 11:10:06 -0700
In-Reply-To: <525958af877c3bbd024ffd3aee0c64e469c3d6cf.1655917628.git.gitgitgadget@gmail.com>
        ("Carlos =?utf-8?Q?L=C3=B3pez?= via GitGitGadget"'s message of "Wed, 22 Jun
 2022
        17:07:08 +0000")
Message-ID: <xmqq7d58603l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8CFD8A7C-F256-11EC-B40C-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Carlos L=C3=B3pez via GitGitGadget"  <gitgitgadget@gmail.com> writes:

> From: =3D?UTF-8?q?Carlos=3D20L=3DC3=3DB3pez?=3D <00xc@protonmail.com>
>
> Add tests for grep's -m / --max-count to check if the option correctly
> outputs limited results, and that it interacts properly with other flag=
s
> that could likely be used in conjunction.
>
> Signed-off-by: Carlos L=C3=B3pez 00xc@protonmail.com
> ---
>  t/t7810-grep.sh | 83 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 83 insertions(+)

This is better done as part of the previous patch.  The new tests
protect the new code from future breakage.

> diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
> index 69356011713..7b1b8a3cd93 100755
> --- a/t/t7810-grep.sh
> +++ b/t/t7810-grep.sh
> @@ -77,6 +77,7 @@ test_expect_success setup '
>  	# Say hello.
>  	function hello() {
>  	  echo "Hello world."
> +	  echo "Hello again."
>  	} # hello
> =20
>  	# Still a no-op.
> @@ -595,6 +596,88 @@ test_expect_success 'grep --files-without-match --=
quiet' '
>  	test_must_be_empty actual
>  '
> =20
> +cat >expected <<EOF &&
> +EOF
> +
> +test_expect_success 'grep --max-count 0 (must exit with non-zero)' '
> +	test_must_fail git grep --max-count 0 foo >actual &&
> +	test_cmp expected actual
> +'

For this particular one, "test_must_be_empty actual" would suffice,
without comparing with the expected output.

> +cat >expected <<EOF &&
> +file:foo mmap bar
> +EOF
> +
> +test_expect_success 'grep --max-count 1' '
> +	git grep --max-count 1 foo >actual &&
> +	test_cmp expected actual
> +'

Writing expected output outside test_expect_success that uses it is
a quite old style but that is because this test script is pretty
much ancient, so mimicking it is OK.  We'd need to come back later
when the tree is quiescent to clean them up, though (#leftoverbits).

> ...
> +	test_cmp expected actual
> +'

The new tests seem to give us a reasonable test coverage.  We could
discard one of the "-m1" vs "-m3" in the early ones, as they do not
give much extra test coverage over the other, to reduce repetition.

We do not test a case where we pick up-to N matches each from
multiple files, though.  Perhaps

    git grep -m1 -e o -- hello.\*

may stop after hitting "No-op." in hello.ps1 and "stdio" in hello.c,
which may make a good test, perhaps?

Thanks.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BB5C433EF
	for <git@archiver.kernel.org>; Wed, 27 Apr 2022 20:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiD0UkY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Apr 2022 16:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiD0UkX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Apr 2022 16:40:23 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05D5CDE
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 13:37:08 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F2E36135432;
        Wed, 27 Apr 2022 16:37:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=UWzEvyvFYHHY
        E5+vJ98A9qzFWHRTX4QniTwOmJUNDvU=; b=cpnc+OPwwUGG/v9vfUpsrqe77iKf
        WN9GqjyyOt9h7EpbeZDg/Q+NnI44AOmF5Jh9rCXec7ndAOVN5JozH+B33cKOF/CH
        gxorXjpMRIbAGarSSmLiMdJWCQc73/85c2XmXGMkMUV2k8EC3c/SiBr2OrGDuSrZ
        UyNB0hoRqxwV7Ak=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D9817135431;
        Wed, 27 Apr 2022 16:37:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 10F85135430;
        Wed, 27 Apr 2022 16:37:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 2/3] t0033-safe-directory: check when 'safe.directory'
 is ignored
References: <pull.1215.git.1649863951.gitgitgadget@gmail.com>
        <20220427170649.4949-1-szeder.dev@gmail.com>
        <20220427170649.4949-3-szeder.dev@gmail.com>
Date:   Wed, 27 Apr 2022 13:37:03 -0700
In-Reply-To: <20220427170649.4949-3-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Wed, 27 Apr 2022 19:06:48 +0200")
Message-ID: <xmqqr15il0uo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CCC4AA6E-C669-11EC-8F8C-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> According to the documentation 'safe.directory' "is only respected
> when specified in a system or global config, not when it is specified
> in a repository config or via the command line option -c
> safe.directory=3D<path>".
>
> Add tests to check that 'safe.directory' in the repository config or
> on the command line is indeed ignored.
>
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> ---
>  t/t0033-safe-directory.sh | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/t/t0033-safe-directory.sh b/t/t0033-safe-directory.sh
> index 6f9680e8b0..82dac0eb93 100755
> --- a/t/t0033-safe-directory.sh
> +++ b/t/t0033-safe-directory.sh
> @@ -16,6 +16,19 @@ test_expect_success 'safe.directory is not set' '
>  	expect_rejected_dir
>  '
> =20
> +test_expect_success 'ignoring safe.directory on the command line' '
> +	test_must_fail git -c safe.directory=3D"$(pwd)" status 2>err &&
> +	grep "unsafe repository" err
> +'
> +
> +test_expect_success 'ignoring safe.directory in repo config' '
> +	(
> +		unset GIT_TEST_ASSUME_DIFFERENT_OWNER &&
> +		git config safe.directory "$(pwd)"
> +	) &&
> +	expect_rejected_dir
> +'

I am debating myself if we want to remove the in-repository
safe.directory configuration setting after this test piece is done,
with test_when_finished.  We just made sure, with this test, that
having the variable does not affect anything, so the subsequent
tests should not care hence it is probably OK.  On the other hand,
to make sure those settings they make (e.g. setting it globally is
what the next test we can see below does) is what affects their
outcome, it removes one more thing we need to worry about if we
clean after ourselves.  I dunno.

Other than that, looking good so far; both [1/3] and [2/3] look good.

>  test_expect_success 'safe.directory does not match' '
>  	git config --global safe.directory bogus &&
>  	expect_rejected_dir

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B25CC433EF
	for <git@archiver.kernel.org>; Wed, 27 Apr 2022 20:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235187AbiD0Ups (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Apr 2022 16:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbiD0Upr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Apr 2022 16:45:47 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214035FC5
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 13:42:35 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 40CCC134ABA;
        Wed, 27 Apr 2022 16:42:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=U+wLdofg/VWI
        zdE7w4sNl1fVGhe4kW4N2Vtgs5RALSk=; b=FF5NJe12tdimFASlLeHotBxdZ/BF
        wp/BPpAXL95uqvPm1tQ9tzpx/K8zB0MEFoMNirj2Y4OsymtQZnMywruG7MSFqU36
        xSQnhOI68CqijPI002R/KuJBoZMmufQupy7YltslNUkX14//nuWBLqFq1sg4Gvv7
        y/0WE5a2i0o0L+o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 37EF7134AB9;
        Wed, 27 Apr 2022 16:42:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A3F5F134AB8;
        Wed, 27 Apr 2022 16:42:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 3/3] safe.directory: document and check that it's
 ignored in the environment
References: <pull.1215.git.1649863951.gitgitgadget@gmail.com>
        <20220427170649.4949-1-szeder.dev@gmail.com>
        <20220427170649.4949-4-szeder.dev@gmail.com>
Date:   Wed, 27 Apr 2022 13:42:32 -0700
In-Reply-To: <20220427170649.4949-4-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Wed, 27 Apr 2022 19:06:49 +0200")
Message-ID: <xmqqlevql0lj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 909FAF56-C66A-11EC-96E2-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> The description of 'safe.directory' mentions that it's respected in
> the system and global configs, and ignored in the repository config
> and on the command line, but it doesn't mention whether it's respected
> or ignored when specified via environment variables (nor does the
> commit message adding 'safe.directory' [1]).

If we had GIT_SAFE_DIRECTORIES that lists the safe directories (like
$PATH does), that would have been absolutely necessary to document
how it works, but GIT_CONFIG_* is merely an implementation detail of
how "git -c var=3Dval" works and I am not sure if it is even a good
idea to hardcode how they happen to work like these tests.  The only
thing the users should know is that GIT_CONFIG_{KEY,VALUE}_* are
used internally by the implementation and they should not muck with
it, no?

I am moderately negative about this change.

> diff --git a/t/t0033-safe-directory.sh b/t/t0033-safe-directory.sh
> index 82dac0eb93..238b25f91a 100755
> --- a/t/t0033-safe-directory.sh
> +++ b/t/t0033-safe-directory.sh
> @@ -21,6 +21,21 @@ test_expect_success 'ignoring safe.directory on the =
command line' '
>  	grep "unsafe repository" err
>  '
> =20
> +test_expect_success 'ignoring safe.directory in the environment' '
> +	test_must_fail env GIT_CONFIG_COUNT=3D1 \
> +		GIT_CONFIG_KEY_0=3D"safe.directory" \
> +		GIT_CONFIG_VALUE_0=3D"$(pwd)" \
> +		git status 2>err &&
> +	grep "unsafe repository" err
> +'
> +
> +test_expect_success 'ignoring safe.directory in GIT_CONFIG_PARAMETERS'=
 '
> +	test_must_fail env \
> +		GIT_CONFIG_PARAMETERS=3D"${SQ}safe.directory${SQ}=3D${SQ}$(pwd)${SQ}=
" \
> +		git status 2>err &&
> +	grep "unsafe repository" err
> +'
> +
>  test_expect_success 'ignoring safe.directory in repo config' '
>  	(
>  		unset GIT_TEST_ASSUME_DIFFERENT_OWNER &&

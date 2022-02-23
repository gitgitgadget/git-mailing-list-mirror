Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828B4C433F5
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 21:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242218AbiBWV1p (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 16:27:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242109AbiBWV1o (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 16:27:44 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F06936695
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 13:27:16 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1182F178F4B;
        Wed, 23 Feb 2022 16:27:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=oYpzSbYk14DV
        KSYqM0xFaZ1q8ZE7Q9mV7+u8omZHLig=; b=Vo5IcOnl99rcLjiXN5W3EKSVKUFM
        O8HE0zvhsx5rC+5Kb+67nnjXcnpwvyokjjQFPVub0Dq1hIrjKpBfPWL9kqVhkdss
        5wgM4xzmrtwR4loMsuropKegFyBb/JjhqoJCd6McUV/lQHmXXii48/YuIDllpAap
        t0iYnnwAO/l8hmk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0AF9B178F49;
        Wed, 23 Feb 2022 16:27:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 754C2178F48;
        Wed, 23 Feb 2022 16:27:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v2 1/3] stash: add test to ensure reflog --rewrite
 --updatref behavior
References: <pull.1218.git.git.1645209647.gitgitgadget@gmail.com>
        <pull.1218.v2.git.git.1645554651.gitgitgadget@gmail.com>
        <6e136b62ca4588cc58f2cb59b635eeaf14e6e20d.1645554652.git.gitgitgadget@gmail.com>
        <220223.864k4q6jpr.gmgdl@evledraar.gmail.com>
Date:   Wed, 23 Feb 2022 13:27:12 -0800
In-Reply-To: <220223.864k4q6jpr.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 23 Feb 2022 09:54:47 +0100")
Message-ID: <xmqq4k4ptgsv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5DE3A452-94EF-11EC-B97C-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> This test was already a bit broken in needing the preceding tests, but
> it will break now if REFFILES isn't true, which you can reproduce
> e.g. with:
>
>     ./t3903-stash.sh --run=3D1-16,18-50 -vixd
>
> Perhaps the least sucky solution to that is:
>
> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index ec9cc5646d6..1d11c9bda20 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -205,13 +205,19 @@ test_expect_success 'drop stash reflog updates re=
fs/stash with rewrite' '
>  	cat >expect <<-EOF &&
>  	$(test_oid zero) $oid
>  	EOF
> -	test_cmp expect actual
> +	test_cmp expect actual &&
> +	>dropped-stash
>  '

If "git stash drop", invoked in earlier part of this test before the
precontext, fails, then test_cmp would fail and we leave
dropped-stash untouched, even though we did run "git stash drop"
already.

Why does the next test need to depend on what has happened earlier?

>  test_expect_success 'stash pop' '
>  	git reset --hard &&
>  	git stash pop &&
> -	test 9 =3D $(cat file) &&
> +	if test -e dropped-stash
> +	then
> +		test 9 =3D $(cat file)
> +	else
> +		test 3 =3D $(cat file)
> +	fi &&
>  	test 1 =3D $(git show :file) &&
>  	test 1 =3D $(git show HEAD:file) &&
>  	test 0 =3D $(git stash list | wc -l)

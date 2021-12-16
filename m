Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE9EC433EF
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 22:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237396AbhLPWDQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 17:03:16 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52327 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234459AbhLPWDP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 17:03:15 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 47BD816209D;
        Thu, 16 Dec 2021 17:03:15 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ZWN//yDbCG/k
        WXfKzE3LumGrrAVuBfqLiuctcWayHeI=; b=HtpwL95RrFhe3LVPPBiDjXpF2I52
        B2QxqxUcPAp+yC2iDz/Ks8Lb7W7l61LculN5gZ/PCmepjGFXCBGYj+EYw6VRAZNp
        zR443Wx+QQjE6qrz1M1R1ugUR3S4GZCd0EvNjEhc71fM3TKhO50rG8j2zIQbCwzw
        vkAazcU4lwQCQus=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4177716209C;
        Thu, 16 Dec 2021 17:03:15 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B3D2A16209B;
        Thu, 16 Dec 2021 17:03:11 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Carlo Arenas <carenas@gmail.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Subject: Re: [PATCH v3] stash: don't show "git stash push" usage on bad "git
 stash" usage
References: <patch-v2-1.1-d1b9790904c-20210921T134436Z-avarab@gmail.com>
        <patch-v3-1.1-6b33b104c84-20211216T125317Z-avarab@gmail.com>
Date:   Thu, 16 Dec 2021 14:03:10 -0800
In-Reply-To: <patch-v3-1.1-6b33b104c84-20211216T125317Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 16 Dec
 2021 13:54:21
        +0100")
Message-ID: <xmqqczlw8axt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F5CF3A48-5EBB-11EC-8B45-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> diff --git a/builtin/stash.c b/builtin/stash.c
> index 18c812bbe03..5462840a073 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -1681,6 +1681,7 @@ static int push_stash(int argc, const char **argv=
, const char *prefix,
>  	if (argc) {
>  		force_assume =3D !strcmp(argv[0], "-p");
>  		argc =3D parse_options(argc, argv, prefix, options,
> +				     push_assumed ? git_stash_usage :
>  				     git_stash_push_usage,
>  				     PARSE_OPT_KEEP_DASHDASH);
>  	}

Yeah, "git stash" having the implicit default to "push" may have
been convenient for its original intended use case (i.e. clear the
working area with as little typing and effort as possible), but
without a care like this one, it would result in surprises.

Looks good, will queue.


> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index 2c66cfbc3b7..b17c52d8807 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -10,6 +10,25 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> =20
>  . ./test-lib.sh
> =20
> +test_expect_success 'usage on cmd and subcommand invalid option' '
> +	test_expect_code 129 git stash --invalid-option 2>usage &&
> +	grep "or: git stash" usage &&
> +
> +	test_expect_code 129 git stash push --invalid-option 2>usage &&
> +	! grep "or: git stash" usage
> +'
> +
> +test_expect_success 'usage on main command -h emits a summary of subco=
mmands' '
> +	test_expect_code 129 git stash -h >usage &&
> +	grep -F "usage: git stash list" usage &&
> +	grep -F "or: git stash show" usage
> +'
> +
> +test_expect_failure 'usage for subcommands should emit subcommand usag=
e' '
> +	test_expect_code 129 git stash push -h >usage &&
> +	grep -F "usage: git stash [push" usage
> +'
> +
>  diff_cmp () {
>  	for i in "$1" "$2"
>  	do

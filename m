Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A0B8C433EF
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 21:14:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245311AbiCBVPj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 16:15:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245346AbiCBVPb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 16:15:31 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5E2E1B65
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 13:13:54 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 829F211B808;
        Wed,  2 Mar 2022 16:13:21 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=kfN45v+0wgsa
        IEVaDO/lnTs++xV8mNUcrBS99DenZRo=; b=D2CN8Dx5ojNoJydmw+OP0v3p3YMa
        zhRZaB1CCHs1NMK6JDZe7PdZ0n0c+xeZb0s5VWswXFY+6OllNjRbbpHHfwjcV6E4
        +R1JlXASo7AX0w1la5c12gMbmMuAyE0vkn0b+eaOoeCpnVxOLAJgZ/wRd0yiwxyw
        n93HUOhm0xaUK7I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 79B1711B807;
        Wed,  2 Mar 2022 16:13:21 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D13B611B806;
        Wed,  2 Mar 2022 16:13:20 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 03/10] tests: assume the hooks are disabled by default
References: <cover-00.10-00000000000-20220302T131859Z-avarab@gmail.com>
        <patch-03.10-0519102edeb-20220302T131859Z-avarab@gmail.com>
Date:   Wed, 02 Mar 2022 13:13:19 -0800
In-Reply-To: <patch-03.10-0519102edeb-20220302T131859Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 2 Mar
 2022 14:22:22
        +0100")
Message-ID: <xmqq8rtsjbww.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 96800426-9A6D-11EC-9A4E-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Stop moving the .git/hooks directory out of the way, or creating it
> during test setup. Instead assume that it will contain
> harmless *.sample files.

Makes sense.  We ship sample files and no activated hooks in the
default install, and we do want to assume that in most of our tests
(except for ones that validate that asssumptions, of course).

> diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction=
-hooks.sh
> index 4e1e84a91f3..d21dd5e5df0 100755
> --- a/t/t1416-ref-transaction-hooks.sh
> +++ b/t/t1416-ref-transaction-hooks.sh
> @@ -8,7 +8,6 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>  . ./test-lib.sh
> =20
>  test_expect_success setup '
> -	mkdir -p .git/hooks &&

Interesting.  This becomes part of the tests that validate the
assumption that we do ship the hooks/ directory with sample files
;-)

>  	test_commit PRE &&
>  	PRE_OID=3D$(git rev-parse PRE) &&
>  	test_commit POST &&
> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
> index 3137eb8d4d2..1a20e54adc1 100755
> --- a/t/t5516-fetch-push.sh
> +++ b/t/t5516-fetch-push.sh
> @@ -28,8 +28,7 @@ mk_empty () {
>  	(
>  		cd "$repo_name" &&
>  		git init &&
> -		git config receive.denyCurrentBranch warn &&
> -		mv .git/hooks .git/hooks-disabled
> +		git config receive.denyCurrentBranch warn
>  	)
>  }

Good.

> diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
> index a6308acf006..63a0f609866 100755
> --- a/t/t7519-status-fsmonitor.sh
> +++ b/t/t7519-status-fsmonitor.sh
> @@ -56,7 +56,6 @@ test_lazy_prereq UNTRACKED_CACHE '
>  '
> =20
>  test_expect_success 'setup' '
> -	mkdir -p .git/hooks &&
>  	: >tracked &&
>  	: >modified &&
>  	mkdir dir1 &&
> @@ -322,7 +321,6 @@ test_expect_success UNTRACKED_CACHE 'ignore .git ch=
anges when invalidating UNTR'
>  	test_create_repo dot-git &&
>  	(
>  		cd dot-git &&
> -		mkdir -p .git/hooks &&
>  		: >tracked &&
>  		: >modified &&
>  		mkdir dir1 &&

Nice.  Presumably these should have been done when we stopped
mucking with hooks-disabled in test_create_repo helper but we
forgot to do so, and these are the only remaining bits?

Thanks for tying the loose ends.


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A976C433EF
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 21:31:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240550AbiCBVcG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 16:32:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235450AbiCBVcE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 16:32:04 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39F9C7C27
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 13:31:20 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 46AFA11BAB5;
        Wed,  2 Mar 2022 16:31:20 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=hO+VLUj6OyYA
        mNCGQr4cUCnQlVwbiY+fqUBGuf4qiIc=; b=HqoTxDerz5L0noJhDf/zkJ1vhx8f
        +hkt1nSAKPgFeVQjD9uhOA+V6IR67T/qGwodluICRS8VtABtU5i1CjSChSSVrAK/
        abVVHw2gLFquur9fWfOFlMary7f8vN8zZjuZvASeoL5ywHCrrAZZ+rbvwsRmkNVj
        oD2N2sfLQggWanI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3DC4D11BAB4;
        Wed,  2 Mar 2022 16:31:20 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8D83C11BAB3;
        Wed,  2 Mar 2022 16:31:19 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 06/10] hook tests: get rid of unnecessary sub-shells
References: <cover-00.10-00000000000-20220302T131859Z-avarab@gmail.com>
        <patch-06.10-d86ee06b46e-20220302T131859Z-avarab@gmail.com>
Date:   Wed, 02 Mar 2022 13:31:18 -0800
In-Reply-To: <patch-06.10-d86ee06b46e-20220302T131859Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 2 Mar
 2022 14:22:25
        +0100")
Message-ID: <xmqqo82ohwih.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1978C578-9A70-11EC-94B4-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Refactor the repository setup code for tests that test hooks the use
> of sub-shells when setting up the test repository and hooks.
>
> A subsequent commit will change the hook setup to use a helper that
> makes use of "test_when_finished", which cannot be used in
> sub-shells. Let's change that setup code, and the adjacent and similar
> "mk_empty" code.

Makes sense.

> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
> index 1a20e54adc1..e4bb7581568 100755
> --- a/t/t5516-fetch-push.sh
> +++ b/t/t5516-fetch-push.sh
> @@ -24,12 +24,8 @@ D=3D$(pwd)
>  mk_empty () {
>  	repo_name=3D"$1"
>  	rm -fr "$repo_name" &&
> -	mkdir "$repo_name" &&
> -	(
> -		cd "$repo_name" &&
> -		git init &&
> -		git config receive.denyCurrentBranch warn
> -	)
> +	git init "$repo_name" &&
> +	git -C "$repo_name" config receive.denyCurrentBranch warn
>  }

I thought of this exact change when I saw a change to this part in
this series in an earlier step.  Excellent.


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60A5C4332F
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 18:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbiBUS1q (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 13:27:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232602AbiBUSYo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 13:24:44 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E19140EC
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 10:19:29 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C3FFE182774;
        Mon, 21 Feb 2022 13:19:28 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=PDU/GkVlbfJC
        B84GZS5jNTnC1ZSrMd8vzWaMjiCMQTc=; b=nLRhDHTjmzFhtMoGKMrBe51Z5ulp
        DT4xycqeZ+XOPOx8/8iDrPvtxDmMUdhaVUJyzTVlqBK3aYt4Piuxvy6M7nsd8sy7
        MVFKPM3TqeOpFByLmkZCVXBs0ugxPvNqQ1GTx0pQ8g8VYieFjQak5fi5vi363bcL
        PZWJCr57WxP7CRQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A6978182773;
        Mon, 21 Feb 2022 13:19:28 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 01136182770;
        Mon, 21 Feb 2022 13:19:25 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] ls-files: support --recurse-submodules --stage
References: <20220218223212.1139366-1-jonathantanmy@google.com>
        <220219.868ru7fsad.gmgdl@evledraar.gmail.com>
Date:   Mon, 21 Feb 2022 10:19:24 -0800
In-Reply-To: <220219.868ru7fsad.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sat, 19 Feb 2022 04:11:30 +0100")
Message-ID: <xmqqk0dot74j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CD1FC19C-9342-11EC-98D1-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> This test though will break, as you can see with:
>
>     GIT_TEST_DEFAULT_HASH=3Dsha256 ./t3007-ls-files-recurse-submodules.=
sh
>
> So you'll need at least something like:
>
> diff --git a/t/t3007-ls-files-recurse-submodules.sh b/t/t3007-ls-files-=
recurse-submodules.sh
> index 3d2da360d17..0fe69da8dcf 100755
> --- a/t/t3007-ls-files-recurse-submodules.sh
> +++ b/t/t3007-ls-files-recurse-submodules.sh
> @@ -42,10 +42,10 @@ test_expect_success '--stage' '
>  	echo brigddsv >submodule/c &&
>  	git -C submodule commit -am "update c again" &&
> =20
> -	cat >expect <<-\EOF &&
> -	100644 6da7 0	.gitmodules
> -	100644 7898 0	a
> -	100644 6178 0	b/b
> +	cat >expect <<-EOF &&
> +	100644 $(git rev-parse --short=3D4 HEAD:.gitmodules) 0	.gitmodules
> +	100644 $(git rev-parse --short=3D4 HEAD:a) 0	a
> +	100644 $(git rev-parse --short=3D4 HEAD:b/b) 0	b/b
>  	100644 dead9 0	submodule/c
>  	EOF
> =20
> But then the problem is that one is dead9 and the other dead6, I was
> just trying to find 4-char prefixes.
>
> But having indulged in all that, I'm now entirely confused about why an=
y
> of this needs to be tested here.
>
> You're adding --stage, which will give us --stage-y output, and it was
> previously incompatible with --recurse-submodules. Having the two
> combine is good!

I think what this is trying to make sure is that it (1) enabled the
combination and (2) uses the object store of the submodule when
disambiguating names of the objects from the submodule, because the
author suspects that the reason why these two options were made
incompatible in the first place was because long time ago there
wasn't a way to ask "here is an object name---please uniquify in the
context of _that_ repository".  So it is understandable to prepare
an object X in a submodule and another object Y in the superproject,
such that the abbreviated name of X in the context of the submodule
is different from the abbreviated name of X in the context of the
superproject (i.e. if X were in the superproject's object store,
because the object names of X and Y share the prefix, it may require
longer prefix to disambiguate from Y), and make sure that the uniquify
is indeed happening in the context of the submodule.

So, you are only concentrating on (1) but forgetting why the author
wants (2).

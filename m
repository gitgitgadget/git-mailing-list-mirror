Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C7DBC43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 20:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237368AbiF3Uwd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 16:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237307AbiF3Uw1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 16:52:27 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94493878A
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 13:52:26 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5EDC01A867E;
        Thu, 30 Jun 2022 16:52:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Wjk1mOvolp3u
        1gyazgIT4l79KFAHd1bgWwyxqcIF2F4=; b=nsK7Cer+WeQo6D9nxfkJ2yf0SD6S
        Bn8IS0w26v/zjHGlvNZDPYdZYju34aCF+Mvr/NEl0wzD5JZsW1gdPZbNnXap79Iy
        kkPYbgVF5BxRt3VvjFvw8Abm7zqgRCgwu07s/LvXhYMRQdPIEHEuUz0kLoDPHaP4
        Mi9Iw1LRjfMdirA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 569B91A867D;
        Thu, 30 Jun 2022 16:52:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CE0C21A867B;
        Thu, 30 Jun 2022 16:52:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        rsbecker@nexbridge.com,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/3] config tests: fix harmless but broken "rm -r"
 cleanup
References: <cover-0.3-00000000000-20220621T221928Z-avarab@gmail.com>
        <cover-v2-0.3-00000000000-20220630T101646Z-avarab@gmail.com>
        <patch-v2-3.3-d3f65326701-20220630T101646Z-avarab@gmail.com>
Date:   Thu, 30 Jun 2022 13:52:21 -0700
In-Reply-To: <patch-v2-3.3-d3f65326701-20220630T101646Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 30 Jun
 2022 12:18:36
        +0200")
Message-ID: <xmqq8rpdeuwq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8A3C9B14-F8B6-11EC-B751-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> diff --git a/t/t1300-config.sh b/t/t1300-config.sh
> index d3d9adbb3db..c6661e61af5 100755
> --- a/t/t1300-config.sh
> +++ b/t/t1300-config.sh
> @@ -2083,12 +2083,13 @@ test_expect_success '--show-scope with --show-o=
rigin' '
>  '
> =20
>  test_expect_success 'override global and system config' '
> -	test_when_finished rm -f "$HOME"/.config/git &&
> -
> +	test_when_finished rm -f \"\$HOME\"/.gitconfig &&

This does look more correct than the original.

>  	cat >"$HOME"/.gitconfig <<-EOF &&
>  	[home]
>  		config =3D true
>  	EOF
> +
> +	test_when_finished rm -rf \"\$HOME\"/.config/git &&
>  	mkdir -p "$HOME"/.config/git &&
>  	cat >"$HOME"/.config/git/config <<-EOF &&
>  	[xdg]

Nicely done.  Will queue.

Thanks.

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3DD7C001DF
	for <git@archiver.kernel.org>; Mon, 17 Jul 2023 16:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjGQQXR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Jul 2023 12:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjGQQXB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2023 12:23:01 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8DB130
        for <git@vger.kernel.org>; Mon, 17 Jul 2023 09:23:00 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BFBE51A7896;
        Mon, 17 Jul 2023 12:22:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=yHRXbLAIhin/
        trgRqXnIs39+obkpHXWaJWO4fE+ko9k=; b=E74OIyBWs7RHAvQu5IXRUrqMn3R0
        B9ROoVXbJZh18k5wD0dGnN10howyWiGBFa1NZPbZ8Kb5Hpu6Wg4sJ/27nShOe7l/
        wjme4Eqr68uoSW2aIsVoBivPxqclapOp0eG2APzgo5dG5rtENadUnfsImuZey6gB
        4HkLoLYdNWX29k0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B7B8D1A7895;
        Mon, 17 Jul 2023 12:22:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 28EE61A7894;
        Mon, 17 Jul 2023 12:22:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>,
        Kousik Sanagavarapu <five231003@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Jaydeep Das <jaydeepjd.8914@gmail.com>,
        Nsengiyumva Wilberforce <nsengiyumvawilberforce@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] t6300: fix setup with GPGSSH but without GPG
References: <cbc22750-af93-9274-2ed4-6dfd356568e8@web.de>
Date:   Mon, 17 Jul 2023 09:22:55 -0700
In-Reply-To: <cbc22750-af93-9274-2ed4-6dfd356568e8@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sun, 16 Jul 2023 10:17:35 +0200")
Message-ID: <xmqqwmyyik2o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2FF2FFA6-24BE-11EE-AD17-307A8E0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> In a test introduced by 26c9c03f0a (ref-filter: add new "signature"
> atom, 2023-06-04) the file named "file" is added by a setup step that
> requires GPG and modified by a second setup step that requires GPGSSH.
> Systems lacking the first prerequisite skip the initial setup step and
> then "git commit -a" in the second one doesn't find the modified file.
> Add it explicitly.
>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
>  t/t6300-for-each-ref.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Thanks for good eyes.

I guess a box without GPG is not so uncommon, and even such a box
can reasonably be expected to have SSH on it, so I would believe if
this was discovered on a real development box, but is that how you
found this?  Or have you invented a nice test helper that lets you
pick random set of prerequisites and try permutations of having and
not having them, or something nice like that?

Will queue.

> diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
> index 6e6ec852b5..1180c3254c 100755
> --- a/t/t6300-for-each-ref.sh
> +++ b/t/t6300-for-each-ref.sh
> @@ -1584,7 +1584,8 @@ test_expect_success GPGSSH 'setup for signature a=
tom using ssh' '
>  	test_config user.signingkey "${GPGSSH_KEY_PRIMARY}" &&
>  	echo "8" >file &&
>  	test_tick &&
> -	git commit -a -S -m "file: 8" &&
> +	git add file &&
> +	git commit -S -m "file: 8" &&
>  	git tag eighth-signed-ssh
>  '
>
> --
> 2.41.0

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF37FC433ED
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 23:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A00961076
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 23:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbhCaXfr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 19:35:47 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51265 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232741AbhCaXf3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 19:35:29 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 17BEE125074;
        Wed, 31 Mar 2021 19:35:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=AjIkmXlUSP6I
        YSqv4U+vtF8B14w=; b=K7kdV0BmodVUP7veNtYtVgWJOsUfK0KVGE4mnOeXQEUv
        imFGWbL/Q7FXiBP88Zm0UM5O+T9rzJIEybZcJYLsavchikxsHIjpZmX2skhSd2kE
        DowWNU2QXX7CV1anGB63zTB/MtahlbXP5Osd3e9bZYeHS+7xnIjnbgU2TKEIryo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=IWvjHB
        XFv2kHEccpHSfkvoRl2MTWyaZ/BnLNuiar7xva+JlxxKAkD5yuGUA28dBWan9z4z
        b2JAtYuuRDqwPciZbnApgZfyC1IHWoGOoqF10Je2XDWtvL73tobFH8L1N7YugzB5
        R20gMvTVHTabUz8AwWhhCwl+wMoQ7b7fXORpc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 109B4125073;
        Wed, 31 Mar 2021 19:35:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4268A125071;
        Wed, 31 Mar 2021 19:35:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v5 11/18] match-trees: use "tmp" for mode in
 shift_tree_by()
References: <87o8fcqrg8.fsf@evledraar.gmail.com>
        <cover-00.19-00000000000-20210331T190531Z-avarab@gmail.com>
        <patch-11.19-e190ed39754-20210331T190531Z-avarab@gmail.com>
Date:   Wed, 31 Mar 2021 16:35:24 -0700
In-Reply-To: <patch-11.19-e190ed39754-20210331T190531Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 31 Mar
 2021 21:09:39
        +0200")
Message-ID: <xmqqo8ey522r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C53EE176-9279-11EB-959D-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Refactor code added in 85e51b783c3 (Make "subtree" part more
> orthogonal to the rest of merge-recursive., 2008-06-30) to make it
> obvious that we don't care about the "mode" here outside of the if
> statement it appears in.

OK.

>
> That's opposed to the sub1 & sub2 variables, where we use the two
> object ids later in this function.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  match-trees.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/match-trees.c b/match-trees.c
> index a6796de442d..bdd16adb70a 100644
> --- a/match-trees.c
> +++ b/match-trees.c
> @@ -317,17 +317,17 @@ void shift_tree_by(struct repository *r,
>  		   const char *shift_prefix)
>  {
>  	struct object_id sub1, sub2;
> -	unsigned short mode1, mode2;
> +	unsigned short tmp;
>  	unsigned candidate =3D 0;
> =20
>  	/* Can hash2 be a tree at shift_prefix in tree hash1? */
> -	if (!get_tree_entry(r, hash1, shift_prefix, &sub1, &mode1) &&
> -	    S_ISDIR(mode1))
> +	if (!get_tree_entry(r, hash1, shift_prefix, &sub1, &tmp) &&
> +	    S_ISDIR(tmp))
>  		candidate |=3D 1;
> =20
>  	/* Can hash1 be a tree at shift_prefix in tree hash2? */
> -	if (!get_tree_entry(r, hash2, shift_prefix, &sub2, &mode2) &&
> -	    S_ISDIR(mode2))
> +	if (!get_tree_entry(r, hash2, shift_prefix, &sub2, &tmp) &&
> +	    S_ISDIR(tmp))
>  		candidate |=3D 2;
> =20
>  	if (candidate =3D=3D 3) {

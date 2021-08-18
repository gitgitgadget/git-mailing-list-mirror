Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F1FEC4338F
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 20:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0237160ED3
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 20:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbhHRUaq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Aug 2021 16:30:46 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61675 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbhHRUap (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Aug 2021 16:30:45 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8C9C915F16A;
        Wed, 18 Aug 2021 16:30:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=LIMs5IL39fF1
        2PA/cHIgsdDcNtHTw1YcCAT0dJmDYs4=; b=JqXvSs8rEgVvS4oX2be6uTvX5yqP
        nWKGxaDIBQuiIDAxHd/VIklX3j1IYoVZld4C1ipYC1R41Iz2Ke4bmX+2Fs40GjOz
        HpTryOul0FaC53+dhuX3JfKdXZS6BsnIaT9/AGlkwaVpuk2GMdNwbP1h+Va4rtiB
        zdmORJqgzkKRzvs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 859C415F169;
        Wed, 18 Aug 2021 16:30:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BE45E15F168;
        Wed, 18 Aug 2021 16:30:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     Thomas De Zeeuw <thomas@slight.dev>, git@vger.kernel.org
Subject: Re: Bug: Segmentation fault in git diff
References: <40BE2EF2-0AF3-45BA-9880-8A6011B38D03@slight.dev>
        <YRzkq47gOGfn8zsw@danh.dev> <YR0CkdVNVKa65vbo@danh.dev>
Date:   Wed, 18 Aug 2021 13:30:05 -0700
In-Reply-To: <YR0CkdVNVKa65vbo@danh.dev> (=?utf-8?B?IsSQb8OgbiBUcuG6p24g?=
 =?utf-8?B?Q8O0bmc=?= Danh"'s message of
        "Wed, 18 Aug 2021 19:52:33 +0700")
Message-ID: <xmqq5yw25wdu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1357F396-0063-11EC-8BF7-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

> This diff could fix the issue, and the test suite still passes:
>
> ---- 8< ----
>
> diff --git a/diff-lib.c b/diff-lib.c
> index f9eadc4fc1..8f303958dd 100644
> --- a/diff-lib.c
> +++ b/diff-lib.c
> @@ -192,7 +192,7 @@ int run_diff_files(struct rev_info *revs, unsigned =
int option)
>  			 * from the desired stage.
>  			 */
>  			pair =3D diff_unmerge(&revs->diffopt, ce->name);
> -			if (wt_mode)
> +			if (pair && wt_mode)
>  				pair->two->mode =3D wt_mode;
>  			if (ce_stage(ce) !=3D diff_unmerged_stage)
>  				continue;
> ---- >8 -----

Looks sensible. =20

The bug is the result of a bad interaction between cd676a51 (diff
--relative: output paths as relative to the current subdirectory,
2008-02-12) that decided to return NULL from diff_unmerge for an
irrelevant path outside the --relative area, and 095ce953
(diff-files: show unmerged entries correctly, 2011-04-22) that
assumed diff_unmerge() would always yield a usable unmerged pair.

As the NULL pair would never be added to the diff_queue(), when the
big loop around this area of code finishes and hands the processing
off to diffcore_std(), the mode futzing the original code was
attempting to do would have affected absolutely nothing, so I do not
think there would be any subtle breakage coming from this fix.

When you submit an "git am"-able patch, please have my Acked-by.

Thanks.

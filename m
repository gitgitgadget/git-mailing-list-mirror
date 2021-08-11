Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED733C4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 19:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABE4260F35
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 19:35:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbhHKTfp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 15:35:45 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54503 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbhHKTfo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 15:35:44 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 757E1E3D57;
        Wed, 11 Aug 2021 15:35:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=83uayFQneWGD
        ViFLHl+JazVIwsnNY1m/Wj8Vyoef+I4=; b=wdcjxMQ7LSodukbAruPCtwOaOGiQ
        53XW9VHBQI+wLziaMaNxlH8hNlu2gYPJnDcNicp24US+CykCy7kpLThShaPMEWTm
        23yrc69OC0JQR59xfjVl5f17MOadno6i4dRUs2DZfVFTapqCe7boHIEEfyWmCT2a
        TXXnjLSISh3/DQ4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6D57EE3D55;
        Wed, 11 Aug 2021 15:35:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 03DBBE3D54;
        Wed, 11 Aug 2021 15:35:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ville =?utf-8?Q?Skytt=C3=A4?= <ville.skytta@iki.fi>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH] completion: avoid config variable name lookup error in
 nounset mode
References: <20210811191637.775693-1-ville.skytta@iki.fi>
Date:   Wed, 11 Aug 2021 12:35:19 -0700
In-Reply-To: <20210811191637.775693-1-ville.skytta@iki.fi> ("Ville
 =?utf-8?Q?Skytt=C3=A4=22's?=
        message of "Wed, 11 Aug 2021 22:16:37 +0300")
Message-ID: <xmqqfsvf93m0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4363D1B4-FADB-11EB-85F0-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ville Skytt=C3=A4 <ville.skytta@iki.fi> writes:

> Config variable name lookup accesses the `sfx` variable before it has

The above sounds as if the function always makes an access to an
uninitialized variable, which puzzled me.  The problem exists only
when called from some callers that do not use the --sfx=3DX option,
which may be worth mentioning.

I see that, ever since the helper function was introduced at e1e00089
(completion: complete configuration sections and variable names for
'git -c', 2019-08-13), it would have upset 'set -u' when the caller
does not pass --sfx=3DX option, and even in that original version,
there was such a caller (the original author Cc'ed).

And the fix looks trivially correct.

I'll be busy preparing the -rc2 today, and will not be queuing this
patch right now, though.  As this is not a recent regression, waiting
for the current release cycle to be over and sending a reroll later
next week would be greatly appreciated.

Thanks.

> been set, causing an error in "nounset" mode. Initialize to an empty
> string to avoid that.
>
>     $ git config submodule.<Tab>bash: sfx: unbound variable
>
> Signed-off-by: Ville Skytt=C3=A4 <ville.skytta@iki.fi>
> ---
>  contrib/completion/git-completion.bash | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
> index 4bdd27ddc8..ecc9352755 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2631,7 +2631,7 @@ __git_complete_config_variable_value ()
>  #                 subsections) instead of the default space.
>  __git_complete_config_variable_name ()
>  {
> -	local cur_=3D"$cur" sfx
> +	local cur_=3D"$cur" sfx=3D""
> =20
>  	while test $# !=3D 0; do
>  		case "$1" in

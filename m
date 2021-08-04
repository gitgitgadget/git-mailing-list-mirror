Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B5EC4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 01:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29FC160524
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 01:16:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbhHDBRE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 21:17:04 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50730 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbhHDBRD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 21:17:03 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C8F9CDBED6;
        Tue,  3 Aug 2021 21:16:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ggV9rIKzTJYz
        7s/PqUlHUDUV1atf+ODUjUA9fBxFMOg=; b=v0Jjko3XMWnaSTI7KKweK1OqIpoS
        bqO186OYxqZHpL4t+N8fzDtvfMD/7MMzifPgbcNImrpbdR2pbwBYrVtu/+yH5TZT
        X3jGc/1cYGEUnVovaB+7xluEsCVC3CEDEcpTp/ad9luIr7Q3uGIHjmv9XBgVwMPm
        Cyv4CXxNVK8csNE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C0FB4DBED5;
        Tue,  3 Aug 2021 21:16:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4F55ADBED4;
        Tue,  3 Aug 2021 21:16:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
Cc:     avarab@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH v2] clone: Allow combining --bare and --origin
References: <8735rsqlal.fsf@evledraar.gmail.com>
        <20210802174944.53745-1-oystwa@gmail.com>
Date:   Tue, 03 Aug 2021 18:16:49 -0700
In-Reply-To: <20210802174944.53745-1-oystwa@gmail.com> (=?utf-8?Q?=22?=
 =?utf-8?Q?=C3=98ystein?= Walle"'s
        message of "Mon, 2 Aug 2021 19:49:44 +0200")
Message-ID: <xmqqzgtyqa9q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A543350C-F4C1-11EB-B8C1-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=98ystein Walle <oystwa@gmail.com> writes:

> diff --git a/t/t5606-clone-options.sh b/t/t5606-clone-options.sh
> index 3a595c0f82..c40dde816d 100755
> --- a/t/t5606-clone-options.sh
> +++ b/t/t5606-clone-options.sh
> @@ -30,12 +30,12 @@ test_expect_success 'rejects invalid -o/--origin' '
> =20
>  '
> =20
> -test_expect_success 'disallows --bare with --origin' '
> -
> -	test_must_fail git clone -o foo --bare parent clone-bare-o 2>err &&
> -	test_debug "cat err" &&
> -	test_i18ngrep -e "--bare and --origin foo options are incompatible" e=
rr
> +test_expect_success '--bare works with -o/--origin' '
> =20
> +	git clone --bare --origin=3Dsomewhere parent clone-bare &&
> +	url=3D"$(git -C clone-bare config --local remote.somewhere.url)" &&
> +	test -n "$url" &&
> +	test_must_fail git -C clone-bare config --local remote.origin.url
>  '

This breaks a later step that creates clone-bare as this used to use
clone-bare-o and the name was available.

Using clone-bare-o as it used to would probably be the easiest fix.

> =20
>  test_expect_success 'disallows --bare with --separate-git-dir' '

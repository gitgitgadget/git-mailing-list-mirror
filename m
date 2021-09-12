Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6DE3C433EF
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 21:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A681561056
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 21:48:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236533AbhILVto (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Sep 2021 17:49:44 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58964 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233942AbhILVtn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Sep 2021 17:49:43 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 28E03DFE03;
        Sun, 12 Sep 2021 17:48:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=/Sd+EXZl7daz
        Wp5HSVQdi/k0bd9+a/jpYifU2P3OAlg=; b=MomFxioGB6hWkHMDtXsfquOo3XDH
        2UiB1zBIj3c3bamW00j8rbnoQclTwrdXpMNRMWvThW4NAnS2bZDEEwPecg6Nl4nK
        sTEhlgGobNAfSCOvQn6qF0BLH7uyT+c+T/VfauVaPIizLkr37gIGvfTvjR+tf8GX
        q4hIcQ2vabvQwHo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 211E6DFE00;
        Sun, 12 Sep 2021 17:48:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9D77FDFDFD;
        Sun, 12 Sep 2021 17:48:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Carlo Arenas <carenas@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 1/6] credential-cache{,--daemon}: don't build under
 NO_UNIX_SOCKETS
References: <cover-v2-0.6-00000000000-20210910T153146Z-avarab@gmail.com>
        <cover-v3-0.6-00000000000-20210911T190239Z-avarab@gmail.com>
        <patch-v3-1.6-ad857e80fd8-20210911T190239Z-avarab@gmail.com>
Date:   Sun, 12 Sep 2021 14:48:27 -0700
In-Reply-To: <patch-v3-1.6-ad857e80fd8-20210911T190239Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sat, 11 Sep
 2021 21:09:00
        +0200")
Message-ID: <xmqqczpdlb2s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 299B6778-1413-11EC-98A2-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> @@ -1693,6 +1695,7 @@ ifdef NO_INET_PTON
>  endif
>  ifdef NO_UNIX_SOCKETS
>  	BASIC_CFLAGS +=3D -DNO_UNIX_SOCKETS
> +	EXCLUDED_PROGRAMS +=3D git-credential-cache git-credential-cache--dae=
mon

Yah, I forgot about EXCLUDED_PROGRAMS ;-) =20

Sounds like a sensible direction to go.

> diff --git a/git.c b/git.c
> index 18bed9a9964..7c696e06ecf 100644
> --- a/git.c
> +++ b/git.c
> @@ -513,8 +513,10 @@ static struct cmd_struct commands[] =3D {
>  	{ "config", cmd_config, RUN_SETUP_GENTLY | DELAY_PAGER_CONFIG },
>  	{ "count-objects", cmd_count_objects, RUN_SETUP },
>  	{ "credential", cmd_credential, RUN_SETUP_GENTLY | NO_PARSEOPT },
> +#ifndef NO_UNIX_SOCKETS
>  	{ "credential-cache", cmd_credential_cache },
>  	{ "credential-cache--daemon", cmd_credential_cache_daemon },
> +#endif
>  	{ "credential-store", cmd_credential_store },
>  	{ "describe", cmd_describe, RUN_SETUP },
>  	{ "diff", cmd_diff, NO_PARSEOPT },

OK.  Looks good.

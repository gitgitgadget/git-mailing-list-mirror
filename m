Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1711BC4332F
	for <git@archiver.kernel.org>; Sat, 23 Apr 2022 04:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbiDWE1S (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Apr 2022 00:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232731AbiDWE1R (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Apr 2022 00:27:17 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0966D302
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 21:24:19 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 27DB9185BF6;
        Sat, 23 Apr 2022 00:24:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=rgdCyOw8/Bkgavbz9VkZSXS+V
        uzOIozJhRu4vdCq7Cw=; b=hjodmmUYMwVZjKS1MHr2UG7X9gCfLkYW9weFjIzMr
        QQZLwsursx8OenQ5UWHABmWdNgCFBM5Jank7FkTNv74V4FUTp/dl1UY4OKCeu7UM
        nEMWIoyAtBdIk6CeJ6T4e5eXd9AeH5p4Pi92fZcp8uCfN18Xoad7QQ/NNjWKiuMD
        gs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1FF0D185BF5;
        Sat, 23 Apr 2022 00:24:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A1346185BF3;
        Sat, 23 Apr 2022 00:24:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Anthony Sottile <asottile@umich.edu>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 1/6] run-command API: replace
 run_processes_parallel_tr2() with opts struct
References: <CA+dzEBn108QoMA28f0nC8K21XT+Afua0V2Qv8XkR8rAeqUCCZw@mail.gmail.com>
        <cover-0.6-00000000000-20220421T122108Z-avarab@gmail.com>
        <patch-1.6-8bf71ce63dd-20220421T122108Z-avarab@gmail.com>
Date:   Fri, 22 Apr 2022 21:24:14 -0700
Message-ID: <xmqq7d7g4ec1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3C3B77F2-C2BD-11EC-BED7-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

>  	if (max_children !=3D 1 && list->nr !=3D 1) {
>  		struct parallel_fetch_state state =3D { argv.v, list, 0, 0 };
> +		struct run_process_parallel_opts run_opts =3D {
> +			.tr2_category =3D "fetch",
> +			.tr2_label =3D "parallel/fetch",
> +		};
> =20
>  		strvec_push(&argv, "--end-of-options");
> -		result =3D run_processes_parallel_tr2(max_children,
> -						    &fetch_next_remote,
> -						    &fetch_failed_to_start,
> -						    &fetch_finished,
> -						    &state,
> -						    "fetch", "parallel/fetch");
> +		result =3D run_processes_parallel(max_children,
> +						&fetch_next_remote,
> +						&fetch_failed_to_start,
> +						&fetch_finished, &state,
> +						&run_opts);

If the idea is that with unset .tr2_* members we can silently bypass
the overhead to invoke trace2 machinery without changing much in the
caller side (or even better, instead of doing this as run_opts but
as tr2_opts, and allow the caller to pass NULL to decline tracing at
runtime), that would be wonderful.

If we are going to throw random other members into the struct that
are unrelated to tr2, then it makes it unclear why we have the three
*_fn and its callback state still passed as separate parameters,
rather than making them members of the struct.  After all, it is
clear that this new struct is designed to be used only with the
run_process_parallel() API, so it is doubly dubious why these three
*_fn and callback state are not members.

So, I dunno. =20

Either

 (1) making it to very clear that this is only about trace2 and name
     the type as such, or

 (2) making it about run_process_parallel (and keep the name), and
     move the *_fn parameters to it (which will allow us to add more
optional callbacks if needed),

would make it better (simply by clarifying why we have this extra
structure and what it is meant to be used for), but the interface as
posted is halfway between the two, and does not look well suited for
either purpose, making the reader feel somewhat frustrating.



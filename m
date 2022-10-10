Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179AEC433FE
	for <git@archiver.kernel.org>; Mon, 10 Oct 2022 18:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiJJSNj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 14:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiJJSNh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 14:13:37 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C82E63F37
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 11:13:36 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 349D415D55E;
        Mon, 10 Oct 2022 14:13:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=WavWeZRv8TFi
        q1GHk2SpLto79HUjKOwbgKia7lHxhOo=; b=W9Hh1jiAexzf9G7rkkHpb4r1cnEs
        u/v9C6deKlltgxxMlr8/Ywu50qd/thp3vDMo5q7cBM0RGqsNTguFDQaz5Zg+3gw9
        NuuKMgqsM4KtTk04M9rz6rSdN21dGx7R/LTnvUbULbbmZbHgi1OHj4qHAO8WuntC
        YL9pQ9oubF3Icu8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2D4F715D55D;
        Mon, 10 Oct 2022 14:13:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9637F15D55A;
        Mon, 10 Oct 2022 14:13:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2] config.mak.dev: disable suggest braces error on old
 clang versions
References: <pull.1375.git.1665085395.gitgitgadget@gmail.com>
        <pull.1375.v2.git.1665416340806.gitgitgadget@gmail.com>
Date:   Mon, 10 Oct 2022 11:13:34 -0700
In-Reply-To: <pull.1375.v2.git.1665416340806.gitgitgadget@gmail.com> (Jeff
        Hostetler via GitGitGadget's message of "Mon, 10 Oct 2022 15:39:00
        +0000")
Message-ID: <xmqqo7uj35td.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 41B36AD8-48C7-11ED-97F5-307A8E0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:

>     Here is version 2. This version adds the "-Wno-missing-braces" comp=
iler
>     flag when we are using an old version of clang -- rather than updat=
ing
>     the source files to use the "{{0}}" syntax that was expected by old=
er
>     versions of clang.
>    =20
>     I've expanded the scope to include fixes for Apple's clang 11 and b=
elow
>     and non-Apple clang 8 and below.
>
> diff --git a/config.mak.dev b/config.mak.dev
> index 4fa19d361b7..981304727c5 100644
> --- a/config.mak.dev
> +++ b/config.mak.dev
> @@ -69,6 +69,31 @@ DEVELOPER_CFLAGS +=3D -Wno-missing-braces
>  endif
>  endif
> =20
> +# Old versions of clang complain about initializaing a
> +# struct-within-a-struct using just "{0}" rather than "{{0}}".  This
> +# error is considered a false-positive and not worth fixing, because
> +# new clang versions do not, so just disable it.
> +#
> +# The "bug" was fixed in upstream clang 9.
> +#
> +# Complicating this is that versions of clang released by Apple have
> +# their own version numbers (associated with the corresponding version
> +# of XCode) unrelated to the official clang version numbers.
> +#
> +# The bug was fixed in Apple clang 12.
> +#
> +ifneq ($(filter clang1,$(COMPILER_FEATURES)),)     # if we are using c=
lang
> +ifeq ($(uname_S),Darwin)                           # if we are on darw=
in
> +ifeq ($(filter clang12,$(COMPILER_FEATURES)),)     # if version < 12
> +DEVELOPER_CFLAGS +=3D -Wno-missing-braces
> +endif
> +else                                               # not darwin
> +ifeq ($(filter clang9,$(COMPILER_FEATURES)),)      # if version < 9
> +DEVELOPER_CFLAGS +=3D -Wno-missing-braces
> +endif
> +endif
> +endif

Looks very straight-forward, albeit a tad verbose, and simple to
follow.  I think this is equivalent to Ren=C3=A9's original one-liner.

Will queue.  Thanks.

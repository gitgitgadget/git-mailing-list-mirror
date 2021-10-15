Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53196C433EF
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 17:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2281861164
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 17:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242036AbhJORXW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 13:23:22 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50776 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242179AbhJORXV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 13:23:21 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2F0DC164E61;
        Fri, 15 Oct 2021 13:21:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=g6zqYpWVir7F
        d2nM9LULriJMAVTE7X+8y6ghmJOXMIA=; b=mq3rtaXvupuY6uvj1MjSuci48Z9i
        wwpIOdmVYHNcb5fhs6iVkvENLhfWkOIMHw3yRTO41VocdjpPa5yzkeuFxUC9S9QI
        LqLtw37cq14VUTSarTyNi/yXY/46gwQ4OzFYoNSpgjOf5TaW4lK55P1L9IzI17B3
        SWdNa1lxK5PM8fA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 28A35164E60;
        Fri, 15 Oct 2021 13:21:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 804DB164E5F;
        Fri, 15 Oct 2021 13:21:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/4] doc build: speed up "make lint-docs"
References: <cover-0.4-00000000000-20211015T123619Z-avarab@gmail.com>
        <patch-3.4-a02a668ebb3-20211015T123619Z-avarab@gmail.com>
Date:   Fri, 15 Oct 2021 10:21:11 -0700
In-Reply-To: <patch-3.4-a02a668ebb3-20211015T123619Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 15 Oct
 2021 14:39:13 +0200")
Message-ID: <xmqqk0ie6w6w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4B8F3566-2DDC-11EC-8C9B-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Extend the trick we use to speed up the "clean" target to also extend
> to the "lint-docs" target. See 54df87555b1 (Documentation/Makefile:
> conditionally include doc.dep, 2020-12-08) for the "clean"
> implementation.
>
> The "doc-lint" target only depends on *.txt files, so we don't need to
> generate GIT-VERSION-FILE etc. if that's all we're doing. This makes
> the "make lint-docs" target more than 2x as fast:

Nice. 0.2s down to 0.1 is a 2x speedup.

> $ git show HEAD~:Documentation/Makefile >Makefile.old
> $ hyperfine -L f ",.old" 'make -f Makefile{f} lint-docs'
> Benchmark #1: make -f Makefile lint-docs
>   Time (mean =C2=B1 =CF=83):     100.2 ms =C2=B1   1.3 ms    [User: 93.=
7 ms, System: 6.7 ms]
>   Range (min =E2=80=A6 max):    98.4 ms =E2=80=A6 103.1 ms    29 runs
>
> Benchmark #2: make -f Makefile.old lint-docs
>   Time (mean =C2=B1 =CF=83):     220.0 ms =C2=B1  20.0 ms    [User: 206=
.0 ms, System: 18.0 ms]
>   Range (min =E2=80=A6 max):   206.6 ms =E2=80=A6 267.5 ms    11 runs
>
> Summary
>   'make -f Makefile lint-docs' ran
>     2.19 =C2=B1 0.20 times faster than 'make -f Makefile.old lint-docs'
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  Documentation/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 78324934d9f..e8e54e053a6 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -284,7 +284,7 @@ install-html: html
>  ../GIT-VERSION-FILE: FORCE
>  	$(QUIET_SUBDIR0)../ $(QUIET_SUBDIR1) GIT-VERSION-FILE
> =20
> -ifneq ($(MAKECMDGOALS),clean)
> +ifneq ($(filter-out lint-docs clean,$(MAKECMDGOALS)),)
>  -include ../GIT-VERSION-FILE
>  endif

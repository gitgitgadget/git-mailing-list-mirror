Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB7CC433ED
	for <git@archiver.kernel.org>; Tue, 11 May 2021 07:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAFBA616EB
	for <git@archiver.kernel.org>; Tue, 11 May 2021 07:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbhEKHEu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 03:04:50 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60198 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhEKHEr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 03:04:47 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B04E311A2DB;
        Tue, 11 May 2021 03:03:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=c3tnLYwMwGsE
        60QQnHb9K8vc6KipYjV3hILR8sSrlHE=; b=eSgSQgrzBIh8HOtYX4v3vw0CrrJz
        ptUICvsw5oFcy/kB8refQzV4idxq+45ZpZcYgU5FpGH5ErkEgbQNtVHwUEmZo9rC
        Uyy5p8S2pHQzjjk088QGGTBLaeYg5gYeWs6jQOqWzsrKTImZSpMVKJAfOtklTLEN
        73TARqUeuQsuYWY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A83B011A2DA;
        Tue, 11 May 2021 03:03:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D7CB111A2D9;
        Tue, 11 May 2021 03:03:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Denton Liu <liu.denton@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH] trace2: refactor to avoid gcc warning under -O3
References: <20200404142131.GA679473@coredump.intra.peff.net>
        <patch-1.1-87d9bcf1095-20210505T083951Z-avarab@gmail.com>
Date:   Tue, 11 May 2021 16:03:35 +0900
In-Reply-To: <patch-1.1-87d9bcf1095-20210505T083951Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 5 May
 2021 10:40:32 +0200")
Message-ID: <xmqqv97pn454.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 01D2C7B6-B227-11EB-A414-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Refactor tr2_dst_try_uds_connect() to avoid a gcc warning[1] that
> appears under -O3 (but not -O2). This makes the build pass under
> DEVELOPER=3D1 without needing a DEVOPTS=3Dno-error.
>
> This can be reproduced with GCC Debian 8.3.0-6, but not e.g. with
> clang 7.0.1-8+deb10u2. We've had this warning since
> ee4512ed481 (trace2: create new combined trace facility, 2019-02-22).
>
> As noted in [2] this warning happens because the compiler doesn't
> assume that errno must be non-zero after a failed syscall. Let's work
> around it as suggested in that analysis. We now return -1 ourselves on
> error, and save away the value of errno in a variable the caller
> passes in.
>
> 1.
>
>     trace2/tr2_dst.c: In function =E2=80=98tr2_dst_get_trace_fd.part.5=E2=
=80=99:
>     trace2/tr2_dst.c:296:10: warning: =E2=80=98fd=E2=80=99 may be used =
uninitialized in this function [-Wmaybe-uninitialized]
>       dst->fd =3D fd;
>       ~~~~~~~~^~~~
>     trace2/tr2_dst.c:229:6: note: =E2=80=98fd=E2=80=99 was declared her=
e
>       int fd;
>           ^~
> 2. https://lore.kernel.org/git/20200404142131.GA679473@coredump.intra.p=
eff.net/
> ---
>  trace2/tr2_dst.c | 27 +++++++++++++++------------
>  1 file changed, 15 insertions(+), 12 deletions(-)

What's the concensus if any on this topic?

In any case, this needs to be signed off before it gets carved into
our history.

Thanks.

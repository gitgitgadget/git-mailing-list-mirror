Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C072C433EF
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 22:58:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238843AbiBYW7P (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 17:59:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiBYW7O (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 17:59:14 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C0DC186418
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 14:58:41 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5CE6E118768;
        Fri, 25 Feb 2022 17:58:40 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=9I1+Avhd8M3s
        +jm6yJ751yjhbYaTdBIO0xuJ7eao6l0=; b=i+ORX6HN3+sjlGKIS/lr9f6wnu9q
        28ivI3eXqPyw3Bxq2sgOO/7sY+84PGTwouWSnQ6DrNdZ1n3qxQTqZAyOgcy8u9pI
        IbmgioJB+plQkXHQP0M9QO6qjcYzGETAOmX9MmVGmUUVYC4tv5SeUCPX8RaiUc3I
        b3om9oqKbqbLlMc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 53269118767;
        Fri, 25 Feb 2022 17:58:40 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BD727118765;
        Fri, 25 Feb 2022 17:58:39 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2] http API: fix dangling pointer issue noted by GCC 12.0
References: <patch-1.1-1cec367e805-20220126T212921Z-avarab@gmail.com>
        <patch-v2-1.1-777838267a5-20220225T090816Z-avarab@gmail.com>
Date:   Fri, 25 Feb 2022 14:58:38 -0800
In-Reply-To: <patch-v2-1.1-777838267a5-20220225T090816Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 25 Feb
 2022 10:09:11
        +0100")
Message-ID: <xmqqsfs68sf5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 78CDF33A-968E-11EC-B246-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> The pre-release GCC 12.0 development branch has a new warning about
> dangling pointers in -Wall:
>
>     http.c: In function =E2=80=98run_active_slot=E2=80=99:
>     http.c:1332:24: error: storing the address of local variable =E2=80=
=98finished=E2=80=99 in =E2=80=98*slot.finished=E2=80=99 [-Werror=3Ddangl=
ing-pointer=3D]
>      1332 |         slot->finished =3D &finished;
>           |         ~~~~~~~~~~~~~~~^~~~~~~~~~~
>     http.c:1330:13: note: =E2=80=98finished=E2=80=99 declared here
>      1330 |         int finished =3D 0;
>           |             ^~~~~~~~
>
> This is on a locally built "gcc (GCC) 12.0.1 20220120 (experimental)",
> built from gcc.git's 8bc700f4c3f (Enhance vec_pack_trunc for integral
> mode mask., 2022-01-17).
>
> The GCC warning is specifically about pointers that survive the exit
> of the function. See a comment added to
> "pass_waccess::use_after_inval_p" in the GCC commit that added the
> warning, or:
>
>     /* The use is one of a dangling pointer if a clobber of the variabl=
e
>       [the pointer points to] has not been found before the function ex=
it
>       point.  */
>     [...]
>
> There's a few possible ways to fix this, but the simplest is to assign
> NULL to "slot->finished" at the end of run_active_slot(), it's the
> only caller that ever assigns non-NULL to it. It was suggested[2] to
> guard that with "if (slot->finished =3D=3D &finished)", but that'll sti=
ll
> trigger the warning.

Does that mean we can clobber the finished member of a slot that was
in use, not the one we prepared, because we do not make sure we do
not clobber slot->finished that other people set up?

I think this change is safe, but it's been quite a while since I
played with dumb HTTP walker the last time, so I no longer trust my
own reading of this code X-<.

> diff --git a/http.c b/http.c
> index 229da4d1488..2f67fbb33cd 100644
> --- a/http.c
> +++ b/http.c
> @@ -1367,6 +1367,7 @@ void run_active_slot(struct active_request_slot *=
slot)
>  			select(max_fd+1, &readfds, &writefds, &excfds, &select_timeout);
>  		}
>  	}
> +	slot->finished =3D NULL;
>  }

Will queue, but it would be nice if GCC can get fixed before we have
to advance this to 'next' and below

Thanks.
.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76343C433EF
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 19:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 522DB610EA
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 19:01:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238776AbhJMTDe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 15:03:34 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57249 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234061AbhJMTDc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 15:03:32 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1E80E14DB0C;
        Wed, 13 Oct 2021 15:01:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=kbwuDVG/fKMN
        VJld9cQP2f4NiohbM6gQnaZiKq4fxT8=; b=MnGTZTXXTEf8QtIlZlq0yzbiGqkr
        972jOw4APRrbjF1opwfk4urzfkjRI9pwCcnhxfNy0lsPh+IKhih8jc7aLs80qYI8
        X1njUqnUb7pNy2+m/L2aEgGbBMbSleYqfRWgGzQ0cKi25X7/N9alu7PUie9cXGuY
        L4TOiEd7n2rC2Ks=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F1E7714DB0B;
        Wed, 13 Oct 2021 15:01:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5B4AD14DB07;
        Wed, 13 Oct 2021 15:01:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 5/7] ls-files: fix a trivial dir_clear() leak
References: <cover-0.7-00000000000-20211006T095426Z-avarab@gmail.com>
        <cover-v2-0.7-00000000000-20211007T100014Z-avarab@gmail.com>
        <patch-v2-5.7-73cf1018953-20211007T100014Z-avarab@gmail.com>
        <xmqqily8o3kw.fsf@gitster.g> <8735p5hwg6.fsf@evledraar.gmail.com>
Date:   Wed, 13 Oct 2021 12:01:25 -0700
In-Reply-To: <8735p5hwg6.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Wed, 13 Oct 2021 15:39:55 +0200")
Message-ID: <xmqqczo8hhq2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F744CC8A-2C57-11EC-862E-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> -       if (ps_matched) {
> -               int bad;
> -               bad =3D report_path_error(ps_matched, &pathspec);
> -               if (bad)
> -                       fprintf(stderr, "Did you forget to 'git add'?\n=
");
> -
> -               return bad ? 1 : 0;
> +       if (ps_matched && report_path_error(ps_matched, &pathspec)) {
> +               fprintf(stderr, "Did you forget to 'git add'?\n");
> +               ret =3D 1;
>         }
> =20
>         dir_clear(&dir);
>         free(max_prefix);
> -       return 0;
> +       return ret;
>  }
>
> Doesn't make much sense, but I can re-roll with it if you feel strongly
> about it. I think the current version is ready to be picked up.

I do not see where that "doesn't make much sense" comes from.  If it
does not make sense, I wouldn't have mentioned it.

> Yeah we should avoid refactoring-while-at-it, but in cases where a patc=
h
> removes the only reason a nested if/if statement exists, unrolling it

And I do not quite see what "the only reason" is in this case, or
what it has to do with the restructuring, either.  Care to either
clarify, or fix the patch, or perhaps both?

Thanks.



Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF10C433F5
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 20:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4F906113E
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 20:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346313AbhIGUGY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 16:06:24 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57978 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346308AbhIGUGX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 16:06:23 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3085B144662;
        Tue,  7 Sep 2021 16:05:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=iW1D3ZtQ5r7M
        Ki/pA9aqQUMjQ1wVSES73IamTfK8Atc=; b=h8iatUw2ff+bJL1ELt+rjVMAB0A5
        4mMbhxaghodWyh6P2+6g/rowWvrqstXO8bPxeofsyU5suaNLBAmWNU59QfusRg9j
        OxZCrNfUPsNpmrPfs6X54x7cu/yzS0xkSdBIsu6U03EMpuaMEY9WXIzBHXEBezrU
        x9Sv/OMG+xFZTAE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 29714144661;
        Tue,  7 Sep 2021 16:05:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 70CAB14465E;
        Tue,  7 Sep 2021 16:05:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [BUG?] git range-diff -Ix @{1}... segfaults
References: <xmqqbl59fq9i.fsf@gitster.g>
        <7ac58fa9-f0f3-53bc-e51b-de9cd4efdb29@web.de>
Date:   Tue, 07 Sep 2021 13:05:12 -0700
In-Reply-To: <7ac58fa9-f0f3-53bc-e51b-de9cd4efdb29@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sat, 4 Sep 2021 09:50:58 +0200")
Message-ID: <xmqq7dfsb18n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: EA1CD050-1016-11EC-A694-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> range-diff.c::output() calls diff.c::diff_flush() in a loop with the
> same struct diff_options (via range-diff.c::patch_diff()).

Woooo, that's, eh, unexpected.

> So the second iteration of that loop tries to use the already freed
> ignore regexes.  Here's a patch for that:

Thanks.

>
> --- >8 ---
> Subject: [PATCH] range-diff: avoid segfault with -I
>
> output() reuses the same struct diff_options for multiple calls of
> diff_flush().  Set the option no_free to instruct it to keep the
> ignore regexes between calls and release them explicitly at the end.
>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
> Test missing because I couldn't see any effect of -I on range-diff.

I wanted to omit my sign-off when comparing a previous series and
the new series (iow, I expected -I"^Signed-off-by: me" to apply to
the outer diff, not the inner "generation of patches to be compared").


>  range-diff.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/range-diff.c b/range-diff.c
> index e731525e66..cac89a2f4f 100644
> --- a/range-diff.c
> +++ b/range-diff.c
> @@ -482,6 +482,7 @@ static void output(struct string_list *a, struct st=
ring_list *b,
>  	else
>  		diff_setup(&opts);
>
> +	opts.no_free =3D 1;
>  	if (!opts.output_format)
>  		opts.output_format =3D DIFF_FORMAT_PATCH;
>  	opts.flags.suppress_diff_headers =3D 1;
> @@ -542,6 +543,8 @@ static void output(struct string_list *a, struct st=
ring_list *b,
>  	strbuf_release(&buf);
>  	strbuf_release(&dashes);
>  	strbuf_release(&indent);
> +	opts.no_free =3D 0;
> +	diff_free(&opts);
>  }
>
>  int show_range_diff(const char *range1, const char *range2,
> --
> 2.33.0

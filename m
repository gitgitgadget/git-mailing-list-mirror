Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8577C433F5
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 22:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241364AbiCaWIe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Mar 2022 18:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbiCaWId (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Mar 2022 18:08:33 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB64243152
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 15:06:45 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 86674126391;
        Thu, 31 Mar 2022 18:06:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=nxsA3ZVFmGaC
        y1Gb9cIxqrB26WXqi8DT2t/C1tzW7c4=; b=WxBJkjZ/WWfJhUfWptUFezpkIPh9
        z65AJQX7FdwAe46jXd9/3mzc689xSJroxL5qZ18rhjBPKPhBVWnmMBFA8VQhzlxz
        2H+50h9RWI3rXQOm90exqsQRPoW0csI0C0MMNLu2zLIZrVer2TZmwsTmvB22qhuS
        jhMjBo5U/Un8byo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7D1DB126390;
        Thu, 31 Mar 2022 18:06:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D823512638F;
        Thu, 31 Mar 2022 18:06:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v4 4/6] pack-bitmap-write: remove unused bitmap_reset()
 function
References: <cover-v3-0.7-00000000000-20220326T171200Z-avarab@gmail.com>
        <cover-v4-0.6-00000000000-20220331T014349Z-avarab@gmail.com>
        <patch-v4-4.6-a9b71c281c2-20220331T014349Z-avarab@gmail.com>
Date:   Thu, 31 Mar 2022 15:06:41 -0700
In-Reply-To: <patch-v4-4.6-a9b71c281c2-20220331T014349Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 31 Mar
 2022 03:45:53
        +0200")
Message-ID: <xmqqczi1zsi6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D9A2805C-B13E-11EC-94C3-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> This function hasn't been used since 449fa5ee069 (pack-bitmap-write:
> ignore BITMAP_FLAG_REUSE, 2020-12-08), which was a cleanup commit
> intending to get rid of the code around the reusing of bitmaps.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  ewah/bitmap.c | 5 -----
>  ewah/ewok.h   | 1 -
>  2 files changed, 6 deletions(-)
>
> diff --git a/ewah/bitmap.c b/ewah/bitmap.c
> index 38a47c44db4..87d5cc8fa30 100644
> --- a/ewah/bitmap.c
> +++ b/ewah/bitmap.c
> @@ -216,11 +216,6 @@ int bitmap_is_subset(struct bitmap *self, struct b=
itmap *other)
>  	return 0;
>  }
> =20
> -void bitmap_reset(struct bitmap *bitmap)
> -{
> -	memset(bitmap->words, 0x0, bitmap->word_alloc * sizeof(eword_t));
> -}
> -

It is kind of surprising that we used to want to "clear" a bitmap
array but no longer do so (read: "we may not use it right now, but
will we soon miss it?"), but the code removed here is simple,
obvious and trivial enough that anybody we does want to use it can
easily reinvent it.

So far, all patches look quite sensible.

Thanks.



>  void bitmap_free(struct bitmap *bitmap)
>  {
>  	if (bitmap =3D=3D NULL)
> diff --git a/ewah/ewok.h b/ewah/ewok.h
> index 66920965da1..7eb8b9b6301 100644
> --- a/ewah/ewok.h
> +++ b/ewah/ewok.h
> @@ -177,7 +177,6 @@ struct bitmap *bitmap_dup(const struct bitmap *src)=
;
>  void bitmap_set(struct bitmap *self, size_t pos);
>  void bitmap_unset(struct bitmap *self, size_t pos);
>  int bitmap_get(struct bitmap *self, size_t pos);
> -void bitmap_reset(struct bitmap *self);
>  void bitmap_free(struct bitmap *self);
>  int bitmap_equals(struct bitmap *self, struct bitmap *other);
>  int bitmap_is_subset(struct bitmap *self, struct bitmap *other);

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B2DC43334
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 20:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbiGAUZq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 16:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbiGAUZn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 16:25:43 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104A0387B1
        for <git@vger.kernel.org>; Fri,  1 Jul 2022 13:25:43 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4E3021AE502;
        Fri,  1 Jul 2022 16:25:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=3gVi6paFx+IY
        NqT5SN1adRreuGp1ZpQ5d0Wn6d5EnqM=; b=mcMLx1YI2KLMyzU7bsmlz0ZdkVRP
        T2bmppatRyTrn3b8t44NvP6dnGnqxxXLBH4sDSzQEjkFNiN+QwMsLiNuL/WaAchy
        2mv3drrLjv2JsmFTqPaAlVPbaWCpb+qqd75+yvEERmvcgu+UW0TI93OeaEUvs8Bo
        1e2iilstSrGsUxU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 462851AE501;
        Fri,  1 Jul 2022 16:25:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D38761AE4FD;
        Fri,  1 Jul 2022 16:25:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 08/11] checkout: avoid "struct unpack_trees_options"
 leak
References: <cover-00.11-00000000000-20220630T175714Z-avarab@gmail.com>
        <cover-v2-00.11-00000000000-20220701T104017Z-avarab@gmail.com>
        <patch-v2-08.11-e21d7e4e9df-20220701T104017Z-avarab@gmail.com>
Date:   Fri, 01 Jul 2022 13:25:37 -0700
In-Reply-To: <patch-v2-08.11-e21d7e4e9df-20220701T104017Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 1 Jul
 2022 12:42:57
        +0200")
Message-ID: <xmqqbku88try.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F89A69AE-F97B-11EC-83AE-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 2eefda81d8c..1109f1301f4 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -710,6 +710,26 @@ static void setup_branch_path(struct branch_info *=
branch)
>  	branch->path =3D strbuf_detach(&buf, NULL);
>  }
> =20
> +static void init_topts(struct unpack_trees_options *topts, int merge,
> +		       int show_progress, int overwrite_ignore,
> +		       struct commit *old_commit)
> +{
> +	memset(topts, 0, sizeof(*topts));
> +	topts->head_idx =3D -1;
> +	topts->src_index =3D &the_index;
> +	topts->dst_index =3D &the_index;
> +
> +	setup_unpack_trees_porcelain(topts, "checkout");
> +
> +	topts->initial_checkout =3D is_cache_unborn();
> +	topts->update =3D 1;
> +	topts->merge =3D 1;
> +	topts->quiet =3D merge && old_commit;
> +	topts->verbose_update =3D show_progress;
> +	topts->fn =3D twoway_merge;
> +	topts->preserve_ignored =3D !overwrite_ignore;
> +}
> +

I've already expressed my opinion on this step in my response to
[00/11], but I'd say we take the patch as-is.  It is pretty much Meh
between moving some code that is only used once to a helper function
that is called from only one places, and not doing so at all.  Once
the code is written in one way, it is not worth the bandwidth and
brain cycles to replace it with a variant, the difference with which
is mostly irrelevant.

THanks.


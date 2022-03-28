Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40CD6C433F5
	for <git@archiver.kernel.org>; Mon, 28 Mar 2022 17:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244429AbiC1RMU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 13:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236364AbiC1RMT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 13:12:19 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC4C62C95
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 10:10:38 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 06FF1190A13;
        Mon, 28 Mar 2022 13:10:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=5VXgPnmXtyKH
        LbGuTr6BbdcR3KgEAMUGnV9BTdMlmYo=; b=Ja2AJlQ96/+ceBm2QT9YUPTsZNqE
        uo52dMBccgV/CBY0/kmkgCq9FkDfW4Wb7nBUgEQjwP/obaWZ6Kg+ew7rQSkzYm0v
        6sIGTw5QVAckgyy71ODu4yjJxMPaT/j93UsP/Ih7oPesPpy+WCHmmHw3EkucGKPm
        SeA+DvuW56CbNF8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F3BEA190A12;
        Mon, 28 Mar 2022 13:10:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 67BC0190A11;
        Mon, 28 Mar 2022 13:10:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v2] pack-objects: lazily set up "struct rev_info", don't
 leak
References: <patch-1.1-193534b0f07-20220325T121715Z-avarab@gmail.com>
        <patch-v2-1.1-9951d92176e-20220328T154049Z-avarab@gmail.com>
Date:   Mon, 28 Mar 2022 10:10:34 -0700
In-Reply-To: <patch-v2-1.1-9951d92176e-20220328T154049Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 28 Mar
 2022 17:43:18
        +0200")
Message-ID: <xmqqmtha2eb9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FB90CC46-AEB9-11EC-84F3-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> diff --git a/list-objects-filter-options.h b/list-objects-filter-option=
s.h
> index 90e4bc96252..ffc02d77e76 100644
> --- a/list-objects-filter-options.h
> +++ b/list-objects-filter-options.h
> @@ -104,13 +104,31 @@ void parse_list_objects_filter(
> ...
> +typedef struct list_objects_filter_options *(*opt_lof_init)(void *);

Do we want or need to expose this type to anybody outside the
list_objects_filter_options.c file?  After all, the client has to
define a function of that type like so:

> +static struct list_objects_filter_options *po_filter_revs_init(void *v=
alue)
> +{
> +	struct po_filter_data *data =3D value;
> +
> +	repo_init_revisions(the_repository, &data->revs, NULL);
> +	data->have_revs =3D 1;
> +
> +	return &data->revs.filter;
> +}

and not

	static opt_lof_init po_filter_revs_init
	{
		body of the function
	}

and the use of it, i.e.=20

> @@ -3954,7 +3969,7 @@ int cmd_pack_objects(int argc, const char **argv,=
 const char *prefix)
>  			      &write_bitmap_index,
>  			      N_("write a bitmap index if possible"),
>  			      WRITE_BITMAP_QUIET, PARSE_OPT_HIDDEN),
> -		OPT_PARSE_LIST_OBJECTS_FILTER(&revs.filter),
> +		OPT_PARSE_LIST_OBJECTS_FILTER_INIT(&pfd, po_filter_revs_init),

casts the type away to (intptr_t) so having a handy way to spell the
type out does not contribute to type safety, either.

Other than that, looks good to me.

Thanks, will queue directly on top of Derrick's partial-bundle
clean-up series.


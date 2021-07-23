Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA70C4320A
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 22:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0781460ED7
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 22:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbhGWVVS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 17:21:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64526 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbhGWVVR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 17:21:17 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8C6CCC2907;
        Fri, 23 Jul 2021 18:01:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=D6e5eTP4JChS
        33V/ajSkJyi5XtCUtCgsqc5w+ek01TI=; b=whUt/yRFww3z8vd26+1LPLP/Bl98
        ZAFpeRIYmC1ZQCCpVm+sJJbTvMC3Su4I+AQyIvR3uK9q8HliFPSaKCOBp7rm0ufA
        gUnCakh3GNTN2psuz470pU4W0fHYGQjGjzoCoW+SSY8OoReE7kczAwJeKcL+nd91
        p2QYvlBe9sNpPzY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 85403C2905;
        Fri, 23 Jul 2021 18:01:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EFD16C2904;
        Fri, 23 Jul 2021 18:01:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 3/3] entry: show finer-grained counter in "Filtering
 content" progress line
References: <20210620200303.2328957-1-szeder.dev@gmail.com>
        <cover-0.3-0000000000-20210722T121801Z-avarab@gmail.com>
        <patch-3.3-f65001627a-20210722T121801Z-avarab@gmail.com>
Date:   Fri, 23 Jul 2021 15:01:48 -0700
In-Reply-To: <patch-3.3-f65001627a-20210722T121801Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 22 Jul
 2021 14:20:17 +0200")
Message-ID: <xmqqbl6slmer.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 942CA5AA-EC01-11EB-AE4B-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> From: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
>
> The "Filtering content" progress in entry.c:finish_delayed_checkout()
> is unusual because of how it calculates the progress count and because
> it shows the progress of a nested loop.  It works basically like this:
>
>   start_delayed_progress(p, nr_of_paths_to_filter)
>   for_each_filter {
>       display_progress(p, nr_of_paths_to_filter - nr_of_paths_still_lef=
t_to_filter)
>       for_each_path_handled_by_the_current_filter {
>           checkout_entry()
>       }
>   }
>   stop_progress(p)
>
> There are two issues with this approach:
>
>   - The work done by the last filter (or the only filter if there is
>     only one) is never counted, so if the last filter still has some
>     paths to process, then the counter shown in the "done" progress
>     line will not match the expected total.
>
>     This would cause a BUG() in an upcoming change that adds an
>     assertion checking if the "total" at the end matches the last
>     progress bar update..

So the other series will semantically depend on this 3-patch series?
Just making sure that is the intended topic structure.

> diff --git a/entry.c b/entry.c
> index 125fabdbd5..d92dd020b3 100644
> --- a/entry.c
> +++ b/entry.c
> @@ -162,7 +162,7 @@ static int remove_available_paths(struct string_lis=
t_item *item, void *cb_data)
>  int finish_delayed_checkout(struct checkout *state, int *nr_checkouts)
>  {
>  	int errs =3D 0;
> -	unsigned delayed_object_count;
> +	unsigned processed_paths =3D 0;
>  	off_t filtered_bytes =3D 0;
>  	struct string_list_item *filter, *path;
>  	struct progress *progress;
> @@ -172,12 +172,10 @@ int finish_delayed_checkout(struct checkout *stat=
e, int *nr_checkouts)
>  		return errs;
> =20
>  	dco->state =3D CE_RETRY;
> -	delayed_object_count =3D dco->paths.nr;
> -	progress =3D start_delayed_progress(_("Filtering content"), delayed_o=
bject_count);
> +	progress =3D start_delayed_progress(_("Filtering content"), dco->path=
s.nr);
>  	while (dco->filters.nr > 0) {
>  		for_each_string_list_item(filter, &dco->filters) {
>  			struct string_list available_paths =3D STRING_LIST_INIT_NODUP;
> -			display_progress(progress, delayed_object_count - dco->paths.nr);
> =20
>  			if (!async_query_available_blobs(filter->string, &available_paths))=
 {
>  				/* Filter reported an error */
> @@ -224,6 +222,7 @@ int finish_delayed_checkout(struct checkout *state,=
 int *nr_checkouts)
>  				ce =3D index_file_exists(state->istate, path->string,
>  						       strlen(path->string), 0);
>  				if (ce) {
> +					display_progress(progress, ++processed_paths);
>  					errs |=3D checkout_entry(ce, state, NULL, nr_checkouts);
>  					filtered_bytes +=3D ce->ce_stat_data.sd_size;
>  					display_throughput(progress, filtered_bytes);

Hmph.  A missing cache entries will not increment processed; would
that cause stop_progress() to see at the end the counter that is
smaller than dco->paths.nr we saw at the beginning?


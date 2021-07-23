Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B50C4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 21:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE9EF60EB6
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 21:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbhGWVOz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 17:14:55 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54930 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbhGWVOy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 17:14:54 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2A07DC26E8;
        Fri, 23 Jul 2021 17:55:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=43mjIEDUjmM/
        /AqRd94G365nvV/psFW/Qrq7JITvjH8=; b=TBbVaHxgUgTR7HcCzfWI2w5E1NVF
        ykNWiLbqtxx6OE2ktbljLohp++hqLst3t6stmdx++cr4KeI3zGTflBVppBi0Qg1a
        9gTwZU2HPes3rCRVAu8phL4SY9OIPnZd/67wm69L4obtNetnO/Dq0K20Ev886mHy
        b56PCY062RbtmEc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 22F7CC26E7;
        Fri, 23 Jul 2021 17:55:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 999ADC26E6;
        Fri, 23 Jul 2021 17:55:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 1/3] commit-graph: fix bogus counter in "Scanning merged
 commits" progress line
References: <20210620200303.2328957-1-szeder.dev@gmail.com>
        <cover-0.3-0000000000-20210722T121801Z-avarab@gmail.com>
        <patch-1.3-832a6c1f78-20210722T121801Z-avarab@gmail.com>
Date:   Fri, 23 Jul 2021 14:55:25 -0700
In-Reply-To: <patch-1.3-832a6c1f78-20210722T121801Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 22 Jul
 2021 14:20:15 +0200")
Message-ID: <xmqqk0lglmpe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B0462708-EC00-11EB-A7D2-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> From: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
>
> The final value of the counter of the "Scanning merged commits"
> progress line is always one less than its expected total, e.g.:
>
>   Scanning merged commits:  83% (5/6), done.
>
> This happens because while iterating over an array the loop variable
> is passed to display_progress() as-is, but while C arrays (and thus
> the loop variable) start at 0 and end at N-1, the progress counter
> must end at N.  This causes the failures of the tests
> 'fetch.writeCommitGraph' and 'fetch.writeCommitGraph with submodules'
> in 't5510-fetch.sh' when run with GIT_TEST_CHECK_PROGRESS=3D1.
>
> Fix this by passing 'i + 1' to display_progress(), like most other
> callsites do.

Sensible, I guess.

>
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  commit-graph.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index 1a2602da61..918061f207 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -2096,7 +2096,7 @@ static void sort_and_scan_merged_commits(struct w=
rite_commit_graph_context *ctx)
> =20
>  	ctx->num_extra_edges =3D 0;
>  	for (i =3D 0; i < ctx->commits.nr; i++) {
> -		display_progress(ctx->progress, i);
> +		display_progress(ctx->progress, i + 1);
> =20
>  		if (i && oideq(&ctx->commits.list[i - 1]->object.oid,
>  			  &ctx->commits.list[i]->object.oid)) {


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6489CC433FE
	for <git@archiver.kernel.org>; Fri,  7 Oct 2022 17:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbiJGRVx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Oct 2022 13:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiJGRVw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2022 13:21:52 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174FAC8223
        for <git@vger.kernel.org>; Fri,  7 Oct 2022 10:21:51 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7FE4A1A4ED4;
        Fri,  7 Oct 2022 13:21:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=g62rn0s1oIRF
        9/BAncAczwlS5nsONEr0QU4BcG1iDhI=; b=uWiGUA3DC/61tmsq4GYHmjLqJM9B
        BCNT3EHPrUVQ7NlLrKaIYqMWgh5hfRH2rW0CQyPwvEiPVRhnoZWuWe1r3uOVuUio
        TEuoGv/Rqiq6f6rVkShV3HgmJ9bXsNrF7GkZvgSStVPfaHJ4OGjD2BWLjEW65DW1
        K/EOuPJf8fEZqAI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 78A091A4ED3;
        Fri,  7 Oct 2022 13:21:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AFFA51A4ED2;
        Fri,  7 Oct 2022 13:21:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH v2] bisect--helper: plug strvec leak
References: <5c6a4c30-d454-51b6-ec57-9af036b9c4e0@web.de>
        <221005.8635c2u3k5.gmgdl@evledraar.gmail.com>
        <xmqqy1tunjgp.fsf@gitster.g>
        <221006.86a668r5mf.gmgdl@evledraar.gmail.com>
        <xmqqk05cipq8.fsf@gitster.g>
        <1965b54b-122a-c965-f886-1a7dd6afbfb4@web.de>
Date:   Fri, 07 Oct 2022 10:21:47 -0700
In-Reply-To: <1965b54b-122a-c965-f886-1a7dd6afbfb4@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Fri, 7 Oct 2022 17:08:42 +0200")
Message-ID: <xmqq4jwfh7mc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 869AE53C-4664-11ED-8E78-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> The strvec "argv" is used to build a command for run_command_v_opt(),
> but never freed.  Use a constant string array instead, which doesn't
> require any cleanup.
>
> Suggested-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
>  builtin/bisect--helper.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

Thanks, both.  Looking good.

>
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 501245fac9..28ef7ec2a4 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -765,11 +765,10 @@ static enum bisect_error bisect_start(struct bise=
ct_terms *terms, const char **a
>  		strbuf_read_file(&start_head, git_path_bisect_start(), 0);
>  		strbuf_trim(&start_head);
>  		if (!no_checkout) {
> -			struct strvec argv =3D STRVEC_INIT;
> +			const char *argv[] =3D { "checkout", start_head.buf,
> +					       "--", NULL };
>
> -			strvec_pushl(&argv, "checkout", start_head.buf,
> -				     "--", NULL);
> -			if (run_command_v_opt(argv.v, RUN_GIT_CMD)) {
> +			if (run_command_v_opt(argv, RUN_GIT_CMD)) {
>  				res =3D error(_("checking out '%s' failed."
>  						 " Try 'git bisect start "
>  						 "<valid-branch>'."),
> --
> 2.38.0

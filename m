Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A292EC001B0
	for <git@archiver.kernel.org>; Tue,  8 Aug 2023 23:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjHHXwr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Aug 2023 19:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjHHXwq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2023 19:52:46 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BA1F0
        for <git@vger.kernel.org>; Tue,  8 Aug 2023 16:52:46 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B2E272E24A;
        Tue,  8 Aug 2023 19:52:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=k4TNDklWkjxD
        aToTAOA8csZVWAz4dGpPInz+pQB8ls8=; b=L7QDm4Vxt8AssFIzzBba49Y7pp+Z
        vBAX4bIiXrb0Wt/uPHIONLhKvCwgYYRUyzqtVUQJQCBE9cEVbkenGNr8Nq1m9raw
        EeCp6hsqZFc4WBw2MWLj8/fmMvh4NzGZgvmf8pnv029UqH+aERZ/rh5cFKEIpnIQ
        zYrDpAyPumCF1ag=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AB4462E249;
        Tue,  8 Aug 2023 19:52:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 45A532E248;
        Tue,  8 Aug 2023 19:52:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH] parse-options: disallow negating OPTION_SET_INT 0
References: <c4cd1591-3a83-920a-6a80-19ffbfe3089d@web.de>
Date:   Tue, 08 Aug 2023 16:52:41 -0700
In-Reply-To: <c4cd1591-3a83-920a-6a80-19ffbfe3089d@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Tue, 8 Aug 2023 22:05:57 +0200")
Message-ID: <xmqqh6p96qie.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: AA030E00-3646-11EE-8AB2-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> An option of type OPTION_SET_INT can be defined to set its variable to
> zero.  It's negated variant will do the same, though, which is
> confusing.  Several such options were fixed by disabling negation,
> changing the value to set or using a different option type:
>
> 991c552916 (ls-tree: fix --no-full-name, 2023-07-18)
> e12cb98e1e (branch: reject "--no-all" and "--no-remotes" early, 2023-07=
-18)
> 68cbb20e73 (show-branch: reject --[no-](topo|date)-order, 2023-07-19)
> 3821eb6c3d (reset: reject --no-(mixed|soft|hard|merge|keep) option, 202=
3-07-19)
> 36f76d2a25 (pack-objects: fix --no-quiet, 2023-07-21)
> 3a5f308741 (pack-objects: fix --no-keep-true-parents, 2023-07-21)
> c95ae3ff9c (describe: fix --no-exact-match, 2023-07-21)
> d089a06421 (bundle: use OPT_PASSTHRU_ARGV, 2023-07-29)
>
> Check for such options that allow negation in parse_options_check() and
> report them to find future cases quicker.

That does make quite a lot of sense, and parse_options_check() is
the perfect place to do so.

Thanks.

> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
>  parse-options.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/parse-options.c b/parse-options.c
> index 87c9fae634..60224cf8d0 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -480,6 +480,9 @@ static void parse_options_check(const struct option=
 *opts)
>  		     opts->long_name))
>  			optbug(opts, "uses feature "
>  			       "not supported for dashless options");
> +		if (opts->type =3D=3D OPTION_SET_INT && !opts->defval &&
> +		    opts->long_name && !(opts->flags & PARSE_OPT_NONEG))
> +			optbug(opts, "OPTION_SET_INT 0 should not be negatable");
>  		switch (opts->type) {
>  		case OPTION_COUNTUP:
>  		case OPTION_BIT:
> --
> 2.41.0

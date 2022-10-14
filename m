Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B64C4332F
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 18:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbiJNSoF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 14:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiJNSoD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 14:44:03 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345541D0666
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 11:44:02 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5CBB0145FE8;
        Fri, 14 Oct 2022 14:44:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=GR9oGLeS1VeB
        +/QQOR+pzZ0y6bm8l7WTaYNSO4Kha0E=; b=S+40l5E3G+nTuDggQxjLd/3N9sRR
        KtmMJTTtHAPEfdWiLaJOSINQTfPFFyyjgQAG7nUL9EvJbmi35bTcwtqBCeHF7Zgy
        LQ2cCjDcbfiBfZLE9bBZWMoZR2pcd8jIYkYgrmVbd2iVtWvIaRtDBUzq/5LivXZV
        W2N2L4qOeAYSjKM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 48747145FE7;
        Fri, 14 Oct 2022 14:44:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 68EDF145FE5;
        Fri, 14 Oct 2022 14:44:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 04/10] am: use run_command_l_opt() for show_patch()
References: <cover-00.10-00000000000-20221014T153426Z-avarab@gmail.com>
        <patch-04.10-4cd61aaa981-20221014T153426Z-avarab@gmail.com>
Date:   Fri, 14 Oct 2022 11:43:59 -0700
In-Reply-To: <patch-04.10-4cd61aaa981-20221014T153426Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 14 Oct
 2022 17:40:16
        +0200")
Message-ID: <xmqqpmeu8cuo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2B0752D2-4BF0-11ED-9F0A-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> The "git show" invocation added in 66335298a47 (rebase: add
> --show-current-patch, 2018-02-11) is a one-off, and one where we're
> not calling oid_to_hex() twice.

I am not sure what relevance it has being a one-off in justifying
this change.

I agree with the latter half of the explanation, though.  As long as
run_command_l_opt() does not reuse the static oid_to_hex() buffers,
this is safe.

> -	if (!is_null_oid(&state->orig_commit)) {
> -		const char *av[4] =3D { "show", NULL, "--", NULL };
> -		char *new_oid_str;
> -		int ret;
> -
> -		av[1] =3D new_oid_str =3D xstrdup(oid_to_hex(&state->orig_commit));
> -		ret =3D run_command_v_opt(av, RUN_GIT_CMD);
> -		free(new_oid_str);
> -		return ret;
> -	}
> +	if (!is_null_oid(&state->orig_commit))
> +		return run_command_l_opt(RUN_GIT_CMD, "show",
> +					 oid_to_hex(&state->orig_commit),
> +					 "--", NULL);
> =20
>  	switch (sub_mode) {
>  	case SHOW_PATCH_RAW:

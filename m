Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC5D2C433EF
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 05:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85C06600CD
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 05:59:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbhJ2GBs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 02:01:48 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56038 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbhJ2GBr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 02:01:47 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EE744FC4DB;
        Fri, 29 Oct 2021 01:59:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=kGPwJbCyIFTj
        DnXcKIb6WUexI3NbNviqj+VoRDNRFrg=; b=RvLUixa8wiboad8MdhLN1GcYdWIq
        m85v4xS8bbGRxunWvO6JcI+e2FWyJVeEbIbYoBEAsWTmF3JkxfipD5tbAWQYGgYo
        yrHprf1tgWThV/JlG3j9zg+EvPMw5qs/kdkn7ibaBI8Qu3vLuZDMlyY7MNWBmFKv
        CwagggRpfRZWupE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E6BA1FC4DA;
        Fri, 29 Oct 2021 01:59:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 56DE4FC4D9;
        Fri, 29 Oct 2021 01:59:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v3 07/13] git hook run: add an --ignore-missing flag
References: <cover-v2-00.13-00000000000-20211015T093918Z-avarab@gmail.com>
        <cover-v3-00.13-00000000000-20211019T231647Z-avarab@gmail.com>
        <patch-v3-07.13-840fb530df3-20211019T231647Z-avarab@gmail.com>
Date:   Thu, 28 Oct 2021 22:59:17 -0700
In-Reply-To: <patch-v3-07.13-840fb530df3-20211019T231647Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 20 Oct
 2021 01:20:45
        +0200")
Message-ID: <xmqqbl38mkwa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5A9A3ADC-387D-11EC-A079-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> +	int ignore_missing =3D 0;
>  	const char *hook_name;
>  	const char *hook_path;
>  	struct option run_options[] =3D {
> +		OPT_BOOL(0, "ignore-missing", &ignore_missing,
> +			 N_("silently ignore missing requested <hook-name>")),
>  		OPT_END(),
>  	};
>  	int ret;
> @@ -53,6 +56,8 @@ static int run(int argc, const char **argv, const cha=
r *prefix)
>  	git_config(git_default_config, NULL);
> =20
>  	hook_name =3D argv[0];
> +	if (ignore_missing)
> +		return run_hooks_oneshot(hook_name, &opt);
>  	hook_path =3D find_hook(hook_name);
>  	if (!hook_path) {
>  		error("cannot find a hook named %s", hook_name);

Given that the rest of this "run()" function is more or less
identical to run_hooks_oneshot(), I have to wonder why we do not
give an .ignore_missing member to the hooks_opt structure to be done
with this.  Otehrwise, every time the underlying run_hooks()
interface needs to change, we need to update two places, no?


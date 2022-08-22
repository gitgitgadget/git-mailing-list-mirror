Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6909C28D13
	for <git@archiver.kernel.org>; Mon, 22 Aug 2022 22:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237974AbiHVWPE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 18:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235467AbiHVWPD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 18:15:03 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175CC402D6
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 15:15:02 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 54B97135E18;
        Mon, 22 Aug 2022 18:15:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=JaFbIWslFtrmtr+pbZJ5XTTgI
        zbp3FbAv8UYk/rtzMg=; b=FYwcv53bvmVMrxxOkcKON2uH++7QngB0suz+Qkhsm
        HXdaGtxijMWC5/vysBvvpjSegDqC3LQldDgTAQi8LMtYryFtYjbw6ROMpfiebRM5
        GtdzscBmyOd+BtuYMddHWvQrFF1STDD9UFjHZrogVC7UFsTPcXsnjUDGryZKGPkh
        uw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3A79C135E16;
        Mon, 22 Aug 2022 18:15:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 923DA135E15;
        Mon, 22 Aug 2022 18:14:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] promisor-remote: fix xcalloc() argument order
References: <20220822213408.662482-1-szeder.dev@gmail.com>
Date:   Mon, 22 Aug 2022 15:14:58 -0700
Message-ID: <xmqqh7249b8d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: DC95D0BC-2267-11ED-8B71-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> Pass the number of elements first and their size second, as expected
> by xcalloc().
>
> Patch generated with 'contrib/coccinelle/xcalloc.cocci' and Coccinelle
> v1.0.7 or later (previous Coccinelle versions don't notice this).

One thing is that Coccinelle is way too slow on our codebase,
compared to the usual compilation, to run every time we make
changes.  Combined with the fact that our codebase is mostly clean,
the cycles feel huge waste of time only to find something small like
what this patch fixes.

That sadly discourages us from doing "make coccicheck" more often as
we should.

I _think_ Googlers have 1.1.1 on their linux boxes, so even if our
GitHub Actions CI is fixed to Ubuntu 18.04 and does not run more
recent Coccinelle, we theoretically should have been able to catch
it before it hit the public list, if "1.0.7 or later" was the
condition.  FWIW, "make coccicheck" with what I happen to have
notices it.

$ spatch version
spatch version 1.1.1 compiled with OCaml version 4.13.1
Flags passed to the configure script: --prefix=3D/usr --sysconfdir=3D/etc=
 --libdir=3D/usr/lib --enable-ocaml --enable-python --enable-opt
OCaml scripting support: yes
Python scripting support: yes
Syntax of regular expressions: PCRE

Anyway, the patch is correct.

Thanks, will queue.

> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> ---
>  promisor-remote.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/promisor-remote.c b/promisor-remote.c
> index 5b33f88bca..68f46f5ec7 100644
> --- a/promisor-remote.c
> +++ b/promisor-remote.c
> @@ -146,7 +146,7 @@ static void promisor_remote_init(struct repository =
*r)
>  	if (r->promisor_remote_config)
>  		return;
>  	config =3D r->promisor_remote_config =3D
> -		xcalloc(sizeof(*r->promisor_remote_config), 1);
> +		xcalloc(1, sizeof(*r->promisor_remote_config));
>  	config->promisors_tail =3D &config->promisors;
> =20
>  	repo_config(r, promisor_remote_config, config);

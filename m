Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F09D3C433EF
	for <git@archiver.kernel.org>; Wed, 18 May 2022 22:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbiERWC1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 May 2022 18:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbiERWCH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 May 2022 18:02:07 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A874C4EDE3
        for <git@vger.kernel.org>; Wed, 18 May 2022 14:51:10 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2263E18AF78;
        Wed, 18 May 2022 17:51:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=N1ZN1dsKJy4L
        DILpSJWAvycLd0J+Ar3JLwkW/bYDqTg=; b=HIc3n2/1eObRjkarQilU3XD4I9Vn
        TgOkM7ar8zW1lDAk64lbXvYTEwJbJLpGJW+Ekl1UxfcwUkZBHojIvPc6QRJPu+Dx
        JrmLNLZOWkWxq/ZSkIsrNb/TP3nat91Z7MNXzZTfFB13rhFbCIGxiN1IMu8Y4h7a
        c20tQr+P/xIt4eo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 185A118AF76;
        Wed, 18 May 2022 17:51:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3A39D18AF6E;
        Wed, 18 May 2022 17:51:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Anthony Sottile <asottile@umich.edu>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 5/8] run-command: add an "ungroup" option to
 run_process_parallel()
References: <cover-0.6-00000000000-20220421T122108Z-avarab@gmail.com>
        <cover-v2-0.8-00000000000-20220518T195858Z-avarab@gmail.com>
        <patch-v2-5.8-c2e015ed840-20220518T195858Z-avarab@gmail.com>
Date:   Wed, 18 May 2022 14:51:05 -0700
In-Reply-To: <patch-v2-5.8-c2e015ed840-20220518T195858Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 18 May
 2022 22:05:21
        +0200")
Message-ID: <xmqqa6betsqe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9E949118-D6F4-11EC-81C8-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> + * If the "ungroup" option isn't specified the callbacks will get a
> + * pointer to a "struct strbuf *out", and must not write to stdout or
> + * stderr as such output will mess up the output of the other parallel
> + * processes. If "ungroup" option is specified callbacks will get a
> + * NULL "struct strbuf *out" parameter, and are responsible for
> + * emitting their own output, including dealing with any race
> + * conditions due to writing in parallel to stdout and stderr.
>   */
>  int run_processes_parallel(struct run_process_parallel_opts *opts);
> =20
> diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
> index 56a806f228b..986acbce5f2 100644
> --- a/t/helper/test-run-command.c
> +++ b/t/helper/test-run-command.c
> @@ -31,7 +31,11 @@ static int parallel_next(struct child_process *cp,
>  		return 0;
> =20
>  	strvec_pushv(&cp->args, d->args.v);
> -	strbuf_addstr(err, "preloaded output of a child\n");
> +	if (err)
> +		strbuf_addstr(err, "preloaded output of a child\n");
> +	else
> +		fprintf(stderr, "preloaded output of a child\n");
> +

This illustrates the intended use of !err and !!err pretty well ;-).


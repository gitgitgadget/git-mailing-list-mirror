Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68454C433F5
	for <git@archiver.kernel.org>; Tue, 24 May 2022 22:38:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242431AbiEXWi6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 18:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiEXWi4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 18:38:56 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3087939A
        for <git@vger.kernel.org>; Tue, 24 May 2022 15:38:55 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DF0C6181BA1;
        Tue, 24 May 2022 18:38:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9E2hLBVzZ4Vzdhxb9t/GgoikhpHhpQQAw2sgp8
        c5Dmo=; b=DqwlaKNhg6TmJwpF3QVit+F2nRnkt4GjiCZXbAE7CfmrTDaZUnJ8vS
        /L1K8/BykTQ4Nz2M/zOnSyrPSfMYP2nEisPY8pmNa4IDglF2OXJr+lZ7KEpgU2up
        sCHV5+pms+PRStKVmEDQYPLLcfkI9Xr1cVGLdWqc+bXP9dIyQTtr0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D7890181BA0;
        Tue, 24 May 2022 18:38:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 465D7181B9F;
        Tue, 24 May 2022 18:38:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/4] http.c: avoid danging pointer to local variable
 `finished`
References: <pull.1238.git.1653351786.gitgitgadget@gmail.com>
        <4a4e0aa0a49a54eea88f9c2d8e1db6a697012718.1653351786.git.gitgitgadget@gmail.com>
        <220524.86fskzxsvq.gmgdl@evledraar.gmail.com>
        <xmqq35gyhf11.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2205242309160.352@tvgsbejvaqbjf.bet>
Date:   Tue, 24 May 2022 15:38:50 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2205242309160.352@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 24 May 2022 23:15:58 +0200 (CEST)")
Message-ID: <xmqqczg2eeth.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 48C2F03C-DBB2-11EC-840A-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Tue, 24 May 2022, Junio C Hamano wrote:
>
>> The "clear slot->finished", by the way, is what I think is the right
>> thing to do, especially that the objective is to squelch the false
>> positive warning from a new compiler.  If there is a way to annotate
>> the line for the compiler to tell it not to warn about it, that would
>> have been even better.
>
> We could do something like this:

Yuck.

> -- snip --
> diff --git a/http.c b/http.c
> index b08795715f8a..2ac8d51d3668 100644
> --- a/http.c
> +++ b/http.c
> @@ -1365,7 +1365,14 @@ void run_active_slot(struct active_request_slot *slot)
>  	struct timeval select_timeout;
>  	int finished = 0;
>
> +#if __GNUC__ >= 12
> +#pragma GCC diagnostic push
> +#pragma GCC diagnostic ignored "-Wdangling-pointer"
> +#endif
>  	slot->finished = &finished;
> +#if __GNUC__ >= 12
> +#pragma GCC diagnostic pop
> +#endif
>  	while (!finished) {
>  		step_active_slots();
> -- snap --
>
> That's quite ugly, though. And what's worse, it is pretty unreadable, too.

Yes, very ugly.  Would an unconditional

	slot->finished = NULL;

at the end squelch the warning?

Or there is a way to say "we make all warnings into errors with
-Werror, but we do not want to turn this dangling-pointer warning to
an error, because it has false positives"?

Or we could add "-Wno-dangling-pointer" globally, perhaps.


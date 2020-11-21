Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25018C388F9
	for <git@archiver.kernel.org>; Sat, 21 Nov 2020 21:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C89042080D
	for <git@archiver.kernel.org>; Sat, 21 Nov 2020 21:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uk20YDmG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbgKUVyX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Nov 2020 16:54:23 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56069 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728513AbgKUVyW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Nov 2020 16:54:22 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DD1198150C;
        Sat, 21 Nov 2020 16:54:18 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IdldlSFjIS+ISj8Fogr2Jec9DLA=; b=uk20YD
        mGsV5BOW0dHZBl8zLbPzZhtp9nh+LQy7Q61dkm9kb91L1Jolv/umH0E2RzLJCrhA
        vHfB9Q3f19hnMu3Le2jJCOwf39AsxbBl9z1sKjIfs0RtQzY4EK+MCCewrDb1+3s+
        GBcFO1h8T8exl/K45BDm9pFsKt30y5KXyvy5I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ncVLkT5FGQFjnj+e8/TojRoDiXXeH7cH
        2sH8EW7CFhF7JlG2631PtiuqdR9cyWgqntLsquzUSKfnuxJOLrZ5kaXuVHrp3gy+
        O1Z8jQkxkIn5cCo/JsJ691QBeZ3sgL0bWgH03fXhvm1Ku9DPozZUNa5xEjMEvTiZ
        3sjktQeeqgU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D4C838150B;
        Sat, 21 Nov 2020 16:54:18 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4E6B081509;
        Sat, 21 Nov 2020 16:54:18 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?5ZSQ5a6H5aWV?= <winglovet@gmail.com>,
        git@vger.kernel.org
Subject: Re: Bug report: orphaned pack-objects after killing upload-pack on [
References: <CAFWsj_UwkQX9y0xPQJE3xguo0z3TMkvKAwei5iryCWXvVP8CjA@mail.gmail.com>
        <badf3777-3970-b714-3ad9-67d2f77f94a5@web.de>
        <20201121002921.GC353076@coredump.intra.peff.net>
Date:   Sat, 21 Nov 2020 13:54:17 -0800
In-Reply-To: <20201121002921.GC353076@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 20 Nov 2020 19:29:21 -0500")
Message-ID: <xmqqd006s7ee.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1AC4A140-2C44-11EB-A696-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Yeah, clean_on_exit seems quite reasonable to me. I suspect nobody ever
> really noticed, because as soon as pack-objects starts to write out the
> pack, it will get SIGPIPE or EPIPE and die. But there is no point in
> letting it chug on expensive object enumeration or delta compression if
> upload-pack has already exited.
>
> I don't know that wait_after_clean is necessary. We don't need to wait
> for pack-objects to fail.
>
> On the flip side, one of the reasons I added clean_on_exit long ago was
> for the similar issue on the push side, which is even worse. Here we
> might just waste some CPU, but on the push side we connect pack-objects
> directly to the remote socket, so it could actually complete the push
> (from the server's perspective) after the local git-push has died. Or at
> least I think that was possible at one point; it might not be the case
> any more.
>
> I wrote this patch ages ago, and it is still sitting close to the bottom
> (if not the bottom) of my todo stack, waiting to be investigated. ;)

Sounds sensible.

> -- >8 --
> Subject: [PATCH] send-pack: kill pack-objects helper on signal or exit
>
> We spawn an external pack-objects process to actually send
> objects to the remote side. If we are killed by a signal
> during this process, the pack-objects will keep running and
> complete the push, which may surprise the user. We should
> take it down when we go down.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  send-pack.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/send-pack.c b/send-pack.c
> index eb4a44270b..d2701bf35c 100644
> --- a/send-pack.c
> +++ b/send-pack.c
> @@ -85,6 +85,7 @@ static int pack_objects(int fd, struct ref *refs, struct oid_array *extra, struc
>  	po.in = -1;
>  	po.out = args->stateless_rpc ? -1 : fd;
>  	po.git_cmd = 1;
> +	po.clean_on_exit = 1;
>  	if (start_command(&po))
>  		die_errno("git pack-objects failed");

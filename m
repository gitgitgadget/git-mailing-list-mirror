Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B61C00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 18:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233258AbiG2SwL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 14:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiG2SwK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 14:52:10 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DF53342F
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 11:52:06 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9DEA613B4B9;
        Fri, 29 Jul 2022 14:52:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CQ4xp/rqUM57U7mC7XOZ4sZOujxpvbnHH5T/1i
        RjuMs=; b=g7bEKK6wjVvKLcsAq/qQ69WwB8rcJGIOtQYfNyBIM+F/bVU7LZHfsd
        keRTAeyi4f+5rZLub9EeOwf9Mb/JSjrVdhk8WeCP75iQDxQPA5irySXU3+IkI4IP
        feqzhDkloRUN801eBL/GrxAYgt9G4gj6yfs+tSyTivludK/aKTEnI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 72AA413B4B8;
        Fri, 29 Jul 2022 14:52:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C283913B4B7;
        Fri, 29 Jul 2022 14:52:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 6/6] revisions API: don't leak memory on argv elements
 that need free()-ing
References: <cover-0.6-00000000000-20220713T130511Z-avarab@gmail.com>
        <patch-6.6-4a581a4a6ce-20220713T130511Z-avarab@gmail.com>
        <YtV4KmrTBkmcx6m3@coredump.intra.peff.net>
        <220718.86zgh6wiwa.gmgdl@evledraar.gmail.com>
        <YtWAMP0ROFseFs6B@coredump.intra.peff.net>
        <220729.86pmhoidsc.gmgdl@evledraar.gmail.com>
        <YuQg5M/cSLtqOgdw@coredump.intra.peff.net>
        <YuQpBwUt8rAE9oym@coredump.intra.peff.net>
Date:   Fri, 29 Jul 2022 11:52:02 -0700
In-Reply-To: <YuQpBwUt8rAE9oym@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 29 Jul 2022 14:37:59 -0400")
Message-ID: <xmqqk07v69bh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 895426FC-0F6F-11ED-A0A4-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The more interesting question is whether it causes any use-after-free
> bugs.

Thanks for mentioning this.  All the "plug more leaks" patches make
me worried for exactly that.  Another is a potential subtle breakage
hidden by use of FREE_AND_NULL() and friends, which the sanitizers
would probably not see, but can appear as behaviour change.

> I don't think it does, and certainly SANITIZE=address agrees.

;-)

> -- >8 --
> Subject: [PATCH] bisect: stop leaking strvec in bisect_rev_setup()
>
> Back when 8a534b6124 (bisect: use argv_array API, 2011-09-13) was
> written, it was not safe to free the argv we had passed to
> setup_revisions() until the actual traversal was done.
>
> But since then, we've had many cleanups that makes this safe; e.g.,
> df835d3a0c (add_rev_cmdline(): make a copy of the name argument,
> 2013-05-25) and 31faeb2088 (object_array_entry: fix memory handling of
> the name field, 2013-05-25). The comment here is now out-dated; we can
> just clear the strvec rather than leaking.
>
> Note that there's still a small leak because of the way
> setup_revisions() handles removed elements internally. That will be
> fixed in a subsequent patch.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  bisect.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/bisect.c b/bisect.c
> index 421470bfa5..9cce23e929 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -670,7 +670,7 @@ static void bisect_rev_setup(struct repository *r, struct rev_info *revs,
>  		read_bisect_paths(&rev_argv);
>  
>  	setup_revisions(rev_argv.nr, rev_argv.v, revs, NULL);
> -	/* XXX leak rev_argv, as "revs" may still be pointing to it */
> +	strvec_clear(&rev_argv);
>  }
>  
>  static void bisect_common(struct rev_info *revs)

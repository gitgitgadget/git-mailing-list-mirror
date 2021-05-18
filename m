Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF3BC433B4
	for <git@archiver.kernel.org>; Tue, 18 May 2021 01:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 317D4611BF
	for <git@archiver.kernel.org>; Tue, 18 May 2021 01:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345642AbhERB20 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 21:28:26 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59023 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238837AbhERB2Z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 21:28:25 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CC127C83F1;
        Mon, 17 May 2021 21:27:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=wyi8oJYsm1RL
        f5h2P8dU7imK5ieGzxLl/QQOJJcY2g0=; b=VppeuHxSoyAZjMMcKHm3EoAcGwXf
        55BmonakrSQXoE76/Qs0Sx6GzhUGlr36LLxOi6HQWMktCD/t1MS/8VijD5V3gvsC
        Z/3lBgQPb4STyWncZBRM1sz3sXzBnuWoRupgkliDAL4+mdkul9k2t5B/Q21V7fIA
        aXjJG/V3SFFxIAs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C486DC83F0;
        Mon, 17 May 2021 21:27:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 55CFEC83EE;
        Mon, 17 May 2021 21:27:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: Man pages have colors? A deep dive into groff
References: <60a046bd83001_f4b0f20861@natae.notmuch>
        <87tun1qp91.fsf@evledraar.gmail.com> <xmqqlf8d6ty5.fsf@gitster.g>
        <60a2f1c4cab0d_13c3702083a@natae.notmuch>
Date:   Tue, 18 May 2021 10:27:06 +0900
In-Reply-To: <60a2f1c4cab0d_13c3702083a@natae.notmuch> (Felipe Contreras's
        message of "Mon, 17 May 2021 17:44:20 -0500")
Message-ID: <xmqqim3g4ys5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 28D151E2-B778-11EB-8A76-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Junio C Hamano wrote:
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>=20
>> > This looks much better.
>> >
>> > I wonder a good follow-up (hint, hint! :) would be to have
>> > exec_man_man() and exec_man_cmd() in builtin/help.c set this dependi=
ng
>> > on color.ui (so we'd do it by default with "auto").
>> >
>> > Then e.g. "git help git" would look prettier than "man git".
>>=20
>> As long as color.man.ui can be used to override the blanket
>> color.ui, I think it is a good idea.
>
> Why not use color.pager?

I dug a bit to refresh my memory and it turns out that the reason we
should not do so is because it means something totally different.

color.[ch] defines want_color() that applications like "diff" and
"log" can use to see if the application is configured to paint its
output in colors.

When that layer says for that particular application it should be
decided automatically, then we call into color.c::check_auto_color()
which is the only user of pager_use_color (which is set from the
color.pager configuration variable).  The purpose of that call is to
ask if the pager is capable of colors.

So in short, the color.pager is about "is the pager capable of
colors?"  and the color.ui (and color.<cmd>) is about "does the user
wants output from <cmd> in color?"  We need to use color.help or
something that controls whether the user wants help/man in colors,
and perhaps default it to "auto" like color.ui defaults to, which
then in turn would consult "color.pager".  Tying it directly to
"color.pager" is wrong.





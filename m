Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C980C43334
	for <git@archiver.kernel.org>; Tue,  5 Jul 2022 18:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbiGESGH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jul 2022 14:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbiGESGG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jul 2022 14:06:06 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255DE15FD5
        for <git@vger.kernel.org>; Tue,  5 Jul 2022 11:06:05 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C7B3B1AC49F;
        Tue,  5 Jul 2022 14:06:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=c8S2W7aNeo/Y
        A+WoAjiZu//Gca656k/A3JZU+4a+chg=; b=hBoXVojnBPJfowyGzmMbDAV4lrnZ
        ZWe1LDfdzpQoTFr163Z6BFJk2BUXpjvT81CKDrZsGrIyMqFTcZNVbssa3ZupIcm3
        WHLMfrBYdzESONM+GJSuoNp94RqSJtnZWICJOyu2T2ryqqYRI3inMLSu0iQxvenM
        4Rg0opQjSO5WJ9s=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C115F1AC49E;
        Tue,  5 Jul 2022 14:06:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 733421AC49C;
        Tue,  5 Jul 2022 14:06:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     "lilinchao@oschina.cn" <lilinchao@oschina.cn>,
        Li Linchao via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH] remote-curl: send Accept-Language header to server
References: <pull.1251.git.1654678407365.gitgitgadget@gmail.com>
        <202207051804341356418@oschina.cn>
        <220705.86o7y3am2m.gmgdl@evledraar.gmail.com>
Date:   Tue, 05 Jul 2022 11:06:00 -0700
In-Reply-To: <220705.86o7y3am2m.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 05 Jul 2022 12:15:44 +0200")
Message-ID: <xmqqr12zjuyf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 20F0867C-FC8D-11EC-AAA5-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> It would make sense to call this protocol verb "setenv", and just give
> it support for setting arbitrary remote environment, which we'd then
> have a whitelist configuration variable for, similar to how sshd(1) doe=
s
> it.

Sounds like a security hole in the making, with dubious risk-benefit
tradeoff.  I cannot honestly answer favourably to this question if
somebody asked me as the project read: Are you solving a real-world
problem, or creating one?

> Or maybe we can just add this as a "capability", which seems like a mor=
e
> natural fit,

I took your suggestion upthread to be hinting this.

> we could even stick it into "agent" I guess...

But not this.

> Anyway, while it definitely would be an improvement to pass this along,
> a much better way to go IMO (but also harder) is to extend the protocol
> so that we don't a emita human language at all, but emit defined error
> states for our various known errors.

I would not go there.

The end that sends errors in status code may be running a newer
version of the software and the particular status code it sent is so
new that the receiving end does not know how to translate it into
human language.

Doing the Accept-Language at the HTTP level, or its equivalent at
the protocol-capability level, has the opposite problem that the
remote end may not know the requested language at all, but at least
the side that sends unlocalized messages is aware of it doing so.

Also the error message sideband carries the same messages that are
meant to be read by humans in Git subcommands that are run by the
protocol software as well as human users.  We could introduce such a
"error status code" language as an artificial locale, translate
_("...") messages into such "status code language" on the end that
sends errors, and then re-translate them into human language locale,
but it is of a dubious value.  Such an approach would not work well
at the gettext layer anyway, as we need to deal with placeholders,
so it would be a lot more involved than just "lets have catalog of
printf formatting templates and translate them".

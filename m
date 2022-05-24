Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC044C433EF
	for <git@archiver.kernel.org>; Tue, 24 May 2022 22:29:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242188AbiEXW3F (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 18:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242193AbiEXW3C (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 18:29:02 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4284B876
        for <git@vger.kernel.org>; Tue, 24 May 2022 15:28:56 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BE808181B43;
        Tue, 24 May 2022 18:28:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=iwR1S9IZGV+H
        k4jSwQ41nWq2zEoXjjuj89fLiXcLjDI=; b=yJWVHIhZJfVNCjcbHVnPjgHu8Nbl
        /wB/uGZT+pz9qN9m8lvsQHV0TJCyKgliOEneQIGguRhA9NJKjSGV77RICiejdYN3
        lgz6+2q1p1wA07+702FHfCWnxqQLYnoM9IFkGDk7HR1Qq/jgoMUOeo+8xrM710qB
        3Yhkr1yYOtVY+Xk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B701E181B42;
        Tue, 24 May 2022 18:28:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6BAD9181B41;
        Tue, 24 May 2022 18:28:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Michael J Gruber <git@grubix.eu>
Subject: Re: [PATCH] http.c: clear the 'finished' member once we are done
 with it
References: <cover.1651859773.git.git@grubix.eu>
        <3f0e462e86625a3c253653e4a4eefabcd8590bf9.1651859773.git.git@grubix.eu>
        <xmqqtua2jtr0.fsf@gitster.g> <xmqqczgqjr8y.fsf_-_@gitster.g>
        <nycvar.QRO.7.76.6.2205232248360.352@tvgsbejvaqbjf.bet>
        <xmqqr14jluu4.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2205240124280.352@tvgsbejvaqbjf.bet>
        <xmqqa6b7lrw6.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2205241258510.352@tvgsbejvaqbjf.bet>
        <xmqqleuqj1gy.fsf@gitster.g>
        <220524.86r14ivewt.gmgdl@evledraar.gmail.com>
Date:   Tue, 24 May 2022 15:28:51 -0700
In-Reply-To: <220524.86r14ivewt.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 24 May 2022 22:38:30 +0200")
Message-ID: <xmqqleuqefa4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E3D208A8-DBB0-11EC-A916-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> I _think_ we can even get away by not doing anything to
>> slot->finished at the end of run_active_slot(), as we are not
>> multi-threaded and the callee only returns to the caller, but if it
>> helps pleasing the warning compiler, I'd prefer the simplest
>> workaround, perhaps with an unconditional clearing there?
>
> I'll admit I haven't fully looked into this again, but does anything in
> the subsequent analysis suggest that my original patch wouldn't be a
> working solution to this, still:
> https://lore.kernel.org/git/patch-1.1-1cec367e805-20220126T212921Z-avar=
ab@gmail.com/ ?

I traced _one_ code path as a demonstration to show why the current
"slot->finished =3D &finished" based solution works. =20

But I think what we need is to demonstrate a code path in the old
version that shows why the old slot->in_use would not have worked
and the slot->finished was needed, and demonstrate why it NO LONGER
is the case in today's code.  Without that, especially with the
latter, I cannot take the "just revert 16-year old bugfix because a
new compiler throws a warning related to multi-threaded code to it,
even though we are strictly single-threaded" as a serious solution.

And because I do not think I've seen anybody has done that necessary
digging, I would still prefer the "if the compiler somehow cares,
then let's clear the finished member once we are done with it" much
better than "we do not know why but we somehow think we can do
without this bugfix, even though we wouldn't be making noises about
this piece of code if a new compiler did not start emitting a
warning".

Thanks.


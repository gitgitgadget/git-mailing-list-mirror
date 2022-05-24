Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A78EC433EF
	for <git@archiver.kernel.org>; Tue, 24 May 2022 23:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242543AbiEXXTP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 19:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233046AbiEXXTO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 19:19:14 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB6B77F25
        for <git@vger.kernel.org>; Tue, 24 May 2022 16:19:13 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C32B3181F4C;
        Tue, 24 May 2022 19:19:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=aTjEfFnKfOKq
        vqwKr4v3ptTU52PpdNNOYcImHVxWZto=; b=GLfz3HOg521/RzvekXAdA2PNqkqf
        gCEIk5dGdWF2Lv32mqB0Y/9ueoHevZTzW16uhvCsA0Lae4O89A4TfmiQSpac+5Sw
        8anYeP/+grS73wPKjBFFd2S57CTesDKlAUQ7X+QI3IVda3ktr1TjKD40VW0igA6x
        Y0zmV4+DhgGGsMI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BC0D2181F4B;
        Tue, 24 May 2022 19:19:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7547E181F4A;
        Tue, 24 May 2022 19:19:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
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
        <20220524201639.2gucdkzponddk5qt@carlos-mbp.lan>
Date:   Tue, 24 May 2022 16:19:08 -0700
In-Reply-To: <20220524201639.2gucdkzponddk5qt@carlos-mbp.lan> ("Carlo
 Marcelo
        Arenas =?utf-8?Q?Bel=C3=B3n=22's?= message of "Tue, 24 May 2022 13:16:39
 -0700")
Message-ID: <xmqqo7zmcydv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: EA1DB908-DBB7-11EC-90D0-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com> writes:

> On Tue, May 24, 2022 at 10:15:57AM -0700, Junio C Hamano wrote:
>>=20
>> I _think_ we can even get away by not doing anything to
>> slot->finished at the end of run_active_slot(), as we are not
>> multi-threaded and the callee only returns to the caller, but if it
>> helps pleasing the warning compiler, I'd prefer the simplest
>> workaround, perhaps with an unconditional clearing there?
>
> Assuming that some overly clever compiler might optimize that out (eith=
er
> because it might think it is Undefined Behaviour or for other unknown
> reasons) then =C3=86var's version would be better for clearing the "war=
ning".

You keep saying undefined behaviour but in this case I do not quite
see there is anything undefined.

The warning, as =C3=86var said in a message, is about storing an address
of an object on the stack in another object whose lifetime lasts
beyond the life of the stackframe.  If you dereference such a
pointer _after_ we return from run_active_slot() function, the
behaviour may indeed be undefined.

But if you recall one such call trace I walked through for Dscho in
another message this morning, we do not make such a dereferencing.
The run_active_slot() function sets up the slot with the pointer to
its on-stack variable in it, we make a call chain that is several
levels deep, and at some point in the call chain, the request that
is represented by the slot may complete and slot may be passed to
finish_active_slot(), which would update (*slot->finished) thus
modifying the on-stack variable of the run_active_slot() that we
will eventually return to.

Is such a use of the pointer in the structure a cause for an
undefined behaviour?



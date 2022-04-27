Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A84C433F5
	for <git@archiver.kernel.org>; Wed, 27 Apr 2022 21:25:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbiD0V3J (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Apr 2022 17:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiD0V3I (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Apr 2022 17:29:08 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7C1222
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 14:25:56 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1C104194D19;
        Wed, 27 Apr 2022 17:25:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=b0HUmKYkoXObrLhL4wt7LGH17rYY6OB+dPsB7Z
        WhvQg=; b=I08tSQ4b4sHle+mwO0EZC63ozqYj7JmpgWSjHdktCZ8oUouChcfKmt
        Q4ZKiu4WkyCfxR23uw9Bp0925hmQQ5uR46hGdfx0TKb9rdT3WnCvbPWhaJbbf/r+
        E8LqlfoT5kNr43fsBoQXSlSfnL3iQvZEAPxGWs9ky+sHeNQuOZfBk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 14394194D18;
        Wed, 27 Apr 2022 17:25:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 933FB194D17;
        Wed, 27 Apr 2022 17:25:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        phillip.wood@dunelm.org.uk, git@vger.kernel.org,
        philipoakley@iee.email, me@ttaylorr.com, guy.j@maurel.de,
        szeder.dev@gmail.com, johannes.Schindelin@gmx.de,
        derrickstolee@github.com, Randall Becker <rsbecker@nexbridge.com>
Subject: Re: [PATCH] git-compat-util: avoid failing dir ownership checks if
 running privileged
References: <20220426183105.99779-1-carenas@gmail.com>
        <20220427000522.15637-1-carenas@gmail.com>
        <6522673b-494a-951c-be5e-3ca01577c12b@gmail.com>
        <fcd26e80-daee-2d66-cbdc-b004c478357d@gmail.com>
        <CAPUEspiHWTTAvNyqqLzcC854UccH=bkPLPBzPaPfzFKn_yt4aA@mail.gmail.com>
        <b0a80f47-f441-fc6e-3695-58ea83dea2b8@gmail.com>
        <xmqqzgk6l5ly.fsf@gitster.g>
        <CAPUEsph9tUkm+JsvU6z0Wt7mtRcTCH1vbvYTEdWjNyXzdoU=vw@mail.gmail.com>
Date:   Wed, 27 Apr 2022 14:25:50 -0700
In-Reply-To: <CAPUEsph9tUkm+JsvU6z0Wt7mtRcTCH1vbvYTEdWjNyXzdoU=vw@mail.gmail.com>
        (Carlo Arenas's message of "Wed, 27 Apr 2022 13:59:33 -0700")
Message-ID: <xmqqy1zqjk0x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9D1D304A-C670-11EC-B6D1-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Arenas <carenas@gmail.com> writes:

> On Wed, Apr 27, 2022 at 11:54 AM Junio C Hamano <gitster@pobox.com> wrote:
>
>> The "sudo sh to get a shell, chdir to /var/tmp/foo to do something"
>> use case does care---it needs to make sure that whereever it goes is
>> not part of a hostile repository.  So "if SUDO_UID is there, anything
>> goes" is not a good protection for such a use case.
>
> FWIW that was never part of the proposal, indeed making git aware of
> SUDO_ID when it is running as only as root was part of the design to
> avoid other users probably allowing repositories they don't control by
> having an evil SUDO_ID.

You forgot to quote:

    This is not a suggestion of an alternative, but is a discussion
    starter to illustrate the line along which we want to think
    about the issues.

that came before it.

>>  - do the comparison between st.st_uid and strtol() result by
>>    casting both to (long).  Without this, st.st_uid has a value that
>>    needs wider than long, we cannot allow the owner of such a
>>    repository in (and I somehow feel that is unlikely to happen).
>
> do you still want to cast both sides even if discarding values that would
> overflow an uid_t?

The variable used with strtol (or strtoull or whatever) does not
have to be casted.  The "both sides" was primarily for the case
where st.st_uid is wider than whatever integral type we used to
parse and hold the value we took from the environment, to force
the same truncation on st.st_uid as the truncation the environment
parsing may have caused.  But as I keep saying I do not think it is
worth it, which means ...

>>  - or omit the third one --- tough luck for those whose UID is
>>    beyond what a long can represent (and I somehow feel that this is
>>    probably OK).

... this one.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B32C433F5
	for <git@archiver.kernel.org>; Wed, 11 May 2022 14:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245339AbiEKO7z (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 May 2022 10:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245305AbiEKO7O (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 May 2022 10:59:14 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2642D222433
        for <git@vger.kernel.org>; Wed, 11 May 2022 07:58:30 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B5EB418F636;
        Wed, 11 May 2022 10:58:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8H4QTW+O1oAcbHTAZTdE8LMc2Wfopul0uN2WlK
        mgots=; b=qws7doRwmP0zClrC3Hfib+ZVISr6c9nbe1fEaUndZ8SLq8hin+zivq
        mCFL9tn/6hRJVvt5vzkw5Utvv6gnS5GCoO4v50P0I/dl1t6TlmXKzJFYBvg2uKTG
        hnTxFAheabzTA0KJ1bDkAqwmxuYOzGZqA3OO2RHMsAR4vhJIoxQ8M=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A552E18F635;
        Wed, 11 May 2022 10:58:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 46A5218F62C;
        Wed, 11 May 2022 10:58:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     git@vger.kernel.org, bagasdotme@gmail.com,
        phillip.wood123@gmail.com, Johannes.Schindelin@gmx.de,
        Guy Maurel <guy.j@maurel.de>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Randall Becker <rsbecker@nexbridge.com>
Subject: Re: [PATCH v4 2/3] git-compat-util: avoid failing dir ownership
 checks if running privileged
References: <20220507163508.78459-1-carenas@gmail.com>
        <20220510174616.18629-1-carenas@gmail.com>
        <20220510174616.18629-3-carenas@gmail.com>
        <xmqqv8ud5741.fsf@gitster.g>
        <CAPUEspiDeDm1p==H+yNq-s1cNyCyo8qOdqE20d7F4MVBi0thHw@mail.gmail.com>
Date:   Wed, 11 May 2022 07:58:24 -0700
In-Reply-To: <CAPUEspiDeDm1p==H+yNq-s1cNyCyo8qOdqE20d7F4MVBi0thHw@mail.gmail.com>
        (Carlo Arenas's message of "Wed, 11 May 2022 00:34:02 -0700")
Message-ID: <xmqqtu9wm7zj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CF036028-D13A-11EC-8A51-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Arenas <carenas@gmail.com> writes:

>> Does Windows provide sudo that leaves the original user in SUDO_UID
>> (I doubt it)?  If not, then "on a platform that provides sudo, it will"
>> would be sufficient.
>
> At least my windows box does not, but dscho's somehow had and so that
> line was added at his request[1] after he wasted so much time trying
> to get this to work and realized the function where SUDO_UID logic
> resides doesn't even exist in a Windows build.

Ahh, of course.  

I forgot that this patch sent into is_path_owned_by_current_uid(),
as a UID as a value of some integer type is not a thing on Windows.
OK, so it does need to be as you wrote to mean "not on Windows, and
with 'sudo' that uses 'SUDO_UID' to record from whom 'root' came".

OK.

>> > + * In the unlikely scenario this happened to you, and that is how you
>> > + * got to this message, we would like to know about it by letting us
>> > + * now with an email to git@vger.kernel.org indicating which platform,
>> > + * you are running on and which version of sudo you used to see if we
>> > + * can provide you a patch that would prevent this issue in the future.
>>
>> Nice.  What message does the reporter see?
>
> when using `sudo git status` a rejection of access to the directory they own

It may have been obvious to who wrote the above comment, but it was
not, at least to me.

>> > + */
>> > +static inline void extract_id_from_env(const char *env, uid_t *id)
>> > +{
>> > +     const char *real_uid = getenv(env);
>> > +
>> > +     /* discard anything empty to avoid a more complex check below */
>> > +     if (real_uid && *real_uid) {
>> > +             char *endptr = NULL;
>> > +             unsigned long env_id;
>> > +
>> > +             errno = 0;
>> > +             /* silent overflow errors could trigger a bug below */
>>
>> What "bug" are we referring to?
>
> All of them, the ones we decided to ignore because they are irrelevant
> when running as root, and the ones that are documented in the long
> paragraph above.

Likewise.  It did not click "a bug below" referred to "your sudo is
behaving in a way different from what we expected".

Thanks.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F2D1C433F5
	for <git@archiver.kernel.org>; Mon,  9 May 2022 19:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240631AbiEITpK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 May 2022 15:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbiEITpJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 May 2022 15:45:09 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDE352519
        for <git@vger.kernel.org>; Mon,  9 May 2022 12:41:13 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EF4C0181E8D;
        Mon,  9 May 2022 15:41:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Fv16/O/iKnpE6VNTGuOx/Fec8x+1kvBZ/wpTSx
        Xm0C0=; b=O65+o1r6WR16zZIlxTlRW2kGDZCRvW3hJr/eLLECa4wronZPAEIZvB
        A4rQeh0BXqVzX8v8mfNQgi2wyx6QPHPPwvNYuUC+BAgMFN6THXWzqHnTLPb2Sd/+
        FlgQNQvG5p+1TN2yr8rkl/Zz04nGPM08OzOOyP/tMleKEUihRkqns=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E8754181E8C;
        Mon,  9 May 2022 15:41:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8E37E181E89;
        Mon,  9 May 2022 15:41:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     git@vger.kernel.org, bagasdotme@gmail.com,
        phillip.wood123@gmail.com, Johannes.Schindelin@gmx.de,
        Guy Maurel <guy.j@maurel.de>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Randall Becker <rsbecker@nexbridge.com>
Subject: Re: [RFC PATCH v4 2/3] git-compat-util: avoid failing dir ownership
 checks if running privileged
References: <20220503065442.95699-1-carenas@gmail.com>
        <20220507163508.78459-1-carenas@gmail.com>
        <20220507163508.78459-3-carenas@gmail.com>
        <xmqqv8uhgsaz.fsf@gitster.g>
        <20220507185624.k5n6xihvzcuuj3vt@carlos-mbp.lan>
        <xmqq1qx2ejdv.fsf@gitster.g>
        <CAPUEspidmqiUYd3xB4QaR72YU=H8pA-3yNXxOF_MWyA_0wrKcA@mail.gmail.com>
Date:   Mon, 09 May 2022 12:41:07 -0700
In-Reply-To: <CAPUEspidmqiUYd3xB4QaR72YU=H8pA-3yNXxOF_MWyA_0wrKcA@mail.gmail.com>
        (Carlo Arenas's message of "Mon, 9 May 2022 11:48:31 -0700")
Message-ID: <xmqq7d6ucx4c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F919339A-CFCF-11EC-A937-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Arenas <carenas@gmail.com> writes:

> not that there are 2 different scenarios which we might seem to be
> flip flopping about :
>
> 1) victim gets attacked by tricking them into using the wrong SUDO_UID
>
> unlikely to be useful as you pointed out, and totally useless if we
> still restrict this code to run only as root

I think we established that we are not interested in this long ago.

> 2) attacker using this code to elevate privileges themselves
>
> only useful if this code is not run as root.

An attacker who is not root would not make the "what does SUDO_UID
say about the user we came from?", and "git" will not be setuid
binary, so I agree the code is not useful for such an attack,
either.

> My concern again, is not with this code AS-IS but how it might be used
> in the future.


I'd rather not such a "concern" to block us for too long.


>> Of course you can tell any user who runs "sudo" to set SUDO_UID to
>> 1000 + 64k and cause wrap-around, but then you can tell them to set
>> SUDO_UID to 1000 without relying on wrap-around and have the same
>> effect.  So, let's stop worrying about this bogus scenario.
>
> bogus only if we are still only running this code as root, of course.

And this code is only run to learn what SUDO_UID says, which is what
we check when we notice geteuid() says we are root.

>> As to the "we can break compilation with -Wsign-compare on a system
>> with signed uid_t", I agree that is true if we have
>
> Apologies for not documenting it until now, but I had
> -Wtautological-constant-out-of-range-compare in mind instead, but your
> are correct either one would work and the point was that (without
> having to add even an "static assert") we were able to find them and
> warn them that they need to patch.
>
>>         env_id <= (uid_t) -1
>
> If that was not enough, that simple code ALSO disabled the code in
> that case to make sure they MUST patch locally if they need to make it
> work, or come back to us to figure out a portable way to accommodate
> them in the future, with all the information about their system we
> currently lack.

Without a comment to say that, nobody would be able to figure out
that we are waiting for them to speak up.

	/* the code does not work on a system with signed uid */
	intmax_t tmp = (uid_t) -1;
	if (tmp < 0)
		BUG("report to git@vger that you have a signed uid_t");

or better yet, a compile-time equivalent, perhaps.

>> there.  But I am not sure if that is the most effective way to smoke
>> out platforms where this code has trouble working correctly.  Also,
>> I would think that a system with signed uid_t is a possibility, but
>> a user with a negative UID?
>
> It doesn't need to be a real user (specially if someone independently
> decides to remove the restriction that keeps this code available only
> to root).

When they break, they can keep both halves.  Is it our concern?

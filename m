Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1006DC433F5
	for <git@archiver.kernel.org>; Mon,  9 May 2022 16:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239321AbiEIQ6x (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 May 2022 12:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239305AbiEIQ6v (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 May 2022 12:58:51 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665F72B24D9
        for <git@vger.kernel.org>; Mon,  9 May 2022 09:54:57 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1AB32133887;
        Mon,  9 May 2022 12:54:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=/HLHZTHIivhe
        h1wf6FjtApvGt8SgFpGYcb2sz/SLs9Y=; b=bubG+0Hvh7tHFbHfCnah3WwRwkp4
        RlMn30ERQ9tEur5rBZefkn3NcxVWm/V6I/38k2yUmUzWix5vHCBdVc7oBxq0rjSz
        vBhPk+LdaBcvAa6umSQDzACdZp/SxPRo5huK+2m86qTh8LKZo0lkKF/yHVpxp9yp
        Y1qHTCftIPw2E+Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 10443133886;
        Mon,  9 May 2022 12:54:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6BCA5133885;
        Mon,  9 May 2022 12:54:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
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
Date:   Mon, 09 May 2022 09:54:52 -0700
In-Reply-To: <20220507185624.k5n6xihvzcuuj3vt@carlos-mbp.lan> ("Carlo
 Marcelo
        Arenas =?utf-8?Q?Bel=C3=B3n=22's?= message of "Sat, 7 May 2022 11:56:24
 -0700")
Message-ID: <xmqq1qx2ejdv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: BF74341C-CFB8-11EC-80E4-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com> writes:

>> In exchange, the only attack scenario the code prevents is this,
>> IIUC.
>>=20
>>  * You, the aspiring cracker, are a user not allowed to run "sudo" on
>>    the box, and you know your uid is 1000
>>=20
>>  * You look for another user, a potential victim, whose uid is 1000
>>    modulo 65536 (if your uid_t is 16-bit) and who can run "sudo" on
>>    the box.
>>=20
>>  * You prepare a malicious repository, invite that user there and
>>    ask them to run "sudo something" there.
>>=20
>> I'd say such an attack vector is not likely,...

Sorry, I was totally wrong here.

It is not just "not likely", but such an attack, with a potential
victim not futzing with SUDO_UID environment themselves, would not
work at all.  The value of SUDO_UID and the original uid of the
potential victim by definition should fit in the uid_t type.  So if
you, the aspiring cracker, have UID 1000, nobody else on the system
has UID that is congruent modulo uid_t and wrap-around attack does
not exist.  As long as the type we use to read SUDO_UID string into
a variable is not narrower than uid_t, there.

Of course you can tell any user who runs "sudo" to set SUDO_UID to
1000 + 64k and cause wrap-around, but then you can tell them to set
SUDO_UID to 1000 without relying on wrap-around and have the same
effect.  So, let's stop worrying about this bogus scenario.

As to the "we can break compilation with -Wsign-compare on a system
with signed uid_t", I agree that is true if we have

	env_id <=3D (uid_t) -1

there.  But I am not sure if that is the most effective way to smoke
out platforms where this code has trouble working correctly.  Also,
I would think that a system with signed uid_t is a possibility, but
a user with a negative UID?

I do not think even nobody4 was negative ;-)

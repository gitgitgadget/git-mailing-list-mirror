Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C26C433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 22:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbiCAWTp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 17:19:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiCAWTo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 17:19:44 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2723819E
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 14:19:02 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A227A1119E8;
        Tue,  1 Mar 2022 17:19:01 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=kJOphRyM+V6w
        0K1iVt1DsTTZtqTZsCSyvZ5V+NR19pI=; b=PaAYi/S0tuK2KgQjeAu9XDBbmj28
        De2kA8PQYESeJmqsEo5pQ8mPnPv25ATLqkgiurJ1NHtfkEH1mglgN6Gfe+6hwB1Z
        zipFyBzzNHxp2EUis4VrQTqnQqUBsVj1PQzgLAZkQk3rclanoeoqnW3lMq6T13zq
        keB8Cmr47hH79t8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 85B6A1119E7;
        Tue,  1 Mar 2022 17:19:01 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 59B3F1119E4;
        Tue,  1 Mar 2022 17:19:00 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: [PATCH] parse-options: make parse_options_check() test-only
References: <xmqqtuck3yv2.fsf@gitster.g>
        <20220228073908.20553-1-chakrabortyabhradeep79@gmail.com>
        <xmqqzgma287n.fsf@gitster.g> <xmqqr17lphav.fsf_-_@gitster.g>
        <220301.86pmn5z5we.gmgdl@evledraar.gmail.com>
Date:   Tue, 01 Mar 2022 14:18:59 -0800
In-Reply-To: <220301.86pmn5z5we.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 01 Mar 2022 22:57:17 +0100")
Message-ID: <xmqqo82pnwoc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 98385D38-99AD-11EC-873B-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Tue, Mar 01 2022, Junio C Hamano wrote:
>
>> The array of options given to the parse-options API is sanity
>> checked for reuse of a single-letter option for multiple entries and
>> other programmer mistakes by calling parse_options_check() from
>> parse_options_start().  This allows our developers to catch silly
>> mistakes early, but all callers of parse-options API pays this cost.
>> Once the set of options in an array is validated and passes this
>> check, until a programmer modifies the array, there is no way for it
>> to fail the check, which is wasteful.
>
> That's not true due to the "git rev-parse --parseopt" interface. I'd be

Meaning that a parse-options array can be fed by "rev-parse --parseopt"
and having the sanity check enabled does help the use case?  Even there,
I would say that once the script writer finishes developing the script
that uses "rev-parse --parseopt", setting the parseopt input in stone,
there is no need to check the same thing over and over again.  Am I
mistaken?  Does "rev-parse --parseopt" that is fed the same input
sometimes trigger the sanity check and sometimes not?

> I see the benifit of Johannes's suggestion of checking this once (but
> with t0012-help.sh etc. we're nowhere near being able to do that).
>
> Now this runs for the whole test suite, so our tests will have the the
> same behavior.

The code for sanity check is there ONLY to help those who develop
while they develop, and it is logical to enable it during our tests.
There is no reason to trigger the sanity check in the end-user
environment, no?

> So aren't we shaving microseconds off the runtime here?

No, the problem I have with the runtime check is more at the
conceptual level.  Those who remove assert() by setting _NDEBUG
would not be doing so to save nanoseconds, either.

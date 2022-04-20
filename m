Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A2ADC433F5
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 17:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381054AbiDTR1y (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 13:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381067AbiDTR1w (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 13:27:52 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97AD1DEAE
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 10:25:05 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 58D25114CD1;
        Wed, 20 Apr 2022 13:25:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=5wW8nhLJIk+S
        Bnlje7HFxaCneIHWmOM8kn5LGEm+cdg=; b=Rveit7PebeA03MBMV9RTuVS4DGZH
        TSl5arqepFnlQFMWmMmNbTMSOScstxv5ugbio7ei/aE1jggdZEIDPqlDrwbqbJEZ
        nXLmYIjX4I4TGuHCt55xDseeegzHmOcd3yGtSUKV1KabNl9hbHTAUWQljk/kJdXl
        bR01qEoiaR/i7X4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3325C114CCE;
        Wed, 20 Apr 2022 13:25:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C99C3114CCD;
        Wed, 20 Apr 2022 13:25:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Anthony Sottile <asottile@umich.edu>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: git 2.36.0 regression: pre-commit hooks no longer have
 stdout/stderr as tty
References: <CA+dzEBn108QoMA28f0nC8K21XT+Afua0V2Qv8XkR8rAeqUCCZw@mail.gmail.com>
        <Yl9Hn0C0TwalASC0@google.com>
        <6aabbcd6-f6c2-fe97-eb73-593bcf2e9e75@gmail.com>
        <xmqqr15rr9k6.fsf@gitster.g>
        <CAJoAoZm7p32Hn=TLQeWUqp_nMjo_TQ2whR4F=cXk4c6PV1M5bA@mail.gmail.com>
Date:   Wed, 20 Apr 2022 10:25:01 -0700
In-Reply-To: <CAJoAoZm7p32Hn=TLQeWUqp_nMjo_TQ2whR4F=cXk4c6PV1M5bA@mail.gmail.com>
        (Emily Shaffer's message of "Wed, 20 Apr 2022 10:09:38 -0700")
Message-ID: <xmqqilr3r7ki.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D0150EFC-C0CE-11EC-8253-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

>> In the longer term, there are multiple possible action items.
>> ...
>>
>>  * We should teach hooks API to make it _optional_ to use the
>>    parallel subprocess API.  If we are not spawning hooks in
>>    parallel today, there is no reason to incur this regression by
>>    using the parallel subprocess API---this was a needress bug, and
>>    I am angry.
>
> To counter, I think that having hooks invoked via two different
> mechanisms depending on how many are provided or whether they are
> parallelized is a mess to debug and maintain. I still stand by the
> decision to use the parallel subprocess API, which I think was
> reasonable to expect to do the same thing when jobs=3D1, and I think we
> should continue to do so. It simplifies the hook code significantly.

A simple code that does not behave as it should and causes end-user
regression is not a code worth defending.  Admitting it was a bad
move we made in the past is the first step to make it better.

The use of the parallel subprocess API in the hooks was prematurely
done, before we had clear use cases for running multiple hooks in
parallel, and due to the lack of use cases, we didn't have chance to
think about the issues that need to be addressed before we can start
using the parallel subprocess API.  The message you are responding to
was written with an explicit purpose of starting to list them.

>>  * the hooks API should learn a mechanism for multiple hooks to
>>    coordinate their executions.  Perhaps they indicate their
>>    preference if they are OK to be run in parallel, and those that
>>    want isolation will be run one-at-a-time before or after others
>>    run in parallel, or something.
>
> There is such a mechanism for hooks overall, but not yet for
> individual hooks. I know we discussed it at length[1] before, and

This...

> decided it would be okay to figure this out later on. I suppose "later
> on" may have come :)

Yes, besides patching up this regression for short term, I listed it
as a possible ation item for the longer term.

>>  * The hooks API should learn a mechanism for us to tell what
>>    execution environment they are in.  Ideally, the hooks, if it is
>>    sane to run under the parallel subprocess API, shouldn't have
>>    been learning if they are talking to an interactive human user by
>>    looking at isatty(), but we should have been explicitly telling
>>    them that they are, perhaps by exporting an environment
>>    variable.  There may probably be more clue hooks writers want
>>    other than "am I talking to human user?" that we would want to
>>    enumerate before going this route.
>
> Hm. I was going to mention that =C3=86var and I discussed the possibili=
ty
> of setting an environment variable for hook child processes, telling

That...

> them which hook they are being run as - e.g.
> "GIT_HOOK=3Dprepare-commit-msg" - but I suppose that relying on that
> alone doesn't tell us anything about whether the parent is being run
> in tty. I agree it could be very useful to simply pass
> GIT_PARENT_ISATTY to hooks (and I suppose other child processes).
> Could we simply do that from start_command() or something else deep in
> run-command.h machinery? Then Anthony's use case becomes
>
> if [-t 1|| GIT_PARENT_ISATTY]
>  ...
>
> and no need to examine Git version.

But DO NOT call it ISATTY.  "Are we showing the output to human
end-users" is the question it is answering to, and isatty() happens
to be an implementation detail on POSIXy system.

"This" and "That" above make it smell like discussion was done, but
everybody got tired of discussing and the topic was shipped without
necessary polishment?  That sounds like a process failure, which we
may want to address in the new development cycle, not limited to this
particular topic.

Thanks.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A25C433EF
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 17:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbiGMRG0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 13:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiGMRGY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 13:06:24 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6772E9F8
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 10:06:23 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1FFFD1B4D89;
        Wed, 13 Jul 2022 13:06:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=h9cWIfdRDblk7WVcdqaWNZzLQVkY4x2qA7cD+k
        Z0L4Y=; b=EWceUM3XcQxfuu7ci7Uhac9iAkmknF47Of8l8hn/sy0sTg0+WCLHR+
        jayAl4QpcjoYmMjHwF9ynpZmzYnufx+alnrROIWM/FFgf+5QD0Pcb2ogVrj7Sze1
        jM9s68neYnuNWUF8FF/nN0mBAuD3N9WBpAmBzBCSwQmeCln/1lmio=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1862D1B4D88;
        Wed, 13 Jul 2022 13:06:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 720621B4D87;
        Wed, 13 Jul 2022 13:06:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Britton Kerin <britton.kerin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: BUG: git-check-ignore documentation doesn't come close to
 describing what it really does
References: <CAC4O8c9izkV5vbnE6MH8-RwnxRbUONxJxYZO+hb1J0ewuDtX+w@mail.gmail.com>
        <CABPp-BG5qjp9Rx+=CCeLMiOH2Bqpa3kmBWRWdu7fTtPM-H=3kA@mail.gmail.com>
Date:   Wed, 13 Jul 2022 10:06:16 -0700
In-Reply-To: <CABPp-BG5qjp9Rx+=CCeLMiOH2Bqpa3kmBWRWdu7fTtPM-H=3kA@mail.gmail.com>
        (Elijah Newren's message of "Tue, 12 Jul 2022 17:17:23 -0700")
Message-ID: <xmqqtu7lc587.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1C030666-02CE-11ED-BF17-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> I suspect we're having an aliasing problem that you're not
> recognizing.  "ignored" and "excluded" are used interchangeably, note
> that patterns from the $GIT_DIR/info/exclude files and patterns from
> the file pointed to by core.excludesFile are also lumped together with
> the patterns from all the .gitignore files (see the gitignore manual
> page).  Further, the internal code refers to them all as "excludes"
> not as "ignores".

All true.

> Yes, it outputs the paths that are excluded, as the documentation
> said.  Perhaps there's a way to reword it to make this clearer?  I
> don't think we can get rid of the alias given the fact that
> $GIT_DIR/info/exclude and core.excludesFile are hard-coded and must be
> kept for backward compatibility.  But suggestions to improve the
> wording would be great.
>
> Maybe it'd be as simple as replacing "is excluded" with "matches an
> ignore/exclude rule"?

I smell a continuation of 7ec8125f (check-ignore: fix documentation
and implementation to match, 2020-02-18), which appears in 2.26 and
later (the way the negative entries in the ignore/exclude mechanism
gets handled has changed in Git 2.26, and the documentation has been
updated).

"Is excluded" is perfectly fine, I think.  The first use of that
verb in the documentation should be a bit more careful, e.g. "is
excluded (aka ignored)" or something.

>> IMO the behavior of git-check-ignore is the correct and useful
>> behavior
>
> I'm with you here.

Yup, with the old "huh?" fixed in Git 2.26 (which was there simply
because check-ignore was not used to be a serious end-user facing
program but was more of a debugging aid), I think the behaviour of
the command we have today is what we want.

>> and the documentation should simply be fixed
>
> Yes, I agree it's easy to misinterpret.  Would my suggested changes help?
>
>> to reflect the
>> fact that it just lists matching entries rather than wrongly claiming
>> that it returns the overall result of the ignore calculation.
>
> I think I understood where the problems were in the documentation that
> could lead to misinterpretations in the other two cases you mentioned
> earlier in your email, but I don't understand this one.  Even the
> first sentence you quoted included the phrase that it could "output
> the path", so I'm not sure where you think it claims that it'd return
> the overall result of the ignore calculation.  Could you point out
> what in the document led you to believe it was claiming this?  Maybe I
> could suggest wording improvements for it as well.  Or maybe you have
> some.

It does return *the* matching entry that decided the path's fate.

    $ (echo '/no-such-*'; echo '!/no-such-*') >>.git/info/exclude
    $ git check-ignore -v no-such-directory; echo $?
    .git/info/exclude:14:!/no-such-*	no-such-directory
    0

Exit status section needs a bit more work.  It used to be OK to say
"success (0) is returned when we found a path that is ignored", but
these days, it is not whether there are ignored paths in the input.

It signals if we found an entry in the list of exclude/ignore
patterns that actively affects the path's fate.  In our project, if
we ask the fate of hello.c

    $ git check-itnore -v hello.c; echo $?
    1

because we do not say explicitly that .c files are usually tracked
sources.  If we did this:

    $ echo >>.git/info/exclude '!*.c'

to explicitly say that .c files are never ignored, it changes the
picture:

    $ git check-itnore -v hello.c; echo $?
    .git/info/exclude:15:!*.c	hello.c
    0



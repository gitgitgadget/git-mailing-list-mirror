Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E15DC433F5
	for <git@archiver.kernel.org>; Thu, 23 Dec 2021 22:37:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbhLWWhc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Dec 2021 17:37:32 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52742 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbhLWWhc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Dec 2021 17:37:32 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 678B6EF74D;
        Thu, 23 Dec 2021 17:37:31 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=EVW3U5l9p4uN
        FumzAhURgxuNDruDcBXph6h2KQ1UMe0=; b=gfntqE3odIQmnP6my6hmDY/d1Rge
        nFRoVFgh2X5tJlrgmWogHjT1JK48Suqts/o+szLJBZ9T1pGOSW8gGx+T/B0yNkUn
        ivaJaJd0lcem+QhH4JYNgD4GhF3cQsDxJ1Oi6vpRY8lYggbFm+ByjPb/Gb4lNmjt
        m+60WH1BxnRrbOM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5F8D1EF74A;
        Thu, 23 Dec 2021 17:37:31 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C0ACFEF749;
        Thu, 23 Dec 2021 17:37:30 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v5 7/7] grep: simplify config parsing and option parsing
References: <cover-v4-0.7-00000000000-20211203T101348Z-avarab@gmail.com>
        <cover-v5-0.7-00000000000-20211222T025214Z-avarab@gmail.com>
        <patch-v5-7.7-63de643ebc2-20211222T025214Z-avarab@gmail.com>
Date:   Thu, 23 Dec 2021 14:37:29 -0800
In-Reply-To: <patch-v5-7.7-63de643ebc2-20211222T025214Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 22 Dec
 2021 03:58:57
        +0100")
Message-ID: <xmqqv8zf6j86.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E9FDF67A-6440-11EC-9F62-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Simplify the parsing of "grep.patternType" and
> "grep.extendedRegexp". This changes no behavior, but gets rid of
> complex parsing logic that isn't needed anymore.
>
> When "grep.patternType" was introduced in 84befcd0a4a (grep: add a
> grep.patternType configuration setting, 2012-08-03) we promised that:
>
>  1. You can set "grep.patternType", and "[setting it to] 'default'
>     will return to the default matching behavior".

You need to call it into readers' attention that back then the
author of that commit meant by "the default" to mean "whatever the
configuration system specified before the patch applied, i.e. with
grep.extendedRegexp".

>  2. We'd support the existing "grep.extendedRegexp" option, but ignore
>     it when the new "grep.patternType" option is set. We said we'd
>     only ignore the older "grep.extendedRegexp" option "when the
>     `grep.patternType` option is set. to a value other than
>     'default'".

Yes, in short, you can think of it this way.

 - We use grep.patternType as the source of truth.  It is a usual
   last-one-wins variable, with values like fixed, basic, pcre,
   etc.

 - There however is a special value 'default', which may mean
   'basic' or 'extended', depending on what grep.extendedRegexp is
   set to.

> In a preceding commit we changed grep_config() to be called after
> grep_init(), which means that much of the complexity here can go
> away.
>
> Now as before when we only understand a "grep.extendedRegexp" setting
> of "true", and if "grep.patterntype=3Ddefault" is set we'll interpret i=
t
> as "grep.patterntype=3Dbasic",

Is that a typo?  If extendedRegexp is set to 'true', then the
'default' would mean 'extended', so I would expect that we'd
see it as the same as setting it 'grep.patternType=3Dextended'.

> except if we previously saw a
> "grep.extendedRegexp", then it's interpreted as
> "grep.patterntype=3Dextended".

I am not sure what this means.  grep.extendedRegexp is also a usual
last-one-wins variable.  If you had this series:

    git \
    -c grep.extendedRegexp =3D false \
    -c grep.extendedRegexp =3D true \
    -c grep.patternType =3D default \
    some-command-that-take-regexp

the last grep.extendedRegexp is true, and the last grep.patternType
is default, so the command sould work on extended.  It is also true
if you had

    git \
    -c grep.extendedRegexp =3D false \
    -c grep.patternType =3D default \
    -c grep.extendedRegexp =3D true \
    some-command-that-take-regexp

That is why it is important to remember the fact that patternType
was give as "default" before you finish reading the configuration
and you are sure you know the last value of grep.extendedRegexp.
Only after that, you can resolve what that "default" means between
"basic" and "extended".  Trying to interpret "default" as soon as
you see it in grep.patternType and trying to make it into either
"basic" or "extended" will not work unless you know you have the
final value of grep.extendedRegexp.

> We don't need grep_commit_pattern_type() anymore,...

And I think that is what this function wanted to say: "we now have
seen all necessary, so we can commit what pattern type we are going
to use; before this point, we couldn't tell what 'default' meant".

So I am not sure how any change that says we do not need the
"commit" phase can be correct.

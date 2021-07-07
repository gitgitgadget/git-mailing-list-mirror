Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01706C07E95
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 19:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBC5861CC3
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 19:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbhGGUAU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jul 2021 16:00:20 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63364 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbhGGUAU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jul 2021 16:00:20 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 84F69134E27;
        Wed,  7 Jul 2021 15:57:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kVuh4FK3EjM2WyT4Z3uWlkcFyA7x6eQNAgaKAD
        BQCEs=; b=QvMtcNmfjfSJGZQLnWUadRtN49O5UQiO8eNN5NDBh1LJV7PUYJtqPK
        jgytGn9VJaI8/g5k6OMWjQ3blcljBKgirRAwrzM4cznszwrXhNXTs/mVWSqrQwTX
        SRbEsRW+8zdO0Bb/MS937yPyYyKwKXLqPIPxUIK6GRjZWh4FgYSA0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7C469134E24;
        Wed,  7 Jul 2021 15:57:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id F2D05134E23;
        Wed,  7 Jul 2021 15:57:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Rafael Silva <rafaeloliveira.cs@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: Re: [GSoC] [PATCH 3/3] submodule--helper: introduce add-clone
 subcommand
References: <20210706181936.34087-1-raykar.ath@gmail.com>
        <20210706181936.34087-4-raykar.ath@gmail.com>
Date:   Wed, 07 Jul 2021 12:57:28 -0700
In-Reply-To: <20210706181936.34087-4-raykar.ath@gmail.com> (Atharva Raykar's
        message of "Tue, 6 Jul 2021 23:49:36 +0530")
Message-ID: <xmqqr1g9ew2f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9041D66E-DF5D-11EB-B0C1-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Atharva Raykar <raykar.ath@gmail.com> writes:

> Let's add a new "add-clone" subcommand to `git submodule--helper` with
> the goal of converting part of the shell code in git-submodule.sh
> related to `git submodule add` into C code. This new subcommand clones
> the repository that is to be added, and checks out to the appropriate
> branch.
>
> This is meant to be a faithful conversion that leaves the behaviour of
> 'submodule add' unchanged.

Makes sense.

> The 'die' that is used in git-submodule.sh is not the same as the
> 'die()' in C--the latter prefixes with 'fatal:' and exits with an error
> code of 128, while the shell die exits with code 1.
>
> Introduce a custom die routine, that can be used by converted
> subcommands to emulate the shell 'die'.

I suspect that installing this with set_die_routine() might be going
too far.  If some of the lower-level helper routines we call from
here have to die (e.g. our call results in xmalloc() getting called
and we run out of memory), die() called there will also end up
calling our submodule_die(), not just new calls to die() you are
adding in this patch.  Calling submodule_die() directly from the
code you convert from the scripted version where we used to call die
of the scripted version would be fine, though.

I suspect that it would be OK to use the standard die() instead,
with the minimum adjustment as needed, namely, we may have to

 * Adjust the messages the scripted version of the caller gave to
   the scripted version of die, if needed (e.g. if the scripted
   version added "fatal:" prefix itself to compensate for the lack
   of it in the scripted "die", we can drop the prefix and call the
   standard die());

 * Adjust the tests if they care about the differences between
   exiting 128 and 1.

> +static NORETURN void submodule_die(const char *err, va_list params)
> +{
> +	vfprintf(stderr, err, params);
> +	fputc('\n', stderr);
> +	fflush(stderr);
> +	exit(1);
> +}


Other than that, all three patches looked quite reasonable.

Thanks.

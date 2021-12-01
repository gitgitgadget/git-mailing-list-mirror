Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6819DC433F5
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 18:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352574AbhLASmV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 13:42:21 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62240 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238768AbhLASmT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 13:42:19 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0BDDBF9135;
        Wed,  1 Dec 2021 13:38:58 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=YmJNc8X9zzOF
        0ldeY6UEcXAAp5+GfklQIusfu5yPsBw=; b=ER/JSUpwfRo6hyycOtCzNkM02FFY
        ghc0rzZQIyLrRlGfiwFbDRbyfLFmyoj0T0BHR1dPbjRL/264oV5E0prlQLDYqJH+
        ChPZ6yuBfNbMIgLpyHc+FXPSsEvCDpBtQUH+mtNQlK4SOyDW9K8xUUOICIZ/GxX+
        HExIuOPMGXtH2c4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0282CF9134;
        Wed,  1 Dec 2021 13:38:58 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 634CFF9133;
        Wed,  1 Dec 2021 13:38:57 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] test-lib.sh: have all tests pass under "-x", remove
 BASH_XTRACEFD
References: <pull.1085.git.1638193666.gitgitgadget@gmail.com>
        <patch-1.1-9f735bd0d49-20211129T200950Z-avarab@gmail.com>
Date:   Wed, 01 Dec 2021 10:38:56 -0800
In-Reply-To: <patch-1.1-9f735bd0d49-20211129T200950Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 29 Nov
 2021 21:13:23 +0100")
Message-ID: <xmqqpmqg1873.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F1766382-52D5-11EC-B5E3-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change the "t1510-repo-setup.sh" test to use a new
> "test_must_be_empty_trace" wrapper, instead of turning on
> "test_untraceable=3DUnfortunatelyYes".
>
> The only reason the test was incompatible with "-x" was because of
> these "test_must_be_empty" checks, which we can instead instead skip
> if we're running under "set -x".
>
> Skipping the tests is preferable to not having the "-x" output at all,

Even more preferrable is not to skip the tests, no?  Is this because
we capture the standard error stream and do not care where, between
the command being tested and the shell running the command, the
output came from?

> Once that's been removed we can dig deeper and see that we only have
> "BASH_XTRACEFD" due to an earlier attempt to work around the same
> issue. See d88785e424a (test-lib: set BASH_XTRACEFD automatically,
> 2016-05-11) and the 90c8a1db9d6 (test-lib: silence "-x" cleanup under
> bash, 2017-12-08) follow-up.

If the objective is to work around the "shell trace and program
output are mixed together" issue, BASH_XTRACEFD is doing much more
superb job to "solve" it than "some tests depend on running without
'-x', so punt and skip them" to "work around" it, I would have to
say.

> It's better if our test suite works the same way on all shells, rather
> than getting a passing run under "bash", only to have it fail with
> "-x" under say "dash". As the deleted code shows this is much simpler
> to implement across our supported POSIX shells.

It is much simpler to punt and skip all tests.  You can even have
"if run with -x stop and skip all" in early part of test-lib.sh and
that would "work around" without developers constantly having to
worry about the distinction between test_must_be_empty and the trace
variant.

It is a sad that you have to trade one good thing for another.
Somehow, this change feels like a regression, not an improvement.



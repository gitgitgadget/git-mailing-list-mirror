Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFAEC433EF
	for <git@archiver.kernel.org>; Mon, 11 Apr 2022 22:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbiDKXBz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Apr 2022 19:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbiDKXBz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Apr 2022 19:01:55 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8201ADB9
        for <git@vger.kernel.org>; Mon, 11 Apr 2022 15:59:38 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3A981189CE2;
        Mon, 11 Apr 2022 18:59:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=vnsnzE76LOry
        tTCRvMTHCyeTrU9J9XjZ/Io+4pcEgrg=; b=UoZ375F0uQ5jT/AJi1a3OlRMu5It
        bpJY0yMCe2+WJgkKQs/QTmkbe3nsW9owlcBSECtrNOWRiw6hGGPovKIkrPS38ukL
        19QOU+3W8/oSwfUUD7lk3V7r5zOTV8K+428OfiRAfIS2eT7VVPBZVA+VTShOwcxv
        rP8oPqZqL3AeiG8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 340ED189CE1;
        Mon, 11 Apr 2022 18:59:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9244C189CE0;
        Mon, 11 Apr 2022 18:59:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] Makefile: add a prerequisite to the
 coverage-report target
References: <20220409043033.1288946-1-gitter.spiros@gmail.com>
        <xmqqv8vfiidm.fsf@gitster.g>
        <220411.86fsmji970.gmgdl@evledraar.gmail.com>
Date:   Mon, 11 Apr 2022 15:59:34 -0700
In-Reply-To: <220411.86fsmji970.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 11 Apr 2022 23:27:42 +0200")
Message-ID: <xmqqpmlnfcq1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0EA9DC46-B9EB-11EC-B2FF-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I haven't come up with a patch for these coverage targets, but I think
> it would be much more useful to:
>
>  * Not have the target itself compile git, i.e. work like SANITIZE=3Dle=
ak,
>    there's no reason you shouldn't be able to e.g. combine the two
>    easily, it's just a complimentary set of flags.
>
>  * We should be able to run this in parallel, see
>    e.g. https://stackoverflow.com/questions/14643589/code-coverage-usin=
g-gcov-on-parallel-run
>    for a trick for how to do that on gcc 9+, on older gcc GCOV_PREFIX*
>    can be used.
>
>    I.e. we'd save these in t/test-results/t0001.coverage or whatever,
>    and then "join" them at the end.

I can see how this might lead to "Ah, *.coverage file exists so we
run report to show that existing result", but it is not reasonable
to say "we didn't touch t0001 so we do not have to rerun the script
under coverage-test" because whatever git subcommand we use may have
be updated (we _could_ describe the dependency fully so we only
re-run t0001 if any of t0001-init.sh, "git init", "git config", and
"git" is newer than the existing t0001.coverage; I do not know if
that is sensible, though).  And ...

> I wonder if the issue this patch is trying to address would then just g=
o
> away, i.e. isn't it OK that we'd re-run the tests to get the report
> then? gcov doesn't add that much runtime overhead.

... I don't think overhead of gcov matters all that much.  Overhead
of "Having to" rerun tests primarily comes from running the tests,
with or without gcov enabled, so...

Or are you suggesting that we'd enable gcov in all our test runs by
default?


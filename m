Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FCD7C433F5
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 18:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376622AbhLBSj1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Dec 2021 13:39:27 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50342 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235498AbhLBSj0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Dec 2021 13:39:26 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1F11810193B;
        Thu,  2 Dec 2021 13:36:03 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=04igsF5hOpHxFAax/NIBNEveWkMmdIibFxdW6x
        cDjWo=; b=aefvxJ1V6Xok9ffdkPSuyZkF9yEH41nSoJH9p1w7s1rbm8hD3xnB4m
        XsOEQ9B/IGx95fOKZwBaLgOQMEzM8Fb2MGVX1z2mxYhP0mzT1qOz2X0rj5Bc3/6k
        T7tCZ/uNYKMSnpyP4L+Z5COjeCS7UtXJaresU3wVmnAry9A4hKAI0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 152FF10193A;
        Thu,  2 Dec 2021 13:36:03 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5C58E101939;
        Thu,  2 Dec 2021 13:36:02 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 5/5] refs/debug: trim trailing LF from reflog message
References: <pull.1145.git.git.1637590855.gitgitgadget@gmail.com>
        <pull.1145.v2.git.git.1637855872.gitgitgadget@gmail.com>
        <0288e743eb2e96e2effd6b0b90c6f885009bf337.1637855872.git.gitgitgadget@gmail.com>
        <xmqqilwf72nf.fsf@gitster.g>
        <CAFQ2z_N20ESyzkPLdGbS9q8HEHGB7_gmaX8FUBR=jGqXLGcL1Q@mail.gmail.com>
        <xmqq1r2y7ork.fsf@gitster.g>
        <CAFQ2z_NYgsiLM1Ffw3O9gAFHVuq68iAfrRbgodHdUPRo5Pm0UA@mail.gmail.com>
Date:   Thu, 02 Dec 2021 10:36:01 -0800
In-Reply-To: <CAFQ2z_NYgsiLM1Ffw3O9gAFHVuq68iAfrRbgodHdUPRo5Pm0UA@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Thu, 2 Dec 2021 17:24:28 +0100")
Message-ID: <xmqq7dcmvoq6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B390087E-539E-11EC-9DFC-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> On Mon, Nov 29, 2021 at 8:20 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Han-Wen Nienhuys <hanwen@google.com> writes:
>>
>> > On Fri, Nov 26, 2021 at 9:16 AM Junio C Hamano <gitster@pobox.com> wrote:
>> >>
>> >> The API promises to have only LF, not CRLF, at the end, so
>> >> strbuf_trim_trailing_newline() is a bit overkill (and if payload
>> >> happened to end with CR, we would lose it).
>> >
>> > it would be best if there was a way to escape characters (ie. "\n" =>
>> > "\\n"). Do we have a function for that?
>>
>> Mere escaping would not work in a backward compatible way, without a
>> trick.  It was envisioned that we probably could encode *and* signal
>
> I'm talking about the debug output, which isn't subject to
> compatibility guarantees.

There is no need to show "\n" in the debug output in the first
place, no?  The message part stored in the reflog database is
already normalized to have each runs of whitespaces (including CR
and LF) turned and squashed into a single SP, so the LF at the end
is constant that the debug output can unconditionally strip without
losing information.

Or are we talking about logging the _input_ to be recorded as the
message for a new reflog entry?  Then I agree we can do whatever,
and if you prefer C-style quoting, the helpers in quote.c are your
friends.

Thanks.



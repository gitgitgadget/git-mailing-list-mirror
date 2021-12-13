Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35081C433EF
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 04:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbhLMEoU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Dec 2021 23:44:20 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58878 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbhLMEoU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Dec 2021 23:44:20 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5D9A610D334;
        Sun, 12 Dec 2021 23:44:19 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=3l3cq5eSx7SGsc+g6Te7MI7v/
        BTdJsEG5NNEbLm1jGg=; b=hiH7h2fJ+2aCxjAvr4Z8TeHFhzLVA5TwjXZR/qWGT
        LkDo3OulkxNxQgAsSxeuBNt0JJ18wOviE0kemeGHN+8f0lpRFR2RCLDshkQtfvn1
        JbsQB/YEO6ie91FakLVse2KF5ghIPe0DkmksLDbY97f6nbeoUG0vYXWMMch4yjHX
        Bs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 45C3A10D332;
        Sun, 12 Dec 2021 23:44:19 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9452810D330;
        Sun, 12 Dec 2021 23:44:18 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: ab/only-single-progress-at-once
References: <xmqqilvvluoa.fsf@gitster.g>
        <211212.86sfuxac8c.gmgdl@evledraar.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
X-Gnus-Delayed: Mon, 13 Dec 2021 00:12:29 -0800
Date:   Sun, 12 Dec 2021 20:44:17 -0800
Message-ID: <xmqqmtl5gllq.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 55212CE4-5BCF-11EC-9E5B-E10CCAD8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Fri, Dec 10 2021, Junio C Hamano wrote:
>
>> * ab/only-single-progress-at-once (2021-11-03) 8 commits
>>  - progress.c: add & assert a "global_progress" variable
>>  - various *.c: use isatty(0|2), not isatty(STDIN_FILENO|STDERR_FILENO=
)
>>  - pack-bitmap-write.c: don't return without stop_progress()
>>  - progress.c: add temporary variable from progress struct
>>  - progress.c tests: test some invalid usage
>>  - progress.c tests: make start/stop commands on stdin
>>  - progress.c test helper: add missing braces
>>  - leak tests: fix a memory leaks in "test-progress" helper
>>
>>  Further tweaks on progress API.
>>
>>  Needs review.
>>  The last three rounds has seen little reaction, even though earlier
>>  round saw a lot of responses. The latest round needs a serious
>>  review or at least Acks from past commentors.
>>  source: <cover-v6-0.8-00000000000-20211102T122507Z-avarab@gmail.com>
>
> I think less in "needs review" and more in needing a tiebreaker and/or
> reply to my [1]. I.e. the ongoing discussion SZEDER and I have had abou=
t
> the relative danger of adding this BUG() to this part of the code.

I thought the BUG() thing has been already settled a few iteration
ago, but now you bring it up back, I read that part again.

In code that is directly about the correctness of the feature, I do
agree with the statement you made (paraphrasing---use of BUG() is
appropriate when we see a condition that should never trigger or our
code is buggy and not behaving the way we intended, and it is better
to stop before spreading the damage and eating user's data), but eye
candy like progress bars, I do not think it is end-user friendly to
kill the operation they started.  Of course, when they report a bug,
we may be able to say "please run with --no-progress to work it
around in the meantime" after thanking them for reporting, so it may
not be such a big deal either way.

> Which is fair enough, but I'd think a good way forward with it would be
> to give it wider exposure during this cycle. If it's triggered somehow
> it's trivial to amend/revert the tip commit to remove the assertion.
>
> If we merge it down I promise I'll (and try to remember to, putting it
> in my calendar if so...) start some discussion before the next release
> about whether we'll want to cut the release with that BUG(), which if w=
e
> don't trigger it by then we'll probably feel confident about keeping.
>
> Does that sound like a good way forward? Otherwise the "one alternative
> way forward[...]" mentioned in [1] is something we could do.

I'm OK with marking it as "will cook in 'next'" to keep it longer
than usual, but I do not think merging down iffy code to 'next' or
even 'master' will give us better chance to expose the issue.  You
will not get a real-user feedback until it hits a release, which is
unfortunately way too late X-<.


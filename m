Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D44CC433EF
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 18:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239847AbhKWSeO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 13:34:14 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53700 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239829AbhKWSeN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 13:34:13 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5A7C715D3DC;
        Tue, 23 Nov 2021 13:31:05 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=eYglfDo2BXm1
        lneJz3IFDJPtZlUbn5QLBVYYHZd9MG0=; b=lTQYkRyWFH0M/7INia5shW/nXnig
        7euMIFHvy7xy0H4YXyqjjR81+xKWPTx/QHBKlpGtRuFEh8JeFAgVsicSo3lAJqPb
        T6YqOqaHBtFd7BYwenDQSoAGjQgW/038qAbeGQmditCHSHisjxlGVCYUkngjZkQ+
        75b+jNR4/7CviY8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 52B5D15D3DB;
        Tue, 23 Nov 2021 13:31:05 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B079D15D3D4;
        Tue, 23 Nov 2021 13:31:02 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH 3/4] test-ref-store: tweaks to for-each-reflog-ent format
References: <pull.1145.git.git.1637590855.gitgitgadget@gmail.com>
        <8a1b094d54732b8b60eacb9892ab460a411bcec3.1637590855.git.gitgitgadget@gmail.com>
        <xmqqr1b7bz5v.fsf@gitster.g>
        <CAFQ2z_PhazkdC8JOqDW-=VD4iLq_==x23+fN7T-Vp9M2DoW=qw@mail.gmail.com>
Date:   Tue, 23 Nov 2021 10:31:01 -0800
In-Reply-To: <CAFQ2z_PhazkdC8JOqDW-=VD4iLq_==x23+fN7T-Vp9M2DoW=qw@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Tue, 23 Nov 2021 18:06:37 +0100")
Message-ID: <xmqqfsrm9122.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 83399A24-4C8B-11EC-9E75-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

>> > +     printf("%s %s %s %" PRItime " %+05d\t%s\n", oid_to_hex(old_oid=
),
>> > +            oid_to_hex(new_oid), committer, timestamp, tz, msg);
>>
>> Looks good to me.  We might want to make the printf format
>> conditional to add \t%s only when msg is not empty, though.
>> Hopefully such a change would follow the reflog format even more
>> closely to make 4/4 unnecessary?
>
> I think the conditional formatting of \t is impractical. It makes thing=
s like
>
>   (metadata, msg) =3D line.split('\t')
>
> in Python require special casing in case msg is empty.

Doesn't it however make it cumobersome (as we saw in 4/4 and =C3=86var's
reaction to it) to write tests to add trailing whitespace like this,
I am afraid?

Without trailing HT, a self-test of this data dumper would become
trivial---just run it and compare its output with the real file in
.git/refs/logs/ directory, no?

As this is only test-helper, I do not mind the deviation from the
format, even though the log message claims to make it closer, to
always show HT.  And because the consumers of this data are only
test scripts, I do not mind they are sloppier than the real-world
code.

But if this were a pair of real world data producer/consumer, the
consumer would be prepared to see and deal with a line that ought to
have but lacks HT anyway, so I suspect that the amount of code to
parse conditionally added HT is not that large.

>> > diff --git a/t/t1405-main-ref-store.sh b/t/t1405-main-ref-store.sh
>> > index a600bedf2cd..76b15458409 100755
>> > --- a/t/t1405-main-ref-store.sh
>> > +++ b/t/t1405-main-ref-store.sh
>> > @@ -94,6 +94,7 @@ test_expect_success 'for_each_reflog_ent()' '
>> >
>> >  test_expect_success 'for_each_reflog_ent_reverse()' '
>> >       $RUN for-each-reflog-ent-reverse HEAD >actual &&
>> > +     head -n1 actual | grep recreate-main &&
>>
>> I am not sure how this new test helps validate the change to the
>> code.
>
> It's for consistency with the preceding test. I can make a separate com=
mit.

Meaning this is an unrelated clean-up of the existing test before
this series started?  Sure, just like the show-branch bugfix, it
would be nicer to have a separate commit for it.

Thanks.

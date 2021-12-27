Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0250C433EF
	for <git@archiver.kernel.org>; Mon, 27 Dec 2021 19:29:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbhL0T3S (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Dec 2021 14:29:18 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60679 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232349AbhL0T3S (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Dec 2021 14:29:18 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 97E45F7550;
        Mon, 27 Dec 2021 14:29:17 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=8CcxtcuW16Jy
        xNuML90If5Fk9+SOgTnHHCuaymb0PG4=; b=Bu+EmZ81otGYyRity8iLeQqAZqsP
        pwZ9YYnyTORMRHoNXMrJUMDpFEDA3QvxXKW1UW4GKfVWbRL23Czz9/VBzlqNKcP9
        QA6crNVAu45Xwj5oamQd0BC+GP6fjtJLymZbtdoDU2A1QxzBeGlxKDdO2AIaWw0g
        DukMudMwvPefccc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8F344F754F;
        Mon, 27 Dec 2021 14:29:17 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E73D9F754C;
        Mon, 27 Dec 2021 14:29:16 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Daniel Vicarel <shundra8820@gmail.com>, git@vger.kernel.org
Subject: Re: Why does "merge --continue" expect no arguments?
References: <CALRdAfcyfesNqfLhhe2GW_5V9s2hf++i6mZS1Lw5hqQYTca85w@mail.gmail.com>
        <xmqqlf0dq3t3.fsf@gitster.g>
        <211224.86mtkqgc8e.gmgdl@evledraar.gmail.com>
        <xmqqk0ft5toy.fsf@gitster.g>
        <211227.868rw7exvi.gmgdl@evledraar.gmail.com>
Date:   Mon, 27 Dec 2021 11:29:15 -0800
In-Reply-To: <211227.868rw7exvi.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 27 Dec 2021 00:31:07 +0100")
Message-ID: <xmqqzgolx2wk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 47FD9B74-674B-11EC-92CE-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>>>     $ git merge --continue
>>>     fatal: There is no merge in progress (MERGE_HEAD missing).
>>>
>>> FWIW I prefer and use it for that reason, i.e. it's useful for script=
ing
>>> to use these "stateful" commands when we're in some sort of rebase/me=
rge
>>> "sequence" since it's an extra layer of sanity checking.
>>
>> There is no additional safety afforded by that, though.  There is no
>> reason why one would even try to say "merge --continue" without
>> doing any merge to begin with.
>>
>> The "merge --continue" not taking any pathspec is a bit of safety,
>> but even there, "commit" already has its own safety to reject
>> pathspec when it notices that it is concluding a conflicted "merge",
>> so "merge --continue" is not necessary for additional safety there,
>> either.
>
> The reason would be that you're confused about what state you're in.
>
> I've had that a few times, so I prefer it over "git commit", so I dares=
y
> someone less experienced in using git could and would benefit from it a=
s
> well.

One can be lost and think that one is in the middle of "git merge"
when in reality there is no merge going on.  Or one can be lost and
confused the other way around, i.e. one thinks one is about to
finish the work one has been doing and conclude in a single parent
commit when in reality that one has done all that is necessary to
whip the working tree and the index into a state good enough to
record as a commit object.

In the former case, saying "git merge --continue", instead of "git
commit" may STOP oneself from proceeding, but then what?

Step back and think the other confusion first.  Saying "git commit",
instead of "git merge --continue", would allow one to record the
merge commit.  It opens an editor, its first line of the log message
would say "Merge blah into bar", the comment section tells you that
you are committing a merge.  It even prevents one from making a
partial commit with "git commit <pathspec>" or screw up the state
with "git commit --amend".  It is totally safe.

Now back to the former case.  You thought your working tree contents
and the index was good enough shape to say "git merge --continue",
but the command refuses because you were not merging.  I have a
suspicion that the message I am responding is a straw-man not worth
I should spend more time on, and if you are truly lost you would
either (1) look at the command line prompt or (2) run "git status"
to re-orient yourself before doing anything drastic like running the
"git merge --continue" command, but hypothetically, if you are lost
between merge and commit yet you are confident enough that your
working tree state and the index is worth recording in a commit
anyway, after a mistaken "git merge --continue" stops you from doing
so, I expect that you would "git commit" to record that tree into a
commit anyway, no?

So, I do agree there would be cases where a user is lost and does
not know what state the working tree s/he just came back to is in,
but "git merge --continue" is a mechanism that gives great help to
such a user.  "git status" may well be such a command, but "git
merge --continue" is not, and training users to use the latter
certainly is a wrong direction to go in.

By the way, you are wasting your time by repeating what you already
said and given an answer that the line of reasoning does not make
much sense.  Unless your goal is to be the one that sends the last
message to a discussion thread, that is.  You can respond to this
message without anything new and I promise that I won't repeat what
has been said already, in such a case.  So you'll be the last one to
utter in this thread then ;-)

You can share a new perspective, of course, in which case I may say
"Light! thanks".





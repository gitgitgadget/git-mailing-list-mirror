Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 033E6C5DF62
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 19:58:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244640AbiAZT6a (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 14:58:30 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54331 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbiAZT63 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 14:58:29 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8257016A8CB;
        Wed, 26 Jan 2022 14:58:29 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=eqzEuuXhZbj2
        Qpu3MZ9ByZhmZMwTV7ucu3Hvcfr1Vj4=; b=b2uYpcv1qI08JfwSVJPU5IO2PDer
        GFVhkp5G9YQBP4C4Eww+uz/rPD9V+ZrEXvS9rpa9U5R+Vb2ukTLM9YoKvBCpN0nZ
        u5sOYtmtqc+EMvnlmLSgqamFzKuHkxCqfxgp003aF3AC+juqvJoZVBbUVbMEiH7s
        xjxwYkB30TWpLio=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7BF6A16A8CA;
        Wed, 26 Jan 2022 14:58:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id F15D716A8C9;
        Wed, 26 Jan 2022 14:58:26 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Yuri <yuri@rawbw.com>, Git Mailing List <git@vger.kernel.org>
Subject: Re: 'git stash push' isn't atomic when Ctrl-C is pressed
References: <4493bcea-c7dd-da0a-e811-83044b3a1cac@tsoft.com>
        <220126.86bkzyfw3q.gmgdl@evledraar.gmail.com>
Date:   Wed, 26 Jan 2022 11:58:25 -0800
In-Reply-To: <220126.86bkzyfw3q.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 26 Jan 2022 14:41:50 +0100")
Message-ID: <xmqqlez2qnfi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 537CBA58-7EE2-11EC-9037-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Tue, Jan 25 2022, Yuri wrote:
>
>> Ctrl-C was pressed in the middle. git creates the stash record and
>> didn't update the files.
>>
>>
>> Expected behavior: Ctrl-C should cleanly roll back the operation.
>
> Yes, you're right. It really should be fixed.
>
> It's a known issue with builtin/stash.c being written in C, but really
> only still being a faithful conversion of the code we had in a
> git-stash.sh shellscript until relatively recently.
>
> (No fault of those doing the conversion, that's always the logical firs=
t
> step).
>
> So it modifies various refs, reflogs etc., but does so mostly via
> shelling out to other git commands, whereas it really should be moved t=
o
> using the ref transaction API.
>
> Ig you or anyone else is interested in would be a most welcome project
> to work on...

I must be missing something.

If I understand the problem description correctly, the user does

	git stash push

which

 * bundles the local changes by recording a commit (with trees and
   blobs) that represents the new stash entry

 * removes the local modification from the working tree files.

And if the user kills the process while the second step is running,
there will be files that are restored to HEAD and other files that
are left unrestored, because the process was killed before it had a
chance to do so.  At that point, we probably do not even know which
ones have been restored to be "rolled back"---that knowledge is lost
when the process got killed.

My take on it is that it is not something that we can call "_should_
be fixed".  It is in the same category as "yes, it would be nice if
the world worked that way, and it would be nice if we had moon,
too".

And it has nothing to do with the command being written in C or
shell, and it does not have much to do with the existence of ref
transaction API.  If you want atomic working tree update, you'd need
to snapshot the working tree state, record the fact that you are
about to muck with the working tree in a secure place and make sure
that hits the disk platter, perform the "stash push" operation
including the working tree update, and then remove the record.  The
record will help you discover that your earlier attempt for doing so
failed for whatever reason (e.g. ^C, kill -9, power failure).  Then
you'd need to arrange that the state gets restored, and possibly
redo what you were doing.

Which theoretically can be done.  But it would be not practically
cheap enough to use in a day-to-day operation.  It certainly would
be too much to expect a new person to be able to "work on".

And the "theoretically" part is important, in that it draws the line
between what is realistic and unrealistic.  The thing written in C
or shell would not make much of a dent and the existence of ref
transaction API would not have much effect on partial working tree
updates not being restored.  They are red-herrings.

I suspect that the untold thinking behind your statement was that we
should try not to discourage new users from asking, and I agree with
the sentiment to a certain degree.  But at the same time, I think it
is simply irresponsible to do so without distinguising between
asking for something realistic and unrealistic.

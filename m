Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E802C433EF
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 19:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245394AbhLAThN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 14:37:13 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50768 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245282AbhLAThJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 14:37:09 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D90CA10190B;
        Wed,  1 Dec 2021 14:33:46 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qqseIaBXAhjDgXAbYL1ri+M2ukFIcyUJTRBwQo
        RgyzI=; b=EAFfCK4YtyRA6RMJTEfzFEZOJEeOk6yG/KrYxzjAjzbZRoqvftLoIg
        3BgaL9hHofIkBkELPEnG3fMgCMWyHuwTBfJfjku3H+tVxnFJidnHpGF4yFF9gJa5
        HELORGHlkUjtkgU+n+GGx/vZ38SsNA8hof7dfCx6LgiBvV+2rXdCs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CF8B310190A;
        Wed,  1 Dec 2021 14:33:46 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3F089101909;
        Wed,  1 Dec 2021 14:33:46 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Chris Torek <chris.torek@gmail.com>
Cc:     phillip.wood@dunelm.org.uk, Carlo Arenas <carenas@gmail.com>,
        Git List <git@vger.kernel.org>, thomas.wolf@paranor.ch,
        Alexander Veit <alexander.veit@gmx.net>
Subject: Re: [PATCH] editor: only save (and restore) the terminal if using a
 tty
References: <04ab7301-ea34-476c-eae4-4044fef74b91@gmail.com>
        <20211122222850.674-1-carenas@gmail.com>
        <b1f2257a-044c-17bb-2737-42b8026421eb@gmail.com>
        <CAPUEsphP2GRaHJa0Qnvf22WUnNB+GnnfG8TgHqwJvSGdYfUQGA@mail.gmail.com>
        <7138fa14-02b2-b123-4d8d-df73763f8431@gmail.com>
        <CAPx1GvcML9TvmP1BSLN0vKWD++8LBj-68Xwmz-KrZM32Q=0_Ug@mail.gmail.com>
Date:   Wed, 01 Dec 2021 11:33:44 -0800
In-Reply-To: <CAPx1GvcML9TvmP1BSLN0vKWD++8LBj-68Xwmz-KrZM32Q=0_Ug@mail.gmail.com>
        (Chris Torek's message of "Tue, 30 Nov 2021 21:12:12 -0800")
Message-ID: <xmqq35nc15nr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 99C5DD4A-52DD-11EC-992E-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Chris Torek <chris.torek@gmail.com> writes:

> On Tue, Nov 30, 2021 at 2:41 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
>> On 23/11/2021 17:31, Carlo Arenas wrote:
>> > Restricting this feature further, maybe through a configuration
>> > property or even special casing the EDITOR is also IMHO a good idea.
>>
>> I think just doing this when we run the editor may be the way to go as I
>> think it is only that case that can mess up the terminal.
>
> If it only happens with certain versions of vi / vim, perhaps Git could come
> with a front end program that saves the tty state, runs vim, and restores the
> tty state. (Or set this up so that the program can run any editor.)  Then add
> a FAQ entry if needed: "if your editor goofs up the terminal, insert this front
> end program".

That might work, and because the user is in control, we have less
risk of unintended breakage.  Doing so unconditionally when the
editor's name is "vi" like Dscho suggested would make it more
convenient for the users.

Some editors like Emacs can open a new window and go graphical, even
when they are launched from a terminal.  Doing the save/restore on
them would be unnecessary.  Although I do not offhand think of a way
such an unnecessary save/restore would break the terminal, we have
already seen that things can break in an unintended way by doing
something unnecessary in this area, so perhaps the best way forward
is

 - Add a multi-valued configuration variable whose value is the name
   of an editor program that needs this save/restore; optionally, we
   may want a way to say "don't do save/restore on this editor",
   e.g. "!emacs" may countermand an earlier value that would include
   the editor in the list.

 - Around the program invocation in launch_specified_editor(), check
   the name of the editor against this list and do the save/restore
   as necessary;

 - When the variable is not defined in the configuration, pretend
   that "vi" is on that list (coming up with the list of editors is
   left as an exercise to readers).

That would give us your flexibility to apply the save/restore on an
arbitrary editor that is not "vi", Dscho's convenience to special
case "vi" out of the box when unconfigured, and an escape hatch for
"vi" users for whom it hurts to do the save/restore on their "vi".

Hmm?

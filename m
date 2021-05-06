Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35173C433B4
	for <git@archiver.kernel.org>; Thu,  6 May 2021 05:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D16CA610E7
	for <git@archiver.kernel.org>; Thu,  6 May 2021 05:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbhEFFg7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 01:36:59 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61753 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbhEFFg6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 01:36:58 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1A32A1212EB;
        Thu,  6 May 2021 01:36:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dSG1TOWxeYpRy//DJaqlCrPP9saIYRJ9M8Y4Er
        vR5qA=; b=TAFh4Dclz3apEgxXWxYuZxJO9PLXdlZf6S7CcVNmHyEDu3gGDL7Q6r
        kTejWbaQBvbP5gbjODphaziH/6p6EG0eZRHHXEhniyoGFVH11DB+th15RM9oUedb
        XNFFG/SiUhbnjhEnyxQh2yC5JEp4f5W0LoivgX+UEm0AzGz7uUYv4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 132C31212E8;
        Thu,  6 May 2021 01:36:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 472971212E6;
        Thu,  6 May 2021 01:35:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] [GSOC] ref-filter: solve bugs caused by enumeration
References: <pull.949.git.1620228664666.gitgitgadget@gmail.com>
        <xmqqfsz01vc2.fsf@gitster.g>
        <CAOLTT8SmvRaohV+v2C9eFXyc8O+di5PfZJeWNinmm8X=Ckdveg@mail.gmail.com>
Date:   Thu, 06 May 2021 14:35:56 +0900
In-Reply-To: <CAOLTT8SmvRaohV+v2C9eFXyc8O+di5PfZJeWNinmm8X=Ckdveg@mail.gmail.com>
        (ZheNing Hu's message of "Thu, 6 May 2021 13:02:51 +0800")
Message-ID: <xmqqk0oczao3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EF64712C-AE2C-11EB-BC64-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> writes:

>> Is it that a check refers to one member of a union without making
>> sure that member is the one in effect in the union?  I am most
>> puzzled by the mention of "enumeration" when there does not appear
>> to be any enum involved.
>
> Sorry, I didn't make it clear. I re-describe the problem first, and then
> modify the commit messages.
>
> Suppose we are dealing with "%(notes)", the name member of our
> `used_atom` item at this time is "notes", and its member union `u` uses
> a `struct notes_option`, we fill some values in `used_atom.u.notes_option`,
>
> When we traverse in `used_atom` array in `populate_value()` and previous
> judgement like "if (starts_with(name, "refname"))" will failed, because we
> are dealing with atom "notes", but in judgement "else if
> (atom->u.remote_ref.push)",
> The value we fill in `used_atom.u.notes_option` just makes
> `used_atom.u.remote_ref.push` non-zero. This leads us into the wrong case.
>
> Is this clearer?

This time you avoided the word enumeration, and it made it clearer.
The word commonly used is "condition" where you said "judgment", I
think, and wit that it would probably be even more clear.

used_atom.u is an union, and it has different members depending on
what atom the auxiliary data the union part of the "struct
used_atom" wants to record.  At most only one of the members can be
valid at any one time.  Since the code checks u.remote_ref without
even making sure if the atom is "push" or "push:" (which are only
two cases that u.remote_ref.push becomes valid), but u.remote_ref
shares the same storage for other members of the union, the check
was reading from an invalid member, which was the bug.

So the fix was to see what atom it is by checking its name member?
Is starts_with() a reliable test?  A fictitious atom "pushe" will be
different from "push" or "push:<something>", but will still pass
that test, so from the point of view of future-proofing the tests,
shouldn't it do the same check as the one at the beginning of
remote_ref_atom_parser()?

Thanks.

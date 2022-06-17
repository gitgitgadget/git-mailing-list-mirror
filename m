Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CBBC433EF
	for <git@archiver.kernel.org>; Fri, 17 Jun 2022 16:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbiFQQAr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jun 2022 12:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiFQQAp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jun 2022 12:00:45 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3133C4AE
        for <git@vger.kernel.org>; Fri, 17 Jun 2022 09:00:44 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E0FB2131621;
        Fri, 17 Jun 2022 12:00:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bTia3X3P9jppPUMApOfJVj5VNmnPT3673V3AoO
        uw418=; b=vUArIHXgoywW6en7aEfImk9VWvtg4C8LBNi6+OsURjmH041QIMc5UG
        BN5e2bz1cwG0snK8tz+4yECwpGgHnRB5uiNMpZM7IjALQ406xlq71zHs7QyIwGrc
        LKQWfCOfAI5npMz7szz39P4mz0AUh+6tzDPwZFWWaiOCXDZzeU258=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D6211131620;
        Fri, 17 Jun 2022 12:00:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4741813161F;
        Fri, 17 Jun 2022 12:00:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, bagasdotme@gmail.com
Subject: Re: [PATCH v5 4/4] git-compat-util: allow root to access both
 SUDO_UID and root owned
References: <20220510174616.18629-1-carenas@gmail.com>
        <20220513010020.55361-1-carenas@gmail.com>
        <20220513010020.55361-5-carenas@gmail.com>
        <nycvar.QRO.7.76.6.2206151557510.349@tvgsbejvaqbjf.bet>
        <CAPUEspgrkVywKOAQz1ffyntaAXaw6=WnNNBZRhNRBHRH8nYUHQ@mail.gmail.com>
Date:   Fri, 17 Jun 2022 09:00:41 -0700
In-Reply-To: <CAPUEspgrkVywKOAQz1ffyntaAXaw6=WnNNBZRhNRBHRH8nYUHQ@mail.gmail.com>
        (Carlo Arenas's message of "Fri, 17 Jun 2022 07:26:37 -0700")
Message-ID: <xmqqmtebp9ee.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A3B98440-EE56-11EC-B3E5-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Arenas <carenas@gmail.com> writes:

>> So unless the refactoring is done to any other end than for refactoring's
>> own sake (which is really not a good reason), I see it as problematic.
>
> I couldn't agree more with that sentiment, but in this case the
> refactoring was done to clean up the recently introduced function
> which was indeed too ugly (some would say on purpose) and replacing it
> with not only better looking code, but also a cleaner interface.
>
> I would think that in this specific case an exemption could be
> granted, but it is also true that while this code is almost a month
> old, it hasn't got the review it will require to be merged so late in
> the release cycle without raising the concerns you both fairly put
> forward.
>
>> >       if (euid == ROOT_UID)
>> > -             extract_id_from_env("SUDO_UID", &euid);
>> > +             return id_from_env_matches("SUDO_UID", st.st_uid);
>>
>> A much shorter, much more obvious patch would look like this:
>>
>> -       if (euid == ROOT_UID)
>> +       if (st.st_uid != euid && euid == ROOT_UID && )
>>                 extract_id_from_env("SUDO_UID", &euid);
>>
>> It accomplishes the same goal, but is eminently easier to review. For
>> regression fixes, I much prefer the safety and confidence that comes with
>> that.
>
> will reroll with your suggestion, thanks again for your helpful
> review, and apologies again to everyone for not cleaning it up earlier
> in the cycle.

As long as the syntax error with the "like this" suggestion gets
fixed, I do not mind if you took the above verbatim ;-)

Quite honestly, at this low level of small "the caller asks if it is
safe for the current user to step into the given path to run git"
function, it would be a waste of time to quibble about the
separation of concerns between the helper function that figures out
who the "current user" is, and checking it against the user who owns
the path.  It is not like we are talking about a brutal-to-reviewers
250-line function that is called from multiple places after all.
The extract_id_from_env() helper could be inlined the caller and the
issue would disappear (I am not making a suggestion to actually do
so, but an illustration why it does not matter much in the larger
picture for something miniscule like this).

Where the function name and the separation of concerns truly matters
is between the is_path_owned_by*() helper and its callers, as in the
longer term I expect it won't be just "ownership" that we would care
about and once we start checking permission bits and other things for
the path, we'd regret the "owned by" part of the name.

But that is not our immediate concern, so let's take whatever that
is not incorrect and can achieve "concensus" the easiest and move
on.

Thanks for sticking with the larger topic of making the end-user
experience better around here.  Very much appreciated.

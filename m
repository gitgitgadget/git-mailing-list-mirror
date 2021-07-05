Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CEF5C07E9A
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 09:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 602CD613C1
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 09:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbhGEKBk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 06:01:40 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57260 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbhGEKBj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 06:01:39 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4466B13AA91;
        Mon,  5 Jul 2021 05:59:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=HDValNafLW9N6OpKEcmRNkpNCIvoqPwcgb6AwvHzCM4=; b=mMbC
        QWxZp8u+ZaidDw8juvEbComodxlxIYD+Bb71ICoDe4nbyXjJAL8vyy9wfWK7MuuX
        w8Eb00qawblNtI6zuVjrCsZpxbiGp6rbpUjCj81+ikmQyQVmnXi3MpehiHMWGBm9
        LpLK9/dl0nPfik8dpuD5+iUOd5i/+D/daLxCk9I=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 32E7B13AA90;
        Mon,  5 Jul 2021 05:59:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 606AA13AA8E;
        Mon,  5 Jul 2021 05:58:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        newren@gmail.com
Subject: Re: [PATCH RFC] rebase: respect --ff-only option
References: <20210705044505.666977-1-alexhenrie24@gmail.com>
        <349748b4-3c48-7ca7-eb0f-e859a15cab0f@gmail.com>
Date:   Mon, 05 Jul 2021 02:58:57 -0700
Message-ID: <xmqq8s2lnkta.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9E72C960-DD77-11EB-8244-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> As I understand it the motivation for this change is to have 'git -c
> pull.rebase=true pull --ff-only' actually fast forward. Why cant we
> just change pull not to rebase in that case?
> ...
> Is there a use for this outside of 'git pull --ff-only'? I'm far from
> convinced we want this new option but if we do end up adding it I
> think it should error out in combination with '-i' or '-x' as '-i'
> implies the user wants to change the existing commits and '-x' can end
> up changing them as well.
>
> I think this patch addresses a valid problem but it seems to me that
> the approach taken pushes complexity into rebase to handle a case when
> pull does not need to invoke rebase in the first place.

I share the sentiment, but my conclusion would be different.

Even though we explain that "pull" is _like_ "fetch" followed by
"merge" (or "rebase"), at the conceptual level, "pull --ff-only"
should not have to invoke merge or rebase backend.  If the branch
fast-fowards to the fetched tip, "pull" should be able to just
update the branch and check it out, and if it doesn't, "pull" should
just be able to fail.

Similarly, "pull --ff" (i.e. fast-forwading allowed) should be able
to just update the branch and check it out when the current tip of
the branch can be fast-forwarded to the fetched tip.

But as you said, pull.rebase=interactive will break such a clean
separation of concerns.  You can leave "pull" oblivious of what
"rebase -i" wants to do when seeing a fast-forwardable history by
teaching "rebase" (and "merge") backend to take "--ff-only", "--ff",
and "--no-ff" options and having "pull" pass them through.

We can teach "pull" that certain backends (namely "rebase -i" in
this case) want to handle "ff logic" [*] themselves, and other
backends (i.e. "rebase" and "merge") do not mind if "pull" handles
"ff logic" for them, but that will break the abstraction (e.g. do we
really want to teach "pull" that "rebase -i" wants to rewrite all
the commits even when the history fast-forwards?) and will become a
source of duplicated logic.

Another thing to worry about are hooks.  post-rebase or post-merge
operations would want to be carried out even when the history would
fast-forward, and making "pull" to perform the fast-forwarding and
know which hooks should be called with what parameter so that we
could pretend as if the "merge" or "rebase" backend was indeed ran,
breaks the abstraction.

So, even though I wish that the world was simpler and we could
handle "ff logic" inside "pull", I am not sure if it is a realistic
wish.


[Footnote]

* By "ff logic", I am referring to what should happen in the 3x2=6
  matrix when one of ("--ff", "--ff-only", or "--no-ff") is given
  and the history (does or does not) fast-forward.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B08FC433EF
	for <git@archiver.kernel.org>; Sat, 14 May 2022 05:24:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbiENFYq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 May 2022 01:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbiENFYo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 May 2022 01:24:44 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893E52C1
        for <git@vger.kernel.org>; Fri, 13 May 2022 22:24:41 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 91E741185F2;
        Sat, 14 May 2022 01:24:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=df6dgGH59gbAx5bdghNoPhP7hPOxf7S7ncnvRj
        VIvug=; b=fUqq1AKylMUWe3CxnroqTpaHxppmnWFoyfSr4rZl4elD8IOoTaj4Er
        KFoWwwqUzg3mDejCLh9QisvvEoDOIBFFxUsH4DJKgzoA6S6abwTnc019bw5IScUa
        7M5/HSfxLbtGn6EaG8pl2fXA4GaQONGhReABl+cEv1/zPPlsmjWEY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 877E01185F1;
        Sat, 14 May 2022 01:24:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E80B01185F0;
        Sat, 14 May 2022 01:24:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Benedek Kozma <cyberbeni@gmail.com>
Subject: Re: Bugreport - submodules are fetched twice in some cases
References: <CAN8jHOgwVF5g=jM_KYT0Oh+j+Lk3qvdyA4zNRbzf8e1Xp5WAUw@mail.gmail.com>
        <xmqqczgzdc1r.fsf@gitster.g>
        <kl6l4k2bpv61.fsf@chooglen-macbookpro.roam.corp.google.com>
        <xmqq1qxfbqtq.fsf@gitster.g>
        <kl6lczghj7tn.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Fri, 13 May 2022 22:24:35 -0700
In-Reply-To: <kl6lczghj7tn.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Fri, 13 May 2022 17:07:00 -0700")
Message-ID: <xmqqpmkg8z58.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 255D2F96-D346-11EC-AC30-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> And obviously, we aren't passing "--recurse-submodules=false", so there's
> good reason to believe that "--all" will fetch submodules R + 1 times.

Good find.

Given your recent work on enumerating the commits in the submodule
repository that are needed to complement "git fetch" made in the
superproject, the above finding raises an interesting question.

Imagine that we have two remotes for the current repository, and
this superproject uses one submodule.

When we run "git fetch --all --resurse-submodules", from one remote,
we may grab a range of history in the superproject that mentions
submodule commits C1 and C2 that are not in our clone of the
submodule, while the other remote gives a different range of history
in the superproject that mentions submodule commit C3 that we do not
have.

What should happen in our submodule?  In other words, how do we make
sure that we grab C1, C2 and C3?

Ideally, we probably would want to run a non-recursive fetch of the
superproject twice (i.e. once for each of the two remotes we have),
then traverse the superproject history to find that these three
commits are needed in the submodule, and run a single (possibly
recursive) fetch in the submodule and ask for C1, C2 and C3.  But I
am not sure if we are set up to do so.  Does the "parent" process
take a snapshot of our refs before spawning the two "child" fetches
for each remote when handling "fetch --all", so that we can later
figure out what superproject commits were obtained during the
fetches from these two remotes?  Without that information, we cannot
find out that C1, C2 and C3 are new in the submodule, so we cannot
implement the "fetch without recursion from each remote and then do
a single fetch in submodule to grab everything we need at once"
approach.

Provided if we have the "make sure everything needed in the
submodule is fetched by inspecting the range of commits we fetch for
a superproject" working correctly for a single remote, an
alternative approach is to run "git fetch --recurse-submodules" for
each remote separately, without the "parent" process doing anything
in the submodule (i.e. you earlier counted R+1 fetches, but instead,
we make R fetches in the submodule.  It is less than ideal but it
may be easier to implement).

Thoughts?

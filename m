Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E2E4C433F5
	for <git@archiver.kernel.org>; Sun,  6 Mar 2022 21:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234294AbiCFVzf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Mar 2022 16:55:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232527AbiCFVze (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Mar 2022 16:55:34 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3BE52E3F
        for <git@vger.kernel.org>; Sun,  6 Mar 2022 13:54:40 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AC4ED17078E;
        Sun,  6 Mar 2022 16:54:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9zr53Mil5/p2DoPgvaeMh/lelE3kZkw4iE5adv
        VCf0g=; b=GGUZ4Nt2XVcJnOg+guwtQIIoVuMD9e0AORrVmQJ9yoRW1KUxEUqGdk
        Z4PeYUA8fuy6TmuqXXMkHXPUoFSqDn8Ucbf4KfB98hNX583S6b+ZLkzoPTiI9rQb
        viCs1vmVwAiuhDtJnXZ/lE16vwpMxCJhPv/ebOF0fGHyE7mjsHag0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 97A8717078C;
        Sun,  6 Mar 2022 16:54:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1489D17078B;
        Sun,  6 Mar 2022 16:54:37 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Tao Klerks <tao@klerks.biz>,
        git <git@vger.kernel.org>, Josh Steadmon <steadmon@google.com>
Subject: Re: What does it mean to have multiple upstream tracking branches?
References: <CAPMMpoiTJAuadBEOPWOVa-kguSXMDvAhvD22B63QwYpu=H7xEw@mail.gmail.com>
        <220303.868rtr42mg.gmgdl@evledraar.gmail.com>
        <kl6l4k4ek73o.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Sun, 06 Mar 2022 13:54:36 -0800
In-Reply-To: <kl6l4k4ek73o.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Thu, 03 Mar 2022 14:24:11 -0800")
Message-ID: <xmqqzgm2vjab.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0419382C-9D98-11EC-8B0E-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> Based on the discussion on that thread you mentioned, I don't think we
> have any such tests. I think the only way to get into this state is to
> manually modify the config.
>
> The only docs I could find on 'multiple values' are from
> Documentation/config/branch.txt:
>
>   branch.<name>.merge::
>     [...]
>     Specify multiple values to get an octopus merge.
>
> So I'd imagine a use case would be something like:
>
> - I'm preparing a feature on the branch 'topic'
> - It will get merged into 'origin/master'
> - The feature also depends on 'origin/other-topic'
>
> I'd have entries like:
>
> branch.topic.remote = origin
> branch.topic.merge = master
> branch.topic.merge = other-topic
>
> That way, if either 'origin/master' or 'origin/other-topic' changes, I
> can pull updates into 'topic' with "git pull".
>
> Not that I would ever _recommend_ someone to work like this though.
> Junio also wondered whether anyone uses this [1].
>
> [1] https://lore.kernel.org/git/xmqqbl2hw10h.fsf@gitster.g

I actually think the current octopus behaviour is a sensible one
(after all, that was what we envisioned how it would be used when we
did the mechanism long time ago).  If you have mutliple, say source
and docs, groups working for you and you are taking their work from
time to time, something like this:

    [branch "main"]
        remote = central-repo
        merge = sources
        merge = docs

would let your folks push into the central-repo, and a "git pull"
will help you advance your main branch that you'll publish later.

You can explain multiple .merge entries for such an integration
branch like I just did and I think such an explanation makes perfect
sense, but these are quite different from what we view as "upstream"
in the traditional sense.  In the setting illustrated here, yours is
the main integration repository, the center of the universe, and
those folks working in the 'sources' and 'docs' groups view yours as
their "upstream".

So, "what does it mean to have multiple branch.*.merge entries" has
a good answer: you are integrating from these contributors and these
entries are not your "upstream" in the usual sense---you do not even
push back to them.  Asking "what does it mean to have multiple
upstream" makes little sense, I would think.

Now, with the 'main' branch used in such a manner, if you did

   $ git branch --track=inherit topic main

and worked on the "topic" branch, you do not push back to either the
sources or docs of the central-repo, of course, but it is unclear if
you even want to "pull" to create octopus from these two branches at
the central-repo, which essentially duplicates the pull's you would
do on your 'main' branch.  I suspect that you'd rather want to merge
updates 'main' accumulated (or rebase on them).

The reason why I asked what Josh's plans are for the multiple .merge
entries in that thread [1] when the "--inherit" feature was being
invented was exactly about this point.  I wondered if last-one-wins
may make sense (and as the above octopus set-up tells us, it may
not), but if we want to keep "multiple .merge entries means an
integrator making octpus merges", then it may make sense not to copy
them when there are multiple with "--track=inherit", to avoid
spreading the "curious" nature of the branch like 'main' depicted
above.



Return-Path: <SRS0=B37d=3G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E7F4C33C9E
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 19:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAB0620728
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 19:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BoZimBtp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729508AbgAQTNT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jan 2020 14:13:19 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60511 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727573AbgAQTNT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jan 2020 14:13:19 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0E4E69E8DA;
        Fri, 17 Jan 2020 14:13:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xNmlf2gNjnmm8mTwWOpc8UV4cCc=; b=BoZimB
        tpwnhFiVtBhN6HA46ipIvgus3iTJjwMx9XAliQzw2iL/fVzef2iN0emFmWkOUf+B
        1T8VIJb6zRWPYkyR8rK4ut8o2uPfau6D52i+ijBqWZcJ+0KPd34DruiC9zDNrKHL
        +CCKrXuA5EGCrNK4l5TD1Zz4FQ7MxSjUsG6G4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SPjYqsmjzMZhf1Ts9xdZOv+/0GkmkHv4
        4MLEZ1Mv9JIj+CNxLENE39VfnoVeUaeU1nYH4P3i0Ot37umk+Es9BA04Q9CWZOq0
        YCbDWZ1Kgu8ie6OU/h1e7voDVeyY0r7YFvyAMrlVTdrvOkjsSkXXvZycez3kuCdC
        hj50F4Vr9To=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 044CC9E8D9;
        Fri, 17 Jan 2020 14:13:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 28F7C9E8D8;
        Fri, 17 Jan 2020 14:13:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] fetch: add --no-update-remote-refs
References: <pull.532.git.1579274939431.gitgitgadget@gmail.com>
Date:   Fri, 17 Jan 2020 11:13:10 -0800
In-Reply-To: <pull.532.git.1579274939431.gitgitgadget@gmail.com> (Derrick
        Stolee via GitGitGadget's message of "Fri, 17 Jan 2020 15:28:59
        +0000")
Message-ID: <xmqqa76lew1l.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 683DED08-395D-11EA-B1F3-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> To prevent long blocking time during a 'git fetch' call, a user
> may want to set up a schedule for background 'git fetch' processes.
> However, these runs will update the refs/remotes branches, and
> hence the user will not notice when remote refs are updated during
> their foreground fetches. In fact, they may _want_ those refs to
> stay put so they can work with the refs from their last foreground
> fetch call.

I've always hated anything that makes the remote-tracking refs
"float" and surprise end users.  I even hated that 'git push' that
pretends as if we immediately turned around and fetched from the
remote we just pushed when it was introduced, even though I gave up
by now.

So I am OK in principle to make it more difficult to update
refs/remotes/* while the end-user is looking the other way, but I
had to wonder why "git fetch" is even being done if it is done to
silently update/catch-up remote-tracking branches automatically in
the first place.

This is more like a "preload" option---without updating the end-user
visible set of remote-tracking branches, you can make the data
available earlier so that the actual "fetch" the end-user runs in
order to update the remote-tracking branches can complete faster and
become ready to be used more quickly.  

Which makes sense.

> Add a --[no-]update-remote-refs option to 'git fetch' which defaults
> to the existing behavior of updating the remote refs. This allows
> a user to run
>
>   git fetch <remote> --no-update-remote-refs +refs/heads/*:refs/hidden/*
>
> to populate a custom ref space and download a pack of the new
> reachable objects.

Hmph.  I have to wonder if this should have been the default.  That
is, when refs/heads/X on the remote is configured to be copied to
refs/remotes/origin/X on this side, and an explicit refspec says it
should go some other place (i.e. refs/hidden/X), shouldn't that
automatically bypass configured +refs/heads/*:refs/remotes/origin/*
refspec?  In any case, it is too late to change that now.

> This kind of call allows a few things to happen:
>
> 1. We download a new pack if refs have updated.
> 2. Since the refs/hidden branches exist, GC will not remove the
>    newly-downloaded data.

Caution.  Since you didn't make it "refs/hidden/<remote>/*", you
just made the data you fetched the same way with this shiny new
"--no-update-remote-tracking-branches" option from another remote
unanchored and susceptible to GCs.

> 3. With fetch.writeCommitGraph enabled, the refs/hidden refs are
>    used to update the commit-graph file.

I have a moderately strong suspicion that it would be better to make
this "--ignore-configured-refspecs" and implemented without special
casign the "refs/remotes/" hierarchy like the code does by
hardcoding.

I also wonder if auto-following of tags should be disabled at the
same time.  I have no good argument either way (yet).

Thanks.

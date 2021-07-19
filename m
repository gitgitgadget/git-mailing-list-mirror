Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FEBC63799
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 23:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 759EC6113E
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 23:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359469AbhGSWWm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 18:22:42 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59255 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387618AbhGSU0A (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jul 2021 16:26:00 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2B1A8149BA2;
        Mon, 19 Jul 2021 17:06:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0L2jaR5RerWJX92y8IKnR2XqXe/9mottYFKksS
        LyxKw=; b=pY7wZrs8qQO3Ls7kSDNKUgIxOOJxyzSR81GJlv9Ql31j6qFj95i733
        bCLUUz2AwEHC8uhpq4h0IQkAPje4b1SsyXab2x0TnFsPQ/JfjD0gQO9I6x/yXX19
        kbS5oACh5wLRbGQWKuHY16pZ3yGsnni9nXkdM0z3K9v4r8P2elGXw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 24A1B149BA1;
        Mon, 19 Jul 2021 17:06:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4E056149BA0;
        Mon, 19 Jul 2021 17:06:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, iankaz@google.com,
        sandals@crustytoothpaste.net, avarab@gmail.com,
        emilyshaffer@google.com
Subject: Re: [RFC PATCH v2 0/2] MVP implementation of remote-suggested hooks
References: <cover.1623881977.git.jonathantanmy@google.com>
        <cover.1626453569.git.jonathantanmy@google.com>
Date:   Mon, 19 Jul 2021 14:06:19 -0700
In-Reply-To: <cover.1626453569.git.jonathantanmy@google.com> (Jonathan Tan's
        message of "Fri, 16 Jul 2021 10:57:39 -0700")
Message-ID: <xmqq8s22ko8k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2B146154-E8D5-11EB-8216-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Here's an updated version of the remote-suggested hooks RFC, hopefully
> addressing some of the concerns people have brought up (e.g.
> auto-updating without letting the user verify, or prompting about hooks
> by default). It consists of two main parts:
>
>  - Non-interactive prompts during certain Git commands about the
>    existence of hooks. These prompts are turned *off* by default.
>
>  - New "git hook" subcommands that can install these hooks (so that the
>    aforementioned Git prompts or out-of-band installation instructions
>    can tell users to install these hooks in a platform-independent way).
>    These subcommands work whether or not prompts are enabled.
>
> You can see how they work in patch 2's t1361.

I really wanted to try this out, but which commit was this based on?

> In doing this, I have tried to scope down the overall effort as much as
> possible (to avoid security risks as much as possible, among other
> things), concentrating on situations that server-side hooks cannot
> handle. I think the main thing is that server-side hooks can check and
> prompt upon push, but they cannot catch problems that the client could
> have noticed upon commit; if the end user pushes a commit chain and only
> notices problems then, the user would have to redo the commits (possibly
> through an interactive rebase on the spot). Catching problems upon
> commit would prevent this problem, only necessitating amending the
> commit.
>
> In the Gerrit use case, Gerrit requires a specific "Change-Id" trailer
> in the commit message, but I can foresee the same issue in projects that
> require their commit messages to fit a certain template or projects that
> want lints to be run but their builds, for some reason, don't run
> arbitrary code (or they have no builds at all).
>
> To that end, I have added a prompt for the "commit-msg" hook if the
> remote has suggested one, but there are none currently installed.
> (Similar prompts could be added for other commit-related hooks.) The
> other prompts are upon clone and upon fetch (if the hooks have been
> updated).
>
> Jonathan Tan (2):
>   hook: move list of hooks
>   hook: remote-suggested hooks
>
>  builtin/bugreport.c               |  38 +-----
>  builtin/clone.c                   |  12 ++
>  builtin/fetch.c                   |  17 +++
>  builtin/hook.c                    |  17 ++-
>  hook.c                            | 185 +++++++++++++++++++++++++++++-
>  hook.h                            |   6 +
>  t/t1361-remote-suggested-hooks.sh | 105 +++++++++++++++++
>  7 files changed, 340 insertions(+), 40 deletions(-)
>  create mode 100755 t/t1361-remote-suggested-hooks.sh

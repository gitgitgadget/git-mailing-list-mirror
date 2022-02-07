Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09B8C4167B
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 01:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235540AbiBHBFW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Feb 2022 20:05:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234438AbiBGXVS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Feb 2022 18:21:18 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1521C061355
        for <git@vger.kernel.org>; Mon,  7 Feb 2022 15:21:16 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 75AEC17CE53;
        Mon,  7 Feb 2022 18:21:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HiCyCMi+oLKCm58kwj0YmgmwlOZJcNDi3SMd5K
        LE29A=; b=iGKC8Qi4SxpDJDZDm7D9nAdVYWlIkI2qB4BpzO3bYjN5krYrmE3A5O
        Xx9hNtRuQbr+QOcWrkpAPkUBTSsb+Lk6ecHXUaCIq5s8QrSgOdwVaP6SEuSCN2mV
        ylmqVQHhGSMB4UI6fm/BoHmjJdjTmhW+Oe/IOfzyJBg/KD7GyAw8Q=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6D4E317CE52;
        Mon,  7 Feb 2022 18:21:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C824217CE4E;
        Mon,  7 Feb 2022 18:21:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
        Albert Cui <albertcui@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Jacob Keller <jacob.keller@gmail.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v6 0/5] teach submodules to know they're submodules
References: <20211117005701.371808-1-emilyshaffer@google.com>
        <20220203215914.683922-1-emilyshaffer@google.com>
        <220204.86pmo34d2m.gmgdl@evledraar.gmail.com>
        <YgF5V2Y0Btr8B4cd@google.com>
Date:   Mon, 07 Feb 2022 15:21:12 -0800
In-Reply-To: <YgF5V2Y0Btr8B4cd@google.com> (Jonathan Nieder's message of "Mon,
        7 Feb 2022 11:56:07 -0800")
Message-ID: <xmqqk0e6gt5j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A4712BF4-886C-11EC-9259-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Here's a few examples:
>
> 1. Suppose I track my $HOME directory as a git repository.  Within my
>    home directory, I have a src/git/ subdirectory with a clone of
>    git.git, but I never intended to treat this as a submodule.
>
>    If I run "git rev-parse --show-superproject-working-tree", then it
>    will discover my home directory repository, run ls-files in there
>    to see if it has GITLINK entries, and either see one for src/git if
>    I had "git add"ed it by mistake or not see one.  In either case,
>    it would it would view my src/git/ directory as being a submodule
>    of my home directory even though I hadn't intended it to be so.

I am not sure about this one.  If you added an unrelated one with
"git add" by mistake, you'd want to know about the mistake sooner
rather than later, no?

> 2. Suppose I have a copy of a repository such as
>    https://gerrit.googlesource.com/gerrit/, with all its submodules.
>    I am in the plugins/replication/ directory.
>
>    If I run "git rev-parse --show-superproject-working-tree", then it
>    will discover my gerrit repository, run ls-files in there to see if
>    it has GITLINK entries, and use the result to decide whether the
>    cwd is a submodule.  So for example, if I had run "git rm --cached
>    plugins/replication" to _prepare to_ remove the plugins/replication
>    submodule, then "git rev-parse --show-superproject-working-tree"
>    will produce the wrong result.

Yes, looking only at the index of the superproject will have that
problem, but don't other things in the superproject point at the
submodule, too, e.g. submodule.<name>.* configuration variables?

And then, after removing them to truly dissociate the submodule from
the superproject, "git rev-parse --show-superproject-working-tree"
may stop saying that it is a submodule, but this series wants to
make it irrelevant what the command says.  Until you unset the
configuration variable in the submodule, it will stay to be a
submodule of the superproject, but the superproject no longer thinks
it is responsible for the submodule.  You'll have to deal with an
inconsistent state during the transition either way, so I am not
sure it is the best solution to introduce an extra setting that can
easily go out of sync.

> 3. Suppose I am not using submodules at all.  I have a clone of
>    mawk.git and I am working there.
>
>    If I run "git rev-parse --show-superproject-working-tree", then I'm
>    presumably interested in doing something submodule-specific;
>    nothing wrong with that.  But the series we're responding to is
>    meant to support a wider variety of operations --- for example,
>    suppose I am running a plain "git status" operation.
>
>    If "git status" runs "git rev-parse
>    --show-superproject-working-tree", then git would walk up the
>    filesystem above my mawk/ directory, looking for another .git dir.
>    We can reach an NFS automounter directory and just hang.  Even
>    without an NFS automounter, we'd expect this to take a while
>    because, unlike normal repository discovery, we have no reason to
>    believe that the walk is going to quickly discover a .git directory
>    and terminate.  So this would violate user expectations.

It would be a problem, but I do not know if "this is a submodule of
that superproject" link is the only solution, let alone the most
effective one.  It seems to me that you are looking more for
something like GIT_CEILING_DIRECTORIES.

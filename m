Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DE8C5CFC2
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 17:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A696613D7
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 17:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhGORgN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 13:36:13 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50358 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbhGORgM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 13:36:12 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9E78ADB5AD;
        Thu, 15 Jul 2021 13:33:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LXSTgvVRK2BelJtgtEjhCMqUDhLRSg25omJi/i
        4h9A0=; b=GSzXOJkk4KNaIVSfWe64gUrGsCDpYep4vLOZV16O2eePGs164XsU7A
        nVDULxRQdddXw4Y/NP4//22ijA+gVSJYp9NeetES0FyFrCaIsLbI4Jo8tyUPdbNV
        JOPdjlKn64jaQJUbZXQT/ZOYOKphM0tUZtzZqDfg0xXSyH2jCzuvI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 95210DB5AC;
        Thu, 15 Jul 2021 13:33:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 185EEDB5AB;
        Thu, 15 Jul 2021 13:33:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Alex Henrie <alexhenrie24@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 3/5] pull: handle conflicting rebase/merge options via
 last option wins
References: <pull.1047.git.git.1626316849.gitgitgadget@gmail.com>
        <3c07ce978caa832b08c6bef1c48c061e41a6fd0b.1626316849.git.gitgitgadget@gmail.com>
Date:   Thu, 15 Jul 2021 10:33:17 -0700
In-Reply-To: <3c07ce978caa832b08c6bef1c48c061e41a6fd0b.1626316849.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Thu, 15 Jul 2021
        02:40:47 +0000")
Message-ID: <xmqq7dhrtrc2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BE094E20-E592-11EB-BA2C-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/Documentation/config/pull.txt b/Documentation/config/pull.txt
> index 54048306095..e70ed99e408 100644
> --- a/Documentation/config/pull.txt
> +++ b/Documentation/config/pull.txt
> @@ -7,12 +7,13 @@ pull.ff::
>  	line). When set to `only`, only such fast-forward merges are
>  	allowed (equivalent to giving the `--ff-only` option from the
>  	command line). This setting overrides `merge.ff` when pulling.
> +	Incompatible with pull.rebase.

This update may mean well, but I sense that the description needs to
be tightened up a bit more.  Unless you mean to say that I am not
allowed to say "[pull] rebase=no" when I set "[pull] ff", that is.

Or do you mean pull.ff=only is incompatible with any setting of
pull.rebase?

Or do you mean pull.ff=only is incompatible with any setting of
pull.rebase other than false?

Or do you mean any setting of pull.ff is imcompatible with any
setting of pull.rebase other than false?

(You do not have to answer---the above questions just demonstrate
that the description is unnecessarily loose).

>  pull.rebase::
>  	When true, rebase branches on top of the fetched branch, instead
>  	of merging the default branch from the default remote when "git
>  	pull" is run. See "branch.<name>.rebase" for setting this on a
> -	per-branch basis.
> +	per-branch basis.  Incompatible with pull.ff.

Likewise.

I think it technically is OK to say "only ff update is allowed" or
"ff update is allowed when able" while saying pull.rebase=yes.  

 - For those who say ff=only, the actual value of pull.rebase would
   not matter (i.e. the integration immediately finishes by updating
   to what was obtained from the upstream because there is no new
   development on our own on top of theirs to either replay or
   merge).

 - For those who merely allow ff, an update may fast-forward even
   when pull.rebase is set to true (or any non-false value), while
   we'll replay our own development on top of theirs when their
   history is not descendent of ours.

So I do not see need to declare these combinations "incompatible".
But perhaps I am missing some subtle cases?

> diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
> index 5c3fb67c014..03e8694e146 100644
> --- a/Documentation/git-pull.txt
> +++ b/Documentation/git-pull.txt
> @@ -121,6 +121,9 @@ When false, merge the current branch into the upstream branch.
>  +
>  When `interactive`, enable the interactive mode of rebase.
>  +
> +Note that these flags are incompatible with --no-ff and --ff-only; if
> +such incompatible flags are given, the last one will take precedence.
> ++

I am not sure about these, either.  Again, --ff-only (whether it is
combined with --rebase or --rebase=no) would mean that the operation
would fail when we have our own development on top of their history,
and we repoint the tip of our history to theirs when we do not.

We see "--no-ff" is explained to "always create an unnecessary extra
merge", bit I am not sure it is the right mental model to apply when
the user prefers rebasing.  The merge workflow is to treat our
history as the primary and merging theirs in, so when theirs is a
descendant (i.e. we have no new development of our own), some people
may want to mark "we were there before we updated from them" with an
extra merge.  Without --no-ff, the resulting history would be quite
different in the merge workflow if you have or do not have your own
development.  But the rebase workflow is to treat their history as
the primary and replay our own development on top of theirs, and the
shape of the resulting history would be the same whether you have
your own development on top of theirs.  We start from their tip and
then replay our own development on top (which could be an empty
set), and there is nothing "--no-ff" would need to do differently to
keep the resulting history similar to cases where we do have
something of our own.  IOW, "--no-ff" becoming a no-op in a "rebase"
workflow is a natural consequence, and there is no strong reason to
say it is incompatible.

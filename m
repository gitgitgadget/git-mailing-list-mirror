Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 707C5C6FA82
	for <git@archiver.kernel.org>; Wed, 21 Sep 2022 17:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiIURUG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Sep 2022 13:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbiIURT6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2022 13:19:58 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8733135E
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 10:19:55 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 51C3A151C5B;
        Wed, 21 Sep 2022 13:19:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lD8nwR8lsi2DAChqO5RVtuxhK6n4cbKJlDC5bl
        fYH9U=; b=tP50ZjD1UWripOvNNgpmh9Lf2kYuJnYVbDWag3nwtF3UWAZU69zfDI
        rIW1gn4FxyL4zWXnLgBIN35WuA+DZMr97OKEk3/TmmjMsEPqetlCoxKt0y4NM79y
        HT/nu2TJZutQ0qH1AH9u2jof2vDTuIwCLYExugixLL2N6Ahst4IDg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4A21E151C5A;
        Wed, 21 Sep 2022 13:19:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ACD05151C59;
        Wed, 21 Sep 2022 13:19:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, vdye@github.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH] maintenance: make unregister idempotent
References: <pull.1358.git.1663635732095.gitgitgadget@gmail.com>
Date:   Wed, 21 Sep 2022 10:19:52 -0700
In-Reply-To: <pull.1358.git.1663635732095.gitgitgadget@gmail.com> (Derrick
        Stolee via GitGitGadget's message of "Tue, 20 Sep 2022 01:02:11
        +0000")
Message-ID: <xmqqpmfo4pc7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9B7231A8-39D1-11ED-98DE-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <derrickstolee@github.com>
>
> The 'git maintenance unregister' subcommand has a step that removes the
> current repository from the multi-valued maitenance.repo config key.
> This fails if the repository is not listed in that key. This makes
> running 'git maintenance unregister' twice result in a failure in the
> second instance.
>
> Make this task idempotent, since the end result is the same in both
> cases: maintenance will no longer run on this repository.

I am not sure if this is a good idea.  What is the ultimate reason
why we want to allow running it blindly without knowing if it is
necessary?  Is it because there is no easy way to tell if unregister
is needed in the first place?

If this were "unregister X" that takes a parameter that tells what
to unregister, I would be vehemently opposed to the idea, because
I'd expect people make typos and want to be reminded of them when
they happen, but ...

>  	git maintenance unregister &&
>  	git config --global --get-all maintenance.repo >actual &&
> -	test_cmp before actual
> +	test_cmp before actual &&
> +
> +	# Expect unregister to be idempotent.
> +	git maintenance unregister
>  '

... given that the user does not have any control over what to
unregister from the command line (it is decided implicitly by where
the user is), I am halfway OK with it.

A user with two repositories may still be upset after running
"unregister" in the one they did not mean to, and not getting told
about the mistake, though, e.g.

    $ ls *.git
    a.git b.git
    $ cd a.git
    $ git maintenance unregister
    $ cd b.git
    ... this would give you an error message ...
    $ git maintenance unregister
    ... this is silent with the change ...

Surely, the second "cd" should be to ../b.git instead of b.git and
surely the user should have noticed that "cd" gave them an error,
but the unregister that complains would be an extra chance for them
to notice the mistake when they wanted to unregister the maintenance
tasks from all their repositories.

I wonder if something like the "--force" option, i.e.

    $ >cruft
    $ rm curft; echo $?
    rm: cannot remove 'curft': No such file or directory
    1
    $ rm cruft; echo $?
    0
    $ rm cruft; echo $?
    rm: cannot remove 'cruft': No such file or directory
    1
    $ rm -f cruft; echo $?
    0

which gives us both typo detection while supporting blind removal,
is a usable workaround?  I dunno.

But as I said, I am halfway OK with the change.  I just think it is
a bit unfriendly to the users.

Thanks.

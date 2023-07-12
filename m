Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59292EB64DA
	for <git@archiver.kernel.org>; Wed, 12 Jul 2023 15:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233723AbjGLPhc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jul 2023 11:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233664AbjGLPhZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2023 11:37:25 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7047B10C4
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 08:37:19 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D535C32F1F;
        Wed, 12 Jul 2023 11:37:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Ywa6GtZX21utj3bGMW6RrWWZJMVkcrYkHpbEUJ
        +dkng=; b=TCDjAj+CRJqZRCvbU62pcjTr6h2McLCRp1Zcu064LRrm53eZHiOH4H
        a+wuMDf6dmtJyNLBVTauia5uufSSqUpBrDWZls8ochWq8aEICXcTUs9xK0Nw5fyk
        fGDFdHaOkwcFcOtfOVoHTx6EOwyabBLtNwueAPw4QHlRzA9SV1AKs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CCF1832F1E;
        Wed, 12 Jul 2023 11:37:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 56A3C32F1D;
        Wed, 12 Jul 2023 11:37:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Aleksander =?utf-8?Q?Korzy=C5=84ski?= <ak@akorzy.net>,
        git@vger.kernel.org
Subject: Re: Beyond Merge and Rebase: The Upstream Import Approach in Git
References: <CADWu+UnThMq2M+kCMADP9rZ5c6nL+Hz+z0-OqRnuG2oYVzbvWw@mail.gmail.com>
        <71f7d816-b139-03ab-88fc-7552d65e4498@gmx.de>
Date:   Wed, 12 Jul 2023 08:37:14 -0700
In-Reply-To: <71f7d816-b139-03ab-88fc-7552d65e4498@gmx.de> (Johannes
        Schindelin's message of "Wed, 12 Jul 2023 13:34:05 +0200 (CEST)")
Message-ID: <xmqq7cr5uonp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FA39AACE-20C9-11EE-BDC5-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I know this strategy well, having used it initially to maintain Git for
> Windows' patches on top of Git releases. I refer to it as `rebasing merge`
> strategy.

;-) Thanks. This did look familiar.

>    o---o---o---o---o---o---o---o  upstream/main
>         \           \
>          \           o'---o'---o'
>           \                     \
>            o---o---o-------------S---o---o---o  main
>
> A candidate to describe this in a commit range would be
> `upstream/main..main ^S^`, but you cannot pass that to `git rebase -i`,
> which expects a single upstream.

If "git rebase" is taught the `--ancestry-path` option and made to
pass it down to the underlying "which commits do I want to replay
and in what order" logic, it would be sufficient to help the above
topology, I would think.  But offhand I do not know what other
rev-list options will become useful in different scenarios.

> So I switched to a different scheme instead that I dub "merging rebase".
> Instead of finishing the rebase with a merge, I start it with that merge.
> In your example, it would look like this:
>
>    o---o---o---o---o  upstream/main
>         \           \
>          o---o---o---M---o'---o'---o' main
>
> Naturally, `M` needs to be a merge that _must_ be made with `-s ours` in
> order to be "tree-same with upstream/main".

And this will let you say "rebase -i upstream/main" to further
rebase the most recent round of commits.  That does look quite
natural.

> This strategy is not without problems, though, which becomes quite clear
> when you accept PRs that are based on commits prior to the most recent
> merging rebase (or rebasing merge, both strategies suffer from the same
> problem): the _next_ merging rebase will not necessarily find the most
> appropriate base commit, in particular when rebasing with
> `--rebase-merges`, causing unnecessary merge conflicts.

Even without rebasing merge or merging rebase, changes, which could
be useful if they were not based on a stale base, do happen, and it
is more effective to have the original authors of these changes to
update them to your most recent tree, than you dealing with them
yourself, for two reasons.  There are more ICs than you alone, and
they are more familiar with their work.

In other words, isn't the real cause of the above that the workflow
is not taking advantage of the distributed development?  "This PR
seems to solve the right problem, but it is based on an old version
of the code, please update?"

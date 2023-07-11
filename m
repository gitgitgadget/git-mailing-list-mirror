Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC367EB64DC
	for <git@archiver.kernel.org>; Tue, 11 Jul 2023 17:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjGKRCQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jul 2023 13:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjGKRCO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2023 13:02:14 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D762A1
        for <git@vger.kernel.org>; Tue, 11 Jul 2023 10:02:13 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9B1AD1ACC5C;
        Tue, 11 Jul 2023 13:02:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=2c8iw6nAU3rv09UYOdQm82wUh
        ZYMBgmP/wPa2uUPPgk=; b=XxE8h/JgZwT13y4yMGIoipDHOTc9WO5/yYHa4+mbo
        3Y/iYMoRX0pkKBUxVYfbfPBXxO/M6hWCyFjhNjEMNnao/muI/DQHxXopW+kK2VeR
        anM0WMIrOYZ/u82+J6YU84IDJzxmTrSXsquhSzoFm7FJnZrQAU0lZZ3uazlb52FE
        0k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8ECE31ACC5B;
        Tue, 11 Jul 2023 13:02:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A79FB1ACC58;
        Tue, 11 Jul 2023 13:02:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Aleksander =?utf-8?Q?Korzy=C5=84ski?= <ak@akorzy.net>
Cc:     git@vger.kernel.org
Subject: Re: Beyond Merge and Rebase: The Upstream Import Approach in Git
References: <CADWu+UnThMq2M+kCMADP9rZ5c6nL+Hz+z0-OqRnuG2oYVzbvWw@mail.gmail.com>
Date:   Tue, 11 Jul 2023 10:02:10 -0700
Message-ID: <xmqqwmz6z8j1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: AD7CC7D8-200C-11EE-9EA5-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Aleksander Korzy=C5=84ski <ak@akorzy.net> writes:

> So the alternative solution is to rebase your "main" branch on top of
> "upstream/main":
>
>   o---o---o---o---o  upstream/main
>                    \
>                     o'---o'---o'  main
>
> You now have the advantage of having greater visibility into the
> differences between "upstream/main" and "main". However, a rebase
> comes with a different problem: if any user of your fork had the
> "main" branch checked out in their local repository and they run "git
> pull", they are going to get an error stating that the local and
> upstream branches have diverged. They will have to take special steps
> to recover from the rebase of the "main" branch.
>
> So how to solve that problem?

In short, what you wrote is a way to use rebase but help those who
have older versions of your work to bring themselves up to date.
That is a useful thing for downstream contributors to have, and it
is a valuable goal to aim to help these downstream contributors to
coordinate sharing of their work.  Because in general, downstream
contributors tend to outnumber upstream maintainers.  It would help
you to hear perspective from upstream maintainers as well, and here
are a few things that come to my mind.

    o---o---o---o---o  upstream/main
         \           \
          \           a'---b'---c'
           \                     \
            a---b---c-------------S  main

 * It certainly would help folks who received a copy of c from you
   and then want to observe your progress after you rebased c to c',
   but how does this help those who have older versions of your
   work, *and* built their own changes on top?  They would not just
   need to update their remote-tracking branch that has your older
   version of the work to the latest, but also rebase their work on
   top.

    o---o---o---o---o  upstream/main
         \           \
          \           a'---b'---c'---d'---e'
           \                     \
            a---b---c-------------S  main
                     \
                      d---e  your coworker

 * It is a reasonable way to for keeping your work as a fork from
   the upstream up-to-date, but it is unclear what the eventual
   presentation to and adoption by the upstream would look like.  As
   an upstream maintainer, for example, I do not want to merge S
   above to the upstream tree.

 * There is no need to say that it is undesirable to merge from
   upstream to your working topic branch like 'main' repeatedly, as
   everybody knows it will clutter your history, but more
   importantly, the resulting history becomes more useless from the
   upstream's point of view as you have more such reverse merges.
   The upstream wants to see your work and only your work delineated
   on your repository.  If you repeat the "rebase and merge", then
   the next round would create a new history a", b" and c" forked on
   top of an updated upstream/main, merged on top of S, perhaps
   looking like this:

    o---o---o---o---o---------------o  upstream/main
         \           \               \
          \           a'---b'---c'    a"--b"--c"
           \                     \             \
            a---b---c-------------S-------------T  main

   However, once you keep going this way for several rounds, would
   the result really be much better than bushy history with full of
   reverse merges from upstream?  Would it help to add new history
   simplification mechanisms and options to help visualize the
   history, or do we already have necessary support (e.g. if the
   convention for these "merge to cauterize the older versions of
   history with the newly rebased history" S and T merges is to
   record the rebased history as the first-parent, then "git log
   --first-parent upstream/main..main" should be sufficient).  The
   users would benefit to have an easy way, given only T or S, to
   get range-diff among (a,b,c) and (a',b',c') and (a",b",c").

What is interesting is that, because S and T are essentially "ours"
merges of your local history into the history that would result if
you rebased on top of the upstream (i.e. merge S and T would have
the same tree as c' and c"), what is tested and used by the holder
of S and T are the changes represented by the latest rebased
versions of the commits.  So from the upstream point of view,
throwing a pull request for c" (not the original a, b and c) would
be a reasonable way to finalize your work.  That way, what you are
offering to the upstream is not an ancient original commits (i.e. a,
b, and c) that you haven't been using at all once you created S and
T.

Thanks.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1605C433EF
	for <git@archiver.kernel.org>; Fri, 29 Apr 2022 20:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380482AbiD2UWe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Apr 2022 16:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380689AbiD2UWa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Apr 2022 16:22:30 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF81D64C0
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 13:19:10 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2EDA411C497;
        Fri, 29 Apr 2022 16:19:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pDyMD9ntjWdiWABxp1Ulg0UqyKzBpBK78Rj0Bk
        hvee8=; b=iQBMTj1ciILZvUA/b7Rh7y0hapYn76tgccMXKeZvtVj5kbiEWjxh0o
        LFC82ZVXNK3nIR53+xyHcrJK5J9SnllrGYeSTqYqYwOgefqz+gBPU0MIMesnAjlI
        m4VwR0O4CQw5P9G0g60hJhGSe/2I70Tvj44lM+Vc7On3OiN7wGpZQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 26D2211C496;
        Fri, 29 Apr 2022 16:19:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7D35811C495;
        Fri, 29 Apr 2022 16:19:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Austin Morton <austin.morton@aquatic.com>
Cc:     git@vger.kernel.org
Subject: Re: Able to checkout same branch in multiple worktrees when using
 symbolic-refs
References: <CAAir=1MbwGtONW7yWRWoXKzAiwqwhOAqdhfWYMYLxt1vANuUOA@mail.gmail.com>
Date:   Fri, 29 Apr 2022 13:19:08 -0700
In-Reply-To: <CAAir=1MbwGtONW7yWRWoXKzAiwqwhOAqdhfWYMYLxt1vANuUOA@mail.gmail.com>
        (Austin Morton's message of "Fri, 29 Apr 2022 19:05:56 +0000")
Message-ID: <xmqqsfpvabib.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A0820532-C7F9-11EC-B87E-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Austin Morton <austin.morton@aquatic.com> writes:

> When using a symbolic-ref I am able to inadvertently checkout the same
> branch in multiple worktrees when using the symbolic-ref name, despite
> being prevented from doing so if I use the target branch name.

Don't do that if it hurts ;-)

If you checked out 'main' in the secondary worktree and made a
commit there, the symbolic-ref makes 'master' to be updated,
confusing the primary worktree whose index and the working tree
files record work relative to the old commit before the secondary
worktree updated it via the symbolic-ref, which is exactly the same
situation that the "do not check out the same branch in two
different worktrees" protection tries to save the user from, but I
do not think we currently do so.

Because this "do not check a branch out twice and let it be futzed
with from the two places" is primarily a mechanism to help
inexperienced users from getting confused (and there is an escape
hatch mechanism to allow it to those who know what they are doing),
and use of symbolic-ref to make 'main' and 'master' synonyms with
each other is not something inexperienced users who have no clue on
what they are doing would be doing anyway, it may not be a huge
deal.

I also suspect there is no way, other than scanning _all_ the local
branches, to see if some other branch aliases the branch we are
about to check out.  It may potentially be somewhat expensive.

But it would be nice if it can get fixed in inexpensively.

Thanks for a report.


> Below is a minimal reproducer:
>
> $ git --version
> git version 2.36.0
> $ git init .
> $ git status
> $ git commit --allow-empty -m "Initial commit"
> $ git symbolic-ref refs/heads/main refs/heads/master
> $ git worktree add ../worktree2
> $ git worktree list
> /home/amorton/test/worktree1 cd8312d [master]
> /home/amorton/test/worktree2 cd8312d [worktree2]
> $ cd ../worktree2
> $ git checkout master
> fatal: 'master' is already checked out at '/home/amorton/test/worktree1'
> $ git checkout main
> Switched to branch 'main'
> $ git worktree list
> /home/amorton/test/worktree1 cd8312d [master]
> /home/amorton/test/worktree2 cd8312d [master]

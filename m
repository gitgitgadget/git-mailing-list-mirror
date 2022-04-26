Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55240C433F5
	for <git@archiver.kernel.org>; Tue, 26 Apr 2022 15:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352328AbiDZPXM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Apr 2022 11:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352334AbiDZPXC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Apr 2022 11:23:02 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51AD51749E8
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 08:16:38 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DD8E618324B;
        Tue, 26 Apr 2022 11:16:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FLw66dAEF2TduJqywNvhRwlYVjg9PtKUH445nz
        PXnkM=; b=dmbBZsZkQBnc6GhZIHc12LAABLf1oPpflRtk5Sa7u36TWjtQMM/Szi
        TDRqzgG9pKJ/joZmTghjuEh7qc5ZZV690IemFngERNpQGeeFmHnNIJ3fT+vu3Ymr
        ek52wdXYWfe/9AqEG5pQBlvEKchhZ/z9LiI6+/kDNNzoKxM7pOr9A=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D4004183247;
        Tue, 26 Apr 2022 11:16:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6C805183225;
        Tue, 26 Apr 2022 11:16:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     git@vger.kernel.org,
        Matthias =?utf-8?Q?A=C3=9Fhauer?= <mha1993@live.de>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] 2.36 gitk/diff-tree --stdin regression fix
References: <xmqqh76j3i3r.fsf@gitster.g> <xmqqbkwpvyyc.fsf@gitster.g>
        <83a76d46-5069-d6c7-b8b3-f3a063637abb@gmail.com>
        <6ac7e164-c4ba-0ffc-a8a4-4cede1d4e7ae@gmail.com>
Date:   Tue, 26 Apr 2022 08:16:29 -0700
In-Reply-To: <6ac7e164-c4ba-0ffc-a8a4-4cede1d4e7ae@gmail.com> (Phillip Wood's
        message of "Tue, 26 Apr 2022 14:45:58 +0100")
Message-ID: <xmqqsfpzswmq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DA3705D0-C573-11EC-8204-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> On further inspection we have tests for "log -p -I<regex>" in t4013
> and e900d494dc ("diff: add an API for deferred freeing", 2021-02-11) 
> modified builtin/log.c to set the new no_free flag so "log" should be
> OK. However "diff-tree --stdin -p -I<regex>" is not as 
> builtin/diff-tree.c is unchanged by e900d494dc so the no_free flag is
> not set which I think is the cause of the problems reported here.

... reported here, meaning some reproduction exists?  It would be
good to have it in the test, next to the ones I added yesterday, I
think.

In any case, I think that is a much older breakage that can be left
after this "oops, where is my pathspec?" regression is dealt with.

> I think the close_file changes in e900d494dc should be safe as far as
> "diff-tree" is concerned as it never sets that flag.
>
> In retrospect the no_free flag is pretty ugly and fragile.

Yes.

> If we
> really cannot do it another way at least requiring callers to set a
> flag when they want things freeing would avoid nasty surprises like
> this at the expense of leaking when the caller forgets to set
> it. Perhaps once 2.36.1 is out we should step back and think about
> exactly what we're trying to achieve by removing these bounded leaks
> rather than annotating them with UNLEAK().

Doubly yes.

There is small per-task resources allocated that is not proportional
to the size of the task, i.e. "git log -p" may need more resource at
"peak" in a project with 100k files than in a project with 1k files,
and we do not want to leak these resources we use to compare two sets
of 100k (or 1k) files between "commit^" and "commit".  It may allocate
and deallocate more times in a project with 100k commits than in a
project with 1k commits, and we do not want to leak 100 times more
resources in the former project than the latter.  Aiming to reclaim
these resources needed proportinally to the size of the task is
absolutely a good thing to do.

But the final clean-up for the very top-level allocations that is
not proportional to the size of the task, like pathspec, regex, and
other result from parsing command line options and configuration
variables?  Using UNLEAK() to squelch the leak checker and letting
process termination to reclaim them is absolutely a no-cost solution
that is much better.

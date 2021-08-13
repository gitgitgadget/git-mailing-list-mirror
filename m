Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 334B6C4338F
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 23:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 153F060FC4
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 23:01:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235505AbhHMXCW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 19:02:22 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57015 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235478AbhHMXCV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 19:02:21 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 62F441571CA;
        Fri, 13 Aug 2021 19:01:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NlGR3OAipr+qyKTF79OMjOhniXgDRvnwOJt0dB
        d6Oj0=; b=i6W96kpsu5PxIC6U//HuYNM6g+9FKV/4ZkQ4ypwiWgYqR5PNALHcpa
        0yaGi6awniZdvlelyDA18Gg2jG94+2rQ3xu0pEbZ4ivoF56/jNLnfdS56/jAzqHN
        2HSL7GJTvozhDH4084esXQqp+YrrAyIDYeNNjgayx3aW5drLzrjdY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5CC611571C9;
        Fri, 13 Aug 2021 19:01:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 914681571C6;
        Fri, 13 Aug 2021 19:01:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 3/3] rebase --continue: remove .git/MERGE_MSG
References: <pull.1013.git.1628587917.gitgitgadget@gmail.com>
        <pull.1013.v2.git.1628775729.gitgitgadget@gmail.com>
        <028c9dfc460b6c00bf481017a07a2a6d37780a76.1628775729.git.gitgitgadget@gmail.com>
Date:   Fri, 13 Aug 2021 16:01:48 -0700
In-Reply-To: <028c9dfc460b6c00bf481017a07a2a6d37780a76.1628775729.git.gitgitgadget@gmail.com>
        (Phillip Wood via GitGitGadget's message of "Thu, 12 Aug 2021 13:42:09
        +0000")
Message-ID: <xmqqa6lluexv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 722C0E3E-FC8A-11EB-B376-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> If the user skips the final commit by removing all the changes from
> the index and worktree with 'git restore' (or read-tree) and then runs
> 'git rebase --continue' .git/MERGE_MSG is left behind. This will seed
> the commit message the next time the user commits which is not what we
> want to happen.

I just remembered that "git rebase --skip" option exists.  Would it
have the same issue if used at the last step?


[Footnote]

I am not saying that it is an error to use "git restore HEAD . &&
git rebase --continue" when you'd usually use "git rebase --skip".

Nuking the difference the working tree files and the index has
relative to HEAD and telling the machinery to continue gives the
signal that the "conflict resolution" happened to have resulted in
an empty change, which should yield the same resulting history as
"git rebase --skip" would, because the resulting empty change should
be dropped (unless --empty=keep is in effect, that is).


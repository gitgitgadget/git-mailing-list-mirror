Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3047FC32771
	for <git@archiver.kernel.org>; Mon, 26 Sep 2022 17:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbiIZR71 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 13:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbiIZR7F (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 13:59:05 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC257C301
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 10:38:50 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3EB2414302A;
        Mon, 26 Sep 2022 13:38:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vDk148RdHgx6DNYeC46R00NzRmFPb8bcFbq2hN
        m8LNY=; b=g5Xl2dGzOlgXgOwBb53TYj+Knq1Qt7Jagno4u/agCN6iXu1ovYVmbD
        fPqC3wxb9/sqOQAdZcJ+rbz6W4AvedRlBDTML5mnM3qFP1JWW2JBDkRW9d3UghZj
        c7J22b/sEZMy8yBG0FJhV7TGlPD7VSSNOo40k6aTCfJu8XSEPoxZU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 35B3F143028;
        Mon, 26 Sep 2022 13:38:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 90AB7143024;
        Mon, 26 Sep 2022 13:38:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        ZheNing Hu <adlternative@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] sparse-checkout.txt: new document with sparse-checkout
 directions
References: <pull.1367.git.1664064588846.gitgitgadget@gmail.com>
Date:   Mon, 26 Sep 2022 10:38:48 -0700
In-Reply-To: <pull.1367.git.1664064588846.gitgitgadget@gmail.com> (Elijah
        Newren via GitGitGadget's message of "Sun, 25 Sep 2022 00:09:48
        +0000")
Message-ID: <xmqqwn9qox1z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 148D3922-3DC2-11ED-9B5C-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +    In the case of am and apply, those commands only operate on the
> +    working tree, so they are kind of in the same boat as stash.

"apply" does not touch the HEAD but it can touch the index; when it
operates with the "--cached" or the "--index" option, it should not
be considered as a working-tree-only command.

"am" is about recording what is in the patch as a commit.

> +    Perhaps `git am` could run `git sparse-checkout reapply`
> +    automatically afterward and move into a category more similar to
> +    merge/rebase/cherry-pick, but it'd still be weird because it'd
> +    vivify files besides just conflicted ones when there are conflicts.

I do not particularly think it is so bad.

How would we handle the case where the user modifies paths outside
the sparse specification and makes a commit out of the result,
without using "am"?  We should be consistent with that use case, i.e.

    $ edit path/outside/sparse/specification
    $ git add path/outside/sparse/specification
    $ git commit

Do we require some "Yes, I am aware that I need to widen my sparse
specification to do this, because I am now stepping out of it, and I
understand that my sparse specification becomes wider after doing
this operation" confirmation with "add" or "commit"?  If not, then I
think "am" should silently widen just like these commands.  If they
do, then "am" should also require such an option.  Perhaps call it
"--widen-sparse" or whatever.

By the way, I like the term "sparse specification" very much, as
we should worry about non-cone mode as well.  Please use it
consistently in this document after getting a concensus that it
is a good phrase to use from others---I saw some other words
used after "sparse" elsewhere in this patch.

> +    In the case of ls-files, `git ls-files -t` is often used to see what
> +    is sparse and not, in which case restricting would not make sense.

I suspect that leaving it tree-wide would allow scripters come up
with Porcelains that restricts to the sparse specification more
easily.

Thanks.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34142C07E9D
	for <git@archiver.kernel.org>; Mon, 26 Sep 2022 22:36:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiIZWgO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 18:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiIZWgN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 18:36:13 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EFA498C96
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 15:36:12 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8E04F15D681;
        Mon, 26 Sep 2022 18:36:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=S6SxVgNVdAAEUN2D0ci7csf1/hDTy272GKpVrX
        tv3iA=; b=WRlaZupXl+UJpcotfdG9UZJPzpeaRzHx+cjdLZrCjgtQhHl+ThxqV5
        26m5xcgY8Nzgqb0QlMCSL3vzCPg3KgZwCuIV9SF5kcRYQEMfUMD1ZfV6w3bJPEDt
        DYeo2zUiGXbXuD/zYCZ8C87pIn9zLdkKe0dcGr/k+ghEGJ600ge4k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 856FC15D680;
        Mon, 26 Sep 2022 18:36:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BF06C15D67F;
        Mon, 26 Sep 2022 18:36:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Victoria Dye <vdye@github.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        ZheNing Hu <adlternative@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] sparse-checkout.txt: new document with sparse-checkout
 directions
References: <pull.1367.git.1664064588846.gitgitgadget@gmail.com>
        <a89413b5-464b-2d54-5b8c-4502392afde8@github.com>
Date:   Mon, 26 Sep 2022 15:36:09 -0700
In-Reply-To: <a89413b5-464b-2d54-5b8c-4502392afde8@github.com> (Victoria Dye's
        message of "Mon, 26 Sep 2022 13:08:59 -0700")
Message-ID: <xmqqv8p9ahly.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9EBA8B94-3DEB-11ED-986C-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Victoria Dye <vdye@github.com> writes:

>> +* Commands behaving the same regardless of high-level use-case
>> +
>> +  * commands that only look at files within the sparsity specification
>> +
>> +      * status
>> +      * diff (without --cached or REVISION arguments)
>> +      * grep (without --cached or REVISION arguments)
>
> 'status' and 'diff' currently show information about untracked files outside
> the working tree (since, not being in the index, they don't have a
> 'SKIP_WORKTREE' to use). Should that change with the proposed '--restrict'
> option?

Most likely not.  When sparsity specification is in effect, as you
said elsewhere in your response, no files, whether tracked or
untrcked, should exist that are outside your area of interest.
Their presence should be reported as anomalies by "git status".

Unless the command is being run with the "-uno" option, that is.

> - 'switch', 'checkout' (switch-like), and 'read-tree -m' block the operation
>   & advise on how to clean up the modified files to re-align with the
>   sparsity patterns.
> - 'reset --hard' silently drops the modified file and resets the
>   'SKIP_WORKTREE' bit on the corresponding index entry.
>
> With the exception of 'reset --hard' (aggressively and unconditionally
> cleaning the worktree & index is an important aspect of the command, IMO),
> I'd personally like to see commands in this category align with the behavior
> of 'switch' where they don't already. Regardless of what we decide, though,
> I think it's probably worth documenting the "modified outside of sparsity
> patterns" case.

True.  I agree on both counts.

> Also, 'read-tree' (no args) doesn't apply the 'SKIP_WORKTREE' bit to *any*
> of the entries it reads into the index. Having all of your files suddenly
> appear "deleted" probably isn't desired behavior, so it might be a good
> candidate for the "Known bugs" section. 

I would imagine that it actually is OK to say that it is the
responsibility of whoever invokes read-tree the plumbing command
to reapply the skip-worktree bits and/or collapse the index entries
outside the area of interest into trees afterwards.

>> +* Commands that differ for behavior A vs. behavior B:
>> +
>> +  * commands that make modifications:
>
> nit: "make modifications" -> "make modifications to the index"? 

That clarification actually raises an interesting question.  Do we
want three level distinction, i.e. different behaviour between
commands that touch and do not touch the working tree, between those
that touch and do not touch the index, and between those that touch
and do not touch the commit?

As the index is merely a way to express what the user did to
eventually create the next tree to be recorded in the commit, my gut
feeling is that it may be easier to understand if we treated the
working tree and the index at the same level, actually.  I.e. if
grepping in the working tree of a sparse checkout does not find a
match outside the cones of interest, it may make sense to do the
same at least by default in "grep --cached" mode.

If I understand Stolee's write-up on the use case of those in the
camp B, they are more aware of the larger whole and expect to see
hits outside the area they have checkout when running "grep HEAD".
But in their use case, they do not touch (only look) the area
outside their cone of interest, so if we limit the operation to
their cone of interest by default for working tree, the same default
probably should apply equally for an operation that inspect the
index.

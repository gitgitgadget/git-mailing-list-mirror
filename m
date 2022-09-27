Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B16C07E9D
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 16:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbiI0QJK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Sep 2022 12:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233204AbiI0QIo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2022 12:08:44 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B475A61D4
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 09:07:36 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C44CE1CD04B;
        Tue, 27 Sep 2022 12:07:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VPBRHkeyIsz6qPTubTCCvsgvuOfQrFUPgGb0sJ
        zq8bQ=; b=ZBAwvfes+4Vx58gmEroPngmi796Jyr5tfi6AuLBHNmCpQL7hm+CNiN
        VL4Liu/zmO5Xlglvh2XB6mmlpC6om+fgGUbm48XeRNwjJKQIkAqqUSSQIi3nbgrZ
        w7J5qeUSwL4FC3VK8ak6rh9V8XJvt+tqXm9GM6uLH47P+D+GnnH3s=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BC5571CD04A;
        Tue, 27 Sep 2022 12:07:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2DC1C1CD049;
        Tue, 27 Sep 2022 12:07:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Victoria Dye <vdye@github.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH] sparse-checkout.txt: new document with sparse-checkout
 directions
References: <pull.1367.git.1664064588846.gitgitgadget@gmail.com>
        <a89413b5-464b-2d54-5b8c-4502392afde8@github.com>
        <xmqqv8p9ahly.fsf@gitster.g>
        <CABPp-BESkb=04vVnqTvZyeCa+7cymX7rosUW3rhtA02khMJKHA@mail.gmail.com>
Date:   Tue, 27 Sep 2022 09:07:30 -0700
In-Reply-To: <CABPp-BESkb=04vVnqTvZyeCa+7cymX7rosUW3rhtA02khMJKHA@mail.gmail.com>
        (Elijah Newren's message of "Tue, 27 Sep 2022 00:30:34 -0700")
Message-ID: <xmqqzgek7qd9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7D945F38-3E7E-11ED-820E-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Oh, wow, that's something completely outside what I had considered.  I
> had viewed sparse-checkouts as splitting "tracked files" into two
> subsets.  As such, `--[no-]restrict` could only affect selecting
> whether the smaller or larger set of tracked files was of interest.
> From that viewpoint, untracked files seemed orthogonal, and thus there
> couldn't be such a thing as an "anamalous untracked file".
>
> But this idea is very interesting.  Hmm...

We need to design the behaviour of "git add" sensibly.  Even we say
"untracked files are just one class and there are two classes of
tracked ones, those path of current interest and those that are
uninteresting", we would need to say "'git add F' behaves this way
if F would become 'tracked path of current interest' when added, but
the command behaves this other way if F becomes 'tracked path that
is not interesting right now'".  It may be cleaner to separate the
untracked ones along the same line as the tracked ones.

Which in turn would mean that the skip-worktree bit cannot be the
source of truth.  Sparsity specification (either pattern matching or
being in listed directories) authoritatively decides if a path is of
the current interest or not.  This is simply because untracked ones
cannot have that bit ;-)  We can treat the skip-worktree bit as mere
implementation detail, a measure for optimization.

> One thing that makes me a little leery about this path is whether we
> can consistently apply the scoped-to-sparse-specification rule for
> index operations.  For example:
>
>   * You previously agreed that `git format-patch` should ignore sparse
> specification and operate full tree.

It is not "are we focusing on subset when we talk about index" to
begin with---format-patch is about a commit (or a series of commit),
and you should view it as a member of the "log" family.  Or the
first half of "rebase/cherry-pick" (the other half being "am"),
which should be full-tree, I would think.

>   * `git apply --cached $PATCH` only updates the index, and you
> suggested in an alternate email that apply should operate full-tree
> (at least with --index or without --cached, but I assume by extension
> it probably also applies with --cached).

I have not thought about "apply --cached".  Just like merge-tree can
merge without a working tree, "apply --cached" should be able to
serve as a foundation to apply a series out of lore archive and
create a topic branch without a working tree.

>   * What if someone runs `git diff --cached` just before that commit?
> Do we scope the diff to only those paths within the sparse
> specification?
>   * What if someone runs `git status` just before that commit?  Do we
> only show staged changes within the sparse specification?
>
> It feels like "git grep --cached" is perhaps the next thing along this
> sequence, and I don't see a clear line where to draw that we should
> limit things to the sparse specification for the index while treating
> the other operations as full tree; it seems like something feels
> broken or inconsistent in this sequence of commands if we attempt to
> do so.

OK, it seems that "--cached" has many cases that it wants to operate
on full tree.  I am in general more in favor of making things work
on full tree, simply because I feel it would have less chance of
going wrong, so defaulting to --no-restrict would be fine ;-)


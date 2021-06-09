Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DD9C47095
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 06:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2519061183
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 06:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235954AbhFIGev (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 02:34:51 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56543 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbhFIGeu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 02:34:50 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B24F4146DFA;
        Wed,  9 Jun 2021 02:32:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WHaOwsSTQO6bm3DeUSt1VGA93ry+nGeok0e2Ei
        ui5WU=; b=NeS3abwnPDN0l55zqRaD1699mHqopEfgqnncaKRQoiWWdIuemMboHU
        x/H+Fv6gnPDx8LyCkl6a7cWa8onA++clbFUwhicQc15ERZGvODFsW9T9odmjp9ML
        zQ2LoAeDHSnG4ShGkHMgBvY78UmupSwPVlDBH6YmBjV1nJi7yd/h4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AB8E0146DF9;
        Wed,  9 Jun 2021 02:32:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EB45E146DF8;
        Wed,  9 Jun 2021 02:32:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v5 10/14] diff-lib: handle index diffs with sparse dirs
References: <pull.932.v4.git.1621598382.gitgitgadget@gmail.com>
        <pull.932.v5.git.1623069252.gitgitgadget@gmail.com>
        <b9b97e0112939d1787ff1d2a13c48e5b406408db.1623069252.git.gitgitgadget@gmail.com>
        <CABPp-BEp0NzUqW_pWpTGoUvrB1JMp9fVHr28Sp8RZqV6w0-hEw@mail.gmail.com>
Date:   Wed, 09 Jun 2021 15:32:51 +0900
In-Reply-To: <CABPp-BEp0NzUqW_pWpTGoUvrB1JMp9fVHr28Sp8RZqV6w0-hEw@mail.gmail.com>
        (Elijah Newren's message of "Tue, 8 Jun 2021 22:47:27 -0700")
Message-ID: <xmqqfsxrk0oc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 84BDDA5E-C8EC-11EB-BD57-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Mon, Jun 7, 2021 at 5:34 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> While comparing an index to a tree, we may see a sparse directory entry.
>> In this case, we should compare that portion of the tree to the tree
>> represented by that entry. This could include a new tree which needs to
>> be expanded to a full list of added files. It could also include an
>> existing tree, in which case all of the changes inside are important to
>> describe, including the modifications, additions, and deletions. Note
>> that the case where the tree has a path and the index does not remains
>> identical to before: the lack of a cache entry is the same with a sparse
>> index.
>>
>> In the case where a tree is modified, we need to expand the tree
>> recursively, and start comparing each contained entry as either an
>> addition, deletion, or modification. This causes an interesting
>> recursion that did not exist before.
>
> So, I haven't read through this in detail yet...but there's a big
> question I'm curious about:
>
> Git already has code for comparing an index to a tree, a tree to a
> tree, or a tree to the working directory, right?  So, when comparing a
> sparse-index to a tree...can't we re-use the compare a tree to a tree
> code when we hit a sparse directory?

Offhand I do not think of a reason why that cannot work.

The tree-diff machinery takes two trees, walks them in parallel and
repeatedly calls either diff_addremove() or diff_change(), which
appends diff_filepair() to the diff_queue[] structure.  If you see
an unexpanded tree on the index side, you should be able to pass
that tree with the subtree you are comparing against to the tree-diff
machinery to come up with a series of filepairs, and then tweak the
pathnames of these filepairs (as such a two-tree comparison would be
comparing two trees representing a single subdirectory of two different
vintages) before adding them to the diff_queue[] you are collecting
the index-vs-tree diff, for example.

But if a part of the index is represented as a tree because it is
outside the cone of interest, should we even be showing the
difference in that part of the tree?  If t/ directory is outside the
cone of interest, should "git diff HEAD~100 HEAD t/" show anything
to begin with (the same question for "git diff --cached HEAD t/")?

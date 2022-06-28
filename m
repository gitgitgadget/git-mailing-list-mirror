Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D37EBCCA479
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 20:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbiF1Uss (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 16:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbiF1Usp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 16:48:45 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230B52CE02
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 13:48:43 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 02551198706;
        Tue, 28 Jun 2022 16:48:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=X1J1LTJj30yW2pQJCsD2WZSypqzye78ImF4y5g
        kWWos=; b=bi3jzwd3KKppCp17KBF90g0PPwNDxArFNg7G+zYzagMVe5VD+1lBcM
        d1pwYHNnEZ/rW83IMBNyuNQZVwbgqcX+cQI2uvMgqhnS9MnJyZV/2SEBf1Rffv5W
        0Q+ntdYjxPecFFrWNB//6niU1XriNRTY2BqrWBspx90Yk4icc1KX8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EDB83198705;
        Tue, 28 Jun 2022 16:48:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8FCB4198704;
        Tue, 28 Jun 2022 16:48:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3 2/8] branch: consider refs under 'update-refs'
References: <pull.1247.v2.git.1654634569.gitgitgadget@gmail.com>
        <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
        <2bc647b6fcd6032a1e97e67739ced31117bfbfce.1656422759.git.gitgitgadget@gmail.com>
Date:   Tue, 28 Jun 2022 13:48:38 -0700
In-Reply-To: <2bc647b6fcd6032a1e97e67739ced31117bfbfce.1656422759.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Tue, 28 Jun 2022
        13:25:53 +0000")
Message-ID: <xmqqpmisikex.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B0573FA0-F723-11EC-8EC5-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <derrickstolee@github.com>
>
> The branch_checked_out() helper helps commands like 'git branch' and
> 'git fetch' from overwriting refs that are currently checked out in
> other worktrees.
>
> A future update to 'git rebase' will introduce a new '--update-refs'
> option which will update the local refs that point to commits that are
> being rebased. To avoid collisions as the rebase completes, we want to
> make the future data store for these refs to be considered by
> branch_checked_out().
>
> The data store is a plaintext file inside the 'rebase-merge' directory
> for that worktree. The file alternates refnames and OIDs. The OIDs will
> be used to store the to-be-written values as the rebase progresses, but
> can be ignored at the moment.
>
> Create a new sequencer_get_update_refs_state() method that parses this
> file and populates a struct string_list with the ref-OID pairs. We can
> then use this list to add to the current_checked_out_branches strmap
> used by branch_checked_out().
>
> To properly navigate to the rebase directory for a given worktree,
> extract the static strbuf_worktree_gitdir() method to a public API
> method.
>
> We can test that this works without having Git write this file by
> artificially creating one in our test script.

Hmph, I am not thrilled to see an ad-hoc text file for things like
this.  Do the objects that appear in this file otherwise already
anchored by existing refs, or can some of them be "floating" without
any refs pointing at them, i.e. making the "connected" and "fsck"
machinery also being aware of them to protect them from collected as
garbage and reported as dangling/unreachable?


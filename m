Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E582C433F5
	for <git@archiver.kernel.org>; Mon, 23 May 2022 22:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbiEWWsw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 18:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiEWWsv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 18:48:51 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19755A14C
        for <git@vger.kernel.org>; Mon, 23 May 2022 15:48:49 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C6E5912318E;
        Mon, 23 May 2022 18:48:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=kMndW/RHmT4kTfZK9aWiGJ4i/t6yhGGrlxiCHfMAFhc=; b=Kt3k
        BtaysKQpxcDOb88wNRsYlfvupD05FQweWpJyO8kDGvl0KemEI1wQoV8XceZ3giuY
        3FAAdBzPTQwyJ5EAOQFSUSNdvF0XUus4zC4ipPQpJXI1yoruyhn+CymFT5k3eX1E
        8SzoFuJ9VCmQbs3MaVvX4/Tw9mjLTBywwvB0GeY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BD5B812318D;
        Mon, 23 May 2022 18:48:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 251BE12318C;
        Mon, 23 May 2022 18:48:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, vdye@github.com, shaoxuan.yuan02@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 08/10] sparse-index: complete partial expansion
References: <pull.1208.git.1652724693.gitgitgadget@gmail.com>
        <pull.1208.v2.git.1652982758.gitgitgadget@gmail.com>
        <ed640e3645ba4f60f06bd335b9ac7bf350dd81f9.1652982759.git.gitgitgadget@gmail.com>
        <xmqqsfp3coqy.fsf@gitster.g>
        <5909f466-c323-0874-b175-51fe5e93dc12@github.com>
Date:   Mon, 23 May 2022 15:48:47 -0700
Message-ID: <xmqqv8tvlvao.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 821B6D46-DAEA-11EC-9638-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

>> I suspect that is a situation that is not so uncommon.  Working
>> inside a narrow cone of a wide tree, performing a merge would
>> hopefully allow many subtrees that are outside of the cones of our
>> interest merged without getting expanded at all (e.g. only the other
>> side touched these subtrees we are not working on, so their version
>> will become the merge result), while changes to some paths in the
>> cone of our interest may result in true conflicts represented as
>> cache entries at higher stages, needing conflict resolution
>> concluded with "git add".  Having to expand these subtrees that we
>> managed to merge while still collapsed, only because we have
>> conflicts in some other parts of the tree, feels somewhat sad.
>
> You are correct that conflicts outside of the sparse-checkout cone will
> cause index expansion. That happens during the 'git merge' command, but
> the index will continue to fail to collapse as long as those conflicts
> still exist in the index.
>
> When there are conflicts like this during the merge, then the index
> expansion is not as large of a portion of the command as normal, because
> the conflict resolution also takes some time to compute. The commands
> afterwards do take longer purely because of the expanded index.

I was imagining a situation more like "tech-writers only have
Documentation/ inside the cone of interest, attempt a pull from
somebody else, have conflicts inside Documentation/, but everything
else could be resolved cleanly without expanding the index".  If the
puller's tree is based on the pristine upstream release tag, and the
pullee's tree is based on a slightly newer version of upstream
snapshot, everything that happened outside Documentation/ in their
trees would fast-forward, so such a merge wouldn't have to expand
directories like "builtin/" or "contrib/" in the index and instead
can merge at the tree level, right?

On the other hand, ...

> However, this state is also not as common as you might think. If a user
> has a sparse-checkout cone specified, then they are unlikely to change
> files outside of the sparse-checkout cone. They would not be the reason
> that those files have a conflict. The conflicts would exist only if they
> are merging branches that had conflicts outside of the cone. Typically,
> any merge of external changes like this are of the form of "git pull" or
> "git rebase", in which case the conflicts are still "local" to the
> developer's changes.

... you seem to be talking about the opposite case (e.g. in the
above paragraph), where a conflict happens outside the cone of
interest of the person who is making a merge.  So, I am a bit
puzzled.

> You are right that there is additional work that could be done here,
> specifically allowing the cache tree to partially succeed and use the
> successfully generated trees to create sparse directory entries where
> possible. This was not viable before because we lacked the "partially
> expanded" index state. This series establishes the necessary vocabulary to
> do such an improvement later.
>> By the way, why are we passing the "--missing-ok" option to "git
>> write-tree" here?
>> 
>>> +	cache_tree_update(istate, WRITE_TREE_MISSING_OK);
>> 
>> The same question here.  We didn't say "missing trees are OK".  What
>> made it OK in this change?
>  
> Both of these additions of WRITE_TREE_MISSING_OK are not needed. I
> think I added them in an earlier version, thinking they were needed
> due to something in the Scalar functional tests. I confirmed just now
> that they are not needed for that. I will remove them.
>
> Thanks,
> -Stolee
